global print_char
global test_fn
extern start_bootloader

section .init

_init:
    push rbp
    mov rbp, rsp
    call start_bootloader
    pop rbp

section .text

print_char:
    push rbp
    mov rbp, rsp
    mov ah, 0x0e
    mov eax, edi
    int 0x10
    pop rbp
    ret

test_fn:
    push rbp
    mov rbp, rsp
    mov ah, 0x0e
    mov al, 'x'
    int 0x10
    pop rbp
    ret


# times 510-($-$$) db 0
# dw 0xaa55 