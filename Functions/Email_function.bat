@echo off

REM Variables
set ACTIVE_SESSION=undetected
set ACTIVE_TOOL=undetected
set NETWORK_AVAILABLE=undetected
set AVALIBLE_COMMENTS=undetected
set AVALIBLE_SWITHMAIL=undetected

REM Start function minimized
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b

REM --------------------------
REM ABRUPTCLOSE STATUS
REM --------------------------

REM Detect if BrainiacsAutoCleanupTool was abruptly closed
if exist "%Output%\Functions\Variables\ABRUPTCLOSE.txt" (
  set /p ABRUPTCLOSE=<%Output%\Functions\Variables\ABRUPTCLOSE.txt
)

REM --------------------------
REM TOOL STATUS
REM --------------------------

REM Detect if BrainiacsAutoCleanupTool is running
:Check_Tool_Active
tasklist.exe /v  | find /i "%PID_BRAINIACS%" >NUL
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

REM Detect if LogMeIn is running & currently connected to a session
:Check_Session_Active
REM DEBUG FOR POSSIBLE PROCESS NAMES -- tasklist | find /i "LMI_Rescue_srv.exe" >nul
REM DEBUG FOR POSSIBLE PROCESS NAMES -- tasklist | find /i "CallingCard_srv.exe" >nul
tasklist | find /i "LMI_RescueRC.exe" >nul
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

REM --------------------------
REM EMAIL SEND
REM --------------------------

echo ACTIVE_SESSION
echo %ACTIVE_SESSION%
echo ACTIVE_TOOL
echo %ACTIVE_TOOL%
echo NETWORK_AVAILABLE
echo %NETWORK_AVAILABLE%
echo AVALIBLE_COMMENTS
echo %AVALIBLE_COMMENTS%
echo AVALIBLE_SWITHMAIL
echo %AVALIBLE_SWITHMAIL%
echo ABRUPTCLOSE
echo %ABRUPTCLOSE%
pause

IF "%ACTIVE_SESSION%"=="no" (
  IF "%AVALIBLE_SWITHMAIL%"=="no" (
    IF "%AVALIBLE_COMMENTS%"=="no" (

    )
  )
)

IF "%ACTIVE_TOOL%"=="no" (

)

IF "%NETWORK_AVAILABLE%"=="no" (

)



:::::::::::::: Lets set some variables ::::::::::::::
set eMail=cleanup@buckeye-express.com
set subj=-s "Test Blat"
set server=-server mail.buckeye-express.com
set x=-x "X-Header-Test: Can Blat do it? Yes it Can!"
set debug=-debug -log blat.log -timestamp
set port=-port 465
set usr=-u cleanup@buckeye-express.com
set pass=-pw BuckeyeCleanup999
::::::::::::::::: Now we run Blat!  :::::::::::::::::
blat %0 -to %eMail% -f %eMail% %subj% %server% %port% %usr% %pass% %debug% %x%
pause





IF "%NETWORK_AVAILABLE%"=="yes" (
  IF "%ACTIVE_SESSION%"=="no" (
    IF "%AVALIBLE_COMMENTS%"=="yes" (
      IF "%ACTIVE_SESSION%"=="no" (
        start "SwithMail" "%Output%\Tools\SwithMail\SwithMail.exe" /s /from "cleanup@buckeye-express.com" /name "AutoCleanupTool" /pass "BuckeyeCleanup999" /server "mail.buckeye-express.com" /p "465" /SSL /to "test@bex.net" /sub "Account Cleanup Tool Notes"
        SwithMail.exe /test /from "cleanup@buckeye-express.com" /name "AutoCleanupTool" /pass "BuckeyeCleanup999" /server "mail.buckeye-express.com" /p "465" /SSL /to "test@bex.net" /sub "Account Cleanup Tool Notes"
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
    ) ELSE IF "%AVALIBLE_COMMENTS%"=="no" (
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
  ) ELSE IF "%ACTIVE_SESSION%"=="no" (

  )
) ELSE IF "%NETWORK_AVAILABLE%"=="no" (

)

REM --------------------------
REM SELF-DESTRUCT
REM --------------------------

(goto) 2>nul & del "%~f0"

REM --------------------------
REM EXIT
REM --------------------------
