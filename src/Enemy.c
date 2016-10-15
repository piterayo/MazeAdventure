
#include "Enemy.h"

const u8 activeEnemies = 0;

Enemy enemyArray[15];

// u8 abs(u8 n){
    // return ~n+1;
// }

void Enemy_spawn_new(){
    u8 i=15;
    Enemy* e;
    if(activeEnemies<15){
        while(i){
            --i;
            if(enemyArray[i].hitPoints==0){
                e = &enemyArray[i];
                
                e->textureId = 0;
                
                e->hitPoints = 10;
                
                break;
            }
        }
    }
}

void Enemy_update_logic(){
    
}