
#include "State_InGame.h"

#include "StateManager.h"

#include "GameDefinitions.h"

#include "StringUtils.h"

#include "Map.h"
#include "Player.h"
#include "Renderer.h"
#include "Level.h"

#include "UI_Compass.h"
#include "UI_GameMenu.h"
#include "UI_PlayerStats.h"

// const u8 isInitialized = 0;

const u8 updateRenderBuffer = 0;

void state_ingame_enter(){
    cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
    
    ui_gamemenu_init();
    
    
    ui_gamemenu_render_all();
    state_ingame_render();
}

void state_ingame_input(){
    
        if(cpct_isKeyPressed(Key_CursorLeft)){
            ui_gamemenu_previous_entry();
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_CursorRight)){
            ui_gamemenu_next_entry();
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_Return)){
            ui_gamemenu_select_entry();
            statemanager_input_accepted();
        }
        //DEBUG
        else if(cpct_isKeyPressed(Key_1)){
            level_set_level(0);
            level_load_level();
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_2)){ 
            level_set_level(9);
            level_load_level();
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_T)){
            *(u8*)&g_texturedWalls = !g_texturedWalls;
            statemanager_input_accepted();
        }
}

void state_ingame_update(){
    
    if(ui_gamemenu_is_selected()){
        ui_gamemenu_render_refresh();
        switch(ui_gamemenu_get_entry()){
            case 0:{
                
                player_turn_left();
                
                
                *(u8*)&updateRenderBuffer = 1;
                break;
            }
            case 1:{
                
                player_move_forward();
                
                
                *(u8*)&updateRenderBuffer = 1;
                break;
            }
            case 2:{
                
                player_turn_right();
                
                *(u8*)&updateRenderBuffer = 1;
                break;
            }
            case 3:{
                
                break;
            }
            case 4:{
                
                break;
            }
            case 5:{
                statemanager_set_state(STATE_PAUSEMENU);
                break;
            }
        }
        ui_gamemenu_unselect_entry();
    }
    
    if(updateRenderBuffer){
         render_draw_to_buffer();
         draw_minimap_to_buffer();
        *(u8*)&updateRenderBuffer = 0;
    }
    
}

void state_ingame_render(){
    ui_gamemenu_render_refresh();
    ui_playerstats_render();
    cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
    renderCompass();
    cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
}

void state_ingame_exit(){
       // *(u8*)&isInitialized = 0;
}