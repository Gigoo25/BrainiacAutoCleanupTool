@echo off

::Variables
set "VarHitman=0"

::Start HitmanPro service.
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
if exist "%Output%\Tools\HitmanPro\HitmanPro*" (
	title [HitmanPro] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Running HitmanPro...
	echo.
	echo =================================
	if exist "%systemdrive%\ProgramData\HitmanPro" (
		rmdir /s /q "%systemdrive%\ProgramData\HitmanPro" >nul 2>&1
	)
	if %OS%==32BIT start /WAIT "HMP" "%Output%\Tools\HitmanPro\HitmanPro.exe" /noupload /noinstall /scan
	if %OS%==64BIT start /WAIT "HMP" "%Output%\Tools\HitmanPro\HitmanPro_x64.exe" /noupload /noinstall /scan
	if exist "%systemdrive%\ProgramData\HitmanPro" (
		rmdir /s /q "%systemdrive%\ProgramData\HitmanPro" >nul 2>&1
	)
	CLS
	echo -Ran HitmanPro >> %Output%\Notes\Comments.txt
	echo.
	echo  ^! USER INPUT
	echo =================================
	echo.
	set /p VarHitman=Enter the amount of infections found:
	echo Infections-!!VarHitman!! >> %Output%\Notes\Comments.txt
	CLS
	echo.
	echo  ^! ALERT
	echo =================================
	echo.
	echo   Done running HitmanPro!
	echo.
	echo =================================
  TIMEOUT 2 >nul 2>&1
  GOTO eof
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    HitmanPro not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 10
  color 07
  goto :eof
)
:eof
ENDLOCAL DISABLEDELAYEDEXPANSION
CLS
