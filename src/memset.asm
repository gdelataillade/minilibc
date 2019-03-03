bits    64                      ; 64 bits architecture

global  memset                  ; export memset

section .text                   ; code section

memset:
    push    rbp                 ; prologue
    mov     rbp, rsp            ; save stack pointer in rbp

    xor     rcx, rcx            ; set the counter rcx to 0

    cmp     rdi, 0              ; check if pointer is null
    je      _end                ; if null, go to _end

    cmp     rdx, 0              ; check if number of bytes (size) to write is 0
    je      _end                ; if 0, go to _end

_loop:
    cmp     rdx, 0              ; compare size to 0
    je      _end                ; if size is 0, go to _end

    mov     byte[rdi + rcx], sil; write sil byte in rdi at position rcx
    inc     rcx                 ; increment rcx, the counter
    dec     rdx                 ; decrement rdx, the size
    jmp     _loop               ; go to _loop

_end:
    mov     rax, rdi            ; set return value to pointer

    mov     rsp, rbp            ; set stack pointer to rbp
    pop     rbp                 ; epilogue

    ret                         ; return rax and exit function