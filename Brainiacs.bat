@ECHO OFF

REM Maximize Window
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b

REM Run as admin
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B
:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

REM Prepare the Command Processor
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM Set default directory
%~d0
cd %~dp0

REM Define the filename where persistent variables get stored
set FilePersist=%cd%\Functions\Persist.cmd&

REM Other variables
set Output=%cd%
set SAFE_MODE=no
set TOOL_VERSION=undetected
set TOOL_DATE=undetected
set OS=unidentified
set WIN_VER=undetected
set WIN_VER_NUM=undetected
set DELETEFUNCTIONS=yes
set DELETE_RESTORE=undetected
set ABRUPTCLOSE=undetected
set ABORT=no
set VarID=unidentified
set VarACC=unidentified
set VarPHN=unidentified
set VarAddtlNote=None
set SKIP_DEFRAG=no
set Skip_Comments=unidentified
set VarGeek=None
set Test_Update_All=undetected
set password=undetected

REM Menu variables
set RKill_choice=,Yes,No,
call:setPersist RKill=Yes
set JRT_choice=,Yes,No,
call:setPersist JRT=Yes
set TDSS_choice=,Yes,No,
call:setPersist TDSS=Yes
set Rogue_choice=,Yes,No,
call:setPersist Rogue=Yes
set ADW_choice=,Yes,No,
call:setPersist ADW=Yes
set HitmanPro_choice=,Yes,No,
call:setPersist HitmanPro=Yes
set Zemana_choice=,Yes,No,
call:setPersist Zemana=Yes
set MBAR_choice=,Yes,No,
call:setPersist MBAR=No
set Malwarebytes_choice=,Yes,No,
call:setPersist Malwarebytes=No
set Spybot_choice=,Yes,No,
call:setPersist Spybot=No
set CCleaner_choice=,Yes,No,
call:setPersist CCleaner=Yes
set DefragSystem_choice=,Yes,No,
call:setPersist DefragSystem=Yes
set ImageChecker_choice=,Yes,No,
call:setPersist ImageChecker=Yes
set DriveChecker_choice=,Yes,No,
call:setPersist DriveChecker=Yes
set SystemRestore_choice=,Yes,No,
call:setPersist SystemRestore=Yes
set AutoClose_choice=,Yes,No,
call:setPersist AutoClose=Yes
set ReviewLogs_choice=,Yes,No,
call:setPersist ReviewLogs=Yes
set OpenNotes_choice=,Yes,No,
call:setPersist OpenNotes=Yes
set DeleteNotes_choice=,Yes,No,
call:setPersist DeleteNotes=No
set DeleteLogs_choice=,Yes,No,
call:setPersist DeleteLogs=No
set DeleteTools_choice=,Yes,No,
call:setPersist DeleteTools=Yes
set SelfDestruct_choice=,Yes,No,
call:setPersist SelfDestruct=Yes
set Reboot_choice=,Yes,No,
call:setPersist Reboot=No

REM  Force path to some system utilities in case the system PATH is messed up
set WMIC=%SystemRoot%\System32\wbem\wmic.exe
set FIND=%SystemRoot%\System32\find.exe
set FINDSTR=%SystemRoot%\System32\findstr.exe
set REG=%SystemRoot%\System32\reg.exe

REM Un-Hide files/folders
attrib "%Output%\Functions" -h -r
attrib "%Output%\Tools" -h -r
attrib "%Output%\Readme.txt" -h -r
attrib "%Output%\Changelog.txt" -h -r
attrib "%Output%\Version.txt" -h -r

REM Unblock files
echo.>"%Output%\Readme.txt":Zone.Identifier
echo.>"%Output%\Changelog.txt":Zone.Identifier
echo.>"%Output%\Version.txt":Zone.Identifier

REM Set tool version/date
if exist "%Output%\Version.txt" (
  < "%Output%\Version.txt" (
      set /p TOOL_VERSION=
      set /p TOOL_DATE=
  )
)

REM Pull ABRUPTCLOSE var if present
if exist "%Output%\Functions\ABRUPTCLOSE.txt" (
    set /p ABRUPTCLOSE=<!Output!\Functions\ABRUPTCLOSE.txt
)

REM Check if 32/64bit windows
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

REM Set Initial Color
color 07

REM Skip to menu if verbose is enabled
if exist "%Output%\Debug" (
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo =========================
  echo.
  echo    Debug file detected.
  echo.
  echo =========================
  TIMEOUT 2
  CLS
  echo.
  echo  ^! WARNING
  echo ==============================
  echo.
  echo    Entering Debugging mode.
  echo.
  echo ==============================
  TIMEOUT 3
  @echo on
  goto :menuLOOP
)

