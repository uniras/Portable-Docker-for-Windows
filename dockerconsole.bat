@echo off
call "%~dp0\start.bat"

if %ERRORLEVEL% NEQ 0 goto exit /b %ERRORLEVEL%

call "%~dp0\script\dockerconfig.bat"

cmd