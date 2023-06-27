/**
 * Created Date: Saturday May 27th 2023
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Saturday May 27th 2023 10:59:11 pm
 * Modified By: DefinitelyNotAGirl@github (definitelynotagirl115169@gmail.com)
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

#include <stdint>
#include <macros>
#include <attr>
#include <bits>

extern "C" u64 getCR2();

u64 PML4T_BASE = 0x2400000;

static u64 getPageEntryAddr(u64 virtAddr)
{
    return PML4T_BASE+((virtAddr/0x200000)*8)+0x2000;
}

/*
    * creates identity mapped page
*/
static void createPageRODATA(u64 address)
{
    u64* entry = (u64*)getPageEntryAddr(address);

    *entry = address;
    CLEARBIT_03(*entry); // clear PWT
    CLEARBIT_05(*entry); // clear Accessed
    CLEARBIT_06(*entry); // clear Dirty
    CLEARBIT_08(*entry); // clear Global
    CLEARBIT_12(*entry); // clear PAT
    CLEARBIT_01(*entry); // clear write
    CLEARBIT_04(*entry); // enable page cache

    SETBIT_00(*entry); // set present
    SETBIT_02(*entry); // set supervisoronly
    SETBIT_07(*entry); // MBO bit 7
    SETBIT_63(*entry); // set NoExecute
}

/*
    * creates identity mapped page
*/
static void createPageRWDATA(u64 address)
{
    u64* entry = (u64*)getPageEntryAddr(address);

    *entry = address;
    CLEARBIT_03(*entry); // clear PWT
    CLEARBIT_05(*entry); // clear Accessed
    CLEARBIT_06(*entry); // clear Dirty
    CLEARBIT_08(*entry); // clear Global
    CLEARBIT_12(*entry); // clear PAT
    CLEARBIT_04(*entry); // enable page cache

    SETBIT_00(*entry); // set present
    SETBIT_01(*entry); // set write
    SETBIT_02(*entry); // set supervisoronly
    SETBIT_07(*entry); // MBO bit 7
    SETBIT_63(*entry); // set NoExecute
}

extern "C" void pageFaultHandler_CPP(u64 error)
{
    if(error == 0)
    {
        //non present read
        u64 address = getCR2();
        createPageRODATA(address);
        return;
    }

    if(error == 2)
    {
        //non present write
        u64 address = getCR2();
        createPageRWDATA(address);
        return;
    }

    interrupt(0xd); //cant handle fault, throw double fault
}
