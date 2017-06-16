;
; int                       asm_nbrlen(long nbr, char base, BOOL is_unsigned)
;
BITS 64

SECTION .text
EXTERN asm_isneg
GLOBAL asm_nbrlen

asm_nbrlen:
    PUSH RBX
    PUSH RCX
    PUSH RDX
    MOV RCX, 0
    CMP DL, 0               ; Check is_unsigned
    JNE _start
    CMP RDI, 0              ; Check is positive
    JNS _start

_isneg:
    ADD RCX, 1
    IMUL RDI, -1

_start:
    MOV RAX, RDI
    MOV RBX, RSI

_loop:
    ADD RCX, 1
    XOR RDX, RDX            ; Clear high bits of RDX (dividend)
    IDIV RBX                ; Divide by 10
    CMP RAX, 0
    JNE _loop

_end:
    MOV RAX, RCX
    POP RDX
    POP RCX
    POP RBX
    RET

