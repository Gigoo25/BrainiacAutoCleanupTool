@ECHO OFF
::Maximize Window
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b

::Prepare the Command Processor
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

::Set default directory
%~d0
cd %~dp0

::Define the filename where persistent variables get stored
set FilePersist=%cd%\Functions\Persist.cmd&

::Set variables
set Output=%cd%
set SAFE_MODE=no
set TOOL_VERSION=undetected
set TOOL_DATE=undetected
set OS=unidentified
set WIN_VER=undetected
set WIN_VER_NUM=undetected
set SAFE_MODE=no
set DELETEFUNCTIONS=yes
set VarID=unidentified
set VarACC=unidentified
set VarPHN=unidentified
set VarAddtlNote=None
set             RKill_choice=,Yes,No,
call:setPersist RKill=Yes
set             JRT_choice=,Yes,No,
call:setPersist JRT=Yes
set             TDSS_choice=,Yes,No,
call:setPersist TDSS=Yes
set             Rogue_choice=,Yes,No,
call:setPersist Rogue=Yes
set             ADW_choice=,Yes,No,
call:setPersist ADW=Yes
set             HitmanPro_choice=,Yes,No,
call:setPersist HitmanPro=Yes
set             Zemana_choice=,Yes,No,
call:setPersist Zemana=Yes
set             MBAR_choice=,Yes,No,
call:setPersist MBAR=Yes
set             Malwarebytes_choice=,Yes,No,
call:setPersist Malwarebytes=Yes
set             Spybot_choice=,Yes,No,
call:setPersist Spybot=No
set             CCleaner_choice=,Yes,No,
call:setPersist CCleaner=Yes
set             DefragSystem_choice=,Yes,No,
call:setPersist DefragSystem=Yes
set             ImageChecker_choice=,Yes,No,
call:setPersist ImageChecker=No
set             DriveChecker_choice=,Yes,No,
call:setPersist DriveChecker=No
set             SFChecker_choice=,Yes,No,
call:setPersist SFChecker=No
set             SystemRestore_choice=,Yes,No,
call:setPersist SystemRestore=Yes
set             AutoClose_choice=,Yes,No,
call:setPersist AutoClose=Yes
set             ReviewLogs_choice=,Yes,No,
call:setPersist ReviewLogs=Yes
set             OpenNotes_choice=,Yes,No,
call:setPersist OpenNotes=Yes
set             DeleteNotes_choice=,Yes,No,
call:setPersist DeleteNotes=No
set             DeleteLogs_choice=,Yes,No,
call:setPersist DeleteLogs=No
set             DeleteTools_choice=,Yes,No,
call:setPersist DeleteTools=Yes
set             SelfDestruct_choice=,Yes,No,
call:setPersist SelfDestruct=Yes
set             Reboot_choice=,Yes,No,
call:setPersist Reboot=No

:: Force path to some system utilities in case the system PATH is messed up
set WMIC=%SystemRoot%\System32\wbem\wmic.exe
set FIND=%SystemRoot%\System32\find.exe
set FINDSTR=%SystemRoot%\System32\findstr.exe
set REG=%SystemRoot%\System32\reg.exe

::Un-Hide files/folders
attrib "%Output%\Functions" -h -r
attrib "%Output%\Tools" -h -r
attrib "%Output%\Readme.txt" -h -r
attrib "%Output%\Changelog.txt" -h -r
attrib "%Output%\Version.txt" -h -r

::Unblock files
echo.>"%Output%\Readme.txt":Zone.Identifier
echo.>"%Output%\Changelog.txt":Zone.Identifier
echo.>"%Output%\Version.txt":Zone.Identifier

::Set tool version/date
if exist "%Output%\Version.txt" (
    < "%Output%\Version.txt" (
        set /p TOOL_VERSION=
        set /p TOOL_DATE=
    )
)

::Check for updates
call functions\Update_function

::Hide files/folders
attrib "%Output%\Functions" +h -r
attrib "%Output%\Tools" +h -r
attrib "%Output%\Readme.txt" +h -r
attrib "%Output%\Changelog.txt" +h -r
attrib "%Output%\Version.txt" +h -r

