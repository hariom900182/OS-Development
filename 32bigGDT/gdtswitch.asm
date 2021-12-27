[bits 16]
switch_to_pm:
    cli ;-> disable intrupts until enable intrupts again
    lgdt [gdt_descriptor] ;-> load gdt

    ;move to 32 bit mode by setting cr0
    mov eax, cr0 
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:init_pm ;-> far jumping to different segment


[bits 32]
;now we will use 32 bit mode
init_pm:
    mov ax, DATA_SEG ;-> update segment registers
    mov ds,ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x9000 ;-> update the stack right at the top of the free space
    mov esp, ebp
    call BEGIN_PM ;-> call known label for usefull code 
