;
; char                  asm_tolower(char c);
;
BITS 64

SECTION .text
GLOBAL asm_tolower

asm_tolower:
    CMP DIL, 65         ; 'A' char
    JL _end
    CMP DIL, 90         ; 'Z' char
    JG _end
    ADD DIL, 32         ; 'a' - 'A'

_end:
    MOVZX RAX, DIL      ; Return counter
    RET

