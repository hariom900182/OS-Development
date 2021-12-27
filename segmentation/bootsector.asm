mov ah, 0x0e

;it will not work as it will start offset from 0x000
mov al, [the_secret]
int 0x10

;it will work because we are setting ds with base address so implicitly it will add offset with ds
mov bx, 0x7c0
mov ds, bx
mov al, [the_secret]
int 0x10

;it will not work as es = 0x000
mov al,[es:the_secret]
int 0x10

;it will work as we have loaded es with 0x7c0
mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10


jmp $

the_secret:
    db 'X'

times 510 - ($ - $$) db 0
dw 0xaa55