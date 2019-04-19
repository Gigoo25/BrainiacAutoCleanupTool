@echo off

REM Variables
set TOOL_REMNANTS=no
set CLEAR_RECYCLE=no

REM Check known locations for EXE File and delete if present
if exist "%userprofile%\Desktop\Brainiacs Cleanup Too*.*" (
	del "%userprofile%\Desktop\Brainiacs Cleanup Too*.*" >nul
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Brainiacs Cleanup Too*.*" (
	del "%systemdrive%\Brainiacs Cleanup Too*.*" >nul
	set TOOL_REMNANTS=yes
)

REM Check known locations & clean random past tools if found.
REM Delete Desktop\Brainiac or Desktop\Brainiacs
if exist "%userprofile%\Desktop\Brainiac" (
	rd /s /q  "%userprofile%\Desktop\Brainiac" >nul
	set TOOL_REMNANTS=yes
)
if exist "%userprofile%\Desktop\Brainiacs" (
	rd /s /q  "%userprofile%\Desktop\Brainiacs" >nul
	set TOOL_REMNANTS=yes
)

REM Delete %userprofile%\Brainiac or %userprofile%\Brainiacs
if exist "%userprofile%\Brainiac" (
	rd /s /q  "%userprofile%\Brainiac" >nul
	set TOOL_REMNANTS=yes
)
if exist "%userprofile%\Brainiacs" (
	rd /s /q  "%userprofile%\Brainiacs" >nul
	set TOOL_REMNANTS=yes
)

REM Delete %systemdrive%\Brainiac or %systemdrive%\Brainiacs
if exist "%systemdrive%\Brainiac" (
	rd /s /q  "%systemdrive%\Brainiac" >nul
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Brainiacs" (
	rd /s /q  "%systemdrive%\Brainiacs" >nul
	set TOOL_REMNANTS=yes
)

REM Delete "%systemdrive%\AdwCleaner
if exist "%systemdrive%\AdwCleaner" (
	rd /s /q "%systemdrive%\AdwCleaner" >nul
	set TOOL_REMNANTS=yes
)

REM Delete %userprofile%\Desktop\mbar
if exist "%userprofile%\Desktop\mbar" (
	rd /s /q  "%userprofile%\Desktop\mbar" >nul
	set TOOL_REMNANTS=yes
)

REM Delete %systemdrive%\Tool or %systemdrive%\Tools
if exist "%systemdrive%\Tool" (
	rd /s /q  "%systemdrive%\Tool" >nul
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Tools" (
	rd /s /q  "%systemdrive%\Tools" >nul
	set TOOL_REMNANTS=yes
)

REM Delete %userprofile%\Brainiac or %userprofile%\Brainiacs
if exist "%systemdrive%\BB Tool" (
	rd /s /q  "%systemdrive%\BB Tool" >nul
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\BB Tools" (
	rd /s /q  "%systemdrive%\BB Tools" >nul
	set TOOL_REMNANTS=yes
)

REM Delete %userprofile%\Desktop\Cleanup or %systemdrive%\Cleanup
if exist "%userprofile%\Desktop\Cleanup" (
	rd /s /q  "%userprofile%\Desktop\Cleanup" >nul
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Cleanup" (
	rd /s /q  "%systemdrive%\Cleanup" >nul
	set TOOL_REMNANTS=yes
)

REM Delete %userprofile%\Desktop\Tool or %userprofile%\Desktop\Tools
if exist "%userprofile%\Desktop\Tool" (
	rd /s /q  "%userprofile%\Desktop\Tool" >nul
	set TOOL_REMNANTS=yes
)
if exist "%userprofile%\Desktop\Tools" (
	rd /s /q  "%userprofile%\Desktop\Tools" >nul
	set TOOL_REMNANTS=yes
)

REM Clear recyclebin
if exist "%systemdrive%\$Recycle.bin" (
	rd /s /q "%systemdrive%\$Recycle.bin" >nul
	set CLEAR_RECYCLE=yes
)

REM Output notes that remnants were cleared.
if %TOOL_REMNANTS%==yes (
	echo -Deleted remnants >> %Output%\Notes\Comments.txt
)

REM Output notes that recyclebin was cleared.
if %CLEAR_RECYCLE%==yes (
	echo -Cleared recyclebin >> %Output%\Notes\Comments.txt
)

REM Set title
title [Deleting Tools] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start DeleteTools service.
if exist "%Output%\Tools" (
	CLS
	echo.
	echo  ^! ALERT
	echo ============================
	echo.
	echo   Deleting tools folder...
	echo.
	echo ============================
	rd /s /q "%Output%\Tools" >nul
	echo -Deleted tools folder >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo ========================
	echo.
	echo   Done deleting tools!
	echo.
	echo ========================
	TIMEOUT 3 >nul
	GOTO :EOF
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
	GOTO :EOF
)
