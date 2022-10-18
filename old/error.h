#pragma once
#include "master.h"

u64* errorHandlers = (u64*)MRESERVED_MEMORY_START;//0-15
//error handler map
//0: unkown error
//1: memory error
//2: disk error
//3: network error
//4: reserved for dynamic use by STL
//5: reserved for dynamic use by STL
//6: reserved for dynamic use by STL
//7: reserved for dynamic use by STL
//8: unused
//9: unused
//10: unused
//11: unused
//12: unused
//13: unused
//14: unused
//15: unused
u64* errorInfo = (u64*)MRESERVED_MEMORY_START+(16*8);//0-15
// error info map
//0: error handler ID

void error();
void setErrHandler(u8 i, u64 addr);
void setErrInfo(u8 i, u64 value);