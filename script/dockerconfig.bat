@echo off
call "%~dp0\config.bat"

set DOCKER_HOST=localhost:2375
set PATH="%~dp0";"%~dp0\..";"%~dp0\..\%DOCKER_PATH%";%PATH%