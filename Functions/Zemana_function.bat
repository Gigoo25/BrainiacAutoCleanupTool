@echo off

REM Variables
set "VarZemana=0"

REM Set title
title [Zemana] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start Zemana service.
SETLOCAL ENABLEDELAYEDEXPANSION
if %WIN_VER_NUM% geq 6.1 (
	if exist "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe" (
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Running Zemana...
		echo.
		echo =================================
		start /WAIT "ZMN" "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe" /scan SmartScan /clean
		echo -Ran Zemana >> %Output%\Notes\Comments.txt
		CLS
		echo.
		echo  ^! USER INPUT
		echo =================================
		echo.
		set /p VarZemana=Enter the amount of infections found:
		echo Infections-!!VarZemana!! >> %Output%\Notes\Comments.txt
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Done running Zemana!
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
  	echo    Zemana not found.
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
) else (
	color 0c
	CLS
	echo.
	echo  ^! ERROR
	echo ======================================
	echo.
	echo    Zemana does not support "%WIN_VER%".
	echo.
	echo    Skipping...
	echo.
	echo ======================================
	TIMEOUT 10
	color 07
	GOTO :EOF
)
ENDLOCAL DISABLEDELAYEDEXPANSION
