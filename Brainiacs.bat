@ECHO OFF

REM Maximize Window
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b
REM if not "%1" == "min" start /MIN cmd /c %0 min & exit/b

REM Run as admin
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%ERRORLEVEL%' == '0' ( goto gotPrivileges ) ELSE ( goto getPrivileges )
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
set ABORT_CLEANUP=no
set VARID=unidentified
set VARPHN=unidentified
set VAR_ADDT_NOTES=None
set SKIP_DEFRAG=no
set VAR_GEEK=None
set TEST_UPDATE_MASTER=undetected
set PASSWORD=undetected
set PID_BRAINIACS=undetected
set EMAIL_SEND=undetected
set ROGUE_QUICKSCAN=undetected
set TEST_UPDATE_MASTER=undetected
set TEST_UPDATE_EXPERIMENTAL=undetected
set PREVIOUS_USER=undetected
set Defrag_External=undetected
set DefragSystem_choice=undetected
set SKIP_DELETE_TOOLS=undetected

set CSG_USR_ID=unidentified
set SUB_PHN=unidentified
set ADDT_NOTES=unidentified

REM Functions menu variables
set Geek_choice=unidentified
set RKill_choice=unidentified
set JRT_choice=unidentified
set TDSS_choice=unidentified
set Rogue_choice=unidentified
set ADW_choice=unidentified
set HitmanPro_choice=unidentified
set Zemana_choice=unidentified
set MBAR_choice=unidentified
set Malwarebytes_choice=unidentified
set Spybot_choice=unidentified
set CCleaner_choice=unidentified
set DefragSystem_choice=unidentified
set ImageChecker_choice=unidentified
set DriveChecker_choice=unidentified
set No_selection_choice_function=unidentified

REM Options menu variables
set SystemRestore_choice=unidentified
set EmailNotes_choice=unidentified
set AutoClose_choice=unidentified
set ReviewLogs_choice=unidentified
set OpenNotes_choice=unidentified
set DeleteNotes_choice=unidentified
set DeleteLogs_choice=unidentified
set DeleteTools_choice=unidentified
set SelfDestruct_choice=unidentified
set Reboot_choice=unidentified
set No_selection_choice_options=unidentified

REM Define the filename where persistent variables get stored
set FilePersist=%Output%\Functions\Variables\Persist.cmd&

REM Functions menu variables persistent
call:setPersist Geek_choice=unidentified
call:setPersist RKill_choice=unidentified
call:setPersist JRT_choice=unidentified
call:setPersist TDSS_choice=unidentified
call:setPersist Rogue_choice=unidentified
call:setPersist ADW_choice=unidentified
call:setPersist HitmanPro_choice=unidentified
call:setPersist Zemana_choice=unidentified
call:setPersist MBAR_choice=unidentified
call:setPersist Malwarebytes_choice=unidentified
call:setPersist Spybot_choice=unidentified
call:setPersist CCleaner_choice=unidentified
call:setPersist DefragSystem_choice=unidentified
call:setPersist ImageChecker_choice=unidentified
call:setPersist DriveChecker_choice=unidentified

REM Options menu variables persistent
call:setPersist SystemRestore_choice=unidentified
call:setPersist EmailNotes_choice=unidentified
call:setPersist AutoClose_choice=unidentified
call:setPersist ReviewLogs_choice=unidentified
call:setPersist OpenNotes_choice=unidentified
call:setPersist DeleteNotes_choice=unidentified
call:setPersist DeleteLogs_choice=unidentified
call:setPersist DeleteTools_choice=unidentified
call:setPersist SelfDestruct_choice=unidentified
call:setPersist Reboot_choice=unidentified

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

REM Create Variables folder if not found
if not exist "%Output%\Functions\Variables\" (
  mkdir "%Output%\Functions\Variables" >nul
)

REM Create notes folder if not found
if not exist "%Output%\Notes\" (
  mkdir "%Output%\Notes" >nul
)

REM Create logs folder if not found
if not exist "%Output%\Logs\" (
  mkdir "%Output%\Logs" >nul
)

REM Pull ABRUPTCLOSE var if present
if exist "!Output!\Functions\Variables\ABRUPTCLOSE.txt" (
    set /p ABRUPTCLOSE=<!Output!\Functions\Variables\ABRUPTCLOSE.txt
)

REM Check if 32/64bit windows
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

REM Get PID of BrainiacsAutoCleanupTool CMD
set T=%TEMP%\sthUnique.tmp
wmic process where (Name="WMIC.exe" AND CommandLine LIKE "%%%TIME%%%") get ParentProcessId /value | find "ParentProcessId" >%T%
set /P A=<%T%
REM Set variables
set PID_BRAINIACS=%A:~16%%

