
#include "Player.h"

#include "GameFunctions.h"

const Vec2u player_position = {
    1,1
};

const Vec2i player_direction = 
{
    1,0
};

u8 player_directionIndex;

void player_turn_left(){
    (player_directionIndex)=(player_directionIndex+2)&7;
    *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
    *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
}

void player_turn_right(){
                
    (player_directionIndex)=(player_directionIndex-2)&7;
    *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
    *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
}

void player_move_forward(){
    *(i8*)&(player_position.x) = player_position.x + player_direction.x;
    *(i8*)&(player_position.y) = player_position.y + player_direction.y;
}

u8 player_get_direction_index(){
    return player_directionIndex;
}