#
# mykernel/cpp/Makefile
#
# Copyright (C) 2017 - 2021 bzt (bztsrc@gitlab)
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
# This file is part of the BOOTBOOT Protocol package.
# @brief An example Makefile for sample kernel
#
#

#NOTE: this is a faily modified version of the original, for the original source go to gitlab

RUN=./scripts/run64.sh

GCC=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-gcc
CPP=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-g++
LD=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-ld
STRIP=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-strip
READELF=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-readelf

BUILD_NUMBER_FILE=VERSION_FILE
BUILD_NUMBER_LDFLAGS = --defsym __BUILD_DATE=$$(date +'%Y%m%d')
BUILD_NUMBER_LDFLAGS += --defsym __BUILD_NUMBER=$$(cat $(BUILD_NUMBER_FILE))

OUT=./build

NOWARN = -Wno-multichar -Wno-unused-variable -Wno-literal-suffix
CPPFLAGS = -Wall -fpic -ffreestanding -fno-stack-protector -fno-exceptions -fno-rtti -nostdinc -nostdlib -I../../dist/ -fpermissive -I"/git/GEOS/stdlibc++/" -ffixed-r15 $(NOWARN)
LDFLAGS = -nostdlib -n -T link.ld
LDFLAGS += $(BUILD_NUMBER_LDFLAGS)

STRIPFLAGS = -s -K mmio -K fb -K bootboot -K environment -K initstack

all: mykernel.x86_64.elf bootboot

asm: src/kernel.cpp
	nasm -f elf64 src/GEOS/asm/asm_main.asm -o build/kernel_2.o
	$(CPP) $(CPPFLAGS) -mno-red-zone -c src/kernel.cpp -o $(OUT)/kernel.o
	$(LD) $(LDFLAGS) $(OUT)/kernel_2.o $(OUT)/kernel.o -S -o asm/kernel.asm

run: clean all
	$(RUN)

bootboot: src/kernel.cpp
	./mkbootimg BOOTBOOT.json GEOS.iso

mykernel.x86_64.elf: src/kernel.cpp
	scripts/builtnum.sh
	nasm -f elf64 src/GEOS/asm/asm_main.asm -o build/kernel_2.o
	$(CPP) $(CPPFLAGS) -mno-red-zone -c src/kernel.cpp -o $(OUT)/kernel.o
	$(LD) $(LDFLAGS) $(OUT)/kernel_2.o $(OUT)/kernel.o -o $(OUT)/geos.x86_64.elf
	$(STRIP) $(STRIPFLAGS) $(OUT)/geos.x86_64.elf
	$(READELF) -hls $(OUT)/geos.x86_64.elf > $(OUT)/geos.x86_64.txt

clean:
	rm *.o *.elf *.txt || true
