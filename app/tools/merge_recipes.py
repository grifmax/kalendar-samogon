"""Слить наборы рецептов в assets/recipes.json с проверкой схемы.

Запуск:  python tools/merge_recipes.py [--write]
Без --write только проверяет и печатает отчёт.

Наборы берутся из assets/_recipes_{a,b,c,d}.json — это рабочие файлы, в git
они не попадают: после слияния их можно удалить. Повторный запуск
сообщит дубли — это значит, что набор уже влит.
"""
import json
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
ASSETS = ROOT / "assets"
TARGET = ASSETS / "recipes.json"
SOURCES = [ASSETS / f"_recipes_{c}.json" for c in "abcd"]

KINDS = {"mash", "distillate", "tincture", "liqueur", "aging", "gin", "rectification"}
UNITS = {"г", "кг", "мл", "л", "шт"}
EVENTS = {
    "start", "check", "measurement", "rack", "distill", "cut",
    "macerate", "strain", "sweeten", "barrel", "topup", "taste", "bottle",
}
ING_KEYS = {"name", "amount", "unit"}
STEP_KEYS = {
    "title", "description", "offsetDays", "durationMin", "tempC",
    "eventKind", "repeatEveryDays", "repeatUntilDay",
}


def problems(recipe, index, source):
    out = []
    where = f"{source.name}[{index}] {recipe.get('id', '?')}"
    for key in ("id", "title", "kind", "summary", "ingredients", "steps"):
        if key not in recipe:
            out.append(f"{where}: нет поля {key}")
    if recipe.get("kind") not in KINDS:
        out.append(f"{where}: kind={recipe.get('kind')!r}")
    if not str(recipe.get("id", "")).isascii():
        out.append(f"{where}: id не ascii")
    if not isinstance(recipe.get("styleTags", []), list):
        out.append(f"{where}: styleTags не список")
    if not recipe.get("ingredients"):
        out.append(f"{where}: пустой состав")
    if not recipe.get("steps"):
        out.append(f"{where}: пустые шаги")
    for ing in recipe.get("ingredients", []):
        if set(ing) - ING_KEYS:
            out.append(f"{where}: лишние поля ингредиента {set(ing) - ING_KEYS}")
        if ING_KEYS - set(ing):
            out.append(f"{where}: не хватает полей ингредиента {ING_KEYS - set(ing)}")
        if ing.get("unit") not in UNITS:
            out.append(f"{where}: unit={ing.get('unit')!r}")
        if not isinstance(ing.get("amount"), (int, float)) or ing.get("amount", 0) <= 0:
            out.append(f"{where}: amount={ing.get('amount')!r}")
    prev = -1
    for step in recipe.get("steps", []):
        if set(step) - STEP_KEYS:
            out.append(f"{where}: лишние поля шага {set(step) - STEP_KEYS}")
        if STEP_KEYS - set(step):
            out.append(f"{where}: не хватает полей шага {STEP_KEYS - set(step)}")
        if step.get("eventKind") not in EVENTS:
            out.append(f"{where}: eventKind={step.get('eventKind')!r}")
        day = step.get("offsetDays")
        if not isinstance(day, int):
            out.append(f"{where}: offsetDays={day!r}")
        elif day < prev:
            out.append(f"{where}: offsetDays не по возрастанию ({day} после {prev})")
        else:
            prev = day
    return out


def main():
    write = "--write" in sys.argv
    base = json.loads(TARGET.read_text(encoding="utf-8"))
    recipes = base["recipes"]
    existing_ids = {r["id"] for r in recipes}
    existing_titles = {r["title"].strip().lower() for r in recipes}

    errors, added = [], []
    for source in SOURCES:
        if not source.exists():
            errors.append(f"нет файла {source.name}")
            continue
        try:
            chunk = json.loads(source.read_text(encoding="utf-8"))
        except json.JSONDecodeError as e:
            errors.append(f"{source.name}: невалидный JSON — {e}")
            continue
        if not isinstance(chunk, list):
            errors.append(f"{source.name}: ожидался массив")
            continue
        for i, recipe in enumerate(chunk):
            found = problems(recipe, i, source)
            errors.extend(found)
            if found:
                continue
            rid = recipe["id"]
            title = recipe["title"].strip().lower()
            if rid in existing_ids:
                errors.append(f"{source.name}[{i}]: дубль id {rid}")
                continue
            if title in existing_titles:
                errors.append(f"{source.name}[{i}]: дубль названия {recipe['title']}")
                continue
            existing_ids.add(rid)
            existing_titles.add(title)
            added.append(recipe)

    by_kind = {}
    for r in recipes + added:
        by_kind[r["kind"]] = by_kind.get(r["kind"], 0) + 1

    print(f"было {len(recipes)}, добавляется {len(added)}, станет {len(recipes) + len(added)}")
    print("по типам:", dict(sorted(by_kind.items())))
    if errors:
        print(f"\nошибки ({len(errors)}):")
        for e in errors[:60]:
            print("  -", e)

    if write and added and not errors:
        base["recipes"] = recipes + added
        base["version"] = 2
        TARGET.write_text(
            json.dumps(base, ensure_ascii=False, indent=1) + "\n",
            encoding="utf-8",
        )
        print(f"\nзаписано {len(base['recipes'])} рецептов в {TARGET}")
    elif write:
        print("\nне записываю: есть ошибки")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
