
#include "Player.h"

const Vec2u player_position = {
    1,1
};

const Vec2i player_direction = 
{
    1,0
};

const u8 player_directionIndex=0;

const i8 player_directionArray[8]={
    1,0,0,-1,-1,0,0,1
};

void player_turn_left(){
    *(u8*)&(player_directionIndex)=(player_directionIndex+2)&7;
    *(i8*)&(player_direction.x) = player_directionArray[(player_directionIndex)];
    *(i8*)&(player_direction.y) = player_directionArray[((player_directionIndex)+1)];
}

void player_turn_right(){
                
    *(u8*)&(player_directionIndex)=(player_directionIndex-2)&7;
    *(i8*)&(player_direction.x) = player_directionArray[(player_directionIndex)];
    *(i8*)&(player_direction.y) = player_directionArray[((player_directionIndex)+1)];
}

void player_move_forward(){
    *(i8*)&(player_position.x) = player_position.x + player_direction.x;
    *(i8*)&(player_position.y) = player_position.y + player_direction.y;
}

u8 player_get_direction_index(){
    return player_directionIndex;
}