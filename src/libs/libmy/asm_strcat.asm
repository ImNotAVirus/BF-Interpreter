;
; char              *asm_strcat(char *dest, char *src);
;
BITS 64

SECTION .text
EXTERN asm_strlen
GLOBAL asm_strcat

asm_strcat:
    PUSH RCX
    PUSH RDI
    MOV RCX, -1                 ; Init counter
    CALL asm_strlen             ; Get first '\@' from dest
    ADD RDI, RAX                ; Start at '\@'

_loop:                          ; Basic loop
    INC RCX
    MOV AL, BYTE [RSI + RCX]
    MOV BYTE [RDI + RCX], AL
    CMP BYTE [RSI + RCX], 0     ; Wait a '\0'
    JNE _loop

_end:
    POP RDI
    POP RCX
    MOV RAX, RDI                ; Return dest
    RET

