/*
 * Created Date: Tuesday June 27th 2023
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Tuesday June 27th 2023 2:21:49 pm
 * Modified By: DefinitelyNotAGirl@github (definitelynotagirl115169@gmail.com)
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

#include <main.h>
#include <ACPI.hxx>

static uint32_t SIG_T_APIC = 'APIC'; // Multiple APIC Description Table (MADT)
static uint32_t SIG_T_BERT = 'BERT'; // Boot Error Record Table (BERT)
static uint32_t SIG_T_CPEP = 'CPEP'; // Corrected Platform Error Polling Table (CPEP)
static uint32_t SIG_T_DSDT = 'DSDT'; // Differentiated System Description Table (DSDT)
static uint32_t SIG_T_ECDT = 'ECDT'; // Embedded Controller Boot Resources Table (ECDT)
static uint32_t SIG_T_EINJ = 'EINJ'; // Error Injection Table (EINJ)
static uint32_t SIG_T_ERST = 'ERST'; // Error Record Serialization Table (ERST)
static uint32_t SIG_T_FACP = 'FACP'; // Fixed ACPI Description Table (FADT)
static uint32_t SIG_T_FACS = 'FACS'; // Firmware ACPI Control Structure (FACS)
static uint32_t SIG_T_HEST = 'HEST'; // Hardware Error Source Table (HEST)
static uint32_t SIG_T_MSCT = 'MSCT'; // Maximum System Characteristics Table (MSCT)
static uint32_t SIG_T_MPST = 'MPST'; // Memory Power State Table (MPST)
static uint32_t SIG_T_OEMx = 'OEMx'; // OEM Specific Information Tables (Any table with a signature beginning with "OEM" falls into this definition)
static uint32_t SIG_T_PMTT = 'PMTT'; // Platform Memory Topology Table (PMTT)
static uint32_t SIG_T_PSDT = 'PSDT'; // Persistent System Description Table (PSDT)
static uint32_t SIG_T_RASF = 'RASF'; // ACPI RAS Feature Table (RASF)
static uint32_t SIG_T_RSDT = 'RSDT'; // Root System Description Table (This wiki page; included for completeness)
static uint32_t SIG_T_SBST = 'SBST'; // Smart Battery Specification Table (SBST)
static uint32_t SIG_T_SLIT = 'SLIT'; // System Locality System Information Table (SLIT)
static uint32_t SIG_T_SRAT = 'SRAT'; // System Resource Affinity Table (SRAT)
static uint32_t SIG_T_SSDT = 'SSDT'; // Secondary System Description Table (SSDT)
static uint32_t SIG_T_XSDT = 'XSDT'; // Extended System Description Table (XSDT; 64-bit version of the RSDT)

static void doCheckSum(RSDPDescriptor* rsdp)
{
    uint8_t sum = 0;
    for(uint64_t i = 0; i < sizeof(RSDPDescriptor); i++)
        sum += ((uint8_t*)(rsdp))[i];
    if(sum == 0)
        return;
    print(u"ERROR: invalid acpi checksum!");
    while(1);
}

static void readSDT(ACPISDTHeader* sdt)
{
    print(u"SDT address: ");
    printHex64((uint64_t)sdt);
    print(u"\n\r");
    print(u"signature: ");
    print32(sdt->Signature);
    print(u"\n\r--------\n\r");
}

void readACPI_r1(void* rsdp)
{
    print(u"ACPI version 1 detected!\n\r");
    doCheckSum((RSDPDescriptor*)rsdp);
    print(u"ACPI checksum valid!\n\r");

    ACPISDTHeader* rsdt = (ACPISDTHeader*)((RSDPDescriptor*)rsdp)->RsdtAddress;
    uint8_t sum = 0;
    for(uint64_t i = 0; i < rsdt->Length; i++)
        sum += ((uint8_t*)(rsdt))[i];
    if(sum != 0)
    {
        print(u"ERROR: invalid rsdt checksum!");
        while(1);
    }
    print(u"rsdt checksum valid!\n\r");

    print(u"rsdt signature: ");
    print32(rsdt->Signature);
    print(u"\n\r");
    print(u"rsdt address: ");
    printHex64((uint64_t)rsdt);
    print(u"\n\r");

    uint64_t sdtCount = (rsdt->Length - sizeof(ACPISDTHeader))/4;
    print(u"sdt count: ");
    printHex64(sdtCount);
    print(u"\n\r");
    print(u"\n\r\n\rreading SDTs...\n\r");
    uint64_t data = (uint64_t)(rsdt+sizeof(ACPISDTHeader));
    for(uint64_t i = 0; i < sdtCount; i++)
    {
        ACPISDTHeader* sdt = (ACPISDTHeader*)readP32(data);
        readSDT(sdt);
        data+=4;
    }
}