#include <cpuid.h>

int* get_vendor(void)
{
    int reg[3];
    int unused;
    __cpuid(0, unused, reg[0], reg[1], reg[2]);
    return &reg;
}