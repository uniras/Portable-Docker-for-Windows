@echo off
echo Linuxを起動しています。しばらくお待ちください...
call %~dp0\start.bat
call %~dp0\startwait.bat
call %~dp0\script\dockerconfig.bat

cmd