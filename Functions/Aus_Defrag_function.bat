@echo off

REM Check for SSD and skip if detected.
for /f %%i in ('%Output%\Tools\SMARTCTL\smartctl.exe --scan') do %Output%\Tools\SMARTCTL\smartctl.exe %%i -a | %FINDSTR% /i "Solid SSD RAID SandForce" >NUL && set SKIP_DEFRAG=yes_ssd
for /f %%i in ('%Output%\Tools\SMARTCTL\smartctl.exe --scan') do %Output%\Tools\SMARTCTL\smartctl.exe %%i -a | %FINDSTR% /i "VMware VBOX XENSRC PVDISK" >NUL && set SKIP_DEFRAG=yes_vm
for /f %%i in ('%Output%\Tools\SMARTCTL\smartctl.exe --scan') do %Output%\Tools\SMARTCTL\smartctl.exe %%i -a | %FIND% /i "Read Device Identity Failed" >NUL && set SKIP_DEFRAG=yes_disk_smart_read_error

REM Skip defrag due to SSD detected
if /i "%SKIP_DEFRAG%"=="yes_ssd" (
	CLS
	color 0c
	echo.
	echo  ^! ERROR
	echo ===================================================================================
	echo.
	echo    SSD Detected.
	echo.
	echo    Skipping defrag function...
	echo.
	echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
	echo.
	echo ===================================================================================
	TIMEOUT 10
	color 07
	GOTO :EOF
)

REM Skip defrag due to Virtual machine detected
if /i "%SKIP_DEFRAG%"=="yes_vm" (
	CLS
	color 0c
	echo.
	echo  ^! ERROR
	echo ===================================================================================
	echo.
	echo    Virtual Machine Detected.
	echo.
	echo    Skipping defrag function...
	echo.
	echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
	echo.
	echo ===================================================================================
	TIMEOUT 10
	color 07
	GOTO :EOF
)

REM Skip defrag due to error reading disk stats detected
if /i "%SKIP_DEFRAG%"=="yes_disk_smart_read_error" (
	CLS
	color 0c
	echo.
	echo  ^! ERROR
	echo ===================================================================================
	echo.
	echo    Disk Smart Read Error.
	echo.
	echo    Skipping defrag function...
	echo.
	echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
	echo.
	echo ===================================================================================
	TIMEOUT 10
	color 07
	GOTO :EOF
)

REM Display disclaimer on checking for SSD.
CLS
color 0c
echo.
echo  ^! WARNING
echo ===================================================================================
echo.
echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% does have a limited check for SSD but
echo    it is not bulletproof.
echo.
echo    Be sure that you are not running this on an SSD and reducing the span of the drive.
echo.
echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 15 seconds.
echo.
echo ===================================================================================
TIMEOUT 15
color 07

REM Set title
title [AusDefrag] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start AusDefrag service.
if exist "%Output%\Tools\AUS\ausdiskdefrag.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running AusDefrag...
	echo.
	echo =================================
	start /WAIT "AUS" "%Output%\Tools\AUS\ausdiskdefrag.exe"
	echo -Ran AusDefrag >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running AusDefrag!
	echo.
	echo =================================
  TIMEOUT 2 >nul
  GOTO :EOF
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    AusDefrag not found.
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
