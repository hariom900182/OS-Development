#ifndef UTIL_H
#define UTIL_H
#define UNUSED(x) (void)(x)

#include "../cpu/types.h"

void memory_copy(char *source, char *dest, int nbytes);
void memory_set(u8 *dest, u8 val, u32 len);
u32 kmalloc(u32 size, int align, u32 *phys_addr);

void int_to_ascii(int n, char str[]);
void hex_to_ascii(int n, char str[]);
void reverse(char s[]);
int strlen(char s[]);

void backspace(char s[]);
void append(char s[], char n);
int strcmp(char s1[], char s2[]);

#endif