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

NORETURN void bootstrap2()
{
    //lterm->clear();
    printINFO("terminal still working?");
    printOK();

    const char str[INTTS_SIZE];
    INTTS(getIDTaddr(),16,str);
    printINFO("IDT addr: 0x");
    lterm->write(str);
    lterm->write('\n');

    INTTS(getGDTaddr(),16,str);
    printINFO("GDT addr: 0x");
    lterm->write(str);
    lterm->write('\n');

    dumpIDT();

    setR15(0x10);
    isTestInterrupt = 1;
    //syscall();
    //interrupt(0x80);

    isTestInterrupt = 0;
    setR15(0x11);

    //testInterrupts();

    //not supposed to reach this code
    printERROR("fuck...");
    sysfreeze();
}

NORETURN void bootstrap()
{
    terminal term(geos::video::screenWidth,geos::video::screenHeight);
    term.setFrameBufferAddr(geos::video::framebuffer);
    lterm = &term;
    term.rainbowText = 0;
    //term.textColor = rainbowColors[0];
    //term.textColor = 0x00FFFFFF;

    // print welcome
    const char* welcome = "Gaming Evolved Operating System (GEOS) loading...\n";
    term.write(welcome);

    //print version
    printINFO("GEOS version: ");
    term.write(GEOS_VERSION);
    term.write('\n');

    printINFO("GEOS build: ");
    const char gBuild[INTTS_SIZE];
    INTTS((unsigned long)&__BUILD_NUMBER,10,gBuild);
    term.write(gBuild);
    term.write('\n');

    printINFO("GEOS build date: ");
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

    //setup machine
    setupPaging();

    //setup GDT before testing interrupts otherwise triple fault
    setupGDT();
    setupIDT();

    bootstrap2();

    //not supposed to reach this code
    printERROR("bootstrap2 call failed, function returned!");
    sysfreeze();
}