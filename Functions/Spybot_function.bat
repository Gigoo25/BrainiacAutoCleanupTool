@echo off
CLS

::Enable delayed expansion
setlocal enableDelayedExpansion

::Start Spybot service.

::Set title
title [Spybot] Brainiacs Cleanup Tool v%TOOL_VERSION%

::Set variables
set Restore_State_Spybot=unidentified
set Skip_Install_Spybot=no
set VarSpybot=0

::If unsupported os then set variable to skip install.
if %WIN_VER_NUM% LSS 6.1 set Skip_Install_Spybot=yes

if %Skip_Install_Spybot%==yes (
	color 0c
	echo.
	echo  ^! ERROR
	echo ===================================================================================
	echo.
	echo    Running Spybot does not support "%WIN_VER%".
	echo.
	echo    You will have to install/run your tools manually.
	echo.
	echo    Sorry.
	echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will now continue.
	echo.
	echo ===================================================================================
  TIMEOUT 15
	goto :EOF
)

::Setup resume state if not found, if found ask if you want to resume
if exist "%Output%\Tools\SpyBot\Restore_State_Spybot.txt" (
	choice /M "Previous state found, do you want to restore the previous session" /c YN
	IF errorlevel 2 goto :restore_no
	IF errorlevel 1 goto :restore_yes
	:restore_yes
  set /p Restore_State_Spybot=<%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto %Restore_State_Spybot%
)
:restore_no
CLS

::Check if Spybot is installed.
if exist "%ProgramFiles%\Spybot - Search & Destroy\SDMain.exe" (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Existing Spybot installation detected.
  echo.
  echo    Skipping installation...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
	CLS
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
)
if exist "%ProgramFiles(x86)%\Spybot - Search & Destroy\SDMain.exe" (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Existing Spybot installation detected.
  echo.
  echo    Skipping installation...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
	CLS
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
)
if exist "%systemdrive%\Spybot\SDMain.exe" (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Existing Spybot installation detected.
  echo.
  echo    Skipping installation...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
	CLS
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
) else (
	echo Install_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Install_Spybot
)

::Install Spybot.
:Install_Spybot
if exist "%Output%\Tools\SpyBot\spybotsd.exe" (
	echo Installing Spybot...
	start /WAIT "Spybot" "%Output%\Tools\SpyBot\spybotsd.exe" /dir="%systemdrive%\Spybot" /silent /type=compact /nocancel /suppressmsgboxes /norestart /noicons
	CLS
	echo Spybot installed successfuly.
	TIMEOUT 3 >nul 2>&1
	CLS
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Spybot installation files not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 10
  color 07
	CLS
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)

::Run Spybot.
:Run_Spybot
if exist "%ProgramFiles(x86)%\Spybot - Search & Destroy\SDMain.exe" (
	echo Opening Spybot...
	start /WAIT "Spybot" "%ProgramFiles(x86)%\Spybot - Search & Destroy\SDMain.exe"
	CLS
	echo -Ran Spybot >> %Output%\Notes\Comments.txt
	set /p VarSpybot=Enter the amount of infections found:
	echo Infections-!!VarSpybot!! >> %Output%\Notes\Comments.txt
	TIMEOUT 3 >nul 2>&1
	CLS
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
if exist "%ProgramFiles%\Spybot - Search & Destroy\SDMain.exe" (
	echo Opening Spybot...
	start /WAIT "Spybot" "%ProgramFiles%\Spybot - Search & Destroy\SDMain.exe"
	CLS
	echo -Ran Spybot >> %Output%\Notes\Comments.txt
	set /p VarSpybot=Enter the amount of infections found:
	echo Infections-!!VarSpybot!! >> %Output%\Notes\Comments.txt
	TIMEOUT 3 >nul 2>&1
	CLS
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
if exist "%systemdrive%\Spybot\SDMain.exe" (
	echo Opening Spybot...
	start /WAIT "Spybot" "%systemdrive%\Spybot\SDMain.exe"
	CLS
	echo -Ran Spybot >> %Output%\Notes\Comments.txt
	set /p VarSpybot=Enter the amount of infections found:
	echo Infections-!!VarSpybot!! >> %Output%\Notes\Comments.txt
	TIMEOUT 3 >nul 2>&1
	CLS
	echo Uninstall_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Uninstall_Spybot
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Spybot not found.
  echo.
  echo    Skipping installation...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
	CLS
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
CLS

::Uninstall Spybot.
:Uninstall_Spybot
choice /T 10 /D N /M "Uninstall Spybot" /c YN
IF errorlevel 2 goto :Skip_Spybot
IF errorlevel 1 goto :Uninstall_Spybot
:Uninstall_Spybot
CLS
if exist "%systemdrive%\Spybot\unins000.exe" (
	echo Uninstalling Spybot...
	start /WAIT "Spybot" "%systemdrive%\Spybot\unins000.exe" /verysilent /suppressmsgboxes /norestart
	if exist "%systemdrive%\Spybot" (
		rmdir /s /q "%systemdrive%\Spybot" >nul 2>&1
	)
	CLS
	echo Uninstalled Spybot.
	TIMEOUT 3 >nul 2>&1
	echo -Uninstalled Spybot >> %Output%\Notes\Comments.txt
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
if exist "%systemdrive%\Spybot\unins001.exe" (
	echo Uninstalling Spybot...
	start /WAIT "Spybot" "%systemdrive%\Spybot\unins001.exe" /verysilent /suppressmsgboxes /norestart
	if exist "%systemdrive%\Spybot" (
		rmdir /s /q "%systemdrive%\Spybot" >nul 2>&1
	)
	CLS
	echo Uninstalled Spybot.
	TIMEOUT 3 >nul 2>&1
	echo -Uninstalled Spybot >> %Output%\Notes\Comments.txt
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
if exist "%systemdrive%\Spybot\unins002.exe" (
	echo Uninstalling Spybot...
	start /WAIT "Spybot" "%systemdrive%\Spybot\unins002.exe" /verysilent /suppressmsgboxes /norestart
	if exist "%systemdrive%\Spybot" (
		rmdir /s /q "%systemdrive%\Spybot" >nul 2>&1
	)
	CLS
	echo Uninstalled Spybot.
	TIMEOUT 3 >nul 2>&1
	echo -Uninstalled Spybot >> %Output%\Notes\Comments.txt
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Spybot not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 10
  color 07
	CLS
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
:Skip_Spybot

::Delete restore point if found.
if exist "%Output%\Tools\SpyBot\Restore_State_Spybot.txt" (
  del /Q "%Output%\Tools\SpyBot\Restore_State_Spybot.txt"
)
CLS
::Disable delayed expansion
ENDLOCAL
