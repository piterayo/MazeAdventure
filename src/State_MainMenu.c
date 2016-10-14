
#include "State_MainMenu.h"

#include "StateManager.h"

#include "GameDefinitions.h"

#include "Renderer.h"

#include "StringUtils.h"

void state_mainmenu_enter(){
    state_mainmenu_render();
}

void state_mainmenu_input(){
    if(cpct_isKeyPressed(Key_Return)){
        statemanager_set_state(STATE_INGAME);
        statemanager_input_accepted();
    }
}

void state_mainmenu_update(){
    
}

void state_mainmenu_render(){
    cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
    print_transparent_text("MAIN MENU", CPCT_VMEM_START, 3);
}

void state_mainmenu_exit(){
    
}

