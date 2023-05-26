/*
 * Created Date: Thursday May 25th 2023
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Thursday May 25th 2023 11:47:32 pm
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

section .data
idt64:
    times 512 dq 0;write idt full of 0's
.pointer:
    dw .pointer - idt64
    dq idt64

gdt64:
    dq 0x00
.kCode: equ $ - gdt64
    dq (1<<21) | (0<<22) | (1<<44) | (1<<47) | (1<<41) | (1<<43) | (1<<53)
.kData: equ $ - gdt64
    dq (1<<44) | (1<<47) | (1<<41)
.pointer:
    dw .pointer - gdt64
    dq gdt64


.bits 32
.text

# rax: phys addr
# rbx: virt addr
# rcx: page table base phys addr
# rdx: page number
genPAGEENTRY_RWDATA:

# rax: phys addr
# rbx: virt addr
# rcx: page table base phys addr
# rdx: page number
genPAGEENTRY_CODE:

# rax: phys addr
# rbx: virt addr
# rcx: page table base phys addr
# rdx: page number
genPAGEENTRY_RODATA:

genPAGETABLE:
    # initiate page table structure

    # start setting pages
    movl $0x2400000, %rcx
    movl $0, %rdx

init:
    movl $0x400000, %esp
    movl $0x400000, %ebp

    call genPAGETABLE
