bits    64

global  strchr:function

section .text

; char *strchr(const char *s, int c);

; arg1 = s = rdi
; arg2 = c = rsi

strchr:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end_null

_loop:
    cmp     [rdi + rcx], sil
    je      _end

    cmp     byte[rdi + rcx], 0
    je      _end_null

    inc     rcx
    jmp     _loop

_end:
    add     rdi, rcx
    mov     rax, rdi

    mov     rsp, rbp
    pop     rbp

    ret

_end_null:
    xor     rax, rax

    mov     rsp, rbp
    pop     rbp

    ret