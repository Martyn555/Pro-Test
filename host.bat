@chcp 1250
@echo off
color 0a
goto start
:start
cls
title Pro-Test host testów sieciowych
if exist LAN\name.f1n4l goto pocheckserv1


rem ================ TWORZENIE KATALOGÓW ================


mkdir LAN
mkdir LAN\log
mkdir LAN\usersinfo
mkdir LAN\resources




rem ================ WPROWADZANIE ZMIENNYCH ================


cls
echo Podaj maksymalną ilość użytkowników.
set /p usersquantity=:
set netrandom=lan%random%

cls
echo Trwa kopiowanie zasobów...
xcopy resources\*.* LAN\resources /s /d /y /i >nul

cls
echo Podaj jaka baza zadań ma być używana na serwerze.
set /p LANbaza=:
mkdir LAN\resources\%LANbaza%\rank

cls
echo Podaj maksymalną ilość czasu na rozwiązanie jednego zadania w sekundach.
set /p LANtimeout=:


rem ================ URUCHAMIANIE SERWERA ================


cls
echo Trwa tworzenie serwera...
net share %netrandom%="%cd%\LAN" /grant:Wszyscy,full /USERS:%usersquantity% /REMARK:"Serwer Pro-Test" /CACHE:programs

echo %netrandom%>"\\%COMPUTERNAME%\%netrandom%\name.f1n4l"
echo %LANbaza%>"\\%COMPUTERNAME%\%netrandom%\baza.f1n4l"
echo %LANtimeout%>"\\%COMPUTERNAME%\%netrandom%\timeout.f1n4l"

goto checkserv

:checkserv
cls
echo Oczekuję na dostęp do serwera...
if exist \\%COMPUTERNAME%\%netrandom%\name.f1n4l goto pocheckserv
timeout 1
goto checkserv

:pocheckserv
echo [%date% \ %time% \ %username%] Utworzono host %netrandom%! >LAN\log\log.f1n4l
goto pocheckserv1


rem ================ PRZEGLĄDANIE LOGÓW ================


:pocheckserv1
cls
title Pro-Test host serwera %netrandom%
echo IP twojego serwera to: \\%COMPUTERNAME%\%netrandom%
echo Użyj go aby dołączyć do serwera.
echo.

type LAN\log\log.f1n4l

echo.
echo 1 - Zamknij okno hosta
echo 2 - Zamknij serwer
echo 3 - Odśwież logi
choice /n /c:123 /t 1 /D 3 /M ":"
if %errorlevel%== 1 goto exity
if %errorlevel%== 2 goto pdele
if %errorlevel%== 3 goto pocheckserv1



rem ================ ZAMYKANIE ================


:exity
cls
echo Czy na pewno chcesz zamknąć okno hosta?
echo Nie spowoduje to zamknięcia serwera, dalej będzie możliwe dołączenie.
echo Do okna hosta dalej będzie można powrócić przez opcję "Utwórz serwer LAN".
echo.
echo 1 - Tak
echo 2 - Nie
choice /n /c:12 /M ":"
if %errorlevel%== 1 exit
if %errorlevel%== 2 goto pocheckserv1






:pdele
cls
echo Czy na pewno chcesz wyłączyć serwer?
echo Wyłączenie serwera spowoduje usunięcie logów serwera.
echo.
echo 1 - Tak
echo 2 - Nie
choice /n /c:12 /M ":"
if %errorlevel%== 1 goto dele
if %errorlevel%== 2 goto pocheckserv1







:dele
cls
set /p netrandom=<LAN\name.f1n4l
net share %netrandom% /delete
rmdir /Q /S LAN
echo Zakończono pracę serwera.
timeout 3 >nul
exit