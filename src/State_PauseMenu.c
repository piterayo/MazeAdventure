
#include "StateManager.h"

#include "State_PauseMenu.h"

#include "GlobalDefinitions.h"

#include <cpctelera.h>

void state_pausemenu_enter(){
    u8* ptr;
    ptr=cpct_getScreenPtr(CPCT_VMEM_START, 20, 40 );
    cpct_drawSolidBox (ptr, 255, 40, 120);
    ptr=cpct_getScreenPtr(CPCT_VMEM_START, 20, 80 );
    cpct_drawStringM0("PAUSE",ptr,0,1);
}

void state_pausemenu_input(){
    
    if(cpct_isKeyPressed(Key_P)){
        statemanager_set_state(STATE_INGAME);
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_Esc)){
        statemanager_set_state(STATE_MAINMENU);
        statemanager_close_state(STATE_INGAME);
        statemanager_input_accepted();
    }
}

void state_pausemenu_update(){
    
}

void state_pausemenu_render(){
    
}

void state_pausemenu_exit(){
    
}