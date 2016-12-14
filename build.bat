@echo off
set PATH=C:\ChibiStudio\tools\gnutools\bin;%PATH%
set PATH=C:\ChibiStudio\tools\openocd\bin;%PATH%
set PATH=C:\ChibiStudio\tools\GNU Tools ARM Embedded\4.9 2015q1\arm-none-eabi\bin;%PATH%
set PATH=C:\ChibiStudio\tools\GNU Tools ARM Embedded\4.9 2015q1\bin;%PATH%
make %*
