
#include "State_Options.h"
#include "StateManager.h"

#include "GameFunctions.h"

#include "Renderer.h"

#include "UI_Options.h"

#include <cpctelera.h>

void state_options_enter(){
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[4], 34, 80);
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 68), g_colors[1], 32, 72);
    ui_options_init();
    ui_options_render_all();
}

void state_options_return(){
    
}

void state_options_input(){
    if(cpct_isKeyPressed(Key_CursorUp)){
        ui_options_previous_entry();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_CursorDown)){
        ui_options_next_entry();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_Return)){
        ui_options_select_entry();
        statemanager_input_accepted();
    }
}

void state_options_update(){
    if(ui_options_is_selected()){
        ui_options_render_refresh();
        switch(ui_options_get_entry()){
            case 0:{//Textures
                textures_on=!textures_on;
                ui_options_set_strings();
                break;
            }
            case 1:{//Sound
                music_on=!music_on;
                if(!music_on) cpct_akp_stop ();
                ui_options_set_strings();
                break;
            }
            case 2:{
                statemanager_close_state();
                break;
            }
        }
    }
    ui_options_unselect_entry();
}

void state_options_render(){
    ui_options_render_refresh();
}

void state_options_exit(){
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[1], 34, 80);
}