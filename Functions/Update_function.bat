@echo off

::Set repo variables
set REPO_URL=https://raw.githubusercontent.com/Gigoo25/BrainiacAutoCleanupTool
set REPO_BRANCH=master

::Set tool verison check variables
set CURRENT_VERSION=unidentified
set CHECK_UPDATE_VERSION=unidentified

::Text files local variables
set Readme_Local=unidentified
set Version_Local=unidentified
set Changelog_Local=unidentified

::Text files online variables
set Readme_Online=unidentified
set Version_Online=unidentified
set Changelog_Online=unidentified

::Function local variables
set RKill_Update_Function_Local=unidentified
set JRT_Update_Function_Local=unidentified
set TDSS_Update_Function_Local=unidentified
set Rogue_Update_Function_Local=unidentified
set ADW_Update_Function_Local=unidentified
set HitmanPro_Update_Function_Local=unidentified
set Zemana_Update_Function_Local=unidentified
set MBAR_Update_Function_Local=unidentified
set Malwarebytes_Update_Function_Local=unidentified
set Spybot_Update_Function_Local=unidentified
set CCleaner_Update_Function_Local=unidentified
set DefragSystem_A_Update_Function_Local=unidentified
set DefragSystem_D_Update_Function_Local=unidentified
set ImageChecker_Update_Function_Local=unidentified
set CHKDSK_Update_Function_Local=unidentified
set SystemRestore_Update_Function_Local=unidentified
set DeleteNotes_Update_Function_Local=unidentified
set DeleteLogs_Update_Function_Local=unidentified
set DeleteTools_Update_Function_Local=unidentified
set Brainiacs_Update_Function_Local=unidentified
set Update_Update_Function_Local=unidentified
set Windows_Defrag_Local=unidentified

::Function online variables
set RKill_Update_Function_Online=unidentified
set JRT_Update_Function_Online=unidentified
set TDSS_Update_Function_Online=unidentified
set Rogue_Update_Function_Online=unidentified
set ADW_Update_Function_Online=unidentified
set HitmanPro_Update_Function_Online=unidentified
set Zemana_Update_Function_Online=unidentified
set MBAR_Update_Function_Online=unidentified
set Malwarebytes_Update_Function_Online=unidentified
set Spybot_Update_Function_Online=unidentified
set CCleaner_Update_Function_Online=unidentified
set DefragSystem_A_Update_Function_Online=unidentified
set DefragSystem_D_Update_Function_Online=unidentified
set ImageChecker_Update_Function_Online=unidentified
set CHKDSK_Update_Function_Online=unidentified
set SystemRestore_Update_Function_Online=unidentified
set DeleteNotes_Update_Function_Online=unidentified
set DeleteLogs_Update_Function_Online=unidentified
set DeleteTools_Update_Function_Online=unidentified
set Brainiacs_Update_Function_Online=unidentified
set Update_Update_Function_Online=unidentified
set Windows_Defrag_Online=unidentified

::Tool local variables
set RKill_Update_Tool_Local=unidentified
set JRT_Update_Tool_Local=unidentified
set TDSS_Update_Tool_Local=unidentified
set Rogue_Update_Tool_Local=unidentified
set ADW_Update_Tool_Local=unidentified
set HitmanPro_Update_Tool_Local=unidentified
set Zemana_Update_Tool_Local=unidentified
set MBAR_Update_Tool_Local=unidentified
set Malwarebytes_Update_Tool_Local=unidentified
set Spybot_Update_Tool_Local=unidentified
set CCleaner_Update_Tool_Local=unidentified
set DefragSystem_A_Update_Tool_Local=unidentified
set DefragSystem_D_Update_Tool_Local=unidentified
set Caffeine_Update_Tool_Local=unidentified
set Geek_Update_Tool_Local=unidentified

::Tool online variables
set RKill_Update_Tool_Online=unidentified
set JRT_Update_Tool_Online=unidentified
set TDSS_Update_Tool_Online=unidentified
set Rogue_Update_Tool_Online=unidentified
set ADW_Update_Tool_Online=unidentified
set HitmanPro_Update_Tool_Online=unidentified
set Zemana_Update_Tool_Online=unidentified
set MBAR_Update_Tool_Online=unidentified
set Malwarebytes_Update_Tool_Online=unidentified
set Spybot_Update_Tool_Online=unidentified
set CCleaner_Update_Tool_Online=unidentified
set DefragSystem_A_Update_Tool_Online=unidentified
set DefragSystem_D_Update_Tool_Online=unidentified
set Caffeine_Update_Tool_Online=unidentified
set Geek_Update_Tool_Online=unidentified

