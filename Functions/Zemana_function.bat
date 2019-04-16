@echo off

::Variables
set "VarZemana=0"

::Start Zemana service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe" (
	title [Zemana] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running Zemana...
	echo.
	echo =================================
	start /WAIT "ZMN" "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe" /scan SmartScan /clean
	CLS
	echo -Ran Zemana >> %Output%\Notes\Comments.txt
	echo.
	echo  ^! USER INPUT
	echo =================================
	echo.
	set /p VarZemana=Enter the amount of infections found:
	echo Infections-!!VarZemana!! >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running Zemana!
	echo.
	echo =================================
  TIMEOUT 2 >nul 2>&1
  GOTO eof
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Zemana not found.
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
