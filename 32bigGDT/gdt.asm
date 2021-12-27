gdt_start: ;don't change label we will use it later
    
    ;GDT starts with 8 null bytes
    dd 0x0
    dd 0x0 

; GDT for code segment
    ; base -> 0x0000000
    ; length -> 0xfffff & other flags

gdt_code:
    dw 0xffff ; -> segment length bit 0-15
    dw 0x0 ; -> base segment bits 0-15
    db 0x0 ; -> segment base bits 16-23
    db 10011010b ; -> flags 8 bits
    db 11001111b ;-> flags (4 bit ) + segment length bits 16-19
    db 0x0 ;-> base segment bits 24-31


;GDT for data segment 
    ; base and length are same as code segment
    ; but flags are differnet

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; -> size 16 bit - always less then it's true sizee
    dd gdt_start ;-> 32 bit address

; constants for later use
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start