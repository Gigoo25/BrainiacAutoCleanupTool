@echo off

REM Set title
title [RKill] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start RKill service.
if exist "%Output%\Tools\RKill\rkill.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running RKill...
	echo.
	echo   This may take a while.
	echo.
	echo =================================
	"%Output%\Tools\RKill\rkill.exe" -s -l "%Output%\Logs\rkill.log" -w "%Output%\Tools\RKill\rkill_process_whitelist.txt"
	echo -Ran RKill >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running RKill!
	echo.
	echo =================================
  TIMEOUT 2 >nul
  GOTO :EOF
) else (
  color 0c
	CLS
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    RKill not found.
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
