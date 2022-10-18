#pragma once
#include "master.h"

u64* MLOGIC = (u64*)MLOGIC_RESERVED_MEMORY_START;//max elements: 24010

void memError();
void memcpy(void* src,void* dst,u64 bytes);
void memmove(void* src,void* dst,u64 bytes);
void memzero(void* t,u64 bytes);
void* malloc(u64 bytes);
void free(void* ptr);
void memAllowAccess(void* ptr, u64 procID);