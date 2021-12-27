mov ah, 0x0e ;tty mode
mov al, 'H'
int 0x10
mov al, 'E'
int 0x10
mov al, 'L'
int 0x10 
int 0x10 ; already have 'L' in AL
mov al, 'O'
int 0x10

jmp $ ;infinit loop

times 510 - ($ - $$) db 0
dw 0xaa55