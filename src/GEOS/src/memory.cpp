/**
 * Created Date: Monday November 14th 2022
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Monday November 14th 2022 1:19:52 am
 * Modified By: DefinitelyNotAGirl@github (definitelynotagirl115199@gmail.com)
 * -----
 * Copyright (c) 2022 DefinitelyNotAGirl@github
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
#include "../master.h"

void detectMemory()
{
    out << "detecting memory..." << endl;
    uint64_t highestHole = 0;
    uint64_t totalMem    = 0;

    uint64_t* mmap_ent_ptr = (uint64_t*)&bootboot.mmap;
    uint64_t* mmap_ent_size = mmap_ent_ptr;
    uint64_t mmapMax = (uint64_t)(&bootboot.mmap+bootboot.size);

    while((uint64_t)mmap_ent_size<mmapMax)
    {
        if((*mmap_ent_size&0xF)==1)
            totalMem+=GETH60(*mmap_ent_size);

        mmap_ent_ptr+=0x10;
        mmap_ent_size+=0x10;
    }

    computer.memorySize = totalMem;
}
