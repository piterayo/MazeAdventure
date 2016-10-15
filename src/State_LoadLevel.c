
#include "State_LoadLevel.h"
#include "StateManager.h"
#include "Renderer.h"
#include "StringUtils.h"
#include "Map.h"
#include "Level.h"
#include <cpctelera.h>

void state_loadlevel_enter(){
    cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
    
    print_transparent_text("LOADING", 0xe391, 3);
    
    generate_level();
    level_load_level();
    
    render_draw_to_buffer();
    draw_minimap_to_buffer();
    
}

void state_loadlevel_return(){
    
}


void state_loadlevel_input(){
    statemanager_input_accepted();
}

void state_loadlevel_update(){
    // statemanager_close_state();
    statemanager_set_state(STATE_INGAME);
}

void state_loadlevel_render(){
    
}

void state_loadlevel_exit(){
    
}