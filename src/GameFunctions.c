
#include "GameFunctions.h"

#include "Map.h"
#include "Renderer.h"
#include "Level.h"


u8 r_counter = 0;

void game_interrupt_handler(){
    //scan_input();
    ++r_counter;
}

void game_init(){
    cpct_disableFirmware();
    cpct_setVideoMode(0);
    cpct_fw2hw(g_palette,16);
    cpct_setInterruptHandler(game_interrupt_handler);
    level_init_palettes();
    cpct_setPalette(g_palette,16);
    cpct_setBorder(g_palette[1]);
    // Clear Screen
    cpct_memset(CPCT_VMEM_START, g_colors[0], 0x4000);
}