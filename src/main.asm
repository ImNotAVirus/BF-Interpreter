;
; A basic BF interpreter
;
BITS 64

;---------------------- Defines ----------------------
%define ENDL 0x0A
%define MEMORY_SIZE 156
;-----------------------------------------------------

;-------------------- Static vars --------------------
SECTION .bss
MEMORY: RESB MEMORY_SIZE
MEMORY_PTR: RESD 1
;-----------------------------------------------------

;--------------------- Variables ---------------------
SECTION .data
ERR_PARAMS   DB     "This program take one param", ENDL, 0
UNKNOWN_CHR  DB     "Unknown character : ", 0
EMPTY_STR    DB     0
;-----------------------------------------------------

SECTION .text
GLOBAL _start
EXTERN asm_putchar
EXTERN asm_putstr
EXTERN asm_throw

_start:
    POP RAX                         ; argc
    POP RSI                         ; argv
    CMP RAX, 2                      ; if (argc == 2) go to main function
    JE main
    MOV RDI, ERR_PARAMS             ; else throw an error
    CALL asm_throw

main: 
    ADD RSI, 8                      ; get first param
    MOV RCX, 0                      ; init counter

loop: 
    MOVZX RDX, BYTE [RSI + RCX]     ; RDI = buff[i]
    CMP RDX, 0                      ; while buff[i] != '\0'
    JE _exit

switch:
    CMP RDX, '>'                    ; case '>'
    JE _right_chevron
    CMP RDX, '<'                    ; case '<'
    JE _left_chevron
    CMP RDX, '+'                    ; case '+'
    JE _plus
    CMP RDX, '-'                    ; case '-'
    JE _minus
    CMP RDX, '.'                    ; case '.'
    JE _dot
    CMP RDX, ','                    ; case ','
    JE _comma
    CMP RDX, '['                    ; case '['
    JE _left_bracket
    CMP RDX, ']'                    ; case ']'
    JE _right_bracket
    MOV RDI, UNKNOWN_CHR            ; default
    CALL asm_putstr 
    MOV RDI, RDX
    CALL asm_putchar
    MOV RDI, ENDL
    CALL asm_putchar
    MOV RDI, EMPTY_STR
    CALL asm_throw

end_of_switch:
    INC RCX
    JMP loop

_exit:
    MOV RDI, ENDL
    CALL asm_putchar
    MOV RAX, 60                     ; Exit
    XOR RDI, RDI                    ; Exit code : 0
    SYSCALL


;----------------------------------------------------------

_right_chevron:
    INC DWORD [MEMORY_PTR]
    JMP end_of_switch


_left_chevron:
    DEC DWORD [MEMORY_PTR]
    JMP end_of_switch


_plus:
    PUSH RBX
    MOV EBX, DWORD [MEMORY_PTR]
    INC BYTE [MEMORY + EBX]
    POP RBX
    JMP end_of_switch

_minus:
    PUSH RBX
    MOV EBX, DWORD [MEMORY_PTR]
    DEC BYTE [MEMORY + EBX]
    POP RBX
    JMP end_of_switch

_dot:
    PUSH RDI
    PUSH RBX
    MOV EBX, DWORD [MEMORY_PTR]
    MOVZX RDI, BYTE [MEMORY + EBX]
    CALL asm_putchar
    POP RBX
    POP RDI
    JMP end_of_switch

_comma:

    JMP end_of_switch

_left_bracket:
    
    JMP end_of_switch

_right_bracket:
    
    JMP end_of_switch

