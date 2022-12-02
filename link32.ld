OUTPUT_FORMAT("binary")
OUTPUT_ARCH(i386)

ENTRY(_start)
SECTIONS
{
    . = 0x10000;
    
    .text :
    {
        *(.text)
    }

    .data :
    {
        *(.data)
        *(.rodata)
    }

    .bss : 
    {
        *(.bss)
    }

    /DISCARD/ : 
    {
        *(.note*);
        *(.iplt*);
        *(.igot*);
        *(.rel*);
        *(.comment);
        *(.eh_frame);
    }
}