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
	rm -r $(espRoot)

fillESP:
	mkdir $(espRoot)
	cp $(WORKSPACE)$(BIN)/main.efi $(espRoot)/GEOS/GEOS.efi

mkESP: wipeESP fillESP

mkDisk: disk_cleanup disk_create disk

disk: disk_ESP disk_MSP

disk_fill: disk_ESP disk_MSP

disk_cleanup:
	-umount mnt/fs0
	-umount mnt/fs1
	losetup -d $(LOOPBACKDEV)

disk_create:
	dd if=/dev/zero of=DISK.vhd bs=1M count=1024
	echo -e "g\nn\n1\n\n+128M\nn\n2\n\n\nw\n" | fdisk DISK.vhd
	losetup -P $(LOOPBACKDEV) $(WORKSPACE)DISK.vhd
	mkfs -t vfat $(LOOPBACKDEV)p1
	mkfs -t ext4 $(LOOPBACKDEV)p2
	mount $(LOOPBACKDEV)p1 $(WORKSPACE)mnt/fs0
	mount $(LOOPBACKDEV)p2 $(WORKSPACE)mnt/fs1

disk_ESP:
	cp -r $(espRoot)/. mnt/fs0/

disk_MSP:
	cp -r $(diskRoot)/GFS0MSP/. mnt/fs1/
