#
# Created Date: Friday February 17th 2023
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Friday February 17th 2023 1:24:05 am
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

UEFI_compile:
	@python scripts/UEFIsizeFlags.py

UEFI_SIZE_FLAG = 
UEFI_compile_2:
	$(info compiling UEFI application...)
#	$(GCC) $(UEFI_SIZE_FLAG) -I$(WORKSPACE)extern/gnu-efi/inc -fshort-wchar -fpic -ffreestanding -fno-stack-protector -fno-stack-check -fshort-wchar -mno-red-zone -maccumulate-outgoing-args -c $(SRC)/UEFI/main.c -o $(WORKSPACE)$(OUT)/UEFI_main.o $(GCCOUT)
	$(GCC) $(UEFI_SIZE_FLAG) -I$(WORKSPACE)extern/gnu-efi/inc -fshort-wchar -fpic -ffreestanding -fno-stack-protector -fno-stack-check -fshort-wchar -mno-red-zone -maccumulate-outgoing-args -S -fverbose-asm $(SRC)/UEFI/main.c -o uefi.asm
	@$(LD) -shared -Bsymbolic -L$(WORKSPACE)extern/gnu-efi/lib -T$(WORKSPACE)extern/gnu-efi/elf_x86_64_efi.lds $(WORKSPACE)extern/gnu-efi/lib/crt0-efi-x86_64.o $(WORKSPACE)$(OUT)/UEFI_main.o -o $(WORKSPACE)$(OUT)/UEFI.so -lgnuefi -lefi $(STDOUT)
	@objcopy -j .text -j .sdata -j .data -j .dynamic -j .dynsym  -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc --target efi-app-x86_64 --subsystem=10 $(WORKSPACE)$(OUT)/UEFI.so $(WORKSPACE)$(BIN)/main.efi $(STDOUT)
