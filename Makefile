# Configuration for Makefile
# Project name and in the same time names of the executables.
PROJ_NAME=hal

# sources' directories
SRCS         := $(wildcard src/*.c) $(wildcard lib/FreeRTOS/*.c) $(wildcard lib/enc28j60/*.c) $(wildcard lib/stm32cubef1/*.c)
SRCSCPP      := $(wildcard src/*.cpp) $(wildcard lib/httpserver/src/*.cpp)

# headers' directories
CINCS := -Iinclude -Ilib/stm32cubef1/include -Ilib/stm32cubef1/include/Legacy 
CINCS += -Ilib/FreeRTOS/include 
CINCS += -Ilib/enc28j60/include
CINCS += -Ilib/httpserver/include
CINCS += -Ilib/rapidjson/include/rapidjson


###
# TODO: Probably we don't need this section
#
# look for sources in given folders
# VPATH := src lib
###


# build directory configuration
BUILDDIR  := build
OBJSDIR   := $(BUILDDIR)/objs
DEPSDIR   := $(BUILDDIR)/deps

DEFINES   := -DSTM32F103xE

# You don't need to edit anything below this line
###################################################

# add list of needed library's objects - OBJSLIB
-include objslib.mk

OBJS    := $(SRCS:%.c=$(OBJSDIR)/%.o)
OBJSCPP := $(SRCSCPP:%.cpp=$(OBJSDIR)/%.o)
OBJSLIB := $(addprefix $(OBJSDIR)/, $(OBJSLIB))

# C compiler's settings
CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy

#-mcpu=cortex-m3 -mthumb -mfloat-abi=soft -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F103xE -I"C:/software/embedded/projects/heat_control/firmware/Inc" -IC:/eclipseopenstm32/STM32Cube/Repository/STM32Cube_FW_F1_V1.4.0/Drivers/STM32F1xx_HAL_Driver/Inc -IC:/eclipseopenstm32/STM32Cube/Repository/STM32Cube_FW_F1_V1.4.0/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy -IC:/eclipseopenstm32/STM32Cube/Repository/STM32Cube_FW_F1_V1.4.0/Drivers/CMSIS/Include -IC:/eclipseopenstm32/STM32Cube/Repository/STM32Cube_FW_F1_V1.4.0/Drivers/CMSIS/Device/ST/STM32F1xx/Include  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Src/gpio.d" -MT"Src/gpio.o" -o "Src/gpio.o" "../Src/gpio.c"

# C compiler's options
CFLAGS := -Wall -std=c11
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m3
# -mthumb-interwork
#CFLAGS += -mfpu=fpv4-sp-d16 -mfloat-abi=softfp
CFLAGS += -fdata-sections -ffunction-sections
CFLAGS += $(DEFINES)

# Cpp compiler's settings
CPP=arm-none-eabi-g++
CPPFLAGS := -Wall -std=c++11
CPPFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m3
# -mthumb-interwork
#CPPFLAGS += -mfpu=fpv4-sp-d16 -mfloat-abi=softfp
CPPFLAGS += -fdata-sections -ffunction-sections
CPPFLAGS += $(DEFINES)

# linker's scripts
LDSRCS    := ldscripts/STM32F103VETx_FLASH.ld

# linker's settings
LDFLAGS := $(LDSRCS:%=-T%) -specs=rdimon.specs -Wl,--gc-sections


# advanced settings
#
# LDLIBS  = -Llib -lstm32f1
# -mfpu=fpv4-sp-d16
# CFLAGS += -ffreestanding -nostdlib

###################################################

.PHONY: all proj depends debug release echo_variables link_needed_lib

.SUFFIXES:

debug: CFLAGS   += -ggdb -Og -DDEBUG
debug: CPPFLAGS += -ggdb -Og -DDEBUG
debug: proj
all: proj
release: CFLAGS   += -ggdb -Og
release: CPPFLAGS += -ggdb -Og
release: proj

depends: link_needed_lib


#################################################
#        debug and dependancy generation        #
#################################################
echo_variables:
	@echo OBJS: $(OBJS)
	@echo OBJSCPP: $(OBJSCPP)
	@echo OBJSLIB: $(OBJSLIB)
	@echo DEPS: $(SRCS:src/%.c=$(DEPSDIR)/%.d)
	@echo DEPS: $(SRCSCPP:src/%.cpp=$(DEPSDIR)/%.d)

link_needed_lib: $(addprefix $(DEPSDIR)/, $(SRCS:%.c=%.d)) $(addprefix $(DEPSDIR)/, $(SRCSCPP:%.cpp=%.d))
	@for i in "$(DEPSDIR)/src/*.d"; do \
		sed 's/\\//g; s/ /\n/g;' $$i | \
		grep 'stm32f1xx_.*\.h' | \
		sed -e '/stm32f1xx_hal_conf.h/d'     \
		    -e '/stm32f1xx_hal_def.h/d'      \
		    -e '/stm32f1xx_hal_gpio_ex.h/d;' \
		    -e '/stm32f1xx_it.h/d;' \
			-e 's:/include::g; s/h$$/o/g' >> objslib.tmp ;\
	done
	@rm -f objslib.mk
	@echo 'OBJSLIB :=' >> objslib.mk
	@sort -u objslib.tmp >> objslib.mk
	@cat objslib.mk | tr '\n' ' '> objslib.mk2
	@mv objslib.mk2 objslib.mk
	@rm -f objslib.tmp
	
$(DEPSDIR)/%.d: %.c | $(BUILDDIR)
	@$(CC) $(CFLAGS) $(CINCS) -MM -o $@ $<

$(DEPSDIR)/%.d: %.cpp | $(BUILDDIR)
	@$(CPP) $(CPPFLAGS) $(CINCS) -MM -MF $@ $<

#################################################

# add list of needed library's objects - OBJSLIB



proj: $(PROJ_NAME).elf 

$(PROJ_NAME).elf: $(OBJS) $(OBJSLIB) $(OBJSCPP)
	@echo "  (LDCPP) -o $@ $^"
	@$(CPP) -o $@ $^ src/startup_stm32f103xe.s $(CPPFLAGS) $(LDFLAGS) $(CINCS)  $(LDLIBS)
	$(OBJCOPY) -O ihex $(PROJ_NAME).elf $(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin

$(OBJS): | $(BUILDDIR)

$(OBJSDIR)/%.o : %.c 
	@echo "  (CC) $@"
	@$(CC) $(CFLAGS) $(CINCS) -MMD -MF $(DEPSDIR)/$(basename $<).d -c -o $@ $<

-include $(SRCS:%.c=$(DEPSDIR)/%.d)

$(OBJSDIR)/%.o : %.cpp
	@echo "  (CPP) $@"
	@$(CPP) $(CPPFLAGS) $(CINCS) -MMD -MF $(DEPSDIR)/$(basename $<).d -c -o $@ $<

-include $(SRCSCPP:%.cpp=$(DEPSDIR)/%.d)

# TODO: maybe dynamic creation of directories
$(BUILDDIR):
	mkdir -p $(OBJSDIR)/src
	mkdir -p $(OBJSDIR)/lib/stm32cubef1
	mkdir -p $(OBJSDIR)/lib/FreeRTOS
	mkdir -p $(OBJSDIR)/lib/enc28j60
	mkdir -p $(OBJSDIR)/lib/httpserver/src
	mkdir -p $(DEPSDIR)/src
	mkdir -p $(DEPSDIR)/lib/stm32cubef1
	mkdir -p $(DEPSDIR)/lib/FreeRTOS
	mkdir -p $(DEPSDIR)/lib/enc28j60
	mkdir -p $(DEPSDIR)/lib/httpserver/src
	


# Take care about non-existing headers.
# If a header doesn't exist, it assumes, that the header has been changed.
# see: GNU Make Manual "Rules without Commands or Prerequisites"
%.h:

clean:
	rm -f $(OBJSLIB)
	rm -f $(OBJSCPP)
	rm -rf $(BUILDDIR)
	rm -f objslib.mk
