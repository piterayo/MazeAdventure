
#include "State_SaveExit.h"
#include "StateManager.h"

#include "GameDefinitions.h"

#include "GameFunctions.h"

#include "StringUtils.h"

#include "SaveGame.h"

#include "Renderer.h"

#include <cpctelera.h>

void state_saveexit_enter(){
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 20, 80), g_colors[4], 40, 40);
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 21, 84), g_colors[1], 38, 32);
    
    print_transparent_text(savegame_get_saveString(), cpctm_screenPtr(CPCT_VMEM_START, 22, 92), 3);
    print_transparent_text("PRESS ANY KEY", cpctm_screenPtr(CPCT_VMEM_START, 27, 100), 3);
    
}

void state_saveexit_return(){
    
}

void state_saveexit_input(){
    if(cpct_isAnyKeyPressed_f()){
        statemanager_set_state(STATE_MAINMENU);
        statemanager_input_accepted();
    }
}

void state_saveexit_update(){
    
}

void state_saveexit_render(){
    
}

void state_saveexit_exit(){
    
}