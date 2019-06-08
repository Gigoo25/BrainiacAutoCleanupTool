@echo off

REM Variables
set VarZemana=0
set Zemana_Infections=unidentified

REM Start Zemana service.
	REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION
if %WIN_VER_NUM% geq 6.1 (
	if exist "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe" (
		start /WAIT "ZMN" "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe" /scan SmartScan /clean
		REM Set notes
		echo -Ran Zemana >> %Output%\Notes\Comments.txt
		REM Ask for amount of infections found & set notes
		FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the amount of infections found:" "[INFECTIONS] Zemana" /H:150 /W:280 /M:"####" /F:"\d{0,4}" /U /I`) DO (
			REM Set variable
			set Zemana_Infections=%%G
		)
		REM Set comments based on variable
		IF NOT "!Zemana_Infections!"=="unidentified" (
		  echo Infections-"!Zemana_Infections!" >> "%Output%\Notes\Comments.txt"
		) else (
			echo No infections found. >> "%Output%\Notes\Comments.txt"
		)
  	GOTO :EOF
	) else (
		REM Display message that tool was not found.
		%Output%\Functions\Menu\MessageBox "Zemana not found.\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool" /B:O /I:E /O:N /T:10
  	GOTO :EOF
	)
) else (
	REM Display message that tool does not support windows version.
	%Output%\Functions\Menu\MessageBox "Zemana does not support "%WIN_VER%" "%OS%". Skipping. The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool" /B:O /I:E /O:N /T:10
	GOTO :EOF
)
REM Disable delayed expansion
ENDLOCAL DISABLEDELAYEDEXPANSION
