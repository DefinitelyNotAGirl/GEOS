#
# Created Date: Wednesday March 8th 2023
# Author: DefinitelyNotAGirl@github
# -----
# Last Modified: Wednesday March 8th 2023 10:44:03 pm
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

moduleName=invalid
moduleFolders=$(WORKSPACE)modules
sample=$(WORKSPACE)sample/

#
#
# CREATE MODULE
#
#
createModule:
#check for module name
ifeq ($(moduleName),invalid)
	$(error please provide a module name)
endif
#create folder for module
	@mkdir $(moduleFolders)/$(moduleName)
	@mkdir $(moduleFolders)/$(moduleName)/src
	@mkdir $(moduleFolders)/$(moduleName)/headers
	@mkdir $(moduleFolders)/$(moduleName)/bin
#copy sample files
	@cp $(sample)module.cpp 	$(moduleFolders)/$(moduleName)/src/main.cpp
	@cp $(sample)module.h 		$(moduleFolders)/$(moduleName)/headers/$(moduleName).h
	@cp $(sample)module.mak 	$(moduleFolders)/$(moduleName)/makefile
	@cp $(sample)module.ld 		$(moduleFolders)/$(moduleName)/link.lds

#
#
# SAMPLE UPDATE
#
#
updateModuleSamples:
	@python $(WORKSPACE)scripts/dllSampleUpdate.py $(moduleFolders)

MOD_NAME_ITERATOR = invalid
moduleSampleUpdateSingle:
	$(info updating $(MOD_NAME_ITERATOR)...)
#	@cp $(sample)module.mak 	$(WORKSPACE)modules/$(MOD_NAME_ITERATOR)/makefile
#	@cp $(sample)module.ld 		$(WORKSPACE)modules/$(MOD_NAME_ITERATOR)/link.ld
#	@cp $(sample)module.cpp 	$(WORKSPACE)modules/$(MOD_NAME_ITERATOR)/src/main.cpp
#	@cp $(sample)module.h 		$(WORKSPACE)modules/$(MOD_NAME_ITERATOR)/headers/$(MOD_NAME_ITERATOR).h

