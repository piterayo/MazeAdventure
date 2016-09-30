
#include "Renderer.h"
#include "Textures.h"
#include "GlobalDefinitions.h"

#include "textures/walls_0.h"

u8** const theme_textures[4]={//TODO create textures
    g_tile_walls_0,g_tile_walls_0,g_tile_walls_0,g_tile_walls_0
};

void uncompress_texture(u8* texture, u8* position, u8 sizeX, u8 sizeY){
    u8 p1, p2;
    
    u8* currPos;
    
    //position=0;
    
    while(sizeX){
        // ++position;
        sizeY=TEXTURE_HEIGHT_HALF;
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
        ++position;
    }
    
}

void uncompress_theme_textures(u8 level){//TODO implement
    uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES,TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
    uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
    uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
    uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072),TEXTURE_WIDTH,TEXTURE_HEIGHT_HALF);
}

// void uncompress_shared_textures(){
    
// }
