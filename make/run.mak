#
# Created Date: Friday November 25th 2022
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Friday November 25th 2022 3:35:56 pm
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

QEMU_DBG=-d in_asm,int,cpu_reset
QEMU_MISC=-no-reboot -no-shutdown
QEMU_MEMORY=512M
QEMU_CORES=1
QEMU_MACHINE=q35
QEMU_DRIVE=-drive format=raw,file=$(img)
QEMU_LOG=/GEOS_LOG/qemu.log
QEMU_FIRMWARE=-bios /usr/share/edk2-ovmf/x64/OVMF.fd

run_FIRMWARE:
	qemu-system-x86_64 -machine $(QEMU_MACHINE) $(QEMU_MISC) $(QEMU_DBG) $(QEMU_DRIVE) -m $(QEMU_MEMORY) $(QEMU_FIRMWARE) -smp $(QEMU_CORES) 2> $(QEMU_LOG)

run:
ifeq ($(firmware),SEABIOS)
	$(MAKE) run_FIRMWARE QEMU_FIRMWARE=""
else ifeq ($(firmware),BOCHS)
	$(MAKE) run_FIRMWARE QEMU_FIRMWARE="-bios ~/BIOS/bochs/bios.bin"
else ifeq ($(firmware),UEFI)
	$(MAKE) run_FIRMWARE QEMU_FIRMWARE="-bios /usr/share/edk2-ovmf/x64/OVMF.fd"
else
	@error invalid firmware "$(firmware)"
endif