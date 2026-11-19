# Календарь самогонщика

Android-приложение на Flutter: рецепты, партии и календарь процессов домашнего винокурения — брага, перегонка, настойки, выдержка в бочке и на щепе, дегустации.

**Статус: M0 — каркас собран и проверен на эмуляторе.** Flutter установлен, приложение запускается: тёмная тема, русская локаль, пять разделов навигации. Дальше — M1 (MVP: БД, рецепты, партии, календарь).

## Документы

- [`PLAN.md`](PLAN.md) — концепция, сущности, экраны, стек, этапы, открытые вопросы.
- [`docs/CONTENT.md`](docs/CONTENT.md) — каталог контента: рецепты, справочники, калькуляторы, статьи, глоссарий, шаблоны календаря.
- [`docs/DATA_MODEL.md`](docs/DATA_MODEL.md) — схема локальной БД.
- [`docs/UX.md`](docs/UX.md) — экраны, навигация, сценарии, напоминания.
- [`docs/ROADMAP.md`](docs/ROADMAP.md) — этапы M0–M4 и критерии готовности.

## Окружение (проверено 19.11.2026)

| Компонент | Состояние |
|---|---|
| Flutter SDK | `C:\flutter` — 3.50.0 stable, Dart 3.14 |
| Android Studio | 2025.2.2, JBR 21 (`C:\Program Files\Android\Android Studio\jbr`) |
| Android SDK | `%LOCALAPPDATA%\Android\Sdk`, platforms 33/34/36, build-tools 34.0.0 и 36.1.0, cmdline-tools latest |
| Эмулятор | AVD `Medium_Phone_API_36.1` |
| Системный `java` | 1.8 — для Gradle не годится, Flutter настроен на JBR 21 (`flutter config --jdk-dir`) |

## Расположение проекта

| Путь | Что это |
|---|---|
| `C:\distiller\KalendarSamogon` | **реальный каталог** проекта (ASCII), здесь git-репозиторий и сборка |
| `C:\distiller\Календарь_самогонщика` | NTFS-джанкшен на него — привычный путь для работы |

Почему так: Dart AOT-компилятор на Windows не читает кириллические пути — сборка падает с `Unable to read file ... app.dill`, а Gradle дополнительно ругается на non-ASCII. Поэтому реальный путь — латиницей, а русский путь работает как ярлык.

Джанкшен создаётся один раз (после переустановки — заново):

```bash
cmd /c "mklink /J C:\distiller\Календарь_самогонщика C:\distiller\KalendarSamogon"
```

Сборка и проверки:

```bash
export PATH="/c/flutter/bin:$PATH"
cd /c/distiller/KalendarSamogon/app
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

APK: `C:\distiller\KalendarSamogon\app\build\app\outputs\flutter-apk\app-release.apk`.

Быстрый путь без ручных команд — `build-apk.cmd` в корне проекта (проверяет джанкшен, гоняет analyze + test и собирает APK).

В `app/android/gradle.properties` оставлен `android.overridePathCheck=true` — страховка, если сборка запускается через кириллический путь. Установка на устройство:

```bash
adb install -r app/build/app/outputs/flutter-apk/app-release.apk
```

## Правила проекта

См. [`docs/CONVENTIONS.md`](docs/CONVENTIONS.md): версия, CHANGELOG, коммиты, что не коммитить.
