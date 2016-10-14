
#include "StateManager.h"

#include "State_PauseMenu.h"

#include "GameDefinitions.h"

#include "Renderer.h"

#include <cpctelera.h>

void state_pausemenu_enter(){
    u8* ptr;
    ptr=cpct_getScreenPtr(CPCT_VMEM_START, 30, 40 );
    cpct_drawSolidBox (ptr, 255, 20, 120);
}

void state_pausemenu_input(){
    
    if(cpct_isKeyPressed(Key_P)){
        statemanager_close_state();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_Esc)){
        statemanager_close_state();
        statemanager_close_state();
        statemanager_set_state(STATE_MAINMENU);
        statemanager_input_accepted();
    }
}

void state_pausemenu_update(){
    
}

void state_pausemenu_render(){
    
}

void state_pausemenu_exit(){
    u8* ptr;
    ptr=cpct_getScreenPtr(CPCT_VMEM_START, 30, 40 );
    cpct_drawSolidBox (ptr, g_colors[1], 20, 120);
}