# 
# Created Date: Friday November 25th 2022
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Friday November 25th 2022 3:29:03 pm
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

target=BIOS
WORKSPACE=
img=$(WORKSPACE)geos.img
MAKE=$(WORKSPACE)make

all: clean buildnum compile updateRootFS createIMG run

hexdump:
#	create file offset by 0x7C00 (31744 dd doesent take hex numbers)
	$(dd) if=/dev/zero 	of=$(img).hexdump.temp conv=notrunc bs=512 	count=125002 	seek=0
	$(dd) if=$(img) 	of=$(img).hexdump.temp conv=notrunc bs=31744	count=125000 	seek=1
# 	hexdump the file
	touch $(img).hexdump
	hexdump  $(img).hexdump.temp -s 0x7C00 > $(img).hexdump
#	get rid of temp image
	rm $(img).hexdump.temp

include make/run.mak
include make/buildnumber.mak
include make/rootfs.mak
include make/compile.mak
include make/img.mak
include make/clean.mak
