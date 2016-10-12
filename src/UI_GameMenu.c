#include "UI_GameMenu.h"

#include "Renderer.h"

#define BUTTON_ROTATE_LEFT_POSITION 0xC550
#define BUTTON_ROTATE_RIGHT_POSITION 0xC566

#define BUTTON_MOVE_FORWARD_POSITION 0xC6E3

#define BUTTON_ACTION_POSITION 0xC584

#define BUTTON_INVENTORY_POSITION 0xC593

#define BUTTON_PAUSE_POSITION 0xC723

#define ENTRIES 6

#define BUTTON_HEIGHT 24

u8 entryIndex=0;
u8 entrySelected=0;

const u8* const entriesPosition[ENTRIES]={
    BUTTON_ROTATE_LEFT_POSITION,BUTTON_MOVE_FORWARD_POSITION,BUTTON_ROTATE_RIGHT_POSITION,
    BUTTON_ACTION_POSITION,BUTTON_INVENTORY_POSITION,BUTTON_PAUSE_POSITION
};

const char* const buttonText[ENTRIES]={
    "","MOVE","","ATTACK","INV","PAUSE",
};

const u8 buttonWidths[ENTRIES]={
    6,22,6,13,13,13
};

void ui_gamemenu_next_entry(){
    if(entryIndex<(ENTRIES-1)){
        ++entryIndex;
    }
}

void ui_gamemenu_previous_entry(){
    if(entryIndex>0){
        --entryIndex;
    }
}

void ui_gamemenu_unselect_entry(){
    entrySelected=0;
}

void ui_gamemenu_select_entry(){
    entrySelected=1;
}

void ui_gamemenu_render(){
    u8 n=ENTRIES, color;
    
    cpct_setBorder(g_palette[0]);
    
    while(n){
        --n;
        color = (n==entryIndex)?((entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
        cpct_drawSolidBox(entriesPosition[n],color, buttonWidths[n], BUTTON_HEIGHT);
    }
    
    cpct_setBorder(g_palette[1]);
    
}

u8 ui_gamemenu_get_entry(){
    return entryIndex;
}

u8 ui_gamemenu_is_selected(){
    return entrySelected;
}
