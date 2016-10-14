
#ifndef STRINGUTILS_H
#define STRINGUTILS_H

#include <cpctelera.h>

//ICONS
// # = Shield
// $ = Key
// + = Sword
// & = Potion
// < = Left arrow
// > = Right arrow
// * = Face
// ~ = Venom

extern void print_text(void * const text, u8* position, u8 bg, u8 fg);

extern void print_transparent_text(void * const text, u8* position, u8 fg);

extern void* integer_to_string(u8 n, u8 format);

#endif