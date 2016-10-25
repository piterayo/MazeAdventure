
#include "Enemy.h"

#include "Player.h"

#include "UI_PlayerStats.h"

#include "GameDefinitions.h"

#include "GameFunctions.h"

#include "Renderer.h"

#include "StringUtils.h"

#include "UI_Log.h"

#include "Item.h"

#include "Level.h"

#include <cpctelera.h>


#define ENEMY_INITIAL_HP 255

#define ENEMY_MAX_ENEMIES 15
#define ENEMY_VIEW_DISTANCE 6

u8 activeEnemies;

Enemy enemyArray[ENEMY_MAX_ENEMIES];

Enemy* const enemy_get_at(u8 index) {
    return (enemyArray+index);
}

void enemy_init_enemies(){
    
    cpct_memset(enemyArray, 0, ENEMY_MAX_ENEMIES*sizeof(Enemy));
    activeEnemies=0;
    // if(level_get_level()<()
    if(level_get_level()!=KING_LEVEL){
        while(activeEnemies<ENEMY_MAX_ENEMIES){
            enemy_try_new_spawn();  
        }
    }
    else{
        activeEnemies=1;
        
        enemyArray->id=0;

        enemyArray->type=1;

        enemyArray->hitPoints=ENEMY_INITIAL_HP;
        
        enemyArray->attackValue = 64;
        enemyArray->defenseValue = 54;
        
        enemyArray->direction=MOVEMENT_SOUTH;
        
        enemyArray->position.x = KING_LEVEL_KING_X;
        enemyArray->position.y = KING_LEVEL_KING_Y;
        
        *(u8*)(MAP_MEM + KING_LEVEL_KING_X + (KING_LEVEL_KING_Y*MAP_WIDTH)) = 1;
    }
    
}


i8 abs(i8 n) {
     if(n<0) n=-n;
     return n;
}

u8 dist(u8 x0, u8 y0, u8 x1, u8 y1){
    u8 dx,dy;
    dx = abs(x1-x0);
    dy = abs(y1-y0);
    
    return dx+dy;
    
}

