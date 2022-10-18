#include "master.h"

//screen: 80x25
//mem: 160x50

i8* FIXEDPRINT_0x = "0x";
i8* FIXEDPRINT_0b = "0b";

void print_newline()
{
    u8 lines = ((u8)(outPosition/160))+1;
    if(outPosition>=160*50)
    {
        clearPage();
        outPosition=0;
        return;
    }
    outPosition=lines*160;
}

void print_char(i8 c)
{
    vga[outPosition] = c;
    vga[outPosition+1] = Color;
    outPosition+=2;
}

void print(i8* str,u64 bytes)
{
    for(u64 I = 0;I<bytes;I++)
        print_char(str[I]);
}

void printline(i8* str, u64 bytes)
{
    print(str,bytes);
    print_newline();
}

u64 strSize(i8* str)
{
    int I = 0;
    while(str[I++] != 0x0);
    return I;
}

/**
 * C++ version 0.4 char* style "itoa":
 * Written by Lukás Chmela
 * Released under GPLv3.
 */
char* ITS(i64 value, char* result, int base) 
{
    // check that the base is valid
    if (base < 2 || base > 36) { *result = '\0'; return result; }

    char* ptr = result, *ptr1 = result, tmp_char;
    int tmp_value;

    do {
        tmp_value = value;
        value /= base;
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
    } while ( value );

    // Apply negative sign
    if (tmp_value < 0) *ptr++ = '-';
    *ptr-- = '\0';
    while(ptr1 < ptr) {
        tmp_char = *ptr;
        *ptr--= *ptr1;
        *ptr1++ = tmp_char;
    }
    return result;
}

void printMemAddress(void* addr)
{
    i64 wAddr = addr;
    i8* wAddrStr;
    wAddrStr = ITS(wAddr,wAddrStr,16);
    print(FIXEDPRINT_0x,2);
    printline(wAddrStr,strSize(wAddrStr));
}

void printNumber(i64 n,short base)
{
    i8* wAddrStr;
    wAddrStr = ITS(n,wAddrStr,base);
    if(base == 16)
        print(FIXEDPRINT_0x,2);
    else if(base == 2)
        print(FIXEDPRINT_0b,2);
    printline(wAddrStr,strSize(wAddrStr));
}
