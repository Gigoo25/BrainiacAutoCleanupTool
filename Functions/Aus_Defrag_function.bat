@echo off

REM Check for SSD and skip if detected.
for /f %%i in ('%Output%\Tools\SMARTCTL\smartctl.exe --scan') do %Output%\Tools\SMARTCTL\smartctl.exe %%i -a | %FINDSTR% /i "Solid SSD RAID SandForce" >NUL && set SKIP_DEFRAG=yes_ssd
for /f %%i in ('%Output%\Tools\SMARTCTL\smartctl.exe --scan') do %Output%\Tools\SMARTCTL\smartctl.exe %%i -a | %FINDSTR% /i "VMware VBOX XENSRC PVDISK" >NUL && set SKIP_DEFRAG=yes_vm
for /f %%i in ('%Output%\Tools\SMARTCTL\smartctl.exe --scan') do %Output%\Tools\SMARTCTL\smartctl.exe %%i -a | %FIND% /i "Read Device Identity Failed" >NUL && set SKIP_DEFRAG=yes_disk_smart_read_error

REM Skip defrag due to SSD detected
if /i "%SKIP_DEFRAG%"=="yes_ssd" (
	%Output%\Functions\Menu\MessageBox "SSD Detected.\n\nSkipping defrag function...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	GOTO :EOF
)

REM Skip defrag due to Virtual machine detected
if /i "%SKIP_DEFRAG%"=="yes_vm" (
	%Output%\Functions\Menu\MessageBox "Virtual Machine Detected.\n\nSkipping defrag function...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	GOTO :EOF
)

REM Skip defrag due to error reading disk stats detected
if /i "%SKIP_DEFRAG%"=="yes_disk_smart_read_error" (
	%Output%\Functions\Menu\MessageBox "Disk Smart Read Error.\n\nSkipping defrag function...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	GOTO :EOF
)

REM Display disclaimer on checking for SSD.
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "The Brainiacs Cleanup Tool v%TOOL_VERSION% does have a limited check for SSD but it is not bulletproof.\n\nBe sure that you are not running this on an SSD and reducing the span of the drive.\n\nAre you sure you're not running on an SSD?" "[DISCLAIMER] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:I /O:N`) DO (
  IF /I "%%G"=="No" (
	%Output%\Functions\Menu\MessageBox "You did not accept responsibility.\n\nSkipping...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
  GOTO :EOF
  )
)

REM Start AusDefrag service.
if exist "%Output%\Tools\AUS\ausdiskdefrag.exe" (
	REM Display start message.
	%Output%\Functions\Menu\MessageBox "Starting AusDefrag..." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	start /WAIT "AUS" "%Output%\Tools\AUS\ausdiskdefrag.exe"
	echo -Ran AusDefrag >> %Output%\Notes\Comments.txt
  GOTO :EOF
) else (
	REM Display message that ADW was not found & skip
	%Output%\Functions\Menu\MessageBox "AusDefrag not found.\n\nSkipping...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	GOTO :EOF
)
