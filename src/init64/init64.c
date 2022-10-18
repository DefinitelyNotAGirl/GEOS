#include "master.h"
#include "CPU.c"

extern void detectCPUID();

void exit()
{
    __asm__("hlt");
}

void init64()
{
    detectCPUID();
    
    i8* STLM = "long mode available";
    printline(STLM,strSize(STLM));
}

void ERROR_NOCPUID()
{
    Color = 0x04;
    i8* error = "ERROR: CPUID not available";
    printline(error,strSize(error));
    exit();
}

void ERROR_NOLONGMODE()
{
    Color = 0x04;
    i8* error = "ERROR: long mode not available";
    printline(error,strSize(error));
    exit();
}

void _main()
{
    clearVMem();

    i8* welcome2 = "TETRIS TIME";
    printline(welcome2,strSize(welcome2));

    i8* cpuV = "CPU vendor: ";
    i8* CPUvendor = (i8*)get_vendor();
    print(cpuV,strSize(cpuV));
    printline(CPUvendor,12);

    init64();
}
