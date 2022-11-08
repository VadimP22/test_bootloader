
OUTPUT_ARCH("i386:x86-64")

SECTIONS
{
    . = 0x7c00;

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
    }
}