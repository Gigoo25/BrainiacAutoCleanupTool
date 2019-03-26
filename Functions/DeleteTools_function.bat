@echo off
CLS

::Variables
set TOOL_REMNANTS=no
set CLEAR_RECYCLE=no

::Check known locations for EXE File and delete if present
if exist "%userprofile%\Desktop\Brainiacs Cleanup Tool*" (
	del "%userprofile%\Desktop\Brainiacs Cleanup Tool*" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Brainiacs Cleanup Tool*" (
	del "%systemdrive%\Brainiacs Cleanup Tool*" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Check known locations & clean random past tools if found.
if exist "%userprofile%\Desktop\Brainiac*" (
	rd /s /q  "%userprofile%\Desktop\Brainiac*" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%userprofile%\Brainiac*" (
	rd /s /q  "%userprofile%\Brainiac*" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Brainiac*" (
	rd /s /q  "%systemdrive%\Brainiac*" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\AdwCleaner" (
	rd /s /q "%systemdrive%\AdwCleaner" >nul 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%userprofile%\Desktop\mbar" (
	rd /s /q  "%userprofile%\Desktop\mbar" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\Tool*" (
	rd /s /q  "%systemdrive%\Tool*" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%systemdrive%\BB Tool*" (
	rd /s /q  "%systemdrive%\BB Tool**" >NUL 2>&1
	set TOOL_REMNANTS=yes
)
if exist "%userprofile%\Desktop\Tool*" (
	rd /s /q  "%userprofile%\Desktop\Tool*" >NUL 2>&1
	set TOOL_REMNANTS=yes
)

::Clear recyclebin
if exist "%systemdrive%\$Recycle.bin" (
	rd /s /q "%systemdrive%\$Recycle.bin" >nul 2>&1
	set CLEAR_RECYCLE=yes
)

::Output notes that remnants were cleared.
if %TOOL_REMNANTS%==yes (
	echo -Deleted tool remnants >> %Output%\Notes\Comments.txt
)

::Output notes that recyclebin was cleared.
if %CLEAR_RECYCLE%==yes (
	echo -Cleared recyclebin >> %Output%\Notes\Comments.txt
)

::Start DeleteTools service.
if exist "%Output%\Tools" (
	title [Deleting Tools] Brainiacs Cleanup Tool v%TOOL_VERSION%
	rd /s /q "%Output%\Tools" >nul 2>&1
	echo Deleting tools folder...
	echo -Deleted Tools folder >> %Output%\Notes\Comments.txt
	CLS
	echo Done deleting tools.
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
