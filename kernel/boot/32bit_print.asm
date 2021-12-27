[bits 32] ;use 32 bit protected mode

VIDEO_MEMORY equ 0xb8000 ;constant for video memory
WHITE_ON_BLACK equ 0x0f ;white color on black constant

print_string_pm:
    pusha ;push all registers
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; ebx is where string referenc available
    mov ah, WHITE_ON_BLACK

    cmp al, 0 ;end of string
    je print_string_pm_done

    mov [edx], ax  ; ASCII char + color property store at edx location
    add ebx, 1 ; get next character
    add edx, 2 ;get next video memory location

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret