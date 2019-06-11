@echo off

REM Variables
set Defrag_On_Boot=unidentified

REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION

REM Determine how the function was ran
if exist "%SystemDrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Windows_Defrag_Function.bat" (
  set Defrag_On_Boot=Yes
  goto Start_Defrag_On_Boot
)
if "%Defrag_External%"=="Yes" (
    goto Start_External_Defrag
)
if "%Defrag_External%"=="No" (
    goto Start_Internal_Defrag
)

REM Start defrag externally
:Start_External_Defrag
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b

REM Start defrag Intenally
:Start_Internal_Defrag

REM Start defrag function
  REM Display message showing internal defrag is being run
%Output%\Functions\Menu\MessageBox "Click 'OK' to run defrag/optimization on all drives." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N
if "%Defrag_External%"=="No" (
  start /WAIT "[Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%" /MAX %SystemRoot%\system32\defrag.exe "%SystemDrive%" /O /V /H /U
) else (
  start "[Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%" %SystemRoot%\system32\defrag.exe "%SystemDrive%" /O /V /H /U
)
if /i !ERRORLEVEL!==0 (
  REM Add succesful defrag notes
  echo -Defragged and Optimized all drives >> %Output%\Notes\Comments.txt
  if "%Defrag_External%"=="No" (
    REM Display message showing defrag was successful
    %Output%\Functions\Menu\MessageBox "Defrag was successful.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N /T:10
	  GOTO :EOF
  ) else (
    REM Display message showing defrag was successful
    %Output%\Functions\Menu\MessageBox "Defrag was successful.\n\nDefrag will close in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N
    exit /b
  )
) else (
  if "%Defrag_External%"=="No" (
  REM Display message showing defrag was un-successful
  %Output%\Functions\Menu\MessageBox "Defrag was un-successful.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N /T:10
  GOTO :EOF
  )
)

REM Start defrag on boot
:Start_Defrag_On_Boot
start /WAIT "[Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%" %SystemRoot%\system32\defrag.exe "%SystemDrive%" /O /V /H /U
if /i !ERRORLEVEL!==0 (
  echo.
  echo  ^! ALERT
  echo ===========================
  echo.
  echo    Defrag complete!
  echo.
  echo    Press any key to quit.
  echo.
  echo ===========================
  REM Self delete if ran after boot/any other circumstance
  (goto) 2>nul & del "%~f0"
  GOTO :EOF
) else (
  REM Loop to Defrag_On_Boot_Loop to try again
  color 0c
  CLS
  echo.
  echo  ^! ERROR
  echo =============================================================================
  echo.
  echo    Windows defrag failed!
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will try again in 15 seconds.
  echo.
  echo =============================================================================
  TIMEOUT 15
  color 07
  set Defrag_On_Boot=No
  goto :Start_Defrag_On_Boot
)

REM Disable delayed expansion
ENDLOCAL DISABLEDELAYEDEXPANSION
