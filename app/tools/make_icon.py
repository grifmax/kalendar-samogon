"""Сборка иконки и сплэша «Календарь самогонщика» из исходной иллюстрации.

Запуск:  python tools/make_icon.py

Что делает:
  * читает design/icon-source.png (иллюстрация с прозрачным фоном);
  * собирает мастер-иконку 1024×1024 — тёплый радиальный фон, мягкая подсветка
    за иллюстрацией, тень, иллюстрация на 70 % ширины;
  * раскладывает Android mipmap (обычная и круглая иконка, слои adaptive icon);
  * раскладывает iOS AppIcon.appiconset (без альфы — требование App Store);
  * готовит картинки сплэша: логотип для нативной заставки и для экрана Flutter.

Иконки и сплэш — производные файлы: править их руками бессмысленно, правьте
иллюстрацию и перезапускайте скрипт.
"""

from __future__ import annotations

import json
import pathlib

from PIL import Image, ImageDraw, ImageFilter

ROOT = pathlib.Path(__file__).resolve().parent.parent
SOURCE = ROOT / "design" / "icon-source.png"
ANDROID_RES = ROOT / "android" / "app" / "src" / "main" / "res"
IOS_ICONS = ROOT / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
FLUTTER_IMAGES = ROOT / "assets" / "images"

# Фон иконки — тёплый кремовый: иллюстрация плоская, с чёрными контурами,
# и на тёмном фоне контуры сливались с подложкой. Центр светлее, край темнее.
BG_CENTER = (251, 243, 230)
BG_EDGE = (228, 213, 190)
GLOW_COLOR = (255, 250, 240)

# Доля ширины, которую занимает иллюстрация в обычной иконке.
LEGACY_SCALE = 0.70
# В adaptive icon слой 108dp, видимая зона — 72dp, поэтому та же оптическая
# крупность получается при 0.70 * 72 / 108.
ADAPTIVE_SCALE = LEGACY_SCALE * 72 / 108


def load_content() -> Image.Image:
    im = Image.open(SOURCE).convert("RGBA")
    r, g, b, a = im.split()
    # В исходнике почти непрозрачные пиксели имеют альфу 254 — поднимаем до 255,
    # иначе на тёмном фоне читается кайма.
    a = a.point(lambda v: 255 if v >= 250 else v)
    im = Image.merge("RGBA", (r, g, b, a))
    bbox = im.getchannel("A").point(lambda v: 255 if v > 8 else 0).getbbox()
    return im.crop(bbox)


