;
; char                          *asm_itoa(long nbr, char *buf, char base)
;
BITS 64

SECTION .text
EXTERN asm_utoa
EXTERN asm_isneg
GLOBAL asm_itoa

asm_itoa:
    CMP RDX, 10                 ; Check base
    JNE _unsigned
    PUSH RBX
    PUSH RCX
    PUSH RDX
    PUSH RDI
    MOV RCX, -1                 ; Init counter
    CMP RDI, 0                  ; Check is positive
    JNS _start

_isneg:
    INC RCX
    MOV BYTE [RSI + RCX], 45    ; '-' char
    IMUL RDI, -1

_start:
    PUSH 0                      ; End of string
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

_unsigned:
    CALL asm_utoa
    RET

