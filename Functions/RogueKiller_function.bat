@echo off

::Variables
set VarRougueKiller=0

::Start RogueKiller service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\RogueKiller\RogueKillerCMD.exe" (
	title [RogueKiller] Brainiacs Cleanup Tool v%TOOL_VERSION%
	"%Output%\Tools\RogueKiller\RogueKillerCMD.exe" -scan -debuglog "%Output%\Logs\rogue.log"
	CLS
	echo -Ran RougueKiller >> %Output%\Notes\Comments.txt
	set /p VarRougueKiller=Enter the amount of infections found:
	echo Infections-!!VarRougueKiller!! >> %Output%\Notes\Comments.txt
	CLS
	echo Done running RougueKiller!
  	TIMEOUT 2 >nul 2>&1
	goto :eof
) else (
	echo RogueKiller not found.
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