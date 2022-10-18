#include "bitmanipulation.h"

void setBit(u8* array,u64 bit,bool value)
{
    u64 n = bit/8;
    u64 k = bit-(8*n);
    array[n] ^= (-value ^ array[n]) & (1UL << k);
}

bool getBit(u8* array,u64 bit)
{
    u64 n = bit/8;
    u64 k = bit-(8*n);
    return (array[n] & (1 << k)) >> k;
}