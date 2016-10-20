
#include "UI_PlayerStats.h"
#include "Renderer.h"
#include "StringUtils.h"

#define UI_PLAYERSTATS_POSITION 0xC000+160

#define UI_PLAYERSTATS_WIDTH 20

#define UI_PLAYERSTATS_TEXT_COLOR 3

#define UI_PLAYERSTATS_HEALTHBAR_FG_COLOR 5

#define UI_PLAYERSTATS_HEALTHBAR_BG_COLOR 4

const char* const strings[5]={
    " 10:10","+ 1.00","# 0.00","&  000","$    0",
};

void ui_playerstats_render(){
    print_transparent_text("STATS", UI_PLAYERSTATS_POSITION+1, UI_PLAYERSTATS_TEXT_COLOR);
    
    print_transparent_text("HP", UI_PLAYERSTATS_POSITION+160, UI_PLAYERSTATS_TEXT_COLOR);
    cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_FG_COLOR], 10,4);
    print_transparent_text(strings[0], UI_PLAYERSTATS_POSITION+240, UI_PLAYERSTATS_TEXT_COLOR);
    print_transparent_text(strings[1], UI_PLAYERSTATS_POSITION+320, UI_PLAYERSTATS_TEXT_COLOR);
    print_transparent_text(strings[2], UI_PLAYERSTATS_POSITION+400, UI_PLAYERSTATS_TEXT_COLOR);
    print_transparent_text(strings[3], UI_PLAYERSTATS_POSITION+480, UI_PLAYERSTATS_TEXT_COLOR);
    print_transparent_text(strings[4], UI_PLAYERSTATS_POSITION+560, UI_PLAYERSTATS_TEXT_COLOR);
}