::Unblock files
echo.>"%Output%\Readme.txt":Zone.Identifier
echo.>"%Output%\Changelog.txt":Zone.Identifier
echo.>"%Output%\Version.txt":Zone.Identifier

::Move update function file if it was updated
if exist "%TEMP%\Update_function.bat" (
    move "%TEMP%\Update_function.bat" "%Output%\Functions\Update_function.bat" 2>NUL
    CLS
)

:: Set the window title
title Brainiacs Cleanup Tool v%TOOL_VERSION%

:: Detect if in safemode.
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" set SAFE_MODE=yes
if /i "%SAFEBOOT_OPTION%"=="NETWORK" set SAFE_MODE=yes

:: Detect the version of Windows
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| %FIND% "ProductName"') DO set WIN_VER=%%i %%j
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion ^| %FIND% "CurrentVersion"') DO set WIN_VER_NUM=%%i

::Check if 32/64bit windows
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

::Set Color
color 07

:: Kill off any running Caffeine instances first + run caffeine.
taskkill /f /im "caffeine.exe" >nul 2>&1
if exist "%Output%\Tools\Caffeine\caffeine.exe" (
    start "Caffeine" "%Output%\Tools\Caffeine\caffeine.exe"
)

::Start interface
echo.
echo  ^! DISCLAIMER
echo ===================================================================================
echo.
echo    I am not responsible if this program ends up causing any harm, blows
echo    up a computer or causes a nuclear war.
echo    You have been warned.
echo.
echo    All logs will be placed in the folder "%cd%\Logs".
echo    This tools also generates notes for the account. These will be
echo    placed in the folder "%cd%\Notes".
echo. 
echo    Please run the program as administrator. Otherwise you'll have to
echo    you'll have to accept UAC for each program that tries to run.
echo.
echo ===================================================================================
choice /M "Do you accept responsibility for running this tool" /c YN
IF errorlevel 2 goto :accept_no
IF errorlevel 1 goto :accept_yes

:accept_no
::Display message if they do not accept the disclaimer
color 0c
cls
echo.
echo  ^! ERROR
echo ===================================================================================
echo.
echo    You did not accept responsibility for running this tool.
echo.                                                        
echo    If you decide to grow up and accept responsibility re-run the tool    
echo    and accept the disclaimer.
echo.
echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 60 seconds.
echo.
echo ===================================================================================
TIMEOUT 60
exit 1

:accept_yes
::Check for administrator privilage
if /i not "%SAFE_MODE%"=="yes" (
    fsutil dirty query %systemdrive% >NUL 2>&1
    if /i not !ERRORLEVEL!==0 (
        color 0c
        cls
        echo.
        echo  ^! ERROR
        echo ===================================================================================
        echo.
        echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% doesn't think it is running as an Administrator.
        echo    You MUST run with full Administrator rights to function correctly.
        echo.
        echo    Close this window and re-run the cleanup tool as an Administrator.
        echo    ^(right-click Brainiacs.bat and click "Run as Administrator"^)
        echo.
        echo ===================================================================================
        pause
        exit 1
    )
)
CLS

::Check for supported os
if "%WIN_VER_NUM%" LEQ 5.1 (
	color 0c
	echo.
	echo  ^! ERROR
	echo ===================================================================================
	echo.
	echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% does not support "%WIN_VER%".
	echo.
	echo    You will have to run your tools manually.
	echo.
	echo    Sorry.
	echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds.
	echo.
	echo ===================================================================================
    TIMEOUT 15
	exit 1
)
CLS

::Check for tools folder
if exist "%Output%\Tools" (
    goto ToolsContinue  
    ) else (
        color 0c
        cls
        echo.
		echo  ^! ERROR
		echo ===================================================================================
        echo.
        echo 	Tools folder not found.
        echo 	You MUST have tools folder under %Output%
        echo.
    	echo 	The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds.
		echo.
		echo ===================================================================================
    	TIMEOUT 15
		exit 1
    )
