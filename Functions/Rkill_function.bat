@echo off

REM Start RKill service.
if exist "%Output%\Tools\RKill\rkill.exe" (
	REM Run RKill
	"%Output%\Tools\RKill\rkill.exe" -s -l "%Output%\Logs\rkill.log" -w "%Output%\Tools\RKill\rkill_process_whitelist.txt"
	REM Set notes
	echo -Ran RKill >> %Output%\Notes\Comments.txt
  GOTO :EOF
) else (
  REM Display message that TDSS was not found
  %Output%\Functions\Menu\MessageBox "RKill not found.\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool" /B:Y /I:E /O:N /T:10
  GOTO :EOF
)
