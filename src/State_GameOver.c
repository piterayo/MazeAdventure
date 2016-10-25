
#include "State_GameOver.h"

#include "StringUtils.h"

#include "GameDefinitions.h"

#include "Renderer.h"

#include "StateManager.h"

#include "Level.h"


void state_gameover_enter(){
    cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
    print_transparent_text("GAME OVER", cpctm_screenPtr((u16)CPCT_VMEM_START,32,92), 3);
    print_transparent_text("LEVEL: ", cpctm_screenPtr((u16)CPCT_VMEM_START,30,100), 3);
    print_transparent_text(integer_to_string(level_get_level(),'d'), cpctm_screenPtr((u16)CPCT_VMEM_START,46,100), 3);
}

void state_gameover_return(){
    
}

void state_gameover_input(){
    if(cpct_isAnyKeyPressed_f ()){
        statemanager_input_accepted();
    }
}

void state_gameover_update(){
    statemanager_set_state(STATE_MAINMENU);
}

void state_gameover_render(){
    
}

void state_gameover_exit(){
    
}