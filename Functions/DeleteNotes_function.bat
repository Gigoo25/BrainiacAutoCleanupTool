@echo off

REM Check for missing comments
if /i "!SAFE_MODE!"=="yes" (
  GOTO :EOF
)

REM Set title
title [Deleting Comments] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Delete Comments service.
if exist "%Output%\Notes\Comments.txt" (
  CLS
	echo.
	echo  ^! ALERT
	echo =====================
	echo.
	echo   Deleting Notes...
	echo.
	echo =====================
	rmdir /s /q "%Output%\Notes" >nul
	TIMEOUT 1 >nul
  GOTO :EOF
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    Comments not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 10
  color 07
	GOTO :EOF
  set SKIP_COMMENTS=yes
)
