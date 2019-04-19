@echo off
CLS

REM Enable delayed expansion
setlocal enableDelayedExpansion

REM Start Spybot service.

REM Set title
title [Spybot] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Set variables
set Restore_State_Spybot=unidentified
set Skip_Install_Spybot=no
set "VarSpybot=0"

REM If unsupported os then set variable to skip install.
if %WIN_VER_NUM% LSS 6.1 set Skip_Install_Spybot=yes

if %Skip_Install_Spybot%==yes (
	color 0c
	CLS
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
	GOTO :EOF
)

REM Setup resume state if not found, if found ask if you want to resume
if exist "%Output%\Tools\SpyBot\Restore_State_Spybot.txt" (
	CLS
	echo.
	choice /M "Previous state found, do you want to restore the previous session" /c YN
	IF errorlevel 2 goto :restore_no
	IF errorlevel 1 goto :restore_yes
	:restore_yes
  set /p Restore_State_Spybot=<%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto %Restore_State_Spybot%
)
:restore_no
CLS

REM Check if Spybot is installed.
if exist "%ProgramFiles%\Spybot - Search & Destroy\SDMain.exe" (
  color 0c
	CLS
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
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
)
if exist "%ProgramFiles(x86)%\Spybot - Search & Destroy\SDMain.exe" (
  color 0c
	CLS
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
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
)
if exist "%systemdrive%\Spybot\SDMain.exe" (
  color 0c
	CLS
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
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
) else (
	echo Install_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Install_Spybot
)

REM Install Spybot.
:Install_Spybot
if exist "%Output%\Tools\SpyBot\spybotsd.exe" (
	echo.
	echo  ^! ALERT
	echo ========================
	echo.
	echo   Installing Spybot...
	echo.
	echo ========================
	start /WAIT "Spybot" "%Output%\Tools\SpyBot\spybotsd.exe" /dir="%systemdrive%\Spybot" /silent /type=compact /nocancel /suppressmsgboxes /norestart /noicons
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Spybot installed successfuly!
	echo.
	echo =================================
	TIMEOUT 3 >nul
	echo Run_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Run_Spybot
) else (
  color 0c
	CLS
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
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)

REM Run Spybot.
:Run_Spybot
if exist "%ProgramFiles(x86)%\Spybot - Search & Destroy\SDMain.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo =====================
	echo.
	echo   Opening Spybot...
	echo.
	echo =====================
	start /WAIT "Spybot" "%ProgramFiles(x86)%\Spybot - Search & Destroy\SDMain.exe"
	echo -Ran Spybot >> %Output%\Notes\Comments.txt
	CLS
	echo.
	set /p VarSpybot=Enter the amount of infections found:
	echo Infections-!!VarSpybot!! >> %Output%\Notes\Comments.txt
	TIMEOUT 3 >nul
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
if exist "%ProgramFiles%\Spybot - Search & Destroy\SDMain.exe" (
	echo.
	echo  ^! ALERT
	echo =====================
	echo.
	echo   Opening Spybot...
	echo.
	echo =====================
	start /WAIT "Spybot" "%ProgramFiles%\Spybot - Search & Destroy\SDMain.exe"
	echo -Ran Spybot >> %Output%\Notes\Comments.txt
	CLS
	echo.
	set /p VarSpybot=Enter the amount of infections found:
	echo Infections-!!VarSpybot!! >> %Output%\Notes\Comments.txt
	TIMEOUT 3 >nul
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
if exist "%systemdrive%\Spybot\SDMain.exe" (
	echo.
	echo  ^! ALERT
	echo =====================
	echo.
	echo   Opening Spybot...
	echo.
	echo =====================
	start /WAIT "Spybot" "%systemdrive%\Spybot\SDMain.exe"
	echo -Ran Spybot >> %Output%\Notes\Comments.txt
	CLS
	echo.
	set /p VarSpybot=Enter the amount of infections found:
	echo Infections-!!VarSpybot!! >> %Output%\Notes\Comments.txt
	TIMEOUT 3 >nul
	echo Uninstall_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Uninstall_Spybot
) else (
  color 0c
	CLS
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
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)

REM Uninstall Spybot.
:Uninstall_Spybot
CLS
echo.
choice /T 10 /D N /M "Uninstall Spybot" /c YN
IF errorlevel 2 goto :Skip_Spybot
IF errorlevel 1 goto :Uninstall_Spybot
:Uninstall_Spybot
if exist "%systemdrive%\Spybot\unins000.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==========================
	echo.
	echo   Uninstalling Spybot...
	echo.
	echo ==========================
	start /WAIT "Spybot" "%systemdrive%\Spybot\unins000.exe" /verysilent /suppressmsgboxes /norestart
	if exist "%systemdrive%\Spybot" (
		rmdir /s /q "%systemdrive%\Spybot" >nul
	)
	CLS
	echo.
	echo  ^! ALERT
	echo =========================
	echo.
	echo   Uninstalled Spybot...
	echo.
	echo =========================
	TIMEOUT 3 >nul
	echo -Uninstalled Spybot >> %Output%\Notes\Comments.txt
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
if exist "%systemdrive%\Spybot\unins001.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==========================
	echo.
	echo   Uninstalling Spybot...
	echo.
	echo ==========================
	start /WAIT "Spybot" "%systemdrive%\Spybot\unins001.exe" /verysilent /suppressmsgboxes /norestart
	if exist "%systemdrive%\Spybot" (
		rmdir /s /q "%systemdrive%\Spybot" >nul
	)
	CLS
	echo.
	echo  ^! ALERT
	echo =========================
	echo.
	echo   Uninstalled Spybot...
	echo.
	echo =========================
	TIMEOUT 3 >nul
	echo -Uninstalled Spybot >> %Output%\Notes\Comments.txt
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
if exist "%systemdrive%\Spybot\unins002.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==========================
	echo.
	echo   Uninstalling Spybot...
	echo.
	echo ==========================
	start /WAIT "Spybot" "%systemdrive%\Spybot\unins002.exe" /verysilent /suppressmsgboxes /norestart
	if exist "%systemdrive%\Spybot" (
		rmdir /s /q "%systemdrive%\Spybot" >nul
	)
	CLS
	echo.
	echo  ^! ALERT
	echo =========================
	echo.
	echo   Uninstalled Spybot...
	echo.
	echo =========================
	TIMEOUT 3 >nul
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
	echo Skip_Spybot >%Output%\Tools\SpyBot\Restore_State_Spybot.txt
	goto Skip_Spybot
)
:Skip_Spybot

REM Delete restore point if found.
if exist "%Output%\Tools\SpyBot\Restore_State_Spybot.txt" (
  del /Q "%Output%\Tools\SpyBot\Restore_State_Spybot.txt"
)

REM Disable delayed expansion
ENDLOCAL
