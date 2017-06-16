;
; int             asm_strcmp(char *s1, char *s2);
;
BITS 64

SECTION .text
GLOBAL asm_strcmp

asm_strcmp:
    PUSH RCX
    PUSH RDX
    MOV RCX, -1                 ; Init counter

_loop:                          ; Basic while
    INC RCX
    MOV DL, BYTE [RSI + RCX]   ; Tmp var
    CMP BYTE [RDI + RCX], DL
    JNE _end
    CMP BYTE [RDI + RCX], 0
    JE _end
    CMP BYTE [RSI + RCX], 0
    JE _end
    JMP _loop

_end:
    MOVZX RAX, BYTE [RDI + RCX]   ; Return difference between s1[i] and s2[i]
    MOVZX RDX, BYTE [RSI + RCX]
    SUB RAX, RDX
    POP RDX
    POP RCX
    RET

