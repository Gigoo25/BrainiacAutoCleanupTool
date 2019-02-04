@echo off

::Check for missing comments
if /i "!SAFE_MODE!"=="yes" (
    goto eof
)

::Delete Comments service.
CLS
if exist "%Output%\Notes\Comments.txt" (
	title [Deleting Comments] Brainiacs Cleanup Tool v%TOOL_VERSION%
	echo Deleting Notes...
	rmdir /s /q "%Output%\Notes" >NUL 2>&1
	TIMEOUT 1 >nul 2>&1
	CLS
  	GOTO eof
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
	goto eof
    set Skip_Comments=yes
)
:eof
CLS