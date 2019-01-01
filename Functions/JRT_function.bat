@echo off

::Start JRT service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\JRT\JRT.exe" (
	title [JRT] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running JRT...
	start /WAIT "JRT" "%Output%\Tools\JRT\JRT.exe"
	TIMEOUT 2 >nul 2>&1
	CLS
	echo -Ran JRT >> %Output%\Notes\Comments.txt
	set /p VarJRT=Enter the amount of infections found:
	echo Infections-!!VarJRT!! >> %Output%\Notes\Comments.txt
	::Move log file
	if exist "%userprofile%\desktop\JRT.txt" (
		move %userprofile%\desktop\JRT.txt %Output%\Logs\JRT.txt >nul 2>&1
	)
	CLS
	echo Done running JRT!
  	TIMEOUT 2 >nul 2>&1
  	GOTO eof
) else (
	echo JRT not found.
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