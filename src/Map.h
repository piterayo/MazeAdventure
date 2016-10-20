
#ifndef MAP_H
#define MAP_H

#include <cpctelera.h>
#include "GameDefinitions.h"

//extern const u8 rand_seed;

extern u8 map_get_seed();

extern void generate_level_with_seed(u8 seed) __z88dk_fastcall;

extern void generate_level();

#endif