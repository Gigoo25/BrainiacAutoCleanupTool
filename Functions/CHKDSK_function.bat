@echo off

REM Check if chkdsk is found if not error out
if exist "%SystemRoot%\System32\chkdsk.exe" (
	REM Display starting message
	%Output%\Functions\Menu\MessageBox "Starting Check Disk\n\nThis will check Windows System Files for corruptions..." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	REM Start function
	%SystemRoot%\System32\chkdsk.exe %SystemDrive%
	REM If errors found then schedule a fix on reboot
	if /i not %ERRORLEVEL%==0 (
		%Output%\Functions\Menu\MessageBox "Errors found on %SystemDrive%\n\nScheduling full chkdsk at next reboot.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:10 >nul
		REM Set notes
		echo -Ran CHKDSK errors were found >> %Output%\Notes\Comments.txt
		REM Set drive as "dirty"
		fsutil dirty set %SystemDrive%
		REM Set notes
		echo -Scheduled a fix for next reboot >> %Output%\Notes\Comments.txt
		REM Finish
		GOTO :EOF
	) else (
		REM Display that no errors were found
		%Output%\Functions\Menu\MessageBox "No errors found on %SystemDrive%\n\nSkipping full chkdsk at next reboot.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:10 >nul
		REM Set notes
		echo -Ran CHKDSK and no error were found >> %Output%\Notes\Comments.txt
		REM Finish
		GOTO :EOF
	)
) else (
	REM Display not found error message
	%Output%\Functions\Menu\MessageBox "Check disk was not found!\n\nThis is a big problem as it is stored in your root directory.\n\n There may be something catastrophically wrong with your machine or the cleanup tool is just coded poorly.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	REM Finish
	GOTO :EOF
)
