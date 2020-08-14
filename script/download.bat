@echo off
call "%~dp0\downloadconfig.bat"

echo ダウンロード・展開を開始します。

echo curlプログラムの存在確認...
where curl
if %ERRORLEVEL% NEQ 0 (
    echo curlが見つからないためセットアップを続行できません。PortableGitにパスを通す必要があります。
    pause
    exit -1
)

: PortableGitダウンロード・インストール
if not defined LIGHT_MODE_INSTALL (
    if not exist "%~dp0\..\%WINGIT_DIR%" (
        mkdir "%~dp0\..\%WINGIT_DIR%"
        echo PortableGit ダウンロード...
        curl -L -o "%~dp0\..\%WINGIT_DIR%\%WINGIT_FILE%"  %WINGIT_URL%
        echo PortableGit 展開...
        start /w "" "%~dp0\..\%WINGIT_DIR%\%WINGIT_FILE%" -o"%~dp0\..\%WINGIT_DIR%" -y
    )
) else (
    echo LIGHTモードインストールのため、PortableGitのダウンロード・インストールをスキップします。
)

: フォルダ作成
echo フォルダ作成...
mkdir "%~dp0\..\%ALPINE_DIR%"
mkdir "%~dp0\..\%QEMU_DIR%"
mkdir "%~dp0\..\%UNIEXT_DIR%"
mkdir "%~dp0\..\%TERATERM_DIR%"
: LIGHT_MODE_INSTALL
if not defined LIGHT_MODE_INSTALL (
    mkdir "%~dp0\..\%DOCKER_DIR%"
)

: ダウンロード
echo Alpine Linux ダウンロード...
curl -L -o "%~dp0\..\%ALPINE_DIR%\%ALPINE_FILE%"  %ALPINE_URL%
echo Qemu ダウンロード...
curl -L -o "%~dp0\..\%QEMU_DIR%\%QEMU_FILE%"  %QEMU_URL%
echo Universal Extractor 2 ダウンロード...
curl -L -o "%~dp0\..\%UNIEXT_DIR%\%UNIEXT_FILE%"  %UNIEXT_URL%
echo Teraterm ダウンロード...
curl -L -o "%~dp0\..\%TERATERM_DIR%\%TERATERM_FILE%"  %TERATERM_URL%

: LIGHT_MODE_INSTALL
if not defined LIGHT_MODE_INSTALL (
    echo Docker CLI ダウンロード...
    curl -L -o "%~dp0\..\%DOCKER_DIR%\%DOCKERCLI_FILE%"  %DOCKERCLI_URL%
    echo Docker-Compose ダウンロード...
    curl -L -o "%~dp0\..\%DOCKER_DIR%\%DOCKERCMP_FILE%"  %DOCKERCMP_URL%
) else (
    echo LIGHTモードインストールのため、Docker CLI / Docker Composeのダウンロードをスキップします。
)

: unzipでダウンロードしたzipを展開、なければLIGHTモード時のみWindow10標準のtarを使う(Window10のtarのzip解凍はWindow10独自機能の模様)
echo 展開プログラムの存在確認...
where unzip
if %ERRORLEVEL% NEQ 0 (
    if not defined LIGHT_MODE_INSTALL (
        echo unzipが見つからないためセットアップを続行できません。PortableGitにパスを通す必要があります。
        pause
        exit -1
    )
    if not exist %windir%\system32\tar.exe (
        echo 展開プログラムが見つからないためセットアップを続行できません。PortableGitにパスを通す必要があります。
        pause
        exit -1
    )
    echo tar（Windows10版）を使います。
    echo Universal Extractor 展開...
    %windir%\system32\tar -xf "%~dp0\..\%UNIEXT_DIR%\%UNIEXT_FILE%" -C "%~dp0\..\%UNIEXT_DIR%"
    echo Teraterm 展開...
    %windir%\system32\tar -xf "%~dp0\..\%TERATERM_DIR%\%TERATERM_FILE%" -C "%~dp0\..\%TERATERM_DIR%"
) else (
    echo unzipを使います。
    echo Universal Extractor 展開...
    unzip "%~dp0\..\%UNIEXT_DIR%\%UNIEXT_FILE%" -d "%~dp0\..\%UNIEXT_DIR%"
    echo Teraterm 展開...
    unzip "%~dp0\..\%TERATERM_DIR%\%TERATERM_FILE%" -d "%~dp0\..\%TERATERM_DIR%"
)

echo Qemu 展開...
"%~dp0\..\%UNIEXT_PATH%\bin\x86\7z.exe" x -y -o"%~dp0\..\%QEMU_DIR%\" "%~dp0\..\%QEMU_DIR%\%QEMU_FILE%" 

: LIGHTモードインストールでは使えないbatを削除
if defined LIGHT_MODE_INSTALL (
    echo LIGHTモードでは使えないバッチファイルを削除します。
    del /q "%~dp0\dockerconfig.bat"
    del /q "%~dp0\..\dockerconsole.bat"
    del /q "%~dp0\..\dockerbash.bat"
)

echo ダウンロード・展開が終了しました。