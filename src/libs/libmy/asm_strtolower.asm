;
; char              *asm_strtolower(char *str, char *buf);
;
BITS 64

SECTION .text
EXTERN asm_tolower
GLOBAL asm_strtolower

asm_strtolower:
    PUSH RCX
    MOV RCX, -1     ; Init counter

_loop:              ; Basic while
    INC RCX

    PUSH RDI
    MOVZX RDI, BYTE [RDI + RCX]
    CALL asm_tolower
    MOV BYTE [RSI + RCX], AL
    POP RDI

    CMP BYTE [RDI + RCX], 0
    JNE _loop

_end:
    MOV RAX, RSI    ; Return buf
    POP RCX
    RET

