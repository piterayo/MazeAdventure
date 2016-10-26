
#include "GameFunctions.h"

#include "Map.h"
#include "Renderer.h"
#include "Level.h"


u16 r_counter;

u8 music_on;
u8 textures_on;

u8 syncmusic_counter;
void* currentMusic;

u8 camelot_warriors_mode;

void game_interrupt_handler(){
    ++r_counter;
    ++syncmusic_counter;
    if(syncmusic_counter==6){
        syncmusic_counter=0;
        if(currentMusic && music_on){
            cpct_akp_musicPlay();
            if (cpct_akp_songLoopTimes > 0){
                cpct_akp_musicInit(currentMusic);
            }
        }
    }
}


const i8 movement_directionArray[8]={
    1,0,0,-1,-1,0,0,1
};

void set_music(void* m){
    currentMusic=m;
    cpct_akp_musicInit(currentMusic);
}

void remove_music(){
    cpct_akp_stop();
    currentMusic=0;
}

void stop_music(){
    cpct_akp_stop();
}

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
    
    syncmusic_counter=0;
    currentMusic = 0;
    
    
    
    camelot_warriors_mode=0;
    
    // *((u8*)0x0000)=0xC9; //Set 0x0000 memory to always return
}