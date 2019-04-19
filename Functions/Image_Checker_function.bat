@echo off

REM Set title
title [Windows Image Check] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start Windows Image Check service.
REM If Windows version equals 10, 8.1 or 8 run dism
if %WIN_VER_NUM% geq 6.2 (
  CLS
  echo.
  echo  ^! ALERT
  echo ===================================
  echo.
  echo   Starting Windows Image Check...
  echo.
  echo ===================================
  TIMEOUT 3 >nul
  CLS
  echo.
  echo  ^! ALERT
  echo =============================================
  echo.
  echo   Checking Windows image for corruptions...
  echo.
  echo =============================================
	REM Start function
	dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%SystemRoot%\Windows_Image_Check.txt"
	REM Create notes
	echo -Checked Windows image for coruptions >> %Output%\Notes\Comments.txt
	CLS
  echo.
  echo  ^! ALERT
  echo ================================
  echo.
  echo   Done checking windows image!
  echo.
  echo ================================
	choice /C YN /T 20 /D N /M "Would you like to review the log"
  IF errorlevel 2 goto dont_review_log_dism
  IF errorlevel 1 goto review_log_dism
  :review_log_dism
  if exist "%SystemRoot%\Windows_Image_Check.txt" (
    type %SystemRoot%\Windows_Image_Check.txt
    pause
    GOTO :EOF
  ) else (
    CLS
    color 0c
    echo.
    echo  ^! ERROR
    echo ===================================================================================
    echo.
    echo    Windows Image Check log not found.
    echo.
    echo    Skipping...
    echo.
    echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
    echo.
    echo ===================================================================================
    TIMEOUT 10
    color 07
    GOTO :EOF
  )
  :dont_review_log_dism
  CLS
	echo Placed log file at %SystemRoot%\Windows_Image_Check.txt
	TIMEOUT 7 >nul
  GOTO :EOF
)

REM Set title
title [SFC] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Check System Files for corruptions
REM If Windows version is less than Windows 7 run sfc
if %WIN_VER_NUM% leq 6.0 (
    if exist "%SystemRoot%\System32\sfc.exe" (
      CLS
      echo.
      echo  ^! ALERT
      echo ============================================
      echo.
      echo   Checking System Files for corruptions...
      echo.
      echo ============================================
      TIMEOUT 1 >nul
      echo.
      %SystemRoot%\System32\sfc.exe /scannow
      %SystemRoot%\System32\findstr.exe /c:"[SR]" %SystemRoot%\logs\cbs\cbs.log
      REM Create notes
      echo -Checked Windows System Files for corruptions >> %Output%\Notes\Comments.txt
      CLS
      echo.
      echo  ^! ALERT
      echo ===============================================
      echo.
      echo   Done checking System Files for corruptions!
      echo.
      echo ===============================================
      choice /C YN /T 20 /D N /M "Would you like to review the log"
      IF errorlevel 2 goto dont_review_log_sfc
      IF errorlevel 1 goto review_log_sfc
      :review_log_sfc
      if exist "%SystemRoot%\logs\cbs\cbs.log" (
        CLS
        type %SystemRoot%\logs\cbs\cbs.log
        pause
        GOTO :EOF
      ) else (
        CLS
        color 0c
        echo.
        echo  ^! ERROR
        echo ===================================================================================
        echo.
        echo    System Files Checker log not found.
        echo.
        echo    Skipping...
        echo.
        echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
        echo.
        echo ===================================================================================
        TIMEOUT 10
        color 07
        GOTO :EOF
      )
      :dont_review_log_sfc
      CLS
      echo Placed log file at %SystemRoot%\logs\cbs\cbs.log
      TIMEOUT 7 >nul
      GOTO :EOF
    ) else (
	    CLS
      color 0c
      echo.
      echo  ^! ERROR
      echo ===================================================================================
      echo.
      echo    SFC not found.
      echo.
      echo    Skipping...
      echo.
      echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
      echo.
      echo ===================================================================================
      TIMEOUT 10
      color 07
      GOTO :EOF
    )
) else (
  CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    SFC does not support "%WIN_VER%".
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 10
  color 07
  GOTO :EOF
)
