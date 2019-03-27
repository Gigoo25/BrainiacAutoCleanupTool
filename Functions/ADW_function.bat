@echo off

::Variables
set "VarADW=0"

::Start ADW service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\ADW\adwcleaner.exe" (
	title [AdwCleaner] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running ADW Cleaner...
	start /WAIT "ADW" "%Output%\Tools\ADW\adwcleaner.exe"
	CLS
	:ADW_RUN_LOOP
	CLS
	tasklist | find /i "ADW.exe" >nul 2>&1
	IF ERRORLEVEL 1 (
		echo -Ran ADWCleaner >> %Output%\Notes\Comments.txt
		set /p VarADW=Enter the amount of infections found:
		echo Infections-!!VarADW!! >> %Output%\Notes\Comments.txt
		CLS
		echo Done running ADWCleaner!
  	TIMEOUT 2 >nul 2>&1
  	GOTO eof
	) ELSE (
		echo Running ADWCleaner...
  	TIMEOUT 3 >nul 2>&1
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
	goto eof
)
:eof
ENDLOCAL DISABLEDELAYEDEXPANSION
CLS
