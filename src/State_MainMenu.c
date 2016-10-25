
#include "State_MainMenu.h"

#include "State_LoadLevel.h"

#include "UI_MainMenu.h"

#include "StateManager.h"

#include "GameDefinitions.h"

#include "GameFunctions.h"

#include "Renderer.h"

#include "Player.h"

#include "StringUtils.h"

#include "Level.h"

#include "textures/menu_bg.h"

void dec_main_bg(){
    u8 counter, value, newPos, col;
    u16 length;
    u8* texture_set;
    u8* position;
    newPos=0;
    texture_set = menu_bg;
    length = menu_bg_LENGTH;
    position=MANUALLY_ALLOCATED_MEMORY_START;
    *position=0;
    
    
    while(length){
        value = g_colors[(*texture_set)&0x0F];
        counter = ((*texture_set)>>4)+1;
        while(counter){
            *position=(*position)|((newPos&1)?(value&0b01010101):(value&0b10101010));
            if(newPos&1){
                ++position;
                *position=0;
            }
            ++newPos;
            --counter;
        }
        ++texture_set;
        --length;
    }
    
    cpct_memcpy((MANUALLY_ALLOCATED_MEMORY_START+4000),MANUALLY_ALLOCATED_MEMORY_START,4000);
    cpct_hflipSpriteM0 (40, 100, (MANUALLY_ALLOCATED_MEMORY_START+4000));
}

void draw_main_bg(){
    cpct_drawSprite (MANUALLY_ALLOCATED_MEMORY_START, cpctm_screenPtr(CPCT_VMEM_START, 0, 100),40,100);
    cpct_drawSprite ((MANUALLY_ALLOCATED_MEMORY_START+4000), cpctm_screenPtr(CPCT_VMEM_START, 40, 100), 40, 100);
}

void state_mainmenu_enter(){
    
    cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
    setMenuPalette();
    dec_main_bg();
    draw_main_bg();
    camelot_warriors_mode=0;
    ui_mainmenu_init();
    ui_mainmenu_render_all();
    
}

void state_mainmenu_return() {
    cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
    draw_main_bg();
    ui_mainmenu_render_all();
}

void state_mainmenu_input(){
        if(cpct_isKeyPressed(Key_CursorUp)){
            ui_mainmenu_previous_entry();
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_CursorDown)){
            ui_mainmenu_next_entry();
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_Return)){
            ui_mainmenu_select_entry();
            statemanager_input_accepted();
        }
}

void state_mainmenu_update(){
    if(ui_mainmenu_is_selected()){
        ui_mainmenu_render_refresh();
        switch(ui_mainmenu_get_entry()){
            case 0:{
                level_set_level(0);
                level_seed=0;
                player_init();
                statemanager_set_state(STATE_LOADLEVEL);
                break;
            }
            case 1:{
                statemanager_set_state(STATE_LOADGAME);
                break;
            }
            case 2:{
                statemanager_set_state(STATE_OPTIONS);
                break;
            }
            case 3:{
                statemanager_set_state(STATE_CREDITS);
                break;
            }
            case 4:{
                statemanager_exit_game();
                break;
            }
        }
        ui_mainmenu_unselect_entry();
    }
}

void state_mainmenu_render() {
    ui_mainmenu_render_refresh();
}

void state_mainmenu_exit(){
    
}

