@echo off

REM Set repo variables
set REPO_URL=https://raw.githubusercontent.com/Gigoo25/BrainiacAutoCleanupTool
set REPO_BRANCH=master
set REPO_BRANCH_TEST=experimental_new_menu

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
set Email_function_Local=unidentified

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
set Email_function_Online=unidentified

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
set Geek_Update_Tool_Local=unidentified
set Blat_Update_Tool_Local=unidentified

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
set Geek_Update_Tool_Online=unidentified
set Blat_Update_Tool_Online=unidentified

REM Tool download location variables
set RKill_Url=unidentified
set JRT_Url=unidentified
set TDSS_Url=http://media.kaspersky.com/utilities/VirusUtilities/EN/tdsskiller.zip
set Rogue_32_Url=unidentified
set Rogue_64_Url=unidentified
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
set Geek_Url=https://geekuninstaller.com/geek.zip
set Blat_Url=unidentified

REM Update functions based on branch selected
if %TEST_UPDATE_MASTER%==yes (
	REM Display message that tool will upgrade to master branch.
	%Output%\Functions\Menu\MessageBox "Upgrading from master branch." "[ALERT] Brainiacs Cleanup Tool" /B:Y /I:A /O:N
	goto Test_Upgrade
	)
if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Display message that tool will upgrade to experimental branch.
	%Output%\Functions\Menu\MessageBox "Upgrading from experimental branch." "[ALERT] Brainiacs Cleanup Tool" /B:Y /I:A /O:N
	goto Test_Upgrade
)

REM Skip checks if reopening from updating update_function
if not "%SKIP_UPDATE_FUNCTION%"=="Yes" (
	goto Continue_Without_Skipping
) else (
	goto update_yes
)
:Continue_Without_Skipping

REM Check that wget is present
if not exist "%Output%\Tools\WGET\wget.exe" (
	REM Display error message that WGET was not found.
	%Output%\Functions\Menu\MessageBox "WGET not found.\n\nCannot check for updates.\n\nChecking for updates will be skipped." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	GOTO :EOF
)

REM Check for version file
if exist "%Output%\Version.txt" (
	REM Set current version as variable
	set /p CURRENT_VERSION=<%Output%\Version.txt
) else (
	REM Display error message that tool version was not found.
	%Output%\Functions\Menu\MessageBox "Cannot detect tool version.\n\nCannot check for updates.\n\nChecking for updates will be skipped." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
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
	REM Display error message that tool version was not found.
	%Output%\Functions\Menu\MessageBox "Something went wrong.\n\nFailed to check for updates.\n\nChecking for updates will be skipped." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
	GOTO :EOF
)

REM Check if downloaded version is greater
if "%CHECK_UPDATE_VERSION%" GTR "%CURRENT_VERSION%" (
	FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Update found.\n\nDo you want to update the tool\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:A /O:N`) DO (
		IF /I "%%G"=="Yes" (
	    REM Go-to tag
			goto update_yes
		) else (
	    REM Go-to tag
			goto update_no
		)
	)
) else (
	GOTO :EOF
)

REM Accept update
:update_no
REM Display message that user did not accept update.
%Output%\Functions\Menu\MessageBox "You did not accept to update the tool.\n\nRemember that this is your decision. Hope you don't encounter any bugs.\n\nUpdate will be skipped." "[ERROR] Brainiacs Cleanup Tool" /B:O /I:E /O:N
GOTO :EOF

REM Decline update
:update_yes
REM If its lower that a major release then prompt the user to download the new update.
if "%CURRENT_VERSION%" LSS "2.0" (
	REM Display message that version is too old then prompt for download
	if "%CHECK_UPDATE_VERSION%" GTR "%CURRENT_VERSION%" (
		REM Ask if sub wants to update
		FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Tool version too old to update.\n\nYou will need to download the new packed version of the tool.\n\nDo you want to download the new packed version now\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:A /O:N`) DO (
			IF /I "%%G"=="Yes" (
				REM Display message that user did not accept update.
				%Output%\Functions\Menu\MessageBox "Opening packed update download page.\n\nPlease re-run the newly downloaded tool.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close and self-destruct in 30 seconds." "[ALERT] Brainiacs Cleanup Tool" /B:O /I:A /O:N
				REM Open download pages
				start "" "https://github.com/Gigoo25/BrainiacAutoCleanupTool/releases"
				REM Self-destruct
				(goto) 2>nul & del "%~f0" & rmdir "%Output%" /s /q
			) else (
				REM Display message that user did not accept update.
				%Output%\Functions\Menu\MessageBox "You did not accept to update the tool.\n\nRemember that this is your decision. Hope you don't encounter any bugs.\n\nUpdate will be skipped." "[ERROR] Brainiacs Cleanup Tool" /B:O /I:E /O:N
				GOTO :EOF
			)
		)
	)
)

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
	set /p Email_function_Local=
)

