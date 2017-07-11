;
; A basic BF interpreter
;
BITS 64

;---------------------- Defines ----------------------
%define ENDL 0x0A
%define MEMORY_SIZE 30000
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
    ; CMP RDX, ','                    ; case ','
    ; JE _comma
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
    MOV RAX, 60                     ; Exit
    XOR RDI, RDI                    ; Exit code : 0
    SYSCALL

;----------------------------------------------------------

_right_chevron:                     ; ++i
    INC DWORD [MEMORY_PTR]
    JMP end_of_switch


_left_chevron:                      ; --i
    DEC DWORD [MEMORY_PTR]
    JMP end_of_switch


_plus:                              ; ++memory[i]
    PUSH RBX
    MOV EBX, DWORD [MEMORY_PTR]
    INC BYTE [MEMORY + EBX]
    POP RBX
    JMP end_of_switch

_minus:                             ; --memory[i]
    PUSH RBX
    MOV EBX, DWORD [MEMORY_PTR]
    DEC BYTE [MEMORY + EBX]
    POP RBX
    JMP end_of_switch

_dot:                               ; Just print memory[i]
    PUSH RDI
    PUSH RBX
    MOV EBX, DWORD [MEMORY_PTR]
    MOVZX RDI, BYTE [MEMORY + EBX]
    CALL asm_putchar
    POP RBX
    POP RDI
    JMP end_of_switch

_comma:                             ; Wait an input

    JMP end_of_switch

_left_bracket:                      ; while(memory[i])
    PUSH RBX
    MOV EBX, DWORD [MEMORY_PTR]
    CMP BYTE [MEMORY + EBX], 0      ; Check if end of while
    JNE lb_end
    PUSH RAX                        ; Depth counter
    XOR RAX, RAX
lb_loop:
    INC RCX
    CMP BYTE [RSI + RCX], '['
    JE lb_depth_inc
    CMP BYTE [RSI + RCX], ']'
    JE lb_check
    JMP lb_loop
lb_check:
    CMP RAX, 0
    JG lb_depth_dec
    JMP lb_check_ok
lb_check_ok:
    POP RAX
lb_end:                             ; End of function
    POP RBX
    JMP end_of_switch
lb_depth_inc:
    INC RAX
    JMP lb_loop
lb_depth_dec:
    DEC RAX
    JMP lb_loop

_right_bracket:                     ; End of loop
    PUSH RAX                        ; Depth counter
    PUSH RBX
    MOV EBX, DWORD [MEMORY_PTR]
    CMP BYTE [MEMORY + EBX], 0      ; Check if end of while
    JE rb_end
    XOR RAX, RAX
rb_loop:
    DEC RCX
    CMP BYTE [RSI + RCX], '['
    JE rb_check
    CMP BYTE [RSI + RCX], ']'
    JE rb_depth_inc
    JMP rb_loop
rb_check:
    CMP RAX, 0
    JG rb_depth_dec
rb_end:                             ; End of function
    POP RBX
    POP RAX
    JMP end_of_switch
rb_depth_inc:
    INC RAX
    JMP rb_loop
rb_depth_dec:
    DEC RAX
    JMP rb_loop

