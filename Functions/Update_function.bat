@echo off

REM Set repo variables
set REPO_URL=https://raw.githubusercontent.com/Gigoo25/BrainiacAutoCleanupTool
set REPO_BRANCH=master

REM Set tool verison check variables
set CURRENT_VERSION=unidentified
set CHECK_UPDATE_VERSION=unidentified

REM Text files local variables
set Readme_Local=unidentified
set Version_Local=unidentified
set Changelog_Local=unidentified

REM Text files online variables
set Readme_Online=unidentified
set Version_Online=unidentified
set Changelog_Online=unidentified

REM Function local variables
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
set Update_Function_Local=unidentified
set Windows_Defrag_Function_Local=unidentified

REM Function online variables
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
set Update_Function_Online=unidentified
set Windows_Defrag_Function_Online=unidentified

REM Tool local variables
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

REM Tool online variables
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

REM Tool download location variables
set RKill_Url=unidentified
set JRT_Url=unidentified
set TDSS_Url=http://media.kaspersky.com/utilities/VirusUtilities/EN/tdsskiller.zip
set Rogue_Url=unidentified
set ADW_Url=https://downloads.malwarebytes.com/file/adwcleaner/adwcleaner_7.3.exe
set HitmanPro_Url=https://dl.surfright.nl/HitmanPro.exe
set HitmanPro_64_Url=https://dl.surfright.nl/HitmanPro_x64.exe
set Zemana_Url=http://dl12.zemana.com/AntiMalware/2.74.2.664/Zemana.AntiMalware.Portable.exe
set MBAR_Url=unidentified
set Malwarebytes_Url=unidentified
set Spybot_Url=unidentified
set CCleaner_Url=https://download.ccleaner.com/portable/ccsetup556.zip
set DefragSystem_A_Url=http://downloads.auslogics.com/en/disk-defrag/ausdiskdefragportable.exe
set DefragSystem_D_Url=https://softpedia-secure-download.com/dl/43f41169943fef85b1fcc5f7e22ac9bf/5c9b623b/100100698/software/portable/system/dfsetup222.zip
set Caffeine_Url=unidentified
set Geek_Url=https://geekuninstaller.com/geek.zip

REM Update all functions if ran in test mode
if %Test_Update_All%==yes (
	goto Test_Upgrade_All
)

REM Set the window title
title [Update] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Check that wget is present
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
	GOTO :EOF
)

REM Check for version file
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
	GOTO :EOF
)

REM Delete version check file if found
if exist "%TEMP%\Version_Check.txt" (
	del "%TEMP%\Version_Check.txt" 2>NUL
)

REM Download version to compare from online
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
	GOTO :EOF
)

REM Check if downloaded version is greater
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
REM Set red Color
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
REM Set default Color
color 07
GOTO :EOF

:update_yes
REM Set default Color
color 07

REM Set variables for local text files
< "%Output%\Version.txt" (
	for /l %%i in (1,1,9) do set /p =
	set /p Readme_Local=
	set /p Version_Local=
	set /p Changelog_Local=
)

REM Set variables for online text files
< "%TEMP%\Version_Check.txt" (
	for /l %%i in (1,1,9) do set /p =
	set /p Readme_Online=
	set /p Version_Online=
	set /p Changelog_Online=
)

REM Set variables for Functions_Local
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
	set /p Update_Function_Local=
	set /p Windows_Defrag_Function_Local=
)

REM Set variables for Tools_Local
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

REM Set variables for Functions_Online
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
	set /p Update_Function_Online=
	set /p Windows_Defrag_Function_Online=
)

REM Set variables for Tools_Online
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

REM Update if ran in test mode
:Test_Upgrade_All
if %Test_Update_All%==yes (
	CLS
	echo.
	echo  ^! ALERT
	echo ==========================================
	echo.
	echo   Upgrading all functions from source...
	echo.
	echo ==========================================
)

REM --------------------------------------
REM Update functions based on version file
REM --------------------------------------

REM Update_Function
if "%Update_Function_Online%" GTR "%Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ======================================
	echo.
	echo   Updating Update_Function...
	echo.
	echo ======================================
	echo.
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Update_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ==================================
	echo.
	echo   Update_function not present.
	echo.
	echo   Downloading Update_function...
	echo.
	echo ==================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM Rkill_Function
