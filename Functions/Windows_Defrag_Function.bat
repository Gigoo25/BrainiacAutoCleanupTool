@echo off

REM Skip if internally ran
if "%Defrag_Internal%"=="Yes" (
    goto Start_Internal_Defrag
) else if "%Defrag_External%"=="Yes" (
    goto Start_Internal_Defrag
)

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

REM Start Defrag
:Start_Internal_Defrag
CLS
title [External Defrag] Brainiacs Cleanup Tool
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
start /WAIT "defrag" defrag "%SystemDrive%" /O /V /H /U
REM Add defrag notes
echo -Defragged & Optimized main drive >> %Output%\Notes\Comments.txt
if /i !ERRORLEVEL!==0 (
  echo.
  echo  ^! ALERT
  echo ===========================================
  echo.
  echo    Defrag complete!
  echo.
  echo    Press any key to continue the cleanup.
  echo.
  echo ===========================================
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
if "%Defrag_External%"=="Yes" (
  REM Exit if ran internally
  exit
) else if "%Defrag_Internal%"=="Yes" (
  REM Continue if ran internally
  GOTO :EOF
) else (
  REM Self delete if ran after boot/any other circumstance
  (goto) 2>nul & del "%~f0"
)