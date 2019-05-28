@echo off

REM Variables
set LOG_REMNANTS=yes

REM Start DeleteLogs service.
%Output%\Functions\Menu\MessageBox "Deleting known logs/temp files..." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul

REM Scan for known logs/temp files in known directories and delete them if found.
if exist "%userprofile%\desktop\Rkill.txt" (
	REM Delete logs
	del "%userprofile%\desktop\Rkill.txt" >nul
	REM Set variable that shows that logs were deleted
	set LOG_REMNANTS=no
)
if exist "%systemdrive%\Rkill.txt" (
	REM Delete logs
	del "%systemdrive%\Rkill.txt" >nul
	REM Set variable that shows that logs were deleted
	set LOG_REMNANTS=no
)
if exist "%userprofile%\desktop\JRT.txt" (
	REM Delete logs
	del "%userprofile%\desktop\JRT.txt" >nul
	REM Set variable that shows that logs were deleted
	set LOG_REMNANTS=no
)
if exist "%systemdrive%\JRT.txt" (
	REM Delete logs
	del "%systemdrive%\JRT.txt" >nul
	REM Set variable that shows that logs were deleted
	set LOG_REMNANTS=no
)
if exist "%SystemRoot%\logs\cbs\cbs.log" (
	REM Delete logs
	del "%SystemRoot%\logs\cbs\cbs.log" >nul
	REM Set variable that shows that logs were deleted
	set LOG_REMNANTS=no
)
if exist "%systemdrive%\TDSSKiller*" (
	REM Delete logs
	del "%systemdrive%\TDSSKiller*" >nul
	REM Set variable that shows that logs were deleted
	set LOG_REMNANTS=no
)
if exist "%userprofile%\desktop\TDSSKiller*" (
	REM Delete logs
	del "%userprofile%\desktop\TDSSKiller*" >nul
	REM Set variable that shows that logs were deleted
	set LOG_REMNANTS=no
)
if exist "%Output%\Logs" (
	REM Delete logs
	rmdir /s /q "%Output%\Logs" >nul
	REM Set variable that shows that logs were deleted
	set LOG_REMNANTS=no
)

REM Output notes that logs were cleared.
if %LOG_REMNANTS%==no (
	REM Display message that logs were deleted succesfuly
	%Output%\Functions\Menu\MessageBox "Done deleting known logs/temp files!\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 10 seconds" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:I /O:N /T:10 >nul
	REM Add notes that finished
	echo -Deleted known logs/temp files remnants left on drive >> %Output%\Notes\Comments.txt
	GOTO :EOF
) else (
	REM Display message that logs were not found
	%Output%\Functions\Menu\MessageBox "No known logs found!\n\nSkipping...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 10 seconds" "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	REM Add notes that finished
	echo -Skipped deleting known logs/temp files remnants left on drive >> %Output%\Notes\Comments.txt
	GOTO :EOF
)
