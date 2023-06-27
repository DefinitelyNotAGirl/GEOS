/*
 * Created Date: Thursday May 25th 2023
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Friday May 26th 2023 10:25:16 pm
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

.global init
.extern initiate
.extern diskdriverinit

 /* Declare constants for the multiboot header. */
.set ALIGN,    1<<0             /* align loaded modules on page boundaries */
.set MEMINFO,  1<<1             /* provide memory map */
.set FLAGS,    ALIGN | MEMINFO  /* this is the Multiboot 'flag' field */
.set MAGIC,    0x1BADB002       /* 'magic number' lets bootloader find the header */
.set CHECKSUM, -(MAGIC + FLAGS) /* checksum of above, to prove we are multiboot */

.text
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.data
gdt64:
    .quad 0
.kCode:
    .word 0xFFFF # limit
    .word 0x0000 # base
    .byte 0x00   # base
    .byte 0x9A   # access byte
    .byte 0xFA   # flags & limit
    .byte 0x00   # base
.kData:
    .word 0xFFFF # limit
    .word 0x0000 # base
    .byte 0x00   # base
    .byte 0x92   # access byte
    .byte 0xFC   # flags & limit
    .byte 0x00   # base
gdt64_pointer:
    .word gdt64_pointer - gdt64
    .quad gdt64


.code32
.text

# ebx: virt addr
# ecx: page table base phys addr
# return in edx
getPAGEENTRYADDR:
    #pro
    pushl %eax
    xor %edx, %edx
    xor %esi, %esi

    #main
    movl %ebx, %eax
    cmp %eax, %esi
    je .GPEA_NDZ
    mov $0x200000, %esi
    divl %esi # eax is now page number
    imull $8, %eax # eax is now offset to entry from PD base
    .GPEA_NDZ:
    movl %eax, %edx
    addl %ecx, %edx
    mov $0x2000, %esi
    addl %esi, %edx

    #epi
    popl %eax
    ret

# eax: phys addr
# ebx: virt addr
# ecx: page table base phys addr
genPAGEENTRY_RWDATA:
    call getPAGEENTRYADDR

    xor %edi, %edi # bits 0-31 in eax and 32-63 in edi0

    and $0b11111111111111111111111010010111, %eax # clear required bits

    or $0b10010111, %eax # set required bits
    or $0b10000000000000000000000000000000, %edi # set NoExecute bit

    movl %eax, (%edx)
    mov $4, %esi
    addl %esi, %edx
    movl %edi, (%edx)

    ret

# eax: phys addr
# ebx: virt addr
# ecx: page table base phys addr
genPAGEENTRY_CODE:
    call getPAGEENTRYADDR

    xor %edi, %edi # bits 0-31 in eax and 32-63 in edi

    or $0b00000000000000000000000010010101, %eax # set required bits
    and $0b11111111111111111111111010010111, %eax # clear required bits

    movl %eax, (%edx)
    mov $4, %esi
    addl %esi, %edx
    movl %edi, (%edx)

    ret

# eax: phys addr
# ebx: virt addr
# ecx: page table base phys addr
genPAGEENTRY_RODATA:
    call getPAGEENTRYADDR

    xor %edi, %edi # bits 0-31 in eax and 32-63 in edi0

    and $0b11111111111111111111111010010111, %eax # clear required bits

    or $0b10010101, %eax # set required bits
    or $0b10000000000000000000000000000000, %edi # set NoExecute bit

    movl %eax, (%edx)
    mov $4, %esi
    addl %esi, %edx
    movl %edi, (%edx)

    ret

# ecx: page table base phys addr
genPML4T:
    xor %eax, %eax
    xor %edx, %edx
    xor %ebx, %ebx
    xor %edi, %edi

    #
    # write the one entry we need
    #
    movl $0x2400000, %eax # address of PDP[0]
    # write entry data to ebx and edi
    movl %ecx, %ebx
    mov $0x1000, %esi
    addl %esi, %ebx # 512*8*2 (8KiB)
    or $0b10111, %ebx

    # write entry to table
    movl %ebx, (%eax)
    mov $4, %esi
    addl %esi, %eax
    movl %edi, (%eax)

    ret

