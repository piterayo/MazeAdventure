#include "UI_GameMenu.h"

#include "StringUtils.h"
#include "Renderer.h"

#define UI_GAMEMENU_BUTTON_ROTATE_LEFT_POSITION 0xC550
#define UI_GAMEMENU_BUTTON_ROTATE_RIGHT_POSITION 0xC566

#define UI_GAMEMENU_BUTTON_MOVE_FORWARD_POSITION 0xC6E3

#define UI_GAMEMENU_BUTTON_ACTION_POSITION 0xC584

#define UI_GAMEMENU_BUTTON_INVENTORY_POSITION 0xC593

#define UI_GAMEMENU_BUTTON_PAUSE_POSITION 0xC723

#define UI_GAMEMENU_ENTRIES 6

#define UI_GAMEMENU_BUTTON_HEIGHT 24

u8 ui_gamemenu_lastEntry=0;
u8 ui_gamemenu_entryIndex=0;
u8 ui_gamemenu_entrySelected=0;

u8 ui_gamemenu_action=0;

const u8* const ui_gamemenu_entriesPosition[UI_GAMEMENU_ENTRIES]={
    UI_GAMEMENU_BUTTON_ROTATE_LEFT_POSITION,UI_GAMEMENU_BUTTON_MOVE_FORWARD_POSITION,UI_GAMEMENU_BUTTON_ROTATE_RIGHT_POSITION,
    UI_GAMEMENU_BUTTON_ACTION_POSITION,UI_GAMEMENU_BUTTON_INVENTORY_POSITION,UI_GAMEMENU_BUTTON_PAUSE_POSITION
};

const char* const ui_gamemenu_action_buttonText[3]={
    "PICK UP","ATTACK","NEXT LEVEL",
};

const char* const ui_gamemenu_buttonText[UI_GAMEMENU_ENTRIES]={
    "<","MOVE",">","","INV","PAUSE",
};

const u8 ui_gamemenu_buttonWidths[UI_GAMEMENU_ENTRIES]={
    6,22,6,13,13,13
};

void ui_gamemenu_init(){
    ui_gamemenu_lastEntry=0;
    ui_gamemenu_entryIndex=0;
    ui_gamemenu_entrySelected=0;
}

void ui_gamemenu_next_entry(){
    if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1)){
        ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
        ++ui_gamemenu_entryIndex;
    }
}

void ui_gamemenu_previous_entry(){
    if(ui_gamemenu_entryIndex>0){
        ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
        --ui_gamemenu_entryIndex;
    }
}

void ui_gamemenu_unselect_entry(){
    ui_gamemenu_entrySelected=0;
}

void ui_gamemenu_select_entry(){
    ui_gamemenu_entrySelected=1;
}


void ui_gamemenu_render_refresh(){
    u8 color;
    
    color = (ui_gamemenu_entrySelected)? g_colors[4]: g_colors[5];
    cpct_drawSolidBox(ui_gamemenu_entriesPosition[ui_gamemenu_entryIndex],color, ui_gamemenu_buttonWidths[ui_gamemenu_entryIndex], UI_GAMEMENU_BUTTON_HEIGHT);
    print_transparent_text(ui_gamemenu_buttonText[ui_gamemenu_entryIndex], ui_gamemenu_entriesPosition[ui_gamemenu_entryIndex], 3);
    
    if(ui_gamemenu_lastEntry!=ui_gamemenu_entryIndex){
        color = g_colors[2];
        cpct_drawSolidBox(ui_gamemenu_entriesPosition[ui_gamemenu_lastEntry],color, ui_gamemenu_buttonWidths[ui_gamemenu_lastEntry], UI_GAMEMENU_BUTTON_HEIGHT);
        print_transparent_text(ui_gamemenu_buttonText[ui_gamemenu_lastEntry], ui_gamemenu_entriesPosition[ui_gamemenu_lastEntry], 3);
        ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
    }
        
}

void ui_gamemenu_render_all(){
    u8 n=UI_GAMEMENU_ENTRIES, color;
    
    
    while(n){
        --n;
        color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
        cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
        print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesPosition[n], 3);
    }
    
    ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
}

u8 ui_gamemenu_get_entry(){
    return ui_gamemenu_entryIndex;
}

u8 ui_gamemenu_is_selected(){
    return ui_gamemenu_entrySelected;
}
