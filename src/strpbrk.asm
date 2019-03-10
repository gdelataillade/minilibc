bits    64

global  strpbrk

section .text

; char *strpbrk(const char *s, const char *accept);

; arg1 = s = rdi
; arg2 = accept = rsi

strpbrk:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end_null

    cmp     rsi, 0
    je      _end_null

_loops1:
    mov     al, byte[rdi]

    cmp     al, 0
    je      _end_null

_loops2:
    cmp     al, byte[rsi + rcx]
    je      _end

    cmp     byte[rsi + rcx], 0
    je      _continue

    inc     rcx
    jmp     _loops2

_continue:
    xor     rcx, rcx
    inc     rdi
    jmp     _loops1

_end:
    mov     rax, rdi

    mov     rsp, rbp
    pop     rbp

    ret

_end_null:
    xor     rax, rax

    mov     rsp, rbp
    pop     rbp

    ret
