"""Аудит цифр в assets/recipes.json: объём против состава.

Проверяет то же, что считает приложение, и печатает расхождения — так
находятся рецепты, где baseVolumeL не сходится с закладкой и пользователь
при запуске партии видит «не влезает».

Запуск: python tools/audit_recipes.py [--write]
--write правит baseVolumeL на расчётный объём (с округлением до целого литра).
"""

from __future__ import annotations

import json
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
TARGET = ROOT / "assets" / "recipes.json"

SUGAR_VOLUME_PER_KG = 0.6
# Сахаристость и объём сырья по категориям (как в domain/reference.dart).
RAW = {
    "вишн": (0.10, 1.05),
    "черешн": (0.11, 1.05),
    "слив": (0.09, 1.00),
    "яблок": (0.10, 0.85),
    "груш": (0.10, 0.85),
    "абрикос": (0.08, 0.95),
    "виноград": (0.16, 0.95),
    "рябин": (0.09, 0.95),
    "клюкв": (0.04, 0.95),
    "брусник": (0.07, 0.95),
    "черник": (0.08, 0.95),
    "смородин": (0.08, 0.95),
    "малин": (0.07, 0.95),
    "клубник": (0.07, 0.95),
    "варень": (0.55, 0.75),
    "мёд": (0.80, 0.70),
    "мед ": (0.80, 0.70),
    "зерн": (0.60, 0.75),
    "пшениц": (0.60, 0.75),
    "рожь": (0.55, 0.75),
    "ячмен": (0.55, 0.75),
    "кукуруз": (0.62, 0.75),
    "рис": (0.70, 0.75),
    "солод": (0.60, 0.75),
    "картоф": (0.16, 0.80),
    "свекл": (0.16, 0.80),
    "крахмал": (0.80, 0.80),
    "декстроз": (0.90, 0.65),
    "тростник": (0.90, 0.65),
    "меласс": (0.50, 0.85),
    "жом": (0.10, 0.95),
    "пектин": (0.0, 0.0),
}


def grams(amount: float, unit: str) -> float:
    unit = unit.strip().lower()
    if unit in ("кг", "kg"):
        return amount * 1000
    if unit in ("л", "l"):
        return amount * 1000
    return amount


def litres(amount: float, unit: str) -> float:
    unit = unit.strip().lower()
    if unit in ("л", "l", "кг", "kg"):
        return amount
    if unit in ("мл", "ml"):
        return amount / 1000
    return 0.0


def raw_params(name: str) -> tuple[float, float]:
    lower = name.lower()
    for key, value in RAW.items():
        if key in lower:
            return value
    return (0.0, 0.9)


def audit(recipe: dict) -> dict:
    kind = recipe["kind"]
    volume = float(recipe.get("baseVolumeL") or 0)
    sugar_kg = 0.0
    water_l = 0.0
    spirit_l = 0.0
    spirit_abv = 0.0
    raw_kg = 0.0
    raw_volume = 0.0
    raw_sugar = 0.0

    for ing in recipe["ingredients"]:
        name = ing["name"].lower()
        if any(w in name for w in ("дрожж", "подкормк", "кислот", "фермент", "соль")):
            continue
        if "сахар" in name and "сахарн" not in name:
            sugar_kg += grams(ing["amount"], ing["unit"]) / 1000
            continue
        if name.startswith("вода") or "вода для" in name:
            water_l += litres(ing["amount"], ing["unit"])
            continue
        if any(w in name for w in ("спирт", "сортиров", "водка", "дистиллят", "коньяк")):
            spirit_l += litres(ing["amount"], ing["unit"])
            import re

            m = re.search(r"(\d+[.,]?\d*)\s*%", ing["name"])
            if m:
                spirit_abv = float(m.group(1).replace(",", "."))
            continue
        if ing["unit"].strip().lower() == "шт":
            continue
        kg = grams(ing["amount"], ing["unit"]) / 1000
        frac_sugar, vol_per_kg = raw_params(ing["name"])
        raw_kg += kg
        raw_sugar += kg * frac_sugar
        raw_volume += kg * vol_per_kg

    if kind == "mash":
        total_sugar = sugar_kg + raw_sugar
        need = water_l + sugar_kg * SUGAR_VOLUME_PER_KG + raw_volume
        hydromodule = water_l / total_sugar if total_sugar else 0
        alcohol = total_sugar * 0.60
        return {
            "id": recipe["id"],
            "kind": kind,
            "volume": volume,
            "need": need,
            "hydromodule": hydromodule,
            "alcohol": alcohol,
            "sugar_gpl": total_sugar * 1000 / need if need else 0,
        }

    if kind in ("tincture", "liqueur"):
        # Объём считаем по составу, а не по таре: иначе проверка тавтологична
        # и «2 л спирта + 800 г вишни в 3-литровую банку» проходит как норма.
        liquid = spirit_l + water_l + sugar_kg * SUGAR_VOLUME_PER_KG
        need = liquid + raw_volume
        return {
            "id": recipe["id"],
            "kind": kind,
            "volume": volume,
            "need": need,
            "liquid": liquid,
            "raw_kg": raw_kg,
            "sugar_kg": sugar_kg,
            "raw_gpl": raw_kg * 1000 / volume if volume else 0,
            "sugar_gpl": sugar_kg * 1000 / volume if volume else 0,
            "spirit_abv": spirit_abv,
            "expected_abv": float(recipe.get("expectedAbv") or 0),
            "actual_abv": (
                spirit_l * spirit_abv / 100 / liquid * 100 if liquid and spirit_abv else 0
            ),
        }

    # Перегонки и прочее: только объём заливки.
    return {
        "id": recipe["id"],
        "kind": kind,
        "volume": volume,
        "need": spirit_l + water_l,
        "charge_abv": (
            spirit_l * spirit_abv / (spirit_l + water_l)
            if spirit_l + water_l and spirit_abv
            else 0
        ),
    }


