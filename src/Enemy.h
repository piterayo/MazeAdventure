
#ifndef ENEMY_H
#define ENEMY_H

#include <cpctelera.h>
#include "Structures.h"

typedef struct Enemy{
    u8 textureId;
    
    Vec2u position;
    
    u16 hitPoints;
    u16 maxHitPoints;
    
    u16 attackValue;
    
    u16 defenseValue;
    
    u8 objectCarried;
    
}Enemy;

extern Enemy enemyArray[15];
extern const u8 activeEnemies;

extern void Enemy_spawn_new();
extern void Enemy_update_logic();

#endif