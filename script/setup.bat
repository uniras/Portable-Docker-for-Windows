@echo off
call "%~dp0\config.bat"

if not exist "%~dp0\..\%QEMU_HDD_PATH%" goto :setupok

echo すでにインストール済みのようです。セットアップを中断します。

pause

exit /b -1

:setupok

echo セットアップを開始します...

call "%~dp0\download.bat"

if %errorlevel% equ -1 goto :err

call "%~dp0\install.bat"

if %errorlevel% equ -1 goto :err

goto :ok

:err
echo セットアップに失敗しました。

pause

exit /b 0

:ok
echo セットアップが終了しました。

pause