OUTPUT_FORMAT("binary")

ENTRY(init)
SECTIONS
{
    . = 0xA00000;
    
    .text :
    {
        *(.text)
    }

    . = 0xC00000;
    . = 0x10600000;

    .data :
    {
        *(.data)
    }

    . = 0x10800000;

    .rodata :
    {
        *(.rodata)
    }

    . = 0x10A00000;

    .bss : 
    {
        *(.bss)
    }

    . = 0x10C00000;

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