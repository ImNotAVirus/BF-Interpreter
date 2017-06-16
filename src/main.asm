;
; A basic BF interpreter
;
BITS 64

;---------------------- Defines ----------------------
%define ENDL 0x0A
;-----------------------------------------------------

;--------------------- Variables ---------------------
SECTION .data
ERR_PARAMS	DB    	"This program take one param", ENDL, 0
CURRENT_CHR	DB    	"Current char : ", 0
;-----------------------------------------------------

SECTION .text
GLOBAL _start
EXTERN asm_putchar
EXTERN asm_putstr
EXTERN asm_throw

_start:
    POP RAX			; argc
    POP RSI			; argv
    CMP RAX, 2			; if (argc == 2) go to main function
    JE main
    MOV RDI, ERR_PARAMS		; else throw an error
    CALL asm_throw

main: 
    ADD RSI, 8			; get first param
    MOV RCX, 0			; init counter

loop:
    CMP BYTE [RSI + RCX], 0	; while current char != '\0'
    JE _exit

    ; INSERT THE SWICH/CASE HERE !
    MOV RDI, CURRENT_CHR
    CALL asm_putstr 
    MOVZX RDI, BYTE [RSI + RCX]	; get current byte
    CALL asm_putchar
    MOV RDI, ENDL
    CALL asm_putchar

    INC RCX
    JMP loop

_exit:
    MOV RAX, 60			; Exit
    XOR RDI, RDI		; Exit code : 0
    SYSCALL

