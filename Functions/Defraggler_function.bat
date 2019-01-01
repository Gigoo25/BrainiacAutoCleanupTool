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
	echo Defraggler not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 5 seconds.
	TIMEOUT 5 >NUL 2>&1
	goto eof
)
:eof
CLS