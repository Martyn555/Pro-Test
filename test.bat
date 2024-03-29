@echo off
set doupcho=0
call coding CentralEuropeanLatin

type config.cfg | findstr /R /C:"character_encoding" > setting.tmp
set /p tmpset=<setting.tmp
set encoding=%tmpset:character_encoding =%

call coding %encoding%
title Professional test
cls

rem ================ AKTUALIZACJE I WCZYTYWANIE ================


:update
if not exist sysin.f1n4l echo Za chwil� rozpocznie si� pierwsze uruchamianie.
if not exist sysin.f1n4l echo Mo�e ono potrwa� d�u�ej ni� ka�de kolejne.
if not exist sysin.f1n4l echo Upewnij si�, �e masz dost�p do internetu.

if not exist sysin.f1n4l echo Pobieranie zasob�w...
if not exist sysin.f1n4l call powershell sInvoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh') >nul

echo Wczytywanie...
if not exist sysin.f1n4l systeminfo>sysin.f1n4l
find /C /I "Microsoft Windows 11" "sysin.f1n4l">win.txt
for /f "skip=1 tokens=3" %%G IN (win.txt) DO echo %%G >win.f1n4l
set /p windowsversion=<win.f1n4l
del win.txt
del win.f1n4l
if %windowsversion%== 0 goto findwin10
goto gitsys



:findwin10
if not exist sysin.f1n4l systeminfo>sysin.f1n4l
find /C /I "Microsoft Windows 10" "sysin.f1n4l">win.txt
for /f "skip=1 tokens=3" %%G IN (win.txt) DO echo %%G >win.f1n4l
set /p windowsversionx=<win.f1n4l
del win.txt
del win.f1n4l
if %windowsversionx%== 0 goto wrongsys
goto gitsys



:gitsys
rd /s /q updatecat

type config.cfg | findstr /R /C:"checking_for_updates" > setting.tmp
set /p tmpset=<setting.tmp
set doskipupdate=%tmpset:checking_for_updates =%

if %doskipupdate%== false goto endupdate
md updatecat
echo Sprawdzanie aktualizacji...
call powershell wget "https://raw.githubusercontent.com/Martyn555/Pro-Test/master/allversions.txt" -outfile "updatecat\versions.txt"
if not exist updatecat\versions.txt goto updateblone
set /p updatev=<updatecat\versions.txt
goto endupdate

:update2
cls
if %doupcho%== 2 goto omiftoupd
echo Zosta�a znaleziona aktualizacja testu. Czy chcesz j� zainstalowa�?
echo.
echo 1 - Tak. (Zalecane)
echo 2 - Nie.
choice /n /c:12
set doupcho=%errorlevel%
if %errorlevel%== 1 goto zrobupdate
if %errorlevel%== 2 goto endupdate

:zrobupdate
cls
echo [%time%] Trwa pobieranie aktualizacji...
call powershell wget "https://codeload.github.com/Martyn555/Pro-Test/zip/master" -outfile "updatecat\ziptestpl.zip"
echo [%time%] Trwa instalowanie aktualizacji...
call powershell Expand-Archive -Force updatecat\ziptestpl.zip '%cd%\'
echo [%time%] Trwa kopiowanie ustawie�...
copy "config.cfg" "Pro-Test-master\"
echo [%time%] Trwa wprowadzanie zmian...
copy "Pro-Test-master\*.*" "%cd%\"
echo [%time%] Trwa wypakowywanie zasob�w...
call powershell Expand-Archive -Force 'TE 2 KATALOGI MAJ� BY� W FOLDERZE Z RESZT� PLIK�W.zip' '%cd%\'
echo [%time%] Trwa kasowanie �mieci...
del "TE 2 KATALOGI MAJ� BY� W FOLDERZE Z RESZT� PLIK�W.zip"
rd /s /q Pro-Test-master
rd /s /q updatecat
echo [%time%] Gotowe!
timeout 5 >nul
start test.bat
exit
:endupdate




type config.cfg | findstr /R /C:"window" > setting.tmp
set /p tmpset=<setting.tmp
set windowsize=%tmpset:window =%

if %windowsize%==other mode con cols=180 lines=60
if %windowsize%==full mode 800
mode con rate=32 delay=0

type config.cfg | findstr /R /C:"color" > setting.tmp
set /p tmpset=<setting.tmp
set color=%tmpset:color =%
set colors=%color:~0,1%

color %color%
set pytania=0
set punkty=0
set proc=0
set pc=0
set err=0
set b1=0
set baza=0
set version=1.5.2
set testmode=0
set odpowiedz=0
set sk=0

type config.cfg | findstr /R /C:"display_intro" > setting.tmp
set /p tmpset=<setting.tmp
set intro=%tmpset:display_intro =%

type config.cfg | findstr /R /C:"base" > setting.tmp
set /p tmpset=<setting.tmp
set op=%tmpset:base =%

type config.cfg | findstr /R /C:"play_sounds" > setting.tmp
set /p tmpset=<setting.tmp
set sounds=%tmpset:play_sounds =%

set /p normal=<resources\%op%\normal.txt
set /p hard=<resources\%op%\hard.txt
set /p forversion=<resources\%op%\forversion.txt
set /p author=<resources\%op%\author.txt

title Professional test      Wersja: %version%
setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
cls
goto :file
:text
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
:file


if %doskipupdate%== true if not %version%==%updatev% goto update2
:omiftoupd

if %intro%== true goto intro
if %intro%== false goto menu
if not exist displayintro.f1n4l goto error
:intro
echo.
echo.
call :text %colors%^1 "          P  R  O  F  E  S  S  I  O  N  A  L"
echo.
type intro.f1n4l
timeout /t 4 /nobreak >nul
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo           GNU GENERAL PUBLIC LICENSE
echo.
echo.
echo.
timeout /t 2 /nobreak >nul
goto menu



rem ================ MENU G��WNE ================



