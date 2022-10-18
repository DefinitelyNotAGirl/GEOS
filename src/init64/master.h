#pragma once

#include "pre.h"

u8 main();
u8* vga = (u8*)(VMS);

//get headers
#include "bool.h"
#include "util.h"
#include "video.h"
#include "print.h"
#include "mem.h"
//#include "error.h"

//get implementation
#include "video.c"
#include "print.c"
#include "util.c"
#include "mem.c"
//#include "error.c"
