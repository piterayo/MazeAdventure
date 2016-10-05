
#include "Renderer.h"
#include "Textures.h"
#include "GlobalDefinitions.h"

#include "textures/walls_0.h"
#include "sprites/enemies/level0_enemies.h"

u8** const theme_textures[4]={//TODO create textures
    g_tile_walls_0,g_tile_walls_0,g_tile_walls_0,g_tile_walls_0
};

u8** const enemy_textures[4]={//TODO create textures
    level0_enemies_tileset,level0_enemies_tileset,level0_enemies_tileset,level0_enemies_tileset
};

void uncompress_texture(u8* texture, u8* position, u8 sizeX, u8 sizeY){
    u8 p1, p2, tex_height=sizeY;
    
    u8* currPos;
    
    //position=0;
    
    while(sizeX){
        // ++position;
        currPos = position;
        while(sizeY){
            p1 = (*texture) & pixelMask[0];
            p1= p1 | (p1>>1);
            *currPos = p1;
            currPos+=TEXTURE_WIDTH;
            
            p2 = (*texture) & pixelMask[1];
            p2 = p2 | (p2<<1);
            *currPos = p2;
            currPos+=TEXTURE_WIDTH;
            --sizeY;
            ++texture;
        }
        --sizeX;
        sizeY=tex_height;
        ++position;
    }
    
}

void uncompress_theme_textures(u8 level){//TODO implement
    uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
    uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
    uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
    uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
}

void uncompress_enemy_textures(u8 level){
    uncompress_texture(enemy_textures[level][0],(u8*)UNCOMPRESSED_ENEMY_TEXTURES,ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
    uncompress_texture(enemy_textures[level][1],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+576),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
    uncompress_texture(enemy_textures[level][2],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1152),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
    uncompress_texture(enemy_textures[level][3],(u8*)(UNCOMPRESSED_ENEMY_TEXTURES+1728),ENEMY_SPRITE_WIDTH,ENEMY_SPRITE_HEIGHT_HALF);
}

void uncompress_item_textures(){
    
}

// void uncompress_shared_textures(){
    
// }