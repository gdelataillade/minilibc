bits    64

global  strstr:function

section .text

; char *strstr(const char *haystack, const char *needle);

; arg1 = haystack = rdi
; arg2 = needle = rsi

strstr:
    push    rbp
    mov     rbp, rsp

    xor     rcx, rcx

    cmp     rdi, 0
    je      _end

    cmp     rsi, 0
    je      _end

_set_counter:
    mov     r9b, [rsi]
    xor     rcx, rcx

    jmp     _loop

_loop:
    mov     r8b, [rsi + rcx]
    cmp     r8b, 0
    je      _end

    mov     r9b, [rdi + rcx]

    cmp     r9b, r8b
    jne     _set_value

    inc     rcx
    jmp     _loop

_set_value:
    cmp     r9b, 0
    je      _end_null

    inc     rdi
    jmp     _set_counter

_end:
    mov     rax, rdi
    jmp     _return

_end_null:
    xor     rax, rax
    jmp     _return

_end_zero:
    mov     rax, 0

_return:
    mov     rsp, rbp
    pop     rbp

    ret