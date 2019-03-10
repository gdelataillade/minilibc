bits    64

global  strcasecmp:function

section .text

; int strcasecmp(const char *s1, const char *s2);

; arg1 = s1 = rdi
; arg2 = s2 = rsi

strcasecmp:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end_zero

    jmp     _loop1

_to_lower1:
    cmp     al, 'A'
    jl      _loop2
    add     al, 32
    jmp     _loop2

_to_lower2:
    cmp     r8b, 'A'
    jl      _compare
    add     r8b, 32
    jmp     _compare

_loop1:
    mov     al,  byte[rdi + rcx]

    cmp     al, 'Z'
    jle     _to_lower1

    jmp     _loop2

_loop2:
    mov     r8b, byte[rsi + rcx]

    cmp     r8b, 'Z'
    jle     _to_lower2

_compare:
    cmp     al, 0
    je      _end_bigger
    cmp     r8b, 0
    je      _end_lower

    cmp     al, r8b
    jg      _end_bigger

    cmp     al, r8b
    jl      _end_lower

    inc     rcx
    jmp     _loop1

_end_bigger:
    cmp     al, r8b
    je      _end_zero

    sub     al, r8b
    movsx   rax, al

    jmp     _epilogue

_end_lower:
    sub     al, r8b
    movsx   rax, al

    jmp     _epilogue

_end_zero:
    xor     rax, rax

_epilogue:
    mov     rsp, rbp
    pop     rbp

    ret