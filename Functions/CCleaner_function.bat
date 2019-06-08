@echo off

REM Start CCleaner service.
REM Check if already installed and run if it is, if not run portable version.
if exist "%systemdrive%\Program Files\CCleaner\CCleaner.exe" (
	REM Display message that CCleaner is installed & run
	%Output%\Functions\Menu\MessageBox "Starting CCleaner temp files cleanup.\n\nThis may take a while." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	REM Run appropriate version of ccleaner temp file scan
	if %OS%==32BIT "%systemdrive%\Program Files\CCleaner\CCleaner.exe" /AUTO
	if %OS%==64BIT "%systemdrive%\Program Files\CCleaner\CCleaner64.exe" /AUTO
	REM Add notes that finished
	echo -Ran CCleaner temp file cleanup >> %Output%\Notes\Comments.txt
	REM Display message that CCleaner is installed & run
	%Output%\Functions\Menu\MessageBox "Done\u0021\n\nOpening CCleaner registry cleanup." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	if %OS%==32BIT "%systemdrive%\Program Files\CCleaner\CCleaner.exe" /REGISTRY
	if %OS%==64BIT "%systemdrive%\Program Files\CCleaner\CCleaner64.exe" /REGISTRY
	REM Add notes that finished
	echo -Ran CCleaner registry cleanup >> %Output%\Notes\Comments.txt
	GOTO :EOF
)
if exist "%systemdrive%\Program Files (x86)\CCleaner\CCleaner.exe" (
	REM Display message that CCleaner is installed & run
	%Output%\Functions\Menu\MessageBox "Starting CCleaner temp files cleanup.\n\nThis may take a while." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	REM Run appropriate version of ccleaner temp file scan
	if %OS%==32BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner.exe" /AUTO
	if %OS%==64BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner64.exe" /AUTO
	REM Add notes that finished
	echo -Ran CCleaner temp file cleanup >> %Output%\Notes\Comments.txt
	REM Display message that CCleaner is installed & run
	%Output%\Functions\Menu\MessageBox "Done\u0021\n\nOpening CCleaner registry cleanup." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	REM Run appropriate version of ccleaner temp file scan
	if %OS%==32BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner.exe" /REGISTRY
	if %OS%==64BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner64.exe" /REGISTRY
	REM Add notes that finished
	echo -Ran CCleaner registry cleanup >> %Output%\Notes\Comments.txt
	GOTO :EOF
)
if exist "%Output%\Tools\CCleaner\CCleane*" (
	REM Display message that CCleaner is not installed & run portable version
	%Output%\Functions\Menu\MessageBox "Starting portable CCleaner temp files cleanup.\n\nThis may take a while." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	REM Run appropriate version of portable ccleaner temp file scan
	if %OS%==32BIT "%Output%\Tools\CCleaner\CCleaner.exe" /AUTO
	if %OS%==64BIT "%Output%\Tools\CCleaner\CCleaner64.exe" /AUTO
	REM Add notes that finished
	echo -Ran CCleaner temp file cleanup >> %Output%\Notes\Comments.txt
	REM Display message that CCleaner is not installed & run portable version
	%Output%\Functions\Menu\MessageBox "Done\u0021\n\nOpening portable CCleaner registry cleanup." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	REM Run appropriate version of ccleaner temp file scan
	if %OS%==32BIT "%Output%\Tools\CCleaner\CCleaner.exe" /REGISTRY
	if %OS%==64BIT "%Output%\Tools\CCleaner\CCleaner64.exe" /REGISTRY
	REM Add notes that finished
	echo -Ran CCleaner registry cleanup >> %Output%\Notes\Comments.txt
	GOTO :EOF
) else (
	REM Display message that CCleaner was not found
	%Output%\Functions\Menu\MessageBox "CCleaner was not found!\n\nSkipping...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 10 seconds" "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
)
