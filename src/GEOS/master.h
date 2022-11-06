/**
 * Created Date: Sunday November 6th 2022
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Sunday November 6th 2022 12:07:56 pm
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

//###############################################//
//###############################################//
//################### headers ###################//
//###############################################//
//###############################################//

//get globals
#include "headers/std.h"
#include "headers/fixedInt.h"
#include "headers/global.h"
#include "headers/GEOS_META.h"
#include "headers/macros.h"

//stdlibc++
#include <itoa.cpp>

//hardware
#include "headers/hardware/CPU.h"
#include "headers/hardware/GPU.h"
#include "headers/hardware/drive.h"
#include "headers/hardware/computer.h"

//interrupts
#include "headers/interrupts/ISR.h"

//data manipulation
#include "headers/bits.h"

//display
#include "headers/video.hpp"
#include "headers/terminal.h"

//misc headers
#include "headers/load.h"
#include "headers/ERROR.h"

//######################################################//
//######################################################//
//################### implementation ###################//
//######################################################//
//######################################################//

//main source
#include "main.cpp"
#include "src/bootstrap.cpp"
#include "src/load.cpp"

//hardware

//interrupts
#include "src/interrupts/defaultInterruptHandler.cpp"
#include "src/interrupts/GPFault.cpp"
#include "src/interrupts/IDT.cpp"
#include "src/interrupts/syscall.cpp"

//data manipulation
#include "src/bits.cpp"
#include "src/mem.cpp"

//display
#include "src/sysout.cpp"
#include "src/terminal.cpp"

//misc source
#include "src/util.cpp"
#include "src/GDT.cpp"
