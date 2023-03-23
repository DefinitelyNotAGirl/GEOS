/**
 * Created Date: Monday February 20th 2023
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Monday February 20th 2023 4:09:13 am
 * Modified By: DefinitelyNotAGirl@github (definitelynotagirl115199@gmail.com)
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

#define KILO 1000
#define MEGA 1000000
#define GIGA 1000000000
#define TERA 1000000000000
#define PETA 1000000000000000

//cstdint
typedef signed      char            int8_t;
typedef unsigned    char            uint8_t;

typedef short       int             int16_t;
typedef unsigned    short int       uint16_t;

typedef signed      int             int32_t;
typedef unsigned    int             uint32_t;

typedef signed      long long       int64_t;
typedef unsigned    long long       uint64_t;

//integers
typedef int8_t i8;
typedef uint8_t u8;
typedef int16_t i16;
typedef uint16_t u16;
typedef int32_t i32;
typedef uint32_t u32;
typedef int64_t i64;
typedef uint64_t u64;

//floating point types
typedef float f32;
typedef double f64;

//misc
typedef u8 byte;
typedef u64 ptr64;
typedef u32 ptr32;
typedef u16 ptr16;

//word types
typedef uint64_t quadword;
typedef uint32_t doubleword;
typedef uint16_t word;

typedef quadword qword;
typedef doubleword dword;


