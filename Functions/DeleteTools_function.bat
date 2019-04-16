@echo off
CLS

::Variables
set TOOL_REMNANTS=no
set CLEAR_RECYCLE=no

::Check known locations for EXE File and delete if present
if exist "%userprofile%\Desktop\Brainiacs Cleanup Too*.*" (
	del "%userprofile%\Desktop\Brainiacs Cleanup Too*.*" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Brainiacs Cleanup Too*.*" (
	del "%systemdrive%\Brainiacs Cleanup Too*.*" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Check known locations & clean random past tools if found.
::
::Delete Desktop\Brainiac or Desktop\Brainiacs
if exist "%userprofile%\Desktop\Brainiac" (
	rd /s /q  "%userprofile%\Desktop\Brainiac" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%userprofile%\Desktop\Brainiacs" (
	rd /s /q  "%userprofile%\Desktop\Brainiacs" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Delete %userprofile%\Brainiac or %userprofile%\Brainiacs
if exist "%userprofile%\Brainiac" (
	rd /s /q  "%userprofile%\Brainiac" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%userprofile%\Brainiacs" (
	rd /s /q  "%userprofile%\Brainiacs" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Delete %systemdrive%\Brainiac or %systemdrive%\Brainiacs
if exist "%systemdrive%\Brainiac" (
	rd /s /q  "%systemdrive%\Brainiac" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Brainiacs" (
	rd /s /q  "%systemdrive%\Brainiacs" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Delete "%systemdrive%\AdwCleaner
if exist "%systemdrive%\AdwCleaner" (
	rd /s /q "%systemdrive%\AdwCleaner" >nul 2>&1
	set TOOL_REMNANTS=yes
)

::Delete %userprofile%\Desktop\mbar
if exist "%userprofile%\Desktop\mbar" (
	rd /s /q  "%userprofile%\Desktop\mbar" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Delete %systemdrive%\Tool or %systemdrive%\Tools
if exist "%systemdrive%\Tool" (
	rd /s /q  "%systemdrive%\Tool" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Tools" (
	rd /s /q  "%systemdrive%\Tools" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Delete %userprofile%\Brainiac or %userprofile%\Brainiacs
if exist "%systemdrive%\BB Tool" (
	rd /s /q  "%systemdrive%\BB Tool" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\BB Tools" (
	rd /s /q  "%systemdrive%\BB Tools" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Delete %userprofile%\Desktop\Cleanup or %systemdrive%\Cleanup
if exist "%userprofile%\Desktop\Cleanup" (
	rd /s /q  "%userprofile%\Desktop\Cleanup" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Cleanup" (
	rd /s /q  "%systemdrive%\Cleanup" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Delete %userprofile%\Desktop\Tool or %userprofile%\Desktop\Tools
if exist "%userprofile%\Desktop\Tool" (
	rd /s /q  "%userprofile%\Desktop\Tool" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%userprofile%\Desktop\Tools" (
	rd /s /q  "%userprofile%\Desktop\Tools" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Clear recyclebin
if exist "%systemdrive%\$Recycle.bin" (
	rd /s /q "%systemdrive%\$Recycle.bin" >nul 2>&1
	set CLEAR_RECYCLE=yes
)

::Output notes that remnants were cleared.
if %TOOL_REMNANTS%==yes (
	echo -Deleted remnants >> %Output%\Notes\Comments.txt
)

::Output notes that recyclebin was cleared.
if %CLEAR_RECYCLE%==yes (
	echo -Cleared recyclebin >> %Output%\Notes\Comments.txt
)

::Start DeleteTools service.
if exist "%Output%\Tools" (
	title [Deleting Tools] Brainiacs Cleanup Tool v%TOOL_VERSION%
	rd /s /q "%Output%\Tools" >nul 2>&1
	echo.
	echo  ^! ALERT
	echo ============================
	echo.
	echo   Deleting tools folder...
	echo.
	echo ============================
	echo -Deleted tools folder >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo ========================
	echo.
	echo   Done deleting tools!
	echo.
	echo ========================
	TIMEOUT 3 >nul 2>&1
	goto eof
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Tools folder not found.
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
