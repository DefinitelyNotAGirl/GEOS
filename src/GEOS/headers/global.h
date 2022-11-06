/**
 * Created Date: Monday October 31st 2022
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Monday October 31st 2022 3:16:23 pm
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

#define INTTS_SIZE 30
#define NORETURN [[noreturn]]

void printINFO(const char* str);
void printWARNING(const char* str);
void printERROR(const char* str);
void printOK();
void printFAILED();

void dumpIDT();
void setupIDT();
void setupPaging();
void setupGDT();
extern "C" uint64_t getIDTaddr();
extern "C" uint64_t getGDTaddr();
extern "C" void loadIDT();
extern "C" void loadGDT();
extern "C" void setR15(uint64_t value);

void INTTS(int64_t value,int base,char* result);

#include "../../bootboot.h"
#include "../../defaultGEOSfont.h"
extern BOOTBOOT bootboot;               // see bootboot.h
