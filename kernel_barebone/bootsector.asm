[org 0x7c00]

KERNEL_OFFSET equ 0x1000 ;-> offset of kernel where we are loading it
mov [BOOT_DRIVE], dl ;-> move drive lcoation to BOOT_DRIVE, BIOS set it in dl

;set stack safety
mov bp, 0x9000
mov sp, bp

;print msg in 16bit mode
mov bx, MSG_REAL_MODE
call print
call print_new_line

;load kernel
call load_kernel
call switch_to_pm
jmp $ ;-> never execute



%include "../bs_fun_str/print.asm"
%include "../bs_fun_str/print_hex.asm"
%include "../disk/disk.asm"
%include "../32bitprint/print.asm"
%include "../32bigGDT/gdt.asm"
%include "../32bigGDT/gdtswitch.asm"



[bits 16]
load_kernel:
    ;msg of loading
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_new_line

    mov bx, KERNEL_OFFSET ;-> address of kernel 0x1000
    mov dh, 2 
    mov dl, [BOOT_DRIVE]
    call load_disk
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ;-> give control to the kernel
    jmp $ ;-> stay here if kernel returns

BOOT_DRIVE db 0 ;-> store drive from dl to here so that we can use dl 
MSG_REAL_MODE db "We are in 16 bit mode",0
MSG_PROT_MODE db "We are in 32 bit mode",0
MSG_LOAD_KERNEL db "Loading kernel..."

times 510-($-$$) db 0
dw 0xaa55

