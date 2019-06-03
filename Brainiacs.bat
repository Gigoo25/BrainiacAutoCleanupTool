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
set TEST_UPDATE_ALL=undetected
set TEST_UPDATE_MASTER=undetected
set TEST_UPDATE_EXPERIMENTAL=undetected
set PREVIOUS_USER=undetected

REM Functions menu variables
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
set PID_BRAINIACS=%A:~16%%

REM Set Initial Color
color 07

REM Skip to menu if verbose is enabled
if exist "%Output%\Debug" (
  %Output%\Functions\Menu\MessageBox "Debug file detected." "[WARNING] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N
  %Output%\Functions\Menu\MessageBox "Entering Debugging mode." "[WARNING] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N
  @echo on
  goto :menuLOOP
)

REM Ask for password for beta testing purposes
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the password in order to access the tool:" "[PASSWORD] Brainiacs Cleanup Tool v%TOOL_VERSION%" "password" /S /H:150 /W:280`) DO (
  IF /I "%%G"=="Bluemoon" (
    goto No_Test_Continue
  ) ELSE if "%%G"=="RedRuby" (
    %Output%\Functions\Menu\MessageBox "Entering hidden testing mode." "[WARNING] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:W /O:N >nul
    goto Choice_Test_Upgrade_All
  ) ELSE (
    %Output%\Functions\Menu\MessageBox "Password is incorrect.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /T:30 /O:N >nul
    exit /b
  )
)
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
%Output%\Functions\Menu\MessageBox "Error\u0021\n\nUser canceled update." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N >nul
goto :Choice_Test_Upgrade_All

REM Upgrade from master branch
:Test_Upgrade_Master
set TEST_UPDATE_ALL=yes
set TEST_UPDATE_MASTER=yes
call functions\Update_function
set TEST_UPDATE_MASTER=no
set TEST_UPDATE_ALL=no
goto Test_Upgrade_All_Decline
REM Upgrade from experimenal branch
:Test_Upgrade_Experimental
set TEST_UPDATE_ALL=yes
set TEST_UPDATE_EXPERIMENTAL=yes
call functions\Update_function
set TEST_UPDATE_EXPERIMENTAL=no
set TEST_UPDATE_ALL=no
goto Test_Upgrade_All_Decline

REM Ask to enable debugging
:Test_Upgrade_All_Decline
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Do you want to enable debugging?\n\nThe output will be really long." "[NOTICE] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:I /O:N`) DO (
  IF /I "%%G"=="Yes" (
    echo. >> "%Output%\Debug"
    start Brainiacs.bat
    exit /b
  ) ELSE (
    goto :menuLOOP
  )
)

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
    FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Abrupt stop detected!\n\nDo you want to restore the session\u003F" "[QUESTION] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:Q /O:N`) DO (
      IF /I "%%G"=="Yes" (
    	  call:restorePersistentVars "%FilePersist%"
        REM Set Color
        color 07
    	  REM Start menu interface
    	  goto :menu_SC
      ) ELSE (
        REM Set Color
        color 07
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
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter your CSG user ID:" "[CSG ID] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280 /M:">L00" /R:"(.)*[a-zA-Z]{1}\d{2}" /F:"(.)*[a-zA-Z]{1}\d{2}"/U /I`) DO (
  echo CSG User ID: "%%G" >> "%Output%\Notes\Comments.txt"
  echo. >> "%Output%\Notes\Comments.txt"
)

REM Enter general cleanup as the reason
echo Continuing general cleanup. >> "%Output%\Notes\Comments.txt"
echo. >> "%Output%\Notes\Comments.txt"

REM Ask & enter any additional notes
FOR /F "usebackq delims=?" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter any additional notes:" "[ADDT NOTES] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280`) DO (
  echo. >> "%Output%\Notes\Comments.txt"
  echo Additional Notes: "%%G" >> "%Output%\Notes\Comments.txt"
  echo --- >> "%Output%\Notes\Comments.txt"
  echo -Picked up session from "%PREVIOUS_USER%" >> "%Output%\Notes\Comments.txt"
)

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

REM Ask & enter CSG user ID into notes
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter your CSG user ID:" "[CSG ID] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280 /M:">L00" /R:"(.)*[a-zA-Z]{1}\d{2}" /F:"(.)*[a-zA-Z]{1}\d{2}"/U /I`) DO (
  echo CSG User ID: "%%G" >> "%Output%\Notes\Comments.txt"
)

REM Ask & enter Phone number into notes
FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter the subscribers Phone number:" "[PHN #] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280 /M:">000\-000\-0000" /R:"[\d0-9]{10}" /F:"[\d0-9]{0,10}" /U /I`) DO (
  echo Phone Number: "%%G" >> "%Output%\Notes\Comments.txt"
  echo. >> "%Output%\Notes\Comments.txt"
)

