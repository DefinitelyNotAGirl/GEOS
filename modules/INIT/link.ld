OUTPUT_FORMAT("binary")

ENTRY(init)
SECTIONS
{
    . = 0x800000;
    
    .text :
    {
        *(.text)
    }

    . = 0xA00000;

    .data :
    {
        *(.data)
    }

    . = 0xC00000;

    .rodata :
    {
        *(.rodata)
    }

    . = 0xE00000;

    .bss : 
    {
        *(.bss)
    }

    . = 0xFFFFFF;

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