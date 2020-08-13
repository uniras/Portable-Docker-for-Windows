@echo off
call "%~dp0\dockerconfig.bat"
%SSH_PATH% -F /dev/null %SSH_KEYOPT% -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p %SSH_PORT% %SSH_USERNAME%@localhost %*