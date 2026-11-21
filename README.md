# Календарь самогонщика

Android-приложение на Flutter: рецепты, партии и календарь процессов домашнего винокурения — брага, перегонка, настойки, выдержка в бочке и на щепе, дегустации.

**Статус: 0.12.1 — M3, выпуск в магазины.** Есть база на drift (схема 4), 105 рецептов, партии с календарём, настройка рецепта под свою тару и вкус, перегонки с фракциями, дегустации, склад, справочник норм и 12 калькуляторов с температурными поправками.

## Что уже умеет

| Раздел | Возможности |
|---|---|
| Сегодня | просрочено / на сегодня / скоро, активные партии, «сделано / отложить / пропустить» |
| Календарь | сетка месяца с точками событий, события дня, фильтр по рецептам не нужен — всё видно |
| Партии | запуск из рецепта, таймлайн шагов, статусы, удаление, заметки |
| Рецепты | 105 встроенных (браги, перегонки, настойки, ликёры, выдержка), поиск, фильтр по типу, избранное |
| Замеры | плотность, крепость, температура, Brix; график и прогноз «готово через N дней» |
| Настаивание | срок, интервал взбалтывания, счётчик, подсказки «пора взболтать» и «пора снимать с осадка» |
| Настройка рецепта | тара, крепость, спирт, сырьё, сахар — с расчётом «влезает ли» и «как сахар снизит крепость» |
| Перегонки | прогоны, фракции по банкам, итоги по АС, выход от залитого |
| Дегустации | оценка, аромат, вкус, послевкусие, выводы |
| Склад | бочки, бутыли, банки: объём, обжиг, занятость, процент заполнения |
| Справочник | нормы сырья г/л, сладость, крепости, выход спирта |
| Статистика | литры закладок и тела, чистый спирт, выход от залитого, часы у куба, топ рецептов, погреб, оценки |
| Калькуляторы | 12 штук: брага, разбавление, сортировка на объём, фракции, укрепление, купаж, сахар и крепость, выход из сырья, масштаб, ареометр, щепа, себестоимость |
| Данные | всё локально, экспорт в JSON-файл, восстановление из файла, напоминания на устройстве |

## Документы

- [`PLAN.md`](PLAN.md) — концепция, сущности, экраны, стек, этапы, открытые вопросы.
- [`docs/CONTENT.md`](docs/CONTENT.md) — каталог контента: рецепты, справочники, калькуляторы, статьи, глоссарий, шаблоны календаря.
- [`docs/DATA_MODEL.md`](docs/DATA_MODEL.md) — схема локальной БД.
- [`docs/UX.md`](docs/UX.md) — экраны, навигация, сценарии, напоминания.
- [`docs/ROADMAP.md`](docs/ROADMAP.md) — этапы M0–M4, iOS-трек, критерии готовности.
- [`docs/RELEASE.md`](docs/RELEASE.md) — чек-лист выпуска в RuStore, Google Play, App Store.
- [`docs/TUNING.md`](docs/TUNING.md) — как считается настройка рецепта: тара, крепость, сахар, влияние на объём.

## Окружение (проверено 19.11.2026)

Целевые платформы: **Android** (основная) и **iOS** (закладываем сразу, собирать нужно на macOS или в CI).

| Компонент | Состояние |
|---|---|
| Flutter SDK | `C:\flutter` — 3.50.0 stable, Dart 3.14 |
| Android Studio | 2025.2.2, JBR 21 (`C:\Program Files\Android\Android Studio\jbr`) |
| Android SDK | `%LOCALAPPDATA%\Android\Sdk`, platforms 33/34/36, build-tools 34.0.0 и 36.1.0, cmdline-tools latest |
| Эмулятор | AVD `Medium_Phone_API_36.1` |
| Системный `java` | 1.8 — для Gradle не годится, Flutter настроен на JBR 21 (`flutter config --jdk-dir`) |
| Xcode / macOS | нет — iOS собирается только на Mac или GitHub Actions с macOS-раннером |

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

## Иконка и заставка

Вся графика — производная от одной иллюстрации `app/design/icon-source.png`:

```bash
cd app
python tools/make_icon.py
```

Скрипт пересобирает:

- `android/app/src/main/res/mipmap-*` — обычная и круглая иконка, слои adaptive icon (фон-градиент + сюжет с подсветкой);
- `ios/Runner/Assets.xcassets/AppIcon.appiconset` — все размеры, без альфы (требование App Store);
- `assets/images/logo_splash.png` и `splash_logo`/`LaunchImage` для нативных заставок Android и iOS;
- `design/app-icon-1024.png` — мастер для карточек в магазинах (в APK не попадает).

Сюжет занимает 70 % кадра, фон — тёплый радиальный градиент `#3A2A1B → #100C09`. Иконки и сплэш руками не правят: правьте иллюстрацию и перезапускайте скрипт.

Заставка двухслойная: нативная (Android 12+ `windowSplashScreen*`, до 12 — `launch_background`, iOS `LaunchScreen`) показывает логотип, затем `BootstrapApp` выводит экран Flutter с логотипом, названием «Календарь самогонщика» и подписью, пока открывается база и раскладываются встроенные рецепты.

## Разработка

```bash
export PATH="/c/flutter/bin:$PATH"
cd /c/distiller/KalendarSamogon/app
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # после правки таблиц drift
flutter analyze
flutter test
```

Структура:

```
lib/
  app/            каркас, тема, AppScope (доступ к базе и сервисам)
  data/
    db/           таблицы drift и база
    repositories/ рецепты, партии, события, замеры
    seed/         загрузка встроенных рецептов из assets
  domain/         чистые расчёты (калькуляторы, настройка рецепта, справочник) + тесты
  features/       экраны: today, calendar, batches, recipes, runs, tastings,
                  vessels, reference, calculators, more
  services/       напоминания, резервная копия
  utils/          форматирование дат и чисел
assets/recipes.json   105 встроенных рецептов
```

## Сборка и выпуск

```
powershell -ExecutionPolicy Bypass -File build-apk.cmd   # analyze + test + build
flutter build appbundle --release                        # .aab для Google Play
flutter build apk --release                              # .apk для RuStore
```

Release подписывается ключом из `app/android/key.properties` (файл вне git,
ключ — `app/android/upload-keystore.jks`). Без `key.properties` сборка
откатывается на debug-подпись, чтобы `flutter run --release` работал в чистом
клоне. **Ключ и пароли храните в менеджере паролей**: потеря ключа = невозможность
обновлять приложение в Google Play.

Документы для выпуска:

| Файл | Что внутри |
|---|---|
| [`docs/RELEASE.md`](docs/RELEASE.md) | чек-лист, площадки, правила по алкогольной тематике, порядок публикации |
| [`docs/STORE_LISTING.md`](docs/STORE_LISTING.md) | тексты карточек, категории, рейтинги, ответы на анкету IARC |
| [`docs/PRIVACY.md`](docs/PRIVACY.md) | политика конфиденциальности; опубликована: <https://grifmax.github.io/kalendar-samogon/PRIVACY.html> (копия в приложении — `app/assets/privacy.md`) |

Репозиторий: <https://github.com/grifmax/kalendar-samogon>. Страница проекта и
политика конфиденциальности публикуются из каталога `docs/` через GitHub Pages
(`docs/_config.yml`, `docs/index.md`).

## Правила проекта

См. [`docs/CONVENTIONS.md`](docs/CONVENTIONS.md): версия, CHANGELOG, коммиты, что не коммитить.
