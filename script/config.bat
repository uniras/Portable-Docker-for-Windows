call "%~dp0\downloadconfig.bat"

:QEMUの実行ファイルのパス
set QEMU_EXE_PATH=%QEMU_PATH%\qemu-system-x86_64.exe

:QEMUのディスプレイモード
:set QEMU_DISPLAY_MODE=-display sdl
:set QEMU_DISPLAY_MODE=-nographic
set QEMU_DISPLAY_MODE=-display none

:QEMU用TELNET接続ポート
set QEMU_SERIAL_PORT=4321

:QEMU用TELNET接続オプション
set QEMU_SERIAL_OPT=-serial telnet:localhost:%QEMU_SERIAL_PORT%,server,nowait

:QEMUのリアルタイムクロック(時計)オプション
set QEMU_CLOCK_OPT=-rtc clock=vm,base=utc

:QEMUで使用するメモリ量(MB単位)
set QEMU_USE_MEMORY=2048

:HDDファイルのパス
set QEMU_HDD_PATH=Linux.qcow2

:ISOファイルのパス
set QEMU_ISO_PATH=%ALPINE_DIR%\Alpine.iso

:SSHのパス
set SSH_PATH=ssh.exe

:ネットワーク関係のオプション設定
set QEMU_NET_OPTION=user
set QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::22-:22
set QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::80-:80
set QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::443-:443
set QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::2222-:2222
set QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::2375-:2375
set QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::8000-:8000
set QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::8080-:8080
set QEMU_NET_OPTION=%QEMU_NET_OPTION%,hostfwd=tcp::9000-:9000

:SSHログイン時のユーザー名
set SSH_USERNAME=root

:SSHサーバーのポート
set SSH_PORT=22

:SSH鍵認証関係オプション
:set SSH_KEYOPT=-i "%USERPROFILE%\.ssh\id_rsa"
set SSH_KEYOPT=

:シャットダウンコマンド
set HALTCOMMAND=poweroff

:ホスト名
:Linuxインストール時のホスト名(Linux ISOファイルからの起動でプロンプトのホスト名がlocalhostではない場合にマクロが正常に動かないので変更します)
set LINUX_INSTALL_HOSTNAME=localhost
:Linuxインストール後のホスト名(インストール時にホスト名の設定を変更した場合はこちらも変更しないとマクロが正常に動きません)
set LINUX_SETUP_HOSTNAME=localhost
:Linuxのホスト名(セットアップ終了後にホスト名を変更した場合はこちらも変更しないとマクロが正常に動きません)
set LINUX_HOSTNAME=localhost

:スクリプトフォルダ(Teratermマクロ用)
set SCRIPTDIR=%~dp0