:ToolsContinue
CLS

::Check for functions folder
if exist "%Output%\Functions" (
    goto FunctionsContinue
    ) else (
        color 0c
        cls
        echo.
		echo  ^! ERROR
		echo ===================================================================================
        echo.
        echo 	Functions folder not found.
        echo 	You MUST have functions folder under %Output%
        echo.
    	echo 	The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds.
		echo.
		echo ===================================================================================
    	TIMEOUT 15
		exit 1
    )
:FunctionsContinue
CLS

::Setup resume state if not found, if found ask if you want to resume
if exist "%FilePersist%" (
	choice /M "Previous state found, do you want to restore the previous session" /c YN
	IF errorlevel 2 goto :restore_no
	IF errorlevel 1 goto :restore_yes
	:restore_yes
	call:restorePersistentVars "%FilePersist%"
	CLS
	::Start menu
	goto :menuLOOP
)
:restore_no
del /Q "%FilePersist%"  >NUL 2>&1

::Delete notes if exist
if exist "%Output%\Notes" (
    del /Q "%Output%\Notes\*.*" >NUL 2>&1
) 
if not exist "%Output%\Notes\" (
    mkdir "%Output%\Notes" >NUL 2>&1
)

::Delete logs if exist
if exist "%Output%\Logs" (
    del /Q "%Output%\Logs\*.*" >NUL 2>&1
) 
if not exist "%Output%\Logs\" (
	mkdir "%Output%\Logs" >NUL 2>&1
)
CLS

::Ask for user input & write to notes
echo ----------------------------------------- >> %Output%\Notes\Comments.txt
::Ask if the session was picked up
choice /T 20 /D N /M "Did you pickup this session" /c YN
IF errorlevel 2 goto :Session_New
IF errorlevel 1 goto :Session_Pickup

::Ask for user input for session pickup
:Session_Pickup
CLS
set /p VarID=Enter your CSG user ID: 
echo "%VarID%" >> "%Output%\Notes\Comments.txt"
CLS
echo. >> "%Output%\Notes\Comments.txt"
echo General Cleanup. >> "%Output%\Notes\Comments.txt"
echo. >> "%Output%\Notes\Comments.txt"
set /p VarAddtlNote=Enter any additional notes:
echo Additional notes: "%VarAddtlNote%" >> "%Output%\Notes\Comments.txt"
echo --- >> "%Output%\Notes\Comments.txt"
echo -Picked up session >> "%Output%\Notes\Comments.txt"
CLS
goto menuLOOP

::Ask for user input for new session
:Session_New
CLS
set /p VarID=Enter your CSG user ID: 
echo "%VarID%" >> "%Output%\Notes\Comments.txt"
CLS
set /p VarACC=Enter the subscribers Account number: 
echo ACC#"%VarACC%" >> "%Output%\Notes\Comments.txt"
CLS
set /p VarPHN=Enter the subscribers Phone number: 
echo PHN#"%VarPHN%" >> "%Output%\Notes\Comments.txt"
CLS
echo. >> "%Output%\Notes\Comments.txt"
echo General Cleanup. >> "%Output%\Notes\Comments.txt"
set /p VarAddtlNote=Enter any additional notes:
echo Additional Notes: "%VarAddtlNote%" >> "%Output%\Notes\Comments.txt"
echo --- >> "%Output%\Notes\Comments.txt"
CLS
goto menuLOOP

::Start Menu
:menuLOOP
CLS
title [Menu] Brainiacs Cleanup Tool v%TOOL_VERSION%
echo.
echo  ^! MENU
echo ===================================================================================
echo.
echo  ^! Select a tool, option or preset from the list below by inputting the corresponding
echo  ^! character. Once you are okay with your selection type "SC" and then enter to 
echo  ^! start the automated process.
echo.
echo ===================================================================================
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.  %%B  %%C
set choice=
echo.
echo ===================================================================================
echo.&set /p choice=Make a choice or hit ENTER to quit: ||(
	GOTO:EOF
)
echo.&call:menu_%choice%
GOTO:menuLOOP

