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

    jmp     _loop1

_to_lower1:
    cmp     al, 'A'
    jl      _loop2
    add     al, 32
    jmp     _loop2

_to_lower2:
    cmp     r8b, 'A'
    jl      _compare
    add     r8b, 32
    jmp     _compare

_loop1:
    mov     al,  byte[rdi + rcx]; store specefic byte of s1 at pos rcx in al

    cmp     al, 0
    je      _end_zero           ; todo...

    cmp     al, 'Z'
    jle     _to_lower1

    jmp     _loop2

_loop2:
    mov     r8b, byte[rsi + rcx]; store specefic byte of s2 at pos rcx in r8b
    
    cmp     r8b, 0
    je      _end_zero

    cmp     r8b, 'Z'
    jle     _to_lower2

    jmp     _compare

_compare:
    cmp     al, 0               ; check if al is end of string
    je      _end_bigger         ; if true, go to _end_bigger
    cmp     r8b, 0              ; check if r8b is end of string
    je      _end_lower          ; if true, go to _end_lower

    cmp     al, r8b             ; compare two bytes of s1 and s2
    jg      _end_bigger         ; if al > r8b go to _end_bigger

    cmp     al, r8b             ; compare two bytes of s1 and s2    
    jl      _end_lower          ; if al < r8b go to _end_lower

    inc     rcx
    jmp     _loop1

_end_bigger:
    cmp     al, r8b             ; check if r8b is end of string too
    je      _end_zero           ; if true, s1 == s2 so go to _end_zero

    sub     al, r8b
    movsx   rax, al              ; else, set return value as 1

    jmp     _epilogue    

_end_lower:
    sub     al, r8b
    movsx   rax, al             ; set return value as -1

    jmp     _epilogue

_end_zero:
    xor     rax, rax            ; set return value as 0
    jmp     _epilogue

_epilogue:
    mov     rsp, rbp
    pop     rbp

    ret