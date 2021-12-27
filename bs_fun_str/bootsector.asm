[org 0x7c00]
mov bx,Hello
call print

call print_new_line


mov dx, 0x1234
call print_hex

call print_new_line

jmp $

%include "print.asm"
%include "print_hex.asm"

Hello:
 db "Hello world",0



times 510 - ($ - $$) db 0
dw  0xaa55


