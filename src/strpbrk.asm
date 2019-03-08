bits    64                      ; 64 bits architecture

global  strpbrk              ; export strpbrk

section .text                   ; code section

; arg1 = s1 = rdi
; arg2 = s2 = rsi

strpbrk:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

    cmp     rdi, 0              ; check if str is null
    je      _end                ; if null, go to _end

    cmp     rsi, 0              ; check if char is null
    je      _end                ; if null, go to _end

    mov     sil, byte[rsi + 0]

_loop:
    cmp     [rdi + rcx], sil
    je      _found

    cmp     byte[rdi + rcx], 0  ; store specefic byte of s1 at pos rcx in al
    je      _end_null                ; if true, go to _end

    inc     rcx
    jmp     _loop

_found:
    mov     rax, rdi
    add     rax, rcx

_end:
    add     rdi, rcx
    mov     rax, rdi            ; set return value as 0

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function

_end_null:
    xor     rax, rax            ; set return value to 0

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function