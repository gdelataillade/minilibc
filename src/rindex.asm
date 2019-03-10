bits    64

global  rindex:function

section .text

; char *rindex(const char *s, int c);

; arg1 = s = rdi
; arg2 = c = rsi

rindex:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end

    cmp     rsi, 0
    je      _end

_loop:
    cmp     byte[rdi + rcx], 0
    je      _end_null

    cmp     [rdi + rcx], sil
    je      _found

    inc     rcx
    jmp     _loop

_found:
    mov     rax, rdi
    add     rax, rcx

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