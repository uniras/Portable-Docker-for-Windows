@echo off
CALL %~dp0\script\config.bat
%SSH_PATH% -F /dev/null %SSH_KEYOPT% -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p %SSH_PORT% %SSH_USERNAME%@localhost %*