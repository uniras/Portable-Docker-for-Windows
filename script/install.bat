@echo off
call "%~dp0\config.bat"

: 初期化時のHDDファイルの最大サイズ(デフォルト値)
if not defined QEMU_HDD_DEF_SIZE (
    set QEMU_HDD_DEF_SIZE=10G
)

if not exist "%~dp0\..\%QEMU_HDD_PATH%" goto :formatok

set /P ANSWER="HDDイメージが存在します。HDDイメージ内のデータはすべて消去されますがよろしいですか (Y/N)？"

if /i {%ANSWER%}=={y} (goto :deleteok)
if /i {%ANSWER%}=={yes} (goto :deleteok)

pause

exit /b -1

:deleteok

del "%~dp0\..\%QEMU_HDD_PATH%"

:formatok

if not exist "%~dp0\..\%QEMU_EXE_PATH%" (
    echo Qemuが見つかりません。Qemuのダウンロード・展開に失敗しているようです。
    exit /b -1
)

echo インストールを開始します。

echo HDDイメージ作成...
echo 最大%QEMU_HDD_DEF_SIZE%Bの設定でHDDイメージを作成します。

"%~dp0\..\%QEMU_PATH%\qemu-img.exe" create -f qcow2 "%~dp0\..\%QEMU_HDD_PATH%" %QEMU_HDD_DEF_SIZE%

echo Qemu起動...

start /min "Qemu" "%~dp0\..\%QEMU_EXE_PATH%" %QEMU_DISPLAY_MODE% %QEMU_SERIAL_OPT% %QEMU_CLOCK_OPT% -smp %QENU_USE_PROCESSOR% -boot d -m %QEMU_USE_MEMORY% -net nic,model=virtio -net %QEMU_NET_OPTION% -hda "%~dp0\..\%QEMU_HDD_PATH%" -cdrom "%~dp0\..\%QEMU_ISO_PATH%"

echo インストールマクロ 起動...

"%~dp0\..\%TERATERM_PATH%\ttpmacro.exe" /I "%~dp0\install.ttl"

echo Qemu再起動...

start /min "Qemu" "%~dp0\..\%QEMU_EXE_PATH%" %QEMU_DISPLAY_MODE% %QEMU_SERIAL_OPT% %QEMU_CLOCK_OPT% -smp %QENU_USE_PROCESSOR% -m %QEMU_USE_MEMORY% -net nic,model=virtio -net %QEMU_NET_OPTION% -hda "%~dp0\..\%QEMU_HDD_PATH%"

echo セットアップマクロ 起動...

"%~dp0\..\%TERATERM_PATH%\ttpmacro.exe" /I "%~dp0\setup.ttl"

echo インストールが終了しました。

exit /b 0