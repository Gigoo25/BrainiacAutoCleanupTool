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
	CLS
    color 0c
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
	title [AdwCleaner Folder] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening AdwCleaner folder...
	TIMEOUT 2 >nul 2>&1
	CLS
	START "AdwCleanerLog" "%SystemRoot%\explorer.exe" "%HOMEDRIVE%\AdwCleaner\Logs"
	pause
	CLS
) else (
	CLS
    color 0c
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
	CLS
    color 0c
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
	CLS
    color 0c
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
	CLS
    color 0c
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
	CLS
    color 0c
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
	CLS
)
:eof
CLS