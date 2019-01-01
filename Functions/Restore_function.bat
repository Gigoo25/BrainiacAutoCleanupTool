@echo off

::Set variables
set DELETE_COOLDOWN=unidentified

::Start System restore service.
CLS
title [System Restore Point] Brainiacs Cleanup Tool v%TOOL_VERSION%
if /i "%WIN_VER:~0,9%"=="Windows 1" (
	if  %SAFE_MODE%==yes (
		::Set Color
		color 0c
		cls
		echo.
		echo  ^! WARNING
		echo ===================================================================================
		echo.
		echo    Windows 10 blocks creating SysRestore points in Safe Mode. Why? Because Microsoft.
		echo.                                                        
		echo    Skipping restore point creation.    
		echo.
		echo    Reboot to Normal mode and re-run the Autocleanup tool if you absolutely require one.
		echo.
		echo ===================================================================================
		TIMEOUT 10
		::Set Color
		color 07
		goto :skip_restore_point_creation
	)
)

::Detect if reg key has been added already to prevent false positive
reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v SystemRestorePointCreationFrequency >nul 2>&1
if /i not %ERRORLEVEL%==0 (
	set DELETE_COOLDOWN=yes
) else (
	set DELETE_COOLDOWN=no
)

::Win7 and up only: Remove the cooldown timer (via reg command) and enable System Restore
if %WIN_VER_NUM% geq 6.1 (
	if /i "%DELETE_COOLDOWN%"=="yes" (
		reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /t reg_dword /v SystemRestorePointCreationFrequency /d 0 /f >nul 2>&1
		powershell "Enable-ComputerRestore -Drive "%SystemDrive%" | Out-Null" 2>&1
		if /i not %ERRORLEVEL%==0 (
			::Set Color
			color 0c
			cls
			echo.
			echo  ^! ERROR
			echo ===================================================================================
			echo.
			echo    Brainiacs - %DATE%: Pre-run checkpoint failed!
			echo.                                                        
			echo    Manually create this restore point or continue but be aware of the consequences!    
			echo.
			echo    Consequences: Bad things will happen.
			echo.
			echo ===================================================================================
			pause
			::Set Color
			color 07
			goto :skip_restore_point_creation
		) else (
			echo Removing system restore cooldown timer...
			::Set variable to skip windows timer if previously ran.
			set DELETE_COOLDOWN=no
			TIMEOUT 1 >NUL 2>&1
		)
	)
)

::Create restore point
echo "%WIN_VER%" | findstr /i /c:"server" >NUL || (
	echo Creating restore point...
	TIMEOUT 1 >NUL 2>&1
	CLS
	powershell "Checkpoint-Computer -Description 'Brainiacs - %DATE%: Pre-run checkpoint' | Out-Null" 2>&1
	if /i not %ERRORLEVEL%==0 (
		::Set Color
		color 0c
		cls
		echo.
		echo  ^! ERROR
		echo ===================================================================================
		echo.
		echo    Brainiacs - %DATE%: Pre-run checkpoint failed!
		echo.                                                        
		echo    Manually create this restore point or continue but be aware of the consequences!    
		echo.
		echo    Consequences: Bad things will happen.
		echo.
		echo ===================================================================================
		pause
		::Set Color
		color 07
		goto :skip_restore_point_creation
	) else (
		CLS
		echo Restore point 'Brainiacs - %DATE%: Pre-run checkpoint' created!
		echo -Created a system restore point 'Brainiacs - %DATE%: Pre-run checkpoint' >> %Output%\Notes\Comments.txt
		TIMEOUT 3 >nul 2>&1
	)
)
:skip_restore_point_creation
CLS
