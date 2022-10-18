#pragma once

#include "fixedInt.h"

//
// video memory
//
#define VMS     0xB8000         //video memory start
#define VPSIZE  0xFA0           //size per display page
#define VPC     0x8             //amount of display pages
#define VMSIZE  VPC*VPSIZE      //size of video memory
#define VME     VMS+VMSIZE      //End of video memory

#define MLOGIC_ALIST_ENTRIES 8000

#define BIOS_RESERVED_MEMORY_END                                                 0x00000000000FFFFF //BIOS reserved memory
#define VIDEO_MEMORY_START                                                       0x00000000000B8000 //video memory
#define VIDEO_MEMORY_END                                                         0x00000000000BFD00
#define MEMORY_START                                                             0x0000000000100000 //start of system memory (i know im wastin 500ish KB of memory here but using those would slow everthing else down)
#define MLOGIC_RESERVED_MEMORY_START        MEMORY_START                        +0x0000000000000000 //reserved for memory logic
#define MLOGIC_RESERVED_MEMORY_END          MLOGIC_RESERVED_MEMORY_START        +0x0000000000177280
#define THREAD_LOGIC_RESERVED_MEMORS_START  MLOGIC_RESERVED_MEMORY_END          +0x0000000000000000 //reserved for threading logic
#define THREAD_LOGIC_RESERVED_MEMORY_END    THREAD_LOGIC_RESERVED_MEMORS_START  +0x0000000000000200 
#define STL_RESERVED_MEMORY_START           THREAD_LOGIC_RESERVED_MEMORY_END    +0x0000000000000000 //reserved for STL logic
#define STL_RESERVED_MEMORY_END             STL_RESERVED_MEMORY_START           +0x00000000000FA000 
#define MRESERVED_MEMORY_START              STL_RESERVED_MEMORY_END             +0x0000000000000000 //reserved for misc logic
#define MRESERVED_MEMORY_END                MRESERVED_MEMORY_START              +0x00000000001F4000
#define FREE_MEMORY_START                   MRESERVED_MEMORY_END                +0x0000000000000000 //start of free memory
//FMS:                                                                           0x0000000000565480

u64 MEM_START = FREE_MEMORY_START;