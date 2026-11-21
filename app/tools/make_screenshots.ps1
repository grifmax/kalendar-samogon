# Скриншоты для магазинов
#
# Снимает набор экранов с запущенного эмулятора и складывает в dist/screenshots/.
# Требования магазинов: PNG, минимум 4 кадра, соотношение сторон не выше 2:1
# (у нас 1080x2400 — 1:2.22, поэтому кадры дополнительно обрезаются по высоте
# до 2160 px: 1080x2160 = 1:2, это допустимо).
#
# Запуск: powershell -ExecutionPolicy Bypass -File tools/make_screenshots.ps1
# Перед запуском: эмулятор запущен, приложение установлено и открыто на нужных
# экранах — скрипт только переключает вкладки и снимает кадры.

param(
    [string]$OutDir = "dist/screenshots",
    [string]$Package = "ru.distiller.kalendar_samogon"
)

$ErrorActionPreference = "Stop"

$sdk = "$env:LOCALAPPDATA\Android\Sdk"
$adb = Join-Path $sdk "platform-tools\adb.exe"
if (-not (Test-Path $adb)) { throw "adb не найден: $adb" }

# Скрипт лежит в app/tools, а dist/ — в корне репозитория.
$root = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSCommandPath))
$out = Join-Path $root $OutDir
New-Item -ItemType Directory -Force -Path $out | Out-Null

function Shot([string]$name) {
    $path = Join-Path $out "$name.png"
    # Только через cmd: перенаправление PowerShell 5.1 портит двоичный поток
    # (переводит \n в \r\n), и PNG получается нечитаемым.
    & cmd /c "`"$adb`" exec-out screencap -p > `"$path`""
    if (-not (Test-Path $path) -or (Get-Item $path).Length -lt 20000) {
        throw "Скриншот не снялся: $path"
    }
    Write-Host "  $name.png"
}

function Tap([int]$x, [int]$y, [int]$pauseMs = 900) {
    & $adb shell input tap $x $y | Out-Null
    Start-Sleep -Milliseconds $pauseMs
}

Write-Host "Запуск приложения"
& $adb shell am force-stop $Package | Out-Null
& $adb shell am start -n "$Package/.MainActivity" | Out-Null
Start-Sleep -Seconds 12   # заставка + инициализация базы

function Back([int]$pauseMs = 1200) {
    & $adb shell input keyevent 4 | Out-Null
    Start-Sleep -Milliseconds $pauseMs
}

# Нижняя навигация: 5 вкладок на ширине 1080.
$tabY = 2232
$tabToday = 108
$tabCalendar = 324
$tabBatches = 540
$tabRecipes = 756
$tabMore = 972

Write-Host "Снимаю экраны"
Tap $tabToday $tabY 0
Shot "01-today"

Tap $tabCalendar $tabY
Shot "02-calendar"

Tap $tabBatches $tabY
Shot "03-batches"

Tap $tabRecipes $tabY
Shot "04-recipes"

# Первая карточка списка → карточка рецепта, затем шторка настройки.
Tap 540 619
Shot "05-recipe"
Tap 765 137
Shot "06-tune"
Back
Back

Tap $tabMore $tabY
Shot "07-more"

# «Ещё» → Калькуляторы (первый пункт списка).
Tap 540 300
Shot "08-calculators"
Back

# «Ещё» → Статистика (второй пункт).
Tap 540 420
Shot "09-stats"
Back

Write-Host "Готово: $out"
Write-Host "Дальше: python app/tools/trim_screenshots.py — обрезка до 1080x2160."
Write-Host "Проверьте кадры глазами: в них не должно быть тестовых данных,"
Write-Host "посторонних приложений и уведомлений в статус-баре."
