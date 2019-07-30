@echo off

REM Variables
set VarRougueKiller=0
set Rogue_Infections=unidentified

REM Start RogueKiller service.
	REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\RogueKiller\RogueKillerCMD_portable*" (
	REM Run quick scan
	if "%ROGUE_QUICKSCAN%"=="Yes" (
		REM Run appropriate version
		if %OS%==32BIT (
			start /WAIT "[Rogue Killer] Brainiacs Cleanup Tool v%TOOL_VERSION%" /MAX "%Output%\Tools\RogueKiller\RogueKillerCMD_portable32.exe" -quickscan -no_interact -debuglog "%Output%\Logs\rogue.log"
		) else (
			start /WAIT "[Rogue Killer] Brainiacs Cleanup Tool v%TOOL_VERSION%" /MAX "%Output%\Tools\RogueKiller\RogueKillerCMD_portable64.exe" -quickscan -no_interact -debuglog "%Output%\Logs\rogue.log"
		)
		REM Set notes
		echo -Ran RougueKiller quickscan >> %Output%\Notes\Comments.txt
	)
	REM Run full scan
	if "%ROGUE_QUICKSCAN%"=="No" (
		if %OS%==32BIT (
			start /WAIT "[Rogue Killer] Brainiacs Cleanup Tool v%TOOL_VERSION%" /MAX "%Output%\Tools\RogueKiller\RogueKillerCMD_portable32.exe" -scan -no_interact -debuglog "%Output%\Logs\rogue.log"
		) else (
			start /WAIT "[Rogue Killer] Brainiacs Cleanup Tool v%TOOL_VERSION%" /MAX "%Output%\Tools\RogueKiller\RogueKillerCMD_portable64.exe" -scan -no_interact -debuglog "%Output%\Logs\rogue.log"
		)
		REM Set notes
		echo -Ran RougueKiller fullscan >> %Output%\Notes\Comments.txt
	)
	REM Ask for amount of infections found & set notes
	FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the amount of infections found:" "[INFECTIONS] Rogue Killer" /H:150 /W:280 /M:"####" /F:"\d{0,4}" /U /I`) DO (
		REM Set variable
		set Rogue_Infections=%%G
	)
	REM Set comments based on variable
	IF NOT "!Rogue_Infections!"=="unidentified" (
		REM Set notes
		echo Infections-"!Rogue_Infections!" >> "%Output%\Notes\Comments.txt"
	) else (
		REM Set notes
		echo No infections found. >> "%Output%\Notes\Comments.txt"
	)
	GOTO :EOF
) else (
  REM Display message that TDSS was not found
  %Output%\Functions\Menu\MessageBox "RogueKiller not found.\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool" /B:Y /I:E /O:N /T:10
  GOTO :EOF
)
	REM Disable delayed expansion
ENDLOCAL DISABLEDELAYEDEXPANSION
