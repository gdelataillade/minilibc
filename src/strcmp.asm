bits    64

global  strcmp:function

section .text

; int strcmp(const char *s1, const char *s2);

; arg1 = s1 = rdi
; arg2 = s2 = rsi

strcmp:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end_zero
    cmp     rsi, 0
    je      _end_zero

_loop:
    mov     al,  byte[rdi + rcx]
    mov     r8b, byte[rsi + rcx]

    cmp     al, 0
    je      _end_bigger
    cmp     r8b, 0
    je      _end_lower

    cmp     al, r8b
    jg      _end_bigger

    cmp     al, r8b
    jl      _end_lower

    inc     rcx
    jmp     _loop

_end_bigger:
    cmp     al, r8b
    je      _end_zero

    sub     al, r8b
    movsx   rax, al

    mov     rsp, rbp
    pop     rbp

    ret

_end_lower:
    sub     al, r8b
    movsx   rax, al

    mov     rsp, rbp
    pop     rbp

    ret

_end_zero:
    xor     rax, rax

    mov     rsp, rbp
    pop     rbp

    ret