REM Skip to menu if debug file is found
if exist "%Output%\Debug" (
  %Output%\Functions\Menu\MessageBox "Debug file detected.\n\nEntering Debugging mode." "[WARNING] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N
  goto Functions_Menu
)

REM Ask for password for beta testing purposes
:Password_Menu
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the password in order to access the tool:" "[PASSWORD] Brainiacs Cleanup Tool v%TOOL_VERSION%" "password" /S /H:150 /W:280`) DO (
  IF /I "%%G"=="Bluemoon" (
    REM Continue if correct password was entered
    goto No_Test_Continue
  ) ELSE if "%%G"=="RedRuby" (
    REM Continue to testing mode if correct password was entered
    %Output%\Functions\Menu\MessageBox "Entering hidden testing mode." "[WARNING] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N >nul
    goto Choice_Test_Upgrade_All
  )
)
REM Exit if cancel/X is pressed or no input is entered
exit /b

REM Ask to upgrade all functions if in testing mode
:Choice_Test_Upgrade_All

REM Ask to upgrade from latest commits
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Do you want to update from the latest commits?\n\nThis may break some things." "[WARNING] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
  IF /I "%%G"=="Yes" (
    goto :Test_Upgrade_All_Accept
  ) ELSE (
    goto :Test_Upgrade_All_Decline
  )
)

REM Ask which branch to upgrade from
:Test_Upgrade_All_Accept
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\RADIOBUTTONBOX  "Master;Experimental" "Which branch do you want to update from?" "[NOTICE] Brainiacs Cleanup Tool v%TOOL_VERSION%" /W:280 /C:2`) DO (
  IF /I "%%G"=="Master" (
    goto :Test_Upgrade_Master
  ) ELSE (
    goto :Test_Upgrade_Experimental
  )
)

REM Upgrade from master branch
:Test_Upgrade_Master
set TEST_UPDATE_MASTER=yes
call functions\Update_function
set TEST_UPDATE_MASTER=no
goto Test_Upgrade_All_Decline

REM Upgrade from experimenal branch
:Test_Upgrade_Experimental
set TEST_UPDATE_EXPERIMENTAL=yes
call functions\Update_function
set TEST_UPDATE_EXPERIMENTAL=no
goto Test_Upgrade_All_Decline

REM Ask to enable debugging
:Test_Upgrade_All_Decline
%Output%\Functions\Menu\MessageBox "Skipping checks and entering menu." "[WARNING] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N
REM Skip to menu without checks
goto Functions_Menu

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
if %WIN_VER_NUM% LSS 6.0 set ABORT_CLEANUP=yes

REM If 32 bit os then set variable to abort
if %OS%==32BIT set ABORT_CLEANUP=yes

REM Display disclaimer
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "I am not responsible if this program ends up causing any harm, blows up a computer or causes a nuclear war.\n\nYou have been warned.\n\nAll logs will be placed in the folder: \"%cd%\Logs.\"\n\nThis tools also generates notes for the account. These will be\nplaced in the folder: \"%cd%\Notes.\"\n\nThe program should already run as Administrator, however if it does not you'll have to run the program as Administrator manually.\n\nDo you accept responsibility for running this tool\u003F" "[DISCLAIMER] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:I /O:N`) DO (
  IF /I "%%G"=="Yes" (
    goto :accept_yes
  ) ELSE (
    goto :accept_no
  )
)

REM Display message if they do not accept the disclaimer
:accept_no
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "You did not accept responsibility for running this tool.\n\nIf you decide to grow up and accept responsibility re-run the tool and accept the disclaimer." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:R /I:E /O:N`) DO (
  IF /I "%%G"=="Retry" (
    goto :No_Test_Continue
  ) ELSE (
    exit /b
  )
)

REM If disclaimer was accepted check for administrator privilage
:accept_yes
if /i not "%SAFE_MODE%"=="yes" (
  fsutil dirty query %systemdrive% >nul
  if /i not !ERRORLEVEL!==0 (
    FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "The Brainiacs Cleanup Tool v%TOOL_VERSION% doesn't think it is running as an Administrator.\nYou MUST run with full Administrator rights to function correctly.\n\nClose this window and re-run the cleanup tool as an Administrator.\n(right-click Brainiacs.bat and click 'Run as Administrator')" "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:R /I:E /O:N`) DO (
      IF /I "%%G"=="Retry" (
        goto :init
      ) ELSE (
        exit /b
      )
    )
  )
)

REM Quit if OS version is unsupported
if %ABORT_CLEANUP%==yes (
  %Output%\Functions\Menu\MessageBox "The Brainiacs Cleanup Tool v%TOOL_VERSION% does not support '%WIN_VER%' '%OS%.'\n\nYou will have to run your tools manually.\n\nSorry.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:15 >nul
  exit /b
)

REM Check if tools folder exists
if not exist "%Output%\Tools" (
  %Output%\Functions\Menu\MessageBox "Tools folder not found.\n\nYou MUST have tools folder under '%Output%'\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:15 >nul
  exit /b
)

