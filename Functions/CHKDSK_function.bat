@echo off

::Start CHKDSK service.
CLS
echo Starting Check Disk...
TIMEOUT 3 >nul 2>&1
CLS
title [CHKDSK] Brainiacs Cleanup Tool v%TOOL_VERSION%
echo Checking Windows System Files for corruptions...
echo.
::Start function
%SystemRoot%\System32\chkdsk.exe %SystemDrive%
::If errors found then schedule a fix on reboot
if /i not %ERRORLEVEL%==0 (
	CLS
    color 0c
    echo.
    echo  ^! WARNING
    echo ===================================================================================
    echo.
    echo    Errors found on %SystemDrive%
    echo.
    echo    Scheduling full chkdsk at next reboot.
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
    echo.
    echo ===================================================================================
    TIMEOUT 10
	echo -Ran CHKDSK errors were found >> %Output%\Notes\Comments.txt
	echo -Scheduled a fix for next reboot >> %Output%\Notes\Comments.txt
	fsutil dirty set %SystemDrive%
    color 07
	goto eof
) else (
	CLS
    color 0c
    echo.
    echo  ^! WARNING
    echo ===================================================================================
    echo.
    echo    No errors found on %SystemDrive%
    echo.
    echo    Skipping full chkdsk at next reboot.
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
    echo.
    echo ===================================================================================
    TIMEOUT 10
	echo -Ran CHKDSK and no error were found >> %Output%\Notes\Comments.txt
    color 07
	goto eof
)
:eof
CLS