REM Enter general cleanup reason
echo General Cleanup. >> "%Output%\Notes\Comments.txt"

REM Ask & enter any additional notes
FOR /F "usebackq delims=?" %%G IN (`%Output%\Functions\Menu\INPUTBOX "Enter any additional notes:" "[ADDT NOTES] Brainiacs Cleanup Tool v%TOOL_VERSION%" /H:150 /W:280`) DO (
  echo. >> "%Output%\Notes\Comments.txt"
  echo Additional Notes: "%%G" >> "%Output%\Notes\Comments.txt"
  echo --- >> "%Output%\Notes\Comments.txt"
)

REM Add check for restore deletion to prevent any remnants from messing with the new session.
if /i "!DELETE_RESTORE!"=="Yes" (
  del /Q "%FilePersist%" >nul
  del "!Output!\Functions\Variables\ABRUPTCLOSE.txt" >nul
)

REM ----------------------------DEBUG---------------------------------------
REM ----------------------------DEBUG---------------------------------------
REM ----------------------------DEBUG---------------------------------------
REM ----------------------------DEBUG---------------------------------------
REM         REMOVE LATER. THIS IS JUST FOR KNOWING WHERE I AM
REM ----------------------------DEBUG---------------------------------------
REM ----------------------------DEBUG---------------------------------------
REM ----------------------------DEBUG---------------------------------------
REM ----------------------------DEBUG---------------------------------------

