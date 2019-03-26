@echo off

::Start MBAR service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\MBAR\mbar.exe" (
	title [MBAR] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running MBAR...
	echo This may take a while.
	start /WAIT "MBAR" "%Output%\Tools\MBAR\mbar.exe"
	CLS
	echo -Ran MBAR >> %Output%\Notes\Comments.txt
	set /p VarMBAR=Enter the amount of infections found:
	echo Infections-!!VarMBAR!! >> %Output%\Notes\Comments.txt
	CLS
	echo Done running MBAR!
  TIMEOUT 2 >nul 2>&1
	goto :eof
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    MBAR not found.
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
