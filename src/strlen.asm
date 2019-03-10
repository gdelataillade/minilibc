bits    64

global  strlen:function

section .text

; size_t strlen(const char *s);

; arg1 = s = rdi

strlen:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

_loop:
    cmp     byte[rdi, rcx], 0
    je      _end

    inc     rcx
    jmp     _loop

_end:
    mov     rax, rcx

    mov     rsp, rbp
    pop     rbp

    ret