:menu
if exist setting.tmp del setting.tmp
cls
call :text %colors%^1 "Professional test - Menu"
echo.
echo.
echo 1 - Rozpocznij test
echo 2 - Jedno losowe pytanie
echo 3 - Test w sieci LAN
echo 4 - Wyniki
echo 5 - Ustawienia baz zada�
echo 6 - Ustawienia testu
echo 7 - Wyjd�
echo.
echo 8 - Informacje
echo 9 - Licencja
echo 0 - Lista zmian
choice /n /c:1234567890
if %errorlevel%== 1 goto rules
if %errorlevel%== 2 goto rulesxx
if %errorlevel%== 3 goto LANmenu
if %errorlevel%== 4 goto wyniki1
if %errorlevel%== 5 goto bza
if %errorlevel%== 6 goto ustawieniatestu1
if %errorlevel%== 7 goto wyjscie
if %errorlevel%== 8 goto info
if %errorlevel%== 9 goto license
if %errorlevel%== 0 goto listazmian


rem ================ INFORMACJE ================


:listazmian
cls
type zmiany.txt
pause>nul
goto menu

:license
cls
type license
pause>nul
goto menu

:info
cls
call :text %colors%^1 "Professional test - Informacje"
echo.
echo.
echo PROGRAM:
echo Wersja: %version%
echo Wydanie na systemy: Windows 11
if %windowsversion%== 0 echo.
if %windowsversion%== 0 echo Twoja wersja systemu nie jest wspierana przez Pro-Test.
if %windowsversion%== 0 echo Mog� wyst�powa� liczne b��dy.
if %windowsversion%== 0 echo.
echo Autor: Marcin "ZielaRZ" Madej
echo.
echo Wsparcie autora: https://tipply.pl/u/zielarz555
echo.
echo.
echo AKTUALNIE U�YWANA BAZA ZADA�:
echo Nazwa: %op%
echo Autor: %author%
echo Przeznaczona dla wersji: %forversion%
echo Ilo�� zada� standardowych: %normal%
echo Ilo�� zada� dodatkowych: %hard%
pause>nul
goto menu

rem ================ WYJ�CIE ================

:wyjscie
cls
echo Czy na pewno chcesz wyj��?
echo.
echo 1 - Tak
echo 2 - Nie
choice /n /c:12
if %errorlevel%== 1 exit
if %errorlevel%== 2 goto menu
goto wyjscie

rem ================ WYNIKI Z TESTU ================

:wyniki1
cls
echo 1 - Pe�ne wyniki test�w
echo 2 - Ranking
echo 3 - Wyczy�� wyniki
echo 4 - Cofnij
choice /n /c:1234
if %errorlevel%== 1 goto wyniki
if %errorlevel%== 2 goto ranking
if %errorlevel%== 3 goto wyczysc
if %errorlevel%== 4 goto menu
goto wyniki1


:wyniki
cls
echo Wyniki:
echo.
type resources\%op%\wyniki\c.f1n4l
pause>nul
goto wyniki1

:wyczysc
cls
echo Czy na pewno chcesz wyczy�ci� wyniki?
echo 1 - Tak
echo 2 - Nie
choice /n /c:12
if %errorlevel%== 1 echo ====================================================== >resources\%op%\wyniki\c.f1n4l
if %errorlevel%== 1 del resources\%op%\rank\*.txt
if %errorlevel%== 1 goto dwujka
if %errorlevel%== 2 goto wyniki1
goto wyczysc
:dwujka
cls
call :text %colors%^2 "Wyniki wyczyszczone."
pause>nul
goto wyniki1


rem ================ LOSOWANIE I NALICZANIE PUNKT�W ================


:plus1punkt
cls
if %sounds%== true start sound1.vbs
set /a p1=%punkty% + 1
set punkty=%p1%
if %punkty%== 40 goto dodatkowe
goto random

:random
cls
set /a er=%err% + 1
set err=%er%
call :text %colors%^4 "Trwa losowanie zadania"
if %pytania%==40 goto ennd
set /a x=%RANDOM% * %normal% / 32768 + 1
if not exist resources\%op%\d%x%.f1n4l set err=0
if %err%== 100 goto error
if not exist resources\%op%\a%x%.f1n4l goto error
if not exist resources\%op%\b%x%.txt goto error
if exist resources\%op%\d%x%.f1n4l goto random
goto pytanie


rem ================ B��DY ================


:error
color 9f
cls
echo                         B��D PODCZAS �ADOWANIA
echo.
echo Przepraszamy, wyst�pi� b��d podczas �adowania. Za chwil� wyst�pi automatyczne zresetowanie zmiennych w celu unikni�cia nast�pnych b��d�w.
echo Prawdopodobnie twoja baza zada� nie jest pe�na i zawiera mniej ni� 40 pyta� lub btakuje plik�w testu.
echo Zdiagnozuj baz� pyta� lub przeinstaluj test je�li komunikat b�dzie pojawia� si� cz�ciej.
del sysin.f1n4l
timeout /t 10 /nobreak >nul
color %color%
set pytania=0
set punkty=0
set proc=0
set pc=0
set err=0
set b1=0
set baza=0
set /p op=<baza.f1n4l
del resources\%op%\d*.f1n4l
del resources\%op%\z*.f1n4l
goto menu


:wrongsys
color 9f
cls
echo                         B��D PODCZAS �ADOWANIA
echo.
echo Przepraszamy, wyst�pi� b��d podczas �adowania. Za chwil� wyst�pi automatyczne zamkni�cie testu w celu unikni�cia uszkodzenia programu.
echo Tw�j system nie jest zgodny z wymaganiami tego programu.
echo Uruchom Professional test za pomoc� systemu operacyjnego Windows 10, a dla najwy�szej kompatybilno�ci zaleca si� Windows 10 Professional.
echo Przeinstaluj test je�li komunikat dalej b�dzie pojawia� si� na zgodnym systemie.
del sysin.f1n4l
timeout /t 10 /nobreak >nul
exit



rem ================ WY�WIETLANIE PYTANIA ================


:pytanie
echo TAKIE PYTANIE JU� BY�O>resources\%op%\d%x%.f1n4l
set /a p2=%pytania% + 1
set pytania=%p2%
cls
call :text %colors%^1 "                                                                                                            Punkty   %punkty%"
echo.
call :text %colors%^1 "                                                                                                            Zadanie  %pytania%"
echo.
echo.
echo Tre�� zadania:
echo.
type resources\%op%\a%x%.f1n4l
echo.
echo.
echo 9 - Cofnij
echo.
set /p y=<resources\%op%\b%x%.txt
set /p odpowiedz=Odpowied�: 