::Tool download location variables
set RKill_Url="https://files.downloadnow-3.com/s/software/16/31/77/69/rkill.exe?token=1554240497_1a8fe216d392387d272ba1afa7874e48&fileName=rkill.exe"
set JRT_Url=unidentified
set TDSS_Url=http://media.kaspersky.com/utilities/VirusUtilities/EN/tdsskiller.zip
set Rogue_Url=unidentified
set ADW_Url=https://downloads.malwarebytes.com/file/adwcleaner/adwcleaner_7.2.7.0.exe
set HitmanPro_Url=https://dl.surfright.nl/HitmanPro.exe
set HitmanPro_64_Url=https://dl.surfright.nl/HitmanPro_x64.exe
set Zemana_Url=http://dl12.zemana.com/AntiMalware/2.74.2.664/Zemana.AntiMalware.Portable.exe
set MBAR_Url=unidentified
set Malwarebytes_Url=unidentified
set Spybot_Url=unidentified
set CCleaner_Url=https://download.ccleaner.com/portable/ccsetup555.zip
set DefragSystem_A_Url=http://downloads.auslogics.com/en/disk-defrag/ausdiskdefragportable.exe
set DefragSystem_D_Url=https://softpedia-secure-download.com/dl/43f41169943fef85b1fcc5f7e22ac9bf/5c9b623b/100100698/software/portable/system/dfsetup222.zip
set Caffeine_Url=unidentified
set Geek_Url=https://geekuninstaller.com/geek.zip

::Update all functions if ran in test mode
if %Test_Update_All%==yes (
	goto Test_Upgrade_All
)

::Set the window title
title [Update] Brainiacs Cleanup Tool v%TOOL_VERSION%

::Check that wget is present
if not exist "%Output%\Tools\WGET\wget.exe" (
	REM Set red Color
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
	REM Set default Color
	color 07
	goto :EOF
)

::Check for version file
if exist "%Output%\Version.txt" (
	REM Set current version as variable
	set /p CURRENT_VERSION=<%Output%\Version.txt
) else (
	REM Skip update check
	REM Set red Color
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
	REM Set default Color
	color 07
	goto :EOF
)

::Delete version check file if found
if exist "%TEMP%\Version_Check.txt" (
	del "%TEMP%\Version_Check.txt" 2>NUL
)

::Download version to compare from online
"%Output%\Tools\WGET\wget.exe" -q "%REPO_URL%/%REPO_BRANCH%/Version.txt" -O "%TEMP%\Version_Check.txt" 2>NUL
if /i %ERRORLEVEL%==0 (
	set /p CHECK_UPDATE_VERSION=<%TEMP%\Version_Check.txt
) else (
	REM Set red Color
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
	REM Set default Color
	color 07
	goto :EOF
)