REM Check for functions folder
if not exist "%Output%\Functions" (
  %Output%\Functions\Menu\MessageBox "Functions folder not found.\n\nYou MUST have functions folder under %Output%\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:15 >nul
  exit /b
)

REM Setup resume state if not found, if found ask if you want to resume the last state
if "%ABRUPTCLOSE%"=="yes" (
  if exist "!Output!\Functions\Variables\ABRUPTCLOSE.txt" (
    FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Abrupt stop detected.\n\nDo you want to restore the session\u003F" "[QUESTION] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:Q /O:N`) DO (
      IF /I "%%G"=="Yes" (
    	  call:restorePersistentVars "%FilePersist%"
    	  REM Start menu interface
    	  goto :Execute_Menu
      ) ELSE (
        REM Set var to delete restore point on start
        set DELETE_RESTORE=Yes
        REM Delete ABRUTCLOSE file
        del "!Output!\Functions\Variables\ABRUPTCLOSE.txt"
      )
    )
  )
)

REM Start notes template
echo ----------------------------------------- >> %Output%\Notes\Comments.txt

REM Ask if the session was picked up
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Did you pickup this session\u003F" "[QUESTION] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:Q /O:N`) DO (
  IF /I "%%G"=="Yes" (
    goto :Session_Pickup
  ) ELSE (
    goto :Session_New
  )
)

REM Start session pickup if selected by the user.
:Session_Pickup

REM Restore variables from last session if present
if exist "%FilePersist%" (
  call:restorePersistentVars "%FilePersist%"
)

REM Show comments made so far.
if exist "%Output%\Notes\Comments.txt" (
  REM Pull previous user of session from notes
  set /p PREVIOUS_USER=<!Output!\Notes\Comments.txt
  REM Display message
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Do you want to see the comments created so far\u003F" "[QUESTION] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:Q /O:N`) DO (
    IF /I "%%G"=="Yes" (
      %Output%\Functions\Menu\MessageBox "Session was started by '%PREVIOUS_USER%'\n\nPress 'OK' to show the comments created so far." "[INFORMATION] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:I /O:N >nul
      REM Type comments out if user wants
      CLS
    	type  %Output%\Notes\Comments.txt
      pause
      CLS
    )
  )
) ELSE (
  REM Error out is comments are not found
  %Output%\Functions\Menu\MessageBox "Previous comments not found.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 5 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:5 >nul
)

REM Ask & enter new CSG user ID into notes
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter your CSG user ID:" "[CSG ID] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280 /M:"L00" /U /I`) DO (
  REM Set variable
  set CSG_USR_ID=%%G
)
REM Set comments based on variable
IF NOT "!CSG_USR_ID!"=="unidentified" (
  echo CSG User ID: "!CSG_USR_ID!" >> "%Output%\Notes\Comments.txt"
) else (
  echo CSG User ID: "*Not entered*" >> "%Output%\Notes\Comments.txt"
)

REM Enter general cleanup as the reason
echo. >> "%Output%\Notes\Comments.txt"
echo Continuing general cleanup. >> "%Output%\Notes\Comments.txt"
echo. >> "%Output%\Notes\Comments.txt"

REM Ask & enter any additional notes
FOR /F "usebackq tokens=*" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter any additional notes:" "[ADDT NOTES] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280`) DO (
  REM Set variable
  set ADDT_NOTES=%%G
)
REM Set comments based on variable
IF NOT "!ADDT_NOTES!"=="unidentified" (
  echo Additional Notes: "!ADDT_NOTES!" >> "%Output%\Notes\Comments.txt"
) else (
  echo Additional Notes: "None" >> "%Output%\Notes\Comments.txt"
)

REM Enter pickup notes
echo --- >> "%Output%\Notes\Comments.txt"
echo -Picked up session from "%PREVIOUS_USER%" >> "%Output%\Notes\Comments.txt"

REM Start menu
goto Functions_Menu

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

REM Ask & enter new CSG user ID into notes
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter your CSG user ID:" "[CSG ID] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280 /M:"L00" /U /I`) DO (
  REM Set variable
  set CSG_USR_ID=%%G
)
REM Set comments based on variable
IF NOT "!CSG_USR_ID!"=="unidentified" (
  echo CSG User ID: "!CSG_USR_ID!" >> "%Output%\Notes\Comments.txt"
) else (
  echo CSG User ID: "*Not entered*" >> "%Output%\Notes\Comments.txt"
)

REM Ask & enter Phone number into notes
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the subscribers Phone number:" "[PHN #] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280 /M:">000\-000\-0000" /U /I`) DO (
  REM Set variable
  set SUB_PHN=%%G
)
REM Set comments based on variable
IF NOT "!SUB_PHN!"=="unidentified" (
  echo Phone Number: "!SUB_PHN!" >> "%Output%\Notes\Comments.txt"
) else (
  echo Phone Number: "*Not entered*" >> "%Output%\Notes\Comments.txt"
)

