bits    64                      ; 64 bits architecture

global  strstr              ; export strstr

section .text                   ; code section

; arg1 = s1 = rdi
; arg2 = s2 = rsi

strstr:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

    cmp     rdi, 0              ; check if str is null
    je      _end                ; if null, go to _end

    cmp     rsi, 0              ; check if char is null
    je      _end                ; if null, go to _end

_loop:
    mov     al, byte[rdi]

    cmp     byte[rsi + rcx], 0
    je      _end

    cmp     al, byte[rsi + rcx]
    jne     _reset

    cmp     al, 0
    je      _end_null

    inc     rcx
    inc     rdi

    jmp     _loop

_reset:
    xor     rcx, rcx
    inc     rdi
    jmp     _loop

_end:
    mov     rax, rdi
    sub     rax, rcx

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function

_end_null:
    xor     rax, rax            ; set return value to 0

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function
