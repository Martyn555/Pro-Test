@chcp 1250
@echo off
title Professional test
cls




:update
echo Wczytywanie...
if not exist sysin.f1n4l systeminfo>sysin.f1n4l
find /C /I "Microsoft Windows 10" "sysin.f1n4l">win.txt
for /f "skip=1 tokens=3" %%G IN (win.txt) DO echo %%G >win.f1n4l
set /p windowsversion=<win.f1n4l
del win.txt
del win.f1n4l
if %windowsversion%== 0 goto wrongsys
rd /s /q updatecat
md updatecat
echo Sprawdzanie aktualizacji...
call powershell wget "https://raw.githubusercontent.com/Martyn555/Pro-Test/master/allversions.txt" -outfile "updatecat\versions.txt"
if not exist updatecat\versions.txt goto updateblone
set /p updatev=<updatecat\versions.txt
goto endupdate

:update2
cls
echo Zosta³a znaleziona aktualizacja testu. Czy chcesz j¹ zainstalowaæ?
echo.
echo 1 - Tak. (Zalecane)
echo 2 - Nie.
choice /n /c:12 /M ":"
if %errorlevel%== 1 goto zrobupdate
if %errorlevel%== 2 goto endupdate

:zrobupdate
cls
echo [%time%] Trwa pobieranie aktualizacji...
call powershell wget "https://codeload.github.com/Martyn555/Pro-Test/zip/master" -outfile "updatecat\ziptestpl.zip"
echo [%time%] Trwa Wypakowywanie aktualizacji...
call powershell Expand-Archive -Force updatecat\ziptestpl.zip '%cd%\'
copy "Pro-Test-master\*.*" "%cd%\"
call powershell Expand-Archive -Force 'TE 2 KATALOGI MAJ¥ BYÆ W FOLDERZE Z RESZT¥ PLIKÓW.zip' '%cd%\'
del "TE 2 KATALOGI MAJ¥ BYÆ W FOLDERZE Z RESZT¥ PLIKÓW.zip"
rd /s /q Pro-Test-master
rd /s /q updatecat
:endupdate





if exist win2.f1n4l mode con cols=180 lines=60
if exist win.f1n4l mode 800
mode con rate=32 delay=0
set /p color=<color.f1n4l
set /p colors=<color2.f1n4l
color %color%
set pytania=0
set punkty=0
set proc=0
set pc=0
set err=0
set b1=0
set baza=0
set version=1.2
set testmode=0
set /p intro=<displayintro.f1n4l
set /p op=<baza.f1n4l
set /p normal=<resources\%op%\normal.txt
set /p hard=<resources\%op%\hard.txt
set /p op=<baza.f1n4l
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

if not %version%==%updatev% goto update2

if %intro%== true goto intro
if %intro%== false goto menu
if not exist displayintro.f1n4l goto error
:intro
echo.
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

:menu
cls
call :text %colors%^1 "Professional test - Menu"
echo.
echo.
echo 1 - Rozpocznij test
echo 2 - Jedno losowe pytanie
echo 3 - Wyniki
echo 4 - Ustawienia baz zadañ
echo 5 - Ustawienia testu
echo 6 - WyjdŸ
echo.
echo 7 - Informacje
echo 8 - Licencja
echo 9 - Lista zmian
choice /n /c:123456789 /M ":"
if %errorlevel%== 1 goto rules
if %errorlevel%== 2 goto rulesxx
if %errorlevel%== 3 goto wyniki1
if %errorlevel%== 4 goto bza
if %errorlevel%== 5 goto ustawieniatestu
if %errorlevel%== 6 goto wyjscie
if %errorlevel%== 7 goto info
if %errorlevel%== 8 goto license
if %errorlevel%== 9 goto listazmian

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
echo Wersja: %version%
echo Wydanie na systemy: Windows 10
echo Autor: Marcin "ZielaRZ" Madej
echo.
echo Baza zadañ: %op%
echo Autor: %author%
echo Przeznaczona dla wersji: %forversion%
echo Iloœæ zadañ standardowych: %normal%
echo Iloœæ zadañ dodatkowych: %hard%
echo.
echo W celu zg³aszania b³êdów i sugerowania zmian proszê napisaæ: https://www.messenger.com/t/100010615000573
pause>nul
goto menu



