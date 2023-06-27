/**
 * Author: DefinitelyNotAGirl@github
 * -----
 * Copyright (c) 2023 DefinitelyNotAGirl@github
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#include <Uefi.h>

#include <main.h>

EFI_SYSTEM_TABLE* sysTable;

EFI_STATUS status = 0;

EFI_STATUS print(uint16_t* msg)
{
    return sysTable->ConOut->OutputString(sysTable->ConOut,msg);
}

EFI_STATUS print(const char16_t* msg)
{
    return sysTable->ConOut->OutputString(sysTable->ConOut,(UINT16*)msg);
}

static void* memMap;
static void* EFImemmap;

void meminit()
{
}

uint64_t strlen(char* str){uint64_t counter = 0;while(*(str++)!=0)counter++;return counter;}

uint64_t malloc(uint64_t size)
{
    for(uint64_t* entry = (uint64_t*)memMap; entry != 0; entry+=8)
    {
        if(*entry == MC64("GEOSFREE"))
        {
            *entry = MC64("GEOSUSED");
            return ((entry-(uint64_t*)memMap)/8*0x200000);
        }
    }
    return 0;
}

static const char* HEXDIG = "0123456789abcdef";

void printHex64(uint64_t value)
{
    uint16_t data[19];
    data[18] = 0x0000;
    ((uint32_t*)data)[0] = 0x00780030;// '0x'
    for(uint8_t I = 17;I>1;I--)
    {
        data[I] = HEXDIG[value&0xF];
        value>>=4;
    }
    print(data);
}

void print64(uint64_t value)
{
    uint64_t i = 0;
    while(i < 8)
    {
        uint32_t v = ((uint8_t*)&value)[i++] | 0b11111111111111110000000000000000;
        print((uint16_t*)(&v));
    }
}
void print32(uint32_t value)
{
    uint64_t i = 0;
    while(i < 4)
    {
        uint32_t v = ((uint8_t*)&value)[i++] | 0b11111111111111110000000000000000;
        print((uint16_t*)(&v));
    }
}

void print64r(uint64_t value)
{
    uint64_t i = 7;
    while(i >= 0 && i != 0xFFFFFFFFFFFFFFFF)
    {
        uint32_t v = ((uint8_t*)&value)[i--] | 0b11111111111111110000000000000000;
        print((uint16_t*)(&v));
    }
}
void print32r(uint32_t value)
{
    uint64_t i = 3;
    while(i >= 0 && i != 0xFFFFFFFFFFFFFFFF)
    {
        uint32_t v = ((uint8_t*)&value)[i--] | 0b11111111111111110000000000000000;
        print((uint16_t*)(&v));
    }
}

bool operator==(GUID& a, GUID& b)
{
    if(((uint64_t*)(&a))[0] != ((uint64_t*)(&b))[0])
        return false;
    if(((uint64_t*)(&a))[1] != ((uint64_t*)(&b))[1])
        return false;
    return true;
}

void listConfigTable()
{
    // EFI_CONFIGURATION_TABLE is 24 bytes long
    //  +0: VendorGUID (0-63)
    //  +8: VendorGUID (64-127)
    // +16: address of table data
    EFI_CONFIGURATION_TABLE* efiConfigTable = sysTable->ConfigurationTable;
    uint64_t entries = sysTable->NumberOfTableEntries;

    //read data
    for(uint64_t i = 0; i < entries; i++)
    {
        if(efiConfigTable[i].VendorGuid == GUID_ACPI){print(u"ACPI");econf.ACPI = efiConfigTable[i].VendorTable;}
        else if(efiConfigTable[i].VendorGuid == GUID_SAL_SYSTEM){print(u"SAL_SYSTEM");econf.SAL_SYSTEM = efiConfigTable[i].VendorTable;}
        else if(efiConfigTable[i].VendorGuid == GUID_SMBIOS){print(u"SMBIOS");econf.SMBIOS = efiConfigTable[i].VendorTable;}
        else if(efiConfigTable[i].VendorGuid == GUID_SMBIOS3){print(u"SMBIOS3");econf.SMBIOS3 = efiConfigTable[i].VendorTable;}
        else if(efiConfigTable[i].VendorGuid == GUID_MPS){print(u"MPS");econf.MPS = efiConfigTable[i].VendorTable;}
        else if(efiConfigTable[i].VendorGuid == GUID_PROPERTIES_TABLE){print(u"PROPERTIES");econf.PROPERTIES = efiConfigTable[i].VendorTable;}
        else goto LCT_skipFoundPrint;
        print(u" table found!\n\r");
        LCT_skipFoundPrint: ;
    }
}

char* strreverse(char* str)
{
    uint64_t len = strlen(str);
    uint64_t start = 0;
    uint64_t end = len-1;
    while(start < end)
    {
        str[start] ^= str[end];
        str[end] ^= str[start];
        str[start] ^= str[end];

        start++;
        end--;
    }
    return str;
}

EFI_STATUS main(EFI_HANDLE imageHandle,EFI_SYSTEM_TABLE* systemTable)
{
    sysTable = systemTable;
    UINT16* msg = (UINT16*)u"Hello World!\n\r";

    systemTable->ConOut->ClearScreen(systemTable->ConOut);
	systemTable->ConOut->OutputString(systemTable->ConOut, msg);

    print64(MC64("GEOSTEST"));
    print(u"\n\r");
    listConfigTable();

    readACPI();

    while(1);
    return EFI_SUCCESS;//we could return to the firmware but we won't, just hang up instead
}