/**
 * Created Date: Friday November 25th 2022
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Friday November 25th 2022 4:18:32 pm
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

#include <stdint.h>

#include "code32/memory.h"
memoryMap mmap;
memoryMapEntry mmap_entries[128];
#include "code32/memory.c"

uint32_t screen_position;
uint8_t* VGA;
void exit();

uint32_t strlen(char* str)
{
    uint32_t I = 0;
    while(str[I]!=0x00)I++;
    return I;
}
void printChar(char c)
{
    if(c == '\n')
    {
        screen_position = ((screen_position/160)+1)*160;
        return;
    }
    else
    {
        VGA[screen_position++] = c;
        VGA[screen_position++] = 0x0F;
    }
}
void printStr(char* str)
{
    uint32_t len = strlen(str);
    for(uint32_t I = 0;I<len;I++)
        printChar(str[I]);
}
const char* HEXDIG = "0123456789ABCDEF";
void printuint(uint32_t n)
{
    printChar('0');
    printChar('x');
    for(uint8_t I = 9;I>1;I--)
    {
        printChar(HEXDIG[n&0xF]);
        n>>=4;
    }
}

char* helloworld = "hello world from C\n";
char* mmapComplete = "Memory map loaded\n";

void stage3(uint32_t screenPos, uint32_t VGA_ADDR)
{
    screen_position = screenPos;
    VGA = (uint16_t*)VGA_ADDR;

    printStr(helloworld);

    mmap.size = ((uint16_t*)0xFFFB)[0];
    mmap.mmap = mmap_entries;
    moveMMAP();
    printStr(mmapComplete);
}
