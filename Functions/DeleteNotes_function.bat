@echo off

REM Delete Comments service.
if exist "%Output%\Notes\Comments.txt" (
  REM Display deletion of notes message
  %Output%\Functions\Menu\MessageBox  "Deleting Notes..." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
  REM Delete notes
	rmdir /s /q "%Output%\Notes" >nul
  GOTO :EOF
) else (
	REM Display message that notes were not found
	%Output%\Functions\Menu\MessageBox "Notes not found!\n\nSkipping...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 10 seconds" "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	GOTO :EOF
)
