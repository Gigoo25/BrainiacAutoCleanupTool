@echo off

::Variables
set "VarJRT=0"

::Start JRT service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\JRT\JRT.exe" (
	title [JRT] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running JRT...
	echo.
	echo =================================
	start /WAIT "JRT" "%Output%\Tools\JRT\JRT.exe"
	CLS
	echo -Ran JRT >> %Output%\Notes\Comments.txt
	echo.
	echo  ^! USER INPUT
	echo =================================
	echo.
	set /p VarJRT=Enter the amount of infections found:
	echo Infections-!!VarJRT!! >> %Output%\Notes\Comments.txt
	::Move log file
	if exist "%userprofile%\desktop\JRT.txt" (
		move %userprofile%\desktop\JRT.txt %Output%\Logs\JRT.txt >nul 2>&1
	)
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running JRT!
	echo.
	echo =================================
  TIMEOUT 2 >nul 2>&1
	:: Run Caffeine if killed by JRT.
	tasklist /FI "IMAGENAME eq caffeine.exe" 2>NUL | find /I /N "caffeine.exe">NUL
	if "%ERRORLEVEL%"=="1" (
	  start /SEPARATE "Caffeine" %Output%\Tools\Caffeine\caffeine.exe -noicon -exitafter:180
	) else (
		taskkill /f /im "caffeine.exe" >nul 2>&1
	  start /SEPARATE "Caffeine" %Output%\Tools\Caffeine\caffeine.exe -noicon -exitafter:180
	)
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