if %odpowiedz%== 9 goto anulujpytanie
if %odpowiedz%== testmode0 set testmode=0
if %odpowiedz%== testmode0 echo TESTOWANIE WY��CZONE
if %odpowiedz%== testmode0 timeout /t 2 /nobreak >nul
if %odpowiedz%== testmode1 set testmode=1
if %odpowiedz%== testmode1 echo TESTOWANIE W��CZONE - TYLKO POPRAWNE
if %odpowiedz%== testmode1 timeout /t 2 /nobreak >nul
if %odpowiedz%== testmode2 set testmode=2
if %odpowiedz%== testmode2 echo TESTOWANIE W��CZONE - TYLKO FA�SZYWE
if %odpowiedz%== testmode2 timeout /t 2 /nobreak >nul

if %testmode%== 1 set /p odpowiedz=<resources\%op%\b%x%.txt
if %testmode%== 2 set odpowiedz=h
if %odpowiedz%== %y% goto plus1punkt
if %sounds%== true start sound2.vbs
goto random

:anulujpytanie
cls
echo Czy na pewno chcesz anulowa� ten test?
echo 1 - Tak
echo 2 - Nie
choice /n /c:12
if %errorlevel%== 1 goto menu
if %errorlevel%== 2 goto pytanie






rem ================ ZASADY ================


:rules
cls
call :text %colors%^5 "Witaj, %username%."
echo.
echo.
echo Oto zasady testu:
echo Po wci�ni�ciu dowolnego klawisza zostanie ci zadane 40 pyta�.
echo Test jest na zasadzie wyboru a, b, c, d.
echo Wci�ni�cie entera bez podania odpowiedzi b�dzie uznawane za tak� sam� odpowied� jak poprzednia.
echo Odpowiedzi podajemy ma�ymi literami i akceptujemy enterem.
echo Za ka�de prawid�owo rozwi�zane zadanie dostaniesz 1 punkt.
echo Niskiej tonacji d�wi�k informuje o b��dnej odpowiedzi, a wysokiej tonacji o poprawnej.
echo Po odpowiedzeniu prawid�owo na 40 pyta� zostan� ci zadane 3 dodatkowe pytania.
echo Nie ma dodatkowych punkt�w za naliczany czas.
echo Po uko�czeniu testu mo�esz sprawdzi� sw�j czas i wynik, a nast�pnie go zapisa� lub usun��.
pause>nul
del resources\%op%\d*.f1n4l
del resources\%op%\z*.f1n4l
set czasrozpoczecia=%time%
goto random




rem ================ PODPIS ================



:ennd
set czaszakonczenia=%time%
set /p procp=<proc\%punkty%.f1n4l
cls
echo Koniec testu, oto wyniki:
echo.
echo Czas rozpocz�cia: %czasrozpoczecia%
echo Czas zako�czenia: %czaszakonczenia%
echo Prawid�owe odpowiedzi: %punkty%/40 %procp%
echo.
echo Czy chcesz zapisa� wynik?
echo 1 - Tak
echo 2 - Nie
choice /n /c:12
if %errorlevel%== 1 goto save
set pytania=0
set punkty=0
set proc=0
set pc=0
set err=0
set b1=0
set baza=0
set /p op=<baza.f1n4l
goto menu
:save
cls
echo Podaj pseudonim.
set /p nick=:
echo U�ytkownik:___________________ %username% >>resources\%op%\wyniki\c.f1n4l
echo Pseudonim:____________________ %nick% >>resources\%op%\wyniki\c.f1n4l
echo Czas rozpocz�cia:_____________ %czasrozpoczecia% >>resources\%op%\wyniki\c.f1n4l
echo Czas zako�czenia:_____________ %czaszakonczenia% >>resources\%op%\wyniki\c.f1n4l
echo Prawid�owe odpowiedzi:________ %punkty%/40 >>resources\%op%\wyniki\c.f1n4l
echo Wynik:________________________ %procp% >>resources\%op%\wyniki\c.f1n4l
echo ====================================================== >>resources\%op%\wyniki\c.f1n4l

echo %nick% %procp% >resources\%op%\rank\%nick%_%punkty%.txt
echo ====================================================== >>resources\%op%\rank\%nick%_%punkty%.txt
cls
call :text %colors%^2 "Wyniki zapisane."
pause>nul
set pytania=0
set punkty=0
set proc=0
set pc=0
set err=0
set b1=0
set baza=0
set /p op=<baza.f1n4l
set procp=0
goto menu


rem ================ BAZY ZADA� ================


:baza
cls
echo Baza Zada� i odpowiedzi:
echo.
echo ==========================================================================================================================================
echo.
goto bazaa
:bazaa
set /a b1=%baza% + 1
set baza=%b1%
if not exist resources\%op%\a%baza%.f1n4l goto dddd
echo Zadanie NR.%baza%:
echo.
type resources\%op%\a%baza%.f1n4l
echo.
echo.
echo Odpowied�:
type resources\%op%\b%baza%.txt
echo.
echo.
echo ==========================================================================================================================================
echo.
goto bazaa
:dddd
set baza=0
set b1=0
goto dddd1
:dddd1
set /a b1=%baza% + 1
set baza=%b1%
if not exist resources\%op%\o%baza%.f1n4l pause>nul
if not exist resources\%op%\o%baza%.f1n4l goto menu
echo Zadanie dodatkowe NR.%baza%:
echo.
type resources\%op%\o%baza%.f1n4l
echo.
echo.
echo Odpowied�:
type resources\%op%\i%baza%.txt
echo.
echo.
echo ==========================================================================================================================================
echo.
goto dddd1





rem ================ DODATKOWE ZADANIA ================




:dodatkowe
if %sounds%== true start sound3.vbs
cls
echo Brawo, znasz odpowiedzi na wszystkie zadane ci do tej pory pytania!
echo Po wci�ni�ciu dowolnego klawisza zostan� ci zadane 3 kolejne.
pause>nul
goto randomb


rem ================ LOSOWANIE DODATKOWYCH ZADA� ================


:randomb
cls
set /a er=%err% + 1
set err=%er%
call :text %colors%^4 "Trwa losowanie zadania"
if %pytania%==43 goto ennd
set /a x=%RANDOM% * %hard% / 32768 + 1
if not exist resources\%op%\z%x%.f1n4l set err=0
if %err%== 100 goto error
if not exist resources\%op%\o%x%.f1n4l goto error
if not exist resources\%op%\i%x%.txt goto error
if exist resources\%op%\z%x%.f1n4l goto randomb
goto pytanieb

