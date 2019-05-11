@echo off

REM Variables
set Defrag_Boot=unidentified

REM Determine how the function was ran
if "%Defrag_Internal%"=="Yes" (
    goto Start_Internal_Defrag
) else if "%Defrag_External%"=="Yes" (
    goto Start_External_Defrag
) else (
    if exist "%SystemDrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Windows_Defrag_Function.bat" (
      set Defrag_Boot=Yes
    )
    goto Start_External_Defrag
)

REM Start Defrag Intenally
:Start_External_Defrag

REM Run as admin
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

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

REM Start Defrag Intenally
:Start_Internal_Defrag

REM Start Defrag function
CLS
if "%Defrag_Internal%"=="Yes" (
  title [Internal Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%
) else (
  title [External Defrag] Brainiacs Cleanup Tool v%TOOL_VERSION%
)
echo.
echo  ^! ALERT
echo ==============================================================
echo.
echo    Defrag waiting to begin.
echo.
echo    Press any key to begin defrag/optimization on all drives.
echo.
echo ==============================================================
pause
CLS
if "%Defrag_Internal%"=="Yes" (
  defrag "%SystemDrive%" /O /V /H /U
  if /i !ERRORLEVEL!==0 (
    echo.
    echo.
    echo  ^! ALERT
    echo ===========================================
    echo.
    echo    Defrag complete!
    echo.
    echo    Press any key to continue the cleanup.
    echo.
    echo ===========================================
    REM Add defrag notes
    echo -Defragged and Optimized main drive >> %Output%\Notes\Comments.txt
    pause
  ) else (
    REM Set Color
    color 0c
    CLS
    echo.
    echo  ^! ERROR
    echo ============================================================================
    echo.
    echo    Windows defrag failed!
    echo.
    echo    Skipping...
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
    echo.
    echo ============================================================================
    TIMEOUT 10
    color 07
  	GOTO :EOF
  )
) else (
  REM Create loop point if ran from boot
  :Defrag_Boot_Loop
  start /WAIT "defrag" defrag "%SystemDrive%" /O /V /H /U
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
    pause
  ) else (
    if "%Defrag_Boot%"=="Yes" (
      REM Loop to Defrag_Boot_Loop to try again
      REM Set Color
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
      set Defrag_Boot=No
      goto Defrag_Boot_Loop
    )
    REM Set Color
    color 0c
    CLS
    echo.
    echo  ^! ERROR
    echo ============================================================================
    echo.
    echo    Windows defrag failed!
    echo.
    echo    Skipping...
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will quit in 10 seconds.
    echo.
    echo ============================================================================
    TIMEOUT 10
    color 07
  	GOTO :EOF
  )
)

REM Complete function + determine what to do based off of how the function was ran
if "%Defrag_External%"=="Yes" (
    REM Exit if ran externally
    exit
) else if "%Defrag_Internal%"=="Yes" (
    REM Continue if ran internally
    GOTO :EOF
) else if "%Defrag_Boot%"=="Yes" (
    REM Self delete if ran after boot/any other circumstance
    (goto) 2>nul & del "%~f0"
)
