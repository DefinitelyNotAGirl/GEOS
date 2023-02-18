#
# Created Date: Friday November 25th 2022
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Friday November 25th 2022 3:33:49 pm
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

fsroot=$(WORKSPACE)GEOS_DISK_ROOT/GFS0MSP
updateRootFS: fillRootFS copyRootFS

fillRootFS:
	cp -rf stdlibc/* 	$(fsroot)/sys/inc
	cp -rf stdlibc++/* 	$(fsroot)/sys/inc
	cp -rf src/* 		$(fsroot)/geos/src_backup

copyRootFS:
	cp -rf $(fsroot)/* $(MNT_1)

wipeRootFS:
	rm -r $(fsroot)

structRootFS:
	mkdir $(fsroot)
	mkdir $(fsroot)/boot
	mkdir $(fsroot)/geos
	mkdir $(fsroot)/geos/src
	mkdir $(fsroot)/geos/src_backup
	mkdir $(fsroot)/sys
	mkdir $(fsroot)/sys/inc

mkRootFS: wipeRootFS structRootFS fillRootFS copyRootFS
