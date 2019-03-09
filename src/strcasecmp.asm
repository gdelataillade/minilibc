bits    64                      ; 64 bits architecture

global  strcasecmp              ; export strcasecmp

section .text                   ; code section

; arg1 = s1 = rdi
; arg2 = s2 = rsi

strcasecmp:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

    cmp     rdi, 0              ; check if s1 is null
    je      _end                ; if null, go to _end

    jmp     _loop

_to_lower1:
    cmp     byte[rdi + rcx], 'A'
    jle     _continue
    add     byte[rdi + rcx], 32

_to_lower2:
    cmp     byte[rsi + rcx], 'A'
    jle     _continue
    add     byte[rsi + rcx], 32

_continue:
    inc     rcx
    jmp     _loop

_loop:
    cmp     byte[rdi + rcx], 0  ; store specefic byte of s1 at pos rcx in al
    je      _end                ; if true, go to _end

    cmp     byte[rsi + rcx], 0
    je      _end

    cmp     byte[rdi + rcx], 'Z'
    jle     _to_lower1

    cmp     byte[rsi + rcx], 'Z'
    jle     _to_lower2

    inc     rcx
    jmp     _loop

_end:
    add     rdi, rcx            ; ca renvoie un pointeur de s1 modified
    add     rsi, rcx            ; ca renvoie un pointeur de s2 modified
    mov     rax, rcx            ; set return value as 0

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function