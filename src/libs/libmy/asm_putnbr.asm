;
; void                      asm_putnbr(long nbr, int base, bool is_unsigned)
;
BITS 64

SECTION .text
EXTERN asm_putchar
EXTERN asm_isneg
GLOBAL asm_putnbr

asm_putnbr:
    PUSH RAX
    PUSH RBX
    PUSH RDX
    CMP DL, 0               ; Check is_unsigned
    JNE _start
    CMP RDI, 0              ; Check is positive
    JNS _start

_isneg:
    PUSH RDI
    MOV RDI, 45             ; '-' char
    CALL asm_putchar
    POP RDI
    IMUL RDI, -1

_start:
    PUSH 0                  ; End of string
    MOV RAX, RDI
    MOV RBX, RSI

_loop_begin:
    XOR RDX, RDX            ; Clear high bits of RDX (dividend)
    IDIV RBX                ; Divide by 10
    PUSH RDX                ; Save remainder
    ADD BYTE [RSP], 0x30    ; Convert to printable char
    CMP BYTE [RSP], 0x39    ; Is lower than '9' char
    JLE _loop_end
    ADD BYTE [RSP], 0x27    ; Convert 10 to 'a'

_loop_end:
    CMP RAX, 0
    JNE _loop_begin

_loop_print:                ; Basic print loop
    POP RDI
    CALL asm_putchar
    CMP RDI, 0
    JNE _loop_print

_end:
    POP RDX
    POP RBX
    POP RAX
    RET

