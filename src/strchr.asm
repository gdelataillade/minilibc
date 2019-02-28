bits 64                         ; 64 bits architecture

global strchr                ; export strchr

section .text                   ; code section

strchr:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

    cmp     rdi, 0              ; compare string to NULL
    je      _end_null           ; if string is NULL, go to _end_null

_loop:
    cmp     [rdi + rcx], sil    ; compare specific byte of string to arg2 byte
    je      _end                ; if the byte is 0, go to _end
    cmp     byte[rdi + rcx], 0  ; check if we reach the end of the string
    je      _end_null           ; if true go to _end_null
    inc     rcx                 ; else increment rcx, the counter
    jmp     _loop               ; repeat _loop

_end:
    add     rdi, rcx            ; sum string to counter
    mov     rax, rdi            ; set return value rax to rcx, the length counter

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return and exit program

_end_null:
    xor     rax, rax            ; set return value to 0

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret