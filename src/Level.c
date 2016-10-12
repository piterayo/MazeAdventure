#include "Level.h"

#include "Renderer.h"

#include "Textures.h"

#include "GameDefinitions.h"


u8 current_level;

const u8 level_palettes[4][VARIABLE_COLORS]={
    {0,9,3,18,10,20,0,4,17,14},
    {11,21,3,9,25,15,1,2,17,14},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
};

u8 level_get_level(){
    return current_level;
}

void level_set_level(u8 l){
    current_level=l;
}

void level_init_palettes(){
   cpct_fw2hw(level_palettes[0],VARIABLE_COLORS);
   cpct_fw2hw(level_palettes[1],VARIABLE_COLORS);
   cpct_fw2hw(level_palettes[2],VARIABLE_COLORS);
   cpct_fw2hw(level_palettes[3],VARIABLE_COLORS);
}

void setLevelPalette(u8 i){
    cpct_memcpy(g_palette+SHARED_COLORS, level_palettes[i],VARIABLE_COLORS);
    cpct_setPalette(g_palette,16);
}

void level_load_level(){
    u8 index;
    
    index =((current_level<8)?0:(
            (current_level<24)?1:(
            (current_level<56)?2:(
            (current_level<120)?4:0
            ))));
    
    uncompress_theme_textures(index);
    uncompress_enemy_textures(index);
    setLevelPalette(index);
    
}