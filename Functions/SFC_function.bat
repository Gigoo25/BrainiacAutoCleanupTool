@echo off

::Start System File Checker (SFC) service.
CLS
echo Starting System File Checker (SFC)...
TIMEOUT 3 >nul 2>&1
CLS
::Start function
if exist "%SystemRoot%\System32\sfc.exe" (
	title [SFC] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Checking System Files for corruptions...
	TIMEOUT 1 >nul 2>&1
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
		TIMEOUT 10 >NUL 2>&1
		goto eof
	)
) else (
	echo SFC not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 10 seconds.
	TIMEOUT 10 >NUL 2>&1
	goto eof
)
:eof
CLS