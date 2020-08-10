@echo off
call %~dp0\config.bat
call %~dp0\downloadconfig.bat

%~dp0\%TERATERM_PATH%\ttpmacro.exe /I %~dp0\startwait.ttl

exit /b %errorlevel%
