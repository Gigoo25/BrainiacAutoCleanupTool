@echo off

::Start CCleaner service.
CLS
title [CCleaner] Brainiacs Cleanup Tool v%TOOL_VERSION%
::Check if already installed and run if it is, if not run portable version.
if exist "%systemdrive%\Program Files\CCleaner\CCleaner.exe" (
	echo CCleaner installed already!
	CLS
	echo CCleaner is cleaning temp files...
	echo This may take a while.
	if %OS%==32BIT "%systemdrive%\Program Files\CCleaner\CCleaner.exe" /AUTO
	if %OS%==64BIT "%systemdrive%\Program Files\CCleaner\CCleaner64.exe" /AUTO
	echo -Ran CCleaner temp file cleanup >> %Output%\Notes\Comments.txt
	CLS
	echo Opening portable CCleaner for registry cleanup...
	if %OS%==32BIT "%systemdrive%\Program Files\CCleaner\CCleaner.exe" /REGISTRY
	if %OS%==64BIT "%systemdrive%\Program Files\CCleaner\CCleaner64.exe" /REGISTRY
	echo -Ran CCleaner registry cleanup >> %Output%\Notes\Comments.txt
	goto :CCleaner_Done
)

if exist "%systemdrive%\Program Files (x86)\CCleaner\CCleaner.exe" (
	echo CCleaner installed already!
	CLS
	echo CCleaner is cleaning temp files...
	echo This may take a while.
	if %OS%==32BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner.exe" /AUTO
	if %OS%==64BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner64.exe" /AUTO
	echo -Ran CCleaner temp file cleanup >> %Output%\Notes\Comments.txt
	CLS
	echo Opening portable CCleaner for registry cleanup...
	if %OS%==32BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner.exe" /REGISTRY
	if %OS%==64BIT "%systemdrive%\Program Files (x86)\CCleaner\CCleaner64.exe" /REGISTRY
	echo -Ran CCleaner registry cleanup >> %Output%\Notes\Comments.txt
	goto :CCleaner_Done
) else (
	echo Running portable CCleaner for temp file cleanup...
	CLS
	echo CCleaner is cleaning temp files...
	echo This may take a while.
	if %OS%==32BIT "%Output%\Tools\CCleaner\CCleaner.exe" /AUTO
	if %OS%==64BIT "%Output%\Tools\CCleaner\CCleaner64.exe" /AUTO
	echo -Ran CCleaner temp file cleanup >> %Output%\Notes\Comments.txt
	CLS
	echo Opening portable CCleaner for registry cleanup...
	if %OS%==32BIT "%Output%\Tools\CCleaner\CCleaner.exe" /REGISTRY
	if %OS%==64BIT "%Output%\Tools\CCleaner\CCleaner64.exe" /REGISTRY
	echo -Ran CCleaner registry cleanup >> %Output%\Notes\Comments.txt
	goto :CCleaner_Done
)
:CCleaner_Done
CLS
echo Done running CCleaner.
TIMEOUT 2 >nul 2>&1
CLS