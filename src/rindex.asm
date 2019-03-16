bits    64

global  rindex:function

section .text

; char  *rindex(const char *s, int c);

; arg1 = s = rdi
; arg2 = c = rsi

rindex:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end

_loop:
    mov     al, byte[rdi + rcx]

    cmp     al, 0
    je      _end_null

    cmp     al, sil
    je      _found

    inc     rcx
    jmp     _loop

_found:
    mov     rax, rdi
    add     rax, rcx

    jmp     _return

_end:
    add     rdi, rcx
    mov     rax, rdi

    jmp     _return

_end_null:
    xor     rax, rax

_return:
    mov     rsp, rbp
    pop     rbp

    ret