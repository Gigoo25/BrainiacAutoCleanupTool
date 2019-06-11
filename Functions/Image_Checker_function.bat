@echo off

REM Start Windows Image Check service.
  REM If Windows version equals 10, 8.1 or 8 run dism
if %WIN_VER_NUM% geq 6.2 (
	REM Display starting message
	%Output%\Functions\Menu\MessageBox "Starting Windows Image Check\n\nThis will check the Windows System Image for corruptions..." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:5 >nul
	REM Clear terminal screen
	CLS
	REM Start function
	start /WAIT "[DISM] Brainiacs Cleanup Tool v%TOOL_VERSION%" /MAX dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%SystemRoot%\Windows_Image_Check.txt"
  REM Set notes
	echo -Checked Windows image for coruptions >> %Output%\Notes\Comments.txt
  REM Ask if user wants to view logs
  FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Done checking windows image.\n\nWould you like to review the log\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:A /O:N`) DO (
    IF /I "%%G"=="Yes" (
      if exist "%SystemRoot%\Windows_Image_Check.txt" (
        REM Open DISM logs
        start "notepad" /wait notepad "%SystemRoot%\Windows_Image_Check.txt"
        GOTO :EOF
      ) else (
        REM Display that no log was dount
        %Output%\Functions\Menu\MessageBox "Windows Image Check log not found\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:X /O:N /T:10 >nul
        GOTO :EOF
      )
    ) else (
      REM Set notes
    	echo Placed log file at %SystemRoot%\Windows_Image_Check.txt
      GOTO :EOF
    )
  )
)

REM Check System Files for corruptions
  REM If Windows version is less than Windows 7 run sfc
if %WIN_VER_NUM% LSS 6.2 (
    if exist "%SystemRoot%\System32\sfc.exe" (
    	REM Display starting message
    	%Output%\Functions\Menu\MessageBox "Starting SFC\n\nThis will check the Windows System Image for corruptions..." "[ALERT] Brainiacs Cleanup
			REM Clear terminal screen
			CLS
			REM Start function
      start /WAIT "[SFC] Brainiacs Cleanup Tool v%TOOL_VERSION%" /MAX %SystemRoot%\System32\sfc.exe /scannow
      %SystemRoot%\System32\findstr.exe /c:"[SR]" %SystemRoot%\logs\cbs\cbs.log
      REM Set notes
      echo -Checked Windows System Files for corruptions >> %Output%\Notes\Comments.txt
      REM Ask if user wants to view logs
      FOR /F "usebackq tokens=1" %%G IN (`%Output%\Functions\Menu\MessageBox "Done checking System Files for corruptions.\n\nWould you like to review the log\u003F" "[ALERT] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:Y /I:A /O:N`) DO (
      IF /I "%%G"=="Yes" (
        if exist "%SystemRoot%\Windows_Image_Check.txt" (
          REM Open DISM logs
          start "notepad" /wait notepad "%SystemRoot%\logs\cbs\cbs.log"
          GOTO :EOF
        ) else (
          REM Display that no log was not found
          %Output%\Functions\Menu\MessageBox "SFC log not found\n\nSkipping.\n\nThe Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds." "[ERROR] Brainiacs Cleanup Tool v%TOOL_VERSION%" /B:O /I:E /O:N /T:10 >nul
          GOTO :EOF
        )
      ) else (
        REM Set notes
        echo Placed log file at %SystemRoot%\logs\cbs\cbs.log
        GOTO :EOF
      )
    )
  )
)