REM Enter general cleanup reason
echo. >> "%Output%\Notes\Comments.txt"
echo General Cleanup. >> "%Output%\Notes\Comments.txt"
echo. >> "%Output%\Notes\Comments.txt"

REM Ask & enter any additional notes
FOR /F "usebackq tokens=*" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter any additional notes:" "[ADDT NOTES] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280`) DO (
  REM Set variable
  set ADDT_NOTES=%%G
)
REM Set comments based on variable
IF NOT "!ADDT_NOTES!"=="unidentified" (
  echo Additional Notes: "!ADDT_NOTES!" >> "%Output%\Notes\Comments.txt"
) else (
  echo Additional Notes: "None" >> "%Output%\Notes\Comments.txt"
)

REM Enter break for notes
echo --- >> "%Output%\Notes\Comments.txt"

REM Add check for restore deletion to prevent any remnants from messing with the new session.
if /i "!DELETE_RESTORE!"=="Yes" (
  del /Q "%FilePersist%" >nul
  del "!Output!\Functions\Variables\ABRUPTCLOSE.txt" >nul
)

REM Functions Menu
:Functions_Menu

FOR /F "usebackq tokens=1-15* delims=;" %%A IN (`%Output%\Functions\Menu\MultipleChoiceBox /L:"OK=Select Options" "Geek Uninstaller;Rkill;JRT;TDSS Killer;Rogue Killer;ADW;Hitman Pro;Zemana;MBAR;Malwarebytes (Experimental);Spybot (Experimental);Ccleaner;Defrag;Check Windows image for errors;Check Windows drive for errors" "Select a tool from the list below by clicking the corresponding box.\nOnce you are okay with your selection click "OK" to start the automated process." "[MENU] Brainiacs Cleanup Tool v%TOOL_VERSION%"`) DO (

  for /f "tokens=* delims=;" %%a in ("%%^") do (

    REM Check %%A & set appropriate variable
    IF "%%A"=="Geek Uninstaller" (set Geek_choice=Yes)
    IF "%%A"=="Rkill" (set RKill_choice=Yes)
    IF "%%A"=="JRT" (set JRT_choice=Yes)
    IF "%%A"=="TDSS Killer" (set TDSS_choice=Yes)
    IF "%%A"=="Rogue Killer" (set Rogue_choice=Yes)
    IF "%%A"=="ADW" (set ADW_choice=Yes)
    IF "%%A"=="Hitman Pro" (set HitmanPro_choice=Yes)
    IF "%%A"=="Zemana" (set Zemana_choice=Yes)
    IF "%%A"=="MBAR" (set MBAR_choice=Yes)
    IF "%%A"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%A"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%A"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%A"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%A"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%A"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)
    IF "%%A"=="" (set No_selection_choice_function=Yes) else (set No_selection_choice_function=No)

    REM Check %%B & set appropriate variable
    IF "%%B"=="Rkill" (set RKill_choice=Yes)
    IF "%%B"=="JRT" (set JRT_choice=Yes)
    IF "%%B"=="TDSS Killer" (set TDSS_choice=Yes)
    IF "%%B"=="Rogue Killer" (set Rogue_choice=Yes)
    IF "%%B"=="ADW" (set ADW_choice=Yes)
    IF "%%B"=="Hitman Pro" (set HitmanPro_choice=Yes)
    IF "%%B"=="Zemana" (set Zemana_choice=Yes)
    IF "%%B"=="MBAR" (set MBAR_choice=Yes)
    IF "%%B"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%B"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%B"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%B"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%B"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%B"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%C & set appropriate variable
    IF "%%C"=="JRT" (set JRT_choice=Yes)
    IF "%%C"=="TDSS Killer" (set TDSS_choice=Yes)
    IF "%%C"=="Rogue Killer" (set Rogue_choice=Yes)
    IF "%%C"=="ADW" (set ADW_choice=Yes)
    IF "%%C"=="Hitman Pro" (set HitmanPro_choice=Yes)
    IF "%%C"=="Zemana" (set Zemana_choice=Yes)
    IF "%%C"=="MBAR" (set MBAR_choice=Yes)
    IF "%%C"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%C"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%C"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%C"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%C"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%C"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%D & set appropriate variable
    IF "%%D"=="TDSS Killer" (set TDSS_choice=Yes)
    IF "%%D"=="Rogue Killer" (set Rogue_choice=Yes)
    IF "%%D"=="ADW" (set ADW_choice=Yes)
    IF "%%D"=="Hitman Pro" (set HitmanPro_choice=Yes)
    IF "%%D"=="Zemana" (set Zemana_choice=Yes)
    IF "%%D"=="MBAR" (set MBAR_choice=Yes)
    IF "%%D"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%D"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%D"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%D"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%D"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%D"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%E & set appropriate variable
    IF "%%E"=="Rogue Killer" (set Rogue_choice=Yes)
    IF "%%E"=="ADW" (set ADW_choice=Yes)
    IF "%%E"=="Hitman Pro" (set HitmanPro_choice=Yes)
    IF "%%E"=="Zemana" (set Zemana_choice=Yes)
    IF "%%E"=="MBAR" (set MBAR_choice=Yes)
    IF "%%E"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%E"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%E"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%E"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%E"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%E"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%F & set appropriate variable
    IF "%%F"=="ADW" (set ADW_choice=Yes)
    IF "%%F"=="Hitman Pro" (set HitmanPro_choice=Yes)
    IF "%%F"=="Zemana" (set Zemana_choice=Yes)
    IF "%%F"=="MBAR" (set MBAR_choice=Yes)
    IF "%%F"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%F"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%F"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%F"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%F"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%F"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%G & set appropriate variable
    IF "%%G"=="Hitman Pro" (set HitmanPro_choice=Yes)
    IF "%%G"=="Zemana" (set Zemana_choice=Yes)
    IF "%%G"=="MBAR" (set MBAR_choice=Yes)
    IF "%%G"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%G"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%G"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%G"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%G"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%G"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%H & set appropriate variable
    IF "%%H"=="Zemana" (set Zemana_choice=Yes)
    IF "%%H"=="MBAR" (set MBAR_choice=Yes)
    IF "%%H"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%H"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%H"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%H"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%H"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%H"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%I & set appropriate variable
    IF "%%I"=="MBAR" (set MBAR_choice=Yes)
    IF "%%I"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%I"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%I"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%I"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%I"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%I"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%J & set appropriate variable
    IF "%%J"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes)
    IF "%%J"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%J"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%J"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%J"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%J"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%K & set appropriate variable
    IF "%%K"=="Spybot (Experimental)" (set Spybot_choice=Yes)
    IF "%%K"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%K"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%K"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%K"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%L & set appropriate variable
    IF "%%L"=="Ccleaner" (set CCleaner_choice=Yes)
    IF "%%L"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%L"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%L"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%M & set appropriate variable
    IF "%%M"=="Defrag" (set DefragSystem_choice=Yes)
    IF "%%M"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%M"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%N & set appropriate variable
    IF "%%N"=="Check Windows image for errors" (set ImageChecker_choice=Yes)
    IF "%%N"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

    REM Check %%O & set appropriate variable
    IF "%%O"=="Check Windows drive for errors" (set DriveChecker_choice=Yes)

  )
)

REM Check if any button was pressed.
IF ERRORLEVEL 0 (
  REM Check if user selected nothing, if so then ask to exit the tool
  IF /i "%No_selection_choice_function%"=="No" (
    REM Set variables
    set No_selection_choice_function=unidentified
    goto Options_Menu
  )
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "No options were selected or you are trying to quit.\n\nDo you want to quit the cleanup tool\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:A /O:N`) DO (
    IF /I "%%G"=="Yes" (
      exit /b
    ) else (
      REM Set variables
      set No_selection_choice_function=unidentified
      goto Functions_Menu
    )
  )
)

