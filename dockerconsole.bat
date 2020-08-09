@echo off
echo Linux‚ğ‹N“®‚µ‚Ä‚¢‚Ü‚·B‚µ‚Î‚ç‚­‚¨‘Ò‚¿‚­‚¾‚³‚¢...
call %~dp0\start.bat
call %~dp0\startwait.bat
call %~dp0\script\dockerconfig.bat

cmd