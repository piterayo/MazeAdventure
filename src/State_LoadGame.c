
#include "State_LoadGame.h"
#include "StateManager.h"

#include "GameFunctions.h"

#include "Renderer.h"

#include "SaveGame.h"

#include "StringInput.h"

#include "UI_LoadGame.h"

#include <cpctelera.h>

void state_loadgame_enter(){
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[4], 44, 42);
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 19, 83), g_colors[1], 42, 34);
    ui_loadgame_init();
    ui_stringinput_init();
    ui_loadgame_render_all();
}

void state_loadgame_return(){
    
}


void state_loadgame_input(){
    
    
    if(cpct_isKeyPressed(Key_CursorLeft)){
        ui_loadgame_previous_entry();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_CursorRight)){
        ui_loadgame_next_entry();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_Return)){
        ui_loadgame_select_entry();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_0)){
        ui_stringinput_add_char('0');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_1)){
        ui_stringinput_add_char('1');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_2)){
        ui_stringinput_add_char('2');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_3)){
        ui_stringinput_add_char('3');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_4)){
        ui_stringinput_add_char('4');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_5)){
        ui_stringinput_add_char('5');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_6)){
        ui_stringinput_add_char('6');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_7)){
        ui_stringinput_add_char('7');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_8)){
        ui_stringinput_add_char('8');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_9)){
        ui_stringinput_add_char('9');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_A)){
        ui_stringinput_add_char('A');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_B)){
        ui_stringinput_add_char('B');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_C)){
        ui_stringinput_add_char('C');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_D)){
        ui_stringinput_add_char('D');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_E)){
        ui_stringinput_add_char('E');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_F)){
        ui_stringinput_add_char('F');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_M)){
        ui_stringinput_add_char('M');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_I)){
        ui_stringinput_add_char('I');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_L)){
        ui_stringinput_add_char('L');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_O)){
        ui_stringinput_add_char('O');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_T)){
        ui_stringinput_add_char('T');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_W)){
        ui_stringinput_add_char('W');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_R)){
        ui_stringinput_add_char('R');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_S)){
        ui_stringinput_add_char('S');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_Space)){
        ui_stringinput_add_char(' ');
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_Del)){
        ui_stringinput_remove_char();
        statemanager_input_accepted();
    }
}

void state_loadgame_update(){
    if(ui_loadgame_is_selected()){
        ui_loadgame_render_all();
        switch(ui_loadgame_get_entry()){
            case 0:{
                savegame_Load(ui_stringinput_get_string());
                break;
            }
            case 1:{//Try
                statemanager_close_state();
                break;
            }
        }
    }
    ui_loadgame_unselect_entry();
}

void state_loadgame_render(){
    ui_loadgame_render_all();
}

void state_loadgame_exit(){
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[1], 44, 42);
}