::Check if downloaded version is greater
if not DEFINED Skip_Update (
	if "%CHECK_UPDATE_VERSION%" GTR "%CURRENT_VERSION%" (
		REM Set red Color
		color 0c
		cls
		echo.
		echo  ^! ALERT
		echo ===================================================================================
		echo.
		echo    Update found!
		echo.
		echo ===================================================================================
		REM Ask if the user wants to update
		choice /M "Do you want to update the tool" /c YN
		IF errorlevel 2 goto :update_no
		IF errorlevel 1 goto :update_yes
	) else (
		goto :EOF
	)
) else (
	goto update_yes
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
::Set default Color
color 07
goto :EOF

:update_yes
::Set default Color
color 07

::Set variables for local text files
< "%Output%\Version.txt" (
	for /l %%i in (1,1,9) do set /p =
	set /p Readme_Local=
	set /p Version_Local=
	set /p Changelog_Local=
)

::Set variables for online text files
< "%TEMP%\Version_Check.txt" (
	for /l %%i in (1,1,9) do set /p =
	set /p Readme_Online=
	set /p Version_Online=
	set /p Changelog_Online=
)

::Set variables for Functions_Local
< "%Output%\Version.txt" (
	for /l %%i in (1,1,39) do set /p =
	set /p RKill_Update_Function_Local=
	set /p JRT_Update_Function_Local=
	set /p TDSS_Update_Function_Local=
	set /p Rogue_Update_Function_Local=
	set /p ADW_Update_Function_Local=
	set /p HitmanPro_Update_Function_Local=
	set /p Zemana_Update_Function_Local=
	set /p MBAR_Update_Function_Local=
	set /p Malwarebytes_Update_Function_Local=
	set /p Spybot_Update_Function_Local=
	set /p CCleaner_Update_Function_Local=
	set /p DefragSystem_A_Update_Function_Local=
	set /p DefragSystem_D_Update_Function_Local=
	set /p ImageChecker_Update_Function_Local=
	set /p CHKDSK_Update_Function_Local=
	set /p SystemRestore_Update_Function_Local=
	set /p DeleteNotes_Update_Function_Local=
	set /p DeleteLogs_Update_Function_Local=
	set /p DeleteTools_Update_Function_Local=
	set /p Brainiacs_Update_Function_Local=
	set /p Update_Update_Function_Local=
	set /p Windows_Defrag_Local=
)

::Set variables for Tools_Local
< "%Output%\Version.txt" (
	for /l %%i in (1,1,80) do set /p =
	set /p RKill_Update_Tool_Local=
	set /p JRT_Update_Tool_Local=
	set /p TDSS_Update_Tool_Local=
	set /p Rogue_Update_Tool_Local=
	set /p ADW_Update_Tool_Local=
	set /p HitmanPro_Update_Tool_Local=
	set /p Zemana_Update_Tool_Local=
	set /p MBAR_Update_Tool_Local=
	set /p Malwarebytes_Update_Tool_Local=
	set /p Spybot_Update_Tool_Local=
	set /p CCleaner_Update_Tool_Local=
	set /p DefragSystem_A_Update_Tool_Local=
	set /p DefragSystem_D_Update_Tool_Local=
	set /p Caffeine_Update_Tool_Local=
	set /p Geek_Update_Tool_Local=
)

::Set variables for Functions_Online
< "%TEMP%\Version_Check.txt" (
	for /l %%i in (1,1,39) do set /p =
	set /p RKill_Update_Function_Online=
	set /p JRT_Update_Function_Online=
	set /p TDSS_Update_Function_Online=
	set /p Rogue_Update_Function_Online=
	set /p ADW_Update_Function_Online=
	set /p HitmanPro_Update_Function_Online=
	set /p Zemana_Update_Function_Online=
	set /p MBAR_Update_Function_Online=
	set /p Malwarebytes_Update_Function_Online=
	set /p Spybot_Update_Function_Online=
	set /p CCleaner_Update_Function_Online=
	set /p DefragSystem_A_Update_Function_Online=
	set /p DefragSystem_D_Update_Function_Online=
	set /p ImageChecker_Update_Function_Online=
	set /p CHKDSK_Update_Function_Online=
	set /p SystemRestore_Update_Function_Online=
	set /p DeleteNotes_Update_Function_Online=
	set /p DeleteLogs_Update_Function_Online=
	set /p DeleteTools_Update_Function_Online=
	set /p Brainiacs_Update_Function_Online=
	set /p Update_Update_Function_Online=
	set /p Windows_Defrag_Online=
)

::Set variables for Tools_Online
< "%TEMP%\Version_Check.txt" (
	for /l %%i in (1,1,80) do set /p =
	set /p RKill_Update_Tool_Online=
	set /p JRT_Update_Tool_Online=
	set /p TDSS_Update_Tool_Online=
	set /p Rogue_Update_Tool_Online=
	set /p ADW_Update_Tool_Online=
	set /p HitmanPro_Update_Tool_Online=
	set /p Zemana_Update_Tool_Online=
	set /p MBAR_Update_Tool_Online=
	set /p Malwarebytes_Update_Tool_Online=
	set /p Spybot_Update_Tool_Online=
	set /p CCleaner_Update_Tool_Online=
	set /p DefragSystem_A_Update_Tool_Online=
	set /p DefragSystem_D_Update_Tool_Online=
	set /p Caffeine_Update_Tool_Online=
	set /p Geek_Update_Tool_Online=
)

::Update functions based on variables

::Update if ran in test mode
:Test_Upgrade_All
CLS
echo Upgrading all functions from source...

::Update_Update_Function
if not DEFINED Skip_Update (
	if "%Update_Update_Function_Online%" GTR "%Update_Update_Function_Local%" (
		CLS
		echo Updating Update_Update_Function...
		echo.
		"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
		CLS
		echo Done updating Update_Update_Function.
		TIMEOUT 2
		CLS
		set Skip_Update=yes
		if not DEFINED Skip_Update set Skip_Update=yes
		if not DEFINED IS_MAXIMIZED set IS_MAXIMIZED=1 && start "" /max "%~dpnx0" %* && exit
	)
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
)

::Rkill_Function
if "%RKill_Update_Function_Online%" GTR "%RKill_Update_Function_Local%" (
	CLS
	echo Updating Rkill_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
	CLS
	echo Done updating Rkill_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
)

::JRT_Function
if "%JRT_Update_Function_Online%" GTR "%JRT_Update_Function_Local%" (
	CLS
	echo Updating JRT_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
	CLS
	echo Done updating JRT_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
)

::TDSS_Function
if "%TDSS_Update_Function_Online%" GTR "%TDSS_Update_Function_Local%" (
	CLS
	echo Updating TDSS_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
	CLS
	echo Done updating TDSS_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
)

::Rogue_Function
if "%TDSS_Update_Function_Online%" GTR "%TDSS_Update_Function_Local%" (
	CLS
	echo Updating Rogue_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
	CLS
	echo Done updating Rogue_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
)

::ADW_Function
if "%ADW_Update_Function_Online%" GTR "%ADW_Update_Function_Local%" (
	CLS
	echo Updating ADW_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
	CLS
	echo Done updating ADW_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
)

::HitmanPro_Function
if "%HitmanPro_Update_Function_Online%" GTR "%HitmanPro_Update_Function_Local%" (
	CLS
	echo Updating HitmanPro_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
	CLS
	echo Done updating HitmanPro_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
)

::Zemana_Function
if "%Zemana_Update_Function_Online%" GTR "%Zemana_Update_Function_Local%" (
	CLS
	echo Updating Zemana_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
	CLS
	echo Done updating Zemana_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
)

::MBAR_Function
if "%MBAR_Update_Function_Online%" GTR "%MBAR_Update_Function_Local%" (
	CLS
	echo Updating MBAR_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
	CLS
	echo Done updating MBAR_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
)

::Malwarebytes_Function
if "%Malwarebytes_Update_Function_Online%" GTR "%Malwarebytes_Update_Function_Local%" (
	CLS
	echo Updating Malwarebytes_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
	CLS
	echo Done updating Malwarebytes_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
)

::Spybot_Function
if "%Spybot_Update_Function_Online%" GTR "%Spybot_Update_Function_Local%" (
	CLS
	echo Updating Spybot_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
	CLS
	echo Done updating Spybot_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
)

::CCleaner_Function
if "%CCleaner_Update_Function_Online%" GTR "%CCleaner_Update_Function_Local%" (
	CLS
	echo Updating CCleaner_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
	CLS
	echo Done updating CCleaner_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
)

::DefragSystem_A_Update_Function
if "%DefragSystem_A_Update_Function_Online%" GTR "%DefragSystem_A_Update_Function_Local%" (
	CLS
	echo Updating DefragSystem_A_Update_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/AusDefrag_function.bat" -O "%Output%\Functions\AusDefrag_function.bat" 2>NUL
	CLS
	echo Done updating DefragSystem_A_Update_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/AusDefrag_function.bat" -O "%Output%\Functions\AusDefrag_function.bat" 2>NUL
)

::DefragSystem_D_Update_Function
if "%DefragSystem_D_Update_Function_Online%" GTR "%DefragSystem_D_Update_Function_Local%" (
	CLS
	echo Updating DefragSystem_D_Update_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Defraggler_function.bat" -O "%Output%\Functions\Defraggler_function.bat" 2>NUL
	CLS
	echo Done updating DefragSystem_D_Update_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Defraggler_function.bat" -O "%Output%\Functions\Defraggler_function.bat" 2>NUL
)

::ImageChecker_Function
if "%ImageChecker_Update_Function_Online%" GTR "%ImageChecker_Update_Function_Local%" (
	CLS
	echo Updating ImageChecker_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
	CLS
	echo Done updating ImageChecker_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
)

::CHKDSK_Function
if "%CHKDSK_Update_Function_Online%" GTR "%CHKDSK_Update_Function_Local%" (
	CLS
	echo Updating CHKDSK_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
	CLS
	echo Done updating CHKDSK_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
)

::SystemRestore_Function
if "%SystemRestore_Update_Function_Online%" GTR "%SystemRestore_Update_Function_Local%" (
	CLS
	echo Updating SystemRestore_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
	CLS
	echo Done updating SystemRestore_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
)

::DeleteNotes_Function
if "%DeleteNotes_Update_Function_Online%" GTR "%DeleteNotes_Update_Function_Local%" (
	CLS
	echo Updating DeleteNotes_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
	CLS
	echo Done updating DeleteNotes_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
)

::DeleteLogs_Function
if "%DeleteLogs_Update_Function_Online%" GTR "%DeleteLogs_Update_Function_Local%" (
	CLS
	echo Updating DeleteLogs_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
	CLS
	echo Done updating DeleteLogs_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
)

::DeleteTools_Function
if "%DeleteTools_Update_Function_Online%" GTR "%DeleteTools_Update_Function_Local%" (
	CLS
	echo Updating DeleteTools_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
	CLS
	echo Done updating DeleteTools_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
)

::Brainiacs_Function
if "%Brainiacs_Update_Function_Online%" GTR "%Brainiacs_Update_Function_Local%" (
	CLS
	echo Updating Brainiacs_Function...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
	CLS
	echo Done updating Brainiacs_Function.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
)

::Windows_Defrag
::Download Windows_Defragr if not present
if not exist "%Output%/Functions/Windows_Defrag.bat" (
	CLS
	echo Windows_Defrag not present.
	echo.
	echo Downloading Windows_Defrag.
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Windows_Defrag.bat" -O "%Output%/Functions/Windows_Defrag.bat" 2>NUL
	CLS
	echo Done downloading Windows_Defrag.
	echo.
	TIMEOUT 2
	CLS
) else if "%Windows_Defrag_Function_Online%" GTR "%Windows_Defrag_Function_Local%" (
	CLS
	echo Updating Windows_Defrag...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Windows_Defrag.bat" -O "%Output%/Functions/Windows_Defrag.bat" 2>NUL
	CLS
	echo Done updating Windows_Defrag.
	echo.
	TIMEOUT 2
	CLS
) else if %Test_Update_All%==yes (
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Windows_Defrag.bat" -O "%Output%/Functions/Windows_Defrag.bat" 2>NUL
)

::End file if updated due to testing
if %Test_Update_All%==yes (
	  goto:Backtotool
)

::Updated tools based on variables

::Rkill_Tool
if "%RKill_Update_Tool_Online%" GTR "%RKill_Update_Tool_Local%" (
	CLS
	echo Updating Rkill_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%RKill_Url%" -O "%Output%\Tools\RKill\rkill.exe" 2>NUL
	CLS
	echo Done updating Rkill_Tool.
	TIMEOUT 2
	CLS
)

::JRT_Tool
if "%JRT_Update_Tool_Online%" GTR "%JRT_Update_Tool_Local%" (
	CLS
	echo Updating JRT_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%JRT_Url%" -O "%Output%\Tools\JRT\JRT.exe" 2>NUL
	CLS
	echo Done updating JRT_Tool.
	TIMEOUT 2
	CLS
)

::TDSS_Tool
if "%TDSS_Update_Tool_Online%" GTR "%TDSS_Update_Tool_Local%" (
	CLS
	echo Updating TDSS Killer...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%TDSS_Url%" -O "%Output%/TDSSKiller.zip" 2>NUL
	CLS
	echo Unzipping file.
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\TDSS'); $zip = $shell.NameSpace('%Output%\TDSSKiller.zip'); $target.CopyHere($zip.Items(), 16); }"
	CLS
	echo Deleting downloaded file
	del "%Output%\TDSSKiller.zip"
	CLS
	echo Done updating TDSS_Tool.
	TIMEOUT 2
	CLS
)

::Rogue_Tool
if "%Rogue_Update_Tool_Online%" GTR "%Rogue_Update_Tool_Local%" (
	CLS
	echo Updating Rogue_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Rogue_Url%" -O "%Output%\Tools\RogueKiller\RogueKillerCMD.exe" 2>NUL
	CLS
	echo Done updating Rogue_Tool.
	TIMEOUT 2
	CLS
)

::ADW_Tool
if "%ADW_Update_Tool_Online%" GTR "%ADW_Update_Tool_Local%" (
	CLS
	echo Updating ADW_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%ADW_Url%" -O "%Output%\Tools\ADW\adwcleaner.exe" 2>NUL
	CLS
	echo Done updating ADW_Tool.
	TIMEOUT 2
	CLS
)

::HitmanPro_Tool
if "%HitmanPro_Update_Tool_Online%" GTR "%HitmanPro_Update_Tool_Local%" (
	CLS
	echo Updating HitmanPro_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%HitmanPro_Url%" -O "%Output%\Tools\HitmanPro\HitmanPro.exe" 2>NUL
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%HitmanPro_64_Url%" -O "%Output%\Tools\HitmanPro\HitmanPro_x64.exe" 2>NUL
	CLS
	echo Done updating HitmanPro_Tool.
	TIMEOUT 2
	CLS
)

::Zemana_Tool
if "%Zemana_Update_Tool_Online%" GTR "%Zemana_Update_Tool_Local%" (
	CLS
	echo Updating Zemana...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Zemana_Url%" -O "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe"
	CLS
	echo Done updating Zemana.
	TIMEOUT 2
	CLS
)

::MBAR_Tool
::FIX DOWNLOAD DIR
if "%MBAR_Update_Tool_Online%" GTR "%MBAR_Update_Tool_Local%" (
	CLS
	echo Updating MBAR_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%MBAR_Url%" -O "%Output%\Tools\MBAR\mbar.exe" 2>NUL
	CLS
	echo Done updating MBAR_Tool.
	TIMEOUT 2
	CLS
)

::Malwarebytes_Tool
if "%Malwarebytes_Update_Tool_Online%" GTR "%Malwarebytes_Update_Tool_Local%" (
	CLS
	echo Updating Malwarebytes_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Malwarebytes_Url%" -O "%Output%\Tools\Malwarebytes\mb3-setup.exe" 2>NUL
	CLS
	echo Done updating Malwarebytes_Tool.
	TIMEOUT 2
	CLS
)

::Spybot_Tool
if "%Spybot_Update_Tool_Online%" GTR "%Spybot_Update_Tool_Local%" (
	CLS
	echo Updating Spybot_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Spybot_Url%" -O "%Output%\Tools\SpyBot\spybotsd.exe" 2>NUL
	CLS
	echo Done updating Spybot_Tool.
	TIMEOUT 2
	CLS
)

::CCleaner_Tool
if "%CCleaner_Update_Tool_Online%" GTR "%CCleaner_Update_Tool_Local%" (
	CLS
	echo Updating CCleaner_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%CCleaner_Url%" -O "%Output%/ccsetup.zip" 2>NUL
	CLS
	echo Unzipping file.
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\CCleaner'); $zip = $shell.NameSpace('%Output%\ccsetup.zip'); $target.CopyHere($zip.Items(), 16); }"
	CLS
	echo Deleting downloaded file
	del "%Output%\ccsetup.zip"
	CLS
	echo Done updating CCleaner_Tool.
	TIMEOUT 2
	CLS
)

::DefragSystem_A_Tool
if "%DefragSystem_A_Update_Tool_Online%" GTR "%DefragSystem_A_Update_Tool_Local%" (
	CLS
	echo Updating DefragSystem_A_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%DefragSystem_A_Url%" -O "%Output%\Tools\AUS\ausdiskdefrag.exe" 2>NUL
	CLS
	echo Done updating DefragSystem_A_Tool.
	TIMEOUT 2
	CLS
)

::DefragSystem_D_Tool
if "%DefragSystem_D_Update_Tool_Online%" GTR "%DefragSystem_D_Update_Tool_Local%" (
	CLS
	echo Updating DefragSystem_D_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%DefragSystem_D_Url%" -O "%Output%\dfsetup.zip" 2>NUL
	CLS
	echo Unzipping file.
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\Defraggler'); $zip = $shell.NameSpace('%Output%\dfsetup.zip'); $target.CopyHere($zip.Items(), 16); }"
	CLS
	echo Deleting downloaded file
	del "%Output%\dfsetup.zip"
	CLS
	echo Done updating DefragSystem_D_Tool.
	TIMEOUT 2
	CLS
)

::Caffeine_Update_Tool
if "%Caffeine_Update_Tool_Online%" GTR "%Caffeine_Update_Tool_Local%" (
	CLS
	echo Updating Caffeine_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Caffeine_Url%" -O "%Output%\Tools\Caffeine\caffeine.exe" 2>NUL
	CLS
	echo Done updating Caffeine_Tool.
	TIMEOUT 2
	CLS
)

::Geek_Update_Tool
::Download Geek Uninstaller if not present
if not exist "%Output%\Tools\Geek\" (
	CLS
	echo Geek_Tool not present.
	echo.
	echo Downloading Geek_Tool.
	echo.
	mkdir "%Output%\Tools\Geek\"
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Geek_Url%" -O "%Output%\Tools\Geek\geek.zip" 2>NUL
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\Geek'); $zip = $shell.NameSpace('%Output%\Tools\Geek\geek.zip'); $target.CopyHere($zip.Items(), 16); }"
	del "%Output%\Tools\Geek\geek.zip"
	CLS
	echo Done downloading Geek_Tool.
	echo.
	TIMEOUT 2
	CLS
	goto Skip_Geek_Update
)

