/**
 * Author: DefinitelyNotAGirl@github
 * -----
 * Copyright (c) 2023 DefinitelyNotAGirl@github
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
#pragma once

#define PAGE_SIZE 0x200000

#define PROC_ID_MAPEND  0x0000000000000000;
#define PROC_ID_NONE    0x0000000000000001;
#define PROC_ID_FIRM    0x0000000000000002;
#define PROC_ID_MMIO    0x0000000000000003;
#define PROC_ID_KERNEL  0x0000000000000004;
#define PROC_ID_GSHARE  0x0000000000000005;
#define PROC_ID_DAMAGED 0x0000000000000006;

extern "C" int init();
extern "C" uint64_t getFreePageAddr(uint64_t skip);//return 0 is invalid
extern "C" void delloc(uint64_t procID);
extern "C" void* malloc(uint64_t size);
extern void deallocatePage(uint64_t physAddr, uint64_t procID);
