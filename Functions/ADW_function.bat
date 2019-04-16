@echo off

::Variables
set "VarADW=0"

::Start ADW service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\ADW\adwcleaner.exe" (
	title [AdwCleaner] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Starting ADW Cleaner
	echo.
	echo =================================
	start "ADW" "%Output%\Tools\ADW\adwcleaner.exe"
	CLS
	:ADW_RUN_LOOP
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running ADW Cleaner
	echo.
	echo =================================
	tasklist | find /i "Adwcleaner.exe" >nul 2>&1
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
  	TIMEOUT 2 >nul 2>&1
  	goto :eof
	) ELSE (
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running ADW Cleaner.
		echo.
		echo =================================
  	TIMEOUT 1 >nul 2>&1
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running ADW Cleaner..
		echo.
		echo =================================
	  TIMEOUT 1 >nul 2>&1
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running ADW Cleaner...
		echo.
		echo =================================
		TIMEOUT 1 >nul 2>&1
		CLS
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
  goto :eof
)
ENDLOCAL DISABLEDELAYEDEXPANSION
CLS
