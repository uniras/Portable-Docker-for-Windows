@echo off
set /P ANSWER="セットアップを開始します。よろしいですか (Y/N)？"

if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)

exit

:yes

echo セットアップを開始します...

call "%~dp0\config.bat"

call "%~dp0\download.bat"

call "%~dp0\install.bat"

pause
