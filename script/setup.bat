@echo off
call "%~dp0\config.bat"

if not exist "%~dp0\..\%QEMU_HDD_PATH%" goto :setupok

echo すでにインストール済みのようです。セットアップを中断します。

pause

exit

:setupok

echo セットアップを開始します...

call "%~dp0\download.bat"

call "%~dp0\install.bat"

echo セットアップが終了しました。

pause