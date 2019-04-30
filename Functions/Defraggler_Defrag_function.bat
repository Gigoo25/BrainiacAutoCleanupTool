@echo off

REM Set title
title [Defraggler] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start Defraggler service.
if exist "%Output%\Tools\Defraggle*" (
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running Defraggler...
	echo.
	echo =================================
	if %OS%==32BIT start /WAIT "DFR" "%Output%\Tools\Defraggler\Defraggler.exe"
	if %OS%==64BIT start /WAIT "DFR" "%Output%\Tools\Defraggler\Defraggler64.exe"
	echo -Ran Defraggler >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running Defraggler!
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
  echo    Defraggler not found.
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
