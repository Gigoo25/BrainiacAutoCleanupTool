@echo off

CLS
::Check for EXE File and delete if present
if exist "%userprofile%\desktop\Brainiacs Cleanup Tool.exe" (
	del "%userprofile%\desktop\Brainiacs Cleanup Tool.exe"  >NUL 2>&1
)
if exist "%systemdrive%\Brainiacs Cleanup Tool.exe" (
	del "%systemdrive%\Brainiacs Cleanup Tool.exe"  >NUL 2>&1
)

::Clean random past tools.
if exist "%userprofile%\Brainiacs" (
	rmdir /s /q  "%userprofile%\Brainiacs"  >NUL 2>&1
)
if exist "%systemdrive%\Brainiacs" (
	rmdir /s /q  "%systemdrive%\Brainiacs"  >NUL 2>&1
)
if exist "%systemdrive%\AdwCleaner" (
	rmdir /s /q "%systemdrive%\AdwCleaner" >nul 2>&1
)

::Start DeleteTools service.
if exist "%Output%\Tools" (
		title [Deleting Tools] Brainiacs Cleanup Tool v%TOOL_VERSION%
		rmdir /s /q "%Output%\Tools" >nul 2>&1
		echo Deleting tools folder...
		echo -Deleted Tools folder >> %Output%\Notes\Comments.txt
		CLS
		echo Done deleting tools.
		TIMEOUT 3 >nul 2>&1
		goto eof
	) else (
		echo Tools not found.
		echo.
		echo Skipping...
		echo.
    	echo Continuing in 5 seconds.
		TIMEOUT 5 >NUL 2>&1
		goto eof
	)
:eof
CLS