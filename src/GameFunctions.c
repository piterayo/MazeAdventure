
#include "GameFunctions.h"

#include "Map.h"
#include "Renderer.h"
#include "Level.h"


u16 r_counter;

u8 music_on;
u8 textures_on;

u8 camelot_warriors_mode;

void game_interrupt_handler(){
    ++r_counter;
}


const i8 movement_directionArray[8]={
    1,0,0,-1,-1,0,0,1
};

void game_init(){
    cpct_disableFirmware();
    cpct_setVideoMode(0);
    
    cpct_fw2hw(g_palette,16);
    
    cpct_setInterruptHandler(game_interrupt_handler);
    level_init_palettes();
    cpct_setPalette(g_palette,16);
    cpct_setBorder(g_palette[1]);
    
    music_on = 1;
    textures_on = 1;
    
    
    camelot_warriors_mode=0;
    
    // *((u8*)0x0000)=0xC9; //Set 0x0000 memory to always return
}