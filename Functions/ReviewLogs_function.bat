@echo off

REM Set title
title [Reviewing Logs] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start ReviewLogs service.
if exist "%Output%\Logs\rkill.log" (
	REM Set title
	title [Rkill Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	CLS
	echo.
	echo  ^! ALERT
	echo ========================
	echo.
	echo   Opening Rkill log...
	echo.
	echo ========================
	TIMEOUT 2 >nul
	CLS
	type %Output%\Logs\rkill.log
	pause
) else (
	CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    Rkill log not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
if exist "%Output%\Logs\rogue.log" (
	REM Set title
	title [RogueKiller Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	CLS
	echo.
	echo  ^! ALERT
	echo ==============================
	echo.
	echo   Opening RogueKiller log...
	echo.
	echo ==============================
	TIMEOUT 2 >nul
	CLS
	type %Output%\Logs\rogue.log
	pause
) else (
  color 0c
	CLS
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    RogueKiller log not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
	CLS
)
if exist "%HOMEDRIVE%\AdwCleaner\Logs" (
	REM Set title
	title [AdwCleaner Folder] Brainiacs Cleanup Tool v%TOOL_VERSION%
	CLS
	echo.
	echo  ^! ALERT
	echo ================================
	echo.
	echo   Opening AdwCleaner folder...
	echo.
	echo ================================
	TIMEOUT 2 >nul
	CLS
	START "AdwCleanerLog" "%SystemRoot%\explorer.exe" "%HOMEDRIVE%\AdwCleaner\Logs"
	pause
) else (
  color 0c
	CLS
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    AdwCleaner log not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
if exist "%Output%\Logs\tdsskiller.log" (
	REM Set title
	title [TDSKiller Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	CLS
	echo.
	echo  ^! ALERT
	echo ============================
	echo.
	echo   Opening TDSKiller log...
	echo.
	echo ============================
	TIMEOUT 2 >nul
	CLS
	type %Output%\Logs\tdsskiller.log
	pause
) else (
  color 0c
	CLS
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    TDSSkiller log not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
if exist "%Output%\Logs\JRT.txt" (
	REM Set title
	title [JRT Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	CLS
	echo.
	echo  ^! ALERT
	echo ======================
	echo.
	echo   Opening JRT log...
	echo.
	echo ======================
	TIMEOUT 2 >nul
	CLS
	type %Output%\Logs\JRT.txt
	pause
) else (
  color 0c
	CLS
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    JRT log not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
if exist "%SystemRoot%\Windows_Image_Check.txt" (
	REM Set title
	title [Windows Image Check Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	CLS
	echo.
	echo  ^! ALERT
	echo ======================================
	echo.
	echo   Opening Windows Image Check log...
	echo.
	echo ======================================
	TIMEOUT 2 >nul
	CLS
	type %SystemRoot%\Windows_Image_Check.txt
	pause
) else (
  color 0c
	CLS
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    Windows Image Check log not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
if exist "%SystemRoot%\logs\cbs\cbs.log" (
	REM Set title
	title [SFC Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	CLS
	echo.
	echo  ^! ALERT
	echo ======================================
	echo.
	echo   Opening System File Checker log...
	echo.
	echo ======================================
	TIMEOUT 2 >nul
	CLS
	type %SystemRoot%\logs\cbs\cbs.log
	pause
) else (
  color 0c
	CLS
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    System File Checker log not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