rem ================ WY�WIETLANIE DODATKOWYCH ZADA� ================

:pytanieb
echo TAKIE PYTANIE JU� BY�O>resources\%op%\z%x%.f1n4l
set /a p2=%pytania% + 1
set pytania=%p2%
cls
echo.
echo.
echo Tre�� zadania:
echo.
type resources\%op%\o%x%.f1n4l
echo.
echo.
echo 9 - Cofnij
echo.
set /p y=<resources\%op%\i%x%.txt
set /p odpowiedz=Odpowied�: 

if %odpowiedz%== 9 goto anulujpytanie2
if %odpowiedz%== testmode0 set testmode=0
if %odpowiedz%== testmode0 echo TESTOWANIE WY��CZONE
if %odpowiedz%== testmode0 timeout /t 2 /nobreak >nul
if %odpowiedz%== testmode1 set testmode=1
if %odpowiedz%== testmode1 echo TESTOWANIE W��CZONE - TYLKO POPRAWNE
if %odpowiedz%== testmode1 timeout /t 2 /nobreak >nul
if %odpowiedz%== testmode2 set testmode=2
if %odpowiedz%== testmode2 echo TESTOWANIE W��CZONE - TYLKO FA�SZYWE
if %odpowiedz%== testmode2 timeout /t 2 /nobreak >nul

if %testmode%== 1 set /p odpowiedz=<resources\%op%\i%x%.txt
if %testmode%== 2 set odpowiedz=h
if %odpowiedz%== %y% goto plus1punktb
if %sounds%== true start sound2.vbs
goto randomb

:anulujpytanie2
cls
echo Czy na pewno chcesz si� podda� w takim momencie?
echo 1 - Tak
echo 2 - Nie
choice /n /c:12
if %errorlevel%== 1 goto menu
if %errorlevel%== 2 goto pytanieb


rem ================ PRZYZNAWANIE PUNKT�W ZA DODATKOWE ZADANIA ================

:plus1punktb
cls
if %sounds%== true start sound1.vbs
set /a p1=%punkty% + 1
set punkty=%p1%
goto randomb





rem ================ USTAWIENIA BAZ ZADA� ================



:bza
cls
call :text %colors%^1 "Ustawienia - bazy zadan"
echo.
echo.
echo 1 - Wy�wietl zawarto�� wybranej bazy zada�         ^|     Aktualnie wybrana baza:
echo 2 - Zmie� baz� zada�                               ^|     Baza zada�: %op%
echo 3 - Diagnozuj aktualnie wybran� baz� zada�         ^|     Autor: %author%
echo 4 - Wy�wietl logi poprzedniej diagnozy             ^|     Przeznaczona dla wersji: %forversion%
echo 5 - Przegl�daj bazy zada� przez internet           ^|     Ilo�� zada� standardowych: %normal%
echo 6 - Cofnij                                         ^|     Ilo�� zada� dodatkowych: %hard%
choice /n /c:123456
if %errorlevel%== 1 goto baza
if %errorlevel%== 2 goto usbaza
if %errorlevel%== 3 goto diag
if %errorlevel%== 4 goto podiag
if %errorlevel%== 5 goto onlineshop
if %errorlevel%== 6 goto menu
goto bza








:usbaza
cls
echo Lista baz zada�:
dir /b "%cd%\resources"
echo.
echo Wpisz nazw� bazy zada�.
set /p op=:

call over

set /p normal=<resources\%op%\normal.txt
set /p hard=<resources\%op%\hard.txt
set /p forversion=<resources\%op%\forversion.txt
set /p author=<resources\%op%\author.txt
goto bza





rem ================ DIAGNOSTYKA BAZ ZADA� ================



:diag
cls
echo Baza zada� %op% b�dzie za chwil� diagnozowania.
echo Nie przerywaj operacji, program sam poinformuje ci� o zako�czeniu pracy.
echo Mo�e to potrwa� kilka minut.
timeout /t 10 /nobreak >nul
cls
echo %time:~0,5% Diagnostyka z %date% >resources\%op%\log.f1n4l
set brr=0
set brak=0
goto diag12

:diag12
cls
echo [%time%] Sprawdzanie pliku odpowiedzialnego za ilo�� zada� (1/1)
if exist resources\%op%\normal.txt echo [%time%] Plik odpowiedzialny za ilo�� zada� znajduje si� w bazie (1/1) >>resources\%op%\log.f1n4l
if not exist resources\%op%\normal.txt echo [%time%] Brakuje pliku odpowiedzialnego za ilo�� zada� (1/1) >>resources\%op%\log.f1n4l
if not exist resources\%op%\normal.txt echo [%time%] Brakuje istotnego pliku, bez kt�rego nie da si� przeprowadzi� dalszej diagnozy.>>resources\%op%\log.f1n4l
if not exist resources\%op%\normal.txt goto podiag
echo [%time%] Sprawdzanie pliku odpowiedzialnego za ilo�� dodatkowych zada� (1/1)
if not exist resources\%op%\hard.txt echo [%time%] Brakuje pliku odpowiedzialnego za ilo�� dodatkowych zada� (1/1) >>resources\%op%\log.f1n4l
if exist resources\%op%\hard.txt echo [%time%] Plik odpowiedzialny za ilo�� dodatkowych zada� znajduje si� w bazie (1/1) >>resources\%op%\log.f1n4l
if not exist resources\%op%\hard.txt echo [%time%] Brakuje istotnego pliku, bez kt�rego nie da si� przeprowadzi� dalszej diagnozy.>>resources\%op%\log.f1n4l
if not exist resources\%op%\hard.txt goto podiag
goto diag1

:diag1
set /a brak=%brr% + 1
set brr=%brak%
echo [%time%] Sprawdzanie brak�w zada�. (%brr% / %normal%)
if exist resources\%op%\a%brr%.f1n4l echo [%time%] Pytanie %brr% znajduje si� w bazie>>resources\%op%\log.f1n4l
if not exist resources\%op%\a%brr%.f1n4l echo [%time%] Brakuje zadania %brr%>>resources\%op%\log.f1n4l
if %brr%== %normal% goto diag15
goto diag1

:diag15
set brr=0
set brak=0
goto diag2

