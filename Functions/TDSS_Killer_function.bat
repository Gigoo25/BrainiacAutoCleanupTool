@echo off

::Variables
set VarTDSSKiller=0

::Start TDSS Killer service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\TDSS\TDSSKiller.exe" (
	title [TDSS Killer] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running TDSS Killer...
	start /WAIT "TDS" "%Output%\Tools\TDSS\TDSSKiller.exe" -l "%Output%\Logs\tdsskiller.log" -accepteula -accepteulaksn
	CLS
	:TDSSKILLER_RUN_LOOP
	CLS
	tasklist | find /i "TDSSKiller.exe" >nul 2>&1
	IF ERRORLEVEL 1 (
		echo -Ran TDSS Killer >> %Output%\Notes\Comments.txt
		set /p VarTDSSKiller=Enter the amount of infections found:
		echo Infections-!!VarTDSSKiller!! >> %Output%\Notes\Comments.txt
		CLS
		echo Done running TDSS Killer!
  		TIMEOUT 2 >nul 2>&1
  		GOTO eof
	) ELSE (
		echo Running TDSS Killer...
  		TIMEOUT 3 >nul 2>&1
  		GOTO TDSSKILLER_RUN_LOOP
	)
) else (
	echo TDSS Killer not found.
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