::Menu functions
:menu_CSG ID: !VarID!
:menu_Account#: !VarACC!
:menu_Phone#: !VarPHN!

:menu_
:menu_Additional Notes:
:menu_!VarAddtlNote!

:menu_
:menu_Tools:
::Start RKill service
:menu_1   Run RKill?                                : '!RKill!' [!RKill_choice:~1,-1!]
call:getNextInList RKill "!RKill_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start JRT service
:menu_2   Run JRT?                                  : '!JRT!' [!JRT_choice:~1,-1!]
call:getNextInList JRT "!JRT_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start TDSS Killer service
:menu_3   Run TDSS Killer?                          : '!TDSS!' [!TDSS_choice:~1,-1!]
call:getNextInList TDSS "!TDSS_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Rogue Killer service
:menu_4   Run Rogue Killer?                         : '!Rogue!' [!Rogue_choice:~1,-1!]
call:getNextInList Rogue "!Rogue_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start ADW service
:menu_5   Run ADW?                                  : '!ADW!' [!ADW_choice:~1,-1!]
call:getNextInList ADW "!ADW_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Hitman Pro service
:menu_6   Run Hitman Pro?                           : '!HitmanPro!' [!HitmanPro_choice:~1,-1!]
call:getNextInList HitmanPro "!HitmanPro_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Zemana service
:menu_7   Run Zemana?                               : '!Zemana!' [!Zemana_choice:~1,-1!]
call:getNextInList Zemana "!Zemana_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start MBAR service
:menu_8   Run MBAR?                                 : '!MBAR!' [!MBAR_choice:~1,-1!]
call:getNextInList MBAR "!MBAR_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Malwarebytes service
:menu_9   Run Malwarebytes?                         : '!Malwarebytes!' [!Malwarebytes_choice:~1,-1!]
call:getNextInList Malwarebytes "!Malwarebytes_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Spybot service
:menu_10   Run Spybot? (Advanced Tool)              : '!Spybot!' [!Spybot_choice:~1,-1!]
call:getNextInList Spybot "!Spybot_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start CCleaner service
:menu_11   Run CCleaner?                            : '!CCleaner!' [!CCleaner_choice:~1,-1!]
call:getNextInList CCleaner "!CCleaner_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Defrag System service
:menu_12   Defrag System?                           : '!DefragSystem!' [!DefragSystem_choice:~1,-1!]
call:getNextInList DefragSystem "!DefragSystem_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Windows Drive check service
:menu_13   Check Windows Drive for errors?          : '!DriveChecker!' [!DriveChecker_choice:~1,-1!]
call:getNextInList DriveChecker "!DriveChecker_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Windows Image check service
:menu_14   Check Windows Image for errors?          : '!ImageChecker!' [!ImageChecker_choice:~1,-1!]
call:getNextInList ImageChecker "!ImageChecker_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start SFC service
:menu_15   Check System Files for corruption?       : '!SFChecker!' [!SFChecker_choice:~1,-1!]
call:getNextInList SFChecker "!SFChecker_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF


:menu_
:menu_Options:
::Start system restore service
:menu_R    Create system restore point?              : '!SystemRestore!' [!SystemRestore_choice:~1,-1!]
call:getNextInList SystemRestore "!SystemRestore_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Auto close service
:menu_A   Auto close when done?                     : '!AutoClose!' [!AutoClose_choice:~1,-1!]
call:getNextInList AutoClose "!AutoClose_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Review Logs service
:menu_L   Review Logs when done?                    : '!ReviewLogs!' [!ReviewLogs_choice:~1,-1!]
call:getNextInList ReviewLogs "!ReviewLogs_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Open comments service
:menu_C   Open comments when done?                  : '!OpenNotes!' [!OpenNotes_choice:~1,-1!]
call:getNextInList OpenNotes "!OpenNotes_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Delete comments service
:menu_DC   Delete comments when done?               : '!DeleteNotes!' [!DeleteNotes_choice:~1,-1!]
call:getNextInList DeleteNotes "!DeleteNotes_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Delete logs service
:menu_DL    Delete logs when done?                   : '!DeleteLogs!' [!DeleteLogs_choice:~1,-1!]
call:getNextInList DeleteLogs "!DeleteLogs_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Delete tools service
:menu_DT    Delete tools when done?                  : '!DeleteTools!' [!DeleteTools_choice:~1,-1!]
call:getNextInList DeleteTools "!DeleteTools_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Self-Destruct service
:menu_SD    Self-Destruct Cleanup Tool when done?    : '!SelfDestruct!' [!SelfDestruct_choice:~1,-1!]
call:getNextInList SelfDestruct "!SelfDestruct_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF
::Start Reboot service
:menu_B   Reboot when done?                         : '!Reboot!' [!Reboot_choice:~1,-1!]
call:getNextInList Reboot "!Reboot_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