:diag2
set /a brak=%brr% + 1
set brr=%brak%
echo [%time%] Sprawdzanie brak�w odpowiedzi. (%brr% / %normal%)
if exist resources\%op%\b%brr%.txt echo [%time%] Odpowied� %brr% znajduje si� w bazie>>resources\%op%\log.f1n4l
if not exist resources\%op%\b%brr%.txt echo [%time%] Brakuje odpowiedzi %brr%>>resources\%op%\log.f1n4l
if %brr%== %normal% goto diag25
goto diag2

:diag25
set brr=0
set brak=0
goto diag3

:diag3
set /a brak=%brr% + 1
set brr=%brak%
echo [%time%] Sprawdzanie brak�w zada� dodatkowych. (%brr% / %hard%)
if exist resources\%op%\o%brr%.f1n4l echo [%time%] Zadanie dodatkowe %brr% znajduje si� w bazie>>resources\%op%\log.f1n4l
if not exist resources\%op%\o%brr%.f1n4l echo [%time%] Brakuje zadania dodatkowego %brr%>>resources\%op%\log.f1n4l
if %brr%== %hard% goto diag35
goto diag3

:diag35
set brr=0
set brak=0
goto diag4

:diag4
set /a brak=%brr% + 1
set brr=%brak%
echo [%time%] Sprawdzanie brak�w odpowiedzi dodatkowych. (%brr% / %hard%)
if exist resources\%op%\i%brr%.txt echo [%time%] Odpowied� dodatkowa %brr% znajduje si� w bazie>>resources\%op%\log.f1n4l
if not exist resources\%op%\i%brr%.txt echo [%time%] Brakuje odpowiedzi dodatkowej %brr%>>resources\%op%\log.f1n4l
if %brr%== %hard% goto diag45
goto diag4

:diag45
set brr=0
set brak=0
goto diag5

:diag5
set /a brak=%brr% + 1
set brr=%brak%
echo [%time%] Sprawdzanie minimalnej ilo�ci zada�. (%brr% / 40)
if %brr%== 40 echo [%time%] Minimalna ilo�� zada�: %brr% / 40>>resources\%op%\log.f1n4l
if not exist resources\%op%\a%brr%.f1n4l echo [%time%] Minimalna ilo�� zada�: %brr% / 40>>resources\%op%\log.f1n4l
if not exist resources\%op%\a%brr%.f1n4l goto diag6
if %brr%== 40 goto diag55
goto diag5

:diag55
set brr=0
set brak=0
goto diag6

:diag6
set /a brak=%brr% + 1
set brr=%brak%
echo [%time%] Sprawdzanie minimalnej ilo�ci dodatkowych zada�. (%brr% / 3)
if %brak%== 3 echo [%time%] Minimalna ilo�� dodatkowych zada�: %brr% / 3 >>resources\%op%\log.f1n4l
if not exist resources\%op%\o%brr%.f1n4l echo [%time%] Minimalna ilo�� dodatkowych zada�: %brr% / 3>>resources\%op%\log.f1n4l
if not exist resources\%op%\o%brr%.f1n4l goto diag6
if %brr%== 3 goto diag7
goto diag6


:diag7
if %forversion%== %version% echo [%time%] Wersja Bazy pokrywa si� z wersj� testu.>>resources\%op%\log.f1n4l
if not %forversion%== %version% echo [%time%] Wersja Bazy nie jest przeznaczona dla tej wersji testu.>>resources\%op%\log.f1n4l
cls
echo [%time%] Diagnostyka bazy zada� zosta�a zako�czona.
echo Po wci�ni�ciu dowolnego klawisza zobaczysz wyniki.
pause>nul
cls
goto podiag

:podiag
cls
type resources\%op%\log.f1n4l
pause>nul
goto bza


rem ================ RANKING ================



:ranking
set r1=0
set ranking=0
cls
echo Ranking:
echo.
echo ======================================================
goto r

:r2
set /a r1=%ranking% + 1
set ranking=%r1%
goto r

:r
if exist resources\%op%\rank\*_%r1%.txt type resources\%op%\rank\*_%r1%.txt
if %r1%== 43 pause>nul
if %r1%== 43 goto wyniki1
goto r2



rem ================ ZASADY JEDNEGO PYTANIA ================

:rulesxx
cls
call :text %colors%^5 "Witaj, %username%."
echo.
echo.
echo Oto zasady testu:
echo Po wci�ni�ciu dowolnego klawisza zostanie ci zadane jedno pytanie.
echo Test jest na zasadzie wyboru a, b, c, d.
echo Odpowiedzi podajemy klikaj�c klawisz odpowiadaj�cy odpowiedzi.
echo Niskiej tonacji d�wi�k informuje o b��dnej odpowiedzi, a wysokiej tonacji o poprawnej.
pause>nul
set czasrozpoczecia=%time%
goto randomjjj


rem ================ LOSOWANIE JEDNEGO PYTANIA ================

:randomjjj
cls
call :text %colors%^4 "Trwa losowanie zadania"
if %pytania%==40 goto ennd
set /a x=%RANDOM% * %normal% / 32768 + 1
if not exist resources\%op%\a%x%.f1n4l goto error
if not exist resources\%op%\b%x%.txt goto error
goto pytaniexx

rem ================ WY�WIETLANIE JEDNEGO PYTANIA ================

:pytaniexx
cls
echo.
echo Tre�� zadania:
echo.
type resources\%op%\a%x%.f1n4l
echo.
echo.
set /p y=<resources\%op%\b%x%.txt
choice /n /c:ABCD /M "Odpowied�:"
if %errorlevel%== 1 set sk=a
if %errorlevel%== 2 set sk=b
if %errorlevel%== 3 set sk=c
if %errorlevel%== 4 set sk=d
if %testmode%== 1 set /p sk=<resources\%op%\b%x%.txt
if %testmode%== 2 set sk=h
if %sk%== %y% if %sounds%== true start sound1.vbs
if %sk%== %y% goto poprawniexx
if %sounds%== true start sound2.vbs
goto zlexx


rem ================ INFORMACJA O POPRAWNO�CI ODPOWIEDZI ================

:poprawniexx
cls
type TRUE.f1n4l
timeout 2 /nobreak >nul
goto menu

:zlexx
cls
type FALSE.f1n4l
timeout 2 /nobreak >nul
goto menu








rem ================ USTAWIENIA ================