if "%RKill_Update_Function_Online%" GTR "%RKill_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==============================
	echo.
	echo   Updating Rkill_Function...
	echo.
	echo ==============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Rkill_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Rkill_Function not present.
	echo.
	echo   Downloading Rkill_Function...
	echo.
	echo =================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM JRT_Function
if "%JRT_Update_Function_Online%" GTR "%JRT_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ============================
	echo.
	echo   Updating JRT_Function...
	echo.
	echo ============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
) else if not exist "%Output%\Functions\JRT_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ===============================
	echo.
	echo   JRT_function not present.
	echo.
	echo   Downloading JRT_function...
	echo.
	echo ===============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM TDSS_Function
if "%TDSS_Update_Function_Online%" GTR "%TDSS_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =============================
	echo.
	echo   Updating TDSS_Function...
	echo.
	echo =============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
) else if not exist "%Output%\Functions\TDSS_Function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ================================
	echo.
	echo   TDSS_Function not present.
	echo.
	echo   Downloading TDSS_Function...
	echo.
	echo ================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM Rogue_Function
if "%TDSS_Update_Function_Online%" GTR "%TDSS_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==============================
	echo.
	echo   Updating Rogue_Function...
	echo.
	echo ==============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Rogue_Function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Rogue_Function not present.
	echo.
	echo   Downloading Rogue_Function...
	echo.
	echo =================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM ADW_Function
if "%ADW_Update_Function_Online%" GTR "%ADW_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ============================
	echo.
	echo   Updating ADW_Function...
	echo.
	echo ============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
) else if not exist "%Output%\Functions\ADW_Function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ===============================
	echo.
	echo   ADW_Function not present.
	echo.
	echo   Downloading ADW_Function...
	echo.
	echo ===============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM HitmanPro_Function
if "%HitmanPro_Update_Function_Online%" GTR "%HitmanPro_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==================================
	echo.
	echo   Updating HitmanPro_Function...
	echo.
	echo ==================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
) else if not exist "%Output%\Functions\HitmanPro_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo =====================================
	echo.
	echo   HitmanPro_function not present.
	echo.
	echo   Downloading HitmanPro_function...
	echo.
	echo =====================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM Zemana_Function
if "%Zemana_Update_Function_Online%" GTR "%Zemana_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===============================
	echo.
	echo   Updating Zemana_Function...
	echo.
	echo ===============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Zemana_Function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ==================================
	echo.
	echo   Zemana_Function not present.
	echo.
	echo   Downloading Zemana_Function...
	echo.
	echo ==================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM MBAR_Function
if "%MBAR_Update_Function_Online%" GTR "%MBAR_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =============================
	echo.
	echo   Updating MBAR_Function...
	echo.
	echo =============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
) else if not exist "%Output%\Functions\MBAR_Function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ================================
	echo.
	echo   MBAR_Function not present.
	echo.
	echo   Downloading MBAR_Function...
	echo.
	echo ================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM Malwarebytes_Function
if "%Malwarebytes_Update_Function_Online%" GTR "%Malwarebytes_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =====================================
	echo.
	echo   Updating Malwarebytes_Function...
	echo.
	echo =====================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Malwarebytes_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ========================================
	echo.
	echo   Malwarebytes_Function not present.
	echo.
	echo   Downloading Malwarebytes_Function...
	echo.
	echo ========================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM Spybot_Function
if "%Spybot_Update_Function_Online%" GTR "%Spybot_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===============================
	echo.
	echo   Updating Spybot_Function...
	echo.
	echo ===============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Spybot_Function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ==================================
	echo.
	echo   Spybot_Function not present.
	echo.
	echo   Downloading Spybot_Function...
	echo.
	echo ==================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM CCleaner_Function
if "%CCleaner_Update_Function_Online%" GTR "%CCleaner_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Updating CCleaner_Function...
	echo.
	echo =================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
) else if not exist "%Output%\Functions\CCleaner_Function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ====================================
	echo.
	echo   CCleaner_Function not present.
	echo.
	echo   Downloading CCleaner_Function...
	echo.
	echo ====================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM DefragSystem_A_Update_Function