:menu_
:menu_Presets:
::Display present options.
::Display default cleanup preset.
:menu_DP    Default cleanup preset.
cls
set             RKill=Yes
set             JRT=Yes
set             TDSS=Yes
set             Rogue=Yes
set             ADW=Yes
set             HitmanPro=Yes
set             Zemana=Yes
set             MBAR=Yes
set             Malwarebytes=Yes
set             Spybot=No
set             CCleaner=Yes
set             DefragSystem=Yes
set             ImageChecker=No
set             DriveChecker=No
set             SFChecker=No
set             SystemRestore=Yes
set             AutoClose=Yes
set             ReviewLogs=Yes
set             OpenNotes=Yes
set             DeleteNotes=No
set             DeleteLogs=No
set             DeleteTools=Yes
set             SelfDestruct=Yes
set             Reboot=No
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

::Display enable all preset.
:menu_EA    Enable all preset.
cls
set             RKill=Yes
set             JRT=Yes
set             TDSS=Yes
set             Rogue=Yes
set             ADW=Yes
set             HitmanPro=Yes
set             Zemana=Yes
set             MBAR=Yes
set             Malwarebytes=Yes
set             Spybot=Yes
set             CCleaner=Yes
set             DefragSystem=Yes
set             ImageChecker=Yes
set             DriveChecker=Yes
set             SFChecker=Yes
set             SystemRestore=Yes
set             AutoClose=Yes
set             ReviewLogs=Yes
set             OpenNotes=Yes
set             DeleteNotes=Yes
set             DeleteLogs=Yes
set             DeleteTools=Yes
set             SelfDestruct=Yes
set             Reboot=Yes
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

::Display disable all preset.
:menu_DA    Disable all preset.
cls
set             RKill=No
set             JRT=No
set             TDSS=No
set             Rogue=No
set             ADW=No
set             HitmanPro=No
set             Zemana=No
set             MBAR=No
set             Malwarebytes=No
set             Spybot=No
set             CCleaner=No
set             DefragSystem=No
set             ImageChecker=No
set             DriveChecker=No
set             SFChecker=No
set             SystemRestore=No
set             AutoClose=No
set             ReviewLogs=No
set             OpenNotes=No
set             DeleteNotes=No
set             DeleteLogs=No
set             DeleteTools=No
set             SelfDestruct=No
set             Reboot=No
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

:menu_
:menu_Execute:
S
:menu_SC   Start Cleanup

