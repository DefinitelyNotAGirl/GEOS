OUTPUT_FORMAT("binary")

ENTRY(_start)
SECTIONS
{
    . = 0x800000;

    .text : 
    {
        *(.entry64Code)
    }

    . = 0x803C00;

    .data :
    {
        *(.entry64Data)
    }

    . = 0x804000;
    
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