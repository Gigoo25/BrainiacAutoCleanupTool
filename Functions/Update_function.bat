@echo off

::Set variables
set REPO_URL=https://raw.githubusercontent.com/Gigoo25/BrainiacAutoCleanupTool
set REPO_BRANCH=master
set CURRENT_VERSION=unidentified
set CHECK_UPDATE_VERSION=unidentified

::Function variables
set RKill_Update_Function=unidentified
set JRT_Update_Function=unidentified
set TDSS_Update_Function=unidentified
set Rogue_Update_Function=unidentified
set ADW_Update_Function=unidentified
set HitmanPro_Update_Function=unidentified
set Zemana_Update_Function=unidentified
set MBAR_Update_Function=unidentified
set Malwarebytes_Update_Function=unidentified
set Spybot_Update_Function=unidentified
set CCleaner_Update_Function=unidentified
set DefragSystem_A_Update_Function=unidentified
set DefragSystem_D_Update_Function=unidentified
set ImageChecker_Update_Function=unidentified
set CHKDSK_Update_Function=unidentified
set SFChecker_Update_Function=unidentified
set SystemRestore_Update_Function=unidentified
set DeleteNotes_Update_Function=unidentified
set DeleteLogs_Update_Function=unidentified
set DeleteTools_Update_Function=unidentified
set Brainiacs_Update_Function=unidentified
set Update_Update_Function=unidentified

::Tool variables
set RKill_Update_Tool=unidentified
set JRT_Update_Tool=unidentified
set TDSS_Update_Tool=unidentified
set Rogue_Update_Tool=unidentified
set ADW_Update_Tool=unidentified
set HitmanPro_Update_Tool=unidentified
set Zemana_Update_Tool=unidentified
set MBAR_Update_Tool=unidentified
set Malwarebytes_Update_Tool=unidentified
set Spybot_Update_Tool=unidentified
set CCleaner_Update_Tool=unidentified
set DefragSystem_A_Update_Tool=unidentified
set DefragSystem_D_Update_Tool=unidentified
set Caffeine_Update_Tool=unidentified

::Tool download location variables
set RKill_Url=https://download.bleepingcomputer.com/dl/0bd7abe3ef66cddbcd7a872fb55eb82c/5c247388/windows/security/security-utilities/r/rkill/rkill.exe
set JRT_Url=unidentified
set TDSS_Url=http://media.kaspersky.com/utilities/VirusUtilities/EN/tdsskiller.exe
set Rogue_Url=unidentified
set ADW_Url=https://download.bleepingcomputer.com/dl/186de3aee284d53245e950977b00e955/5c247462/windows/security/security-utilities/a/adwcleaner/AdwCleaner.exe
set HitmanPro_Url=https://dl.surfright.nl/HitmanPro.exe
set HitmanPro_64_Url=https://dl.surfright.nl/HitmanPro_x64.exe
set Zemana_Url=unidentified
set MBAR_Url=unidentified
set Malwarebytes_Url=unidentified
set Spybot_Url=unidentified
set CCleaner_Url=unidentified
set DefragSystem_A_Url=unidentified
set DefragSystem_D_Url=unidentified
set Caffeine_Url=unidentified

::Set the window title
title [Update] Brainiacs Cleanup Tool v%TOOL_VERSION%

::Check that wget is present
if not exist "%Output%\Tools\WGET\wget.exe" (
	::Set red Color
	color 0c
	cls
	echo.
	echo  ^! ERROR
	echo ===================================================================================
	echo.
	echo    WGET not found!
	echo.                                                        
	echo    Please check to make sure WGET.exe is found.
	echo.
	echo    Checking for updates will be skipped.
	echo.
	echo ===================================================================================
	TIMEOUT 10
	::Set default Color
	color 07
	goto end
)

::Check for version file
if exist "%Output%\Version.txt" (
	::Set current version as variable
	set /p CURRENT_VERSION=<%Output%\Version.txt
) else (
	::Skip update check
	::Set red Color
	color 0c
	cls
	echo.
	echo  ^! ERROR
	echo ===================================================================================
	echo.
	echo    Cannot detect tool version!
	echo.                                                        
	echo    The cleanup tool will not be able to update.
	echo.
	echo    Skipping update.
	echo.
	echo ===================================================================================
	TIMEOUT 10
	::Set default Color
	color 07
	goto end
)

