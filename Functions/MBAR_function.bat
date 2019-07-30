@echo off

REM Variables
set VarMBAR=0
set MBAR_Infections=unidentified

REM Start MBAR service.
	REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\MBAR\mbar.exe" (
	REM Start MBAR
	start /WAIT "MBAR" "%Output%\Tools\MBAR\mbar.exe"
	REM Set notes
	echo -Ran MBAR >> %Output%\Notes\Comments.txt
	REM Ask for amount of infections found & set notes
	FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the amount of infections found:" "[INFECTIONS] MBAR" /H:150 /W:280 /M:"####" /F:"\d{0,4}" /U /I`) DO (
		REM Set variable
		set MBAR_Infections=%%G
	)
	REM Set comments based on variable
	IF NOT "!MBAR_Infections!"=="unidentified" (
		echo Infections-"!MBAR_Infections!" >> "%Output%\Notes\Comments.txt"
	) else (
		echo No infections found. >> "%Output%\Notes\Comments.txt"
	)
	GOTO :EOF
) else (
	REM Display message that tool was not found.
	%Output%\Functions\Menu\MessageBox "MBAR not found.\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool" /B:O /I:E /O:N /T:10
)
REM Disable delayed expansion
ENDLOCAL DISABLEDELAYEDEXPANSION
