#
# Created Date: Friday November 25th 2022
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Friday November 25th 2022 3:35:00 pm
# Modified By: DefinitelyNotAGirl@github (definitelynotagirl115199@gmail.com)
# -----
# Copyright (c) 2022 DefinitelyNotAGirl@github
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use, copy,
# modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#

# x86_64 compiler
GCC=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-gcc
CPP=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-g++
LD=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-ld

#Linker options
LD_FLAGS = -nostdlib -n
LD_FLAGS += $(BUILD_NUMBER_LDFLAGS)

#c options
C_NOWARN=-Wno-multichar -Wno-unused-variable -Wno-literal-suffix
C_FLAGS=-c -nostdlib -Wall -ffreestanding -fno-stack-protector -I"./stdlibc/" -ffixed-r15 $(C_NOWARN)

#c++ options
CPP_NOWARN=-c -Wno-multichar -Wno-unused-variable -Wno-literal-suffix
CPP_FLAGS= -Wall -ffreestanding -fno-stack-protector -fno-exceptions -fno-rtti -nostdinc -nostdlib -I../../dist/ -fpermissive -I"./stdlibc++/" -ffixed-r15 $(CPP_NOWARN) $(BUILD_NUM_FLAG)

# dirs
OUT=build
SRC=src
BIN=bin

# outputs
OUT_BOOT=$(WORKSPACE)$(BIN)/boot
OUT_16  =$(WORKSPACE)$(BIN)/bin16
OUT_32  =$(WORKSPACE)$(BIN)/bin32
OUT_64  =$(WORKSPACE)$(BIN)/bin64

compile_boot:
	nasm -f bin $(SRC)/boot.asm -o $(OUT_BOOT)

compile_32:
	nasm -f elf32 $(SRC)/entry32.asm -o $(OUT)/asm32.o
	$(GCC) $(C_FLAGS) -m32 $(SRC)/code32.c -o $(OUT)/c32.o
	$(LD) -O binary $(OUT)/asm32.o $(OUT)/c32.o -o $(OUT_32) $(LD_FLAGS) -T $(WORKSPACE)link32.ld

compile_64:
	nasm -f elf64 $(SRC)/GEOS/asm/asm_main.asm -o $(OUT)/asm64.o
	$(CPP) $(CPP_FLAGS) $(SRC)/GEOS/main.cpp -o $(OUT)/c64.o
	$(LD) -O binary $(OUT)/asm64.o $(OUT)/c64.o -o $(OUT_64) $(LD_FLAGS)

compile: compile_boot compile_32 compile_64