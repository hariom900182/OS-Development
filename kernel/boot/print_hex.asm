;suppose hex string is in dx
print_hex:
    pusha ;push all registers
    mov cx, 0 ;counter for 4 iteration

;strategy:
;   1. get last character then convert it to ASCII
;   2. Numeric ASCII value: for value '0' (0x30) to '9'(0x39) we add 0x30 to bye 'N'
;   3. Alphanumeric A-F: 'A'(0x41) to 'F' (0x46) we add 0x40
;   4. Move the correct ASCII character to correct position at resuting string

hex_loop:
    cmp cx, 4 ; 4 times loop
    je end

    ;convert last character to ascii
    mov ax, dx ; ax is our working register
    and ax, 0x000f ;get last digit making first 3 digits 0
    add al, 0x30 ;add 0x30 to convert it to ASCII 'N'
    cmp al, 0x39 ;if > 9 add extra 8 to get A to F
    jle step2 ;if condition true  don't need to conver to A-F
    add al, 7 ;ASCII of 'A' is 65 instead of 58 65 - 58 = 7

step2:
    ;GET correct position of the string to place ACII character
    ; bx <--- base Address + length of string - index of character
    mov bx, HEX_OUT + 5 ; bx <--  (base Address + length of string) = P1 : address of output string with index
    sub bx, cx  ; P1 - character index
    mov [bx], al ;copy ASCII value to correct position of output string
    ror dx,4 ; rotat to get next character at last 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

    ;increment index n loop
    add cx, 1
    jmp hex_loop

end:
    mov bx, HEX_OUT
    call print
    popa
    ret


HEX_OUT:
    db '0x0000',0 ;reserved for output string with acii characters