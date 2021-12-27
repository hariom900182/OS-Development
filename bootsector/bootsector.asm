;infinite loop e9 fd ff
loop:
    jmp loop

;fill 510 bit zeros
times 510-($-$$) db 0

;magic number
dw 0xaa55