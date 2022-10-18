.code32
.section .text.prologue

.global _start
_start:
    call _main
    hlt

.intel_syntax noprefix
.global detectCPUID
detectCPUID:
    # copy FLAGS in to eax via stack
    pushfd
    pop eax

    # copy to ecx for later
    mov ecx, eax

    # flip ID bit
    xor eax, 1 << 21

    # copy eax to flags via stack
    push eax
    popfd

    # Compare EAX and ECX. if they are equal trhen that means the bit wanst flipped, no CPUID
    xor eax, ecx
    jz NoCPUID
    call check64
    ret
.att_syntax

NoCPUID:
    call ERROR_NOCPUID

NoLongMode:
    call ERROR_NOLONGMODE

check64:
    mov %eax, 0x80000000
    cpuid
    cmp %eax, 0x80000001 # compare eax to 0x80000001
    jb NoLongMode
    
    mov %eax, 0x80000001
    cpuid
    test %edx, 1 << 29
    jz NoLongMode
    call enableLongMode
    ret

enableLongMode:
    ret