# ecx: page table base phys addr
genPDP:
    xor %eax, %eax
    xor %edx, %edx
    xor %ebx, %ebx
    xor %edi, %edi

    #
    # write the one entry we need
    #
    movl $0x2401000, %eax # address of PDP[0]
    # write entry data to ebx and edi
    movl %ecx, %ebx
    mov $0x2000, %esi
    addl %esi, %ebx # 512*8*2 (8KiB)
    or $0b10111, %ebx

    # write entry to table
    movl %ebx, (%eax)
    mov $4, %esi
    addl %esi, %eax
    movl %edi, (%eax)

    ret

genPAGETABLE:
    movl $0x2400000, %ecx
    # initiate page table structure
    call genPML4T
    call genPDP

    # start setting pages

    #reserved bios memory (set ROD for now)
    movl $0x00000000, %eax
    movl $0x00000000, %ebx
    call genPAGEENTRY_RWDATA

    #MISC Data
    movl $0x200000, %eax
    movl $0x200000, %ebx
    call genPAGEENTRY_RWDATA

    #Stack
    movl $0x400000, %eax
    movl $0x400000, %ebx
    call genPAGEENTRY_RWDATA

    #bootInfo
    movl $0x600000, %eax
    movl $0x600000, %ebx
    call genPAGEENTRY_RWDATA

    #INIT module
    movl $0x800000, %eax
    movl $0x800000, %ebx
    call genPAGEENTRY_CODE
    movl $0xA00000, %eax
    movl $0xA00000, %ebx
    call genPAGEENTRY_RWDATA
    movl $0xC00000, %eax
    movl $0xC00000, %ebx
    call genPAGEENTRY_RODATA
    movl $0xE00000, %eax
    movl $0xE00000, %ebx
    call genPAGEENTRY_RWDATA

    #PRIME PAGE TABLE
    movl $0x2400000, %eax
    movl $0x2400000, %ebx
    call genPAGEENTRY_RWDATA

    #GDT/IDT for later
    movl $0x4400000, %eax
    movl $0x4400000, %ebx
    call genPAGEENTRY_RWDATA

    ret

ismb1:
    pushl $1
    jmp init_b1

notmb2:
    movl $0x2BADB002, %esi
    cmp %eax, %esi
    je ismb1
    int $0xFF

init:
    movl $0x5FFFFF, %esp
    movl $0x5FFFFF, %ebp
    pushl %ebx # push mutliboot info address

    movl $0x36d76289, %esi
    cmp %eax, %esi
    jne notmb2
    pushl $2
init_b1:

    call genPAGETABLE

    #load gdt
    lgdt [gdt64_pointer]

    #
    #enable long mode
    # 

    #set cr4.PAE (bit 5)
    mov %cr4, %eax
    or $0b100000, %eax
    mov %eax, %cr4

    #load cr3
    mov $0x2400000, %eax
    mov %eax, %cr3

    #set EFER.LME
    mov $0xC0000080, %ecx # EFER MSR selector.
    rdmsr # read from EFER
    or $0b100000000, %eax # set EFER.LME (bit 8)
    wrmsr # write to EFER

    #set cr0.PG (bit 31)
    mov %cr0, %eax
    or $0b10000000000000000000000000000000, %eax
    mov %eax, %cr0

    xor %edi, %edi
    pop %esi # pass the multiboot version to initiate
    pop %edi # pass the previously pushed mutlibootInfo address to initiate

    jmp $0x08,$init64

    int $0xFB

.code64

.global DBG_EXIT

.text
init64:
    //load segment registers
    mov $0x10, %rax
    mov %rax, %es
    mov %rax, %ss
    mov %rax, %ds
    mov %rax, %fs
    mov %rax, %gs

    //reset stack
    movq $0x5FFFFF, %rsp
    movq $0x5FFFFF, %rbp

    call initiate

DBG_EXIT:
    movq %rdi, %r15
    int $0x99
    ret

.global loadIDT
loadIDT:
    LIDT (%rdi)
