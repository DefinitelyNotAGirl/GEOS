#include "master.h"

void clearPage()
{
    for(int I = 0;I<VPSIZE;I++)
        vga[I] = 0x0000;
}

void clearVMem()
{
    vga = VMS;
    for(int I = 0;I<VMSIZE;I++)
        vga[I] = 0x0000;
    vga=VMS+VPSIZE*page;
}