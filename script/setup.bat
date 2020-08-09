@echo off
set /P ANSWER="セットアップを開始します。よろしいですか (Y/N)？"

if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)

exit

:yes

echo セットアップを開始します...

call %~dp0\download.bat

call %~dp0\config.bat

echo HDDイメージ作成...

%~dp0\..\apps\qemu\qemu-img create -f qcow2 %~dp0\..\%QEMU_HDD_PATH% %QEMU_HDD_DEF_SIZE%

echo Qemu起動...

start /min %~dp0\..\%QEMU_PATH% %QEMU_DISPLAY_MODE% %QEMU_SERIAL_OPT% %QEMU_CLOCK_OPT% -smp 2 -boot d -m %QEMU_USE_MEMORY% -net nic,model=virtio -net %QEMU_NET_OPTION% -hda %~dp0\..\%QEMU_HDD_PATH% -cdrom %~dp0\..\%QEMU_ISO_PATH%

echo インストールマクロ 起動...

start /w %~dp0\..\%TERATERM_PATH%\ttpmacro.exe %~dp0\install.ttl

echo Qemu再起動...

start /min %~dp0\..\%QEMU_PATH% %QEMU_DISPLAY_MODE% %QEMU_SERIAL_OPT% %QEMU_CLOCK_OPT% -smp 2 -m %QEMU_USE_MEMORY% -net nic,model=virtio -net %QEMU_NET_OPTION% -hda %~dp0\..\%QEMU_HDD_PATH%

echo セットアップマクロ 起動...

start /w %~dp0\..\%TERATERM_PATH%\ttpmacro.exe %~dp0\setup.ttl

echo セットアップが終了しました

pause