if "%DefragSystem_A_Update_Function_Online%" GTR "%DefragSystem_A_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ====================================
	echo.
	echo   Updating Aus_Defrag_function...
	echo.
	echo ====================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Aus_Defrag_function.bat" -O "%Output%\Functions\Aus_Defrag_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Aus_Defrag_function.bat" -O "%Output%\Functions\Aus_Defrag_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Aus_Defrag_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ======================================
	echo.
	echo   Aus_Defrag_function not present.
	echo.
	echo   Downloading Aus_Defrag_function...
	echo.
	echo ======================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Aus_Defrag_function.bat" -O "%Output%\Functions\Aus_Defrag_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM DefragSystem_D_Update_Function
if "%DefragSystem_D_Update_Function_Online%" GTR "%DefragSystem_D_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==========================================
	echo.
	echo   Updating Defraggler_Defrag_function...
	echo.
	echo ==========================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Defraggler_Defrag_function.bat" -O "%Output%\Functions\Defraggler_Defrag_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Defraggler_Defrag_function.bat" -O "%Output%\Functions\Defraggler_Defrag_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Defraggler_Defrag_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo =============================================
	echo.
	echo   Defraggler_Defrag_function not present.
	echo.
	echo   Downloading Defraggler_Defrag_function...
	echo.
	echo =============================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Defraggler_Defrag_function.bat" -O "%Output%\Functions\Defraggler_Defrag_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM ImageChecker_Function
if "%ImageChecker_Update_Function_Online%" GTR "%ImageChecker_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =====================================
	echo.
	echo   Updating ImageChecker_Function...
	echo.
	echo =====================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Image_Checker_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo =========================================
	echo.
	echo   Image_Checker_function not present.
	echo.
	echo   Downloading Image_Checker_function...
	echo.
	echo =========================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM CHKDSK_Function
if "%CHKDSK_Update_Function_Online%" GTR "%CHKDSK_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===============================
	echo.
	echo   Updating CHKDSK_Function...
	echo.
	echo ===============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
) else if not exist "%Output%\Functions\CHKDSK_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ==================================
	echo.
	echo   CHKDSK_Function not present.
	echo.
	echo   Downloading CHKDSK_Function...
	echo.
	echo ==================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM SystemRestore_Function
if "%SystemRestore_Update_Function_Online%" GTR "%SystemRestore_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ================================
	echo.
	echo   Updating Restore_function...
	echo.
	echo ================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Restore_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ===================================
	echo.
	echo   Restore_function not present.
	echo.
	echo   Downloading Restore_function...
	echo.
	echo ===================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM DeleteNotes_Function
if "%DeleteNotes_Update_Function_Online%" GTR "%DeleteNotes_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ====================================
	echo.
	echo   Updating DeleteNotes_Function...
	echo.
	echo ====================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
) else if not exist "%Output%\Functions\DeleteNotes_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo =======================================
	echo.
	echo   DeleteNotes_function not present.
	echo.
	echo   Downloading DeleteNotes_function...
	echo.
	echo =======================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM DeleteLogs_Function
if "%DeleteLogs_Update_Function_Online%" GTR "%DeleteLogs_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===================================
	echo.
	echo   Updating DeleteLogs_Function...
	echo.
	echo ===================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
) else if not exist "%Output%\Functions\DeleteLogs_function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ======================================
	echo.
	echo   DeleteLogs_function not present.
	echo.
	echo   Downloading DeleteLogs_function...
	echo.
	echo ======================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM DeleteTools_Function
if "%DeleteTools_Update_Function_Online%" GTR "%DeleteTools_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ====================================
	echo.
	echo   Updating DeleteTools_Function...
	echo.
	echo ====================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
) else if not exist "%Output%\Functions\DeleteTools_Function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo =======================================
	echo.
	echo   DeleteTools_Function not present.
	echo.
	echo   Downloading DeleteTools_Function...
	echo.
	echo =======================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM Brainiacs_Function
if "%Brainiacs_Update_Function_Online%" GTR "%Brainiacs_Update_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==================================
	echo.
	echo   Updating Brainiacs_Function...
	echo.
	echo ==================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
) else if not exist "%Output%\Functions\Brainiacs.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ================================
	echo.
	echo   Brainiacs.bat not present.
	echo.
	echo   Downloading Brainiacs.bat...
	echo.
	echo ================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM Windows_Defrag_Function
