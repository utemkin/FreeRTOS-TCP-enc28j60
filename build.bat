@echo off
set PATH=C:\software\embedded\gcc-arm-none-eabi-5_4-2016q3-20160926-win32\bin;%PATH%
set PATH=C:\software\embedded\GNU ARM Eclipse\Build Tools\2.6-201507152002\bin;%PATH%

echo %PATH%
make %*
