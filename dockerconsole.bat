call "%~dp0\start.bat"

echo Linuxを起動しています。しばらくお待ちください...

call "%~dp0\script\startwait.bat"

if errorlevel 0 goto start

echo 接続に失敗しました。Qemuが起動していないようです。

pause 

exit

:start

call "%~dp0\script\dockerconfig.bat"

cmd