@echo off
TITLE DASI-Skript Updatecheck
setlocal enabledelayedexpansion

:: Neue Online-Version herunterladen
curl -s -o newversion.txt https://raw.githubusercontent.com/Tinnitus97/backup_my_windows_Updater/refs/heads/main/newversion.txt >nul

:: Lokale Version aus Versionscheck\Version.txt einlesen
if not exist "Versionscheck\Version.txt" (
    echo Fehler: Versionscheck\Version.txt wurde nicht gefunden!
    pause
    exit /b
)

for /f "tokens=1,2 delims=|" %%a in (Versionscheck\Version.txt) do (
    set "Version=%%a"
    set "Build=%%b"
)

:: Online-Version einlesen
set /p newversion=<newversion.txt
set newversion=%newversion: =%
del newversion.txt

:: Vergleich
if "!Version!" LSS "!newversion!" goto updateverfuegbar
if "!Version!" GEQ "!newversion!" goto keinupdateverfuegbar

:: === UPDATE VERFÜGBAR ===
:updateverfuegbar
echo Es ist ein Update fuer DASI-Skript verfuegbar!
echo.
echo Aktuelle lokale Version: !Version! vom !Build!
echo Verfuegbare Online-Version: !newversion!
echo.
echo Soll das Update heruntergeladen werden? (j / n)
set /p wahl=
if /i "!wahl!"=="j" goto Webseite_Oeffnen
if /i "!wahl!"=="n" goto Start_DASI-Skript
goto Start_DASI-Skript

:: === UPDATELINK ===
:Webseite_Oeffnen
start microsoft-edge:https://github.com/Tinnitus97/backup_my_windows
exit

:: === UPDATE ABGELEHNT ===
:Start_DASI-Skript
echo Das Update wurde uebersprungen!
goto Start

:: === KEIN UPDATE ===
:keinupdateverfuegbar
echo DASI-Skript ist aktuell! [!Version!]
goto Start

:Start
:: Hier startet dein eigentliches DASI-Skript (optional)
echo Starte DASI-Skript...
