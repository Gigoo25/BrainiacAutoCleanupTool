@echo off

REM Variables
set "VarTDSSKiller=0"

REM Set title
title [TDSS Killer] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start TDSS Killer service.
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\TDSS\TDSSKiller.exe" (
  CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running TDSS Killer
	echo.
	echo =================================
  start "TDS" "%Output%\Tools\TDSS\TDSSKiller.exe" -l "%Output%\Logs\tdsskiller.log" -accepteula
  :TDSSKILLER_RUN_LOOP
  CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running TDSS Killer
	echo.
	echo =================================
  tasklist | find /i "TDSSKiller.exe" >nul
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
  	TIMEOUT 2 >nul
    GOTO :EOF
	) ELSE (
    CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running TDSS Killer.
		echo.
		echo =================================
  	TIMEOUT 1 >nul
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running TDSS Killer..
		echo.
		echo =================================
	  TIMEOUT 1 >nul
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running TDSS Killer...
		echo.
		echo =================================
		TIMEOUT 1 >nul
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
  GOTO :EOF
)
ENDLOCAL DISABLEDELAYEDEXPANSION
