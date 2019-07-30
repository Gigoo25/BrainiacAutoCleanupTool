@echo off

REM Variables
set Defrag_On_Boot=undetected
set Defrag_On_Boot_Counter=0

REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION

REM Determine if it was ran from boot folder
if "%cd%"=="%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" (
  set Defrag_On_Boot=Yes
)

REM Run function according to how it was ran
if "%Defrag_On_Boot%"=="Yes" (
  goto Start_Defrag_On_Boot
)
if "%DEFRAG_EXTERNAL%"=="Yes" (
  goto Start_External_Defrag
)
if "%DEFRAG_EXTERNAL%"=="No" (
  goto Start_Internal_Defrag
)

REM Start defrag externally
:Start_External_Defrag
REM Start Minimized
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b
REM Start Defrag
start /WAIT "[Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%" %SystemRoot%\system32\defrag.exe "%SystemDrive%" /V /H /U
if /i !ERRORLEVEL!==0 (
  REM Add succesful defrag notes
  echo -Defragged and Optimized all drives >> %Output%\Notes\Comments.txt
  REM Display message showing defrag was successful
  %Output%\Functions\Menu\MessageBox "Defrag was successful.\n\nDefrag will close in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N
  exit /b
) else (
  REM Display message showing defrag was un-successful
  %Output%\Functions\Menu\MessageBox "Defrag was un-successful.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N /T:10
  exit /b
)

REM Start defrag Intenally
:Start_Internal_Defrag
  REM Display message showing internal defrag is being run
%Output%\Functions\Menu\MessageBox "Click 'OK' to run defrag/optimization on all drives." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N
REM Start Defrag
start /WAIT "[Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%" /MAX %SystemRoot%\system32\defrag.exe "%SystemDrive%" /V /H /U
if /i !ERRORLEVEL!==0 (
  REM Add succesful defrag notes
  echo -Defragged and Optimized all drives >> %Output%\Notes\Comments.txt
  REM Display message showing defrag was successful
  %Output%\Functions\Menu\MessageBox "Defrag was successful.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N /T:10
	GOTO :EOF
) else (
  REM Display message showing defrag was un-successful
  %Output%\Functions\Menu\MessageBox "Defrag was un-successful.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N /T:10
  GOTO :EOF
)

REM Start defrag on boot
:Start_Defrag_On_Boot

REM Run as admin
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%ERRORLEVEL%' == '0' ( goto gotPrivileges ) ELSE ( goto getPrivileges )
:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B
:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

REM Set title
title [Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%
pause
REM Start defrag
start /WAIT "[Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%" %SystemRoot%\system32\defrag.exe "%SystemDrive%" /V /H /U
pause
if /i !ERRORLEVEL!==0 (
  CLS
  echo.
  echo  ^! ALERT
  echo ============================
  echo.
  echo    Defrag complete!
  echo.
  echo    Press any key to quit.
  echo.
  echo ============================
  REM Self delete if ran after boot/any other circumstance
  (goto) 2>nul & del "%~f0"
  GOTO :EOF
) else (
  REM Loop to Defrag_On_Boot_Loop to try again
  CLS
  REM Set color
  color 0c
  REM Check for more than 3 tries then quit
  if %Defrag_On_Boot_Counter%==3 (
    CLS
    REM Set color
    color 0c
    echo.
    echo  ^! ERROR
    echo ==============================================================================
    echo.
    echo    Windows defrag failed 3 times!
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will close and self-destruct in 15 seconds.
    echo.
    echo ==============================================================================
    TIMEOUT 15
    REM Set color
    color 07
    REM Self delete if defrag failed to run after 3 consecutive tries
    (goto) 2>nul & del "%~f0"
    GOTO :EOF
  ) else (
    echo.
    echo  ^! ERROR
    echo ==============================================================================
    echo.
    echo    Windows defrag failed!
    echo.
    REM Display correct amount of times
    if %Defrag_On_Boot_Counter%==0 (
      echo    Will try to defrag 3 more times before quitting.
    )
    if %Defrag_On_Boot_Counter%==1 (
    echo    Will try to defrag 2 more times before quitting.
    )
    if %Defrag_On_Boot_Counter%==2 (
    echo    Will try to defrag 1 more time before quitting.
    )
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will try again in 15 seconds.
    echo.
    echo ==============================================================================
    TIMEOUT 15
    REM Set color
    color 07
    REM Set counter for amount of tries
    if %Defrag_On_Boot_Counter%==0 set Defrag_On_Boot_Counter=1
    if %Defrag_On_Boot_Counter%==1 set Defrag_On_Boot_Counter=2
    if %Defrag_On_Boot_Counter%==2 set Defrag_On_Boot_Counter=3
    REM Re-try to run defrag
    goto :Start_Defrag_On_Boot
  )
)

REM Disable delayed expansion
ENDLOCAL DISABLEDELAYEDEXPANSION
