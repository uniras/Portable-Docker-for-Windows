@echo off
call "%~dp0\script\config.bat"
start /min "Qemu" "%~dp0\%QEMU_EXE_PATH%" %QEMU_DISPLAY_MODE% %QEMU_SERIAL_OPT% %QEMU_CLOCK_OPT% -smp 2 -m %QEMU_USE_MEMORY% -net nic -net %QEMU_NET_OPTION% -hda "%~dp0%QEMU_HDD_PATH%"