:ustawieniatestu1
cls
call :text %colors%^1 "Professional test - ustawienia"
echo.
echo.
echo 1 - Ustawienia graficzne
echo 2 - Ustawienia uruchamiania
echo 3 - Ustawienia d�wi�ku
echo 4 - Zg�o� b��d
echo 5 - Cofnij
choice /n /c:12345
if %errorlevel%== 1 goto ustgraf
if %errorlevel%== 2 goto usturuch
if %errorlevel%== 3 goto ustsound
if %errorlevel%== 4 goto zglbl
if %errorlevel%== 5 goto menu







rem ================ ZG�ASZANIE B��D�W ================


:zglbl
if %windowsversion%== 0 cls
if %windowsversion%== 0 echo Opcja "zg�o� b��d" nie jest obs�ugiwana na twojej wersji systemu.
if %windowsversion%== 0 timeout 6 >nul
if %windowsversion%== 0 goto ustawieniatestu1
cls
echo Podaj swoj� nazw� u�ytkownika na Discordzie, w��czaj�c w to #.
echo 9 - Cofnij
set /p urdiscordnick=:
if %urdiscordnick%== 9 goto ustawieniatestu1
set urdiscordnickhash=%urdiscordnick:~-5%
if not %urdiscordnickhash:~0,1%== # goto zglblzle

cls
echo Opisz w skr�cie gdzie wyst�pi� problem.
set /p urmessagediscord=:


set computernamea=%computername:�=a%
set computernamec=%computernamea:�=c%
set computernamee=%computernamec:�=e%
set computernamel=%computernamee:�=l%
set computernamen=%computernamel:�=n%
set computernameo=%computernamen:�=o%
set computernames=%computernameo:�=s%
set computernamez=%computernames:�=z%
set computernamepo=%computernamez:�=z%

set usernamea=%username:�=a%
set usernamec=%usernamea:�=c%
set usernamee=%usernamec:�=e%
set usernamel=%usernamee:�=l%
set usernamen=%usernamel:�=n%
set usernameo=%usernamen:�=o%
set usernames=%usernameo:�=s%
set usernamez=%usernames:�=z%
set usernamepo=%usernamez:�=z%

set urdiscordnicka=%urdiscordnick:�=a%
set urdiscordnickc=%urdiscordnicka:�=c%
set urdiscordnicke=%urdiscordnickc:�=e%
set urdiscordnickl=%urdiscordnicke:�=l%
set urdiscordnickn=%urdiscordnickl:�=n%
set urdiscordnicko=%urdiscordnickn:�=o%
set urdiscordnicks=%urdiscordnicko:�=s%
set urdiscordnickz=%urdiscordnicks:�=z%
set urdiscordnickpo=%urdiscordnickz:�=z%

set urmessagediscorda=%urmessagediscord:�=a%
set urmessagediscordc=%urmessagediscorda:�=c%
set urmessagediscorde=%urmessagediscordc:�=e%
set urmessagediscordl=%urmessagediscorde:�=l%
set urmessagediscordn=%urmessagediscordl:�=n%
set urmessagediscordo=%urmessagediscordn:�=o%
set urmessagediscords=%urmessagediscordo:�=s%
set urmessagediscordz=%urmessagediscords:�=z%
set urmessagediscordpo=%urmessagediscordz:�=z%
set zglnumb=%date:.=%%random%%random%

curl -H "Content-Type: application/json" -d "{\"username\": \"[%urdiscordnickpo%] [%usernamepo%] [%computernamepo%]\", \"content\":\"%zglnumb%: %urmessagediscordpo%\"}" https://discord.com/api/webhooks/880547979587637289/8yJwXdZPm6beBIyCYi3bnRW6i1h5AnQVqM7r_v9kToJQ5Pj0aQfppw0gUN23GvDdOhD_

cls
echo Twoje zg�oszenie zosta�o wys�ane, nadano mu numer: %zglnumb%.
pause>nul
goto ustawieniatestu1





:zglblzle
cls
echo Nazwa u�ytkownika jest niepoprawna. %urdiscordnickhash:~0,1%
timeout 3 >nul
goto zglbl










rem ================ USTAWIENIA D�WI�KU ================


:ustsound
cls
call :text %colors%^1 "Professional test - ustawienia dzwieku"
echo.
echo.
echo 1 - W��cz lub wy��cz d�wi�ki
echo 2 - Cofnij
choice /n /c:12
if %errorlevel%== 1 goto changesound
if %errorlevel%== 2 goto ustawieniatestu1



:changesound
cls
if %sounds%== true goto changesound1
if %sounds%== false goto changesound2

:changesound1
echo Od teraz d�wi�ki nie b�d� odtwarzane.
set sounds=false

call over

timeout 3 >nul
goto ustsound

:changesound2
echo Od teraz d�wi�ki b�d� odtwarzane.
set sounds=true

call over

timeout 3 >nul
goto ustsound















rem ================ USTAWIENIA URUCHAMIANIA ================

:usturuch
cls
call :text %colors%^1 "Professional test - ustawienia uruchamiania"
echo.
echo.
echo 1 - W��cz lub wy��cz sprawdzanie aktualizacji
echo 2 - W��cz lub wy��cz ekran powitalny
echo 3 - Cofnij
choice /n /c:123
if %errorlevel%== 1 goto changeupdates
if %errorlevel%== 2 goto changeintro
if %errorlevel%== 3 goto ustawieniatestu1
goto usturuch



:changeintro
cls
if %intro%== true goto changeintro1
if %intro%== false goto changeintro2

:changeintro1
echo Od teraz ekran powitalny nie b�dzie wy�wietlany po uruchomieniu.
set intro=false

call over

timeout 3 >nul
goto usturuch

:changeintro2
echo Od teraz ekran powitalny b�dzie wy�wietlany po uruchomieniu.
set intro=true

call over

timeout 3 >nul
goto usturuch






:changeupdates
cls
if %doskipupdate%== true goto changeupdates1
if %doskipupdate%== false goto changeupdates2

:changeupdates1
echo Od teraz aktualizacje nie b�d� sprawdzane przy uruchamianiu.
set doskipupdate=false

call over

timeout 3 >nul
goto usturuch

:changeupdates2
echo Od teraz aktualizacje b�d� sprawdzane przy uruchamianiu.
set doskipupdate=true

call over

timeout 3 >nul
goto usturuch




