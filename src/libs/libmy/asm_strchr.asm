;
; char              *strchr (const char *str, char c);
;
BITS 64

SECTION .text
GLOBAL asm_strchr

asm_strchr:
    PUSH RCX
    MOV RCX, -1     ; Init counter

_loop:              ; Basic while
    INC RCX
    
    CMP BYTE [RDI + RCX], SIL
    JE _finded
    CMP BYTE [RDI + RCX], 0
    JNE _loop
    MOV RCX, 0

_end:
    MOV RAX, RCX    ; Return counter
    POP RCX
    RET

_finded:
    ADD RCX, RDI
    JMP _end

