;
; int             asm_strncmp(char *s1, char *s2, size_t num);
;
BITS 64

SECTION .text
GLOBAL asm_strncmp

asm_strncmp:
    PUSH RCX
    PUSH RDX
    MOV RAX, 0
    MOV RCX, -1                 ; Init counter

    CMP RDX, 0
    JE _end
    DEC RDX

_loop:                          ; Basic while
    INC RCX
    CMP RCX, RDX
    JGE _get_result
    MOV AL, BYTE [RSI + RCX]   ; Tmp var
    CMP BYTE [RDI + RCX], AL
    JNE _get_result
    CMP BYTE [RDI + RCX], 0
    JE _get_result
    CMP BYTE [RSI + RCX], 0
    JE _get_result
    JMP _loop

_get_result:
    MOVZX RAX, BYTE [RDI + RCX]   ; Return difference between s1[i] and s2[i]
    MOVZX RDX, BYTE [RSI + RCX]
    SUB RAX, RDX

_end:
    POP RDX
    POP RCX
    RET

