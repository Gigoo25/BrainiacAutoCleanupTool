@echo off

REM Start Defraggler service.
if exist "%Output%\Tools\Defraggle*" (
	REM Display message that CCleaner is installed & run
	%Output%\Functions\Menu\MessageBox "Starting Defraggler." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	REM Run appropriate version of defraggler
	if %OS%==32BIT start /WAIT "DFR" "%Output%\Tools\Defraggler\Defraggler.exe"
	if %OS%==64BIT start /WAIT "DFR" "%Output%\Tools\Defraggler\Defraggler64.exe"
	REM Add notes that finished
	echo -Ran Defraggler >> %Output%\Notes\Comments.txt
  GOTO :EOF
) else (
	REM Display message that Defraggler was not found
	%Output%\Functions\Menu\MessageBox "Defraggler was not found!\n\nSkipping...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 10 seconds" "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	GOTO :EOF
)
