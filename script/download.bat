@echo off
call "%~dp0\downloadconfig.bat"

echo ダウンロード・展開を開始します。

: 親ディレクトリの絶対パスを取得(msiexecが絶対パスしか受け付けないため)
for /f "usebackq" %%A in (`powershell -Command "convert-path %~dp0\.."`) do set BASEDIR=%%A

echo %BASEDIR%

echo curlプログラムの存在確認...
where curl
if %ERRORLEVEL% NEQ 0 (
    echo curlが見つからないためセットアップを続行できません。PortableGitにパスを通す必要があります。
    pause
    exit /b -1
)

: PortableGitダウンロード・インストール
if not defined LIGHT_MODE_INSTALL (
    if not exist "%BASEDIR%\%WINGIT_DIR%" (
        mkdir "%BASEDIR%\%WINGIT_DIR%"
        echo PortableGit ダウンロード...
        curl -L -o "%BASEDIR%\%WINGIT_DIR%\%WINGIT_FILE%"  %WINGIT_URL%
        echo PortableGit 展開...
        start /w "" "%BASEDIR%\%WINGIT_DIR%\%WINGIT_FILE%" -o"%BASEDIR%\%WINGIT_DIR%" -y
    )
) else (
    echo LIGHTモードインストールのため、PortableGitのダウンロード・インストールをスキップします。
)

: フォルダ作成
echo フォルダ作成...
mkdir "%BASEDIR%\%ALPINE_DIR%"
mkdir "%BASEDIR%\%QEMU_DIR%"
mkdir "%BASEDIR%\%SEVENZ_DIR%"
mkdir "%BASEDIR%\%TERATERM_DIR%"
: LIGHT_MODE_INSTALLではDocker CLI/Docker Composeはインストールしないのでフォルダを作成しない。
if not defined LIGHT_MODE_INSTALL (
    mkdir "%BASEDIR%\%DOCKER_DIR%"
)

: ダウンロード
echo Alpine Linux ダウンロード...
curl -L -o "%BASEDIR%\%ALPINE_DIR%\%ALPINE_FILE%"  %ALPINE_URL%
echo Qemu ダウンロード...
curl -L -o "%BASEDIR%\%QEMU_DIR%\%QEMU_FILE%"  %QEMU_URL%
echo 7-Zip ダウンロード...
curl -L -o "%BASEDIR%\%SEVENZ_DIR%\%SEVENZ_FILE%"  %SEVENZ_URL%
echo Teraterm ダウンロード...
curl -L -o "%BASEDIR%\%TERATERM_DIR%\%TERATERM_FILE%"  %TERATERM_URL%

: Docker CLI/Docker Composeのダウンロード。
if not defined LIGHT_MODE_INSTALL (
    echo Docker CLI ダウンロード...
    curl -L -o "%BASEDIR%\%DOCKER_DIR%\%DOCKERCLI_FILE%"  %DOCKERCLI_URL%
    echo Docker-Compose ダウンロード...
    curl -L -o "%BASEDIR%\%DOCKER_DIR%\%DOCKERCMP_FILE%"  %DOCKERCMP_URL%
) else (
    echo LIGHTモードインストールのため、Docker CLI / Docker Composeのダウンロードをスキップします。
)

echo 7-zip展開...
msiexec /passive /a "%BASEDIR%\%SEVENZ_DIR%\%SEVENZ_FILE%" targetdir="%BASEDIR%\%SEVENZ_DIR%\7z"

echo Teraterm 展開...
"%BASEDIR%\%SEVENZ_PATH%\7z.exe" x -y -o"%BASEDIR%\%TERATERM_DIR%\" "%BASEDIR%\%TERATERM_DIR%\%TERATERM_FILE%" 

echo Qemu 展開...
"%BASEDIR%\%SEVENZ_PATH%\7z.exe" x -y -o"%BASEDIR%\%QEMU_DIR%\" "%BASEDIR%\%QEMU_DIR%\%QEMU_FILE%" 

: LIGHTモードインストールでは使えないbatを削除
if defined LIGHT_MODE_INSTALL (
    echo LIGHTモードでは使えないバッチファイルを削除します。
    del /q "%BASEDIR%\script\dockerconfig.bat"
    del /q "%BASEDIR%\dockerconsole.bat"
    del /q "%BASEDIR%\dockerbash.bat"
)

echo ダウンロード・展開が終了しました。