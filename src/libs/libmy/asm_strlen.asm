;
; int             asm_strlen(char *str);
;
BITS 64

SECTION .text
GLOBAL asm_strlen

asm_strlen:
    PUSH RCX
    MOV RCX, -1     ; Init counter

_loop:              ; Basic while
    INC RCX
    CMP BYTE [RDI + RCX], 0
    JNE _loop

_end:
    MOV RAX, RCX    ; Return counter
    POP RCX
    RET

