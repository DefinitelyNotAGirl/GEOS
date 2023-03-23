#
# Created Date: Saturday February 18th 2023
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Saturday February 18th 2023 10:55:13 pm
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


dllName=invalid
dllFolders=$(WORKSPACE)dll
sample=$(WORKSPACE)sample/

createDll:
#check for dll name
ifeq ($(dllName),invalid)
	$(error please provide a dll name)
endif

#create folder for dll
	@mkdir $(dllFolders)/$(dllName)
	@mkdir $(dllFolders)/$(dllName)/src
	@mkdir $(dllFolders)/$(dllName)/headers
	@mkdir $(dllFolders)/$(dllName)/bin

#copy sample files
	@cp $(sample)dll.cpp 	$(dllFolders)/$(dllName)/src/main.cpp
	@cp $(sample)dll.h 		$(dllFolders)/$(dllName)/headers/$(dllName).h
	@cp $(sample)dll.mak 	$(dllFolders)/$(dllName)/makefile
	@cp $(sample)dll.ld 	$(dllFolders)/$(dllName)/link.ld