::Delete version check file if found
if exist "%TEMP%\Version_Check.txt" (
	del "%TEMP%\Version_Check.txt" 2>NUL
)

::Download version to compare from online
"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Version.txt" -O "%TEMP%\Version_Check.txt" 2>NUL
pause
if /i %ERRORLEVEL%==0 (
	set /p CHECK_UPDATE_VERSION=<%TEMP%\Version_Check.txt
) else (
	::Set red Color
	color 0c
	cls
	echo.
	echo  ^! FAILED
	echo ===================================================================================
	echo.
	echo    Failed to check for updates!
	echo.                                                        
	echo    The cleanup tool will not be able to update.
	echo.
	echo    Skipping update.
	echo.
	echo ===================================================================================
	TIMEOUT 10
	::Set default Color
	color 07
	goto end
)

::Check if downloaded version is greater
if "%CHECK_UPDATE_VERSION%" GTR "%CURRENT_VERSION%" (
	::Set red Color
	color 0c
	cls
	echo.
	echo  ^! ALERT
	echo ===================================================================================
	echo.
	echo    Update found!
	echo.
	echo ===================================================================================
	::Ask if the user wants to update
	choice /M "Do you want to update the tool" /c YN 
	IF errorlevel 2 goto :update_no
	IF errorlevel 1 goto :update_yes
) else (
	goto end
)

:update_no
::Set red Color
color 0c
cls
echo.
echo  ^! ALERT
echo ===================================================================================
echo.
echo    You did not accept to update the tool.
echo.                                                        
echo    Remember that this is your decision.   
echo.
echo    Update will be skipped.
echo.
echo ===================================================================================
TIMEOUT 10
goto end

:update_yes
::Set default Color
color 07
::Display that we will be updating now
CLS
echo Updating tool...

::Update version file
"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Version.txt" -O "%Output%\Version.txt"

::Update Readme file
"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Readme.txt" -O "%Output%\Readme.txt"

::Update Changelog file
"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Changelog.txt" -O "%Output%\Changelog.txt"

::Set variables for functions to update
< "%TEMP%\Version_Check.txt" (
	for /l %%i in (1,1,28) do set /p =
	set /p RKill_Update_Function=
	set /p JRT_Update_Function=
	set /p TDSS_Update_Function=
	set /p Rogue_Update_Function=
	set /p ADW_Update_Function=
	set /p HitmanPro_Update_Function=
	set /p Zemana_Update_Function=
	set /p MBAR_Update_Function=
	set /p Malwarebytes_Update_Function=
	set /p Spybot_Update_Function=
	set /p CCleaner_Update_Function=
	set /p DefragSystem_A_Update_Function=
	set /p DefragSystem_D_Update_Function=
	set /p ImageChecker_Update_Function=
	set /p CHKDSK_Update_Function=
	set /p SFChecker_Update_Function=
	set /p SystemRestore_Update_Function=
	set /p DeleteNotes_Update_Function=
	set /p DeleteLogs_Update_Function=
	set /p DeleteTools_Update_Function=
	set /p Brainiacs_Update_Function=
	set /p Update_Update_Function=
)
	
::Set variables for tools to update
< "%TEMP%\Version_Check.txt" (
	for /l %%i in (1,1,68) do set /p =
	set /p RKill_Update_Tool=
	set /p JRT_Update_Tool=
	set /p TDSS_Update_Tool=
	set /p Rogue_Update_Tool=
	set /p ADW_Update_Tool=
	set /p HitmanPro_Update_Tool=
	set /p Zemana_Update_Tool=
	set /p MBAR_Update_Tool=
	set /p Malwarebytes_Update_Tool=
	set /p Spybot_Update_Tool=
	set /p CCleaner_Update_Tool=
	set /p DefragSystem_A_Update_Tool=
	set /p DefragSystem_D_Update_Tool=
	set /p Caffeine_Update_Tool=
)

::Update functions based on variables

