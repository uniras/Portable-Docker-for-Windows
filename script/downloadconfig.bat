@echo off

:各種ソフトウェアのURL
set WINGIT_URL="https://github.com/git-for-windows/git/releases/download/v2.29.2.windows.3/PortableGit-2.29.2.3-64-bit.7z.exe"
set ALPINE_URL="https://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-virt-3.12.3-x86_64.iso"
set QEMU_URL="https://qemu.weilnetz.de/w64/2020/qemu-w64-setup-20201124.exe"
set SEVENZ_URL="https://ja.osdn.net/frs/redir.php?m=jaist&f=sevenzip%%2F70662%%2F7z1900-x64.msi"
set TERATERM_URL="https://ja.osdn.net/frs/redir.php?m=jaist&f=ttssh2%%2F72009%%2Fteraterm-4.105.zip"
set DOCKERCLI_URL="https://github.com/StefanScherer/docker-cli-builder/releases/download/19.03.14/docker.exe"
set DOCKERCMP_URL="https://github.com/docker/compose/releases/download/1.27.4/docker-compose-Windows-x86_64.exe"
set DOCKER_EXPOSE_PLUGIN_URL="https://raw.githubusercontent.com/lukaszlach/clip/master/docker-clip"
set WEBMIN_VERSION=1.962

:各種ソフトウェアのパス
set APP_DIR=app
set WINGIT_DIR=%APP_DIR%\PortableGit
set ALPINE_DIR=%APP_DIR%\alpine
set QEMU_DIR=%APP_DIR%\qemu
set SEVENZ_DIR=%APP_DIR%\7Zip
set TERATERM_DIR=%APP_DIR%\teraterm
set DOCKER_DIR=%APP_DIR%\docker

:各種ソフトウェアのファイル名
set ALPINE_FILE=alpine.iso
set WINGIT_FILE=PortableGit.exe
set QEMU_FILE=qemu.exe
set SEVENZ_FILE=7z.msi
set TERATERM_FILE=teraterm.zip
set DOCKERCLI_FILE=docker.exe
set DOCKERCMP_FILE=docker-compose.exe

:解凍後のフォルダ名
set SEVENZ_PATH=%SEVENZ_DIR%\7z\Files\7-zip
set TERATERM_PATH=%TERATERM_DIR%\teraterm-4.105
set QEMU_PATH=%QEMU_DIR%
set WINGIT_PATH=%WINGIT_DIR%
set DOCKER_PATH=%DOCKER_DIR%

:パスの設定
set PATH=%~dp0\..\%WINGIT_PATH%\bin;%~dp0\..\%WINGIT_PATH%\usr\bin;%~dp0\..\%WINGIT_PATH%\mingw64\bin;%PATH%