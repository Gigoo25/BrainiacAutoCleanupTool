@echo off

::Start ReviewLogs service.
CLS
title [Reviewing Logs] Brainiacs Cleanup Tool v%TOOL_VERSION%
if exist "%Output%\Logs\rkill.log" (
	title [Rkill Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening Rkill log...
	TIMEOUT 2 >nul 2>&1
	CLS
	type %Output%\Logs\rkill.log
	pause
	CLS
) else (
	echo Rkill log not found.
	echo.
	echo Skipping...
	echo.
   	echo Continuing in 3 seconds.
	TIMEOUT 3 >NUL 2>&1
	CLS
)
if exist "%Output%\Logs\rogue.log" (
	title [RogueKiller Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening RogueKiller log...
	TIMEOUT 2 >nul 2>&1
	CLS
	type %Output%\Logs\rogue.log
	pause
	CLS
) else (
	echo RogueKiller log not found.
	echo.
	echo Skipping...
	echo.
   	echo Continuing in 3 seconds.
	TIMEOUT 3 >NUL 2>&1
	CLS
)
if exist "%HOMEDRIVE%\AdwCleaner\Logs" (
	title [AdwCleaner Folder] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening AdwCleaner folder...
	TIMEOUT 2 >nul 2>&1
	CLS
	START "AdwCleanerLog" "%SystemRoot%\explorer.exe" "%HOMEDRIVE%\AdwCleaner\Logs"
	pause
	CLS
) else (
	echo AdwCleaner log not found.
	echo.
	echo Skipping...
	echo.
   	echo Continuing in 3 seconds.
	TIMEOUT 3 >NUL 2>&1
	CLS
)
if exist "%Output%\Logs\tdsskiller.log" (
	title [TDSKiller Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening TDSKiller log...
	TIMEOUT 2 >nul 2>&1
	CLS
	type %Output%\Logs\tdsskiller.log
	pause
	CLS
) else (
	echo TDSSkiller log not found.
	echo.
	echo Skipping...
	echo.
   	echo Continuing in 3 seconds.
	TIMEOUT 3 >NUL 2>&1
	CLS
)
if exist "%Output%\Logs\JRT.txt" (
	title [JRT Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening JRT log...
	TIMEOUT 2 >nul 2>&1
	CLS
	type %Output%\Logs\JRT.txt
	pause
	CLS
) else (
	echo JRT log not found.
	echo.
	echo Skipping...
	echo.
   	echo Continuing in 3 seconds.
	TIMEOUT 3 >NUL 2>&1
	CLS
)
if exist "%SystemRoot%\Windows_Image_Check.txt" (
	title [Windows Image Check Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening Windows Image Check log...
	TIMEOUT 2 >nul 2>&1
	CLS
	type %SystemRoot%\Windows_Image_Check.txt
	pause
	CLS
) else (
	echo Windows Image Check log not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 3 seconds.
	TIMEOUT 3 >NUL 2>&1
	CLS
)
if exist "%SystemRoot%\Windows_Image_Check.txt" (
	title [Windows Image Check Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening Windows Image Check log...
	TIMEOUT 2 >nul 2>&1
	CLS
	type %SystemRoot%\Windows_Image_Check.txt
	pause
	CLS
) else (
	echo Windows Image Check log not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 3 seconds.
	TIMEOUT 3 >NUL 2>&1
	CLS
)
if exist "%SystemRoot%\logs\cbs\cbs.log" (
	title [SFC Log] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening System File Checker log...
	TIMEOUT 2 >nul 2>&1
	CLS
	type %SystemRoot%\logs\cbs\cbs.log
	pause
	CLS
) else (
	echo System File Checker log not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 3 seconds.
	TIMEOUT 3 >NUL 2>&1
	CLS
)
:eof
CLS