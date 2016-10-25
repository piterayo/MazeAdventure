
#ifndef GAMEFUNCTIONS_H
#define GAMEFUNCTIONS_H

#include <cpctelera.h>

extern u16 r_counter;

extern u8 music_on;
extern u8 textures_on;

extern u8 camelot_warriors_mode;

#define MOVEMENT_EAST  0
#define MOVEMENT_NORTH 2
#define MOVEMENT_WEST  4
#define MOVEMENT_SOUTH 6

extern const i8 movement_directionArray[8];

extern void game_init();



#endif