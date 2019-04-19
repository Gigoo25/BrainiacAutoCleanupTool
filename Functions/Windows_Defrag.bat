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
echo ===================================================================================
echo.
echo    Defrag waiting to begin.
echo.
echo    Press any key to begin defrag/optimization on all drives.
echo.
echo ===================================================================================
pause
CLS
defrag C: /O /V /H
pause
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
