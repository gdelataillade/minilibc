bits    64

global  memcpy

section .text

; void *memcpy(void *dest, const void *src, size_t n);

; arg1 = dest = rdi
; arg2 = src = rsi
; arg3 = n = rdx

memcpy:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end
    cmp     rsi, 0
    je      _end
    cmp     rdx, 0
    je      _end

_loop:
    cmp     rcx, rdx
    je      _end

    cmp     byte[rdi + rcx], 0
    je      _end

    mov     r8b, byte[rsi + rcx]
    mov     byte[rdi + rcx], r8b

    inc     rcx
    jmp     _loop

_end:
    mov     rax, rdi

    mov     rsp, rbp
    pop     rbp

    ret