/**
 * Created Date: Thursday November 17th 2022
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Thursday November 17th 2022 8:40:01 am
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

ostream::ostream(){}

void ostream::out(int32_t i)
{
    char STR[INTTS_SIZE] = {0x00};
    INTTS(i,10,STR);
    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(int16_t i)
{
    char STR[INTTS_SIZE] = {0x00};
    INTTS(i,10,STR);
    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(int8_t  i)
{
    char STR[INTTS_SIZE] = {0x00};
    INTTS(i,10,STR);
    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(uint64_t i)
{
    char STR[INTTS_SIZE] = {0x00};
    INTTS((uint32_t)i,10,STR);
    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(uint32_t i)
{
    char STR[INTTS_SIZE] = {0x00};
    INTTS(i,10,STR);
    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(uint16_t i)
{
    char STR[INTTS_SIZE] = {0x00};
    INTTS(i,10,STR);
    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(uint8_t  i)
{
    char STR[INTTS_SIZE] = {0x00};
    INTTS(i,10,STR);
    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(int64_t  i)
{
    char STR[INTTS_SIZE] = {0x00};
    INTTS(i,10,STR);
    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(HEX64 i)
{
    char STR[STR_POINTER_LEN] = {0x00};
    PTS(STR,i);

    for(auto I = 0;I<STR_POINTER_LEN;I++)
        this->putchar(STR[I]);
}

void ostream::out(HEX32 i)
{
    char STR[STR_POINTER_LEN] = {0x00};
    PTS(STR,i);

    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(HEX16 i)
{
    char STR[STR_POINTER_LEN] = {0x00};
    PTS(STR,i);

    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(HEX8 i)
{
    char STR[STR_POINTER_LEN] = {0x00};
    PTS(STR,i);

    for(auto I = 0;I<strlen(STR);I++)
        this->putchar(STR[I]);
}

void ostream::out(char* str)
{
    uint64_t len = strlen((char*)str);
    for(uint64_t I = 0;I<len;I++)
        this->putchar(str[I]);
}

void ostream::out(const char* str)
{
    uint64_t len = strlen(str);
    for(uint64_t I = 0;I<len;I++)
        this->putchar(str[I]);    
}

void ostream::out(char c)
{
    this->putchar(c);
}

void ostream::out(bool b)
{
    if(b)
        this->out("true");
    else
        this->out("false");
}

void ostream::out(time::timestamp ts)
{
    ostream ko = *(this);
    time::writeTime(ko,time::format::yyyy_mm_dd_hh_ii_ss,ts);
}

ostream operator<<(ostream ko,const char * arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko,      char * arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko,      char   arg){ko.out(arg);return ko;}

ostream operator<<(ostream ko, uint64_t arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, uint32_t arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, uint16_t arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, uint8_t  arg){ko.out(arg);return ko;}

ostream operator<<(ostream ko, int64_t arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, int32_t arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, int16_t arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, int8_t  arg){ko.out(arg);return ko;}

ostream operator<<(ostream ko, bool             arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, time ::timestamp arg){ko.out(arg);return ko;}

ostream operator<<(ostream ko, HEX64 arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, HEX32 arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, HEX16 arg){ko.out(arg);return ko;}
ostream operator<<(ostream ko, HEX8  arg){ko.out(arg);return ko;}
