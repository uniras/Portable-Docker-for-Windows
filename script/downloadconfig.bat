:各種ソフトウェアのURL
SET ALPINE_URL="http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-virt-3.12.0-x86_64.iso"
SET QEMU_URL="https://qemu.weilnetz.de/w64/2020/qemu-w64-setup-20200805.exe"
SET UNIEXT_URL="https://github.com/Bioruebe/UniExtract2/releases/download/v2.0.0-rc.2/UniExtractRC2.zip"
SET TERATERM_URL="https://ja.osdn.net/frs/redir.php?m=jaist&f=ttssh2%%2F72009%%2Fteraterm-4.105.zip"
SET DOCKERCLI_URL="https://github.com/StefanScherer/docker-cli-builder/releases/download/19.03.12/docker.exe"
SET DOCKERCMP_URL="https://github.com/docker/compose/releases/download/1.26.2/docker-compose-Windows-x86_64.exe"

:各種ソフトウェアのパス
SET ALPINE_DIR=apps\alpine
SET QEMU_DIR=apps\qemu
SET UNIEXT_DIR=apps\uniext
SET TERATERM_DIR=apps\teraterm
SET DOCKERCLI_DIR=apps\docker
SET DOCKERCMP_DIR=apps\docker

:各種ソフトウェアのファイル名
SET ALPINE_FILE=alpine.iso
SET QEMU_FILE=qemu.exe
SET UNIEXT_FILE=uniext.zip
SET TERATERM_FILE=teraterm.zip
SET DOCKERCLI_FILE=docker.exe
SET DOCKERCMP_FILE=docker-compose.exe

:解凍後のフォルダ名
SET UNIEXT_PATH=%UNIEXT_DIR%\UniExtract
SET TERATERM_PATH=%TERATERM_DIR%\teraterm-4.105
