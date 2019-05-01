@echo off

REM Start function minimized
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b

REM Internet connection status
set NETWORK_AVAILABLE=undetected

REM Detect network connection. We assume it's available unless we actively detect it isn't
:Check_Internet
FOR /F "usebackq tokens=1" %%A IN (`ping www.google.com -n 2 -w 1000`) DO (
  REM Check the current line for the indication of a successful connection.
  IF /I "%%A"=="Reply" (
    SET NETWORK_AVAILABLE=yes
  ) else (
    SET NETWORK_AVAILABLE=no
  )
)

REM If no internet was found then loop back to check for internet
IF "%NETWORK_AVAILABLE%"=="no" (
  TIMEOUT 10 >nul
  GOTO Check_Internet
)

REM Check for notes if avalible
if exist "%Output%\Notes\Comments.txt" (

)