:wyjscie
cls
echo Czy na pewno chcesz wyjœæ?
echo.
echo 1 - Tak
echo 2 - Nie
choice /n /c:12 /M ":"
if %errorlevel%== 1 exit
if %errorlevel%== 2 goto menu
goto wyjscie

:wyniki1
cls
echo 1 - Pe³ne wyniki testów
echo 2 - Ranking
echo 3 - Wyczyœæ wyniki
echo 4 - Cofnij
choice /n /c:1234 /M ":"
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
echo Czy na pewno chcesz wyczyœciæ wyniki?
echo 1 - Tak
echo 2 - Nie
choice /n /c:12 /M ":"
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

:plus1punkt
cls
start sound1.vbs
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

:error
color 9f
cls
echo                         B£¥D PODCZAS £ADOWANIA
echo.
echo Przepraszamy, wyst¹pi³ b³¹d podczas ³adowania. Za chwilê wyst¹pi automatyczne zresetowanie zmiennych w celu unikniêcia nastêpnych b³êdów.
echo Prawdopodobnie twoja baza zadañ nie jest pe³na i zawiera mniej ni¿ 40 pytañ lub btakuje plików testu.
echo Zdiagnozuj bazê pytañ lub przeinstaluj test jeœli komunikat bêdzie pojawia³ siê czêœciej.
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






:pytanie
echo TAKIE PYTANIE JU¯ BY£O>resources\%op%\d%x%.f1n4l
set /a p2=%pytania% + 1
set pytania=%p2%
cls
call :text %colors%^1 "                                                                                                            Punkty   %punkty%"
echo.
call :text %colors%^1 "                                                                                                            Zadanie  %pytania%"
echo.
echo.
echo Treœæ zadania:
echo.
type resources\%op%\a%x%.f1n4l
echo.
echo.
echo OdpowiedŸ:
set /p y=<resources\%op%\b%x%.txt
set /p odpowiedz=:

if %odpowiedz%== testmode0 set testmode=0
if %odpowiedz%== testmode0 echo TESTOWANIE WY£¥CZONE
if %odpowiedz%== testmode0 timeout /t 2 /nobreak >nul
if %odpowiedz%== testmode1 set testmode=1
if %odpowiedz%== testmode1 echo TESTOWANIE W£¥CZONE - TYLKO POPRAWNE
if %odpowiedz%== testmode1 timeout /t 2 /nobreak >nul
if %odpowiedz%== testmode2 set testmode=2
if %odpowiedz%== testmode2 echo TESTOWANIE W£¥CZONE - TYLKO FA£SZYWE
if %odpowiedz%== testmode2 timeout /t 2 /nobreak >nul

if %testmode%== 1 set /p odpowiedz=<resources\%op%\b%x%.txt
if %testmode%== 2 set odpowiedz=h
if %odpowiedz%== %y% goto plus1punkt
start sound2.vbs
goto random









:rules
cls
call :text %colors%^5 "Witaj, %username%."
echo.
echo.
echo Oto zasady testu:
echo Po wciœniêciu dowolnego klawisza zostanie ci zadane 40 pytañ z dziedziny informatyki.
echo Test jest na zasadzie wyboru a, b, c, d.
echo Wciœniêcie entera bez podania odpowiedzi bêdzie uznawane za tak¹ sam¹ odpowiedŸ jak poprzednia.
echo Odpowiedzi podajemy ma³ymi literami i akceptujemy enterem.
echo Za ka¿de prawid³owo rozwi¹zane zadanie dostaniesz 1 punkt.
echo Niskiej tonacji dŸwiêk informuje o b³êdnej odpowiedzi, a wysokiej tonacji o poprawnej.
echo Po odpowiedzeniu prawid³owo na 40 pytañ zostan¹ ci zadane 3 dodatkowe pytania.
echo Nie ma dodatkowych punktów za naliczany czas.
echo Po ukoñczeniu testu mo¿esz sprawdziæ swój czas i wynik, a nastêpnie go zapisaæ lub usun¹æ.
pause>nul
del resources\%op%\d*.f1n4l
del resources\%op%\z*.f1n4l
set czasrozpoczecia=%time%
goto random








