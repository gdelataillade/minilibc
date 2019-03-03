bits    64                      ; 64 bits architecture

global  memeset                  ; export memeset

section .text                   ; code section

memset:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

_loop:
    cmp     byte[rdi + rcx], 0
    je      _end
    cmp     rcx, rdx
    je      _end
    mov     byte[rdi + rcx], sil
    inc     rcx
    jmp     _loop

_end:
    mov     rsp, rbp
    pop     rbp

    ret