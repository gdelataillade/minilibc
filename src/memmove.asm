bits    64

global  memmove:function

section .text

; void *memmove(void *dest, const void *src, size_t n);

; arg1 = dest = rdi
; arg2 = src = rsi
; arg3 = n = rdx

memmove:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end
    cmp     rsi, 0
    je      _end
    cmp     rdx, 0
    je      _end

    mov     r8, rdi
    sub     r8, rsi

    cmp     r8, 0
    jge     _overlap

_copy:
    cmp      rdx, rcx
    je      _end

    mov     r8b, byte[rsi + rcx]
    mov     byte[rdi + rcx], r8b

    inc     rcx
    jmp     _copy

_overlap:
    dec     rdx

_loop:
    cmp     rdx, 0
    jl      _end

    mov     r8b, byte[rsi + rcx]
    mov     byte[rdi + rcx], r8b

    dec     rdx
    jmp     _loop

_end:
    mov     rax, rdi

    mov     rsp, rbp
    pop     rbp

    ret