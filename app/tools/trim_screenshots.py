"""Обрезка скриншотов под требования магазинов.

Эмулятор отдаёт 1080x2400 (соотношение 1:2.22), а Google Play и RuStore
принимают кадры с соотношением от 1:2 до 2:1. Скрипт режет высоту до 2160
(1080x2160 = ровно 1:2), отбрасывая полосы сверху и снизу — обычно там
статус-бар и системная навигация, полезное содержимое остаётся.

Запуск: python app/tools/trim_screenshots.py [--height 2160]
"""

from __future__ import annotations

import argparse
import pathlib
import sys

try:
    from PIL import Image
except ImportError:  # pragma: no cover
    sys.exit("Нужен Pillow: pip install pillow")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--src", default="dist/screenshots")
    ap.add_argument("--dst", default="dist/screenshots/store")
    ap.add_argument("--height", type=int, default=2160)
    args = ap.parse_args()

    root = pathlib.Path(__file__).resolve().parents[2]
    src = root / args.src
    dst = root / args.dst
    if not src.is_dir():
        sys.exit(f"Нет каталога со скриншотами: {src}")

    files = sorted(p for p in src.glob("*.png") if p.is_file())
    if not files:
        sys.exit(f"В {src} нет PNG — сначала снимите кадры make_screenshots.ps1")

    dst.mkdir(parents=True, exist_ok=True)
    for path in files:
        img = Image.open(path).convert("RGB")
        w, h = img.size
        target_h = min(h, args.height)
        if target_h < h:
            # Режем поровну сверху и снизу: статус-бар и навигация уходят,
            # середина экрана с содержимым остаётся.
            top = (h - target_h) // 2
            img = img.crop((0, top, w, top + target_h))
        ratio = target_h / w
        out = dst / path.name
        img.save(out, "PNG", optimize=True)
        print(f"{path.name}: {w}x{h} -> {img.size[0]}x{img.size[1]} (1:{ratio:.2f})")

    print(f"\nГотово: {dst}")
    print("Минимум для Google Play — 4 кадра; загружайте первые два как главные.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
