#pragma once

// fixed width integer types
typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef char i8;
typedef short i16;
typedef int i32;
typedef u32 size_t;
//typedef u32 uintptr_t;
typedef float f32;

#ifdef GEOS_32bit
    typedef u32 u64;
    typedef i32 i64;
    typedef f32 f64;
#else
    typedef unsigned long long u64;
    typedef long long i64;
    typedef double f64;
#endif
