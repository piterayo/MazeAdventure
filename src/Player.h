
#ifndef PLAYER_H
#define PLAYER_H

#include <cpctelera.h>
#include "Structures.h"

extern u16 player_health_points;

extern u16 player_attack_value;

extern const Vec2u player_position;
extern const Vec2i player_direction;

extern void player_turn_left();
extern void player_turn_right();

extern void player_move_forward();

extern u8 player_get_direction_index();

#endif