@echo off

::Start DeleteLogs service.
CLS
if exist "%Output%\Logs" (
		title [Deleting Logs] Brainiacs Cleanup Tool v%TOOL_VERSION%
		rmdir /s /q "%Output%\Logs" >nul 2>&1
		::Clean random past logs.
		if exist "%userprofile%\desktop\Rkill.txt" (
			del "%userprofile%\desktop\Rkill.txt"  >NUL 2>&1
		)
		if exist "%userprofile%\desktop\JRT.txt" (
			del "%userprofile%\desktop\JRT.txt"  >NUL 2>&1

		)
		if exist "%systemdrive%\Rkill.txt" (
			del "%systemdrive%\Rkill.txt"  >NUL 2>&1
			
		)
		if exist "%systemdrive%\JRT.txt" (
			del "%systemdrive%\JRT.txt"  >NUL 2>&1
		)
		if exist "%SystemRoot%\logs\cbs\cbs.log" (
			del "%SystemRoot%\logs\cbs\cbs.log"  >NUL 2>&1
		)
		echo Deleting logs/temp files...
		echo -Deleted logs >> %Output%\Notes\Comments.txt
		CLS
		echo Done deleting logs.
		TIMEOUT 3 >nul 2>&1
		goto eof
	) else (
		echo Logs not found.
		echo.
		echo Skipping...
		echo.
    	echo Continuing in 5 seconds.
		TIMEOUT 5 >NUL 2>&1
		goto eof
	)
:eof
CLS