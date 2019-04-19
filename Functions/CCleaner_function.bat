@echo off

REM Set title
title [CCleaner] Brainiacs Cleanup Tool v%TOOL_VERSION%

REM Start CCleaner service.
REM Check if already installed and run if it is, if not run portable version.
if exist "%systemdrive%\Program Files\CCleaner\CCleaner.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===============================
	echo.
	echo   CCleaner installed already!
	echo.
	echo ===============================
	CLS
	echo.
	echo  ^! ALERT
	echo ======================================
	echo.
	echo   CCleaner is cleaning temp files...
	echo.
	echo   This may take a while.
	echo ======================================
	if %OS%==32BIT "%systemdrive%\Program Files\CCleaner\CCleaner.exe" /AUTO
	if %OS%==64BIT "%systemdrive%\Program Files\CCleaner\CCleaner64.exe" /AUTO
	echo -Ran CCleaner temp file cleanup >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =====================================================
	echo.
	echo   Opening portable CCleaner for registry cleanup...
	echo.
	echo =====================================================
	if %OS%==32BIT "%systemdrive%\Program Files\CCleaner\CCleaner.exe" /REGISTRY
	if %OS%==64BIT "%systemdrive%\Program Files\CCleaner\CCleaner64.exe" /REGISTRY
	echo -Ran CCleaner registry cleanup >> %Output%\Notes\Comments.txt
	goto :CCleaner_Done
)

if exist "%systemdrive%\Program Files (x86)\CCleaner\CCleaner.exe" (
	CLS
	echo.
	echo  ^! ALERT
	echo ===============================
	echo.
	echo   CCleaner installed already!
	echo.
	echo ===============================
	CLS
	echo.
	echo  ^! ALERT
	echo ======================================
	echo.
	echo   CCleaner is cleaning temp files...
	echo.
	echo   This may take a while.
	echo ======================================
	if %OS%==32BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner.exe" /AUTO
	if %OS%==64BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner64.exe" /AUTO
	echo -Ran CCleaner temp file cleanup >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =====================================================
	echo.
	echo   Opening portable CCleaner for registry cleanup...
	echo.
	echo =====================================================
	if %OS%==32BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner.exe" /REGISTRY
	if %OS%==64BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner64.exe" /REGISTRY
	echo -Ran CCleaner registry cleanup >> %Output%\Notes\Comments.txt
	goto :CCleaner_Done
) else (
	CLS
	echo.
	echo  ^! ALERT
	echo ======================================================
	echo.
	echo   Opening portable CCleaner for temp file cleanup...
	echo.
	echo ======================================================
	CLS
	echo.
	echo  ^! ALERT
	echo ======================================
	echo.
	echo   CCleaner is cleaning temp files...
	echo.
	echo   This may take a while.
	echo ======================================
	if %OS%==32BIT "%Output%\Tools\CCleaner\CCleaner.exe" /AUTO
	if %OS%==64BIT "%Output%\Tools\CCleaner\CCleaner64.exe" /AUTO
	echo -Ran CCleaner temp file cleanup >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =====================================================
	echo.
	echo   Opening portable CCleaner for registry cleanup...
	echo.
	echo =====================================================
	if %OS%==32BIT "%Output%\Tools\CCleaner\CCleaner.exe" /REGISTRY
	if %OS%==64BIT "%Output%\Tools\CCleaner\CCleaner64.exe" /REGISTRY
	echo -Ran CCleaner registry cleanup >> %Output%\Notes\Comments.txt
	goto :CCleaner_Done
)
:CCleaner_Done
CLS
echo.
echo  ^! ALERT
echo ==========================
echo.
echo   Done running CCleaner.
echo.
echo ==========================
TIMEOUT 2 >nul
