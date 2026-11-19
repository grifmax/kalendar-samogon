# Календарь самогонщика

Android-приложение на Flutter: рецепты, партии и календарь процессов домашнего винокурения — брага, перегонка, настойки, выдержка в бочке и на щепе, дегустации.

**Статус: планирование.** Кода пока нет, есть план и модель данных. Flutter SDK в процессе установки.

## Документы

- [`PLAN.md`](PLAN.md) — концепция, сущности, экраны, стек, этапы, открытые вопросы.
- [`docs/CONTENT.md`](docs/CONTENT.md) — каталог контента: рецепты, справочники, калькуляторы, статьи, глоссарий, шаблоны календаря.
- [`docs/DATA_MODEL.md`](docs/DATA_MODEL.md) — схема локальной БД.
- [`docs/UX.md`](docs/UX.md) — экраны, навигация, сценарии, напоминания.
- [`docs/ROADMAP.md`](docs/ROADMAP.md) — этапы M0–M4 и критерии готовности.

## Окружение (проверено 19.11.2026)

| Компонент | Состояние |
|---|---|
| Flutter SDK | ставится в `C:\flutter` (3.50.0 stable, Dart 3.14) |
| Android Studio | 2025.2.2, JBR 21 (`C:\Program Files\Android\Android Studio\jbr`) |
| Android SDK | `%LOCALAPPDATA%\Android\Sdk`, platforms 33/34/36, build-tools 34.0.0 и 36.1.0 |
| Эмулятор | AVD `Medium_Phone_API_36.1` |
| Системный `java` | 1.8 — для Gradle не годится, используем JBR 21 |

## Сборка (после установки Flutter)

```bash
cd C:/distiller/Календарь_самогонщика/app
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

APK: `app/build/app/outputs/flutter-apk/app-release.apk`.

## Правила проекта

См. [`docs/CONVENTIONS.md`](docs/CONVENTIONS.md): версия, CHANGELOG, коммиты, что не коммитить.
