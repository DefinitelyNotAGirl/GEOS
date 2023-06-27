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

u64 mb2TagFlags = 0;

extern "C" void DBG_EXIT(u64 n);
extern "C" void loadIDT(void* idt);

__bootInfo__* bootInfo = (__bootInfo__*)0x600000;

bool evaluateMB2Tag(multiboot2::tag_base* tag)
{
    if(tag->type == 0)
    {
        return false;
    }
    else if(tag->type == 4) // BASIC MEMORY INFORMATION
    {
        auto* t = (multiboot2::BasicMemoryInformation*)tag;
        SETBIT_00(mb2TagFlags);//set 0 for basic mem info

        if(t->mem_lower > 640)
            interrupt(0xFE);//640KiB is the max for mem_lower

        bootInfo->VirtualMemoryMAX = (t->mem_lower+t->mem_upper)*1024;
    }
    else
    {
        //DBG_EXIT(0xFFFF0000 | tag->type);
    }

    if(tag->size == 0)
    {
        tag+=8;
        return true;
    }
    
    if(ISMULTIPLE(tag->size,8) == false)
    {
        u64 s = tag->size;
        while(ISMULTIPLE(s,8) == false)
            s++;
        tag+=s;
        return true;
    }
    tag += tag->size;//increment tag pointer by size of tag
    return true;
}

void evaluateMultiboot2(void* mb2i)
{
    u32 totalSize = *((u32*)(mb2i));
    if(totalSize == 8)
        interrupt(0xF0); // no tags, terminate kernel cause no information
    mb2i += 8;
    while(evaluateMB2Tag((multiboot2::tag_base*)mb2i)){}
    DBG_EXIT(0x9999);
}

void evaluateMultiboot1(void* mb1i)
{
}

void installPageFaultHandler()
{
    u64* IDTaddress = 0x4400000;
    u64* IDTlimit = 0x4400000+8;
    void** IDT = 0x4400000+10;

    //assign page fault handler
    IDT[0x0E] = &pageFaultHandler;

    *IDTaddress = IDT;
    *IDTlimit = 2048;

    loadIDT(0x4400000);
}

extern "C" void initiate(void* mbi,u64 multibootVersion)
{
    //
    // REMEMBER: we dont have klib in memory at this point
    //

    installPageFaultHandler();

    if(multibootVersion == 1)
        evaluateMultiboot1(mbi);
    else if(multibootVersion == 2)
        evaluateMultiboot2(mbi);
    else
        interrupt(0xFE);

   interrupt(0xFF);//terminate kernel, end of program
}