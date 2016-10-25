
#ifndef STRINGINPUT_H
#define STRINGINPUT_H

#include <cpctelera.h>

extern void ui_stringinput_init();

extern void ui_stringinput_add_char(u8 c);

extern char* const ui_stringinput_get_string();

extern void ui_stringinput_remove_char();

#endif