@echo off

REM Check for missing comments
if /i "!SAFE_MODE!"=="yes" (
    GOTO :EOF
)

REM Open Comments service.
if exist "%Output%\Notes\Comments.txt" (
  REM Display message that tool will be opening notes
  %Output%\Functions\Menu\MessageBox "Opening comments.\n\nPlease copy these into 'LogMeIn'" "[ALERT] Brainiacs Cleanup Tool" /B:Y /I:A /O:N /T:10
  REM Open notes
	start "notepad" /wait notepad "%Output%\Notes\Comments.txt"
  GOTO :EOF
) else (
  REM Display message that notes were not found
  %Output%\Functions\Menu\MessageBox "Comments not found.\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool" /B:Y /I:E /O:N /T:10
  GOTO :EOF
  set SKIP_COMMENTS=yes
)
