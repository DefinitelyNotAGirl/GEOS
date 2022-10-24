#include "std.h"

/* Check if the compiler thinks you are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

#include "print.cpp"

void geos_main()
{
    TMinit();
    
    char* welcome = "Gaming Evolved Operating System (GEOS) loading...";
    printStr(welcome);
}