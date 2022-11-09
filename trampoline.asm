global print_char
global test_fn
extern start_bootloader

section .init

_init:
    push bp
    mov bp, sp
    call start_bootloader
    pop bp

section .text

print_char:
    push bp
    mov bp, sp
    mov ah, 0x0e
    mov eax, edi
    int 0x10
    pop bp
    ret

test_fn:
    push bp
    mov bp, sp
    mov ah, 0x0e
    mov al, 'x'
    int 0x10
    pop bp
    ret


# times 510-($-$$) db 0
# dw 0xaa55 