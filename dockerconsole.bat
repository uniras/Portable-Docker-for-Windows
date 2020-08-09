@echo off
echo Linux‚ğ‹N“®‚µ‚Ä‚¢‚Ü‚·B‚µ‚Î‚ç‚­‚¨‘Ò‚¿‚­‚¾‚³‚¢...
CALL %~dp0\start.bat
CALL %~dp0\startwait.bat
CALL %~dp0\script\dockerconfig.bat

cmd