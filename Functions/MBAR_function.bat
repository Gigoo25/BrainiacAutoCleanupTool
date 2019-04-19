@echo off

REM Variables
set "VarMBAR=0"

REM Set title
title [MBAR] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start MBAR service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\MBAR\mbar.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running MBAR...
	echo.
	echo   This may take a while.
	echo.
	echo =================================
	start /WAIT "MBAR" "%Output%\Tools\MBAR\mbar.exe"
	CLS
	echo -Ran MBAR >> %Output%\Notes\Comments.txt
	echo.
	echo  ^! USER INPUT
	echo =================================
	echo.
	set /p VarMBAR=Enter the amount of infections found:
	echo Infections-!!VarMBAR!! >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running MBAR!
	echo.
	echo =================================
  TIMEOUT 2 >nul
	GOTO :EOF
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    MBAR not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 10
  color 07
  GOTO :EOF
)
ENDLOCAL DISABLEDELAYEDEXPANSION
