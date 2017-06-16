;
; char              *asm_strtoupper(char *str, char *buf);
;
BITS 64

SECTION .text
EXTERN asm_toupper
GLOBAL asm_strtoupper

asm_strtoupper:
    PUSH RCX
    MOV RCX, -1     ; Init counter

_loop:              ; Basic while
    INC RCX

    PUSH RDI
    MOVZX RDI, BYTE [RDI + RCX]
    CALL asm_toupper
    MOV BYTE [RSI + RCX], AL
    POP RDI

    CMP BYTE [RDI + RCX], 0
    JNE _loop

_end:
    MOV RAX, RSI    ; Return buf
    POP RCX
    RET