REM Ask for password for beta testing purposes
CLS
echo.
echo  ^! PASSWORD
echo ===================================================================================
echo.
echo    Enter the password in order to access the tool.
echo.
echo    If you do not have the password please close out of this tool.
echo.
echo ===================================================================================
set /p password="Enter password: "
if "%password%"=="RedRuby" (
  cls
  color 0c
  echo.
  echo  ^! WARNING
  echo ==================================
  echo.
  echo    Entering hidden testing mode.
  echo.
  echo ==================================
  TIMEOUT 2
  goto Choice_Test_Upgrade_All
) else if /I "%password%"=="Bluemoon" (
  goto No_Test_Continue
) else (
  cls
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Password is incorrect.
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 30 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 30
  exit /b
)

REM Ask to upgrade all functions if in testing mode
:Choice_Test_Upgrade_All

REM Ask to upgrade from latest commits
CLS
echo.
echo  ^! WARNING
echo =================================
echo.
echo    This may break some things.
echo.
echo =================================
choice /M "Do you want to update from the latest commits?" /c YN
IF errorlevel 2 goto :Test_Upgrade_All_Decline
IF errorlevel 1 goto :Test_Upgrade_All_Accept
:Test_Upgrade_All_Accept
set Test_Update_All=yes
call functions\Update_function
set Test_Update_All=no

REM Ask to enable debugging
:Test_Upgrade_All_Decline
CLS
echo.
echo  ^! WARNING
echo ====================================
echo.
echo    The output will be really long.
echo.
echo ====================================
choice /M "Do you want to enable debugging?" /c YN
IF errorlevel 2 goto :menuLOOP
IF errorlevel 1 goto :Enable_Debugging
:Enable_Debugging
echo. >> "%Output%\Debug"
start Brainiacs.bat
exit /b

REM Skip testing mode stuff if denied previously
:No_Test_Continue

REM Begin "Checks"
REM -----------------
REM Check for updates
call functions\Update_function

REM Hide files/folders
attrib "%Output%\Functions" +h -r
attrib "%Output%\Tools" +h -r
attrib "%Output%\Readme.txt" +h -r
attrib "%Output%\Changelog.txt" +h -r
attrib "%Output%\Version.txt" +h -r

REM Unblock files
echo.>"%Output%\Readme.txt":Zone.Identifier
echo.>"%Output%\Changelog.txt":Zone.Identifier
echo.>"%Output%\Version.txt":Zone.Identifier

REM  Set the window title
title Brainiacs Cleanup Tool v%TOOL_VERSION%

REM  Detect if in safemode
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" set SAFE_MODE=yes
if /i "%SAFEBOOT_OPTION%"=="NETWORK" set SAFE_MODE=yes

REM  Detect the version of Windows
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| %FIND% "ProductName"') DO set WIN_VER=%%i %%j
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion ^| %FIND% "CurrentVersion"') DO set WIN_VER_NUM=%%i

REM If unsupported os then set variable to abort
if %WIN_VER_NUM% LSS 6.0 set ABORT=yes

REM  Run caffeine
tasklist | find /i "caffeine.exe" >nul
if "%ERRORLEVEL%"=="1" (
  start "Caffeine" %Output%\Tools\Caffeine\caffeine.exe -noicon -exitafter:180
)

REM Start interface
CLS
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

REM Display message if they do not accept the disclaimer
:accept_no
cls
color 0c
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

REM If disclaimer was accepted check for administrator privilage
:accept_yes
if /i not "%SAFE_MODE%"=="yes" (
  fsutil dirty query %systemdrive% >nul
  if /i not !ERRORLEVEL!==0 (
    cls
    color 0c
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
    exit
  )
)

REM Quit if windows version is unsupported
if %ABORT%==yes (
  CLS
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

REM Check if tools folder exists
if exist "%Output%\Tools" (
  goto ToolsContinue
) else (
  cls
  color 0c
  echo.
	echo  ^! ERROR
	echo ===================================================================================
  echo.
  echo    Tools folder not found.
  echo    You MUST have tools folder under %Output%
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds.
	echo.
	echo ===================================================================================
  TIMEOUT 15
	exit 1
)

REM Continue if tools folder was found
:ToolsContinue

REM Check for functions folder
if exist "%Output%\Functions" (
  goto FunctionsContinue
) else (
  cls
  color 0c
  echo.
	echo  ^! ERROR
	echo ===================================================================================
  echo.
  echo    Functions folder not found.
  echo    You MUST have functions folder under %Output%
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds.
	echo.
	echo ===================================================================================
  TIMEOUT 15
	exit 1
)

REM Continue if functions folder was found
:FunctionsContinue

REM Setup resume state if not found, if found ask if you want to resume the last state
if "%ABRUPTCLOSE%"=="yes" (
  if exist "%Output%\Functions\ABRUPTCLOSE.txt" (
    cls
    color 0c
    echo.
    echo  ^! WARNING
    echo ===================================================================================
    echo.
    echo    Abrupt stop detected!
    echo.
    echo ===================================================================================
	  choice /M "Do you want to restore the session?" /c YN
	  IF errorlevel 2 goto :restore_no
	  IF errorlevel 1 goto :restore_yes
	  :restore_yes
	  call:restorePersistentVars "%FilePersist%"
    color 07
	  REM Start cleanup
	  goto :menu_SC
    :restore_no
    REM Set var to delete restore point on start
    set DELETE_RESTORE=Yes
    del "%Output%\Functions\ABRUPTCLOSE.txt"
  )
)

REM Create notes folder if not found
if not exist "%Output%\Notes\" (
  mkdir "%Output%\Notes" >nul
)

