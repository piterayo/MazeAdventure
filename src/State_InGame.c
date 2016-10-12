
#include "State_InGame.h"

#include "StateManager.h"

#include "GlobalDefinitions.h"

#include "Map.h"
#include "Player.h"
#include "Renderer.h"
#include "Level.h"
#include "UI_Compass.h"

const u8 isInitialized = 0;

const u8 needRender = 0;

void state_ingame_enter(){
    if(!isInitialized){
        generate_level();
        level_load_level(0);
        render_draw_to_buffer();
        draw_minimap_to_buffer();
        *(u8*)&isInitialized = 1;
    }
    cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
    state_ingame_render();
}

void state_ingame_input(){
    
        if(cpct_isKeyPressed(Key_CursorLeft)){
            *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
            *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
            *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
            
            *(u8*)&needRender = 1;
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_CursorRight)){
            *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
            *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
            *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
            *(u8*)&needRender = 1;
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_CursorUp)){
            *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
            *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
            
            *(u8*)&needRender = 1;
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_CursorDown)){
            *(i8*)&(PLAYER_position.x) = PLAYER_position.x - PLAYER_direction.x;
            *(i8*)&(PLAYER_position.y) = PLAYER_position.y - PLAYER_direction.y;
            
            *(u8*)&needRender = 1;
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_0)){
            level_load_level(0);
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_1)){ 
            level_load_level(9);
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_T)){
            *(u8*)&g_texturedWalls = !g_texturedWalls;
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_P)){
            statemanager_set_state(STATE_PAUSEMENU);
            statemanager_input_accepted();
        }
}

void state_ingame_update(){
    if(needRender){
         render_draw_to_buffer();
         draw_minimap_to_buffer();
        *(u8*)&needRender = 0;
    }
    
}

void state_ingame_render(){
     cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
     renderCompass();
     cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
}

void state_ingame_exit(){
       *(u8*)&isInitialized = 0;
}