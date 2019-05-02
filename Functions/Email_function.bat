@echo off

REM Start function minimized
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b

REM --------------------------
REM TOOL STATUS
REM --------------------------


REM BrainiacsAutoCleanupTool status
set ACTIVE_TOOL=undetected

REM Detect if BrainiacsAutoCleanupTool is running, if it is continue to loop until it is not
:Check_Tool_Active
tasklist | find /i "" >nul
IF NOT ERRORLEVEL 1 (
  SET ACTIVE_TOOL=yes
) else (
  SET ACTIVE_TOOL=no
)

REM If tool is active then loop back to check for tool
IF "%ACTIVE_TOOL%"=="yes" (
  TIMEOUT 10 >nul
  GOTO Check_Tool_Active
)

REM --------------------------
REM INTERNET STATUS
REM --------------------------


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

REM --------------------------
REM SESSION STATUS
REM --------------------------


REM Session status
set ACTIVE_SESSION=undetected

REM Detect if LogMeIn is running, if it is continue to loop until it is not
:Check_Session_Active
tasklist | find /i "" >nul
IF NOT ERRORLEVEL 1 (
  set ACTIVE_SESSION=yes
) else (
  set ACTIVE_SESSION=no
)

REM If session is active then loop back to check for session
IF "%ACTIVE_SESSION%"=="yes" (
  TIMEOUT 10 >nul
  GOTO Check_Session_Active
)

REM --------------------------
REM NOTES STATUS
REM --------------------------


REM Session status
set AVALIBLE_COMMENTS=undetected

REM Check for notes if avalible
if exist "%Output%\Notes\Comments.txt" (
  set AVALIBLE_COMMENTS=yes
) else (
  set AVALIBLE_COMMENTS=no
)

REM If notes are avalible then continue, if not error out + exit
IF "%AVALIBLE_COMMENTS%"=="no" (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===========================
  echo.
  echo    Comments not found.
  echo.
  echo    Exiting in 10 seconds.
  echo.
  echo ===========================
  TIMEOUT 10
  color 07
  GOTO :EOF
)