::Update Geek Uninstaller
if "%Geek_Update_Tool_Online%" GTR "%Geek_Update_Tool_Local%" (
	CLS
	echo Updating Geek_Tool...
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Geek_Url%" -O "%Output%\Tools\Geek\geek.zip" 2>NUL
	CLS
	echo Unzipping file.
	echo.
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\Geek'); $zip = $shell.NameSpace('%Output%\Tools\Geek\geek.zip'); $target.CopyHere($zip.Items(), 16); }"
	CLS
	echo Deleting downloaded file
	echo.
	del "%Output%\Tools\Geek\geek.zip"
	CLS
	echo Done updating Geek_Tool.
	echo.
	TIMEOUT 2
	CLS
)
:Skip_Geek_Update

::Update Readme file
if "%Readme_Online%" GTR "%Readme_Local%" (
	CLS
	echo Updating Readme file...
	echo.
	"%Output%\Tools\WGET\wget.exe" -q  --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 "%REPO_URL%/%REPO_BRANCH%/Readme.txt" -O "%Output%\Readme.txt"
	CLS
	echo Done updating Readme file.
	TIMEOUT 2
	CLS
)

::Update Version file
if "%Version_Online%" GTR "%Version_Local%" (
	CLS
	echo Updating Verison file...
	echo.
	"%Output%\Tools\WGET\wget.exe" -q  --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 "%REPO_URL%/%REPO_BRANCH%/Version.txt" -O "%Output%\Version.txt"
	CLS
	echo Done updating Verison file.
	TIMEOUT 2
	CLS
)

::Update Changelog file
if "%Changelog_Online%" GTR "%Changelog_Local%" (
	CLS
	echo Updating Changelog file...
	echo.
	"%Output%\Tools\WGET\wget.exe" -q  --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 "%REPO_URL%/%REPO_BRANCH%/Changelog.txt" -O "%Output%\Changelog.txt"
	CLS
	echo Done updating Changelog file.
	TIMEOUT 2
	CLS
)

::Set the window title
title [Update] Brainiacs Cleanup Tool v%TOOL_VERSION%

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
echo    Re-open the tool to load the new version.
echo.
echo ===================================================================================
TIMEOUT 10
::Start Brainiacs tool
set Skip_Update=yes
exit

::Set default Color
color 07

::Re-Open main file
:Backtotool
CLS
