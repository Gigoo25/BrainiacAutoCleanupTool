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
::Create notes
echo -Checked Windows Drive for corruptions >> %Output%\Notes\Comments.txt
::If errors found then schedule a fix on reboot
if /i not %ERRORLEVEL%==0 (
	CLS
	echo Errors found on %SystemDrive%
	echo.
	echo Scheduling full chkdsk at next reboot.
	echo.
    echo Continuing in 10 seconds.
	TIMEOUT 10 >NUL 2>&1
	echo -Ran CHKDSK errors were found
	echo -Scheduled a fix for next reboot >> %Output%\Notes\Comments.txt
	fsutil dirty set %SystemDrive%
  	goto :eof
) else (
	CLS
	echo No errors found on %SystemDrive%
	echo.
	echo Skipping full chkdsk at next reboot.
	echo.
    echo Continuing in 10 seconds.
	TIMEOUT 10 >NUL 2>&1
	echo -Ran CHKDSK and no error were found >> %Output%\Notes\Comments.txt
  	goto :eof
)
:eof
CLS