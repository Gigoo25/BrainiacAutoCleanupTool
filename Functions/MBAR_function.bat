@echo off

::Variables
set "VarMBAR=0"

::Start MBAR service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\MBAR\mbar.exe" (
	title [MBAR] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running MBAR...
	echo.
	echo   This may take a while.
	echo.
	echo =================================
	start /WAIT "MBAR" "%Output%\Tools\MBAR\mbar.exe"
	CLS
	echo -Ran MBAR >> %Output%\Notes\Comments.txt
	echo.
	echo  ^! USER INPUT
	echo =================================
	echo.
	set /p VarMBAR=Enter the amount of infections found:
	echo Infections-!!VarMBAR!! >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running MBAR!
	echo.
	echo =================================
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