def radial_background(size: int) -> Image.Image:
    img = Image.new("RGBA", (size, size), BG_EDGE + (255,))
    draw = ImageDraw.Draw(img)
    steps = 96
    for i in range(steps, 0, -1):
        t = i / steps  # 1.0 — самый большой круг (край), 0 — центр
        radius = int(size * 0.82 * t)
        # Край тёмный, центр светлый: к центру подмешиваем BG_CENTER.
        mix = 1 - t
        color = tuple(
            int(edge + (center - edge) * mix)
            for center, edge in zip(BG_CENTER, BG_EDGE)
        )
        draw.ellipse(
            [size // 2 - radius, size // 2 - radius,
             size // 2 + radius, size // 2 + radius],
            fill=color + (255,),
        )
    return img


def glow_layer(size: int, box: tuple[int, int, int, int]) -> Image.Image:
    x, y, w, h = box
    mask = Image.new("L", (size, size), 0)
    ImageDraw.Draw(mask).ellipse(
        [x - int(w * 0.14), y - int(h * 0.10),
         x + w + int(w * 0.14), y + h + int(h * 0.14)],
        fill=255,
    )
    mask = mask.filter(ImageFilter.GaussianBlur(int(size * 0.07)))
    mask = mask.point(lambda v: int(v * 90 / 255))
    layer = Image.new("RGBA", (size, size), GLOW_COLOR + (0,))
    layer.putalpha(mask)
    return layer


def shadow_layer(content: Image.Image, size: int, box: tuple[int, int, int, int]) -> Image.Image:
    x, y, w, h = box
    mask = Image.new("L", (size, size), 0)
    mask.paste(content.resize((w, h), Image.LANCZOS).getchannel("A"), (x, y))
    mask = mask.filter(ImageFilter.GaussianBlur(int(size * 0.018)))
    mask = mask.point(lambda v: int(v * 150 / 255))
    layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    layer.putalpha(mask)
    return layer


def icon(content: Image.Image, size: int = 1024, scale: float = LEGACY_SCALE,
         opaque: bool = True) -> Image.Image:
    base = radial_background(size)
    w = int(size * scale)
    h = int(content.height * w / content.width)
    x = (size - w) // 2
    y = (size - h) // 2
    box = (x, y, w, h)
    base.alpha_composite(glow_layer(size, box))
    base.alpha_composite(shadow_layer(content, size, (x, y + int(size * 0.012), w, h)))
    base.alpha_composite(content.resize((w, h), Image.LANCZOS), (x, y))
    if opaque:
        return base.convert("RGB")
    return base


def adaptive_foreground(content: Image.Image, size: int = 432) -> Image.Image:
    """Слой содержимого для adaptive icon: только иллюстрация с подсветкой."""
    layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    w = int(size * ADAPTIVE_SCALE)
    h = int(content.height * w / content.width)
    x = (size - w) // 2
    y = (size - h) // 2
    box = (x, y, w, h)
    layer.alpha_composite(glow_layer(size, box))
    layer.alpha_composite(shadow_layer(content, size, (x, y + int(size * 0.012), w, h)))
    layer.alpha_composite(content.resize((w, h), Image.LANCZOS), (x, y))
    return layer


def rounded(img: Image.Image, radius_ratio: float = 0.5) -> Image.Image:
    size = img.width
    mask = Image.new("L", (size, size), 0)
    ImageDraw.Draw(mask).ellipse([0, 0, size - 1, size - 1], fill=255)
    out = img.convert("RGBA")
    out.putalpha(mask)
    return out


def save(img: Image.Image, path: pathlib.Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    img.save(path, optimize=True)
    print(f"  {path.relative_to(ROOT)}  {img.width}×{img.height}")


ANDROID_DENSITIES = {
    "mdpi": 1.0,
    "hdpi": 1.5,
    "xhdpi": 2.0,
    "xxhdpi": 3.0,
    "xxxhdpi": 4.0,
}

IOS_SIZES = [
    ("Icon-App-20x20@1x", 20), ("Icon-App-20x20@2x", 40), ("Icon-App-20x20@3x", 60),
    ("Icon-App-29x29@1x", 29), ("Icon-App-29x29@2x", 58), ("Icon-App-29x29@3x", 87),
    ("Icon-App-40x40@1x", 40), ("Icon-App-40x40@2x", 80), ("Icon-App-40x40@3x", 120),
    ("Icon-App-60x60@2x", 120), ("Icon-App-60x60@3x", 180),
    ("Icon-App-76x76@1x", 76), ("Icon-App-76x76@2x", 152),
    ("Icon-App-83.5x83.5@2x", 167),
    ("Icon-App-1024x1024@1x", 1024),
]


def main() -> None:
    content = load_content()
    print(f"Исходник: {content.width}×{content.height}")

    print("Мастер-иконка (для магазинов, в APK не попадает):")
    master = icon(content, 1024, opaque=False)
    save(master.convert("RGB"), ROOT / "design" / "app-icon-1024.png")

    print("Android mipmap:")
    for density, factor in ANDROID_DENSITIES.items():
        px = int(48 * factor)
        save(icon(content, px), ANDROID_RES / f"mipmap-{density}" / "ic_launcher.png")
        save(rounded(icon(content, px, opaque=False).convert("RGBA")),
             ANDROID_RES / f"mipmap-{density}" / "ic_launcher_round.png")
        layer_px = int(108 * factor)
        save(radial_background(layer_px),
             ANDROID_RES / f"mipmap-{density}" / "ic_launcher_background.png")
        save(adaptive_foreground(content, layer_px),
             ANDROID_RES / f"mipmap-{density}" / "ic_launcher_foreground.png")

    print("iOS AppIcon:")
    for name, px in IOS_SIZES:
        save(icon(content, px), IOS_ICONS / f"{name}.png")

    print("Сплэш:")
    # Логотип круглый: Android 12 всё равно рисует системную заставку круглой,
    # и без этого при переходе к экрану Flutter виден скачок формы.
    splash = rounded(icon(content, 1024, scale=0.62, opaque=False))
    save(splash, FLUTTER_IMAGES / "logo_splash.png")
    # 200dp — заметно, но не на весь экран; совпадает с логотипом на экране
    # Flutter, поэтому переход между заставками не заметен.
    for density, factor in ANDROID_DENSITIES.items():
        px = int(200 * factor)
        save(rounded(icon(content, px, scale=0.62, opaque=False)),
             ANDROID_RES / f"drawable-{density}" / "splash_logo.png")
    for name, px in (("LaunchImage.png", 200), ("LaunchImage@2x.png", 400),
                     ("LaunchImage@3x.png", 600)):
        save(rounded(icon(content, px, scale=0.62, opaque=False)),
             ROOT / "ios" / "Runner" / "Assets.xcassets"
             / "LaunchImage.imageset" / name)

    print("Готово.")


if __name__ == "__main__":
    main()
