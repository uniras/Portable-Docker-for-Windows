:QEMUの実行ファイルのパス
SET QEMU_PATH=apps\qemu\qemu-system-x86_64.exe

:QEMUのディスプレイモード
:SET QEMU_DISPLAY_MODE=-display sdl
:SET QEMU_DISPLAY_MODE=-nographic
SET QEMU_DISPLAY_MODE=-display none

:QEMU用TELNET接続ポート
SET QEMU_SERIAL_PORT=4321

:QEMU用TELNET接続オプション
SET QEMU_SERIAL_OPT=-serial telnet:localhost:%QEMU_SERIAL_PORT%,server,nowait

:QEMUのリアルタイムクロック(時計)オプション
SET QEMU_CLOCK_OPT=-rtc clock=vm,base=utc

:QEMUで使用するメモリ量(MB単位)
SET QEMU_USE_MEMORY=2048

:HDDファイルのパス
SET QEMU_HDD_PATH=Linux.qcow2

:初期化時のHDDファイルの最大サイズ
SET QEMU_HDD_DEF_SIZE=10G

:isoファイルのパス
SET QEMU_ISO_PATH=apps\alpine\Alpine.iso

:SSHのパス
SET SSH_PATH=ssh.exe
:SET SSH_PATH=%APPDIR%\git\usr\bin\ssh.exe

:ネットワーク関係のオプション設定
SET QEMU_NET_OPTION=user
SET QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::22-:22
SET QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::80-:80
SET QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::443-:443
SET QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::2222-:2222
SET QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::2375-:2375
SET QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::8000-:8000
SET QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::8080-:8080
SET QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::9000-:9000

:SSHログイン時のユーザー名
SET SSH_USERNAME=root

:SSHサーバーのポート
SET SSH_PORT=22

:SSH鍵認証関係オプション
:SET SSH_KEYOPT=-i %HOME%\.ssh\id_rsa
SET SSH_KEYOPT=

:シャットダウンコマンド
SET HALTCOMMAND=poweroff

:ベースフォルダ
SET BASEDIR=%~dp0\..

:スクリプトフォルダ
SET SCRIPTDIR=%~dp0
