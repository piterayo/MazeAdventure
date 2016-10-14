
#include "State_MainMenu.h"

#include "UI_MainMenu.h"

#include "StateManager.h"

#include "GameDefinitions.h"

#include "Renderer.h"

#include "StringUtils.h"

#include "Level.h"

void state_mainmenu_enter(){
    cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
    print_transparent_text("MAIN MENU", CPCT_VMEM_START, 3);
    ui_mainmenu_init();
    ui_mainmenu_render_all();
    state_mainmenu_render();
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
                statemanager_set_state(STATE_LOADLEVEL);
                break;
            }
            case 1:{
                
                break;
            }
            case 2:{
                
                break;
            }
            case 3:{
                
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

void state_mainmenu_render(){
    ui_mainmenu_render_refresh();
}

void state_mainmenu_exit(){
    
}

