[org 0x7c00] ;-> bootloader offset
    mov bp, 0x9000 ;-> set stack
    mov sp, bp
    mov bx, MSG_REAL_MODE
    call print

    call switch_to_pm

    jmp $ 


    %include "../bs_fun_str/print.asm"
    %include "../32bitprint/print.asm"
    %include "gdt.asm"
    %include "gdtswitch.asm"

[bits 32]
BEGIN_PM:  ; -> after the switch move here
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $


MSG_REAL_MODE db "We are in 16 bit mode",0
MSG_PROT_MODE db "We are in 32 bit mode",0

times 510 - ($-$$) db 0
dw 0xaa55