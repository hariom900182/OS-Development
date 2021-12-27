[bits 32]

VIDEO_MEMORY equ 0xb8000 ;Video memory address
WHITE_ON_BLACK equ 0x0f ; color byte for each character

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; ebx is address of character
    mov ah, WHITE_ON_BLACK

    cmp al, 0 ;check for end of string
    je print_string_pm_done

    mov [edx], ax ; mov character and attributte to edx
    add ebx, 1 ; next character
    add edx, 1 ; next video memory location

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret
    