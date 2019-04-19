@echo off

REM Set title
title [Comments] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Check for missing comments
if /i "!SAFE_MODE!"=="yes" (
    GOTO :EOF
)

REM Open Comments service.
if exist "%Output%\Notes\Comments.txt" (
  CLS
  echo.
  echo  ^! ALERT
  echo =======================
  echo.
  echo   Opening Comments...
  echo.
  echo =======================
	start "notepad" /wait notepad "%Output%\Notes\Comments.txt"
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
  set Skip_Comments=yes
)
