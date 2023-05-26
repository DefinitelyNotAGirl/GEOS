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
#include <INIT.h>
#include <attr>
#include <bits>
#include <macros>
#include <multiboot.h>
#include <bootInfo>
#include <decext>

extern "C" void initiate(multiboot::info* multiBootInfo)
{
    //
    // REMEMBER: we dont have klib in memory at this point
    //

    __bootInfo__* bootInfo = (__bootInfo__*)0x600000;

    //check if multiBootInfo is on the 4th memory page
    if(!(multiBootInfo >= (void*)0x800000 && multiBootInfo <= (void*)0x600000-sizeof(multiboot::info)))
    {
        //gotta relocate multiBootInfo

        for(uint8_t* i = (uint8_t*)0x200000;i<(void*)0x200000+sizeof(multiboot::info);i++)
        {
            if(init_memiszero((void*)0x200000,sizeof(multiboot::info)) == 0)
                init_memcpy(multiBootInfo,(void*)0x200000,sizeof(multiboot::info));
            interrupt(0xFD);
        }
    }

    //assume multiBootInfo is now in a safe location and that 0x600000-0x800000 is free
    if(EXPR_GETBIT_00(multiBootInfo->flags))
    {
        if(multiBootInfo->mem_lower > 640)
            interrupt(0xFE);//640KiB is the max for mem_lower

        bootInfo->VirtualMemoryMAX = (multiBootInfo->mem_lower+multiBootInfo->mem_upper)*1024;
    }
    else
        interrupt(0xFC);//terminate kernel, no memory information
}