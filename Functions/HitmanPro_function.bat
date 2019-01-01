@echo off

::Start HitmanPro service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\HitmanPro\HitmanPro*" (
	title [HitmanPro] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running HitmanPro...
	if exist "%systemdrive%\ProgramData\HitmanPro" (
		rmdir /s /q "%systemdrive%\ProgramData\HitmanPro" >nul 2>&1
	)
	TIMEOUT 1 >nul 2>&1
	if %OS%==32BIT start /WAIT "HMP" "%Output%\Tools\HitmanPro\HitmanPro.exe" /noupload /noinstall /scan
	if %OS%==64BIT start /WAIT "HMP" "%Output%\Tools\HitmanPro\HitmanPro_x64.exe" /noupload /noinstall /scan
	TIMEOUT 1 >nul 2>&1
	if exist "%systemdrive%\ProgramData\HitmanPro" (
		rmdir /s /q "%systemdrive%\ProgramData\HitmanPro" >nul 2>&1
	)
	CLS
	echo -Ran HitmanPro >> %Output%\Notes\Comments.txt
	set /p VarHitman=Enter the amount of infections found:
	echo Infections-!!VarHitman!! >> %Output%\Notes\Comments.txt
	CLS
	echo Done running HitmanPro!
  	TIMEOUT 2 >nul 2>&1
  	GOTO eof
) else (
	echo HitmanPro not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 5 seconds.
	TIMEOUT 5 >NUL 2>&1
	goto eof
)
:eof
ENDLOCAL DISABLEDELAYEDEXPANSION
CLS