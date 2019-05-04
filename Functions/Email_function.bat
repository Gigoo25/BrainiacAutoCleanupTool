@echo off

REM Variables
set ACTIVE_SESSION=undetected
set ACTIVE_TOOL=undetected
set NETWORK_AVAILABLE=undetected
set AVALIBLE_COMMENTS=undetected
set AVALIBLE_SWITHMAIL=undetected
set ABRUPTCLOSE=undetected

REM Start function minimized
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b

REM --------------------------
REM ABRUPTCLOSE STATUS
REM --------------------------

REM Detect if BrainiacsAutoCleanupTool was abruptly closed
if exist "%Output%\Functions\Variables\ABRUPTCLOSE.txt" (
    set /p ABRUPTCLOSE=<!Output!\Functions\Variables\ABRUPTCLOSE.txt
)

REM --------------------------
REM TOOL STATUS
REM --------------------------

REM Detect if BrainiacsAutoCleanupTool is running
:Check_Tool_Active
tasklist.exe /v  | find /i "%PID_Brainiacs%" >NUL
IF NOT ERRORLEVEL 1 (
  SET ACTIVE_TOOL=yes
) else (
  SET ACTIVE_TOOL=no
)

REM --------------------------
REM INTERNET STATUS
REM --------------------------

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

REM --------------------------
REM SESSION STATUS
REM --------------------------

REM Detect if LogMeIn is running
:Check_Session_Active
tasklist | find /i "" >nul
IF NOT ERRORLEVEL 1 (
  set ACTIVE_SESSION=yes
) else (
  set ACTIVE_SESSION=no
)

REM --------------------------
REM SWITHMAIL STATUS
REM --------------------------

REM Detect if SWITHMAIL is avalible
if exist "%Output%\Tools\SwithMail\SwithMail.exe" (
  set AVALIBLE_SWITHMAIL=yes
) else (
  set AVALIBLE_SWITHMAIL=no
)

REM --------------------------
REM NOTES STATUS
REM --------------------------

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

REM --------------------------
REM EMAIL SEND
REM --------------------------

IF "%NETWORK_AVAILABLE%"=="yes" (
  IF "%ACTIVE_SESSION%"=="no" (
    IF "%AVALIBLE_COMMENTS%"=="yes" (
      IF "%ACTIVE_SESSION%"=="no" (
        start "SwithMail" "%Output%\Tools\SwithMail\SwithMail.exe" /s /from "cleanup@buckeye-express.com" /name "AutoCleanupTool" /pass "BuckeyeCleanup999" /server "mail.buckeye-express.com" /p "465" /SSL /to "test@bex.net" /sub "Account Cleanup Tool Notes"
        if "%ERRORLEVEL%"=="0" (
          CLS
          echo.
          echo  ^! ALERT
          echo ===================================
          echo.
          echo   Sent email report successfully!
          echo.
          echo   Continuing in 3 seconds.
          echo.
          echo ===================================
          TIMEOUT 3 >nul
        )
        if "%ERRORLEVEL%"=="1" (
  	       CLS
           color 0c
           echo.
           echo  ^! ERROR
           echo =====================================================================
           echo.
           echo    Failed sending email report!
           echo.
           echo    Going back in 10 seconds to check for internet connection again.
           echo.
           echo =====================================================================
           TIMEOUT 10
           color 07
           goto Check_Internet
        )
      )
    )
  )
)

REM --------------------------
REM SELF-DESTRUCT
REM --------------------------

(goto) 2>nul & del "%~f0"

REM --------------------------
REM EXIT
REM --------------------------