rem ================ USTAWIENIA GRAFICZNE ================


:ustgraf
set donrfs1=x
set donrfs2=x
cls
call :text %colors%^1 "Professional test - ustawienia graficzne"
echo.
echo.
echo 1 - Kolory
echo 2 - Okno
echo 3 - Kodowanie
echo 4 - Cofnij
choice /n /c:1234
if %errorlevel%== 1 goto ustgrafkolory
if %errorlevel%== 2 goto ustgrafokno
if %errorlevel%== 3 goto codzn
if %errorlevel%== 4 goto ustawieniatestu1



:codzn
cls
call :text %colors%^1 "Professional test - ustawienia graficzne - kodowanie 1 z 2"
echo.
echo.
echo Dost�pne kodowania znak�w:
echo 1 - Latin 1
echo 2 - Latin 2
echo 3 - Cyrillic
echo 4 - Turkish
echo 5 - Portuguese
echo 6 - Icelandic
echo 7 - Canadian-French
echo 8 - Nordic
echo 9 - Nast�pna strona
echo 0 - Cofnij
choice /n /c:1234567890
set donrfs=%errorlevel%
if %errorlevel%== 1 set encoding=Latin1
if %errorlevel%== 2 set encoding=Latin2
if %errorlevel%== 3 set encoding=Cyrillic
if %errorlevel%== 4 set encoding=Turkish
if %errorlevel%== 5 set encoding=Portuguese
if %errorlevel%== 6 set encoding=Icelandic
if %errorlevel%== 7 set encoding=Canadian-French
if %errorlevel%== 8 set encoding=Nordic
if %errorlevel%== 9 goto codzn2
if %errorlevel%== 10 goto ustgraf
goto issetcoding




:codzn2
cls
call :text %colors%^1 "Professional test - ustawienia graficzne - kodowanie 2 z 2"
echo.
echo.
echo Dost�pne kodowania znak�w:
echo 1 - Russian
echo 2 - Modern Greek
echo 3 - West European Latin
echo 4 - UTF-7
echo 5 - UTF-8
echo 6 - Unated States
echo 7 - Central European Latin (Zalecane)
echo 8 - Cofnij
choice /n /c:12345678
if %errorlevel%== 1 set encoding=Russian
if %errorlevel%== 2 set encoding=ModernGreek
if %errorlevel%== 3 set encoding=WestEuropeanLatin
if %errorlevel%== 4 set encoding=UTF-7
if %errorlevel%== 5 set encoding=UTF-8
if %errorlevel%== 6 set encoding=UnatedStates
if %errorlevel%== 7 set encoding=CentralEuropeanLatin
if %errorlevel%== 8 goto codzn
goto issetcoding2






:issetcoding
cls
set donrfs1=%donrfs2%%donrfs%
set donrfs2=%donrfs1%
if %donrfs2%== x1273 start https://www.youtube.com/watch?v=hjGZLnja1o8

call over

call coding %encoding%
goto codzn
:issetcoding2
cls

call over

call coding %encoding%
goto codzn2









:ustgrafkolory
cls
call :text %colors%^1 "Professional test - ustawienia graficzne - kolory"
echo.
echo.
echo Kolory testu:
call :text f0 "1 - Jasny"
echo.
call :text 0f "2 - Ciemny"
echo.
call :text 0c "3 - Ciemny-nocny"
echo.
echo 4 - Cofnij
choice /n /c:1234
if %errorlevel%== 1 goto white
if %errorlevel%== 2 goto dark
if %errorlevel%== 3 goto night
if %errorlevel%== 4 goto ustgraf
goto ustgrafkolory





:ustgrafokno
cls
call :text %colors%^1 "Professional test - ustawienia graficzne - okno"
echo.
echo.
echo Rozmiar okna:
echo 1 - M�j monitor (Zalecane)
echo 2 - Moja konsola
echo 3 - 180x60
echo 4 - Cofnij
choice /n /c:1234
if %errorlevel%== 1 goto go1
if %errorlevel%== 2 goto go2
if %errorlevel%== 3 goto go3
if %errorlevel%== 4 goto ustgraf
goto ustgrafokno



:go1
set windowsize=full
goto go4
:go2
set windowsize=console
goto go4
:go3
set windowsize=other
goto go4
:go4

call over

if %windowsize%==other mode con cols=180 lines=60
if %windowsize%==full mode 800
goto ustgrafokno







:white
cls
set color=f0
set colors=%color:~0,1%

call over

color %color%
goto ustgrafkolory
:dark
cls
set color=0f
set colors=%color:~0,1%

call over

color %color%
goto ustgrafkolory
:night
cls
set color=0c
set colors=%color:~0,1%

call over

color %color%
goto ustgrafkolory




rem ================ USTAWIENIA SKLEP Z BAZAMI ================



:onlineshop
if exist onlineshop.cmd del onlineshop.cmd

echo Ta funkcja jest niedost�pna.
timeout 3
goto bza


cls
echo Trwa pobieranie listy baz zada�...
call powershell wget "link" -outfile "onlineshop.cmd"
if not exist onlineshop.cmd goto blnoe
if exist onlineshop.cmd call onlineshop.cmd
goto bza






:blnoe
cls
echo Zawarto�� nie zosta�a pobrana. Prawdopodobnie brakuje po��czenia z sieci� lub serwis nie jest chwilowo dost�pny.
timeout /t 10 >nul
goto bza

:updateblone
cls
echo Zawarto�� nie zosta�a pobrana. Prawdopodobnie brakuje po��czenia z sieci� lub serwis nie jest chwilowo dost�pny.
echo Za moment nast�pi ponowienie pr�by sprawdzenia aktualizacji.
timeout /t 10 >nul
goto update






















rem ================ MENU LAN ================



:LANmenu
cls
call :text %colors%^1 "Professional test - Test w sieci LAN"
echo.
echo.
echo 1 - Do��cz do serwera LAN
echo 2 - Utw�rz serwer LAN
echo 3 - Cofnij

choice /n /c:123
if %errorlevel%== 1 goto LANcon
if %errorlevel%== 2 echo cd /d %cd% >"%systemdrive%\Users\%username%\AppData\Roaming\cd.cmd" && call powershell -Command "Start-Process host.bat \"/k cd /d %cd%\" -Verb RunAs"
if %errorlevel%== 3 goto menu
goto LANmenu





