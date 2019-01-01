@echo off

::Start Spybot service.
CLS

::Set title
title [Spybot] Brainiacs Cleanup Tool v%TOOL_VERSION%

::Set variables
set Restore_State_Spybot=unidentified

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
	echo Existing Spybot installation detected. Skipping installation...
	TIMEOUT 3 >nul 2>&1
	CLS
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
)
if exist "%ProgramFiles(x86)%\Spybot - Search & Destroy\SDMain.exe" (
	echo Existing Spybot installation detected. Skipping installation...
	TIMEOUT 3 >nul 2>&1
	CLS
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
)
if exist "%systemdrive%\Spybot\SDMain.exe" (
	echo Existing Spybot installation detected. Skipping installation...
	TIMEOUT 3 >nul 2>&1
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
	"%Output%\Tools\SpyBot\spybotsd.exe" /dir="%systemdrive%\Spybot" /silent /type=compact /nocancel /suppressmsgboxes /norestart /noicons
	CLS
	echo Spybot installed successfuly.
	TIMEOUT 3 >nul 2>&1
	CLS
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
) else (
	echo Spybot installation files not found.
	echo.
	echo Skipping...
	echo.
    echo Continuing in 5 seconds.
	TIMEOUT 5 >NUL 2>&1
	CLS
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)

::Run Spybot.
:Run_Spybot
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%ProgramFiles(x86)%\Spybot - Search & Destroy\SDMain.exe" (
	echo Opening Spybot...
	"%ProgramFiles(x86)%\Spybot - Search & Destroy\SDMain.exe" /autoupdate /autocheck
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
	"%ProgramFiles%\Spybot - Search & Destroy\SDMain.exe" /autoupdate /autocheck
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
	"%systemdrive%\Spybot\SDMain.exe" /autoupdate /autocheck
	CLS
	echo -Ran Spybot >> %Output%\Notes\Comments.txt
	set /p VarSpybot=Enter the amount of infections found:
	echo Infections-!!VarSpybot!! >> %Output%\Notes\Comments.txt
	TIMEOUT 3 >nul 2>&1
	CLS
	echo Uninstall_Spybot_Next >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Uninstall_Spybot_Next
) else (
	echo Spybot not found. Skipping...
	TIMEOUT 3 >nul 2>&1
	CLS
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
ENDLOCAL DISABLEDELAYEDEXPANSION
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
	"%systemdrive%\Spybot\unins000.exe" /verysilent /suppressmsgboxes /norestart
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
	"%systemdrive%\Spybot\unins001.exe" /verysilent /suppressmsgboxes /norestart
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
	"%systemdrive%\Spybot\unins002.exe" /verysilent /suppressmsgboxes /norestart
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
	echo Spybot not found. Skipping...
	echo Skip_Spybot >%Output%\Tools\Restore_State_Malwarebytes.txt
	TIMEOUT 3 >nul 2>&1
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