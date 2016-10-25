
#ifndef PLAYER_H
#define PLAYER_H

#include <cpctelera.h>
#include "Structures.h"

extern u8 player_health_points;

extern u8 player_attack_value;
extern u8 player_defense_value;

extern u8 player_is_dead;

extern u8 player_has_key;

extern u8 player_potion_count;

extern u8 player_scroll_count;

extern const Vec2u player_position;
extern const Vec2i player_direction;

extern void player_init();

extern void player_turn_left();
extern void player_turn_right();

extern void player_move_forward();

extern u8 player_get_direction_index();

#endif