if /i "%SystemRestore:~0,1%"=="Y" (
    CLS
    ::Call function
	call functions\Restore_function
    ::Create restore point
    set SystemRestore=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%RKill:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\Rkill_function
    ::Create restore point
    set RKill=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%JRT:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\JRT_function
    ::Create restore point
    set JRT=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%TDSS:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\TDSS_Killer_function
    ::Create restore point
    set TDSS=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%Rogue:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\RogueKiller_function
    ::Create restore point
    set Rogue=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%ADW:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\ADW_function
    ::Create restore point
    set ADW=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%HitmanPro:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\HitmanPro_function
    ::Create restore point
    set HitmanPro=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%Zemana:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\Zemana_function
    ::Create restore point
    set Zemana=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%MBAR:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\MBAR_function
    ::Create restore point
    set MBAR=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%Malwarebytes:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\Malwarebytes_function
    ::Create restore point
    set Malwarebytes=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%Spybot:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\Spybot_function
    ::Create restore point
    set Spybot=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%CCleaner:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\CCleaner_function
    ::Create restore point
    set CCleaner=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%DefragSystem:~0,1%"=="Y" (
    CLS
    ::Ask which program to use to defrag
    :choice_start
    CLS
    choice /C AD /T 20 /D A /M "Which program do you want to defrag with [A] AusDefrag or [D] Defraggler"
    IF errorlevel 2 goto Defraggler
    IF errorlevel 1 goto AusDefrag
    ::Open Defraggler_function.
    :Defraggler
    call functions\Defraggler_function
    ::Open AusDefrag_function.
    :AusDefrag
    call functions\AusDefrag_function
    ::Create restore point
    set DefragSystem=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%ImageChecker:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\Image_Checker_function
    ::Create restore point
    set ImageChecker=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%SFChecker:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\SFC_function
    ::Create restore point
    set SFChecker=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%DriveChecker:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\CHKDSK_function
    ::Create restore point
    set SystemChecker=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%ReviewLogs:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\ReviewLogs_function
    ::Create restore point
    set ReviewLogs=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%OpenNotes:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\OpenNotes_function
    ::Create restore point
    set OpenNotes=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%DeleteNotes:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\DeleteNotes_function
    ::Create restore point
    set DeleteNotes=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%DeleteLogs:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\DeleteLogs_function
    ::Create restore point
    set DeleteLogs=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)
if /i "%DeleteTools:~0,1%"=="Y" (
    CLS
    ::Call function
    call functions\DeleteTools_function
    ::Create restore point
    set DeleteTools=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%SelfDestruct:~0,1%"=="N" (
    CLS
    ::Set Variable
	set SelfDestruct=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

taskkill /f /im "caffeine.exe" >nul 2>&1

if /i "%AutoClose:~0,1%"=="Y" (
    CLS
    ::Create restore point
    set AutoClose=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title [Exiting] Brainiacs Cleanup Tool v%TOOL_VERSION%
    color 0c
    echo.
	echo  ^! WARNING
	echo ===================================================================================
    echo.
    echo The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds.
	echo.
	echo ===================================================================================
    TIMEOUT 15
    if %SelfDestruct%==yes ( 
        if exist "%Output%\Functions" (
            rmdir /s /q "%Output%\Functions" >nul 2>&1  
        )
        cd /D "%~dp0"
        md "%appdata%\UploadFiles" 2>nul
        xcopy "*.zip" "%appdata%\UploadFiles" /e /i /q /y
        echo rd /S /Q "%~dp0">"%TEMP%\%~nx0"
        echo del "%TEMP%\%~nx0">>"%TEMP%\%~nx0"
        cd /D "%TEMP%"
        "%TEMP%\%~nx0"
    	(goto) 2>nul & del "%~f0"
    ) else (
    	exit
	)
)

if /i "%Reboot:~0,1%"=="Y" (
    CLS
    ::Create restore point
    set Reboot=No
    call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
    ::Set title
    title [Rebooting] Brainiacs Cleanup Tool v%TOOL_VERSION%
    color 0c
    echo.
	echo  ^! WARNING
	echo ===================================================================================
    echo.
    echo The Brainiacs Cleanup Tool v%TOOL_VERSION% will reboot the PC in 10 seconds.
    echo Exit the tool to stop the reboot.
	echo.
	echo ===================================================================================
    TIMEOUT 10
    shutdown -r -f -t 0
    ::Self-Destruct
    if %SelfDestruct%==yes (
        if exist "%Output%\Functions" (
            rmdir /s /q "%Output%\Functions" >nul 2>&1  
        )
        cd /D "%~dp0"
        md "%appdata%\UploadFiles" 2>nul
        xcopy "*.zip" "%appdata%\UploadFiles" /e /i /q /y
        echo rd /S /Q "%~dp0">"%TEMP%\%~nx0"
        echo del "%TEMP%\%~nx0">>"%TEMP%\%~nx0"
        cd /D "%TEMP%"
        "%TEMP%\%~nx0"
    	(goto) 2>nul & del "%~f0"
    ) else (
        exit
    )
)

GOTO:EOF

:menu_VR   View Readme
CLS
if exist "%Output%\Readme.txt" (
    title [Readme] Brainiacs Cleanup Tool v%TOOL_VERSION%
	type  %Output%\Readme.txt
	echo.
    echo.
	pause
	CLS
) else (
    echo Readme not found.
    echo.
    echo Returning to menu...
    echo.
    echo Continuing in 5 seconds.
    TIMEOUT 5 >NUL 2>&1
)
GOTO:EOF

:menu_VC   View Comments
CLS
if exist "%Output%\Notes\Comments.txt" (
    title [Comments] Brainiacs Cleanup Tool v%TOOL_VERSION%
	type  %Output%\Notes\Comments.txt
	echo.
    echo.
	pause
	CLS
) else (
    echo Comments not found.
    echo.
    echo Returning to menu...
    echo.
    echo Continuing in 5 seconds.
    TIMEOUT 5 >NUL 2>&1
)
GOTO:EOF

:menu_VH   View Changelog
CLS
if exist "%Output%\Changelog.txt" (
    title [Changelog] Brainiacs Cleanup Tool v%TOOL_VERSION%
	type  %Output%\Changelog.txt
	echo.
    echo.
	pause
	CLS
) else (
    echo Changelog not found.
    echo.
    echo Returning to menu...
    echo.
    echo Continuing in 5 seconds.
    TIMEOUT 5 >NUL 2>&1
)
GOTO:EOF

::-----------------------------------------------------------
:: helper functions follow below here
::-----------------------------------------------------------


:setPersist -- to be called to initialize persistent variables
::          -- %*: set command arguments
set %*
GOTO:EOF


:getPersistentVars -- returns a comma separated list of persistent variables
::                 -- %~1: reference to return variable
SETLOCAL
set retlist=
set parse=findstr /i /c:"call:setPersist" "%~f0%"^|find /v "ButNotThisLine"
for /f "tokens=2 delims== " %%a in ('"%parse%"') do (set retlist=!retlist!%%a,)
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" SET %~1=%retlist%
)
GOTO:EOF


