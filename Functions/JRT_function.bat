@echo off

REM Variables
set VarJRT=0
set JRT_Infections=unidentified

REM Start JRT service.
	REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\JRT\JRT.exe" (
	REM Start JRT
	start /WAIT "JRT" "%Output%\Tools\JRT\JRT.exe"
	REM Set notes
	echo -Ran JRT >> %Output%\Notes\Comments.txt
	REM Ask for amount of infections found & set notes
	FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the amount of infections found:" "[INFECTIONS] Junkware Removal Tool" /H:150 /W:280 /M:"####" /F:"\d{0,4}" /U /I`) DO (
		REM Set variable
		set JRT_Infections=%%G
	)
	REM Set comments based on variable
	IF NOT "!JRT_Infections!"=="unidentified" (
		echo Infections-"!JRT_Infections!" >> "%Output%\Notes\Comments.txt"
	) else (
		echo No infections found. >> "%Output%\Notes\Comments.txt"
	)
	REM Move log file to local log directory
	if exist "%userprofile%\desktop\JRT.txt" (
		move %userprofile%\desktop\JRT.txt %Output%\Logs\JRT.txt >nul
	)
	GOTO :EOF
) else (
	REM Display message that tool was not found.
	%Output%\Functions\Menu\MessageBox "JRT not found.\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool" /B:O /I:E /O:N /T:10
	GOTO :EOF
)
REM Disable delayed expansion
ENDLOCAL DISABLEDELAYEDEXPANSION
