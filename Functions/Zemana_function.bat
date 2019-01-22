@echo off

::Variables
set VarZemana=0

::Start Zemana service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe" (
	title [Zemana] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running Zemana...
	start /WAIT "ZMN" "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe" /scan SmartScan /clean
	CLS
	echo -Ran Zemana >> %Output%\Notes\Comments.txt
	set /p VarZemana=Enter the amount of infections found:
	echo Infections-!!VarZemana!! >> %Output%\Notes\Comments.txt
	CLS
	echo Done running Zemana!
  	TIMEOUT 2 >nul 2>&1
  	GOTO eof
) else (
	echo Zemana not found.
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