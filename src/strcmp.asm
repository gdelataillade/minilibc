bits    64                      ; 64 bits architecture

global  strcmp                  ; export strcmp

section .text                   ; code section

; arg1 = s1 = rdi
; arg2 = s2 = rsi

strcmp:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

    cmp     rdi, 0              ; check if s1 is null
    je      _end_zero           ; if null, go to _end_zero
    cmp     rsi, 0              ; check if s2 is null
    je      _end_zero           ; if null, go to _end_zero

_loop:
    mov     al,  byte[rdi + rcx]; store specefic byte of s1 at pos rcx in al
    mov     r8b, byte[rsi + rcx]; store specefic byte of s2 at pos rcx in r8b

    cmp     al, 0               ; check if al is end of string
    je      _end_bigger         ; if true, go to _end_bigger
    cmp     r8b, 0              ; check if r8b is end of string
    je      _end_lower          ; if true, go to _end_lower

    cmp     al, r8b             ; compare two bytes of s1 and s2
    jg      _end_bigger         ; if al > r8b go to _end_bigger

    cmp     al, r8b             ; compare two bytes of s1 and s2    
    jl      _end_lower          ; if al < r8b go to _end_lower

    inc     rcx                 ; increment counter
    jmp     _loop               ; repeat _loop

_end_bigger:
    cmp     al, r8b             ; check if r8b is end of string too
    je      _end_zero           ; if true, s1 == s2 so go to _end_zero

    sub     al, r8b
    movsx   rax, al             ; else, set return value as 1

    mov     rsp, rbp            ; set stack pointer to rbp            
    pop     rbp                 ; epilogue

    ret                         ; return rax and exit function

_end_lower:
    sub     al, r8b
    movsx   rax, al             ; set return value as -1

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return rax and exit function

_end_zero:
    xor     rax, rax            ; set return value as 0

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return 0 and exit function