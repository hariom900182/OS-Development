
mov ah, 0x0e ;tty mode

; mov al, the_secret
; int 0x10
mov al, [the_secret]
int 0x10

; mov bx, the_secret
; add bx, 0x7c00
; mov al, [bx]
; int 0x10

; mov al , [0x7c14]
; int 0x10

jmp $ ;infinit loop

[org 0x7c00]
the_secret:
 db "Hello world",0h

times 510 - ($ - $$) db 0
dw 0xaa55