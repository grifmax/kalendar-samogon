# Модель данных

Локальная SQLite (drift). Все таблицы — с `id TEXT` (uuid) и `updatedAt`, чтобы позже можно было включить синхронизацию без переделки схемы. Даты — `INTEGER` (epoch ms, UTC), в UI показываем локальное время.

## Перечисления

```
recipeKind      mash | distillate | tincture | liqueur | aging | gin | rectification
batchStatus     planned | fermenting | distilling | aging | ready | bottled | done | failed
eventKind       start | check | measurement | rack | distill | cut | macerate | strain
                | sweeten | pour_to_barrel | top_up | taste | bottle | custom
eventStatus     planned | done | skipped | overdue
runKind         strip | spirit | rectification | gin | steam
fractionKind    foreshots | heads | hearts | tails | feints
vesselKind      barrel | glass | steel | jar | bottle | fermenter
metricKind      sg | brix | temp | abv | ph | acidity | sugar
```

## Таблицы

### `recipes` — шаблон
| Поле | Тип | Смысл |
|---|---|---|
| id, title, kind | TEXT | название, тип |
| styleTags | TEXT (json) | «бурбон-стиль», «скоропорт», «ягодная» |
| baseVolumeL | REAL | объём, на который задан состав |
| expectedYieldL, expectedAbv | REAL | ожидаемый выход |
| source, isOwn, isBuiltIn, isFavorite | TEXT/BOOL | происхождение и пометки |
| notes | TEXT | свободные заметки |
| createdAt, updatedAt | INT | |

### `recipe_ingredients`
`recipeId, ingredientId (nullable), name, amount, unit, note, sortOrder`

### `recipe_steps`
`recipeId, sortOrder, title, description, tempC (nullable), durationMin (nullable), offsetDays (день от старта), createsEvent (bool), eventKind`

> `offsetDays` + `eventKind` — то, из чего генерируется календарь партии. Один рецепт = десяток событий с относительными датами.

### `batches` — партия
| Поле | Смысл |
|---|---|
| recipeId, parentBatchId | откуда взялась, из какой партии сделана (сырец из браги) |
| code | человекочитаемый номер «Б-2026-07» |
| startedAt, finishedAt | |
| volumeL, abv | текущий объём и крепость |
| status | см. enum |
| vesselId | где стоит сейчас |
| notes | |

### `batch_events` — календарь
`batchId, kind, title, plannedAt, actualAt, status, remindBeforeMin, isRecurring, recurrenceRule (RRULE-подобная строка), notes`

События без партии (личные напоминания) — `batchId = null`.

### `measurements` — замеры
`batchId, at, kind, value, note` — строится график брожения, прогноз «когда готово».

### `runs` — перегонки
`batchId, kind, startedAt, endedAt, equipmentId, totalVolumeL, totalAbv, cubeTempStartC, cubeTempEndC, speedMlMin, notes, externalRunId (id из Smart-Column-S3)`

### `run_fractions` — фракции
`runId, fractionKind, jarNo, volumeMl, abv, tempC, notes` — по банкам; сумма даёт тело/головы/хвосты.

### `vessels` — тара
`kind, name, volumeL, material, charLevel, toastLevel, origin, location, isOccupied`

### `aging` — выдержка
`batchId, vesselId, startedAt, plannedEndAt, angelSharePctPerYear, lastToppedAt, nextTopUpAt, nextTasteAt`

### `tastings`
`batchId, at, rating (1–5), aroma, taste, finish, verdict, photoPath, wouldRepeat`

### `equipment`
`name, type, volumeL, powerKw, hasColumn, sensors (json), sc3Host, sc3Enabled`

### `ingredients` — справочник
`name, category (sugar|grain|malt|enzyme|yeast|nutrient|berry|fruit|spice|herb|acid|additive), unit, sugarContentPct, abvPotential, defaultDose, doseUnit, tempMinC, tempMaxC, notes`

### `articles`
`slug, title, category, bodyMarkdown, updatedAt` — статьи и глоссарий лежат в ассетах и перезаписываются при обновлении приложения; пользовательские заметки — отдельно.

### `app_meta`
`schemaVersion, lastBackupAt, installedVersion`

## Связи

```
recipes 1─n recipe_ingredients
recipes 1─n recipe_steps
recipes 1─n batches ─n batch_events
batches 1─n measurements
batches 1─n runs 1─n run_fractions
batches 1─n aging n─1 vessels
batches 1─n tastings
batches 0─1 parentBatch (самоссылка: брага → сырец → сортировка)
```

## Запросы, которые должны быть быстрыми

1. **Сегодня**: `batch_events where status=planned and plannedAt between today 00:00 and 23:59` + просроченные (`plannedAt < now and status=planned`).
2. **Месяц**: `batch_events` за диапазон, сгруппированные по дате.
3. **Активные партии**: `batches where status in (fermenting, distilling, aging)` с прогрессом по шагам рецепта.
4. **Склад**: `vessels` + текущая `batches` в каждой + суммарный АС (`Σ volumeL × abv/100`).
5. **Просроченные напоминания** для бейджа на иконке.

## Миграции и бэкап

- Версия схемы — в `app_meta`, миграции drift пошаговые (не «снести и создать»).
- Бэкап: полный дамп в JSON (`schemaVersion` + все таблицы) + опционально фото. Импорт — с проверкой версии и режимами «заменить / слить».
- Никаких PII и телеметрии; экспорт CSV для таблиц замеров и перегонок.
