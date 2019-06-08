@echo off

REM Variables
set VarTDSSKiller=0
set TDSS_Infections=unidentified

REM Start TDSS Killer service.
	REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\TDSS\TDSSKiller.exe" (
  REM Start TDSSKiller
  start "TDS" "%Output%\Tools\TDSS\TDSSKiller.exe" -l "%Output%\Logs\tdsskiller.log" -accepteula
  REM Start running loop
  :TDSSKILLER_RUN_LOOP
  tasklist | find /i "TDSSKiller.exe" >nul
  IF ERRORLEVEL 1 (
		REM Set notes
    echo -Ran TDSS Killer >> %Output%\Notes\Comments.txt
    REM Ask for amount of infections found & set notes
    FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the amount of infections found:" "[INFECTIONS] TDSS Killer" /H:150 /W:280 /M:"####" /F:"\d{0,4}" /U /I`) DO (
      REM Set variable
      set TDSS_Infections=%%G
    )
    REM Set comments based on variable
    IF NOT "!TDSS_Infections!"=="unidentified" (
  		REM Set notes
      echo Infections-"!TDSS_Infections!" >> "%Output%\Notes\Comments.txt"
    ) else (
  		REM Set notes
      echo No infections found. >> "%Output%\Notes\Comments.txt"
    )
    GOTO :EOF
	) ELSE (
    REM Restart loop if TDSS is still open
  	GOTO TDSSKILLER_RUN_LOOP
	)
) else (
  REM Display message that TDSS was not found
  %Output%\Functions\Menu\MessageBox "TDSS Killer not found.\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool" /B:Y /I:E /O:N /T:10
  GOTO :EOF
)
	REM Disable delayed expansion
ENDLOCAL DISABLEDELAYEDEXPANSION
