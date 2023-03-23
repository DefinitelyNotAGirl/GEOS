#
# Created Date: Saturday February 18th 2023
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Wednesday March 8th 2023 11:30:53 pm
# Modified By: DefinitelyNotAGirl@github (definitelynotagirl115199@gmail.com)
# -----
# Copyright (c) 2023 DefinitelyNotAGirl@github
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
BINARY=bin/BOOTX64.EFI
INCDIRS=headers ../../lib/inc
LDMISC=-shared -Bsymbolic -L../../extern/gnu-efi/lib -T../../extern/gnu-efi/elf_x86_64_efi.lds $(WORKSPACE)extern/gnu-efi/lib/crt0-efi-x86_64.o $(WORKSPACE)$(OUT)/UEFI_main.o -o ../../bin/UEFI.so -lgnuefi -lefi
GPPMISC=../../extern/gnu-efi/inc -fshort-wchar -fpic -ffreestanding -fno-stack-protector -fno-stack-check -fshort-wchar -mno-red-zone -maccumulate-outgoing-args -c $(SRC)/UEFI/main.c

GPP=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-g++
LD=/git/GEOS_CROSSCOMPILER/bin/x86_64-elf-ld

OPT=-O0
DEPFLAGS=-MP -MD

LIBS=$(wildcard ../../lib/*.a)
LIB_FLAGS=$(foreach D,$(LIBS),-L:$(D))
LD_ARGS=$(LDMISC)
NOWARN=-Wno-literal-suffix
GPP_ARGS=$(GPPMISC) $(NOWARN) $(OPT) $(DEPFLAGS) $(foreach D,$(INCDIRS),-I$(D)) -nostdlib -ffreestanding -fno-stack-protector

SOURCE=$(wildcard src/*.cpp)
OBJECTS=$(patsubst src/%.cpp,bin/%.o,$(SOURCE))
DEPFILES=$(patsubst src/%.cpp,bin/%.d,$(SOURCE))

all: $(BINARY)

$(BINARY): $(OBJECTS)
	@$(LD) $(LD_ARGS) $^
	@objcopy -j .text -j .sdata -j .data -j .dynamic -j .dynsym  -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc --target efi-app-x86_64 --subsystem=10 ../../bin/UEFI.so $@
	$(info [BUILD] compiled module: $(shell basename $(CURDIR)))
	@python ../../scripts/placeMod.py ../ ../../GEOS_DISK_ROOT $(shell basename $(CURDIR))
	$(info [FILESYSTEM] placed module: $(shell basename $(CURDIR)))

bin/%.o: src/%.cpp
	$(GPP) $(GPP_ARGS) -o $@ $<

# include dependencies
-include $(DEPFILES)

clean:
	@-rm $(OBJECTS) $(DEPFILES) $(BINARY)