@echo off

::Start RKill service.
CLS
if exist "%Output%\Tools\RKill\rkill.exe" (
	title [RKill] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running RKill...
	echo This may take a while.
	"%Output%\Tools\RKill\rkill.exe" -s -l "%Output%\Logs\rkill.log" -w "%Output%\Tools\RKill\rkill_process_whitelist.txt"
	echo -Ran RKill >> %Output%\Notes\Comments.txt
	CLS
	echo Done running RKill!
  TIMEOUT 2 >nul 2>&1
	goto eof
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    RKill not found.
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
CLS
