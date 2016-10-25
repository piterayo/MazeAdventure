
#include "Renderer.h"
#include "Textures.h"
#include "GameDefinitions.h"
#include "GameFunctions.h"

#include "textures/walls/level0_walls.h"
#include "textures/walls/level1_walls.h"
#include "textures/walls/level2_walls.h"
#include "textures/walls/level3_walls.h"

#include "textures/enemies/rat_enemy.h"
#include "textures/enemies/king_enemy.h"
#include "textures/enemies/camelot_enemy.h"

#include "textures/enemies/level0_enemies.h"
#include "textures/enemies/level1_enemies.h"
#include "textures/enemies/level2_enemies.h"
#include "textures/enemies/level3_enemies.h"

#include "textures/items_tileset.h"

u8* const theme_textures[4]={//TODO create textures
    level0_walls,level1_walls,level2_walls,level3_walls
};

const u16 const theme_textures_length[4]={
    level0_walls_LENGTH,level1_walls_LENGTH,level2_walls_LENGTH,level3_walls_LENGTH
};

u8* const enemy_textures[5]={//TODO create textures
    level0_enemies,level1_enemies,level2_enemies,level3_enemies,king_enemy
};

const u16 const enemy_textures_length[5]={
    level0_enemies_LENGTH,level1_enemies_LENGTH,level2_enemies_LENGTH,level3_enemies_LENGTH,king_enemy_LENGTH
};


void uncompress_texture_rle(u8* position, u8* texture_set, u16 length){
    u8 counter, value;
    
    while(length){
        value = (*texture_set)&0x0F;
        counter = ((*texture_set)>>4)+1;
        while(counter){
            *position=g_colors[value];
            ++position;
            --counter;
        };
        ++texture_set;
        --length;
    }
}

void uncompress_theme_textures(u8 level) {//TODO implement
    uncompress_texture_rle((u8*)UNCOMPRESSED_TEXTURES, theme_textures[level], theme_textures_length[level]);    
    
}

void uncompress_enemy_textures(u8 level) {
    if(camelot_warriors_mode){
        uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
        uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,camelot_enemy,camelot_enemy_LENGTH);
    }
    else{
        uncompress_texture_rle((u8*)UNCOMPRESSED_RAT_TEXTURE,rat_enemy,rat_enemy_LENGTH);
        uncompress_texture_rle((u8*)UNCOMPRESSED_ENEMY_TEXTURE,enemy_textures[level],enemy_textures_length[level]);
    }
}

void uncompress_item_textures(){
    uncompress_texture_rle((u8*)UNCOMPRESSED_OBJECT_TEXTURES, items_tileset, items_tileset_LENGTH);
}

