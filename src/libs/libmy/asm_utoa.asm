;
; char                          *asm_utoa(unsigned long nbr, char *buf, char base)
;
BITS 64

SECTION .text
GLOBAL asm_utoa

asm_utoa:
    PUSH RBX
    PUSH RCX
    PUSH RDX
    PUSH RDI
    PUSH 0
    MOV RCX, -1                 ; Init counter
    MOV RAX, RDI
    MOV RBX, RDX

_loop_begin:
    XOR RDX, RDX                ; Clear high bits of RDX (dividend)
    IDIV RBX                    ; Divide by 10
    PUSH RDX                    ; Save remainder
    ADD BYTE [RSP], 0x30        ; Convert to printable char
    CMP BYTE [RSP], 0x39        ; Is lower than '9' char
    JLE _loop_end
    ADD BYTE [RSP], 0x27        ; Convert 10 to 'a'

_loop_end:
    CMP RAX, 0
    JNE _loop_begin

_loop_write:                    ; Basic write loop
    INC RCX
    POP RDI
    MOV BYTE [RSI + RCX], DIL
    CMP DIL, 0
    JNE _loop_write

_end:
    MOV RAX, RSI
    POP RDI
    POP RDX
    POP RCX
    POP RBX
    RET

