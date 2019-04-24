@echo off

REM Enable delayed expansion
setlocal enableDelayedExpansion

REM Set variables
set DELETE_COOLDOWN=unidentified

REM Set title
title [System Restore Point] Brainiacs Cleanup Tool v!TOOL_VERSION!

REM Start System restore service.
if !SAFE_MODE!==yes (
	REM Set Color
	color 0c
	cls
	echo.
	echo  ^! WARNING
	echo ===================================================================================
	echo.
	echo    "%WIN_VER%" blocks creating SysRestore points in Safe Mode. Why? Because Microsoft.
	echo.
	echo    Skipping restore point creation.
	echo.
	echo    Reboot to Normal mode and re-run the Autocleanup tool if you absolutely require one.
	echo.
	echo ===================================================================================
	TIMEOUT 10
	REM Set Color
	color 07
	echo -Skipped restore point due to being booted in safe mode >> !Output!\Notes\Comments.txt
	goto :skip_restore_point_creation
)

REM Detect if reg key has been added already to prevent false positive
CLS
reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v SystemRestorePointCreationFrequency >NUL 2>&1
if /i not !ERRORLEVEL!==0 (
	set DELETE_COOLDOWN=yes
) else (
	set DELETE_COOLDOWN=no
)

REM Win7 and up only: Remove the cooldown timer (via reg command) and enable System Restore
if /i !WIN_VER_NUM! geq 6.1 (
	if /i "!DELETE_COOLDOWN!"=="yes" (
		reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /t reg_dword /v SystemRestorePointCreationFrequency /d 0 /f >nul
		powershell "Enable-ComputerRestore -Drive "!SystemDrive!" | Out-Null" 2>&1
		if /i not !ERRORLEVEL!==0 (
			REM Set Color
			color 0c
			cls
			echo.
			echo  ^! ERROR
			echo ===================================================================================
			echo.
			echo    Brainiacs - !DATE!: Pre-run checkpoint failed!
			echo.
			echo    Would you like to create a manual restore point prior to start?
			echo.
			echo    You can skip this step but be aware of the consequences!
			echo.
			echo.
			echo    Consequences: Bad things will happen.
			echo.
			echo ===================================================================================
			choice /M "[M]anual restore or [S]kip restore" /c MS
			IF errorlevel 2 goto skip_restore_point_creation_user_choice_cooldown
			IF errorlevel 1 goto manual_restore_point_creation_user_choice_cooldown
			:skip_restore_point_creation_user_choice_cooldown
			CLS
			echo.
			echo  ^! WARNING
			echo ===================================================================================
			echo.
			echo    Skipping manual restore point!
			echo.
			echo    I hope you are aware of the consequences!!
			echo.
			echo ===================================================================================
			TIMEOUT 5 >nul
			echo -Skipped creation restore point creation per user input >> !Output!\Notes\Comments.txt
			REM Set Color
			color 07
			goto :skip_restore_point_creation
			:manual_restore_point_creation_user_choice_cooldown
			start /WAIT "RESTORE" "!SystemRoot!\System32\SystemPropertiesProtection.exe"
			CLS
		  echo.
		  echo  ^! ALERT
		  echo =================================
		  echo.
		  echo   Manual restore point created!
		  echo.
		  echo =================================
			echo -Created a manual restore point >> !Output!\Notes\Comments.txt
			REM Set Color
			color 07
			goto :skip_restore_point_creation
		) else (
			CLS
		  echo.
		  echo  ^! ALERT
		  echo =============================================
		  echo.
		  echo   Removing system restore cooldown timer...
		  echo.
		  echo =============================================
			REM Set variable to skip windows timer if previously ran.
			set DELETE_COOLDOWN=no
			TIMEOUT 2 >nul
		)
	)
)

REM Create restore point
echo "!WIN_VER!" | findstr /i /c:"server" >NUL || (
	CLS
	echo.
	echo  ^! ALERT
	echo =============================
	echo.
	echo   Creating restore point...
	echo.
	echo =============================
	TIMEOUT 1 >nul
	CLS
	echo.
	powershell "Checkpoint-Computer -Description 'Brainiacs - !DATE!: Pre-run checkpoint' | Out-Null" 2>&1
	if /i not !ERRORLEVEL!==0 (
		REM Set Color
		color 0c
		cls
		echo.
		echo  ^! ERROR
		echo ===================================================================================
		echo.
		echo    Brainiacs - !DATE!: Pre-run checkpoint failed!
		echo.
		echo    Would you like to create a manual restore point prior to start?
		echo.
		echo    You can skip this step but be aware of the consequences!
		echo.
		echo.
		echo    Consequences: Bad things will happen.
		echo.
		echo ===================================================================================
		choice /M "[M]anual restore or [S]kip restore" /c MS
		IF errorlevel 2 goto skip_restore_point_creation_user_choice_cooldown
		IF errorlevel 1 goto manual_restore_point_creation_user_choice_cooldown
		:skip_restore_point_creation_user_choice_cooldown
		CLS
		echo.
		echo  ^! WARNING
		echo ===================================================================================
		echo.
		echo    Skipping manual restore point!
		echo.
		echo    I hope you are aware of the consequences!!
		echo.
		echo ===================================================================================
		TIMEOUT 5 >nul
		echo -Skipped creation restore point creation per user input >> !Output!\Notes\Comments.txt
		REM Set Color
		color 07
		goto :skip_restore_point_creation
		:manual_restore_point_creation_user_choice_cooldown
		start /WAIT "RESTORE" "!SystemRoot!\System32\SystemPropertiesProtection.exe"
		CLS
		echo.
		echo  ^! ALERT
		echo =================================
		echo.
		echo   Manual restore point created!
		echo.
		echo =================================
		echo -Created a manual restore point >> !Output!\Notes\Comments.txt
		REM Set Color
		color 07
		goto :skip_restore_point_creation
	) else (
		CLS
		echo.
		echo  ^! ALERT
		echo ===================================================================
		echo.
		echo   Restore point 'Brainiacs - !DATE!: Pre-run checkpoint' created!
		echo.
		echo ===================================================================
		echo -Created a system restore point 'Brainiacs - !DATE!: Pre-run checkpoint' >> !Output!\Notes\Comments.txt
		TIMEOUT 3 >nul
	)
)
:skip_restore_point_creation
REM Disable delayed expansion
ENDLOCAL
