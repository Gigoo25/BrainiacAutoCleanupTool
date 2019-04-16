@echo off

::Variables
set "VarTDSSKiller=0"

::Start TDSS Killer service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\TDSS\TDSSKiller.exe" (
  title [TDSS Killer] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running TDSS Killer
	echo.
	echo =================================
  start "TDS" "%Output%\Tools\TDSS\TDSSKiller.exe" -l "%Output%\Logs\tdsskiller.log" -accepteula
  CLS
  :TDSSKILLER_RUN_LOOP
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running TDSS Killer
	echo.
	echo =================================
  tasklist | find /i "TDSSKiller.exe" >nul 2>&1
  IF ERRORLEVEL 1 (
    CLS
    echo -Ran TDSS Killer >> %Output%\Notes\Comments.txt
		echo.
		echo  ^! USER INPUT
		echo =================================
		echo.
    set /p VarTDSSKiller=Enter the amount of infections found:
		echo Infections-!!VarTDSSKiller!! >> %Output%\Notes\Comments.txt
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Done running TDSS Killer!
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
		echo   Running TDSS Killer.
		echo.
		echo =================================
  	TIMEOUT 1 >nul 2>&1
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running TDSS Killer..
		echo.
		echo =================================
	  TIMEOUT 1 >nul 2>&1
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running TDSS Killer...
		echo.
		echo =================================
		TIMEOUT 1 >nul 2>&1
		CLS
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
ENDLOCAL DISABLEDELAYEDEXPANSION
CLS