def normalise_mash(recipe: dict) -> bool:
    """Привести брагу к выбраживаемым пропорциям.

    Если сахара больше ~240 г/л, дрожжи не вытянут: часть сахара останется,
    а расчётная крепость браги уходит за 14 %. Уменьшаем добавленный сахар
    (сырьё не трогаем — это основа рецепта) и пересчитываем объём.
    """
    sugar_kg = 0.0
    sugar_index = None
    water_l = 0.0
    water_index = None
    raw_sugar = 0.0
    raw_volume = 0.0

    for index, ing in enumerate(recipe["ingredients"]):
        name = ing["name"].lower()
        if any(w in name for w in ("дрожж", "подкормк", "кислот", "фермент")):
            continue
        if "сахар" in name and "сахарн" not in name:
            sugar_kg += grams(ing["amount"], ing["unit"]) / 1000
            sugar_index = index
            continue
        if name.startswith("вода") or "вода для" in name:
            water_l += litres(ing["amount"], ing["unit"])
            if water_index is None:
                water_index = index
            continue
        if ing["unit"].strip().lower() == "шт":
            continue
        kg = grams(ing["amount"], ing["unit"]) / 1000
        frac_sugar, vol_per_kg = raw_params(ing["name"])
        raw_sugar += kg * frac_sugar
        raw_volume += kg * vol_per_kg

    def need(sugar: float) -> float:
        return water_l + sugar * SUGAR_VOLUME_PER_KG + raw_volume

    def sugar_gpl(sugar: float) -> float:
        volume = need(sugar)
        return (sugar + raw_sugar) * 1000 / volume if volume else 0

    if sugar_index is None or sugar_gpl(sugar_kg) <= 240:
        return False

    # Подбираем добавленный сахар: 3 итерации хватает, объём зависит от сахара.
    target = 200.0
    sugar = sugar_kg
    for _ in range(4):
        volume = need(sugar)
        allowed = target * volume / 1000 - raw_sugar
        sugar = max(0.0, allowed)

    ing = recipe["ingredients"][sugar_index]
    unit = ing["unit"].strip().lower()
    new_amount = round(sugar * 1000) if unit in ("г", "g") else round(sugar, 2)
    if unit in ("г", "g"):
        new_amount = int(round(sugar * 1000 / 100) * 100)  # кратно 100 г
    ing["amount"] = new_amount

    # Бродильной ёмкости нужен запас на пену — 10 %.
    recipe["baseVolumeL"] = int(-(-(need(sugar) * 1.1) // 1))
    return True


def normalise_tincture(recipe: dict) -> bool:
    """Привести спирт и воду настойки к арифметике приложения.

    Спирт и вода подбираются так, чтобы закладка заняла ровно объём рецепта
    и получилась заявленная крепость. Тогда карточка рецепта и форма запуска
    показывают одни и те же числа.
    """
    volume = float(recipe.get("baseVolumeL") or 0)
    if volume <= 0:
        return False

    sugar_kg = 0.0
    raw_kg = 0.0
    raw_volume = 0.0
    spirit_abv = 0.0
    spirit_index = None
    water_indices: list[int] = []

    for index, ing in enumerate(recipe["ingredients"]):
        name = ing["name"].lower()
        if any(w in name for w in ("дрожж", "подкормк", "кислот", "фермент")):
            continue
        if "сахар" in name and "сахарн" not in name:
            sugar_kg += grams(ing["amount"], ing["unit"]) / 1000
            continue
        if name.startswith("вода") or "вода для" in name:
            water_indices.append(index)
            continue
        if any(w in name for w in ("спирт", "сортиров", "водка", "дистиллят", "коньяк")):
            spirit_index = index
            import re

            m = re.search(r"(\d+[.,]?\d*)\s*%", ing["name"])
            spirit_abv = float(m.group(1).replace(",", ".")) if m else 40.0
            continue
        if ing["unit"].strip().lower() == "шт":
            continue
        kg = grams(ing["amount"], ing["unit"]) / 1000
        _, vol_per_kg = raw_params(ing["name"])
        raw_kg += kg
        raw_volume += kg * vol_per_kg

    if spirit_index is None or spirit_abv <= 0:
        return False

    sugar_volume = sugar_kg * SUGAR_VOLUME_PER_KG
    liquid = volume - raw_volume - sugar_volume
    if liquid <= 0.05:
        return False

    target_abv = float(recipe.get("expectedAbv") or 0)
    if target_abv <= 0 or target_abv > spirit_abv:
        return False

    spirit_l = target_abv / spirit_abv * liquid
    water_l = max(0.0, liquid - spirit_l)

    changed = False

    def set_volume(ing: dict, litres_value: float) -> bool:
        """Записать объём в той же единице, что была в рецепте."""
        unit = ing["unit"].strip().lower()
        if unit in ("мл", "ml"):
            new_amount = round(litres_value * 1000)
            if new_amount < 1:
                new_amount = 1
        elif unit in ("л", "l"):
            new_amount = round(litres_value, 2)
        else:
            # Градусы/граммы у объёмного ингредиента — переводим в литры.
            ing["unit"] = "л"
            new_amount = round(litres_value, 2)
        tolerance = max(0.02, abs(new_amount) * 0.02)
        if abs(ing["amount"] - new_amount) > tolerance:
            ing["amount"] = new_amount
            return True
        return False

    spirit_ing = recipe["ingredients"][spirit_index]
    if set_volume(spirit_ing, spirit_l):
        changed = True

    if water_indices:
        # Добавочные воды («вода для сиропа») не трогаем — они часть шага,
        # а доливаем столько, чтобы всё вместе заняло объём рецепта.
        extra_water = 0.0
        for index in water_indices[1:]:
            ing = recipe["ingredients"][index]
            extra_water += litres(ing["amount"], ing["unit"])
        first = recipe["ingredients"][water_indices[0]]
        first_water = max(0.0, water_l - extra_water)
        if first_water <= 0.01:
            recipe["ingredients"].pop(water_indices[0])
            changed = True
        elif set_volume(first, first_water):
            changed = True
    elif water_l > 0.01:
        recipe["ingredients"].insert(
            spirit_index + 1,
            {"name": "Вода", "amount": round(water_l, 2), "unit": "л"},
        )
        changed = True

    return changed


def main() -> int:
    write = "--write" in sys.argv
    data = json.loads(TARGET.read_text(encoding="utf-8"))
    recipes = data["recipes"]

    over, tight, abv_off = [], [], []
    for recipe in recipes:
        a = audit(recipe)
        need = a["need"]
        volume = a["volume"]
        if volume <= 0:
            over.append((a, "нет объёма"))
            continue
        if a["kind"] == "mash":
            if need > volume * 1.02:
                over.append((a, f"не влезает: {need:.1f} л при {volume:.0f} л"))
            elif need < volume * 0.85:
                tight.append((a, f"пусто: {need:.1f} л при {volume:.0f} л"))
            if a["hydromodule"] and a["hydromodule"] < 2.8 and a["sugar_gpl"] > 0:
                # сочное сырьё даёт воду само — смотрим только на сахар в г/л
                if a["sugar_gpl"] > 320:
                    tight.append((a, f"сахара {a['sugar_gpl']:.0f} г/л — не выбраживает"))
        elif a["kind"] in ("tincture", "liqueur"):
            if need > volume * 1.02:
                over.append((a, f"закладка {need:.2f} л при {volume:.0f} л"))
            actual = a.get("actual_abv") or 0
            expected = a.get("expected_abv") or 0
            if actual and expected and abs(actual - expected) > 6:
                abv_off.append(
                    (a, f"крепость в рецепте {expected:.0f} %, по составу {actual:.0f} %")
                )
        else:
            if need > volume * 1.02:
                over.append((a, f"заливка {need:.1f} л при {volume:.0f} л"))

    print(f"рецептов: {len(recipes)}")
    print(f"не влезает: {len(over)}")
    for a, why in over:
        print(f"  - {a['id']} [{a['kind']}]: {why}")
    print(f"подозрительно: {len(tight)}")
    for a, why in tight:
        print(f"  - {a['id']} [{a['kind']}]: {why}")
    print(f"крепость расходится с составом: {len(abv_off)}")
    for a, why in abv_off:
        print(f"  - {a['id']}: {why}")

    if write:
        fixed = {"mash": 0, "tincture": 0, "distillate": 0}
        for recipe in recipes:
            a = audit(recipe)
            kind = a["kind"]
            if kind == "mash":
                if a["volume"] > 0 and a["need"] > a["volume"] * 0.90:
                    # Тару берём с запасом на пену, а не впритык.
                    recipe["baseVolumeL"] = int(-(-(a["need"] * 1.1) // 1))
                    fixed["mash"] += 1
                if normalise_mash(recipe):
                    fixed["mash"] += 1
            elif kind in ("tincture", "liqueur"):
                if normalise_tincture(recipe):
                    fixed["tincture"] += 1
            elif kind not in ("tincture", "liqueur", "mash"):
                need = a["need"]
                if need > 0 and abs(need - a["volume"]) > 0.2:
                    recipe["baseVolumeL"] = int(-(-need // 1))
                    fixed["distillate"] += 1
        TARGET.write_text(
            json.dumps(data, ensure_ascii=False, indent=1) + "\n", encoding="utf-8"
        )
        print(f"\nпоправлено: {fixed}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
