
#include "State_Victory.h"

#include "StringUtils.h"

#include "GameDefinitions.h"

#include "Renderer.h"

#include "StateManager.h"

#include "Level.h"


void state_victory_enter(){
    cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
    print_transparent_text("CONGRATULATIONS!", cpctm_screenPtr((u16)CPCT_VMEM_START,24,92), 3);
    print_transparent_text("YOU HAVE DEFEATED THE EVIL KING!", cpctm_screenPtr((u16)CPCT_VMEM_START,8,100), 3);
}

void state_victory_return(){
    
}

void state_victory_input(){
    if(cpct_isAnyKeyPressed_f ()){
        statemanager_input_accepted();
    }
}

void state_victory_update(){
    statemanager_set_state(STATE_MAINMENU);
}

void state_victory_render(){
    
}

void state_victory_exit(){
    
}