call %~dp0\config.bat
call %~dp0\downloadconfig.bat

set DOCKER_HOST=localhost:2375
set PATH=%PATH%;%~dp0\..\%DOCKERCLI_DIR%
