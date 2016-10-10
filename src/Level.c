#include "Level.h"

#include "Renderer.h"

#include "Textures.h"

const u8 level_palettes[4][9]={
    {5,10,17,14,12,9,15,1,2},
    {20,19,17,14,18,9,15,3,10},
    {0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0},
};

void level_init_palettes(){
   cpct_fw2hw(level_palettes[0],9);
   cpct_fw2hw(level_palettes[1],9);
   cpct_fw2hw(level_palettes[2],9);
   cpct_fw2hw(level_palettes[3],9);
}

void setLevelPalette(u8 i){
    cpct_memcpy(g_palette+7, level_palettes[i],9);
    cpct_setPalette(g_palette,16);
}

void level_load_level(u8 l){
    u8 index;
    
    index =((l<8)?0:(
            (l<24)?1:(
            (l<56)?2:(
            (l<120)?4:0
            ))));
    
    uncompress_theme_textures(index);
    uncompress_enemy_textures(index);
    setLevelPalette(index);
    
}