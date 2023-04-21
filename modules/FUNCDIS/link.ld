OUTPUT_FORMAT("binary")

ENTRY(init)
SECTIONS
{
    . = 0x1000000;
    
    .text :
    {
        *(.text)
    }

    . = 0x1200000;

    .data :
    {
        *(.data)
    }

    . = 0x1400000;

    .rodata :
    {
        *(.rodata)
    }

    . = 0x1600000;

    .bss : 
    {
        *(.bss)
    }

    . = 0x17FFFFF;

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