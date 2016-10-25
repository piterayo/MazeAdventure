
#ifndef ENEMY_H
#define ENEMY_H

#include <cpctelera.h>
#include "Structures.h"

// 0 + 1 + 5 + 5 + 8

typedef struct Enemy{
    u8 id;
    
    u8 type;
    
    
    
    u8 direction;
    Vec2u position;
    
    u8 hitPoints;
    
    u8 attackValue;
    
    u8 defenseValue;
    
}Enemy;


extern u8 enemy_attack_enemy(Enemy* e);

extern Enemy* const enemy_get_at(u8 index) ;

extern void enemy_init_enemies();

extern u8 enemy_try_new_spawn();

extern void enemy_update();

#endif