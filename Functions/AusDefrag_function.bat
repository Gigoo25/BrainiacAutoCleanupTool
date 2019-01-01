@echo off

::Start AusDefrag service.
CLS
if exist "%Output%\Tools\AUS\ausdiskdefrag.exe" (
	title [AusDefrag] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running AusDefrag...
	start /WAIT "AUS" "%Output%\Tools\AUS\ausdiskdefrag.exe"
	echo -Ran AusDefrag >> %Output%\Notes\Comments.txt
	CLS
	echo Done running AusDefrag!
  	TIMEOUT 2 >nul 2>&1
  	GOTO eof
) else (
	echo AusDefrag not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 5 seconds.
	TIMEOUT 5 >NUL 2>&1
	goto eof
)
:eof
CLS