u8 enemy_can_view(Enemy* e){
    i8 dx, sx, dy, sy, e1, e2, x0,x1,y0,y1,mask;
    u8* map = (u8*)MAP_MEM;
    
    x0 = player_position.x;
    y0 = player_position.y;
    
    x1 = e->position.x;
    y1 = e->position.y;
    
    mask = (CELL_WALL_MASK|CELL_ENEMY_MASK)^(e->id+1);
    
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
        
        if((*(u8*)(MAP_MEM+(x0+(y0*MAP_WIDTH)))&(mask))||(
                (*(u8*)(MAP_MEM+((x0)+((y0-sy)*MAP_WIDTH)))&(mask))&&
                (*(u8*)(MAP_MEM+((x0-sx)+(y0*MAP_WIDTH)))&(mask))
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

u8 enemy_is_adjacent_to_player(Enemy* e){    
    return (dist(player_position.x,player_position.y,e->position.x,e->position.y)==1);
}


void enemy_new_enemy(Vec2u* position) {
    u8 i=ENEMY_MAX_ENEMIES, x, y;
    Enemy* enemy=(enemyArray+ENEMY_MAX_ENEMIES);
    u8* memPos;
    
    x=position->x;
    y=position->y;
    
    memPos = (MAP_MEM+x+(y*MAP_WIDTH));
    
    while(i){
        --i;
        --enemy;
        if(enemy->hitPoints==0){
            enemy->id=i;
        
            enemy->type=cpct_getRandom_mxor_u8()&1;
        
            enemy->hitPoints=ENEMY_INITIAL_HP;
            
            enemy->attackValue = (10)+level_get_level()+(cpct_getRandom_mxor_u8()&7);
            enemy->defenseValue = level_get_level()+(cpct_getRandom_mxor_u8()&7);
            
            enemy->direction=(cpct_getRandom_mxor_u8()&3)*2;
            
            enemy->position.x = x;
            enemy->position.y = y;
            
            *memPos=(i+1)|(*memPos);
            
            ++activeEnemies;
            break;
        }
    }
    
}

// u8 enemy_get_enemies_near_player(){
    // u8* map;
    // u8 counter=0;
    // u8 mu, md, mr, ml;
    
    // map = (u8*)MAP_MEM;
    
    // mu = map[(player_position.x) + ((player_position.y+1)*MAP_WIDTH)];
    // md = map[(player_position.x) + ((player_position.y-1)*MAP_WIDTH)];
    // mr = map[(player_position.x+1) + ((player_position.y)*MAP_WIDTH)];
    // ml = map[(player_position.x-1) + ((player_position.y)*MAP_WIDTH)];
    
    // if(!(mu&CELL_WALL_MASK)){
        // if(mu&CELL_ENEMY_MASK){
            // ++counter;
        // }
    // }
    
    // if(!(md&CELL_WALL_MASK)){
        // if(md&CELL_ENEMY_MASK){
            // ++counter;
        // }
    // }
    
    // if(!(mr&CELL_WALL_MASK)){
        // if(mr&CELL_ENEMY_MASK){
            // ++counter;
        // }
    // }
    
    // if(!(ml&CELL_WALL_MASK)){
        // if(ml&CELL_ENEMY_MASK){
            // ++counter;
        // }
    // }
    
    // return counter;
    
// }

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

u8 enemy_collision_at_dir(Vec2u* pos, u8 dir){
    i8 dx;
    i8 dy;
    u8 val;
    
    dx = movement_directionArray[dir];
    dy = movement_directionArray[dir+1];
    
    val = *(u8*)(MAP_MEM + (pos->x + dx) + ((pos->y + dy)*MAP_WIDTH));
    
    if((val & (CELL_WALL_MASK|CELL_ENEMY_MASK)) || (((pos->x + dx) == player_position.x) && ((pos->y + dy) == player_position.y))) return 1;
    return 0;
}

u8 enemy_get_distance_to_obstacle(Enemy* e, u8 direction){
    Vec2u position;
    u8 count=0;
    i8 dx;
    i8 dy;
    
    dx = movement_directionArray[direction];
    dy = movement_directionArray[direction+1];
    
    
    position.x = e->position.x;
    position.y = e->position.y;
    
    
    
    while(!(enemy_collision_at_dir(&position, direction))){
        ++count;
        position.x += dx;
        position.y += dy;
    }
    
    return count;
}

void enemy_remove(Enemy* e){
    u8* map;
    
    map = (u8*)MAP_MEM;
    
    e->hitPoints=0;
    
    (map[e->position.x + (e->position.y)*MAP_WIDTH]) &= (CELL_ITEM_MASK);
    --activeEnemies;
}

void enemy_move(Enemy* e, u8 d){
    i8 dx;
    i8 dy;
    u8 x,y;
    u8* map;
    
    map = (u8*)MAP_MEM;
    
    x = e->position.x;
    y = e->position.y;
    
    
    (map[x + (y)*MAP_WIDTH]) &= (CELL_ITEM_MASK);
    
    dx=movement_directionArray[d];
    dy=movement_directionArray[d+1];
    

    x+=dx;
    y+=dy;
    
    e->direction = d;

    e->position.x = x;
    e->position.y = y;
    
    
    (map[x + (y)*MAP_WIDTH]) |= ((e->id)+1);
}

u8 enemy_attack_enemy(Enemy* e){
    i8 dmg;
    const char* t = "    DMG";
    dmg = (player_attack_value - e->defenseValue);
    if(dmg<1) dmg = 1;
    
    cpct_memcpy(t,integer_to_string(dmg,'d'),3);
    ui_log_add_log("YOU MAKE",3);
    ui_log_add_log(t,5);
    ui_log_render();
    
    if(e->hitPoints>(u8)dmg){
        e->hitPoints -= dmg;
        return 0;
    }
    else{
        
        enemy_remove(e);
        
        if(cpct_getRandom_mxor_u8()%2 || level_get_level()==KING_LEVEL){
            item_try_new_spawn_at(&(e->position));
        }
        
        return 1;
    }
}

void enemy_attack(Enemy* e){
    i8 dmg;
    const char* t = "    HP";
    dmg = (e->attackValue - player_defense_value);
    if(dmg<1) dmg = 1;
    
    cpct_memcpy(t,integer_to_string(dmg,'d'),3);
    ui_log_add_log("YOU LOSE",3);
    ui_log_add_log(t,4);
    ui_log_render();
    
    if(player_health_points>(u8)dmg){
        player_health_points -= dmg;
    }
    else{
        player_is_dead = 1;
    }
    ui_playerstats_render_hp();
}

void enemy_go_to_player(Enemy* e){//NOT WORKING
    i8 dx;
    i8 dy;
    u8 dirX, dirY;
    
    dx=player_position.x-e->position.x;
    dy=player_position.y-e->position.y;
    
    dirX = (dx>0)?MOVEMENT_EAST:MOVEMENT_WEST;
    dirY = (dy>0)?MOVEMENT_SOUTH:MOVEMENT_NORTH;
    
    if(abs(dx)>abs(dy)){
        if(!enemy_collision_at_dir(&(e->position),dirX)){
                // cpct_setBorder(g_palette[0]);
                // return;
            enemy_move(e, dirX);
        }
        else{
                // cpct_setBorder(g_palette[3]);
                // return;
            enemy_move(e, dirY);
        }
    }
    else{
        if(!enemy_collision_at_dir(&(e->position),dirY)){
                // cpct_setBorder(g_palette[2]);
                // return;
            enemy_move(e, dirY);
        }
        else{
                // cpct_setBorder(g_palette[5]);
                // return;
            enemy_move(e, dirX);
        }
    }
}


void enemy_flee(Enemy* e) {
    u8 fleeFromDir, df, dl, dr, distf, distl, distr, d, dist;
    u8 distFromPlayX, distFromPlayY;
    
    distFromPlayX = abs(player_position.x - e->position.x);
    distFromPlayY = abs(player_position.y - e->position.y);
    
    if(distFromPlayX>distFromPlayY){//Flee X
        fleeFromDir=(player_position.x<e->position.x)?MOVEMENT_EAST:MOVEMENT_WEST;
    }
    else{//Flee Y
        fleeFromDir=(player_position.y<e->position.y)?MOVEMENT_NORTH:MOVEMENT_SOUTH;
    }
    
    df = (fleeFromDir+4)&7;
    dl = (df+2)&7;
    dr = (df-2)&7;
    
    distf = enemy_get_distance_to_obstacle(e, df);
    distl = enemy_get_distance_to_obstacle(e, dl);
    distr = enemy_get_distance_to_obstacle(e, dr);
    
    if(distf>distl && distf>distr){
        d = df;
        dist = distf;
    }
    else if(distl>distf && distl>distr){
        d=dl;
        dist=distl;
    }
    else if(distr>distf && distr>distl){
        d=dr;
        dist=distr;
    }
    else{//All equal
        d=df;
        dist=distf;
    }
    
    if(dist){
        enemy_move(e,d);
    }
    
}

void enemy_roam(Enemy* e) {
    u8 d, nd=0;
    u8 directions[4];
    Vec2u* pos;
    
    d = e->direction;
    pos = &(e->position);
    
    if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
    
        directions[nd]=d;
        ++nd;
    
    }
            
    d=((e->direction+2)&7);

    if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
    
        directions[nd]=d;
        ++nd;
    
    }
    
    d=((e->direction-2)&7);

    if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
    
        directions[nd]=d;
        ++nd;
    
    }
    
    if(nd==0){//If cannot move any other direction than back
        
        d=((e->direction+4)&7);
        
        if(!enemy_collision_at_dir(pos,d)){//If not wall nor enemy forward
        
            ++nd;
        
        }
    }
    else{
        d=directions[cpct_getRandom_mxor_u8()%(nd)];
    }
    
    if(nd){//If can move
        enemy_move(e, d);
    }
}