:ennd
set czaszakonczenia=%time%
set /p procp=<proc\%punkty%.f1n4l
cls
echo Koniec testu, oto wyniki:
echo.
echo Czas rozpoczêcia: %czasrozpoczecia%
echo Czas zakoñczenia: %czaszakonczenia%
echo Prawid³owe odpowiedzi: %punkty%/40 %procp%
echo.
echo Czy chcesz zapisaæ wynik?
echo 1 - Tak
echo 2 - Nie
choice /n /c:12 /M ":"
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
echo U¿ytkownik:___________________ %username% >>resources\%op%\wyniki\c.f1n4l
echo Pseudonim:____________________ %nick% >>resources\%op%\wyniki\c.f1n4l
echo Czas rozpoczêcia:_____________ %czasrozpoczecia% >>resources\%op%\wyniki\c.f1n4l
echo Czas zakoñczenia:_____________ %czaszakonczenia% >>resources\%op%\wyniki\c.f1n4l
echo Prawid³owe odpowiedzi:________ %punkty%/40 >>resources\%op%\wyniki\c.f1n4l
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




:baza
cls
echo Baza Zadañ i odpowiedzi:
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
echo OdpowiedŸ:
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
echo OdpowiedŸ:
type resources\%op%\i%baza%.txt
echo.
echo.
echo ==========================================================================================================================================
echo.
goto dddd1










:dodatkowe
start sound3.vbs
cls
echo Brawo, znasz odpowiedzi na wszystkie zadane ci do tej pory pytania!
echo Po wciœniêciu dowolnego klawisza zostan¹ ci zadane 3 kolejne.
pause>nul
goto randomb

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


:pytanieb
echo TAKIE PYTANIE JU¯ BY£O>resources\%op%\z%x%.f1n4l
set /a p2=%pytania% + 1
set pytania=%p2%
cls
echo.
echo.
echo Treœæ zadania:
echo.
type resources\%op%\o%x%.f1n4l
echo.
echo.
echo OdpowiedŸ:
set /p y=<resources\%op%\i%x%.txt
set /p odpowiedz=:

if %odpowiedz%== testmode0 set testmode=0
if %odpowiedz%== testmode0 echo TESTOWANIE WY£¥CZONE
if %odpowiedz%== testmode0 timeout /t 2 /nobreak >nul
if %odpowiedz%== testmode1 set testmode=1
if %odpowiedz%== testmode1 echo TESTOWANIE W£¥CZONE - TYLKO POPRAWNE
if %odpowiedz%== testmode1 timeout /t 2 /nobreak >nul
if %odpowiedz%== testmode2 set testmode=2
if %odpowiedz%== testmode2 echo TESTOWANIE W£¥CZONE - TYLKO FA£SZYWE
if %odpowiedz%== testmode2 timeout /t 2 /nobreak >nul

if %testmode%== 1 set /p odpowiedz=<resources\%op%\i%x%.txt
if %testmode%== 2 set odpowiedz=h
if %odpowiedz%== %y% goto plus1punktb
start sound2.vbs
goto randomb


:plus1punktb
cls
start sound1.vbs
set /a p1=%punkty% + 1
set punkty=%p1%
goto randomb









:bza
cls
call :text %colors%^1 "Ustawienia - bazy zadañ"
echo.
echo Aktualnie wybrana baza: %op%
echo.
echo 1 - Wyœwietl zawartoœæ wybranej bazy zadañ
echo 2 - Zmieñ bazê zadañ
echo 3 - Diagnozuj wybran¹ bazê zadañ
echo 4 - Wyœwietl logi poprzedniej diagnozy
echo 5 - Przegl¹daj bazy zadañ przez internet
echo 6 - Cofnij
choice /n /c:123456 /M ":"
if %errorlevel%== 1 goto baza
if %errorlevel%== 2 goto usbaza
if %errorlevel%== 3 goto diag
if %errorlevel%== 4 goto podiag
if %errorlevel%== 5 goto onlineshop
if %errorlevel%== 6 goto menu
goto bza

