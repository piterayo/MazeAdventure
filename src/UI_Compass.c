#include "UI_Compass.h"

#include "Player.h"
#include "textures/compass.h"

void renderCompass(){
    cpct_drawSprite(compass_tileset[player_get_direction_index()/2],COMPASS_POSITION,8,16);
}