#pragma once
#include "master.h"

void error()
{
    void* addr = (void*)errorHandlers[errorInfo[0]];
    goto *addr;
}

void setErrHandler(u8 i, u64 addr)
{
    errorHandlers[i] = addr;
}
void setErrInfo(u8 i, u64 value)
{
    errorInfo[i] = value;
}