if "%Windows_Defrag_Function_Online%" GTR "%Windows_Defrag_Function_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =======================================
	echo.
	echo   Updating Windows_Defrag_Function...
	echo.
	echo =======================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Windows_Defrag_Function.bat" -O "%Output%/Functions/Windows_Defrag_Function.bat" 2>NUL
	TIMEOUT 1 >nul
) else if %Test_Update_All%==yes (
	REM Download if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Windows_Defrag_Function.bat" -O "%Output%/Functions/Windows_Defrag_Function.bat" 2>NUL
) else if not exist "%Output%/Functions/Windows_Defrag_Function.bat" (
	REM Download if not present
	CLS
	echo.
	echo  ^! ALERT
	echo ==========================================
	echo.
	echo   Windows_Defrag_Function not present
	echo.
	echo   Downloading Windows_Defrag_Function...
	echo.
	echo ==========================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Windows_Defrag_Function.bat" -O "%Output%/Functions/Windows_Defrag_Function.bat" 2>NUL
	TIMEOUT 1 >nul
)

REM End file if updated due to testing
if %Test_Update_All%==yes (
	  goto:Backtotool
)

REM Updated tools based on variables
REM Rkill_Tool
if "%RKill_Update_Tool_Online%" GTR "%RKill_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==========================
	echo.
	echo   Updating Rkill_Tool...
	echo.
	echo ==========================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%RKill_Url%" -O "%Output%\Tools\RKill\rkill.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM JRT_Tool
if "%JRT_Update_Tool_Online%" GTR "%JRT_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ========================
	echo.
	echo   Updating JRT_Tool...
	echo.
	echo ========================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%JRT_Url%" -O "%Output%\Tools\JRT\JRT.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM TDSS_Tool
if "%TDSS_Update_Tool_Online%" GTR "%TDSS_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===========================
	echo.
	echo   Updating TDSS Killer...
	echo.
	echo ===========================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%TDSS_Url%" -O "%Output%/TDSSKiller.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\TDSS'); $zip = $shell.NameSpace('%Output%\TDSSKiller.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Deleting zip file
	del "%Output%\TDSSKiller.zip"
	TIMEOUT 1 >nul
)

REM Rogue_Tool
if "%Rogue_Update_Tool_Online%" GTR "%Rogue_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==========================
	echo.
	echo   Updating Rogue_Tool...
	echo.
	echo ==========================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Rogue_Url%" -O "%Output%\Tools\RogueKiller\RogueKillerCMD.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM ADW_Tool
if "%ADW_Update_Tool_Online%" GTR "%ADW_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ========================
	echo.
	echo   Updating ADW_Tool...
	echo.
	echo ========================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%ADW_Url%" -O "%Output%\Tools\ADW\adwcleaner.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM HitmanPro_Tool
if "%HitmanPro_Update_Tool_Online%" GTR "%HitmanPro_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==============================
	echo.
	echo   Updating HitmanPro_Tool...
	echo.
	echo ==============================
	REM Update 32 bit version
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%HitmanPro_Url%" -O "%Output%\Tools\HitmanPro\HitmanPro.exe" 2>NUL
	REM Update 64 bit version
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%HitmanPro_64_Url%" -O "%Output%\Tools\HitmanPro\HitmanPro_x64.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM Zemana_Tool
if "%Zemana_Update_Tool_Online%" GTR "%Zemana_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ======================
	echo.
	echo   Updating Zemana...
	echo.
	echo ======================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Zemana_Url%" -O "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe"
	TIMEOUT 1 >nul
)

REM MBAR_Tool
REM FIX DOWNLOAD DIR
if "%MBAR_Update_Tool_Online%" GTR "%MBAR_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =========================
	echo.
	echo   Updating MBAR_Tool...
	echo.
	echo =========================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%MBAR_Url%" -O "%Output%\Tools\MBAR\mbar.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM Malwarebytes_Tool
if "%Malwarebytes_Update_Tool_Online%" GTR "%Malwarebytes_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Updating Malwarebytes_Tool...
	echo.
	echo =================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Malwarebytes_Url%" -O "%Output%\Tools\Malwarebytes\mb3-setup.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM Spybot_Tool
if "%Spybot_Update_Tool_Online%" GTR "%Spybot_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===========================
	echo.
	echo   Updating Spybot_Tool...
	echo.
	echo ===========================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Spybot_Url%" -O "%Output%\Tools\SpyBot\spybotsd.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM CCleaner_Tool
