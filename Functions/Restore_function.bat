@echo off

REM Set variables
set DELETE_COOLDOWN=unidentified

REM Enable delayed expansion
SETLOCAL ENABLEDELAYEDEXPANSION

REM Start System restore service.
if !SAFE_MODE!==yes (
  REM Display message that TDSS was not found
  %Output%\Functions\Menu\MessageBox "'%WIN_VER%' blocks creating SysRestore points in Safe Mode.\n\nSkipping restore point creation.\n\nReboot to Normal mode and re-run the Autocleanup tool if you absolutely require one." "[ERROR] Brainiacs Cleanup Tool" /B:Y /I:E /O:N /T:10
	REM Set notes
	echo -Skipped restore point due to being booted in safe mode >> !Output!\Notes\Comments.txt
  GOTO :EOF
)

REM Detect if reg key has been added already to prevent false positive
reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v SystemRestorePointCreationFrequency >NUL 2>&1
if /i not !ERRORLEVEL!==0 (
	REM Set variable
	set DELETE_COOLDOWN=yes
) else (
	REM Set variable
	set DELETE_COOLDOWN=no
)

REM Win7 and up only: Remove the cooldown timer (via reg command) and enable System Restore
if /i !WIN_VER_NUM! geq 6.1 (
	if /i "!DELETE_COOLDOWN!"=="yes" (
		reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /t reg_dword /v SystemRestorePointCreationFrequency /d 0 /f >nul
		powershell "Enable-ComputerRestore -Drive "!SystemDrive!" | Out-Null" 2>&1
		if /i not !ERRORLEVEL!==0 (
      REM Display message that restore point pre-check failed
      FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Brainiacs - %DATE%: Pre-run checkpoint failed.\n\nWould you like to create a manual restore point prior to start\u003F\n\nYou can skip this step but be aware of the consequences\n\n\n\nConsequences: Bad things will happen." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:A /O:N`) DO (
        IF /I "%%G"=="Yes" (
          goto manual_restore_point_creation_user_choice_cooldown
        ) else (
          goto skip_restore_point_creation_user_choice_cooldown
        )
      )

			:skip_restore_point_creation_user_choice_cooldown
      REM Display message that user skipped manual restore creation
      %Output%\Functions\Menu\MessageBox "You decided to skip the manual restore point.\n\nI hope you are aware of the consequences." "[WARNING] Brainiacs Cleanup Tool" /B:O /I:W /O:N /T:10
  		REM Set notes
			echo -Skipped creation restore point creation per user input >> !Output!\Notes\Comments.txt
			GOTO :EOF

			:manual_restore_point_creation_user_choice_cooldown
			start /WAIT "RESTORE" "!SystemRoot!\System32\SystemPropertiesProtection.exe"
  		REM Set notes
			echo -Created a manual restore point >> !Output!\Notes\Comments.txt
			GOTO :EOF
		) else (
			REM Set variable to skip windows timer if previously ran.
			set DELETE_COOLDOWN=no
		)
	)
)

REM Create restore point
echo "!WIN_VER!" | findstr /i /c:"server" >NUL || (
  powershell "Checkpoint-Computer -Description 'Brainiacs - !DATE!: Pre-run checkpoint' | Out-Null" 2>&1
	if /i not !ERRORLEVEL!==0 (
    REM Display message that restore point failed
    FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Brainiacs - %DATE%: Pre-run checkpoint failed.\n\nWould you like to create a manual restore point prior to start\u003F\n\nYou can skip this step but be aware of the consequences\n\n\n\nConsequences: Bad things will happen." "[ERROR] Brainiacs Cleanup Tool" /B:Y /I:E /O:N`) DO (
      IF /I "%%G"=="Yes" (
        goto manual_restore_point_creation_user_choice_cooldown
      ) else (
        goto skip_restore_point_creation_user_choice_cooldown
      )
    )

    :skip_restore_point_creation_user_choice_cooldown
    REM Display message that user skipped manual restore creation
    %Output%\Functions\Menu\MessageBox "You decided to skip the manual restore point.\n\nI hope you are aware of the consequences." "[WARNING] Brainiacs Cleanup Tool" /B:O /I:W /O:N /T:10
    REM Set notes
    echo -Skipped creation restore point creation per user input >> !Output!\Notes\Comments.txt
    GOTO :EOF

    :manual_restore_point_creation_user_choice_cooldown
    start /WAIT "RESTORE" "!SystemRoot!\System32\SystemPropertiesProtection.exe"
    REM Set notes
    echo -Created a manual restore point >> !Output!\Notes\Comments.txt
    GOTO :EOF

	) else (
    REM Display message that restore point was Created
    %Output%\Functions\Menu\MessageBox "Restore point 'Brainiacs - %DATE%: Pre-run checkpoint' created.\n\nThe tool will continue in 10 seconds." "[INFORMATION] Brainiacs Cleanup Tool" /B:O /I:I /O:N /T:10
    REM Set notes
		echo -Created a system restore point 'Brainiacs - !DATE!: Pre-run checkpoint' >> !Output!\Notes\Comments.txt
	)
)

REM Disable delayed expansion
ENDLOCAL DISABLEDELAYEDEXPANSION
