@echo off
echo セットアップを開始します...

call "%~dp0\config.bat"

call "%~dp0\download.bat"

call "%~dp0\install.bat"

pause
