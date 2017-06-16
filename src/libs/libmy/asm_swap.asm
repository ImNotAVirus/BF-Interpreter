;
; void              asm_swap(void *a, void *b)
;
BITS 64

SECTION .text
GLOBAL asm_swap

asm_swap:
    ;MOV RCX, [RSI]
    ;MOV RDX, [RDI]
    ;MOV [RSI], RDX
    ;MOV [RDI], RCX

    ; OR

    PUSH QWORD [RSI]
    PUSH QWORD [RDI]
    POP QWORD [RSI]
    POP QWORD [RDI]

_end:
    RET

