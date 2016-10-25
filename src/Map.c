
#include "Map.h"
#include "Structures.h"
#include "Player.h"

#include "Level.h"

#include "GameFunctions.h"

#include "Renderer.h"

u16 rand_seed;

u16 map_get_seed(){
    return rand_seed;
}

u8 get_random_wall(){
    u8 cellType = cpct_getRandom_mxor_u8 ();
    if(cellType&1){ //1,3,5,7
        return CELLTYPE_WALL1;
    }
    else{
        if(cellType&3){//2,6
            return CELLTYPE_WALL2;
        }
        else{
            if(cellType&7){//4
                return CELLTYPE_WALL3;
            }
            else{//0
                return CELLTYPE_WALL4;  
            }
        }
    }
}

void generate_final_map(){
    u8 i,j;
    u8 (*map)[MAP_HEIGHT] = MAP_MEM;
    u8* m = MAP_MEM+1024;
    
    while(m>=MAP_MEM){
        *m=CELLTYPE_WALL1;
        --m;
    }
    //GENERATE BORDERS
    for(i=1;i<KING_LEVEL_WIDTH-1;++i){
        for(j=1;j<KING_LEVEL_HEIGHT-1;++j){
            map[j][i]=CELLTYPE_FLOOR;//get_random_wall();
        }
    }
    
    for(i=2;i<7;i+=2){
        map[i][2]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
        map[i][6]=(cpct_getRandom_mxor_u8 ()%2)?CELLTYPE_WALL2:CELLTYPE_WALL3;//get_random_wall();
    }
    
    map[KING_LEVEL_EXIT_Y][KING_LEVEL_EXIT_X] = CELLTYPE_DOOR;
    
    
    while(player_get_direction_index()!=MOVEMENT_NORTH){
        player_turn_left();
    }
    
    *(i8*)&(player_position.x) = KING_LEVEL_PLAYER_X;
    *(i8*)&(player_position.y) = KING_LEVEL_PLAYER_Y;
    
}

void generate_map(){
    
    u8 cellType, surroundedByWalls, convertToFloor, adjacentType,i, rotatePlayer;
    u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
    u8 (*map)[MAP_HEIGHT] = MAP_MEM;
    Vec2u* cellStack = (Vec2u*)GENERATOR_DATA_PTR;
    Vec2u* wallList = (Vec2u*)(GENERATOR_DATA_PTR+(MAP_SIZE));
    Vec2u* wallListPosition;
    Vec2u currentPos;
    u16 wallListCount = 0;
    u16 lastStackItem = 0;
    
    cpct_memset (GENERATOR_DATA_PTR, 0, 4096);
    
    (*cellStack).x = (cpct_getRandom_mxor_u8 ()%(MAP_WIDTH-2))+1; //RANDOM
    (*cellStack).y = (cpct_getRandom_mxor_u8 ()%(MAP_HEIGHT-2))+1; //RANDOM
    
    rotatePlayer = cpct_getRandom_mxor_u8 ()%4;
    while(rotatePlayer){
        player_turn_left();
        --rotatePlayer;
    }
    
    *(i8*)&(player_position.x) = (*cellStack).y;
    *(i8*)&(player_position.y) = (*cellStack).x;
    
    cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
    
    
    map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
    
    //GENERATE BORDERS
    for(i=0;i<MAP_WIDTH;++i){
        map[0][i]=CELLTYPE_WALL1;//get_random_wall();
        map[MAP_HEIGHT-1][i]=CELLTYPE_WALL1;//get_random_wall();
    }
    
    for(i=0;i<MAP_HEIGHT-1;++i){
        map[i][0]=CELLTYPE_WALL1;//get_random_wall();
        map[i][MAP_WIDTH-1]=CELLTYPE_WALL1;//get_random_wall();
    }
    
    while(remainingCells>0){
        wallListPosition = wallList+wallListCount;
        while(wallListCount<MAP_SIZE){
            
            currentPos.x = (*wallListPosition).x;
            currentPos.y = (*wallListPosition).y;
            
            convertToFloor=0;
            surroundedByWalls=1;
            
            if(currentPos.x>0){
                adjacentType = map[currentPos.x-1][currentPos.y];
                if(adjacentType == CELLTYPE_UNDEFINED){
                    convertToFloor  = 1;
                }
                else if(adjacentType == CELLTYPE_FLOOR){
                    surroundedByWalls = 0;
                }
            }
            if(currentPos.x < (MAP_WIDTH-1)){
                
                adjacentType = map[currentPos.x+1][currentPos.y];
                if(adjacentType == CELLTYPE_UNDEFINED){
                    convertToFloor  = 1;
                }
                else if(adjacentType == CELLTYPE_FLOOR){
                    surroundedByWalls = 0;
                }
            }
            if(currentPos.y > 0){
                
                adjacentType = map[currentPos.x][currentPos.y-1];
                if(adjacentType == CELLTYPE_UNDEFINED){
                    convertToFloor  = 1;
                }
                else if(adjacentType == CELLTYPE_FLOOR){
                    surroundedByWalls = 0;
                }
            }
            if(currentPos.y < (MAP_HEIGHT-1)){
                
                adjacentType = map[currentPos.x][currentPos.y+1];
                if(adjacentType == CELLTYPE_UNDEFINED){
                    convertToFloor  = 1;
                }
                else if(adjacentType == CELLTYPE_FLOOR){
                    surroundedByWalls = 0;
                }
            }
            
            (*wallListPosition).x = (*(wallList+wallListCount)).x;
            (*wallListPosition).y = (*(wallList+wallListCount)).y;
            --wallListCount;
            
            
            if((convertToFloor)&&(!surroundedByWalls)){
                map[currentPos.x][currentPos.y] = CELLTYPE_FLOOR;
                
                ++lastStackItem;
                (*(cellStack+lastStackItem)).x = currentPos.x;
                (*(cellStack+lastStackItem)).y = currentPos.y;
                
                
                break;
            }
            --wallListPosition;
        }
        while(lastStackItem<MAP_SIZE){
            currentPos.x=(*(lastStackItem+cellStack)).x;
            currentPos.y=(*(lastStackItem+cellStack)).y;
            --lastStackItem;
            cellType = map[currentPos.x][currentPos.y];
            
            if(cellType == CELLTYPE_UNDEFINED){
                
                if(cpct_getRandom_mxor_u8 ()&1){//WALL
                    cellType = get_random_wall();
                }
                else{//FLOOR
                    cellType = CELLTYPE_FLOOR;
                }
                map[currentPos.x][currentPos.y]=cellType;
                --remainingCells;
            }
            
            if((cellType == CELLTYPE_FLOOR)){
                 if(currentPos.x>0){
                    adjacentType = map[currentPos.x-1][currentPos.y];
                    if(adjacentType == CELLTYPE_UNDEFINED){
                                
                        ++lastStackItem;
                        (*(cellStack+lastStackItem)).x = currentPos.x-1;
                        (*(cellStack+lastStackItem)).y = currentPos.y;
                        
                    }
                }
                if(currentPos.x < (MAP_WIDTH-1)){
                    
                    adjacentType = map[currentPos.x+1][currentPos.y];
                    if(adjacentType == CELLTYPE_UNDEFINED){
                        
                                
                        ++lastStackItem;
                        (*(cellStack+lastStackItem)).x = currentPos.x+1;
                        (*(cellStack+lastStackItem)).y = currentPos.y;
                        
                    }
                }
                if(currentPos.y > 0){
                    
                    adjacentType = map[currentPos.x][currentPos.y-1];
                    if(adjacentType == CELLTYPE_UNDEFINED){
                        
                                
                        ++lastStackItem;
                        (*(cellStack+lastStackItem)).x = currentPos.x;
                        (*(cellStack+lastStackItem)).y = currentPos.y-1;
                        
                    }
                }
                if(currentPos.y < (MAP_HEIGHT-1)){
                    
                    adjacentType = map[currentPos.x][currentPos.y+1];
                    if(adjacentType == CELLTYPE_UNDEFINED){
                        
                                
                        ++lastStackItem;
                        (*(cellStack+lastStackItem)).x = currentPos.x;
                        (*(cellStack+lastStackItem)).y = currentPos.y+1;
                        
                    }
                }
            }
            else{
                ++wallListCount;
                (*(wallList+wallListCount)).x = currentPos.x;
                (*(wallList+wallListCount)).y = currentPos.y;
            }
        }
    }
}

