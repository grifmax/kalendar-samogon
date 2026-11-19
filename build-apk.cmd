@echo off
rem Сборка release-APK проекта «Календарь самогонщика».
rem Реальный путь проекта — ASCII (C:\distiller\KalendarSamogon), потому что
rem Dart AOT-компилятор на Windows не читает кириллические пути.
rem Кириллический путь C:\distiller\Календарь_самогонщика — джанкшен на него.

setlocal
set "PROJ=C:\distiller\KalendarSamogon"
set "ALIAS=C:\distiller\Календарь_самогонщика"
set "FLUTTER=C:\flutter\bin"

if not exist "%PROJ%\app" (
    echo ОШИБКА: нет каталога %PROJ%\app
    exit /b 1
)

if not exist "%ALIAS%" (
    echo [0/4] Создаю джанкшен %ALIAS%
    cmd /c mklink /J "%ALIAS%" "%PROJ%" || goto :err
)

set "PATH=%FLUTTER%;%PATH%"
cd /d "%PROJ%\app" || goto :err

echo [1/4] pub get
call flutter pub get || goto :err

echo [2/4] analyze
call flutter analyze || goto :err

echo [3/4] test
call flutter test || goto :err

echo [4/4] build apk --release
call flutter build apk --release || goto :err

echo.
echo Готово: %PROJ%\app\build\app\outputs\flutter-apk\app-release.apk
echo Установка: adb install -r "%PROJ%\app\build\app\outputs\flutter-apk\app-release.apk"
exit /b 0

:err
echo.
echo СБОЙ на шаге выше. См. лог.
exit /b 1
