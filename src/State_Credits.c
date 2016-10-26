
#include "State_Credits.h"

#include "StringUtils.h"

#include "GameDefinitions.h"

#include "Renderer.h"

#include "StateManager.h"





void state_credits_enter(){
    
    cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[4],52,92);
    cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,15,50),g_colors[1],50,84);
    
    print_transparent_text("CODING:", cpctm_screenPtr((u16)CPCT_VMEM_START,16,54),3);
    print_transparent_text("Albert Sirvent @piterayo",cpctm_screenPtr((u16)CPCT_VMEM_START,16,62),3);
    
    print_transparent_text("ART:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,78),3);
    print_transparent_text("Alejandro Padilla",cpctm_screenPtr((u16)CPCT_VMEM_START,16,86),3);
    
    print_transparent_text("MUSIC:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,102),3);
    print_transparent_text("Carlos Blaya",cpctm_screenPtr((u16)CPCT_VMEM_START,16,110),3);
    
}

void state_credits_return(){
    
}

void state_credits_input(){
    if(cpct_isAnyKeyPressed_f ()){
        statemanager_input_accepted();
    }
}

void state_credits_update(){
    statemanager_close_state();
}

void state_credits_render(){
    
}

void state_credits_exit(){
    cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[1],52,92);
}