void generate_exit_door(){
    u8 x=(cpct_getRandom_mxor_u8 ()%32);
    u8 y=(cpct_getRandom_mxor_u8 ()%32);
    u8 door_not_positioned=1;
    
    u8* lastVal;
    u8* nextVal;
    u8* topVal;
    u8* bottomVal;
    
    u8* position = (u8*)(MAP_MEM + x + MAP_WIDTH*y);
    
    // x=x%32;
    // y=y%32;
    
    lastVal = (position-1);
    nextVal = (position+1);
    topVal = (position-MAP_WIDTH);
    bottomVal = (position+MAP_WIDTH);
    
    while(door_not_positioned){
        if((*position)!=CELLTYPE_FLOOR){
            if((((*lastVal)!=CELLTYPE_FLOOR) || (lastVal<MAP_MEM) )&& (((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM))){
                if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)==CELLTYPE_FLOOR)&&(bottomVal<END_OF_MAP_MEM))){
                    door_not_positioned=0;
                    *position=CELLTYPE_DOOR;
                }
                else if((((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM)) && (((*topVal)==CELLTYPE_FLOOR)&&(topVal>=MAP_MEM))){
                    door_not_positioned=0;
                    *position=CELLTYPE_DOOR;
                }
            }
            else if((((*topVal)!=CELLTYPE_FLOOR)||(topVal<MAP_MEM)) && (((*bottomVal)!=CELLTYPE_FLOOR)||(bottomVal>=END_OF_MAP_MEM))){
                if((((*lastVal)!=CELLTYPE_FLOOR)|| (lastVal<MAP_MEM) ) && (((*nextVal)==CELLTYPE_FLOOR)&&(nextVal<END_OF_MAP_MEM))){
                    door_not_positioned=0;
                    *position=CELLTYPE_DOOR;
                }
                else if((((*nextVal)!=CELLTYPE_FLOOR)||(nextVal>=END_OF_MAP_MEM)) && (((*lastVal)==CELLTYPE_FLOOR)&&(lastVal>=MAP_MEM))){
                    door_not_positioned=0;
                    *position=CELLTYPE_DOOR;
                }
            }
        }
        ++position;
        ++lastVal;
        ++nextVal;
        ++topVal;
        ++bottomVal;
        if(position==END_OF_MAP_MEM){
            position = MAP_MEM;
            lastVal = (position-1);
            nextVal = (position+1);
            topVal = (position-MAP_WIDTH);
            bottomVal = (position+MAP_WIDTH);
        }
    }
    
}

void generate_level(){
    generate_level_with_seed(r_counter);
}

void generate_level_with_seed(u16 seed) {
    
    rand_seed=seed;
    // cpct_setSeed_lcg_u8(seed+level_get_level());
    
    cpct_setSeed_mxor(((seed+level_get_level())&0xFFFE) + 1);
    cpct_restoreState_mxor_u8();
    
    if(level_get_level()<KING_LEVEL){
        generate_map();
        generate_exit_door();
    }
    else{
        generate_final_map();
    }
}