@echo off

REM Variables
set VarADW=0

REM Start ADW service.
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\ADW\adwcleaner.exe" (
	REM Display start message.
	%Output%\Functions\Menu\MessageBox "Starting ADW Cleaner..." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	REM Start ADW & loop
	start "ADW" "%Output%\Tools\ADW\adwcleaner.exe"
	:ADW_RUN_LOOP
	CLS
	tasklist | find /i "Adwcleaner.exe" >nul
	IF ERRORLEVEL 1 (
		echo -Ran ADWCleaner >> %Output%\Notes\Comments.txt
		REM Ask for number of infections & add to notes
		FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the amount of infections found:" "[INF #] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280 /M:">00" /R:"[\d0-9]{10}" /F:"[\d0-9]{0,10}" /U /I`) DO (
		  echo Infections-"%%G" >> "%Output%\Notes\Comments.txt"
		)
  	GOTO :EOF
	) ELSE (
  	TIMEOUT 3 >nul
  	GOTO ADW_RUN_LOOP
	)
) else (
	REM Display message that ADW was not found & skip
	%Output%\Functions\Menu\MessageBox "Adw Cleaner not found.\n\nSkipping...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
  GOTO :EOF
)
ENDLOCAL DISABLEDELAYEDEXPANSION
