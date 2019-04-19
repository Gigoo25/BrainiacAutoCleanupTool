@echo off

REM Variables
set "VarRougueKiller=0"

REM Set title
title [RogueKiller] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start RogueKiller service.
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\RogueKiller\RogueKillerCMD.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Starting RougueKiller...
	echo.
	echo =================================
  TIMEOUT 2 >nul
	CLS
	"%Output%\Tools\RogueKiller\RogueKillerCMD.exe" -scan -debuglog "%Output%\Logs\rogue.log"
	echo -Ran RougueKiller >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! USER INPUT
	echo =================================
	echo.
	set /p VarRougueKiller=Enter the amount of infections found:
	echo Infections-!!VarRougueKiller!! >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running RougueKiller!
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
  echo    RogueKiller not found.
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
