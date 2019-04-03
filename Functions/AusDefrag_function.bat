@echo off

REM Display disclaimer on checking for SSD.
CLS
color 0c
echo.
echo  ^! WARNING
echo ===================================================================================
echo.
echo    Auslogic Defrag does not check for an SSD!
echo.
echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% does have a limited check for SSD but
echo    it is not bulletproof.
echo.
echo    Be sure that you are not running this on an SSD and reducing the span of the drive.
echo.
echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 15 seconds.
echo.
echo ===================================================================================
TIMEOUT 15
color 07
CLS

::Start AusDefrag service.
if exist "%Output%\Tools\AUS\ausdiskdefrag.exe" (
	title [AusDefrag] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Running AusDefrag...
	start /WAIT "AUS" "%Output%\Tools\AUS\ausdiskdefrag.exe"
	echo -Ran AusDefrag >> %Output%\Notes\Comments.txt
	CLS
	echo Done running AusDefrag!
  TIMEOUT 2 >nul 2>&1
  GOTO eof
) else (
	CLS
  color 0c
  echo.
  echo  ^! ERROR
  echo ===================================================================================
  echo.
  echo    AusDefrag not found.
  echo.
  echo    Skipping...
  echo.
  echo    The Brainiacs Cleanup Tool v%TOOL_VERSION% will continue in 10 seconds.
  echo.
  echo ===================================================================================
  TIMEOUT 10
  color 07
	goto eof
)
:eof
CLS
