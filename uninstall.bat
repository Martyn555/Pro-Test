@echo off
title Dezinstalator programu Informatyczny test
color f0
set miejsce=%cd%
chcp 65001
setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)>nul
goto :file
:text
rem Martyn's Studio
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
:file

cls
echo Witamy w programie kasacyjnym informatycznego testu.
echo Czy na pewno chcesz usunąć test ze swojego komputera?
echo.
call :text fc "1"
echo - Odinstaluj.
call :text fc "2"
echo - Anuluj.
choice /n /c:1 /M ":"
if %errorlevel%== 1 goto uninstall
if %errorlevel%== 2 exit





:uninstall
cls
echo Za chwilę rozpocznie się kasacja programu
timeout 1 /nobreak >nul
cls
echo Za chwilę rozpocznie się kasacja programu.
timeout 1 /nobreak >nul
cls
echo Za chwilę rozpocznie się kasacja programu..
timeout 1 /nobreak >nul
cls
echo Za chwilę rozpocznie się kasacja programu...
timeout 1 /nobreak >nul

if not exist "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\ITtest\InformatycznyTest.bat" goto skip1
echo [%time%] Usuwanie skrótów z menu start...
cd /d "%systemdrive%\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\"
rd /s /q ITtest
cd /d "%miejsce%"

:skip1
if not exist "%systemdrive%\Users\%username%\desktop\InformatycznyTest.bat" goto skip2
echo [%time%] Usuwanie skrótów z pulpitu...
cd /d %systemdrive%\Users\%username%\desktop\"
del InformatycznyTest.bat
cd /d "%miejsce%"

:skip2
cd ..
echo [%time%] Usuwanie programu...
rd /s /q ITtestPL-master
echo.
echo Gotowe
timeout 2 /nobreak >nul
exit