;
; int               asm_putchar(char c);
;
BITS 64

SECTION .text
GLOBAL asm_putchar

asm_putchar:
    PUSH RAX
    PUSH RBX
    PUSH RCX
    PUSH RDX
    PUSH RSI
    PUSH RDI		; Store character into buffer

    MOV RAX, 1      	; Sous fonction
    MOV RSI, RSP    	; Character pointer (into the stack)
    MOV RDI, 1      	; Flux (0 : stdin, 1 : stdout, 2 : stderr)
    MOV RDX, 1      	; Length
    SYSCALL

    POP RDI
    POP RSI
    POP RDX
    POP RCX
    POP RBX
    POP RAX
    RET

