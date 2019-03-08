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

_to_lower:
    add     al, 32
    mov     byte[rdi + rcx], al
    inc     rcx
    jmp     _loop

_loop:
    cmp     byte[rdi + rcx], 0  ; store specefic byte of s1 at pos rcx in al
    je      _end                ; if true, go to _end

    mov     al, byte[rdi + rcx]

    cmp     al, 97
    jl      _to_lower

    inc     rcx
    jmp     _loop

_end:
    mov     rax, rdi            ; set return value as 0

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function