:usbaza
cls
echo Wpisz nazwê katalogu z baz¹ zadañ.
set /p secik=:
echo %secik%>baza.f1n4l
set /p op=<baza.f1n4l
set /p normal=<resources\%op%\normal.txt
set /p hard=<resources\%op%\hard.txt
set /p forversion=<resources\%op%\forversion.txt
set /p author=<resources\%op%\author.txt
goto bza









:diag
cls
echo Baza zadañ %op% bêdzie za chwilê diagnozowania.
echo Nie przerywaj operacji, program sam poinformuje ciê o zakoñczeniu pracy.
echo Mo¿e to potrwaæ kilka minut.
timeout /t 10 /nobreak >nul
cls
echo %time:~0,5% Diagnostyka z %date% >resources\%op%\log.f1n4l
set brr=0
set brak=0
goto diag12

:diag12
cls
echo %time% Sprawdzanie pliku odpowiedzialnego za iloœæ zadañ (1/1)
if exist resources\%op%\normal.txt echo %time% Plik odpowiedzialny za iloœæ zadañ znajduje siê w bazie (1/1) >>resources\%op%\log.f1n4l
if not exist resources\%op%\normal.txt echo %time% Brakuje pliku odpowiedzialnego za iloœæ zadañ (1/1) >>resources\%op%\log.f1n4l
if not exist resources\%op%\normal.txt echo %time% Brakuje istotnego pliku, bez którego nie da siê przeprowadziæ dalszej diagnozy.>>resources\%op%\log.f1n4l
if not exist resources\%op%\normal.txt goto podiag
echo %time% Sprawdzanie pliku odpowiedzialnego za iloœæ dodatkowych zadañ (1/1)
if not exist resources\%op%\hard.txt echo %time% Brakuje pliku odpowiedzialnego za iloœæ dodatkowych zadañ (1/1) >>resources\%op%\log.f1n4l
if exist resources\%op%\hard.txt echo %time% Plik odpowiedzialny za iloœæ dodatkowych zadañ znajduje siê w bazie (1/1) >>resources\%op%\log.f1n4l
if not exist resources\%op%\hard.txt echo %time% Brakuje istotnego pliku, bez którego nie da siê przeprowadziæ dalszej diagnozy.>>resources\%op%\log.f1n4l
if not exist resources\%op%\hard.txt goto podiag
goto diag1

:diag1
set /a brak=%brr% + 1
set brr=%brak%
echo %time% Sprawdzanie braków zadañ. (%brr% / %normal%)
if exist resources\%op%\a%brr%.f1n4l echo %time% Pytanie %brr% znajduje siê w bazie>>resources\%op%\log.f1n4l
if not exist resources\%op%\a%brr%.f1n4l echo %time% Brakuje zadania %brr%>>resources\%op%\log.f1n4l
if %brr%== %normal% goto diag15
goto diag1

:diag15
set brr=0
set brak=0
goto diag2

:diag2
set /a brak=%brr% + 1
set brr=%brak%
echo %time% Sprawdzanie braków odpowiedzi. (%brr% / %normal%)
if exist resources\%op%\b%brr%.txt echo %time% OdpowiedŸ %brr% znajduje siê w bazie>>resources\%op%\log.f1n4l
if not exist resources\%op%\b%brr%.txt echo %time% Brakuje odpowiedzi %brr%>>resources\%op%\log.f1n4l
if %brr%== %normal% goto diag25
goto diag2

:diag25
set brr=0
set brak=0
goto diag3

:diag3
set /a brak=%brr% + 1
set brr=%brak%
echo %time% Sprawdzanie braków zadañ dodatkowych. (%brr% / %hard%)
if exist resources\%op%\o%brr%.f1n4l echo %time% Zadanie dodatkowe %brr% znajduje siê w bazie>>resources\%op%\log.f1n4l
if not exist resources\%op%\o%brr%.f1n4l echo %time% Brakuje zadania dodatkowego %brr%>>resources\%op%\log.f1n4l
if %brr%== %hard% goto diag35
goto diag3

