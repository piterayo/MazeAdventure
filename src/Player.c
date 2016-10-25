
#include "Player.h"

#include "GameFunctions.h"

#define PLAYER_MAX_HP 255

u8 player_defense_value;
u8 player_attack_value;

u8 player_health_points;

u8 player_is_dead;

u8 player_has_key;
u8 player_potion_count;
u8 player_scroll_count;

const Vec2u player_position = {
    1,1
};

const Vec2i player_direction = 
{
    1,0
};

u8 player_directionIndex;

void player_init(){
    player_attack_value = 52;
    player_defense_value = 8;
    player_is_dead=0;
    
    player_health_points = PLAYER_MAX_HP;
    player_has_key=0;
    player_potion_count=0;
    player_scroll_count=0;
    
}

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