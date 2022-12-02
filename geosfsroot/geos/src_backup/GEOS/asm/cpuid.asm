;
; Created Date: Wednesday November 9th 2022
; Author: DefinitelyNotAGirl@github
; -----
; Last Modified: Wednesday November 9th 2022 11:32:05 pm
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

global __cpuid__
global getCPUFeatures

section .text
; uint64_t getCPUFeatures(void)
getCPUFeatures:
    mov rax, 0x01; cpuid arg
    mov rcx, 0x00; zero out rcx in case it is unused by cpuid
    cpuid
    mov rax,rdx
    shl rax, 32
    shrd rax,rcx,32
    ret

; void __cpuid__(uint64_t func)
__cpuid__:
    mov rax, [rsp+8]
    cpuid
    ret
