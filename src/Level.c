#include "Level.h"

#include "Renderer.h"

#include "Textures.h"

#include "GameDefinitions.h"


u8 current_level;

const u8 menu_palette[VARIABLE_COLORS]={
    1,2,24,18,21,16,3,0,17
};

const u8 level_palettes[4][VARIABLE_COLORS]={
    {0,9,20,11,10,13,18,3,17},
    {11,21,20,10,16,3,24,25,17},
    {1,11,25,24,16,3,2,18,17},
    {13,3,25,24,26,0,0,0,17},
};

u8 level_get_level(){
    return current_level;
}

void level_set_level(u8 l) {
    current_level=l;
}

void level_init_palettes(){
   cpct_fw2hw(level_palettes[0],VARIABLE_COLORS);
   cpct_fw2hw(level_palettes[1],VARIABLE_COLORS);
   cpct_fw2hw(level_palettes[2],VARIABLE_COLORS);
   cpct_fw2hw(level_palettes[3],VARIABLE_COLORS);
   cpct_fw2hw(menu_palette,VARIABLE_COLORS);
}

void setMenuPalette(){
    cpct_memcpy(g_palette+SHARED_COLORS, menu_palette,VARIABLE_COLORS);
    cpct_setPalette(g_palette,16);
}

void setLevelPalette(u8 i){
    cpct_memcpy(g_palette+SHARED_COLORS, level_palettes[i],VARIABLE_COLORS);
    cpct_setPalette(g_palette,16);
}

void level_load_level(){
    u8 index=current_level>>3;
    u8 enemIndex;
    
    enemIndex = index;
    
    if(current_level==KING_LEVEL) index = 3;
    // if(camelot_mode) enemIndex = 5;
    
    uncompress_theme_textures(index);
    uncompress_enemy_textures(enemIndex);
    uncompress_item_textures();
    setLevelPalette(index);
}