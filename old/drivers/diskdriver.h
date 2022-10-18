#pragma once
#include "../master.h"

#define DISK_UNKNOWN 0x00
#define DISK_ATA    0x01
#define DISK_ATAPI  0x02
#define DISK_SATA   0x03
#define DISK_SCSI   0x04
#define DISK_USBFM  0x05
#define DISK_SSD    0x06

u8 diskCounter = 1;
u64* diskSize;
u8* diskType;

u8 diskGetByte(u64 addr);
void diskRead(u64 start,u64 len,void* dst);