REM Options Menu
:Options_Menu

FOR /F "usebackq tokens=1-10* delims=;" %%A IN (`%Output%\Functions\Menu\MultipleChoiceBox /L:"OK=Start Cleanup" "Create system restore point;Email notes (Experimental);Auto close when done;Review Logs when done;Open comments when done;Delete comments when done;Delete logs when done;Delete tools when done;Self-Destruct Cleanup Tool when done;Reboot when done" "Select an option or preset from the list below by clicking the corresponding box.\nOnce you are okay with your selection click "OK" to start the automated process." "[MENU] Brainiacs Cleanup Tool v%TOOL_VERSION%"`) DO (
  for /f "tokens=1-10* delims=;" %%a in ("%%^") do (

    REM Check %%A & set appropriate variable
    IF "%%A"=="Create system restore point" (set SystemRestore_choice=Yes)
    IF "%%A"=="Email notes (Experimental)" (set EmailNotes_choice=Yes)
    IF "%%A"=="Auto close when done" (set AutoClose_choice=Yes)
    IF "%%A"=="Review Logs when done" (set ReviewLogs_choice=Yes)
    IF "%%A"=="Open comments when done" (set OpenNotes_choice=Yes)
    IF "%%A"=="Delete comments when done" (set DeleteNotes_choice=Yes)
    IF "%%A"=="Delete logs when done" (set DeleteLogs_choice=Yes)
    IF "%%A"=="Delete tools when done" (set DeleteTools_choice=Yes)
    IF "%%A"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes)
    IF "%%A"=="Reboot when done" (set Reboot_choice=Yes)
    IF "%%A"=="" (set No_selection_choice_options=Yes) else (set No_selection_choice_options=No)

    REM Check %%B & set appropriate variable
    IF "%%B"=="Email notes (Experimental)" (set EmailNotes_choice=Yes)
    IF "%%B"=="Auto close when done" (set AutoClose_choice=Yes)
    IF "%%B"=="Review Logs when done" (set ReviewLogs_choice=Yes)
    IF "%%B"=="Open comments when done" (set OpenNotes_choice=Yes)
    IF "%%B"=="Delete comments when done" (set DeleteNotes_choice=Yes)
    IF "%%B"=="Delete logs when done" (set DeleteLogs_choice=Yes)
    IF "%%B"=="Delete tools when done" (set DeleteTools_choice=Yes)
    IF "%%B"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes)
    IF "%%B"=="Reboot when done" (set Reboot_choice=Yes)

    REM Check %%C & set appropriate variable
    IF "%%C"=="Auto close when done" (set AutoClose_choice=Yes)
    IF "%%C"=="Review Logs when done" (set ReviewLogs_choice=Yes)
    IF "%%C"=="Open comments when done" (set OpenNotes_choice=Yes)
    IF "%%C"=="Delete comments when done" (set DeleteNotes_choice=Yes)
    IF "%%C"=="Delete logs when done" (set DeleteLogs_choice=Yes)
    IF "%%C"=="Delete tools when done" (set DeleteTools_choice=Yes)
    IF "%%C"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes)
    IF "%%C"=="Reboot when done" (set Reboot_choice=Yes)

    REM Check %%D & set appropriate variable
    IF "%%D"=="Review Logs when done" (set ReviewLogs_choice=Yes)
    IF "%%D"=="Open comments when done" (set OpenNotes_choice=Yes)
    IF "%%D"=="Delete comments when done" (set DeleteNotes_choice=Yes)
    IF "%%D"=="Delete logs when done" (set DeleteLogs_choice=Yes)
    IF "%%D"=="Delete tools when done" (set DeleteTools_choice=Yes)
    IF "%%D"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes)
    IF "%%D"=="Reboot when done" (set Reboot_choice=Yes)

    REM Check %%E & set appropriate variable
    IF "%%E"=="Open comments when done" (set OpenNotes_choice=Yes)
    IF "%%E"=="Delete comments when done" (set DeleteNotes_choice=Yes)
    IF "%%E"=="Delete logs when done" (set DeleteLogs_choice=Yes)
    IF "%%E"=="Delete tools when done" (set DeleteTools_choice=Yes)
    IF "%%E"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes)
    IF "%%E"=="Reboot when done" (set Reboot_choice=Yes)

    REM Check %%F & set appropriate variable
    IF "%%F"=="Delete comments when done" (set DeleteNotes_choice=Yes)
    IF "%%F"=="Delete logs when done" (set DeleteLogs_choice=Yes)
    IF "%%F"=="Delete tools when done" (set DeleteTools_choice=Yes)
    IF "%%F"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes)
    IF "%%F"=="Reboot when done" (set Reboot_choice=Yes)

    REM Check %%G & set appropriate variable
    IF "%%G"=="Delete logs when done" (set DeleteLogs_choice=Yes)
    IF "%%G"=="Delete tools when done" (set DeleteTools_choice=Yes)
    IF "%%G"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes)
    IF "%%G"=="Reboot when done" (set Reboot_choice=Yes)

    REM Check %%H & set appropriate variable
    IF "%%H"=="Delete tools when done" (set DeleteTools_choice=Yes)
    IF "%%H"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes)
    IF "%%H"=="Reboot when done" (set Reboot_choice=Yes)

    REM Check %%I & set appropriate variable
    IF "%%I"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes)
    IF "%%I"=="Reboot when done" (set Reboot_choice=Yes)

    REM Check %%J & set appropriate variable
    IF "%%J"=="Reboot when done" (set Reboot_choice=Yes)
  )
)

