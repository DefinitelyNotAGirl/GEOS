#pragma once

u8 Color = 0x0F;
u16 outPosition = 0x0000;
void print_newline();
void print_char(i8 c);
void print(i8* str,u64 bytes);
void printline(i8* str, u64 bytes);
u64 strSize(i8* str);

char* ITS(i64 value, char* result, int base);
void ITHS(u64 n);