REM Functions Menu
:Functions_Menu
CLS
FOR /F "usebackq tokens=1-14* delims=;" %%A IN (`%Output%\Functions\Menu\MultipleChoiceBox /L:"OK=Start Cleanup" "Rkill;JRT;TDSS Killer;Rogue Killer;ADW;Hitman Pro;Zemana;MBAR;Malwarebytes (Experimental);Spybot (Experimental);Ccleaner;Defrag;Check Windows image for errors;Check Windows drive for errors" "Select a tool from the list below by clicking the corresponding box.\nOnce you are okay with your selection click "OK" to start the automated process." "[MENU] Brainiacs Cleanup Tool v%TOOL_VERSION%"`) DO (
  for /f "tokens=1-14* delims=;" %%a in ("%%^") do (

    REM Check %%A & set appropriate variable
    IF "%%A"=="Rkill" (set RKill_choice=Yes) else (set RKill_choice=No)
    IF "%%A"=="JRT" (set JRT_choice=Yes) else (set JRT_choice=No)
    IF "%%A"=="TDSS Killer" (set TDSS_choice=Yes) else (set TDSS_choice=No)
    IF "%%A"=="Rogue Killer" (set Rogue_choice=Yes) else (set Rogue_choice=No)
    IF "%%A"=="ADW" (set ADW_choice=Yes) else (set ADW_choice=No)
    IF "%%A"=="Hitman Pro" (set HitmanPro_choice=Yes) else (set HitmanPro_choice=No)
    IF "%%A"=="Zemana" (set Zemana_choice=Yes) else (set Zemana_choice=No)
    IF "%%A"=="MBAR" (set MBAR_choice=Yes) else (set MBAR_choice=No)
    IF "%%A"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes) else (set Malwarebytes_choice=No)
    IF "%%A"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%A"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%A"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%A"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%A"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%B & set appropriate variable
    IF "%%B"=="JRT" (set JRT_choice=Yes) else (set JRT_choice=No)
    IF "%%B"=="TDSS Killer" (set TDSS_choice=Yes) else (set TDSS_choice=No)
    IF "%%B"=="Rogue Killer" (set Rogue_choice=Yes) else (set Rogue_choice=No)
    IF "%%B"=="ADW" (set ADW_choice=Yes) else (set ADW_choice=No)
    IF "%%B"=="Hitman Pro" (set HitmanPro_choice=Yes) else (set HitmanPro_choice=No)
    IF "%%B"=="Zemana" (set Zemana_choice=Yes) else (set Zemana_choice=No)
    IF "%%B"=="MBAR" (set MBAR_choice=Yes) else (set MBAR_choice=No)
    IF "%%B"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes) else (set Malwarebytes_choice=No)
    IF "%%B"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%B"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%B"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%B"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%B"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%C & set appropriate variable
    IF "%%C"=="TDSS Killer" (set TDSS_choice=Yes) else (set TDSS_choice=No)
    IF "%%C"=="Rogue Killer" (set Rogue_choice=Yes) else (set Rogue_choice=No)
    IF "%%C"=="ADW" (set ADW_choice=Yes) else (set ADW_choice=No)
    IF "%%C"=="Hitman Pro" (set HitmanPro_choice=Yes) else (set HitmanPro_choice=No)
    IF "%%C"=="Zemana" (set Zemana_choice=Yes) else (set Zemana_choice=No)
    IF "%%C"=="MBAR" (set MBAR_choice=Yes) else (set MBAR_choice=No)
    IF "%%C"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes) else (set Malwarebytes_choice=No)
    IF "%%C"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%C"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%C"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%C"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%C"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%D & set appropriate variable
    IF "%%D"=="Rogue Killer" (set Rogue_choice=Yes) else (set Rogue_choice=No)
    IF "%%D"=="ADW" (set ADW_choice=Yes) else (set ADW_choice=No)
    IF "%%D"=="Hitman Pro" (set HitmanPro_choice=Yes) else (set HitmanPro_choice=No)
    IF "%%D"=="Zemana" (set Zemana_choice=Yes) else (set Zemana_choice=No)
    IF "%%D"=="MBAR" (set MBAR_choice=Yes) else (set MBAR_choice=No)
    IF "%%D"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes) else (set Malwarebytes_choice=No)
    IF "%%D"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%D"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%D"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%D"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%D"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%E & set appropriate variable
    IF "%%E"=="ADW" (set ADW_choice=Yes) else (set ADW_choice=No)
    IF "%%E"=="Hitman Pro" (set HitmanPro_choice=Yes) else (set HitmanPro_choice=No)
    IF "%%E"=="Zemana" (set Zemana_choice=Yes) else (set Zemana_choice=No)
    IF "%%E"=="MBAR" (set MBAR_choice=Yes) else (set MBAR_choice=No)
    IF "%%E"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes) else (set Malwarebytes_choice=No)
    IF "%%E"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%E"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%E"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%E"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%E"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%F & set appropriate variable
    IF "%%F"=="Hitman Pro" (set HitmanPro_choice=Yes) else (set HitmanPro_choice=No)
    IF "%%F"=="Zemana" (set Zemana_choice=Yes) else (set Zemana_choice=No)
    IF "%%F"=="MBAR" (set MBAR_choice=Yes) else (set MBAR_choice=No)
    IF "%%F"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes) else (set Malwarebytes_choice=No)
    IF "%%F"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%F"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%F"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%F"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%F"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%G & set appropriate variable
    IF "%%G"=="Zemana" (set Zemana_choice=Yes) else (set Zemana_choice=No)
    IF "%%G"=="MBAR" (set MBAR_choice=Yes) else (set MBAR_choice=No)
    IF "%%G"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes) else (set Malwarebytes_choice=No)
    IF "%%G"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%G"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%G"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%G"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%G"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%H & set appropriate variable
    IF "%%H"=="MBAR" (set MBAR_choice=Yes) else (set MBAR_choice=No)
    IF "%%H"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes) else (set Malwarebytes_choice=No)
    IF "%%H"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%H"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%H"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%H"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%H"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%I & set appropriate variable
    IF "%%I"=="Malwarebytes (Experimental)" (set Malwarebytes_choice=Yes) else (set Malwarebytes_choice=No)
    IF "%%I"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%I"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%I"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%I"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%I"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%J & set appropriate variable
    IF "%%J"=="Spybot (Experimental)" (set Spybot_choice=Yes) else (set Spybot_choice=No)
    IF "%%J"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%J"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%J"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%J"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%K & set appropriate variable
    IF "%%K"=="Ccleaner" (set CCleaner_choice=Yes) else (set CCleaner_choice=No)
    IF "%%K"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%K"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%K"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%L & set appropriate variable
    IF "%%L"=="Defrag" (set DefragSystem_choice=Yes) else (set DefragSystem_choice=No)
    IF "%%L"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%L"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%M & set appropriate variable
    IF "%%M"=="Check Windows image for errors" (set ImageChecker_choice=Yes) else (set ImageChecker_choice=No)
    IF "%%M"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    REM Check %%N & set appropriate variable
    IF "%%N"=="Check Windows drive for errors" (set DriveChecker_choice=Yes) else (set DriveChecker_choice=No)

    echo ERROR LEVEL
    echo %ERRORLEVEL%
    pause
    CLS
  )
)