::Rkill_Function
if "%RKill_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
)
::JRT_Function
if "%JRT_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
)
::TDSS_Function
if "%TDSS_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
)
::Rogue_Function
if "%Rogue_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
)
::ADW_Function
if "%ADW_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
)
::HitmanPro_Function
if "%HitmanPro_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
)
::Zemana_Function
if "%Zemana_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
)
::MBAR_Function
if "%MBAR_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
)
::Malwarebytes_Function
if "%Malwarebytes_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
)
::Spybot_Function
if "%Spybot_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
)
::CCleaner_Function
if "%CCleaner_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
)
::DefragSystem_A_Update_Function
if "%DefragSystem_A_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/AusDefrag_function.bat" -O "%Output%\Functions\AusDefrag_function.bat" 2>NUL
)
::DefragSystem_D_Update_Function
if "%DefragSystem_D_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/Defraggler_function.bat" -O "%Output%\Functions\Defraggler_function.bat" 2>NUL
)
::ImageChecker_Function
if "%ImageChecker_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
)
::CHKDSK_Function
if "%CHKDSK_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
)
::SFChecker_Function
if "%SFChecker_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/SFC_function.bat" -O "%Output%\Functions\SFC_function.bat" 2>NUL
)
::SystemRestore_Function
if "%SystemRestore_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
)
::DeleteNotes_Function
if "%DeleteNotes_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
)
::DeleteLogs_Function
if "%DeleteLogs_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
)
::DeleteTools_Function
if "%DeleteTools_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
)
::Brainiacs_Function
if "%Brainiacs_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
)
::Updated tools based on variables
::Rkill_Function
if "%RKill_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%RKill_Url%" -O "%Output%\Tools\RKill\rkill.exe" 2>NUL
)
::JRT_Tool
if "%JRT_Update_Tool%"=="yes" (
"%Output%\Tools\WGET\wget.exe" -q "%JRT_Url%" -O "%Output%\Tools\JRT\JRT.exe" 2>NUL
)
::TDSS_Tool
if "%TDSS_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%TDSS_Url%" -O "%Output%\Tools\TDSS\TDSSKiller.exe" 2>NUL
)
::Rogue_Tool
if "%Rogue_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%Rogue_Url%" -O "%Output%\Tools\RogueKiller\RogueKillerCMD.exe" 2>NUL
)
::ADW_Tool
if "%ADW_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%ADW_Url%" -O "%Output%\Tools\ADW\adwcleaner.exe" 2>NUL
)
::HitmanPro_Tool
if "%HitmanPro_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%HitmanPro_Url%" -O "%Output%\Tools\HitmanPro\HitmanPro.exe" 2>NUL
	"%Output%\Tools\WGET\wget.exe" -q "%HitmanPro_64_Url%" -O "%Output%\Tools\HitmanPro\HitmanPro_x64.exe" 2>NUL
)
::Zemana_Tool
if "%Zemana_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%Zemana_Url%" -O "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe" 2>NUL
)
::MBAR_Tool
::FIX DOWNLOAD DIR
if "%MBAR_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%MBAR_Url%" -O "%Output%\Tools\MBAR\mbar.exe" 2>NUL
)
::Malwarebytes_Tool
if "%Malwarebytes_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%Malwarebytes_Url%" -O "%Output%\Tools\Malwarebytes\mb3-setup.exe" 2>NUL
)
::Spybot_Tool
if "%Spybot_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%Spybot_Url%" -O "%Output%\Tools\SpyBot\spybotsd.exe" 2>NUL
)
::CCleaner_Tool
::ADD 64 BIT VERSION
if "%CCleaner_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%CCleaner_Url%" -O "%Output%\Tools\CCleaner\CCleaner.exe" 2>NUL
)
::DefragSystem_A_Tool
if "%DefragSystem_A_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%DefragSystem_A_Url%" -O "%Output%\Tools\AUS\ausdiskdefrag.exe" 2>NUL
)
::DefragSystem_D_Tool
::ADD 64 BIT VERSION
if "%DefragSystem_D_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%DefragSystem_D_Url%" -O "%Output%\Tools\Defraggler\Defraggler.exe" 2>NUL
)
::Caffeine_Update_Tool
if "%Caffeine_Update_Tool%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%Caffeine_Url%" -O "%Output%\Tools\Caffeine\caffeine.exe" 2>NUL
)
::Update_Update_Function last
if "%Update_Update_Function%"=="yes" (
	"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
)
::Notify update was successful
::Set red Color
color 0c
cls
echo.
echo  ^! WARNING
echo ===================================================================================
echo.
echo    Update successful.
echo.                                                        
echo    Tool will now close.
echo.
echo    Please re-open the tool to load the new version.
echo.
echo ===================================================================================
TIMEOUT 10
::Set default Color
color 07
exit

:end
CLS
