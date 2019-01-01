@echo off

::Open Comments service.
CLS
if exist "%Output%\Notes\Comments.txt" (
	title [Comments] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Opening Comments...
	start "notepad" /wait notepad "%Output%\Notes\Comments.txt"
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