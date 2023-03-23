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

WORKSPACE=
MAKE=$(WORKSPACE)make
STDOUT= &>> $(WORKSPACE)makeout.txt
GCCOUT= -w >> $(WORKSPACE)makeout.txt
MAKEOUT= --no-print-directory

debug:
	$(info ************ DEBUG BUILD ************)
	@$(MAKE) all KERNEL_DEFINE="-D GEOS_DEBUG" $(MAKEOUT)

release:
	$(info ************ RELEASE BUILD ************)
	@$(MAKE) all KERNEL_DEFINE="-D GEOS_RELEASE" $(MAKEOUT)

all: buildnum
	@python $(WORKSPACE)scripts/dllCompileAll.py $(moduleFolders)
	@$(MAKE) updateRootFS $(MAKEOUT)
	@$(MAKE) disk $(MAKEOUT)
	@$(MAKE) run $(MAKEOUT)

include make/make.dev
include make/run.mak
include make/buildnumber.mak
include make/rootfs.mak
include make/compile.mak
include make/disk.mak
include make/clean.mak
include make/modules.mak