:savePersistentVars -- Save values of persistent variables into a file
::                  -- %~1: file name
SETLOCAL
echo.>"%~1"
call :getPersistentVars persvars
for %%a in (%persvars%) do (echo.SET %%a=!%%a!>>"%~1")
GOTO:EOF


:restorePersistentVars -- Restore the values of the persistent variables
::                     -- %~1: batch file name to restore from
if exist "%FilePersist%" call "%FilePersist%"
GOTO:EOF


:getNextInList -- return next value in list
::             -- %~1 - in/out ref to current value, returns new value
::             -- %~2 - in     choice list, must start with delimiter which must not be '@'
SETLOCAL
set lst=%~2&             rem.-- get the choice list
if "%lst:~0,1%" NEQ "%lst:~-1%" echo.ERROR Choice list must start and end with the delimiter&GOTO:EOF
set dlm=%lst:~-1%&       rem.-- extract the delimiter used
set old=!%~1!&           rem.-- get the current value
set fst=&for /f "delims=%dlm%" %%a in ("%lst%") do set fst=%%a&rem.--get the first entry
                         rem.-- replace the current value with a @, append the first value
set lll=!lst:%dlm%%old%%dlm%=%dlm%@%dlm%!%fst%%dlm%
                         rem.-- get the string after the @
for /f "tokens=2 delims=@" %%a in ("%lll%") do set lll=%%a
                         rem.-- extract the next value
for /f "delims=%dlm%" %%a in ("%lll%") do set new=%%a
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" (SET %~1=%new%) ELSE (echo.%new%)
)
GOTO:EOF


FOR /l %%a in (%~1,-1,1) do (ping -n 2 -w 1 127.0.0.1>NUL)
goto :eof
