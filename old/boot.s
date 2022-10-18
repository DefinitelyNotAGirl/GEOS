.code16
.org 0

.text

.global _start
_start:
    /* segment setup */
    mov %cs, %ax
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss

    # place stack pointer in middle of free memory area
    movw $0x3000, %sp

    # save drive number to read kernel later 
    mov %dl, drive_num

    # initiate GDT
    call debugPrint
    call setGDT
    call debugPrint
    call reloadSegments
    call debugPrint
    hlt
    
    # enable A20 line
    call enableA20Line
    call debugPrint

    # read kernel
    call readKernel
.kernelReadContinue:
    call debugPrint

    # enable prot mode
    call enableProtMode

    # this should never be executed
    call debugPrint
    hlt

#
#
# read kernel into memory
#
#
/*  read kernel into memory at 0x10000 (segment 0x1000)
        kernel binary has been placed on the disk directly after the first sector
        reading $20 * num_sectors after (value in %cx)
    */
readKernel:
    movw $20, %cx
    movb drive_num, %dl
    movw $disk_packet, %si
    movw $0x1000, segment
    movw $1, sector

sector_loop:
    movb $0x42, %ah
    int $0x13
    jc disk_error

    addw $64, sector
    addw $0x8000, offset
    jnc sector_same_segment

    /* increment segment, reset offset if on different segment */
    addw $0x1000, segment
    movw $0x0000, offset
sector_same_segment:
    /* drecrements %cx and loops if nonzero */
    loop sector_loop

    jmp $0x00, $.kernelReadContinue

_loop:
    jmp _loop

#
#
# switch to protected mode
#
#
enableProtMode:
    cli
    mov %eax, %cr0
    or %al, 1
    mov %cr0, %eax
    
    jmp $0x00, $entry32

.code32
#
#
# protected mode (jump to kernel)
#
#
entry32:
    movl $0x10000, %eax
    jmpl *%eax

.code16
#
#
# A20 line
#
#
enableA20Line:
    cli

    /* read and save state */
    call enable_a20_wait0
    movb $0xD0, %al
    outb $0x64
    call enable_a20_wait1
    xorw %ax, %ax
    inb $0x60

    /* write new state with A20 bit set (0x2) */
    pushw %ax
    call enable_a20_wait0
    movb $0xD1, %al
    outb $0x64
    call enable_a20_wait0
    popw %ax
    orw $0x2, %ax
    outb $0x60

enable_a20_wait0:
    xorw %ax, %ax
    inb $0x64
    btw $1, %ax
    jc enable_a20_wait0
    ret

enable_a20_wait1:
    xorw %ax, %ax
    inb $0x64
    btw $0, %ax
    jnc enable_a20_wait1
    ret

#
#
# GDT stuff
#
#
setGDT: 
    xor %eax, %eax
    mov %ax, %ds
    # shl %eax, 0x04
    add %eax, gdt_start
    mov [gdt_start + 2], %eax
    mov %eax, gdt_end
    sub %eax, gdt_start
    mov gdt_start, %ax
    lgdt gdt_start
    ret

reloadSegments:
    # reload CS register containing code selector
    ljmp $0x00, $.reloadCS
.reloadCS:
    mov %ax, 0x10 # 0x10 is stand in for data segment
    mov %ds, %ax
    mov %es, %ax
    mov %fs, %ax
    mov %gs, %ax
    mov %ss, %ax
    ret

.align 16
gdt_start:
gdt_null:
    .quad 0
gdt_kernel_code_segment:
    .word 0xffff
    .word 0x0000
    .byte 0x00
    .byte 0b10011010
    .byte 0b11001111
    .byte 0x00
gdt_kernel_data_segment:
    .word 0xffff
    .word 0x0000
    .byte 0x00
    .byte 0b10010010
    .byte 0b11001111
    .byte 0x00
gdt_end:

#
#
# misc
#
#
debugPrint:
    xorb %bh, %bh
    movb $0x41, %al
    movb $0x0E, %ah
    int $0x10
    ret

disk_error_str:
    .asciz "DISK ERROR\n"

disk_error:
    movw $disk_error_str, %si
    call print

/* SAVED DRIVE NUMBER TO READ FROM */
drive_num:
    .word 0x0000

/* INT 13H PACKET */
disk_packet:
    .byte 0x10
    .byte 0x00
num_sectors:
    .word 0x0040
offset:
    .word 0x0000
segment:
    .word 0x0000
sector:
    .quad 0x00000000

print:
    xorb %bh, %bh
    movb $0x0E, %ah

    lodsb

    /* NULL check */
    cmpb $0, %al
    je 1f

    /* print %al to screen */
    int $0x10
    jmp print

1: ret
    
/* MBR BOOT SIGNATURE */
.fill 510-(.-_start), 1, 0
.word 0xAA55