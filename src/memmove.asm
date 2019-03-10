bits    64                      ; 64 bits architecture

global  memmove                  ; export memmove

section .text                   ; code section

; arg1 = dest = rdi
; arg2 = src = rsi
; arg3 = n = rdx

memmove:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

    cmp     rdi, 0              ; check if pointer dest is null
    je      _end                ; if true, go to _end
    cmp     rsi, 0              ; check if pointer src is null
    je      _end                ; if true, go to _end
    cmp     rdx, 0              ; check if n is 0
    je      _end                ; if true, go to _end

    mov     r8, rdi
    sub     r8, rsi

    cmp     r8, 0
    jge     _overlap

_copy:
    cmp      rdx, rcx
    je      _end

    mov     r8b, byte[rsi + rcx]
    mov     byte[rdi + rcx], r8b

    inc     rcx
    jmp     _copy

_overlap:
    dec     rdx

_loop:
    cmp     rdx, 0
    jl      _end

    mov     r8b, byte[rsi + rcx]
    mov     byte[rdi + rcx], r8b

    dec     rdx
    jmp     _loop

_end:
    mov     rax, rdi

    mov     rsp, rbp
    pop     rbp

    ret                         ; return rax and exit function