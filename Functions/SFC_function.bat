@echo off

REM Set title
title [SFC] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start System File Checker (SFC) service.
CLS
echo.
echo  ^! ALERT
echo =================================
echo.
echo   Starting System File Checker (SFC)...
echo.
echo =================================
TIMEOUT 3 >nul
CLS
REM Start function
if exist "%SystemRoot%\System32\sfc.exe" (
	echo Checking System Files for corruptions...
	TIMEOUT 1 >nul
	echo.
	if %WIN_VER_NUM% geq 6.0 (
		%SystemRoot%\System32\sfc.exe /scannow
		%SystemRoot%\System32\findstr.exe /c:"[SR]" %SystemRoot%\logs\cbs\cbs.log
		echo -Checked Windows System Files for corruptions >> %Output%\Notes\Comments.txt
	) else (
		echo SFC does not support "%WIN_VER%".
		echo.
		echo Skipping...
		echo.
    	echo Continuing in 10 seconds.
		TIMEOUT 10 >nul
		GOTO :EOF
	)
) else (
	echo SFC not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 10 seconds.
	TIMEOUT 10 >nul
	GOTO :EOF
)
:eof
CLS
