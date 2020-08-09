@echo off
CALL %~dp0\script\config.bat
start /min %~dp0%QEMU_PATH% %QEMU_DISPLAY_MODE% %QEMU_SERIAL_OPT% %QEMU_CLOCK_OPT% -smp 2 -m %QEMU_USE_MEMORY% -net nic -net %QEMU_NET_OPTION% -hda %~dp0%QEMU_HDD_PATH%