bits 64

global my_strlen

section .text

; main:
;     push    rbp
;     mov     rbp, rsp

;     mov     rdi, str
;     call    my_strlen

;     leave
;     ret

my_strlen:
    push    rbp
    mov     rbp, rsp
    xor     rcx, rcx

_loop:
    cmp     BYTE[rdi, rcx], 0
    je      _end
    inc     rcx
    jmp     _loop

_end:
    mov     rax, rcx
    leave
    ret

; section .rodata
;     str:	DB "abc", 0Ah, 0