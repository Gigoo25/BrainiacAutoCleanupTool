@echo off

REM Display message that tool will be opening logs
%Output%\Functions\Menu\MessageBox "Opening known logs created for review." "[ALERT] Brainiacs Cleanup Tool" /B:Y /I:A /O:N /T:10

REM Start ReviewLogs service.
if exist "%Output%\Logs\rkill.log" (
	REM Open RKill logs
	start "notepad" /wait notepad "%Output%\Logs\rkill.log"
)

if exist "%Output%\Logs\rogue.log" (
	REM Open RogueKiller logs
	start "notepad" /wait notepad "%Output%\Logs\rogue.log"
)

if exist "%HOMEDRIVE%\AdwCleaner\Logs" (
	REM Open ADW logs folder
	START "AdwCleanerLog" /wait "%SystemRoot%\explorer.exe" "%HOMEDRIVE%\AdwCleaner\Logs"
)

if exist "%Output%\Logs\tdsskiller.log" (
	REM Open tdsskiller logs
	start "notepad" /wait notepad "%Output%\Logs\tdsskiller.log"
)

if exist "%Output%\Logs\JRT.txt" (
	REM Open JRT logs
	start "notepad" /wait notepad "%Output%\Logs\JRT.txt"
)

if exist "%SystemRoot%\Windows_Image_Check.txt" (
	REM Open Windows Image Check logs
	start "notepad" /wait notepad "%SystemRoot%\Windows_Image_Check.txt"
)

if exist "%SystemRoot%\logs\cbs\cbs.log" (
	REM Open Windows Drive Check logs
	start "notepad" /wait notepad "%SystemRoot%\logs\cbs\cbs.log"
)
