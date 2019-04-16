@echo off
CLS

::Variables
set LOG_REMNANTS=no

::Scan for random past logs and delete them if found.
if exist "%userprofile%\desktop\Rkill.txt" (
	del "%userprofile%\desktop\Rkill.txt" >NUL 2>&1
	set LOG_REMNANTS=yes
)
if exist "%userprofile%\desktop\JRT.txt" (
	del "%userprofile%\desktop\JRT.txt" >NUL 2>&1
	set LOG_REMNANTS=yes
)
if exist "%systemdrive%\Rkill.txt" (
	del "%systemdrive%\Rkill.txt" >NUL 2>&1
	set LOG_REMNANTS=yes
)
if exist "%systemdrive%\JRT.txt" (
	del "%systemdrive%\JRT.txt" >NUL 2>&1
	set LOG_REMNANTS=yes
)
if exist "%SystemRoot%\logs\cbs\cbs.log" (
	del "%SystemRoot%\logs\cbs\cbs.log" >NUL 2>&1
	set LOG_REMNANTS=yes
)
if exist "%systemdrive%\TDSSKiller*" (
	del "%systemdrive%\TDSSKiller*" >NUL 2>&1
	set LOG_REMNANTS=yes
)
if exist "%userprofile%\desktop\TDSSKiller*" (
	del "%userprofile%\desktop\TDSSKiller*" >NUL 2>&1
	set LOG_REMNANTS=yes
)

::Output notes that logs were cleared.
if %LOG_REMNANTS%==yes (
	echo -Deleted tool remnants >> %Output%\Notes\Comments.txt
)

::Start DeleteLogs service.
if exist "%Output%\Logs" (
	title [Deleting Logs] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo.
	echo  ^! ALERT
	echo ===============================
	echo.
	echo   Deleting logs/temp files...
	echo.
	echo ===============================
	rmdir /s /q "%Output%\Logs" >nul 2>&1
	echo -Deleted logs >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =======================
	echo.
	echo   Done deleting logs!
	echo.
	echo =======================
	TIMEOUT 3 >nul 2>&1
	goto eof
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Logs not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 10
  color 07
	goto eof
)
:eof
CLS
