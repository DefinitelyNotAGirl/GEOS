;
; Created Date: Friday November 25th 2022
; Author: DefinitelyNotAGirl@github
; -----
; Last Modified: Friday November 25th 2022 4:16:03 pm
; Modified By: DefinitelyNotAGirl@github (definitelynotagirl115199@gmail.com)
; -----
; Copyright (c) 2022 DefinitelyNotAGirl@github
; 
; Permission is hereby granted, free of charge, to any person
; obtaining a copy of this software and associated documentation
; files (the "Software"), to deal in the Software without
; restriction, including without limitation the rights to use, copy,
; modify, merge, publish, distribute, sublicense, and/or sell copies
; of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be
; included in all copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
; DEALINGS IN THE SOFTWARE.
;
extern stage3
global _start
global exit
global detectMemory
_start:
    ;reset stack
    mov esp, 0x0000FFEF
    mov ebp, 0x00000000

    mov eax, 0x10
    mov es, eax;reset ES, former screen segment
    mov fs, eax;
    mov gs, eax;
    xor eax, eax

    push dword 0xB8000
    push edi
    call stage3

    cli
    hlt

disableProtMode:
    mov eax, cr0
    and eax, 0b01111111111111111111111111111111; clear PE bit
    mov cr0, eax
    ret
enableProtMode:
    mov eax, cr0
    or eax, 1; set PE bit
    mov cr0, eax
    ret

exit:
    cli
    hlt