REM Set variables for Tools_Local
< "%Output%\Version.txt" (
	for /l %%i in (1,1,81) do set /p =
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
	set /p Geek_Update_Tool_Local=
	set /p Blat_Update_Tool_Local=
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
	set /p Email_function_Online=
)

REM Set variables for Tools_Online
< "%TEMP%\Version_Check.txt" (
	for /l %%i in (1,1,81) do set /p =
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
	set /p Geek_Update_Tool_Online=
	set /p Blat_Update_Tool_Online=
)

REM Update functions if ran in test mode
:Test_Upgrade

REM --------------------------------------
REM Update functions based on version file
REM --------------------------------------

REM Update_Function
if not "%SKIP_UPDATE_FUNCTION%"=="Yes" (
	REM Check if online function version is greater than local, if so then update
	if "%Update_Function_Online%" GTR "%Update_Function_Local%" (
		REM Update function based on variables
		"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
		REM Set variables
		set SKIP_UPDATE_FUNCTION=Yes
		REM Kill update function and restart update function after update of function.
		(goto) 2>nul & start /MAX cmd /c %0 max & exit/b
	) else if %TEST_UPDATE_MASTER%==yes (
		REM Update from master branch if debug mode is enabled
		"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
	) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
		REM Update from experimental branch if debug mode is enabled
		"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
	) else if not exist "%Output%\Functions\Update_function.bat" (
		REM Download if not present
		"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Update_function.bat" -O "%TEMP%\Update_function.bat" 2>NUL
	)
)

REM Rkill_Function
if "%RKill_Update_Function_Online%" GTR "%RKill_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Rkill_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Rkill_function.bat" -O "%Output%\Functions\Rkill_function.bat" 2>NUL
)

REM JRT_Function
if "%JRT_Update_Function_Online%" GTR "%JRT_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
) else if not exist "%Output%\Functions\JRT_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/JRT_function.bat" -O "%Output%\Functions\JRT_function.bat" 2>NUL
)

REM TDSS_Function
if "%TDSS_Update_Function_Online%" GTR "%TDSS_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
) else if not exist "%Output%\Functions\TDSS_Killer_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/TDSS_Killer_function.bat" -O "%Output%\Functions\TDSS_Killer_function.bat" 2>NUL
)

REM Rogue_Function
if "%Rogue_Update_Function_Online%" GTR "%Rogue_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
) else if not exist "%Output%\Functions\RogueKiller_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/RogueKiller_function.bat" -O "%Output%\Functions\RogueKiller_function.bat" 2>NUL
)

REM ADW_Function
if "%ADW_Update_Function_Online%" GTR "%ADW_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
) else if not exist "%Output%\Functions\ADW_Function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/ADW_function.bat" -O "%Output%\Functions\ADW_function.bat" 2>NUL
)

REM HitmanPro_Function
if "%HitmanPro_Update_Function_Online%" GTR "%HitmanPro_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
) else if not exist "%Output%\Functions\HitmanPro_function.bat" (
	REM Download if not present
	echo =====================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/HitmanPro_function.bat" -O "%Output%\Functions\HitmanPro_function.bat" 2>NUL
)

REM Zemana_Function
if "%Zemana_Update_Function_Online%" GTR "%Zemana_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
)  else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Zemana_Function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Zemana_function.bat" -O "%Output%\Functions\Zemana_function.bat" 2>NUL
)