REM Create logs folder if not found
if not exist "%Output%\Logs\" (
  mkdir "%Output%\Logs" >nul
)

REM Start notes template
echo ----------------------------------------- >> %Output%\Notes\Comments.txt

REM Ask if the session was picked up
CLS
echo.
echo  ^! USER INPUT
echo =================================
echo.
choice /T 20 /D N /M "Did you pickup this session" /c YN
IF errorlevel 2 goto :Session_New
IF errorlevel 1 goto :Session_Pickup
:Session_Pickup

REM Restore variables from last session if present
if exist "%FilePersist%" (
  call:restorePersistentVars "%FilePersist%"
)

REM Ask & enter CSG user ID into notes
CLS
echo.
echo  ^! USER INPUT
echo =================================
echo.
set /p VarID=Enter your CSG user ID:
echo "%VarID%" >> "%Output%\Notes\Comments.txt"
echo. >> "%Output%\Notes\Comments.txt"

REM Enter general cleanup as the reason
echo General Cleanup. >> "%Output%\Notes\Comments.txt"
echo. >> "%Output%\Notes\Comments.txt"

REM Ask & enter any additional notes
CLS
echo.
echo  ^! USER INPUT
echo =================================
echo.
set /p VarAddtlNote=Enter any additional notes:
echo Additional notes: "%VarAddtlNote%" >> "%Output%\Notes\Comments.txt"
echo --- >> "%Output%\Notes\Comments.txt"
echo -Picked up session >> "%Output%\Notes\Comments.txt"

REM Goto menu
goto menuLOOP

REM Start new session if user did not pick up session
:Session_New

REM Delete notes if exist
if exist "%Output%\Notes" (
  del /Q "%Output%\Notes\*.*" >nul
)

REM Create new notes folder if not present
if not exist "%Output%\Notes\" (
  mkdir "%Output%\Notes" >nul
)

REM Delete logs if exist
if exist "%Output%\Logs" (
  del /Q "%Output%\Logs\*.*" >nul
)

REM Create new logs folder if not present
if not exist "%Output%\Logs\" (
  mkdir "%Output%\Logs" >nul
)

REM Ask & enter CSG user ID into notes
CLS
echo.
echo  ^! USER INPUT
echo =================================
echo.
set /p VarID=Enter your CSG user ID:
echo "%VarID%" >> "%Output%\Notes\Comments.txt"

REM Ask & enter Account number notes
REM CLS
REM echo.
REM echo  ^! USER INPUT
REM echo =================================
REM echo.
REM set /p VarACC=Enter the subscribers Account number:
REM echo ACC#"%VarACC%" >> "%Output%\Notes\Comments.txt"

REM Ask & enter Phone number into notes
CLS
echo.
echo  ^! USER INPUT
echo =================================
echo.
set /p VarPHN=Enter the subscribers Phone number:
echo PHN#"%VarPHN%" >> "%Output%\Notes\Comments.txt"
echo. >> "%Output%\Notes\Comments.txt"

REM Enter general cleanup reason
echo General Cleanup. >> "%Output%\Notes\Comments.txt"

REM Ask & enter any additional notes
CLS
echo.
echo  ^! USER INPUT
echo =================================
echo.
set /p VarAddtlNote=Enter any additional notes:
echo Additional Notes: "%VarAddtlNote%" >> "%Output%\Notes\Comments.txt"
echo --- >> "%Output%\Notes\Comments.txt"

REM Add check for restore deletion
if /i "!DELETE_RESTORE!"=="Yes" (
  del /Q "%FilePersist%"  >nul
  del "%Output%\Functions\ABRUPTCLOSE.txt"
)

REM Goto menu
goto menuLOOP

REM Start Menu
:menuLOOP
CLS
REM Set title
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
echo.&set /p choice=Make a choice: ||(
	GOTO:menuLOOP
)
echo.&call:menu_%choice%
GOTO:menuLOOP

REM Display notes
:menu_CSG ID: !VarID!
:menu_Account#: !VarACC!
:menu_Phone#: !VarPHN!

