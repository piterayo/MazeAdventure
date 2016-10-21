
#include "Enemy.h"

#include "Player.h"

#include "GameDefinitions.h"

#include "GameFunctions.h"

#include "Renderer.h"

#include "StringUtils.h"

#include "UI_Log.h"

#include <cpctelera.h>


#define ENEMY_INITIAL_HP 255

#define ENEMY_MAX_ENEMIES 15
#define ENEMY_VIEW_DISTANCE 6

u8 activeEnemies;

Enemy enemyArray[ENEMY_MAX_ENEMIES];

Enemy* const enemy_get_at(u8 index) __z88dk_fastcall{
    return (enemyArray+index);
}

void enemy_init_enemies(){
    
    cpct_memset(enemyArray, 0, ENEMY_MAX_ENEMIES*sizeof(Enemy));
    activeEnemies=0;
    
    while(activeEnemies<ENEMY_MAX_ENEMIES){
        enemy_try_new_spawn();
    }
    
}


i8 abs(i8 n) __z88dk_fastcall{
     if(n<0) n=-n;
     return n;
}

u8 dist(u8 x0, u8 y0, u8 x1, u8 y1){
    i8 dx,dy;
    dx = abs(x1-x0);
    dy = abs(y1-y0);
    
    if(dx>dy) return ((2*dx)+dy)/2;
    else return ((2*dy)+dx)/2;
    
}

u8 enemy_can_view(u8 x0, u8 y0, u8 x1, u8 y1){
    i8 dx, sx, dy, sy, e1, e2;
    u8* map = (u8*)MAP_MEM;
    
    dx = abs(x1-x0);
    dy = abs(y1-y0);
    
    sx = (x0<x1)?1:-1;
    sy = (y0<y1)?1:-1;
    
    e1 = ((dx>dy)?dx:-dy)/2;
    
    while(1){
        e2 = e1;
        if (e2 >-dx) {
            e1 -= dy;
            x0 += sx;
        }
        if (e2 < dy) {
            e1 += dx;
            y0 += sy;
        }
        //CHANGE VALUES
        
        
        if((*(u8*)(MAP_MEM+(x0+(y0*MAP_WIDTH)))&CELL_WALL_MASK)||(
                (*(u8*)(MAP_MEM+((x0)+((y0-sy)*MAP_WIDTH)))&CELL_WALL_MASK)&&
                (*(u8*)(MAP_MEM+((x0-sx)+(y0*MAP_WIDTH)))&CELL_WALL_MASK)
                )
                ){
            return 0;
        }
        if ((x0==x1 && y0==y1)){
            break;
        }
    }
    
    return 1;
}


void enemy_new_enemy(Vec2u* position) __z88dk_fastcall{
    u8 i=15, x, y;
    Enemy* enemy=(enemyArray+ENEMY_MAX_ENEMIES);
    
    x=position->x;
    y=position->y;
    
    
    while(i){
        --i;
        --enemy;
        if(enemy->hitPoints==0){//TODO
            enemy->id=i;
        
            enemy->type=0;
        
            enemy->hitPoints=ENEMY_INITIAL_HP;
            
            // *(u16*)&((*enemy).position)=(u16)(*position);
            enemy->direction=0;
            
            enemy->position.x = x;
            enemy->position.y = y;
            
            *(u8*)(MAP_MEM+x+(y*MAP_WIDTH))=(i+1);
            
            ++activeEnemies;
            break;
        }
    }
    
}


u8 enemy_try_new_spawn(){
    Vec2u pos;
    
    if(activeEnemies<ENEMY_MAX_ENEMIES){
        pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
        pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
        
        if((*(u8*)(MAP_MEM+pos.x+(pos.y*MAP_WIDTH))&(CELL_WALL_MASK|CELL_ENEMY_MASK))==0){
            if(dist(player_position.x, player_position.y, pos.x, pos.y)>ENEMY_VIEW_DISTANCE){
                enemy_new_enemy(&pos);
                return 1;
            }
        }
    }
    return 0;
}