REM MBAR_Function
if "%MBAR_Update_Function_Online%" GTR "%MBAR_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
) else if not exist "%Output%\Functions\MBAR_Function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/MBAR_function.bat" -O "%Output%\Functions\MBAR_function.bat" 2>NUL
)

REM Malwarebytes_Function
if "%Malwarebytes_Update_Function_Online%" GTR "%Malwarebytes_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Malwarebytes_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Malwarebytes_function.bat" -O "%Output%\Functions\Malwarebytes_function.bat" 2>NUL
)

REM Spybot_Function
if "%Spybot_Update_Function_Online%" GTR "%Spybot_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Spybot_Function.bat" (
	REM Download if not present
	echo ==================================
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Spybot_function.bat" -O "%Output%\Functions\Spybot_function.bat" 2>NUL
)

REM CCleaner_Function
if "%CCleaner_Update_Function_Online%" GTR "%CCleaner_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
) else if not exist "%Output%\Functions\CCleaner_Function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CCleaner_function.bat" -O "%Output%\Functions\CCleaner_function.bat" 2>NUL
)

REM DefragSystem_A_Update_Function
if "%DefragSystem_A_Update_Function_Online%" GTR "%DefragSystem_A_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Aus_Defrag_function.bat" -O "%Output%\Functions\Aus_Defrag_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Aus_Defrag_function.bat" -O "%Output%\Functions\Aus_Defrag_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Aus_Defrag_function.bat" -O "%Output%\Functions\Aus_Defrag_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Aus_Defrag_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Aus_Defrag_function.bat" -O "%Output%\Functions\Aus_Defrag_function.bat" 2>NUL
)

REM DefragSystem_D_Update_Function
if "%DefragSystem_D_Update_Function_Online%" GTR "%DefragSystem_D_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Defraggler_Defrag_function.bat" -O "%Output%\Functions\Defraggler_Defrag_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Defraggler_Defrag_function.bat" -O "%Output%\Functions\Defraggler_Defrag_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Defraggler_Defrag_function.bat" -O "%Output%\Functions\Defraggler_Defrag_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Defraggler_Defrag_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Defraggler_Defrag_function.bat" -O "%Output%\Functions\Defraggler_Defrag_function.bat" 2>NUL
)

REM ImageChecker_Function
if "%ImageChecker_Update_Function_Online%" GTR "%ImageChecker_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Image_Checker_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Image_Checker_function.bat" -O "%Output%\Functions\Image_Checker_function.bat" 2>NUL
)

REM CHKDSK_Function
if "%CHKDSK_Update_Function_Online%" GTR "%CHKDSK_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
) else if not exist "%Output%\Functions\CHKDSK_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/CHKDSK_function.bat" -O "%Output%\Functions\CHKDSK_function.bat" 2>NUL
)

REM SystemRestore_Function
if "%SystemRestore_Update_Function_Online%" GTR "%SystemRestore_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
) else if not exist "%Output%\Functions\Restore_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Restore_function.bat" -O "%Output%\Functions\Restore_function.bat" 2>NUL
)

REM DeleteNotes_Function
if "%DeleteNotes_Update_Function_Online%" GTR "%DeleteNotes_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
) else if not exist "%Output%\Functions\DeleteNotes_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteNotes_function.bat" -O "%Output%\Functions\DeleteNotes_function.bat" 2>NUL
)

REM DeleteLogs_Function
if "%DeleteLogs_Update_Function_Online%" GTR "%DeleteLogs_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
) else if not exist "%Output%\Functions\DeleteLogs_function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteLogs_function.bat" -O "%Output%\Functions\DeleteLogs_function.bat" 2>NUL
)

REM DeleteTools_Function
if "%DeleteTools_Update_Function_Online%" GTR "%DeleteTools_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
) else if not exist "%Output%\Functions\DeleteTools_Function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/DeleteTools_function.bat" -O "%Output%\Functions\DeleteTools_function.bat" 2>NUL
)

REM Brainiacs_Function
if "%Brainiacs_Update_Function_Online%" GTR "%Brainiacs_Update_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
) else if not exist "%Output%\Brainiacs.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Brainiacs.bat" -O "%Output%\Brainiacs.bat" 2>NUL
)

