bits 64                         ; 64 bits architecture

global strlen                ; export strlen

section .text                   ; code section

strlen:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

_loop:
    cmp     BYTE[rdi, rcx], 0   ; compare specific byte of string to 0

    je      _end                ; if the byte is 0, go to _end
    inc     rcx                 ; else increment rcx, the counter
    jmp     _loop               ; repeat _loop

_end:
    mov     rax, rcx            ; set return value rax to rcx, the length counter

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return and exit program