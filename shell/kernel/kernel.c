
#include "../cpu/isr.h"
#include "../cpu/timer.h"
#include "../drivers/keyboard.h"
#include "util.h"
#include "kernel.h"
#include "../drivers/screen.h"

void main()
{
    clear_screen();
    isr_install();
    asm volatile("sti");
    // commented to test keyboard event
    init_timer(50);
    init_keyboard();
    kprint("Type something, it will go through the kernel\n"
           "Type END to halt the CPU\n> ");
}
void user_input(char *input)
{
    if (strcmp(input, "END") == 0)
    {
        kprint("Stopping the CPU. Bye!\n");
        asm volatile("hlt");
    }
    kprint("You said: ");
    kprint(input);
    kprint("\n> ");
}