REM Display additional notes
:menu_
:menu_Additional Notes:
:menu_!VarAddtlNote!

REM Display menu tools
:menu_
:menu_Tools:

REM Start RKill service
:menu_1   Run RKill?                                : '!RKill!' [!RKill_choice:~1,-1!]
call:getNextInList RKill "!RKill_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start JRT service
:menu_2   Run JRT?                                  : '!JRT!' [!JRT_choice:~1,-1!]
call:getNextInList JRT "!JRT_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start TDSS Killer service
:menu_3   Run TDSS Killer?                          : '!TDSS!' [!TDSS_choice:~1,-1!]
call:getNextInList TDSS "!TDSS_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Rogue Killer service
:menu_4   Run Rogue Killer?                         : '!Rogue!' [!Rogue_choice:~1,-1!]
call:getNextInList Rogue "!Rogue_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start ADW service
:menu_5   Run ADW?                                  : '!ADW!' [!ADW_choice:~1,-1!]
call:getNextInList ADW "!ADW_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Hitman Pro service
:menu_6   Run Hitman Pro?                           : '!HitmanPro!' [!HitmanPro_choice:~1,-1!]
call:getNextInList HitmanPro "!HitmanPro_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Zemana service
:menu_7   Run Zemana?                               : '!Zemana!' [!Zemana_choice:~1,-1!]
call:getNextInList Zemana "!Zemana_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start MBAR service
:menu_8   Run MBAR? (Takes a long time to run)      : '!MBAR!' [!MBAR_choice:~1,-1!]
call:getNextInList MBAR "!MBAR_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Malwarebytes service
:menu_9   Run Malwarebytes? (Experimental)          : '!Malwarebytes!' [!Malwarebytes_choice:~1,-1!]
call:getNextInList Malwarebytes "!Malwarebytes_choice!"
cls

REM Check for testing mode
if not "%password%"=="RedRuby" (
    set Malwarebytes=No
    cls
    color 0c
    echo.
    echo  ^! ERROR
    echo ===================================================================================
    echo.
    echo    You are not in testing mode and are not able to try Experimental tools.
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 30 seconds.
    echo.
    echo ===================================================================================
    TIMEOUT 30
    color 07
    GOTO :EOF
)

REM Check if system restore is enabled
if /I "%password%"=="Bluemoon" (
if /i "!SystemRestore!"=="No" (
  set Malwarebytes=No
  cls
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Malwarebytes requires you to have the option "Create system restore point" to be
  echo    enabled. Please enable this option and try again.
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 30 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 30
  color 07
)
)

