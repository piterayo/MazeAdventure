
#include "Map.h"
#include "Structures.h"
#include "Player.h"

#include "Renderer.h"

const u8 rand_seed=0;

void init_generator(){
    cpct_setSeed_lcg_u8(rand_seed);
}

void generate_map(){
    
    u8 cellType, surroundedByWalls, convertToFloor, adjacentType,i;
    u16 remainingCells = MAP_SIZE-(MAP_WIDTH*2)-((MAP_HEIGHT-2)*2)-1;
    u8 (*map)[MAP_HEIGHT] = MAP_MEM;
    Vec2u* cellStack = (Vec2u*)GENERATOR_DATA_PTR;
    Vec2u* wallList = (Vec2u*)(GENERATOR_DATA_PTR+(MAP_SIZE));
    Vec2u* wallListPosition;
    Vec2u currentPos;
    u16 wallListCount = 0;
    u16 lastStackItem = 0;
    
    (*cellStack).x = (cpct_getRandom_lcg_u8()%(MAP_WIDTH-2))+1; //RANDOM
    (*cellStack).y = (cpct_getRandom_lcg_u8()%(MAP_HEIGHT-2))+1; //RANDOM
    
    
    *(i8*)&(PLAYER_position.x) = (*cellStack).y;
    *(i8*)&(PLAYER_position.y) = (*cellStack).x;
    
    cpct_memset (MAP_MEM,CELLTYPE_UNDEFINED,MAP_SIZE);
    
    map[(*cellStack).x][(*cellStack).y] = CELLTYPE_FLOOR;
    
    //GENERATE BORDERS
    for(i=0;i<MAP_WIDTH;++i){
        map[0][i]=cpct_getRandom_lcg_u8()&3;
        map[MAP_HEIGHT-1][i]=cpct_getRandom_lcg_u8()&3;
    }
    
    for(i=1;i<MAP_HEIGHT-1;++i){
        map[i][0]=cpct_getRandom_lcg_u8()&3;
        map[i][MAP_WIDTH-1]=cpct_getRandom_lcg_u8()&3;
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
                
                if(cpct_getRandom_lcg_u8()&1){//WALL
                    cellType = cpct_getRandom_lcg_u8()&3;
                }
                else{//FLOOR
                    cellType = CELLTYPE_FLOOR;
                }
                //cellType = (cpct_getRandom_lcg_u8()&1)?CELLTYPE_FLOOR:CELLTYPE_WALL1;
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