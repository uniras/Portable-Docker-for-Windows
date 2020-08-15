@echo off
call "%~dp0\script\boot.bat"
echo Linuxを起動しています。しばらくお待ちください...
call "%~dp0\script\startwait.bat"
if ERRORLEVEL EQU 0 goto exit /b 0
echo 接続に失敗しました。Qemuが起動していないようです。
pause
exit /b -1