REM Windows_Defrag_Function
if "%Windows_Defrag_Function_Online%" GTR "%Windows_Defrag_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Windows_Defrag_Function.bat" -O "%Output%/Functions/Windows_Defrag_Function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Windows_Defrag_Function.bat" -O "%Output%/Functions/Windows_Defrag_Function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Windows_Defrag_Function.bat" -O "%Output%/Functions/Windows_Defrag_Function.bat" 2>NUL
) else if not exist "%Output%/Functions/Windows_Defrag_Function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Windows_Defrag_Function.bat" -O "%Output%/Functions/Windows_Defrag_Function.bat" 2>NUL
)

REM Email_Function
if "%Email_Function_Online%" GTR "%Email_Function_Local%" (
	REM Update function based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Email_Function.bat" -O "%Output%/Functions/Email_Function.bat" 2>NUL
) else if %TEST_UPDATE_MASTER%==yes (
	REM Update from master branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Email_Function.bat" -O "%Output%/Functions/Email_Function.bat" 2>NUL
) else if %TEST_UPDATE_EXPERIMENTAL%==yes (
	REM Update from experimental branch if debug mode is enabled
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH_TEST%/Functions/Email_Function.bat" -O "%Output%/Functions/Email_Function.bat" 2>NUL
) else if not exist "%Output%/Functions/Email_Function.bat" (
	REM Download if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%REPO_URL%/%REPO_BRANCH%/Functions/Email_Function.bat" -O "%Output%/Functions/Email_Function.bat" 2>NUL
)

REM End file if updated due to testing
if %TEST_UPDATE_MASTER%==yes (
	  GOTO:EOF
)
if %TEST_UPDATE_EXPERIMENTAL%==yes (
	  GOTO:EOF
)

REM Updated tools based on variables
REM Rkill_Tool
if "%RKill_Update_Tool_Online%" GTR "%RKill_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%RKill_Url%" -O "%Output%\Tools\RKill\rkill.exe" 2>NUL
)

REM JRT_Tool
if "%JRT_Update_Tool_Online%" GTR "%JRT_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%JRT_Url%" -O "%Output%\Tools\JRT\JRT.exe" 2>NUL
)

REM TDSS_Tool
if "%TDSS_Update_Tool_Online%" GTR "%TDSS_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%TDSS_Url%" -O "%Output%/TDSSKiller.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\TDSS'); $zip = $shell.NameSpace('%Output%\TDSSKiller.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Deleting zip file
	del "%Output%\TDSSKiller.zip"
)

REM Rogue_Tool
if "%Rogue_Update_Tool_Online%" GTR "%Rogue_Update_Tool_Local%" (
	REM Update tool based on variables
		REM Update 32 bit version
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Rogue_32_Url%" -O "%Output%\Tools\RogueKiller\RogueKillerCMD_portable32.exe" 2>NUL
		REM Update 64 bit version
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Rogue_64_Url%" -O "%Output%\Tools\RogueKiller\RogueKillerCMD_portable64.exe" 2>NUL
)

REM ADW_Tool
if "%ADW_Update_Tool_Online%" GTR "%ADW_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%ADW_Url%" -O "%Output%\Tools\ADW\adwcleaner.exe" 2>NUL
)

REM HitmanPro_Tool
if "%HitmanPro_Update_Tool_Online%" GTR "%HitmanPro_Update_Tool_Local%" (
	REM Update tool based on variables
		REM Update 32 bit version
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%HitmanPro_Url%" -O "%Output%\Tools\HitmanPro\HitmanPro.exe" 2>NUL
		REM Update 64 bit version
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%HitmanPro_64_Url%" -O "%Output%\Tools\HitmanPro\HitmanPro_x64.exe" 2>NUL
)

REM Zemana_Tool
if "%Zemana_Update_Tool_Online%" GTR "%Zemana_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Zemana_Url%" -O "%Output%\Tools\Zemana\Zemana.AntiMalware.Portable.exe"
)

REM MBAR_Tool
REM FIX DOWNLOAD DIR
if "%MBAR_Update_Tool_Online%" GTR "%MBAR_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%MBAR_Url%" -O "%Output%\Tools\MBAR\mbar.exe" 2>NUL
)

