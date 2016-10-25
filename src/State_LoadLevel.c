
#include "State_LoadLevel.h"
#include "StateManager.h"
#include "Renderer.h"
#include "StringUtils.h"
#include "Map.h"
#include "Level.h"
#include "Enemy.h"

#include "SaveGame.h"

#include <cpctelera.h>

u16 level_seed;

void state_loadlevel_enter(){
    
    if(level_get_level()<=(KING_LEVEL)){
        cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
        
        print_transparent_text("LOADING", 0xe391, 3);
        
        if(level_seed) generate_level_with_seed(level_seed);
        else generate_level();
        level_load_level();
        
        enemy_init_enemies();
        item_init_items();
        
        savegame_Save();
        
        render_draw_to_buffer();
        draw_minimap_to_buffer();
        level_seed=0;
    }
    
}

void state_loadlevel_return(){
    
}


void state_loadlevel_input() {
    statemanager_input_accepted();
}

void state_loadlevel_update(){
    if(level_get_level()<=(KING_LEVEL)){
        statemanager_set_state(STATE_INGAME);
    }
    else{//Victory state
        statemanager_set_state(STATE_VICTORY);
    }
}

void state_loadlevel_render(){
    
}

void state_loadlevel_exit(){
    
}