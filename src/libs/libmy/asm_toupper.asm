;
; char                  asm_toupper(char c);
;
BITS 64

SECTION .text
GLOBAL asm_toupper

asm_toupper:
    CMP DIL, 97         ; 'a' char
    JL _end
    CMP DIL, 122        ; 'z' char
    JG _end
    SUB DIL, 32         ; 'a' - 'A'

_end:
    MOVZX RAX, DIL      ; Return counter
    RET