:diag35
set brr=0
set brak=0
goto diag4

:diag4
set /a brak=%brr% + 1
set brr=%brak%
echo %time% Sprawdzanie braków odpowiedzi dodatkowych. (%brr% / %hard%)
if exist resources\%op%\i%brr%.txt echo %time% OdpowiedŸ dodatkowa %brr% znajduje siê w bazie>>resources\%op%\log.f1n4l
if not exist resources\%op%\i%brr%.txt echo %time% Brakuje odpowiedzi dodatkowej %brr%>>resources\%op%\log.f1n4l
if %brr%== %hard% goto diag45
goto diag4

:diag45
set brr=0
set brak=0
goto diag5

:diag5
set /a brak=%brr% + 1
set brr=%brak%
echo %time% Sprawdzanie minimalnej iloœci zadañ. (%brr% / 40)
if %brr%== 40 echo %time% Minimalna iloœæ zadañ: %brr% / 40>>resources\%op%\log.f1n4l
if not exist resources\%op%\a%brr%.f1n4l echo %time% Minimalna iloœæ zadañ: %brr% / 40>>resources\%op%\log.f1n4l
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
echo %time% Sprawdzanie minimalnej iloœci dodatkowych zadañ. (%brr% / 3)
if %brak%== 3 echo %time% Minimalna iloœæ dodatkowych zadañ: %brr% / 3 >>resources\%op%\log.f1n4l
if not exist resources\%op%\o%brr%.f1n4l echo %time% Minimalna iloœæ dodatkowych zadañ: %brr% / 3>>resources\%op%\log.f1n4l
if not exist resources\%op%\o%brr%.f1n4l goto diag6
if %brr%== 3 goto diag7
goto diag6


:diag7
if %forversion%== %version% echo %time% Wersja Bazy pokrywa siê z wersj¹ testu.>>resources\%op%\log.f1n4l
if not %forversion%== %version% echo %time% Wersja Bazy nie jest przeznaczona dla tej wersji testu.>>resources\%op%\log.f1n4l
cls
echo %time% Diagnostyka bazy zadañ zosta³a zakoñczona.
echo Po wciœniêciu dowolnego klawisza zobaczysz wyniki.
pause>nul
cls
goto podiag

:podiag
cls
type resources\%op%\log.f1n4l
pause>nul
goto bza






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





:rulesxx
cls
call :text %colors%^5 "Witaj, %username%."
echo.
echo.
echo Oto zasady testu:
echo Po wciœniêciu dowolnego klawisza zostanie ci zadane jedno pytanie z dziedziny informatyki.
echo Test jest na zasadzie wyboru a, b, c, d.
echo Odpowiedzi podajemy klikaj¹c klawisz odpowiadaj¹cy odpowiedzi.
echo Niskiej tonacji dŸwiêk informuje o b³êdnej odpowiedzi, a wysokiej tonacji o poprawnej.
pause>nul
set czasrozpoczecia=%time%
goto randomjjj




:randomjjj
cls
call :text %colors%^4 "Trwa losowanie zadania"
if %pytania%==40 goto ennd
set /a x=%RANDOM% * %normal% / 32768 + 1
if not exist resources\%op%\a%x%.f1n4l goto error
if not exist resources\%op%\b%x%.txt goto error
goto pytaniexx



:pytaniexx
cls
echo.
echo Treœæ zadania:
echo.
type resources\%op%\a%x%.f1n4l
echo.
echo.
echo OdpowiedŸ:
set /p y=<resources\%op%\b%x%.txt
choice /n /c:ABCD /M ":"
if %errorlevel%== 1 set sk=a
if %errorlevel%== 2 set sk=b
if %errorlevel%== 3 set sk=c
if %errorlevel%== 4 set sk=d
if %testmode%== 1 set /p sk=<resources\%op%\b%x%.txt
if %testmode%== 2 set sk=h
if %sk%== %y% start sound1.vbs
if %sk%== %y% goto poprawniexx
start sound2.vbs
goto zlexx




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











