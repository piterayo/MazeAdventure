
#include "StateManager.h"

#include "State_PauseMenu.h"

#include "UI_PauseMenu.h"

#include "GameDefinitions.h"

#include "Renderer.h"

#include <cpctelera.h>

void state_pausemenu_enter(){
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
    ui_pausemenu_init();
    ui_pausemenu_render_all();
}

void state_pausemenu_return() {
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
    ui_pausemenu_render_all();
}

void state_pausemenu_input(){
    
    if(cpct_isKeyPressed(Key_CursorUp)){
        ui_pausemenu_previous_entry();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_CursorDown)){
        ui_pausemenu_next_entry();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_Return)){
        ui_pausemenu_select_entry();
        statemanager_input_accepted();
    }
}


void state_pausemenu_update(){
    if(ui_pausemenu_is_selected()){
        ui_pausemenu_render_refresh();
        switch(ui_pausemenu_get_entry()){
            case 0:{
                statemanager_close_state();
                break;
            }
            case 1:{
                statemanager_set_state(STATE_OPTIONS);
                break;
            }
            case 2:{
                statemanager_set_state(STATE_SAVEEXIT);
                break;
            }
            case 3:{
                statemanager_set_state(STATE_MAINMENU);
                break;
            }
        }
    }
    ui_pausemenu_unselect_entry();
}

void state_pausemenu_render() {
    ui_pausemenu_render_refresh();
}

void state_pausemenu_exit(){
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[1], 34, 144);
}