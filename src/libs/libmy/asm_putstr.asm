;
; void              asm_putstr(char *str);
;
BITS 64

SECTION .text
EXTERN asm_strlen
GLOBAL asm_putstr

asm_putstr:
    PUSH RAX
    PUSH RBX
    PUSH RCX
    PUSH RDX
    PUSH RDI
    PUSH RSI

    CALL asm_strlen
    MOV RSI, RDI    ; Buffer
    MOV RDX, RAX    ; Length
    MOV RAX, 1      ; Sous fonction
    MOV RDI, 1      ; Flux (0 : stdin, 1 : stdout, 2 : stderr)
    SYSCALL
    
    POP RSI
    POP RDI
    POP RDX
    POP RCX
    POP RBX
    POP RAX
    RET

