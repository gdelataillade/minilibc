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
    je      _end_zero           ; if null, go to _end_zero
    cmp     rsi, 0              ; check if s2 is null
    je      _end_zero           ; if null, go to _end_zero

_strtouppercase:
    mov     r8b, byte[rdi + rcx]
    mov     r9b, byte[rsi + rcx]

    cmp     r8b, 0
    je      _pre_loop
    cmp     r9b, 0
    je      _pre_loop

    cmp     r8b, 96
    jg      _subs1

    cmp     r9b, 96
    jg      _subs2

    inc     rcx
    jmp     _strtouppercase

_subs1:
    sub     r8b, 32
    jmp     _strtouppercase    

_subs2:
    sub     r9b, 32
    jmp     _strtouppercase

_pre_loop:
    xor     rcx, rcx

_loop:
    mov     r8b, byte[rdi + rcx]; store specefic byte of s1 at pos rcx in r8b
    mov     r9b, byte[rsi + rcx]; store specefic byte of s2 at pos rcx in r9b

    cmp     r8b, 0              ; check if r8b is end of string
    je      _end_bigger         ; if true, go to _end_bigger
    cmp     r9b, 0              ; check if r9b is end of string
    je      _end_lower          ; if true, go to _end_lower

    cmp     r8b, r9b            ; compare two bytes of s1 and s2
    jg      _end_bigger         ; if r8b > r9b go to _end_bigger

    cmp     r8b, r9b            ; compare two bytes of s1 and s2    
    jl      _end_lower          ; if r8b < r9b go to _end_lower

    inc     rcx                 ; increment counter
    jmp     _loop               ; repeat _loop

_end_bigger:
    cmp     r8b, r9b            ; check if r9b is end of string too
    je      _end_zero           ; if true, s1 == s2 so go to _end_zero

    mov     rax, 1              ; else, set return value as 1

    mov     rsp, rbp            ; set stack pointer to rbp            
    pop     rbp                 ; epilogue

    ret                         ; return rax and exit function

_end_lower:
    mov     rax, -1             ; set return value as -1

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return rax and exit function

_end_zero:
    xor     rax, rax            ; set return value as 0

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function