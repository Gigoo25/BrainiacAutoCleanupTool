@echo off

REM Variables
set Defrag_On_Boot=undetected
set Defrag_On_Boot_Counter=0

REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION

REM Determine if it was ran from boot folder
if "%cd%"=="%SystemDrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" (
  set Defrag_On_Boot=Yes
)

REM Run function according to how it was ran
if "%Defrag_On_Boot%"=="Yes" (
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
REM Set title
title [Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%
REM Start defrag
start /WAIT "[Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%" %SystemRoot%\system32\defrag.exe "%SystemDrive%" /O /V /H /U
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
