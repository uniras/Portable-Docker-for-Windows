@echo off
call "%~dp0\config.bat"

if not exist "%~dp0\..\%QEMU_HDD_PATH%" goto :setupok

set /P ANSWER="すでにインストール済みのようです。実行すると仮想HDDのデータはすべて消去され、再度ファイルのダウンロードから始めますがよろしいですか (Y/N)？"

if /i {%ANSWER%}=={y} (goto :formatok)
if /i {%ANSWER%}=={yes} (goto :formatok)

pause

exit

:formatok

del /q "%~dp0\..\%QEMU_HDD_PATH%"

:setupok

echo セットアップを開始します...

call "%~dp0\download.bat"

call "%~dp0\install.bat"

pause
