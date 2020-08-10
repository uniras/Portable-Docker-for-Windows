@echo off
call %~dp0\script\config.bat
call %~dp0\script\downloadconfig.bat

%~dp0\%TERATERM_PATH%\ttpmacro.exe /I %~dp0\script\stopwait.ttl

exit /b %errorlevel%
