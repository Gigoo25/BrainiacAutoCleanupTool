@echo off

REM Variables
set VarRougueKiller=0
set RougueKiller_Exists=undetected

REM Set title
title [RogueKiller] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Check if roguekiller is avalible before executing
if exist "%Output%\Tools\RogueKiller\RogueKillerCMD_portable32.exe" (
	set RougueKiller_Exists=Yes
) else if exist "%Output%\Tools\RogueKiller\RogueKillerCMD_portable64.exe" (
	set RougueKiller_Exists=Yes
)

REM Start RogueKiller service.
SETLOCAL ENABLEDELAYEDEXPANSION
if "%RougueKiller_Exists%"=="Yes" (
	if "%ROGUE_QUICKSCAN%"=="Yes" (
		CLS
		echo.
		echo  ^! ALERT
		echo =======================================
		echo.
		echo   Starting RougueKiller Quick scan...
		echo.
		echo =======================================
	  TIMEOUT 2 >nul
		CLS
		if %OS%==32BIT (
			"%Output%\Tools\RogueKiller\RogueKillerCMD_portable32.exe" -quickscan -no_interact -debuglog "%Output%\Logs\rogue.log"
		) else (
			"%Output%\Tools\RogueKiller\RogueKillerCMD_portable64.exe" -quickscan -no_interact -debuglog "%Output%\Logs\rogue.log"
		)
	) else (
		CLS
		echo.
		echo  ^! ALERT
		echo ======================================
		echo.
		echo   Starting RougueKiller Full scan...
		echo.
		echo ======================================
	  TIMEOUT 2 >nul
		CLS
		if %OS%==32BIT (
			"%Output%\Tools\RogueKiller\RogueKillerCMD_portable32.exe" -scan -no_interact -debuglog "%Output%\Logs\rogue.log"
		) else (
			"%Output%\Tools\RogueKiller\RogueKillerCMD_portable64.exe" -scan -no_interact -debuglog "%Output%\Logs\rogue.log"
		)
	)
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