REM Check for windows 8 or above
if %WIN_VER_NUM% geq 6.2 (
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  GOTO:EOF
) else (
  CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Malwarebytes does not support "%WIN_VER%".
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

REM Start Spybot service
:menu_10   Run Spybot? (Experimental)               : '!Spybot!' [!Spybot_choice:~1,-1!]
call:getNextInList Spybot "!Spybot_choice!"
cls

REM Check for testing mode
if not "%password%"=="RedRuby" (
    cls
    set Spybot=No
    color 0c
    echo.
    echo  ^! ERROR
    echo ===================================================================================
    echo.
    echo    You are not in testing mode and are not able to try Experimental tools.
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 30 seconds.
    echo.
    echo ===================================================================================
    TIMEOUT 30
    color 07
    GOTO :EOF
)

REM Check if system restore is enabled
if /I "%password%"=="Bluemoon" (
if /i "!SystemRestore!"=="No" (
  CLS
  set Spybot=No
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Spybot requires you to have the option "Create system restore point" to be
  echo    enabled. Please enable this option and try again.
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 30 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 30
  color 07
)
)

REM Check for windows 8 or above
if %WIN_VER_NUM% geq 6.2 (
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  GOTO:EOF
) else (
  CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Spybot does not support "%WIN_VER%".
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

REM Start CCleaner service
:menu_11   Run CCleaner?                            : '!CCleaner!' [!CCleaner_choice:~1,-1!]
call:getNextInList CCleaner "!CCleaner_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Defrag System service
:menu_12   Defrag System?                           : '!DefragSystem!' [!DefragSystem_choice:~1,-1!]
call:getNextInList DefragSystem "!DefragSystem_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Windows Drive check service
:menu_13   Check Windows Drive for errors?          : '!DriveChecker!' [!DriveChecker_choice:~1,-1!]
call:getNextInList DriveChecker "!DriveChecker_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Windows Image check service
:menu_14   Check Windows Image for errors?          : '!ImageChecker!' [!ImageChecker_choice:~1,-1!]
call:getNextInList ImageChecker "!ImageChecker_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Display other tools
:menu_
:menu_Other_Tools:

REM Start Geek Uninstaller
:menu_GK   Run Geek Uninstaller
if exist "%Output%\Tools\Geek\geek.exe" (
  CLS
  REM Set title
  title [Geek Uninstaller] Brainiacs Cleanup Tool v%TOOL_VERSION%
  echo Running Geek Uninstaller...
  start /WAIT "Geek" "%Output%\Tools\Geek\geek.exe"
  CLS
  echo -Ran Geek Uninsaller >> %Output%\Notes\Comments.txt
  set /p VarGeek=Enter any uninstalled programs separated by a comma:
  echo Uninstalled programs-!!VarGeek!! >> %Output%\Notes\Comments.txt
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
) else (
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    Geek Uninstaller not found.
  echo.
  echo    Returning to menu...
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
GOTO:EOF

REM Display menu options
:menu_
:menu_Options:

REM Start system restore service
:menu_R    Create system restore point?              : '!SystemRestore!' [!SystemRestore_choice:~1,-1!]
call:getNextInList SystemRestore "!SystemRestore_choice!"
cls
if /i "!SystemRestore!"=="No" (
  if /i "!Malwarebytes!"=="Yes" (
    set Malwarebytes=No
  )
  if /i "!Spybot!"=="Yes" (
    set Spybot=No
  )
)
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Auto close service
:menu_A   Auto close when done?                     : '!AutoClose!' [!AutoClose_choice:~1,-1!]
call:getNextInList AutoClose "!AutoClose_choice!"
cls
if /i "!SelfDestruct!"=="Yes" (
  if /i "!AutoClose!"=="No" (
    if /i "!Reboot!"=="No" (
      set SelfDestruct=No
    )
  )
)
if /i "!DeleteTools!"=="Yes" (
  if /i "!AutoClose!"=="No" (
    if /i "!Reboot!"=="No" (
      set DeleteTools=No
    )
  )
)
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Review Logs service
:menu_L   Review Logs when done?                    : '!ReviewLogs!' [!ReviewLogs_choice:~1,-1!]
call:getNextInList ReviewLogs "!ReviewLogs_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Open comments service
:menu_C   Open comments when done?                  : '!OpenNotes!' [!OpenNotes_choice:~1,-1!]
call:getNextInList OpenNotes "!OpenNotes_choice!"
cls
if /i "!OpenNotes!"=="No" (
  if /i "!DeleteNotes!"=="Yes" (
    set DeleteNotes=No
  )
)
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Delete comments service
:menu_DC   Delete comments when done?               : '!DeleteNotes!' [!DeleteNotes_choice:~1,-1!]
call:getNextInList DeleteNotes "!DeleteNotes_choice!"
if /i "!DeleteNotes!"=="Yes" (
  if /i "!AutoClose!"=="No" (
    if /i "!Reboot!"=="No" (
      CLS
      color 0c
      echo.
      echo  ^! ERROR
      echo ===================================================================================
      echo.
      echo    Delete notes requires you to have the options "Auto close when done" or
      echo    "Reboot when done" to be enabled.
      echo.
      echo ===================================================================================
      choice /C AR /T 20 /D A /M "Select [A]utoClose or [R]eboot to continue."
      IF errorlevel 2 goto Reboot_deletenotes_choice
      IF errorlevel 1 goto AutoClose_deletenotes_choice
      :AutoClose_deletenotes_choice
      set AutoClose=Yes
      set Reboot=No
      GOTO Delete_notes_Continue
      :Reboot_deletenotes_choice
      set AutoClose=No
      set Reboot=Yes
    )
  )
  :Delete_notes_Continue
  if /i "!OpenNotes!"=="No" (
    CLS
    color 0c
    echo.
    echo  ^! ERROR
    echo ===================================================================================
    echo.
    echo    Delete comments requires you to have the option "Open comments when done" to be
    echo    enabled. Please enable this option and try again.
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 30 seconds.
    echo.
    echo ===================================================================================
    set DeleteNotes=No
    TIMEOUT 30
    color 07
    GOTO:EOF
  )
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    You have selected to delete the comments when done.
  echo.
  echo    The comments will still open before deletion for you to copy, but once you close
  echo    the prompt it will all be gone.
  echo.
  echo ===================================================================================
  choice /C YN /T 20 /D N /M "Are you really sure you want to delete the notes after run?"
  IF errorlevel 2 goto DontDeleteNotes_Prompt_choice
  IF errorlevel 1 goto DeleteNotes_Prompt_Continue
  :DontDeleteNotes_Prompt_choice
  set DeleteNotes=No
  GOTO DeleteNotes_Prompt_Continue
  :DeleteNotes_Prompt_choice
  set DeleteNotes=Yes
)
:DeleteNotes_Prompt_Continue
color 07
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Delete logs service
:menu_DL    Delete logs when done?                   : '!DeleteLogs!' [!DeleteLogs_choice:~1,-1!]
call:getNextInList DeleteLogs "!DeleteLogs_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Delete tools service
:menu_DT    Delete tools when done?                  : '!DeleteTools!' [!DeleteTools_choice:~1,-1!]
call:getNextInList DeleteTools "!DeleteTools_choice!"
cls
if /i "!DeleteTools!"=="Yes" (
  if /i "!AutoClose!"=="No" (
    if /i "!Reboot!"=="No" (
      color 0c
      echo.
      echo  ^! ERROR
      echo ===================================================================================
      echo.
      echo    Delete tools requires you to have the options "Auto close when done" or
      echo    "Reboot when done" to be enabled.
      echo.
      echo ===================================================================================
      choice /C AR /T 20 /D A /M "Select [A]utoClose or [R]eboot to continue."
      IF errorlevel 2 goto Reboot_deletetools_choice
      IF errorlevel 1 goto AutoClose_deletetools_choice
      :AutoClose_deletetools_choice
      set AutoClose=Yes
      set Reboot=No
      GOTO Deletetools_Continue
      :Reboot_deletetools_choice
      set AutoClose=No
      set Reboot=Yes
    )
  )
)
:Deletetools_Continue
color 07
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Self-Destruct service
:menu_SD    Self-Destruct Cleanup Tool when done?    : '!SelfDestruct!' [!SelfDestruct_choice:~1,-1!]
call:getNextInList SelfDestruct "!SelfDestruct_choice!"
cls
if /i "!SelfDestruct!"=="Yes" (
  if /i "!AutoClose!"=="No" (
    if /i "!Reboot!"=="No" (
      color 0c
      echo.
      echo  ^! ERROR
      echo ===================================================================================
      echo.
      echo    Self-Destruct requires you to have the options "Auto close when done" or
      echo    "Reboot when done" to be enabled.
      echo.
      echo ===================================================================================
      choice /C AR /T 20 /D A /M "Select [A]utoClose or [R]eboot to continue."
      IF errorlevel 2 goto Reboot_selfdestruct_choice
      IF errorlevel 1 goto AutoClose_selfdestruct_choice
      :AutoClose_selfdestruct_choice
      set AutoClose=Yes
      set Reboot=No
      GOTO:SelfDestruct_Continue
      :Reboot_selfdestruct_choice
      set AutoClose=No
      set Reboot=Yes
    )
  )
)
:SelfDestruct_Continue
color 07
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Reboot service
:menu_B   Reboot when done?                         : '!Reboot!' [!Reboot_choice:~1,-1!]
call:getNextInList Reboot "!Reboot_choice!"
cls
if /i "!SelfDestruct!"=="Yes" (
  if /i "!AutoClose!"=="No" (
    if /i "!Reboot!"=="No" (
      set SelfDestruct=No
    )
  )
)
if /i "!DeleteTools!"=="Yes" (
  if /i "!AutoClose!"=="No" (
    if /i "!Reboot!"=="No" (
      set DeleteTools=No
    )
  )
)
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Display preset options.
:menu_
:menu_Tool_Presets:

:menu_DP    Default cleanup preset.
cls
set RKill=Yes
set JRT=Yes
set TDSS=Yes
set Rogue=Yes
set ADW=Yes
set HitmanPro=Yes
set Zemana=Yes
set MBAR=No
set Malwarebytes=No
set Spybot=No
set CCleaner=Yes
set DefragSystem=Yes
set ImageChecker=Yes
set DriveChecker=Yes
set SystemRestore=Yes
set AutoClose=Yes
set ReviewLogs=Yes
set OpenNotes=Yes
set DeleteNotes=No
set DeleteLogs=No
set DeleteTools=Yes
set SelfDestruct=Yes
set Reboot=No
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

:menu_EA    Enable all preset.
cls
set RKill=Yes
set JRT=Yes
set TDSS=Yes
set Rogue=Yes
set ADW=Yes
set HitmanPro=Yes
set Zemana=Yes
set MBAR=Yes
set Malwarebytes=Yes
set Spybot=Yes
set CCleaner=Yes
set DefragSystem=Yes
set ImageChecker=Yes
set DriveChecker=Yes
set SystemRestore=Yes
set AutoClose=Yes
set ReviewLogs=Yes
set OpenNotes=Yes
set DeleteNotes=Yes
set DeleteLogs=Yes
set DeleteTools=Yes
set SelfDestruct=Yes
set Reboot=Yes
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

:menu_DA    Disable all preset.
cls
set RKill=No
set JRT=No
set TDSS=No
set Rogue=No
set ADW=No
set HitmanPro=No
set Zemana=No
set MBAR=No
set Malwarebytes=No
set Spybot=No
set CCleaner=No
set DefragSystem=No
set ImageChecker=No
set DriveChecker=No
set SystemRestore=No
set AutoClose=No
set ReviewLogs=No
set OpenNotes=No
set DeleteNotes=No
set DeleteLogs=No
set DeleteTools=No
set SelfDestruct=No
set Reboot=No
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Display execute options.
:menu_
:menu_Execute_Actions:
:menu_SC   Start Cleanup

if /i "%SystemRestore:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\Restore_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set SystemRestore=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%RKill:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\Rkill_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set RKill=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%JRT:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\JRT_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set JRT=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%TDSS:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\TDSS_Killer_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set TDSS=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%Rogue:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\RogueKiller_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set Rogue=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%ADW:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\ADW_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set ADW=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%HitmanPro:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\HitmanPro_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set HitmanPro=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%Zemana:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\Zemana_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set Zemana=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%MBAR:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\MBAR_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set MBAR=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%Malwarebytes:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\Malwarebytes_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set Malwarebytes=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%Spybot:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\Spybot_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set Spybot=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%CCleaner:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\CCleaner_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set CCleaner=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%DefragSystem:~0,1%"=="Y" (
  REM Ask if want to run externally
  CLS
  echo.
  echo  ^! USER INPUT
  echo =================================
  echo.
  choice /C YN /T 20 /D N /M "Do you want to run defrag externally?"
  IF errorlevel 2 goto Next_Boot_Defrag_Windows_Choice
  IF errorlevel 1 goto Run_External_Defrag_Windows
  REM Initiate external run
  :Run_External_Defrag_Windows
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  set Defrag_External=Yes
  start functions\Windows_Defrag
  set Defrag_External=No
  goto Defrag_Done
  :Next_Boot_Defrag_Windows_Choice
  REM Ask if want to schedule boot
  CLS
  echo.
  echo  ^! USER INPUT
  echo =================================
  echo.
  choice /C YN /T 20 /D N /M "Do you want to run defrag on the next boot?"
  IF errorlevel 2 goto choice_start
  IF errorlevel 1 goto Next_Boot_Defrag_Windows
  REM Schedule for next reboot/delete task after
  :Next_Boot_Defrag_Windows
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  xcopy /v "%Output%\Functions\Windows_Defrag.bat" "%SystemDrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\"
  cls
  echo.
  echo  ^! ALERT
  echo ===================================================================================
  echo.
  echo    Defrag scheduled for next boot.
  echo.
  echo    Reboot PC to start the defrag process.
  echo.
  echo ===================================================================================
  TIMEOUT 5
  goto Defrag_Done
  REM Ask which program to use to defrag
  :choice_start
  CLS
  echo.
  echo  ^! USER INPUT
  echo =================================
  echo.
  choice /C ADW /T 20 /D W /M "Which program do you want to defrag with [A] AusDefrag, [D] Defraggler or [W] Windows Defrag"
  IF errorlevel 3 goto Windows_Defrag_Function
  IF errorlevel 2 goto Defraggler
  IF errorlevel 1 goto AusDefrag
  REM Open Windows_Defrag function.
  :Windows_Defrag_Function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  set Defrag_Internal=Yes
  call functions\Windows_Defrag
  set Defrag_Internal=No
  goto Defrag_Done
  REM Open Defraggler_function.
  :Defraggler
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\Defraggler_function
  goto Defrag_Done
  REM Open AusDefrag_function.
  :AusDefrag
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\AusDefrag_function
  goto Defrag_Done
  REM Finish defrag
  :Defrag_Done
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set DefragSystem=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%ImageChecker:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\Image_Checker_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set ImageChecker=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%DriveChecker:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\ABRUPTCLOSE.txt
  call functions\CHKDSK_function
  echo No >!Output!\Functions\ABRUPTCLOSE.txt
  REM Create restore point
  set DriveChecker=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%ReviewLogs:~0,1%"=="Y" (
  REM Call function
  call functions\ReviewLogs_function
  REM Create restore point
  set ReviewLogs=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%DeleteLogs:~0,1%"=="Y" (
  REM Call function
  call functions\DeleteLogs_function
  REM Create restore point
  set DeleteLogs=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%DeleteTools:~0,1%"=="Y" (
  REM Call function
  call functions\DeleteTools_function
  REM Create restore point
  set DeleteTools=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%OpenNotes:~0,1%"=="Y" (
  REM Call function
  call functions\OpenNotes_function
  REM Create restore point
  set OpenNotes=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%DeleteNotes:~0,1%"=="Y" (
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%SelfDestruct:~0,1%"=="Y" (
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%AutoClose:~0,1%"=="Y" (
  REM Create restore point
  set AutoClose=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title [Exiting] Brainiacs Cleanup Tool v%TOOL_VERSION%
  CLS
  color 0c
  echo.
	echo  ^! WARNING
	echo ===================================================================================
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds.
	echo.
	echo ===================================================================================
  TIMEOUT 15
  REM Kill off any running Caffeine instances.
	tasklist | find /i "caffeine.exe" >nul
  if "%ERRORLEVEL%"=="0" (
    taskkill /IM caffeine.exe /f /t >nul
  )
  REM Delete notes
  if /i "%DeleteNotes:~0,1%"=="Y" (
    CLS
    REM Call function
    call functions\DeleteNotes_function
  )
  REM Initiate Self Destruct if selected prior.
  if /i "%SelfDestruct:~0,1%"=="Y" (
    echo -Deleted Brainiacs Script >> %Output%\Notes\Comments.txt
    if exist "%Output%\Functions" (
      rmdir /s /q "%Output%\Functions" >nul
    )
    (goto) 2>nul & del "%~f0"
  ) else (
    exit
	)
)

if /i "%Reboot:~0,1%"=="Y" (
  REM Create restore point
  set Reboot=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title [Rebooting] Brainiacs Cleanup Tool v%TOOL_VERSION%
  CLS
  color 0c
  echo.
	echo  ^! WARNING
	echo ===================================================================================
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will reboot the PC in 10 seconds.
  echo    Exit the tool to stop the reboot.
	echo.
	echo ===================================================================================
  TIMEOUT 10
  echo -Rebooted PC >> %Output%\Notes\Comments.txt
  REM Kill off any running Caffeine instances.
	tasklist | find /i "caffeine.exe" >nul
  if "%ERRORLEVEL%"=="0" (
    taskkill /IM caffeine.exe /f /t >nul
  )
  REM Delete notes
  if /i "%DeleteNotes:~0,1%"=="Y" (
    REM Call function
    call functions\DeleteNotes_function
  )
  REM Restart PC command
  shutdown -r -f -t 0
  REM Self-Destruct
  if /i "%SelfDestruct:~0,1%"=="Y" (
    echo -Deleted Brainiacs Script >> %Output%\Notes\Comments.txt
    if exist "%Output%\Functions" (
      rmdir /s /q "%Output%\Functions" >nul
    )
    (goto) 2>nul & del "%~f0"
  ) else (
    exit
  )
)

GOTO:EOF

:menu_VR   View Readme
if exist "%Output%\Readme.txt" (
  CLS
  REM Set title
  title [Readme] Brainiacs Cleanup Tool v%TOOL_VERSION%
	type  %Output%\Readme.txt
	echo.
  echo.
	pause
) else (
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    Readme not found.
  echo.
  echo    Returning to menu...
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
GOTO:EOF

:menu_VC   View Comments
if exist "%Output%\Notes\Comments.txt" (
  CLS
  REM Set title
  title [Comments] Brainiacs Cleanup Tool v%TOOL_VERSION%
	type  %Output%\Notes\Comments.txt
	echo.
  echo.
	pause
) else (
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    Comments not found.
  echo.
  echo    Returning to menu...
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
GOTO:EOF

:menu_VH   View Changelog
if exist "%Output%\Changelog.txt" (
  CLS
  REM Set title
  title [Changelog] Brainiacs Cleanup Tool v%TOOL_VERSION%
	type  %Output%\Changelog.txt
	echo.
  echo.
	pause
) else (
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo ===================================================================================
  echo.
  echo    Changelog not found.
  echo.
  echo    Returning to menu...
  echo.
  echo ===================================================================================
  TIMEOUT 5
  color 07
)
GOTO:EOF

REM -----------------------------------------------------------
REM  helper functions follow below here
REM -----------------------------------------------------------


:setPersist -- to be called to initialize persistent variables
REM           -- %*: set command arguments
set %*
GOTO:EOF


:getPersistentVars -- returns a comma separated list of persistent variables
REM                  -- %~1: reference to return variable
SETLOCAL
set retlist=
set parse=findstr /i /c:"call:setPersist" "%~f0%"^|find /v "ButNotThisLine"
for /f "tokens=2 delims== " %%a in ('"%parse%"') do (set retlist=!retlist!%%a,)
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" SET %~1=%retlist%
)
GOTO:EOF


:savePersistentVars -- Save values of persistent variables into a file
REM                   -- %~1: file name
SETLOCAL
echo.>"%~1"
call :getPersistentVars persvars
for %%a in (%persvars%) do (echo.SET %%a=!%%a!>>"%~1")
GOTO:EOF


:restorePersistentVars -- Restore the values of the persistent variables
REM                      -- %~1: batch file name to restore from
if exist "%FilePersist%" call "%FilePersist%"
GOTO:EOF


:getNextInList -- return next value in list
REM              -- %~1 - in/out ref to current value, returns new value
REM              -- %~2 - in     choice list, must start with delimiter which must not be '@'
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
