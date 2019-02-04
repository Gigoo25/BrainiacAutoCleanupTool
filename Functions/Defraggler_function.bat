@echo off

::Start Defraggler service.
CLS
if exist "%Output%\Tools\Defraggle*" (
	title [Defraggler] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running Defraggler...
	if %OS%==32BIT start /WAIT "DFR" "%Output%\Tools\Defraggler\Defraggler.exe"
	if %OS%==64BIT start /WAIT "DFR" "%Output%\Tools\Defraggler\Defraggler64.exe"
	echo -Ran Defraggler >> %Output%\Notes\Comments.txt
	CLS
	echo Done running Defraggler!
  	TIMEOUT 2 >nul 2>&1
  	GOTO eof
) else (
	CLS
    color 0c
    echo.
    echo  ^! ERROR
    echo ===================================================================================
    echo.
    echo    Defraggler not found.
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