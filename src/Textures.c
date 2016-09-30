
#include "Renderer.h"
#include "Textures.h"
#include "GlobalDefinitions.h"

#include "textures/walls_0.h"

u8** const theme_textures[4]={//TODO create textures
    g_tile_walls_0,g_tile_walls_0,g_tile_walls_0,g_tile_walls_0
};

void uncompress_texture(u8* texture, u8* position){
    u8 p1, p2, i=TEXTURE_WIDTH, j=TEXTURE_HEIGHT_HALF;
    
    u8* currPos;
    
    //position=0;
    
    while(i){
        // ++position;
        j=TEXTURE_HEIGHT_HALF;
        currPos = position;
        while(j){//TEXTURE_HEIGHT_HALF -> 2 pixels per byte of compressed texture
            p1 = (*texture) & pixelMask[0];
            p1= p1 | (p1>>1);
            *currPos = p1;
            currPos+=TEXTURE_WIDTH;
            
            p2 = (*texture) & pixelMask[1];
            p2 = p2 | (p2<<1);
            *currPos = p2;
            currPos+=TEXTURE_WIDTH;
            --j;
            ++texture;
        }
        --i;
        ++position;
    }
    
}

void uncompress_theme_textures(u8 level){//TODO implement
    uncompress_texture(theme_textures[level][0],(u8*)UNCOMPRESSED_LEVEL_TEXTURES);
    uncompress_texture(theme_textures[level][1],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+1024));
    uncompress_texture(theme_textures[level][2],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+2048));
    uncompress_texture(theme_textures[level][3],(u8*)(UNCOMPRESSED_LEVEL_TEXTURES+3072));
}

// void uncompress_shared_textures(){
    
// }