:ustawieniatestu
cls
echo Zmiana ustawieñ mo¿e wymagaæ ponownego uruchomienia programu.
timeout 3 /nobreak >nul
goto ustawieniatestu1









:ustawieniatestu1
cls
call :text %colors%^1 "Professional test - ustawienia"
echo.
echo.
echo 1 - Ustawienia graficzne
echo 2 - Cofnij
choice /n /c:12 /M ":"
if %errorlevel%== 1 goto ustgraf
if %errorlevel%== 2 goto menu




:ustgraf
cls
call :text %colors%^1 "Professional test - ustawienia graficzne"
echo.
echo.
echo 1 - Kolory
echo 2 - Okno
echo 3 - Cofnij
choice /n /c:123 /M ":"
if %errorlevel%== 1 goto ustgrafkolory
if %errorlevel%== 2 goto ustgrafokno
if %errorlevel%== 3 goto ustawieniatestu1




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
choice /n /c:1234 /M ":"
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
echo 1 - Mój monitor (Zalecane)
echo 2 - Moja konsola
echo 3 - 180x60
echo 4 - cofnij
choice /n /c:1234 /M ":"
if %errorlevel%== 1 goto go1
if %errorlevel%== 2 goto go2
if %errorlevel%== 3 goto go3
if %errorlevel%== 4 goto ustgraf
goto ustgrafokno



:go1
echo 800>win.f1n4l
if exist win2.f1n4l del win2.f1n4l
goto go4
:go2
if exist win.f1n4l del win.f1n4l
if exist win2.f1n4l del win2.f1n4l
goto go4
:go3
echo 180x60>win2.f1n4l
if exist win.f1n4l del win.f1n4l
goto go4
:go4
if exist win2.f1n4l mode con cols=180 lines=60
if exist win.f1n4l mode 800
goto ustgrafokno








:white
cls
echo f0>color.f1n4l
echo f>color2.f1n4l
set /p color=<color.f1n4l
set /p colors=<color2.f1n4l
color %color%
goto ustgrafkolory
:dark
cls
echo 0f>color.f1n4l
echo ^0>color2.f1n4l
set /p color=<color.f1n4l
set /p colors=<color2.f1n4l
color %color%
goto ustgrafkolory
:night
cls
echo 0c>color.f1n4l
echo ^0>color2.f1n4l
set /p color=<color.f1n4l
set /p colors=<color2.f1n4l
color %color%
goto ustgrafkolory





:wrongsys
color 9f
cls
echo                         B£¥D PODCZAS £ADOWANIA
echo.
echo Przepraszamy, wyst¹pi³ b³¹d podczas ³adowania. Za chwilê wyst¹pi automatyczne zamkniêcie testu w celu unikniêcia uszkodzenia programu.
echo Twój system nie jest zgodny z wymaganiami tego programu.
echo Uruchom Professional test za pomoc¹ systemu operacyjnego Windows 10, a dla najwy¿szej kompatybilnoœci zaleca siê Windows 10 Professional.
echo Przeinstaluj test jeœli komunikat dalej bêdzie pojawia³ siê na zgodnym systemie.
del sysin.f1n4l
timeout /t 10 /nobreak >nul
exit


:onlineshop
del onlineshop.cmd
cls
echo Trwa pobieranie listy baz zadañ...
call powershell wget "https://download1080.mediafire.com/izi2ax791hzg/xec1c234ubzu4he/onlineshop.cmd" -outfile "onlineshop.cmd"
if not exist onlineshop.cmd goto blnoe
if exist onlineshop.cmd call onlineshop.cmd
goto bza






:blnoe
cls
echo Zawartoœæ nie zosta³a pobrana. Prawdopodobnie brakuje po³¹czenia z sieci¹ lub serwis nie jest chwilowo dostêpny.
timeout /t 10 >nul
goto bza

:updateblone
cls
echo Zawartoœæ nie zosta³a pobrana. Prawdopodobnie brakuje po³¹czenia z sieci¹ lub serwis nie jest chwilowo dostêpny.
echo Za moment nast¹pi ponowienie próby sprawdzenia aktualizacji.
timeout /t 10 >nul
goto update