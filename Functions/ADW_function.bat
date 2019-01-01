@echo off

::Start ADW service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\ADW\adwcleaner.exe" (
	title [AdwCleaner] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running ADW Cleaner...
	start /WAIT "ADW" "%Output%\Tools\ADW\adwcleaner.exe"
	TIMEOUT 2 >nul 2>&1
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
	echo Adw Cleaner not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 5 seconds.
	TIMEOUT 5 >NUL 2>&1
	goto eof
)
:eof
ENDLOCAL DISABLEDELAYEDEXPANSION
CLS