@echo off

REM Variables
set TOOL_REMNANTS=yes
set CLEAR_RECYCLE=no

REM Start DeleteLogs service.
%Output%\Functions\Menu\MessageBox "Deleting known tools/tool remnants..." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul

REM Scan for known tools in known directories and delete them if found.
if exist "%userprofile%\Desktop\Brainiacs Cleanup Too*.exe" (
	del "%userprofile%\Desktop\Brainiacs Cleanup Too*.exe" >nul
	set TOOL_REMNANTS=no
)
if exist "%systemdrive%\Brainiacs Cleanup Too*.exe" (
	del "%systemdrive%\Brainiacs Cleanup Too*.exe" >nul
	set TOOL_REMNANTS=no
)

REM Check known locations & clean random past tools if found.
REM Delete Desktop\Brainiac or Desktop\Brainiacs
if exist "%userprofile%\Desktop\Brainiac" (
	rd /s /q  "%userprofile%\Desktop\Brainiac" >nul
	set TOOL_REMNANTS=no
)
if exist "%userprofile%\Desktop\Brainiacs" (
	rd /s /q  "%userprofile%\Desktop\Brainiacs" >nul
	set TOOL_REMNANTS=no
)

REM Delete %userprofile%\Brainiac or %userprofile%\Brainiacs
if exist "%userprofile%\Brainiac" (
	rd /s /q  "%userprofile%\Brainiac" >nul
	set TOOL_REMNANTS=no
)
if exist "%userprofile%\Brainiacs" (
	rd /s /q  "%userprofile%\Brainiacs" >nul
	set TOOL_REMNANTS=no
)

REM Delete %systemdrive%\Brainiac or %systemdrive%\Brainiacs
if exist "%systemdrive%\Brainiac" (
	rd /s /q  "%systemdrive%\Brainiac" >nul
	set TOOL_REMNANTS=no
)
if exist "%systemdrive%\Brainiacs" (
	rd /s /q  "%systemdrive%\Brainiacs" >nul
	set TOOL_REMNANTS=no
)

REM Delete "%systemdrive%\AdwCleaner
if exist "%systemdrive%\AdwCleaner" (
	rd /s /q "%systemdrive%\AdwCleaner" >nul
	set TOOL_REMNANTS=no
)

REM Delete %userprofile%\Desktop\mbar
if exist "%userprofile%\Desktop\mbar" (
	rd /s /q  "%userprofile%\Desktop\mbar" >nul
	set TOOL_REMNANTS=no
)

REM Delete %systemdrive%\Tool or %systemdrive%\Tools
if exist "%systemdrive%\Tool" (
	rd /s /q  "%systemdrive%\Tool" >nul
	set TOOL_REMNANTS=no
)
if exist "%systemdrive%\Tools" (
	rd /s /q  "%systemdrive%\Tools" >nul
	set TOOL_REMNANTS=no
)

REM Delete %userprofile%\Brainiac or %userprofile%\Brainiacs
if exist "%systemdrive%\BB Tool" (
	rd /s /q  "%systemdrive%\BB Tool" >nul
	set TOOL_REMNANTS=no
)
if exist "%systemdrive%\BB Tools" (
	rd /s /q  "%systemdrive%\BB Tools" >nul
	set TOOL_REMNANTS=no
)

REM Delete %userprofile%\Desktop\Cleanup or %systemdrive%\Cleanup
REM if exist "%userprofile%\Desktop\Cleanup" (
REM 	rd /s /q  "%userprofile%\Desktop\Cleanup" >nul
REM 	set TOOL_REMNANTS=no
REM )
REM if exist "%systemdrive%\Cleanup" (
REM 	rd /s /q  "%systemdrive%\Cleanup" >nul
REM 	set TOOL_REMNANTS=no
REM )

REM Delete %userprofile%\Desktop\Tool or %userprofile%\Desktop\Tools
if exist "%userprofile%\Desktop\Tool" (
	rd /s /q  "%userprofile%\Desktop\Tool" >nul
	set TOOL_REMNANTS=no
)
if exist "%userprofile%\Desktop\Tools" (
	rd /s /q  "%userprofile%\Desktop\Tools" >nul
	set TOOL_REMNANTS=no
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

REM Start DeleteTools service.
if exist "%Output%\Tools" (
	REM Delete tools folder
	rd /s /q "%Output%\Tools" >nul
	REM Set variable that shows that tools were deleted
	echo -Deleted tools folder >> %Output%\Notes\Comments.txt
	GOTO :EOF
) else (
	REM Display message that logs were not found
	%Output%\Functions\Menu\MessageBox "No known tools found!\n\nSkipping...\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 10 seconds" "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	GOTO :EOF
)
