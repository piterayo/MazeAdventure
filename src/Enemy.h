
#ifndef ENEMY_H
#define ENEMY_H

#include <cpctelera.h>
#include "Structures.h"

typedef struct Enemy{
    u8 id;
    
    u8 type;
    
    
    
    u8 direction;
    Vec2u position;
    
    u8 hitPoints;
    
    u16 attackValue;
    
    u16 defenseValue;
    
}Enemy;


extern Enemy* const enemy_get_at(u8 index) __z88dk_fastcall;

extern void enemy_init_enemies();

extern u8 enemy_try_new_spawn();
extern void enemy_update();

#endif