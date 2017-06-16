;
; int               asm_isneg(int n)
;
BITS 64

SECTION .text
GLOBAL asm_isneg

asm_isneg:
    CMP EDI, 0
    JS _less

_greater:
    MOV RAX, 0
    JMP _end

_less:
    MOV RAX, 1

_end:
    RET

