@echo off
set /P mpos=Memory Position: 
AKSToBin.exe -a %mpos% %1
pause