REM Check if any button was pressed.
IF ERRORLEVEL 0 (
  REM Check if user selected nothing, if so then ask to exit the tool
  IF /i "%No_selection_choice_options%"=="No" (
    REM Set variables
    set No_selection_choice_options=unidentified
    goto Execute_Menu
  )
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "No options were selected or you are trying to quit.\n\nDo you want to continue with no options selected\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:N /I:A /O:N`) DO (
    IF /I "%%G"=="Yes" (
      goto Execute_Menu
    )
    IF /I "%%G"=="No" (
     REM Set variables
     set No_selection_choice_options=unidentified
     goto Options_Menu
    ) else (
      exit /b
    )
  )
)

REM Execute Menu
:Execute_Menu

if /i "%EmailNotes_choice%"=="Yes" (
  REM ---------------------------TEMPORARIY------------------------------------
  REM ADD TO DISABLE EMAIL UNLESS TESTING.
  if "%PASSWORD%"=="RedRuby" (
    REM Create restore point
    echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
    REM Call function
    call functions\Email_function
    REM Create restore point
    echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
    REM Set variables
    set EmailNotes=No
  )
  REM ADD TO DISABLE EMAIL UNLESS TESTING.
  REM ---------------------------TEMPORARIY------------------------------------
)

if /i "%SystemRestore_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\Restore_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set SystemRestore_choice=No
) else /i "%SystemRestore_choice%"=="No" (
  if /i "%Malwarebytes_choice%"=="Yes" (
    FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Malwarebytes requires 'System Restore' to be enabled to be able to run.\n\nDo you want to enable it\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
      IF /I "%%G"=="Yes" (
        REM Set variables
        set SystemRestore_choice=Yes
        REM Create restore point
        echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
        REM Call function
        call functions\Restore_function
        REM Set variables if spybot is not selected to prevent double prompt
        if /i "%Spybot_choice%"=="No" (
          set SystemRestore_choice=No
        )
      ) else (
        set Malwarebytes_choice=No
      )
    )
  )
  if /i "%Spybot_choice%"=="Yes" (
    FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Spybot requires 'System Restore' to be enabled to be able to run.\n\nDo you want to enable it\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
      IF /I "%%G"=="Yes" (
        REM Set variables
        set SystemRestore_choice=Yes
        REM Create restore point
        echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
        REM Call function
        call functions\Restore_function
        REM Set variables
        set SystemRestore_choice=No
      ) else (
        set Spybot_choice=No
      )
    )
  )
)

