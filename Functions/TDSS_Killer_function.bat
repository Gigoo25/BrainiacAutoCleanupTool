@echo off

::Variables
set "VarTDSSKiller=0"

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
    TIMEOUT 1 >nul 2>&1
  	GOTO TDSSKILLER_RUN_LOOP
	)
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    TDSS Killer not found.
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
:eof
ENDLOCAL DISABLEDELAYEDEXPANSION
CLS
