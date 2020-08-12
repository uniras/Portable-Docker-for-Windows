call "%~dp0\downloadconfig.bat"

echo curlプログラムの存在確認...
where curl
if %ERRORLEVEL% NEQ 0 (
    echo curlが見つからないためセットアップを続行できません。
    exit -1
)

:フォルダ作成
echo フォルダ作成...
mkdir "%~dp0\..\%ALPINE_DIR%"
mkdir "%~dp0\..\%QEMU_DIR%"
mkdir "%~dp0\..\%UNIEXT_DIR%"
mkdir "%~dp0\..\%TERATERM_DIR%"
mkdir "%~dp0\..\%DOCKERCLI_DIR%"
:mkdir "%~dp0\..\%DOCKERCMP_DIR%"

:ダウンロード
echo Alpine Linx ダウンロード...
curl -L -o "%~dp0\..\%ALPINE_DIR%\%ALPINE_FILE%"  %ALPINE_URL%
echo Qemu ダウンロード...
curl -L -o "%~dp0\..\%QEMU_DIR%\%QEMU_FILE%"  %QEMU_URL%
echo Universal Extractor 2 ダウンロード...
curl -L -o "%~dp0\..\%UNIEXT_DIR%\%UNIEXT_FILE%"  %UNIEXT_URL%
echo Teraterm ダウンロード...
curl -L -o "%~dp0\..\%TERATERM_DIR%\%TERATERM_FILE%"  %TERATERM_URL%
echo Docker CLI ダウンロード...
curl -L -o "%~dp0\..\%DOCKERCLI_DIR%\%DOCKERCLI_FILE%"  %DOCKERCLI_URL%
echo Docker-Compose ダウンロード...
curl -L -o "%~dp0\..\%DOCKERCMP_DIR%\%DOCKERCMP_FILE%"  %DOCKERCMP_URL%

:ダウンロードしたファイルの展開
:PATHにunzipがあればunzipを使い、なければWindow10標準のtarを使う(Window10のtarのzip解凍はWindow10独自機能の模様)
echo 展開プログラムの存在確認...
set EXPAND_CMD=unzip
set EXPAND_OPT=
set EXPAND_DIR_OPT=-d

where %EXPAND_CMD%
if %ERRORLEVEL% NEQ 0 (
    set EXPAND_CMD=tar
    set EXPAND_OPT=-xf
    set EXPAND_DIR_OPT=-C
)

where %EXPAND_CMD%
if %ERRORLEVEL% NEQ 0 (
    echo 展開プログラムが見つからないためセットアップを続行できません。
    exit -1
)

echo %EXPAND_CMD%を使います。
echo Universal Extractor 展開...
%EXPAND_CMD% %EXPAND_OPT% "%~dp0\..\%UNIEXT_DIR%\%UNIEXT_FILE%" %EXPAND_DIR_OPT% "%~dp0\..\%UNIEXT_DIR%"
echo Teraterm 展開...
%EXPAND_CMD% %EXPAND_OPT% "%~dp0\..\%TERATERM_DIR%\%TERATERM_FILE%" %EXPAND_DIR_OPT% "%~dp0\..\%TERATERM_DIR%"
echo Qemu 展開...
"%~dp0\..\%UNIEXT_PATH%\bin\x86\7z.exe" x -y -o"%~dp0\..\%QEMU_DIR%\" "%~dp0\..\%QEMU_DIR%\%QEMU_FILE%" 
