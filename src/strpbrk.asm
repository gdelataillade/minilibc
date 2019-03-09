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

_loops1:
    mov     al, byte[rdi]

    cmp     al, 0
    je      _end_null
    
    jmp     _loops2

_loops2:
    cmp     al, byte[rsi + rcx]
    je      _end

    cmp     byte[rsi + rcx], 0
    je      _continue

    inc     rcx
    jmp     _loops2

_continue:
    xor     rcx, rcx
    inc     rdi
    jmp     _loops1

_end:
    mov     rax, rdi

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function

_end_null:
    xor     rax, rax            ; set return value to 0

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function
