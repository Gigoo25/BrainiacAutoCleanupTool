@echo off

REM Variables
set VarADW=0

REM Set title
title [AdwCleaner] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start ADW service.
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\ADW\adwcleaner.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Starting ADW Cleaner
	echo.
	echo =================================
	start "ADW" "%Output%\Tools\ADW\adwcleaner.exe"
	:ADW_RUN_LOOP
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running ADW Cleaner
	echo.
	echo =================================
	tasklist | find /i "Adwcleaner.exe" >nul
	IF ERRORLEVEL 1 (
		CLS
		echo -Ran ADWCleaner >> %Output%\Notes\Comments.txt
		echo.
		echo  ^! USER INPUT
		echo =================================
		echo.
		set /p VarADW=Enter the amount of infections found:
		echo Infections-!!VarADW!! >> %Output%\Notes\Comments.txt
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Done running ADWCleaner!
		echo.
		echo =================================
  	TIMEOUT 2 >nul
  	GOTO :EOF
	) ELSE (
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running ADW Cleaner.
		echo.
		echo =================================
  	TIMEOUT 1 >nul
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running ADW Cleaner..
		echo.
		echo =================================
	  TIMEOUT 1 >nul
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running ADW Cleaner...
		echo.
		echo =================================
		TIMEOUT 1 >nul
  	GOTO ADW_RUN_LOOP
	)
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Adw Cleaner not found.
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