IF ERRORLEVEL 0 (
  REM OK BUTTON WAS PRESSED
  echo OK WAS PRESSED!
  pause
  goto Functions_Menu
)
IF ERRORLEVEL 1 (
  REM COMMAND LINE ERRORS
  echo COMMAND LINE ERROR
  pause
  goto Functions_Menu
)
IF ERRORLEVEL 2 (
  goto Options_Menu
)
REM Ask if the user wants to quit.
IF ERRORLEVEL -1 (
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Are you sure you want to quit\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
    IF /I "%%G"=="Yes" (
      exit /b
    ) else (
      goto Functions_Menu
    )
  )
)

REM Options Menu
:Options_Menu
FOR /F "usebackq tokens=1-10* delims=;" %%A IN (`%Output%\Functions\Menu\MultipleChoiceBox /L:"OK=Select Options" "Create system restore point;Email notes (Experimental);Auto close when done;Review Logs when done;Open comments when done;Delete comments when done;Delete logs when done;Delete tools when done;Self-Destruct Cleanup Tool when done;Reboot when done" "Select an option or preset from the list below by clicking the corresponding box.\nOnce you are okay with your selection click "OK" to start the automated process." "[MENU] Brainiacs Cleanup Tool v%TOOL_VERSION%"`) DO (
  for /f "tokens=1-10* delims=;" %%a in ("%%^") do (

    REM Check %%A & set appropriate variable
    IF "%%A"=="Create system restore point" (set SystemRestore_choice=Yes) else (set SystemRestore_choice=No)
    IF "%%A"=="Email notes (Experimental)" (set EmailNotes_choice=Yes) else (set EmailNotes_choice=No)
    IF "%%A"=="Auto close when done" (set AutoClose_choice=Yes) else (set AutoClose_choice=No)
    IF "%%A"=="Review Logs when done" (set ReviewLogs_choice=Yes) else (set ReviewLogs_choice=No)
    IF "%%A"=="Open comments when done" (set OpenNotes_choice=Yes) else (set OpenNotes_choice=No)
    IF "%%A"=="Delete comments when done" (set DeleteNotes_choice=Yes) else (set DeleteNotes_choice=No)
    IF "%%A"=="Delete logs when done" (set DeleteLogs_choice=Yes) else (set DeleteLogs_choice=No)
    IF "%%A"=="Delete tools when done" (set DeleteTools_choice=Yes) else (set DeleteTools_choice=No)
    IF "%%A"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes) else (set SelfDestruct_choice=No)
    IF "%%A"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    REM Check %%B & set appropriate variable
    IF "%%B"=="Email notes (Experimental)" (set EmailNotes_choice=Yes) else (set EmailNotes_choice=No)
    IF "%%B"=="Auto close when done" (set AutoClose_choice=Yes) else (set AutoClose_choice=No)
    IF "%%B"=="Review Logs when done" (set ReviewLogs_choice=Yes) else (set ReviewLogs_choice=No)
    IF "%%B"=="Open comments when done" (set OpenNotes_choice=Yes) else (set OpenNotes_choice=No)
    IF "%%B"=="Delete comments when done" (set DeleteNotes_choice=Yes) else (set DeleteNotes_choice=No)
    IF "%%B"=="Delete logs when done" (set DeleteLogs_choice=Yes) else (set DeleteLogs_choice=No)
    IF "%%B"=="Delete tools when done" (set DeleteTools_choice=Yes) else (set DeleteTools_choice=No)
    IF "%%B"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes) else (set SelfDestruct_choice=No)
    IF "%%B"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    REM Check %%C & set appropriate variable
    IF "%%C"=="Auto close when done" (set AutoClose_choice=Yes) else (set AutoClose_choice=No)
    IF "%%C"=="Review Logs when done" (set ReviewLogs_choice=Yes) else (set ReviewLogs_choice=No)
    IF "%%C"=="Open comments when done" (set OpenNotes_choice=Yes) else (set OpenNotes_choice=No)
    IF "%%C"=="Delete comments when done" (set DeleteNotes_choice=Yes) else (set DeleteNotes_choice=No)
    IF "%%C"=="Delete logs when done" (set DeleteLogs_choice=Yes) else (set DeleteLogs_choice=No)
    IF "%%C"=="Delete tools when done" (set DeleteTools_choice=Yes) else (set DeleteTools_choice=No)
    IF "%%C"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes) else (set SelfDestruct_choice=No)
    IF "%%C"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    REM Check %%D & set appropriate variable
    IF "%%D"=="Review Logs when done" (set ReviewLogs_choice=Yes) else (set ReviewLogs_choice=No)
    IF "%%D"=="Open comments when done" (set OpenNotes_choice=Yes) else (set OpenNotes_choice=No)
    IF "%%D"=="Delete comments when done" (set DeleteNotes_choice=Yes) else (set DeleteNotes_choice=No)
    IF "%%D"=="Delete logs when done" (set DeleteLogs_choice=Yes) else (set DeleteLogs_choice=No)
    IF "%%D"=="Delete tools when done" (set DeleteTools_choice=Yes) else (set DeleteTools_choice=No)
    IF "%%D"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes) else (set SelfDestruct_choice=No)
    IF "%%D"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    REM Check %%E & set appropriate variable
    IF "%%E"=="Open comments when done" (set OpenNotes_choice=Yes) else (set OpenNotes_choice=No)
    IF "%%E"=="Delete comments when done" (set DeleteNotes_choice=Yes) else (set DeleteNotes_choice=No)
    IF "%%E"=="Delete logs when done" (set DeleteLogs_choice=Yes) else (set DeleteLogs_choice=No)
    IF "%%E"=="Delete tools when done" (set DeleteTools_choice=Yes) else (set DeleteTools_choice=No)
    IF "%%E"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes) else (set SelfDestruct_choice=No)
    IF "%%E"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    REM Check %%F & set appropriate variable
    IF "%%F"=="Delete comments when done" (set DeleteNotes_choice=Yes) else (set DeleteNotes_choice=No)
    IF "%%F"=="Delete logs when done" (set DeleteLogs_choice=Yes) else (set DeleteLogs_choice=No)
    IF "%%F"=="Delete tools when done" (set DeleteTools_choice=Yes) else (set DeleteTools_choice=No)
    IF "%%F"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes) else (set SelfDestruct_choice=No)
    IF "%%F"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    REM Check %%G & set appropriate variable
    IF "%%G"=="Delete logs when done" (set DeleteLogs_choice=Yes) else (set DeleteLogs_choice=No)
    IF "%%G"=="Delete tools when done" (set DeleteTools_choice=Yes) else (set DeleteTools_choice=No)
    IF "%%G"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes) else (set SelfDestruct_choice=No)
    IF "%%G"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    REM Check %%H & set appropriate variable
    IF "%%H"=="Delete tools when done" (set DeleteTools_choice=Yes) else (set DeleteTools_choice=No)
    IF "%%H"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes) else (set SelfDestruct_choice=No)
    IF "%%H"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    REM Check %%I & set appropriate variable
    IF "%%I"=="Self-Destruct Cleanup Tool when done" (set SelfDestruct_choice=Yes) else (set SelfDestruct_choice=No)
    IF "%%I"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    REM Check %%J & set appropriate variable
    IF "%%J"=="Reboot when done" (set Reboot_choice=Yes) else (set Reboot_choice=No)

    echo ERROR LEVEL
    echo %ERRORLEVEL%
    pause
  )
)
IF ERRORLEVEL 0 (
  REM OK BUTTON WAS PRESSED
  echo OK WAS PRESSED!
  pause
  goto Options_Menu
)
IF ERRORLEVEL 1 (
  REM COMMAND LINE ERRORS
  echo COMMAND LINE ERROR
  pause
  goto Options_Menu
)
IF ERRORLEVEL 2 (
  goto Functions_Menu
)
REM Ask if the user wants to quit.
IF ERRORLEVEL -1 (
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Are you sure you want to quit\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:W /O:N`) DO (
    IF /I "%%G"=="Yes" (
      exit /b
    ) else (
      goto Options_Menu
    )
  )
)

REM Start Rogue Killer service
:menu_4   Run Rogue Killer?                         : '!Rogue!' [!Rogue_choice:~1,-1!]
call:getNextInList Rogue "!Rogue_choice!"
if "!Rogue!"=="Yes" (
  CLS
  echo.
  echo  ^! ALERT
  echo ================================================================
  echo.
  echo    RogueKiller is able to perform a full scan or a quick scan.
  echo.
  echo    Which scan would you like to perform?
  echo.
  echo ================================================================
  choice /C FQ /T 20 /D Q /M "[F]ull or [Q]uick"
  IF ERRORLEVEL 2 goto RogueKiller_Quickscan
  IF ERRORLEVEL 1 goto RogueKiller_Fullscan
  :RogueKiller_Quickscan
  CLS
  echo.
  echo  ^! ALERT
  echo =========================
  echo.
  echo    Quick scan selected!
  echo.
  echo =========================
  set ROGUE_QUICKSCAN=Yes
  cls
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  GOTO:EOF
  :RogueKiller_Fullscan
  CLS
  echo.
  echo  ^! ALERT
  echo ========================
  echo.
  echo    Full scan selected!
  echo.
  echo ========================
  set ROGUE_QUICKSCAN=No
  cls
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  GOTO:EOF
)
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Malwarebytes service
:menu_9   Run Malwarebytes? (Experimental)          : '!Malwarebytes!' [!Malwarebytes_choice:~1,-1!]
call:getNextInList Malwarebytes "!Malwarebytes_choice!"
cls
REM ---------------------------TEMPORARIY------------------------------------
REM ADD TO DISABLE MALWAREBYTES UNLESS TESTING.
if not "%PASSWORD%"=="RedRuby" (
  call functions\Malwarebytes_function
  set Malwarebytes=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  GOTO:EOF
)
REM ADD TO DISABLE MALWAREBYTES UNLESS TESTING.
REM ---------------------------TEMPORARIY------------------------------------
REM Check if system restore is enabled
if /i "!SystemRestore!"=="No" (
  set Malwarebytes=No
  cls
  color 0c
  echo.
  echo  ^! ERROR
  echo =====================================================================================
  echo.
  echo    Malwarebytes requires you to have the option "Create system restore point" to be
  echo    enabled. Please enable this option and try again.
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 30 seconds.
  echo.
  echo =====================================================================================
  TIMEOUT 30
  color 07
)
call:getNextInList EmailNotes "!EmailNotes_choice!"
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

REM Start Spybot service
:menu_10   Run Spybot? (Experimental)               : '!Spybot!' [!Spybot_choice:~1,-1!]
call:getNextInList Spybot "!Spybot_choice!"
cls
REM ---------------------------TEMPORARIY------------------------------------
REM ADD TO DISABLE SPYBOT UNLESS TESTING.
if not "%PASSWORD%"=="RedRuby" (
  call functions\Spybot_function
  set Spybot=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  GOTO:EOF
)
REM ADD TO DISABLE SPYBOT UNLESS TESTING.
REM ---------------------------TEMPORARIY------------------------------------
REM Check if system restore is enabled
if /i "!SystemRestore!"=="No" (
  CLS
  set Spybot=No
  color 0c
  echo.
  echo  ^! ERROR
  echo ===============================================================================
  echo.
  echo    Spybot requires you to have the option "Create system restore point" to be
  echo    enabled. Please enable this option and try again.
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 30 seconds.
  echo.
  echo ===============================================================================
  TIMEOUT 30
  color 07
)
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

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
  set /p VAR_GEEK=Enter any uninstalled programs separated by a comma:
  echo Uninstalled programs-!!VAR_GEEK!! >> %Output%\Notes\Comments.txt
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
) ELSE (
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo ================================
  echo.
  echo    Geek Uninstaller not found.
  echo.
  echo    Returning to menu...
  echo.
  echo ================================
  TIMEOUT 5
  color 07
)
GOTO:EOF

REM Email notes?
:menu_E    Email notes? (Experimental)               : '!EmailNotes!' [!EmailNotes_choice:~1,-1!]
REM ---------------------------TEMPORARIY------------------------------------
REM ADD TO DISABLE EMAIL UNLESS TESTING.
if not "%PASSWORD%"=="RedRuby" (
  call functions\Email_function
  set EmailNotes=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  GOTO:EOF
)
REM ADD TO DISABLE EMAIL UNLESS TESTING.
REM ---------------------------TEMPORARIY------------------------------------
call:getNextInList EmailNotes "!EmailNotes_choice!"
cls
call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
GOTO:EOF

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
      echo ============================================================================
      echo.
      echo    Delete notes requires you to have the options "Auto close when done" or
      echo    "Reboot when done" to be enabled.
      echo.
      echo ============================================================================
      choice /C AR /T 20 /D A /M "Select [A]utoClose or [R]eboot to continue."
      IF ERRORLEVEL 2 goto Reboot_deletenotes_choice
      IF ERRORLEVEL 1 goto AutoClose_deletenotes_choice
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
    echo ====================================================================================
    echo.
    echo    Delete comments requires you to have the option "Open comments when done" to be
    echo    enabled. Please enable this option and try again.
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 30 seconds.
    echo.
    echo ====================================================================================
    set DeleteNotes=No
    TIMEOUT 30
    color 07
    GOTO:EOF
  )
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo ======================================================================================
  echo.
  echo    You have selected to delete the comments when done.
  echo.
  echo    The comments will still open before deletion for you to copy, but once you close
  echo    the prompt it will all be gone.
  echo.
  echo ======================================================================================
  choice /C YN /T 20 /D N /M "Are you really sure you want to delete the notes after run?"
  IF ERRORLEVEL 2 goto DontDeleteNotes_Prompt_choice
  IF ERRORLEVEL 1 goto DeleteNotes_Prompt_Continue
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
      echo ============================================================================
      echo.
      echo    Delete tools requires you to have the options "Auto close when done" or
      echo    "Reboot when done" to be enabled.
      echo.
      echo ============================================================================
      choice /C AR /T 20 /D A /M "Select [A]utoClose or [R]eboot to continue."
      IF ERRORLEVEL 2 goto Reboot_deletetools_choice
      IF ERRORLEVEL 1 goto AutoClose_deletetools_choice
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
      echo =============================================================================
      echo.
      echo    Self-Destruct requires you to have the options "Auto close when done" or
      echo    "Reboot when done" to be enabled.
      echo.
      echo =============================================================================
      choice /C AR /T 20 /D A /M "Select [A]utoClose or [R]eboot to continue."
      IF ERRORLEVEL 2 goto Reboot_selfdestruct_choice
      IF ERRORLEVEL 1 goto AutoClose_selfdestruct_choice
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

if /i "%EmailNotes:~0,1%"=="Y" (
  REM Call function
  call functions\Email_function
  REM Create restore point
  set EmailNotes=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%SystemRestore:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\Restore_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set SystemRestore=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%RKill:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\Rkill_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set RKill=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%JRT:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\JRT_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set JRT=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%TDSS:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\TDSS_Killer_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set TDSS=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%Rogue:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\RogueKiller_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set Rogue=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%ADW:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\ADW_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set ADW=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%HitmanPro:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\HitmanPro_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set HitmanPro=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%Zemana:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\Zemana_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set Zemana=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%MBAR:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\MBAR_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set MBAR=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%Malwarebytes:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\Malwarebytes_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set Malwarebytes=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%Spybot:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\Spybot_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set Spybot=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%CCleaner:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\CCleaner_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set CCleaner=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%DefragSystem:~0,1%"=="Y" (
  REM Ask which program to use to defrag
  :choice_start
  CLS
  echo.
  echo  ^! USER INPUT
  echo =================================
  echo.
  choice /C ADW /T 20 /D W /M "Which program do you want to defrag with [A] AusDefrag, [D] Defraggler or [W] Windows Defrag"
  IF ERRORLEVEL 3 goto Windows_Defrag_Function
  IF ERRORLEVEL 2 goto Defraggler
  IF ERRORLEVEL 1 goto AusDefrag

  REM Windows_Defrag function.
  :Windows_Defrag_Function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt

  REM Ask if want to run externally
  CLS
  echo.
  echo  ^! USER INPUT
  echo =================================
  echo.
  choice /C YN /T 20 /D N /M "Do you want to run defrag externally?"
  IF ERRORLEVEL 2 goto Next_Boot_Defrag_Windows_Choice
  IF ERRORLEVEL 1 goto Run_External_Defrag_Windows

  REM Initiate external run
  :Run_External_Defrag_Windows
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  set Defrag_External=Yes
  start functions\Windows_Defrag_Function
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
  IF ERRORLEVEL 2 goto Defrag_Windows
  IF ERRORLEVEL 1 goto Next_Boot_Defrag_Windows

  REM Schedule for next reboot/delete task after
  :Next_Boot_Defrag_Windows
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  xcopy /v "%Output%\functions\Windows_Defrag_Function.bat" "%SystemDrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\"
  cls
  echo.
  echo  ^! ALERT
  echo ===========================================
  echo.
  echo    Defrag scheduled for next boot.
  echo.
  echo    Reboot PC to start the defrag process.
  echo.
  echo ===========================================
  TIMEOUT 5
  goto Defrag_Done

  REM Open Windows Defrag if other options were denied.
  :Defrag_Windows
  set Defrag_Internal=Yes
  call functions\Windows_Defrag_Function
  set Defrag_Internal=No
  goto Defrag_Done

  REM Open Defraggler_Defrag_function.
  :Defraggler
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\Defraggler_Defrag_function
  goto Defrag_Done

  REM Open Aus_Defrag_function.
  :AusDefrag
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\Aus_Defrag_function
  goto Defrag_Done

  REM Finish defrag
  :Defrag_Done
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt

  REM Create restore point
  set DefragSystem=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage

  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%ImageChecker:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\Image_Checker_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
  REM Create restore point
  set ImageChecker=No
  call:savePersistentVars "%FilePersist%"&   rem --save the persistent variables to the storage
  REM Set title
  title Brainiacs Cleanup Tool v%TOOL_VERSION%
)

if /i "%DriveChecker:~0,1%"=="Y" (
  REM Call function
  echo yes>!Output!\Functions\Variables\ABRUPTCLOSE.txt
  call functions\CHKDSK_function
  echo No >!Output!\Functions\Variables\ABRUPTCLOSE.txt
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
	echo =========================================================================
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds.
	echo.
	echo =========================================================================
  TIMEOUT 15
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
  ) ELSE (
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
	echo =================================================================================
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will reboot the PC in 10 seconds.
  echo    Exit the tool to stop the reboot.
	echo.
	echo =================================================================================
  TIMEOUT 10
  echo -Rebooted PC >> %Output%\Notes\Comments.txt
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
  ) ELSE (
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
) ELSE (
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo =========================
  echo.
  echo    Readme not found.
  echo.
  echo    Returning to menu...
  echo.
  echo =========================
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
) ELSE (
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo =========================
  echo.
  echo    Comments not found.
  echo.
  echo    Returning to menu...
  echo.
  echo =========================
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
) ELSE (
  CLS
  color 0c
  echo.
  echo  ^! WARNING
  echo =========================
  echo.
  echo    Changelog not found.
  echo.
  echo    Returning to menu...
  echo.
  echo =========================
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
