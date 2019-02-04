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
	CLS
    color 0c
    echo.
    echo  ^! ERROR
    echo ===================================================================================
    echo.
    echo    AusDefrag not found.
    echo.
    echo    Skipping...
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
    echo.
    echo ===================================================================================
    TIMEOUT 10
    color 07
	goto eof
)
:eof
CLS