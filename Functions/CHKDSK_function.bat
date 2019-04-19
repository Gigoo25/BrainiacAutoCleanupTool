@echo off

REM Set title
title [CHKDSK] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start CHKDSK service.
CLS
echo.
echo  ^! ALERT
echo ==========================
echo.
echo   Starting Check Disk...
echo.
echo ==========================
TIMEOUT 3 >nul
CLS
echo.
echo  ^! ALERT
echo ====================================================
echo.
echo   Checking Windows System Files for corruptions...
echo.
echo ====================================================

REM Start function
%SystemRoot%\System32\chkdsk.exe %SystemDrive%

REM If errors found then schedule a fix on reboot
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
	GOTO :EOF
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
	GOTO :EOF
)
