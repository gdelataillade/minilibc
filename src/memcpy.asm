bits    64                      ; 64 bits architecture

global  memcpy                  ; export memcpy

section .text                   ; code section

; arg1 = dest = rdi
; arg2 = src = rsi
; arg3 = n = rdx

memcpy:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

    cmp     rdi, 0              ; check if pointer dest is null
    je      _end                ; if true, go to _end
    cmp     rsi, 0              ; check if pointer src is null
    je      _end                ; if true, go to _end
    cmp     rdx, 0              ; check if n is 0
    je      _end                ; if true, go to _end

_loop:
    cmp     rcx, rdx
    je      _end

    cmp     byte[rdi + rcx], 0
    je      _end

    mov     r8b, byte[rsi + rcx]
    mov     byte[rdi + rcx], r8b
    
    inc     rcx
    jmp     _loop

_end:
    mov     rax, rdi

    mov     rsp, rbp
    pop     rbp

    ret                         ; return rax and exit function