REM Malwarebytes_Tool
if "%Malwarebytes_Update_Tool_Online%" GTR "%Malwarebytes_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Malwarebytes_Url%" -O "%Output%\Tools\Malwarebytes\mb3-setup.exe" 2>NUL
)

REM Spybot_Tool
if "%Spybot_Update_Tool_Online%" GTR "%Spybot_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Spybot_Url%" -O "%Output%\Tools\SpyBot\spybotsd.exe" 2>NUL
)

REM CCleaner_Tool
if "%CCleaner_Update_Tool_Online%" GTR "%CCleaner_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%CCleaner_Url%" -O "%Output%/ccsetup.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\CCleaner'); $zip = $shell.NameSpace('%Output%\ccsetup.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Delete zip file
	del "%Output%\ccsetup.zip"
)

REM DefragSystem_A_Tool
if "%DefragSystem_A_Update_Tool_Online%" GTR "%DefragSystem_A_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%DefragSystem_A_Url%" -O "%Output%\Tools\AUS\ausdiskdefrag.exe" 2>NUL
)

REM DefragSystem_D_Tool
if "%DefragSystem_D_Update_Tool_Online%" GTR "%DefragSystem_D_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%DefragSystem_D_Url%" -O "%Output%\dfsetup.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\Defraggler'); $zip = $shell.NameSpace('%Output%\dfsetup.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Delete zip file
	del "%Output%\dfsetup.zip"
)

REM Update Geek Uninstaller
if "%Geek_Update_Tool_Online%" GTR "%Geek_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Geek_Url%" -O "%Output%\Tools\Geek\geek.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\Geek'); $zip = $shell.NameSpace('%Output%\Tools\Geek\geek.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Deleteing zip file
	del "%Output%\Tools\Geek\geek.zip"
)
if not exist "%Output%\Tools\Geek\" (
	REM Create directory
	mkdir "%Output%\Tools\Geek\"
	REM Download Geek Uninstaller if not present
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Geek_Url%" -O "%Output%\Tools\Geek\geek.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\Tools\Geek'); $zip = $shell.NameSpace('%Output%\Tools\Geek\geek.zip'); $target.CopyHere($zip.Items(), 16); }"
	REM Delete zip file
	del "%Output%\Tools\Geek\geek.zip"
)

REM Blat_Update_Tool_Online
if "%Blat_Update_Tool_Online%" GTR "%Blat_Update_Tool_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 --progress=bar:force "%Blat_Url%" -O "%Output%\blat3219_32.full.zip" 2>NUL
	REM Unzip zip file
	powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%Output%\'); $zip = $shell.NameSpace('%Output%\blat3219_32.full.zip'); $target.CopyHere($zip.Items(), 16); }" 2>NUL
	REM Move folder
	move "%Output%\blat3219\full" "%Output%\Tools\Blat" 2>NUL
	REM Delete zip file
	del "%Output%\blat3219_32.full.zip" 2>NUL
	REM Delete unecessary remaining folder
	rmdir "%Output%\blat3219" /s /q 2>NUL
)

REM Update Readme file
if "%Readme_Online%" GTR "%Readme_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" -q  --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 "%REPO_URL%/%REPO_BRANCH%/Readme.txt" -O "%Output%\Readme.txt"
)

REM Update Version file
if "%Version_Online%" GTR "%Version_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" -q  --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 "%REPO_URL%/%REPO_BRANCH%/Version.txt" -O "%Output%\Version.txt"
)

REM Update Changelog file
if "%Changelog_Online%" GTR "%Changelog_Local%" (
	REM Update tool based on variables
	"%Output%\Tools\WGET\wget.exe" -q  --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 2 "%REPO_URL%/%REPO_BRANCH%/Changelog.txt" -O "%Output%\Changelog.txt"
)

REM Display message that update was successful.
%Output%\Functions\Menu\MessageBox "Update successful.\n\nRe-open the tool to load the new version.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will close in 15 seconds." "[INFORMATION] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:I /O:N /T:15 >nul
exit /b
