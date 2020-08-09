CALL %~dp0\script\config.bat
CALL %~dp0\script\downloadconfig.bat

%~dp0\%TERATERM_PATH%\ttpmacro.exe /I %~dp0\script\startwait.ttl