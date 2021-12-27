[org 0x7c00] ;global offset

mov bp, 0x8000 ;set base pointer for statck stack safety
mov sp, bp ; sp = bp means empty stack 
mov bx, 0x9000 ; set bx so es:bx = 0x0000 + 0x9000 = 0x9000 : setting it for disk sectors read 
mov dh, 0x02 ; number of sectors to read
call load_disk

mov dx, [0x9000]  ;read first sector 
call print_hex

call print_new_line

mov dx, [0x9000 + 512] ;print second sector

call print_hex
call print_new_line

jmp $

%include "../bs_fun_str/print.asm"
%include "../bs_fun_str/print_hex.asm"
%include "disk.asm"

;bootsector is loaded at sector 1
times 510 - ($-$$) db 0
dw 0xaa55

times 256 dw 0xdada ;sector 2 data
times 256 dw 0xface ;sector 3 data