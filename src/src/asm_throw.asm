;
; void              asm_throw(int error_code)
;
BITS 64

SECTION .text
GLOBAL asm_throw
EXTERN asm_putstr

asm_throw:
    CALL asm_putstr
    MOV RAX, 60		; sys_exit
    MOV RDI, 1		; status_code: 1
    SYSCALL

