/*
 * Created Date: Friday May 26th 2023
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Friday May 26th 2023 9:10:11 pm
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

.intel_syntax noprefix

.global init_memcpy
.global init_memzero
.global init_memiszero

.text

# src = rdi
# dst = rsi
# bytes = rdx
# no stack setup or cleanup since we dont touch the stack
init_memcpy:
.loopmc:
    movq [rdi], rax # copy value from src to dst
    movq rax, [rsi]
    inc rdi # next src
    inc rsi # next dst
    dec rdx # dec counter

    cmp rdx, 0
    jg .loopmc
    ret

# target = rdi
# bytes = rsi
# no stack setup or cleanup since we dont touch the stack
init_memzero:
    xor rax, rax
.loopmz:
    movq rax, [rdi]  # zero out current byte
    inc rdi # next byte
    dec rsi # dec counter

    cmp rsi, 0
    jg .loopmz
    ret

# target = rdi
# bytes = rsi
init_memiszero:
    xor rax, rax
.loopmiz:
    cmp rax, [rdi]
    jne .mizRF
    dec rsi

    cmp rsi, rax
    jg .loopmiz
.mizRT:
    ret
.mizRF:
    movq rax, 1
    ret
