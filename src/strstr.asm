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

    ; todo:
    jmp     _end_null

_loop:
    mov     al, byte[rdi]

    ; cmp     byte[rsi + rcx], 0
    ; je      _end

    ; cmp     al, byte[rsi + rcx]
    ; jne     _reset

    cmp     al, 0
    je      _end_null

    inc     rcx
    inc     rdi

    jmp     _loop

; _reset:
;     xor     rcx, rcx
;     inc     rdi
;     jmp     _loop

_end:
    mov     rax, rdi
    sub     rax, rcx

    mov     rsp, rbp
    pop     rbp

    ret

_end_null:
    xor     rax, rax

    mov     rsp, rbp
    pop     rbp

    ret
