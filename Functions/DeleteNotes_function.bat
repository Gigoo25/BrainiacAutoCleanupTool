@echo off

::Delete Comments service.
CLS
if exist "%Output%\Notes\Comments.txt" (
	title [Deleting Comments] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Deleting Notes...
	rmdir /s /q "%Output%\Notes" >NUL 2>&1
	TIMEOUT 1 >nul 2>&1
	CLS
  	GOTO eof
) else (
	echo Comments not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 5 seconds.
	TIMEOUT 5 >NUL 2>&1
	goto eof
)
:eof
CLS