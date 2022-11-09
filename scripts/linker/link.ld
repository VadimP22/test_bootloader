
OUTPUT_ARCH("i386")
OUTPUT_FORMAT("binary")

SECTIONS
{
    . = 0x0;

    .text . :
    {
        *(.init);
        *(.text);
    }

    . = 0x1fe;

    .bootmagic : {
        BYTE(0x55);
        BYTE(0xaa);
    }

    /DISCARD/ :
    {
        *(.comment);
        *(.note.gnu.property);
        *(.eh_frame);
        *(.debug_frame);
        *(.debug_loc);
        *(.debug_pubnames);
        *(.debug_str);
        *(.debug_line);
        *(.debug_aranges);
        *(.debug_abbrev);
        *(.debug_info);
    }
}