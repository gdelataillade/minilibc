bits    64

global  strcspn:function

section .text

; size_t strcspn(const char *s, const char *reject);

; arg1 = s = rdi
; arg2 = reject = rsi

strcspn:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx
    xor     r8, r8

    cmp     rdi, 0
    je      _end_null

    cmp     rsi, 0
    je      _end_null

_loops1:
    mov     al, byte[rdi + r8]

    cmp     al, 0
    je      _end

    jmp     _loops2

_loops2:
    cmp     al, byte[rsi + rcx]
    je      _end

    cmp     byte[rsi + rcx], 0
    je      _continue

    inc     rcx
    jmp     _loops2

_continue:
    xor     rcx, rcx
    inc     r8
    jmp     _loops1

_end:
    mov     rax, r8

    mov     rsp, rbp
    pop     rbp

    ret

_end_null:
    xor     rax, rax

    mov     rsp, rbp
    pop     rbp

    ret
