@echo off

::Start Windows Image Check service.
CLS
echo Starting Windows Image Check...
TIMEOUT 3 >nul 2>&1
CLS
title [Windows Image Check] Brainiacs Cleanup Tool v%TOOL_VERSION%
if %WIN_VER_NUM% geq 6.2 (
	echo Checking Windows image for corruptions...
	echo.
	::Start function
	dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%SystemRoot%\Windows_Image_Check.txt"
	::Create notes
	echo -Checked Windows image for coruptions >> %Output%\Notes\Comments.txt
	CLS
	echo Done checking windows system files!
	echo Placed log file at %SystemRoot%\Windows_Image_Check.txt
	pause
  	goto :eof
) else (
	echo Skipping...
	echo.
	echo Windows Image Check does not support "%WIN_VER%".
	echo.
   	echo Continuing in 10 seconds.
	TIMEOUT 10 >NUL 2>&1
  	goto :eof
	)
:eof
CLS