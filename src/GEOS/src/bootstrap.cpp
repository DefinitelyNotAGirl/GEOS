/**
 * Created Date: Friday November 4th 2022
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Friday November 4th 2022 1:19:50 pm
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

void putchar(char c)
{
    lterm->write(c);
}

NORETURN void bootstrap(uint32_t coreID)
{
    endl = '\n';
    terminal term(geos::video::screenWidth,geos::video::screenHeight);
    term.setFrameBufferAddr(geos::video::framebuffer);
    term.clear();
    lterm = &term;
    term.rainbowText = 0;
    out.putchar = putchar;
    //term.textColor = rainbowColors[0];
    //term.textColor = 0x00FFFFFF;

    // print welcome
    const char* welcome = "Gaming Evolved Operating System (GEOS) loading...";
    out << welcome << endl;

    //print version
    out << "GEOS version: " << GEOS_VERSION << endl;
    out << "GEOS build: " << __BUILD_NUMBER << endl;
    out << "GEOS build date: ";
    char gBuildDate[INTTS_SIZE];
    INTTS((unsigned long)&__BUILD_DATE,10,gBuildDate);
    //format time as yyyy/mm/dd
    char* gbdYear = gBuildDate;
    char* gbdMonth = gBuildDate+4;
    char* gbdDay = gBuildDate+6;
    term.write(gbdDay,2);
    term.write(".");
    term.write(gbdMonth,2);
    term.write(".");
    term.write(gbdYear,4);
    term.write('\n');

    out << "BOOTBOOT loader level: " << bootboot.protocol << endl;

    //print core id
    out << "current core ID: " << coreID << endl;

    controlRegisters::readAll();
    //setupPaging();

    //setupGDT();
    setupIDT();

    //fetch machine information
    //cpu
    computer.cpu.cpuid.update();
    computer.cpu.coreCount = bootboot.numcores;
    //memory
    detectMemory();
    //sysfreeze();

    computer.print();

    //setup time
    time::init();
    out << "time: ";
    time::writeTime(out,time::format::yyyy_mm_dd_hh_ii_ss);

    //setup APIC 
    init_apic();

    //not supposed to reach this code
    out << "fuck..." << endl;
    sysfreeze();
}
