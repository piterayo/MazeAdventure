
#ifndef LEVEL_H
#define LEVEL_H

#include <cpctelera.h>

extern void level_set_level(u8 l) __z88dk_fastcall;

extern u8 level_get_level();

extern void level_load_level();

extern void level_init_palettes();

#endif