@echo off

REM Prevent noobies from testing function before its finished.
if not "%PASSWORD%"=="RedRuby" (
  REM Skip function for now until it is fixed & functioning.
  %Output%\Functions\Menu\MessageBox "Email feature is still experimental and not enebled yet.\n\nWait until I get it tested and fixed.\n\nThanks.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10
  GOTO:EOF
) else (
  REM Continue function for testing purposes
  %Output%\Functions\Menu\MessageBox "Dragons ahead.\n\nHighly experimental option.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10
)

REM Variables
set ACTIVE_SESSION=undetected
set ACTIVE_TOOL=undetected
set NETWORK_AVAILABLE=undetected
set AVALIBLE_COMMENTS=undetected
set AVALIBLE_SMTPMAILSENDER=undetected

  REM Email Variables
REM -config
set EMAIL_CONFIG=%Output%\Tools\SMTPMailSender\config.conf
REM -username
set EMAIL_USERNAME=cleanup@buckeye-express.com
REM -password
set EMAIL_PASSWORD=BuckeyeCleanup999
REM -to
set EMAIL_TO=cleanup@buckeye-express.com
REM -from
set EMAIL_FROM=cleanup@buckeye-express.com
REM -cc
set EMAIL_CC=unidentified
REM -subject
set EMAIL_SUBJECT=unidentified
REM -body
set EMAIL_BODY=unidentified
REM -attachment
set EMAIL_ATTACHMENT=%Output%\Notes\Comments.txt
REM -timeout
set EMAIL_TIMEOUT=100
REM -logfile
set EMAIL_LOG=%Output%\Logs\Email.log

REM Start function minimized
REM if not "%1" == "min" start /MIN cmd /c %0 min & exit/b

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
REM SMTPMAILSENDER STATUS
REM --------------------------

REM Detect if SMTPMAILSENDER is avalible
if exist "%Output%\Tools\SMTPMailSender\SMTPMailSender.exe" (
  set AVALIBLE_SMTPMAILSENDER=yes
) else (
  set AVALIBLE_SMTPMAILSENDER=no
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
echo AVALIBLE_SMTPMAILSENDER
echo %AVALIBLE_SMTPMAILSENDER%
echo ABRUPTCLOSE
echo %ABRUPTCLOSE%
pause

REM %Output%\Tools\SMTPMailSender\SMTPMailSender.exe -username %EMAIL_USERNAME% -password %EMAIL_PASSWORD% -to %EMAIL_TO% -from %EMAIL_FROM% -subject %EMAIL_SUBJECT% -attachment %EMAIL_ATTACHMENT% -timeout %EMAIL_TIMEOUT% -logfile %EMAIL_LOG% -send
%Output%\Tools\SMTPMailSender\SMTPMailSender.exe -config %EMAIL_CONFIG% -to %EMAIL_TO% -subject %EMAIL_SUBJECT% -attachment %EMAIL_ATTACHMENT% -timeout %EMAIL_TIMEOUT% -logfile %EMAIL_LOG% -send
pause
GOTO:EOF


IF "%ACTIVE_SESSION%"=="no" (




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
