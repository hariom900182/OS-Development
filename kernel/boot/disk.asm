; dh -- number of sectors to read from drive: dl into es:bx
;BIOS set the dl with boot drive number
;if it gives error we have to add error for qemu : -fda

load_disk:
    pusha ;push all registers to stack

    push dx ; our inputs are in dx dh and dl so storing input to stack for later use

    mov ah, 0x02 ;Read function of bios intrupt 0x13
    mov al, dh ; Number of sectors to read
    mov cl, 0x02 ;first available sector 0x01 is bootsector to 0x02 is available
    mov ch, 0x00 ; cylinder
    mov dh, 0x00 ;head position
    ;BIOS will set dl so we don't need to set
    int 0x13

    jc disk_error ;if jc 1 means error is accourd

    pop dx

    cmp al, dh ; BIOS returns number of sector read in al so actual read sectors compare with actually read sectors
    jne  sector_error

    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_new_line
    mov dh, ah ; error code returns in ah
    call print_hex
    jmp disk_loop

sector_error:
    mov bx, SECTOR_ERROR
    call print

disk_loop:
    jmp $



DISK_ERROR: db "Disk read error",0
SECTOR_ERROR: db "Error in read sectors",0
    

