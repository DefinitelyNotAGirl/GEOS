#
# Created Date: Friday November 25th 2022
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Friday November 25th 2022 3:41:41 pm
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

dd=dd

createIMG_UEFI:

createIMG_BIOS:
# 	copy code to 64MB MBR partition
	$(dd) if=/dev/zero  	of=$(img) conv=notrunc bs=512 count=125000 	seek=0
	$(dd) if=$(OUT_BOOT)   	of=$(img) conv=notrunc bs=512 count=4      	seek=0
	$(dd) if=$(OUT_32)   	of=$(img) conv=notrunc bs=512 count=28     	seek=4
	$(dd) if=$(OUT_64)   	of=$(img) conv=notrunc bs=512 count=124968 	seek=32

createIMG:
ifeq ($(target),BIOS)
	$(MAKE) createIMG_BIOS
else ifeq ($(target),UEFI)
	$(MAKE) createIMG_UEFI
else
	@error invalid target "$(target)"
endif
		