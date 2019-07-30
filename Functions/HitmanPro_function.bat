@echo off

REM Variables
set VarHitman=0
set HMP_Infections=unidentified

REM Start HitmanPro service.
	REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\HitmanPro\HitmanPro*" (
	REM Delete old license if found
	if exist "%systemdrive%\ProgramData\HitmanPro" (
		rmdir /s /q "%systemdrive%\ProgramData\HitmanPro" >nul
	)
	REM Start HMP
	if %OS%==32BIT start /WAIT "HMP" "%Output%\Tools\HitmanPro\HitmanPro.exe" /noupload /noinstall /scan
	if %OS%==64BIT start /WAIT "HMP" "%Output%\Tools\HitmanPro\HitmanPro_x64.exe" /noupload /noinstall /scan
	REM Delete old license if found
	if exist "%systemdrive%\ProgramData\HitmanPro" (
		rmdir /s /q "%systemdrive%\ProgramData\HitmanPro" >nul
	)
	REM Set notes
	echo -Ran HitmanPro >> %Output%\Notes\Comments.txt
	REM Ask for amount of infections found & set notes
	FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the amount of infections found:" "[INFECTIONS] Hitman Pro" /H:150 /W:280 /M:"####" /F:"\d{0,4}" /U /I`) DO (
		REM Set variable
		set HMP_Infections=%%G
	)
	REM Set comments based on variable
	IF NOT "!HMP_Infections!"=="unidentified" (
		echo Infections-"!HMP_Infections!" >> "%Output%\Notes\Comments.txt"
	) else (
		echo No infections found. >> "%Output%\Notes\Comments.txt"
	)
  GOTO :EOF
) else (
	REM Display message that tool was not found.
	%Output%\Functions\Menu\MessageBox "HitmanPro not found.\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool" /B:O /I:E /O:N /T:10
)
REM Disable delayed expansion
ENDLOCAL DISABLEDELAYEDEXPANSION