if /i "%Geek_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Start function
  if exist "%Output%\Tools\Geek\geek.exe" (
    start /WAIT "Geek" "%Output%\Tools\Geek\geek.exe"
    echo -Ran Geek Uninstaller >> %Output%\Notes\Comments.
  ) else (
    REM Display message showing that tool was not found
    %Output%\Functions\Menu\MessageBox "Geek uninstaller not found.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10
  )
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set Geek_choice=No
)

if /i "%RKill_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\Rkill_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set RKill_choice=No
)

if /i "%JRT_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\JRT_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set JRT_choice=No
)

if /i "%TDSS_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\TDSS_Killer_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set TDSS_choice=No
)

if /i "%Rogue_choice%"=="Yes" (
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "RogueKiller is able to perform a quick scan.\n\nWould you like to perform a quick scan\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
    IF /I "%%G"=="Yes" (
      REM Set variables
      set ROGUE_QUICKSCAN=Yes
    ) else (
      REM Set variables
      set ROGUE_QUICKSCAN=No
    )
  )
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\RogueKiller_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set Rogue_choice=No
)

if /i "%ADW_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\ADW_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set ADW_choice=No
)

if /i "%HitmanPro_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\HitmanPro_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set HitmanPro_choice=No
)

if /i "%Zemana_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\Zemana_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set Zemana_choice=No
)

if /i "%MBAR_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\MBAR_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set MBAR_choice=No
)

if /i "%Malwarebytes_choice%"=="Yes" (
  REM ---------------------------TEMPORARIY------------------------------------
  REM ADD TO DISABLE MALWAREBYTES UNLESS TESTING.
  if "%PASSWORD%"=="RedRuby" (
    REM Create restore point
    echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
    REM Call function
    call functions\Malwarebytes_function
    REM Create restore point
    echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
    REM Set variables
    set Malwarebytes_choice=No
  )
  REM ADD TO DISABLE MALWAREBYTES UNLESS TESTING.
  REM ---------------------------TEMPORARIY------------------------------------
)

if /i "%Spybot_choice%"=="Yes" (
  REM ---------------------------TEMPORARIY------------------------------------
  REM ADD TO DISABLE SPYBOT UNLESS TESTING.
  if not "%PASSWORD%"=="RedRuby" (
    REM Create restore point
    echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
    REM Call function
    call functions\Spybot_function
    REM Create restore point
    echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
    REM Set variables
    set Spybot_choice=No
  )
  REM ADD TO DISABLE SPYBOT UNLESS TESTING.
  REM ---------------------------TEMPORARIY------------------------------------
  REM Check if system restore is enabled
)

if /i "%CCleaner_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  REM call functions\CCleaner_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set CCleaner_choice=No
)