void enemy_AI_passive(Enemy* e) {
    u8 hp, x, y;
    
    x = e->position.x;
    y = e->position.y;
    
    hp=e->hitPoints;
    
    if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
        if(enemy_can_view(e)){
            if(hp < ENEMY_INITIAL_HP){//Aggresive
                if(enemy_is_adjacent_to_player(e)){//Attack
                    enemy_attack(e);
                    return;
                }
                else{
                    enemy_go_to_player(e);
                    return;
                }
            }
            else if(hp < ENEMY_INITIAL_HP/4){ //Flee
                enemy_flee(e);
                return;
            }
        }
    }
    enemy_roam(e);   
}

void enemy_AI_aggressive(Enemy* e){
    u8  x, y;
    
    x = e->position.x;
    y = e->position.y;
    
    if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
        if(enemy_can_view(e)){
            if(enemy_is_adjacent_to_player(e)){//Attack
                enemy_attack(e);
                return;
            }
            else{
                enemy_go_to_player(e);
                return;
            }
        }
    }
    enemy_roam(e);     
}

// void enemy_AI_tactical(Enemy* e){
    // u8 hp, x, y;
    
    // x = e->position.x;
    // y = e->position.y;
    
    // hp=e->hitPoints;
    
    // if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
        // if(enemy_can_view(player_position.x,player_position.y, x, y)){
            // if(enemy_get_enemies_near_player()){//Aggresive
                // if(enemy_is_adjacent_to_player(e)){//Attack
                    // enemy_attack(e);
                    // return;
                // }
                // else{
                    // enemy_go_to_player(e);
                    // return;
                // }
            // }
            // else if(hp < ENEMY_INITIAL_HP/4){ //Flee
                // enemy_flee(e);
                // return;
            // }
        // }
    // }
    // enemy_roam(e);   
// }

// void enemy_AI_shy(Enemy* e){
    // u8 x, y;
    
    // x = e->position.x;
    // y = e->position.y;
    
    // if(dist(player_position.x, player_position.y, x,y)<ENEMY_VIEW_DISTANCE){
        // if(enemy_can_view(player_position.x,player_position.y, x, y)){
            // enemy_flee(e);
            // return;
        // }
    // }
    // enemy_roam(e);     
// }

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
                    enemy_AI_aggressive(enemy);
                    break;
                }
                // case 2:{
                    // enemy_AI_tactical(enemy);
                    // break;
                // }
                // case 3:{
                    // enemy_AI_shy(enemy);
                    // break;
                // }
            }
        }
        ++enemy;
    }
        
    // cpct_setBorder(g_palette[1]);
}