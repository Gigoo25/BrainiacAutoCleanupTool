@echo off

REM Variables
set "VarJRT=0"

REM Set title
title [JRT] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start JRT service.
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\JRT\JRT.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running JRT...
	echo.
	echo =================================
	start /WAIT "JRT" "%Output%\Tools\JRT\JRT.exe"
	CLS
	echo -Ran JRT >> %Output%\Notes\Comments.txt
	echo.
	echo  ^! USER INPUT
	echo =================================
	echo.
	set /p VarJRT=Enter the amount of infections found:
	echo Infections-!!VarJRT!! >> %Output%\Notes\Comments.txt
	REM Move log file
	if exist "%userprofile%\desktop\JRT.txt" (
		move %userprofile%\desktop\JRT.txt %Output%\Logs\JRT.txt >nul
	)
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running JRT!
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
  echo    JRT not found.
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
