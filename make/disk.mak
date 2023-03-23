#
# Created Date: Friday February 17th 2023
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Friday February 17th 2023 5:49:29 am
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

espRoot=$(WORKSPACE)GEOS_DISK_ROOT/ESP
diskRoot=$(WORKSPACE)GEOS_DISK_ROOT

wipeESP:
	$(info wiping EFI system parition...)
	@-rm -r $(espRoot) $(STDOUT)

fillESP:
	$(info populating EFI system partition...)
	@-mkdir $(espRoot) $(STDOUT)
	@-mkdir $(espRoot)/EFI $(STDOUT)
	@-mkdir $(espRoot)/EFI/BOOT $(STDOUT)
#	@-mkdir $(espRoot)/BOOT $(STDOUT)
	@-mkdir $(espRoot)/GEOS $(STDOUT)

#	BOOTX64.EFI	
	@cp $(WORKSPACE)$(BIN)/main.efi $(espRoot)/GEOS/GEOS.efi $(STDOUT)
	@cp $(espRoot)/GEOS/GEOS.efi $(espRoot)/EFI/BOOT/BOOTX64.EFI $(STDOUT)

#	GEOS config
	@cp $(WORKSPACE)OS_CONFIG/boot.ini $(espRoot)/GEOS/boot.ini $(STDOUT)

mkESP: wipeESP fillESP

mkDisk: mkESP mkRootFS disk_cleanup disk_create disk

disk: disk_ESP disk_MSP

disk_cleanup:
	$(info cleaning up virtual disk setup...)
	@-umount mnt/fs0 $(STDOUT)
	@-umount mnt/fs1 $(STDOUT)
	@-losetup -d $(LOOPBACKDEV) $(STDOUT)

disk_create:
	$(info setting up virtual disk...)
	$(info writing blank disk image...)
	@dd if=/dev/zero of=DISK.vhd bs=1M count=1024 $(STDOUT)
	$(info paritioning disk...)
	@echo -e "g\nn\n1\n\n+128M\nn\n2\n\n\nt\n1\n1\nw\n" | fdisk DISK.vhd $(STDOUT)
	$(info creating loopback...)
	@losetup -P $(LOOPBACKDEV) $(WORKSPACE)DISK.vhd $(STDOUT)
	$(info creating filesystems...)
	@mkfs.vfat -F 32 -n "EFI System" $(LOOPBACKDEV)p1 $(STDOUT)
	@mkfs -t ext4 $(LOOPBACKDEV)p2 $(STDOUT)
	$(info mounting file systems...)
	@mount $(LOOPBACKDEV)p1 $(WORKSPACE)mnt/fs0 $(STDOUT)
	@mount $(LOOPBACKDEV)p2 $(WORKSPACE)mnt/fs1 $(STDOUT)

disk_ESP: fillESP
	$(info populating EFI system partition...)
	@cp -r $(espRoot)/. mnt/fs0/ $(STDOUT)

disk_MSP:
	$(info populating main system partition...)
	@cp -r $(diskRoot)/GFS0MSP/. mnt/fs1/ $(STDOUT)