if "%CCleaner_Update_Tool_Online%" GTR "%CCleaner_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =============================
	echo.
	echo   Updating CCleaner_Tool...
	echo.
	echo =============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%CCleaner_Url%" -O "%Output%/ccsetup.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\CCleaner'); $zip = $shell.NameSpace('%Output%\ccsetup.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Delete zip file
	del "%Output%\ccsetup.zip"
	TIMEOUT 1 >nul
)

REM DefragSystem_A_Tool
if "%DefragSystem_A_Update_Tool_Online%" GTR "%DefragSystem_A_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ================================
	echo.
	echo   Updating DefragSystem_A_Tool...
	echo.
	echo ================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%DefragSystem_A_Url%" -O "%Output%\Tools\AUS\ausdiskdefrag.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM DefragSystem_D_Tool
if "%DefragSystem_D_Update_Tool_Online%" GTR "%DefragSystem_D_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===================================
	echo.
	echo   Updating DefragSystem_D_Tool...
	echo.
	echo ===================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%DefragSystem_D_Url%" -O "%Output%\dfsetup.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\Defraggler'); $zip = $shell.NameSpace('%Output%\dfsetup.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Delete zip file
	del "%Output%\dfsetup.zip"
	TIMEOUT 1 >nul
)

REM Caffeine_Update_Tool
if "%Caffeine_Update_Tool_Online%" GTR "%Caffeine_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =============================
	echo.
	echo   Updating Caffeine_Tool...
	echo.
	echo =============================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Caffeine_Url%" -O "%Output%\Tools\Caffeine\caffeine.exe" 2>NUL
	TIMEOUT 1 >nul
)

REM Geek_Update_Tool
REM Download Geek Uninstaller if not present
if not exist "%Output%\Tools\Geek\" (
	CLS
	echo.
	echo  ^! ALERT
	echo ============================
	echo.
	echo   Geek_Tool not present.
	echo.
	echo   Downloading Geek_Tool...
	echo.
	echo ============================
	mkdir "%Output%\Tools\Geek\"
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Geek_Url%" -O "%Output%\Tools\Geek\geek.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\Geek'); $zip = $shell.NameSpace('%Output%\Tools\Geek\geek.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Delete zip file
	del "%Output%\Tools\Geek\geek.zip"
	TIMEOUT 1 >nul
	goto Skip_Geek_Update
)

REM Update Geek Uninstaller
if "%Geek_Update_Tool_Online%" GTR "%Geek_Update_Tool_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo =========================
	echo.
	echo   Updating Geek_Tool...
	echo.
	echo =========================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Geek_Url%" -O "%Output%\Tools\Geek\geek.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\Geek'); $zip = $shell.NameSpace('%Output%\Tools\Geek\geek.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Deleteing zip file
	del "%Output%\Tools\Geek\geek.zip"
	TIMEOUT 1 >nul
)
:Skip_Geek_Update

REM Update Readme file
if "%Readme_Online%" GTR "%Readme_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===========================
	echo.
	echo   Updating Readme file...
	echo.
	echo ===========================
	"%Output%\Tools\WGET\wget.exe" -q  --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 "%REPO_URL%/%REPO_BRANCH%/Readme.txt" -O "%Output%\Readme.txt"
	TIMEOUT 1 >nul
)

REM Update Version file
if "%Version_Online%" GTR "%Version_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ============================
	echo.
	echo   Updating Verison file...
	echo.
	echo ============================
	"%Output%\Tools\WGET\wget.exe" -q  --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 "%REPO_URL%/%REPO_BRANCH%/Version.txt" -O "%Output%\Version.txt"
	TIMEOUT 1 >nul
)

REM Update Changelog file
if "%Changelog_Online%" GTR "%Changelog_Local%" (
	CLS
	echo.
	echo  ^! ALERT
	echo ==============================
	echo.
	echo   Updating Changelog file...
	echo.
	echo ==============================
	"%Output%\Tools\WGET\wget.exe" -q  --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 "%REPO_URL%/%REPO_BRANCH%/Changelog.txt" -O "%Output%\Changelog.txt"
	TIMEOUT 1 >nul
)

REM Set the window title
title [Update] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Notify update was successful
REM Set red Color
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
REM Start Brainiacs tool
set Skip_Update=yes
exit

REM Set default Color
color 07

REM Re-Open main file
:Backtotool
CLS
