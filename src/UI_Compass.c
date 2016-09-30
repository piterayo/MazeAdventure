#include "UI_Compass.h"

#include "Player.h"
#include "textures/compass.h"

void renderCompass(){
    cpct_drawSprite(g_tile_compass[PLAYER_directionIndex/2],COMPASS_POSITION,8,16);
}