@echo off

::Variables
set VarJRT=0

::Start JRT service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\JRT\JRT.exe" (
	title [JRT] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running JRT...
	start /WAIT "JRT" "%Output%\Tools\JRT\JRT.exe"
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
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    JRT not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 10
  color 07
  goto :eof
)
:eof
ENDLOCAL DISABLEDELAYEDEXPANSION
CLS