void enemy_roam(Enemy* e) __z88dk_fastcall{
    u8 x, y, d, ml, mr, m;
    i8 dx, dy;
    
    u8* map = (u8*)MAP_MEM;
    
    x=e->position.x;
    y=e->position.y;
    
    d=e->direction;
    
    ui_log_add_log(integer_to_string(e->id,'d'));
    
    dx=movement_directionArray[d];
    dy=movement_directionArray[d+1];
    
    m=0;
    
    if((map[(x+dx) + (y+dy)*MAP_WIDTH])&(CELL_WALL_MASK|CELL_ENEMY_MASK)){//If wall or enemy forward
            
        d=((e->direction+2)&7);
    
        dx=movement_directionArray[d];
        dy=movement_directionArray[d+1];
    
        ml=(map[x+dx + (y+dy)*MAP_WIDTH]);
        
        d=((e->direction-2)&7);
    
        dx=movement_directionArray[d];
        dy=movement_directionArray[d+1];
    
        mr=(map[x+dx + (y+dy)*MAP_WIDTH]);
        
        
        if(cpct_getRandom_mxor_u8()%2){//Turn left then right
            if(!(ml&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move left
                d=((e->direction+2)&7);
                m=1;
            }
            else if(!(mr&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move right
                d=((e->direction-2)&7);
                m=1;
            }
            
        }
        else{//Turn right then left
            if(!(mr&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move left
                d=((e->direction-2)&7);
                m=1;
            }
            else if(!(ml&(CELL_WALL_MASK|CELL_ENEMY_MASK))){//Can move right
                d=((e->direction+2)&7);
                m=1;
            }
        }
        
        if(!m){
            
            d=((e->direction+4)&7);
            
            dx=movement_directionArray[d];
            dy=movement_directionArray[d+1];
        
            if(!((map[x+dx + (y+dy)*MAP_WIDTH])&(CELL_WALL_MASK|CELL_ENEMY_MASK))){
                m=1;
            }
            
        }
        else {
            dx=movement_directionArray[d];
            dy=movement_directionArray[d+1];
        }
        
    }
    else{ //Move forward
        m=1;
    } 
    
    if(m){
        (map[x + (y)*MAP_WIDTH]) &= (CELL_ITEM_MASK|CELL_WALL_MASK);
        
        
    
        x+=dx;
        y+=dy;
        
        e->direction = d;
    
        e->position.x = x;
        e->position.y = y;
        
        
        (map[x + (y)*MAP_WIDTH]) |= (e->id)+1;
    }
}

void enemy_AI_passive(Enemy* e) __z88dk_fastcall{
    u8 hp;
    
    
    hp=e->hitPoints;
    
    
    if(hp < ENEMY_INITIAL_HP){//Aggresive
        
    }
    else if(hp < ENEMY_INITIAL_HP/4){ //Flee
        
    }
    else{ //Roam
        enemy_roam(e);        
    }
}

void enemy_AI_aggressive(Enemy* e){
    
}

void enemy_AI_tactical(Enemy* e){
    
}

void enemy_AI_shy(Enemy* e){
    
}

void enemy_update(){
    u8 i=15;
    Enemy* enemy=enemyArray;
    
    for(i;i;--i){
        if(enemy->hitPoints){
            switch(enemy->type){
                case 0:{
                    enemy_AI_passive(enemy);
                    break;
                }
                case 1:{
                    
                    break;
                }
                case 2:{
                    
                    break;
                }
                case 3:{
                    
                    break;
                }
            }
            // if(dist(player_position.x, player_position.y, enemy->position.x, enemy->position.y)<=ENEMY_VIEW_DISTANCE){
                // if(enemy_can_view(enemy->position.x, enemy->position.y, player_position.x, player_position.y)){
                    // ui_log_add_log("RAT SEE YOU");
                // }
                // else{
                    // ui_log_add_log("OUT OF VIEW");
                // }
            // }
        }
        ++enemy;
    }
        
    // cpct_setBorder(g_palette[1]);
}