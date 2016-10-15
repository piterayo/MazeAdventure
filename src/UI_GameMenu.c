#include "UI_GameMenu.h"

#include "GameDefinitions.h"

#include "Player.h"

#include "StringUtils.h"
#include "Renderer.h"

#define UI_GAMEMENU_BUTTON_ROTATE_LEFT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,0,176))
#define UI_GAMEMENU_BUTTON_ROTATE_RIGHT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,22,176))

#define UI_GAMEMENU_BUTTON_MOVEMENT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,7,176))

#define UI_GAMEMENU_BUTTON_ACTION_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,0,136))

#define UI_GAMEMENU_BUTTON_INVENTORY_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,52,136))

#define UI_GAMEMENU_BUTTON_WAIT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,52,176))

#define UI_GAMEMENU_BUTTON_PAUSE_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,67,176))


#define UI_GAMEMENU_BUTTON_ROTATE_LEFT_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,0+2,176+9))
#define UI_GAMEMENU_BUTTON_ROTATE_RIGHT_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,22+2,176+9))

#define UI_GAMEMENU_BUTTON_MOVEMENT_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,7+3,176+9))

#define UI_GAMEMENU_BUTTON_ACTION_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,0+4,136+9))

#define UI_GAMEMENU_BUTTON_INVENTORY_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,52+5,136+9))

#define UI_GAMEMENU_BUTTON_WAIT_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,52+3,176+9))

#define UI_GAMEMENU_BUTTON_PAUSE_TEXT_POSITION (SCREEN_PTR_AT(CPCT_VMEM_START,67+2,176+9))

#define UI_GAMEMENU_ENTRIES 7

#define UI_GAMEMENU_BUTTON_HEIGHT 24

u8 ui_gamemenu_lastEntry=0;
u8 ui_gamemenu_entryIndex=0;
u8 ui_gamemenu_entrySelected=0;

u8 ui_gamemenu_can_move=0;
u8 ui_gamemenu_action=0;

const u8* const ui_gamemenu_entriesPosition[UI_GAMEMENU_ENTRIES]={
    UI_GAMEMENU_BUTTON_ACTION_POSITION,UI_GAMEMENU_BUTTON_INVENTORY_POSITION,
    UI_GAMEMENU_BUTTON_ROTATE_LEFT_POSITION,UI_GAMEMENU_BUTTON_MOVEMENT_POSITION,UI_GAMEMENU_BUTTON_ROTATE_RIGHT_POSITION,
    UI_GAMEMENU_BUTTON_WAIT_POSITION,UI_GAMEMENU_BUTTON_PAUSE_POSITION
};

const u8* const ui_gamemenu_entriesTextPosition[UI_GAMEMENU_ENTRIES]={
    UI_GAMEMENU_BUTTON_ACTION_TEXT_POSITION,UI_GAMEMENU_BUTTON_INVENTORY_TEXT_POSITION,
    UI_GAMEMENU_BUTTON_ROTATE_LEFT_TEXT_POSITION,UI_GAMEMENU_BUTTON_MOVEMENT_TEXT_POSITION,UI_GAMEMENU_BUTTON_ROTATE_RIGHT_TEXT_POSITION,
    UI_GAMEMENU_BUTTON_WAIT_TEXT_POSITION,UI_GAMEMENU_BUTTON_PAUSE_TEXT_POSITION
};

const char* const ui_gamemenu_action_buttonText[4]={
    "NEXT LEVEL","  ATTACK","   PICK UP",
};

const char* const ui_gamemenu_buttonText[UI_GAMEMENU_ENTRIES]={
    "","INVENTORY","<","",">","WAIT","PAUSE",
};

const u8 ui_gamemenu_buttonWidths[UI_GAMEMENU_ENTRIES]={
    28,28,6,14,6,13,13
};

void ui_gamemenu_init(){
    ui_gamemenu_lastEntry=0;
    ui_gamemenu_entryIndex=0;
    ui_gamemenu_entrySelected=0;
    ui_gamemenu_update_action();
}

void ui_gamemenu_above_entry(){
    if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
        ui_gamemenu_entryIndex=0;
    }
    else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
        ui_gamemenu_entryIndex=1;
    }
}

void ui_gamemenu_below_entry(){
    if(ui_gamemenu_entryIndex==0){
        ui_gamemenu_entryIndex=3;
    }
    else if(ui_gamemenu_entryIndex==1){
        ui_gamemenu_entryIndex=5;
    }
}

void ui_gamemenu_next_entry(){
    if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
        ++ui_gamemenu_entryIndex;
    }
}

void ui_gamemenu_previous_entry(){
    if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
        --ui_gamemenu_entryIndex;
    }
}

void ui_gamemenu_unselect_entry(){
    ui_gamemenu_entrySelected=0;
}

void ui_gamemenu_select_entry(){
    ui_gamemenu_entrySelected=1;
}

void ui_gamemenu_render_button(u8 n){
    u8 color;
    color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
    cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
    if(n==0 && ui_gamemenu_action){
        print_transparent_text(ui_gamemenu_action_buttonText[ui_gamemenu_action-1], ui_gamemenu_entriesTextPosition[n], 3);
    }
    else if(n==3 && ui_gamemenu_can_move){
        print_transparent_text("MOVE", ui_gamemenu_entriesTextPosition[n], 3);
    }
    else{
        print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
    }
}

void ui_gamemenu_render_refresh(){
    
    ui_gamemenu_render_button(ui_gamemenu_entryIndex);
    ui_gamemenu_render_button(ui_gamemenu_lastEntry);
        
        
    ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
        
}

void ui_gamemenu_render_all(){
    u8 n=UI_GAMEMENU_ENTRIES;
    
    
    while(n){
        --n;
        ui_gamemenu_render_button(n);
    }
    
    ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
}

u8 ui_gamemenu_get_entry(){
    return ui_gamemenu_entryIndex;
}

u8 ui_gamemenu_is_selected(){
    return ui_gamemenu_entrySelected;
}

void ui_gamemenu_update_action(){
    u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
    
    ui_gamemenu_can_move=0;
    ui_gamemenu_action=0;
    
    if(forward&CELL_WALL_MASK){
        if(forward==CELLTYPE_DOOR){
            ui_gamemenu_action=1;
        }
    } 
    else if(forward&CELL_ENEMY_MASK) ui_gamemenu_action=2;
    else if(forward&CELL_ITEM_MASK) ui_gamemenu_action=3;
    else{
        ui_gamemenu_can_move=1;
    }
    ui_gamemenu_render_button(0);
    ui_gamemenu_render_button(3);
}

u8 ui_gamemenu_get_movement(){
    return ui_gamemenu_can_move;
}

u8 ui_gamemenu_get_action(){
    return ui_gamemenu_action;
}
