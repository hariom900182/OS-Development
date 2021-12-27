#ifndef IDT_H

#define IDT_H

#include "types.h"

#define KERNEL_CS 0x08 // segment selectors

//Interrupt gate(handler) definition

typedef struct
{
    u16 low_offset; //lower 16-bit of handler function address
    u16 sel;        //Kernel segment selector
    u8 always0;
    //bit 7 -> interrupt is present
    // bits 6-5 -> privilege level (0 = kernel... 3=user)
    //bit 4 ->  set to 0 for interrupt gate
    //bits 3-0 -> bits 1110 -> decimal 14 = "32 bit interrupt gate"
    u8 flags;
    u16 high_offset; //higher 16 bits of handler function address
} __attribute__((packed)) idt_gate_t;

//pointer to the array interrupt handler
//assembly instruction 'lidt' will read it
typedef struct
{
    u16 limit;
    u32 base;
} __attribute__((packed)) idt_register_t;

#define IDT_ENTRIES 256
idt_gate_t idt[IDT_ENTRIES];
idt_register_t idt_reg;

void set_idt_gate(int n, u32 handler);
void set_idt();

#endif