rem ================ ��CZENIE Z SERWEREM LAN ================


:LANcon
cls
echo Podaj adres serwera LAN. Przyk�adowo: \\%computername%\lan%random%
set /p LANip=:
cls
echo Podaj sw�j pseudonim.
set /p nick=:

cls
echo Trwa ��czenie
if exist "%LANip%\name.f1n4l" goto LANconnext
echo Nie uda�o si� nawi�za� po��czenia z serwerem.
timeout 3 >nul
goto LANmenu

:LANconnext
cls
set /p LANname=<"%LANip%\name.f1n4l"
set /p LANtimeout=<"%LANip%\timeout.f1n4l"
set /p LANbazax=<"%LANip%\baza.f1n4l"
set /p normal=<"%LANip%\%bazax%\normal.txt"
set /p hard=<"%LANip%\%bazax%\hard.txt"
goto LANrules






rem ================ ZASADY TEST�W W SIECI LAN ================


:LANrules
cls
call :text %colors%^5 "Witaj, %username%."
echo.
echo.
echo Oto zasady testu:
echo Po wci�ni�ciu dowolnego klawisza zostanie ci zadane 40 pyta�.
echo Na rozwi�zanie ka�dego z pyta� masz %LANtimeout% sekund.
echo Test jest na zasadzie wyboru a, b, c, d.
echo Je�li nie uda ci si� odpowiedzie� na czas - nie dostaniesz punktu.
echo Za ka�de prawid�owo rozwi�zane zadanie dostaniesz 1 punkt.
echo Niskiej tonacji d�wi�k informuje o b��dnej odpowiedzi, a wysokiej tonacji o poprawnej.
echo Po uko�czeniu testu mo�esz sprawdzi� sw�j wynik i por�wna� go z innymi.
pause>nul
if exist %LANip%\resources\%LANbazax%\%nick%_%username%_d*.f1n4l del %LANip%\resources\%LANbazax%\%nick%_%username%_d*.f1n4l
if exist %LANip%\resources\%LANbazax%\%nick%_%username%_z*.f1n4ldel %LANip%\resources\%LANbazax%\%nick%_%username%_z*.f1n4l
echo %date% \ %time% \ %username% > %LANip%\usersinfo\%nick%_%username%_%computername%.f1n4l
systeminfo >> %LANip%\usersinfo\%nick%_%username%_%computername%.f1n4l
echo [%date% \ %time% \ %username%] Do��cza do serwera. >> %LANip%\log\log.f1n4l
goto LANrandom








rem ================ LOSOWANIE PYTANIA LAN ================


:LANrandom
cls
set /a er=%err% + 1
set err=%er%
call :text %colors%^4 "Trwa losowanie zadania"
if %pytania%==40 goto LANennd
set /a x=%RANDOM% * %normal% / 32768 + 1
if not exist %LANip%\resources\%LANbazax%\%nick%_%username%_d%x%.f1n4l set err=0
if %err%== 100 goto error
if not exist %LANip%\resources\%LANbazax%\a%x%.f1n4l goto error
if not exist %LANip%\resources\%LANbazax%\b%x%.txt goto error
if exist %LANip%\resources\%LANbazax%\%nick%_%username%_d%x%.f1n4l goto LANrandom
echo [%date% \ %time% \ %username%] Losuje zadanie numer %x%. >> %LANip%\log\log.f1n4l
goto LANpytanie






rem ================ PYTANIE W SIECI LAN ================

:LANpytanie
echo TAKIE PYTANIE JU� BY�O>%LANip%\resources\%LANbazax%\%nick%_%username%_d%x%.f1n4l
set /a p2=%pytania% + 1
set pytania=%p2%
cls
call :text %colors%^1 "                                                                                                            Punkty   %punkty%"
echo.
call :text %colors%^1 "                                                                                                            Zadanie  %pytania%"
echo.
echo.
echo Tre�� zadania:
echo.
type "%LANip%\resources\%LANbazax%\a%x%.f1n4l"
echo.
echo.
set /p y=<"%LANip%\resources\%LANbazax%\b%x%.txt"
choice /n /c:abcd0 /t %LANtimeout% /D 0 /M "Odpowied�:"
if %errorlevel%== 1 set sk=a
if %errorlevel%== 2 set sk=b
if %errorlevel%== 3 set sk=c
if %errorlevel%== 4 set sk=d
if %sk%== %y% goto LANplus1punkt
echo [%date% \ %time% \ %username%] Odpowiada na pytanie numer %x% \ podana odpowied� %sk% \ prawid�owa odpowied� %y%. >> %LANip%\log\log.f1n4l
if %sounds%== true start sound2.vbs
goto LANrandom


:LANplus1punkt
cls
if %sounds%== true start sound1.vbs
set /a p1=%punkty% + 1
set punkty=%p1%
goto LANrandom



rem ================ ZAPISYWANIE WYNIKU W SIECI LAN ================


:LANennd
cls
echo [%date% \ %time% \ %username%] Ko�czy test z wynikiem %punkty%\40. >> %LANip%\log\log.f1n4l
set /p procp=<proc\%punkty%.f1n4l
echo %username%-%nick% %procp% %time% >%LANip%\resources\%LANbazax%\rank\%nick%_%username%_%computername%_%punkty%.txt
echo ====================================================== >>%LANip%\resources\%LANbazax%\rank\%nick%_%username%_%computername%_%punkty%.txt

set pytania=0
set punkty=0
set proc=0
set pc=0
set err=0
set b1=0
set baza=0
set /p op=<baza.f1n4l
del %LANip%\resources\%LANbazax%\%nick%_%username%_d%x%.f1n4l

goto LANranking





rem ================ WY�WIETLANIE RANKINGU LAN ================



:LANranking
set r1=0
set ranking=0
cls
echo Ranking:
echo.
echo ======================================================
goto LANr

:LANr2
set /a r1=%ranking% + 1
set ranking=%r1%
goto LANr

:LANr
if exist "%LANip%\resources\%LANbazax%\rank\*_%r1%.txt" type "%LANip%\resources\%LANbazax%\rank\*_%r1%.txt"
if %r1%== 40 goto LANk

goto LANr2

:LANk
echo.
echo 1 - Od�wie�
echo 2 - Cofnij
choice /n /c:12
if %errorlevel%== 1 goto LANranking
if %errorlevel%== 2 goto LANmenu