if /i "%DefragSystem_choice%"=="Yes" (
  REM Ask if want to run externally
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Do you want to run defrag externally\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
    IF /I "%%G"=="Yes" (
      REM Set variables
      set Defrag_External=Yes
    ) else (
      REM Set variables
      set Defrag_External=No
    )
  )

  REM Ask if want to schedule boot if not ran externally
  if /i "!Defrag_External!"=="No" (
    FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Do you want to run defrag on the next boot\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
      IF /I "%%G"=="Yes" (
        REM Move defrag function to boot folder
        xcopy /v "%Output%\functions\Windows_Defrag_Function.bat" "%SystemDrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\"
        REM Display message showing defrag will start next boot
        %Output%\Functions\Menu\MessageBox "Defrag is scheduled to run on next boot.\n\nCleanup will now continue." "[INFORMATION] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:I /O:N /T:10
        REM Continue cleanup
        goto Continue_ImageChecker
      )
    )
  )

  REM Initiate defrag based on variables
    REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\Windows_Defrag_Function
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set DefragSystem_choice=No
)

REM Set tag for Continuing Cleanup
:Continue_ImageChecker
if /i "%ImageChecker_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\Image_Checker_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set ImageChecker_choice=No
)

if /i "%DriveChecker_choice%"=="Yes" (
  REM Create restore point
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Call function
  call functions\CHKDSK_function
  REM Create restore point
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Set variables
  set DriveChecker_choice=No
)

if /i "%ReviewLogs_choice%"=="Yes" (
  REM Call function
  call functions\ReviewLogs_function
  REM Set variables
  set ReviewLogs_choice=No
)

if /i "%DeleteLogs_choice%"=="Yes" (
  REM Call function
  call functions\DeleteLogs_function
  REM Set variables
  set DeleteLogs_choice=No
)

if /i "%DeleteTools_choice%"=="Yes" (
  REM set SKIP_DELETE_TOOLS if autoclose or reboot was selected
  if /i "%AutoClose_choice%"=="No" (set SKIP_DELETE_TOOLS=Yes)
  if /i "%Reboot_choice%"=="No" (set SKIP_DELETE_TOOLS=Yes)
  REM If skip delete then display a message
  if /i "%SKIP_DELETE_TOOLS%"=="Yes" (
    FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Tool deletion requires the 'Auto-Close' or 'Reboot' option to be enabled to be able to run.\n\nDo you want to enable autoclose\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
      IF /I "%%G"=="Yes" (
        REM Set variables
        set DeleteTools_choice=Yes
        set AutoClose_choice=Yes
        REM Create restore point
        echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
        REM Call function
        call functions\DeleteTools_function
        REM Set variables
        set DeleteTools_choice=No
      ) else (
        set Malwarebytes_choice=No
      )
    )
  ) else (
    REM Set variables
    set DeleteTools_choice=Yes
    REM Create restore point
    echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
    REM Call function
    call functions\DeleteTools_function
    REM Set variables
    set DeleteTools_choice=No
  )
)

if /i "%OpenNotes_choice%"=="Yes" (
  REM Call function
  call functions\OpenNotes_function
  REM Set variables
  set OpenNotes_choice=No
)

if /i "%DeleteNotes_choice%"=="Yes" (
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "You have selected to delete the comments when done.\n\nAre you sure you want to delete the notes\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
    IF /I "%%G"=="Yes" (
      REM Set variables
      set DeleteNotes_choice=Yes
      REM Call function
      call functions\DeleteNotes_function
      REM Set variables
      set DeleteNotes_choice=No
    ) else (
      REM Set variables
      set DeleteNotes_choice=No
    )
  )
)

if /i "%SelfDestruct_choice%"=="Yes" (
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "You have selected to self-destruct when done.\n\nAre you sure you want to self-destruct\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
    IF /I "%%G"=="Yes" (
      REM Set variables
      set SelfDestruct_choice=Yes
    ) else (
      REM Set variables
      set SelfDestruct_choice=No
    )
  )
)

REM Self-Destruct if it was selected.
if /i "%SelfDestruct_choice%"=="Yes" (
  REM Place in notes that tool self-destructed
  echo -Deleted Brainiacs Script >> %Output%\Notes\Comments.txt
  REM Delete function folder if found
  if exist "%Output%\Functions" (
    rmdir /s /q "%Output%\Functions" >nul
  )
  REM Self-Destruct
  (goto) 2>nul & del "%~f0"
)

REM Reboot if it was selected.
if /i "%Reboot_choice%"=="Yes" (
  REM Restart PC command
  shutdown -r -f -t 0
)

REM AutoClose if it was selected.
if /i "%AutoClose_choice%"=="Yes" (
  REM Exit tool
  exit /b
)

REM Show message to go back to menu when cleanup is done and no end options were selected.
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Cleanup completed.\n\nWould you like to go back to the main menu\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
  IF /I "%%G"=="Yes" (
    goto Functions_Menu
  ) else (
    %Output%\Functions\Menu\MessageBox "Exiting 'Brainiacs Cleanup Tool v%TOOL_VERSION%' in 5 seconds.\n\nGoodbye." "[INFORMATION] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:I /O:N /T:5
    exit /b
  )
)

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
