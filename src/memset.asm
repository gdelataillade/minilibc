bits    64

global  memset:function

section .text

; void *memset(void *s, int c, size_t n);

; arg1 = s = rdi
; arg2 = c = rsi
; arg2 = n = rdx

memset:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end

    cmp     rdx, 0
    je      _end

_loop:
    cmp     rdx, 0
    je      _end

    mov     byte[rdi + rcx], sil
    inc     rcx
    dec     rdx
    jmp     _loop

_end:
    mov     rax, rdi

    mov     rsp, rbp
    pop     rbp

    ret