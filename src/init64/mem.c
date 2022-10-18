#pragma once
#include "mem.h"

void memcpy(void* src, void* dst, u64 bytes)
{
    char* d = (char*)(dst);
    char* s = (char*)(src);

    for(u64 I = 0;I<bytes;I++)
        d[I] = s[I];
}

void memmove(void* src, void* dst, u64 bytes)
{
    memcpy(src,dst,bytes);
    memzero(src,bytes);
}

void memzero(void* t,u64 bytes)
{
    char* dst = (char*)(t);
    for(u64 I = 0;I<bytes;I++)
        dst[I] = 0x00;
}
