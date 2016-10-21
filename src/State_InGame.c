
#include "State_InGame.h"

#include "StateManager.h"

#include "GameDefinitions.h"

#include "StringUtils.h"

#include "Map.h"
#include "Player.h"
#include "Renderer.h"
#include "Level.h"

#include "Enemy.h"

#include "UI_Compass.h"
#include "UI_GameMenu.h"
#include "UI_PlayerStats.h"
#include "UI_Log.h"

u8 updateRenderBuffer;

typedef enum{
    NONE,MOVE,ATTACK,USE_OBJECT,PICK_OBJECT,WAIT
}ACTION;

ACTION action;

void state_ingame_enter(){
    
    cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
    
    ui_log_init();
    
    ui_gamemenu_init();
    ui_gamemenu_render_all();
    state_ingame_render();
}

void state_ingame_return(){
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
        else if(cpct_isKeyPressed(Key_CursorUp)){
            ui_gamemenu_above_entry();
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_CursorDown)){
            ui_gamemenu_below_entry();
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_Return)){
            ui_gamemenu_select_entry();
            statemanager_input_accepted();
        }
        //DEBUG
        else if(cpct_isKeyPressed(Key_T)){
            *(u8*)&g_texturedWalls = !g_texturedWalls;
            statemanager_input_accepted();
        }
        else if(cpct_isKeyPressed(Key_Tab)){
            level_set_level(level_get_level()+1);
            statemanager_close_state();
            statemanager_set_state(STATE_LOADLEVEL);
            statemanager_input_accepted();
        }
}

void state_ingame_update(){
    
    action=NONE;
    updateRenderBuffer=0;
    
    if(ui_gamemenu_is_selected()){
        ui_gamemenu_render_refresh();
        switch(ui_gamemenu_get_entry()){
            case 0:{//ACTION BUTTON
                
                switch(ui_gamemenu_get_action()){
                    case 1:{
                        level_set_level(level_get_level()+1);
                        statemanager_close_state();
                        statemanager_set_state(STATE_LOADLEVEL);
                        
                        break;
                    }
                    case 2:{
                        // action=ATTACK;
                        break;
                    }
                    case 3:{
                        // action=PICK_OBJECT;
                        break;
                    }
                }
                break;
            }
            case 1:{//INVENTORY
                
                
                break;
            }
            case 2:{//TURN LEFT
                
                player_turn_left();
                ui_gamemenu_update_action();
                
                updateRenderBuffer = 1;
                break;
            }
            case 3:{//MOVE
                // if(ui_gamemenu_get_movement()){//BYPASS IF FOR NOCLIP
                
                    player_move_forward();
                    ui_gamemenu_update_action();
                    // action=MOVE;
                    
                    updateRenderBuffer = 1;
                // }
                break;
            }
            case 4:{//TURN RIGHT
                player_turn_right();
                ui_gamemenu_update_action();
                
                updateRenderBuffer = 1;
                
                break;
            }
            case 5:{//WAIT
                action=WAIT;
                updateRenderBuffer = 1;
                break;
            }
            case 6:{//PAUSE
                statemanager_set_state(STATE_PAUSEMENU);
                break;
            }
        }
        ui_gamemenu_unselect_entry();
    }
    
    if(action!=NONE){
        enemy_update();
    }
    
    if(updateRenderBuffer){
         render_draw_to_buffer();
         draw_minimap_to_buffer();
    }
    
}

void state_ingame_render(){
    ui_gamemenu_render_refresh();
    renderCompass();
    cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
    cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
    ui_playerstats_render();
    ui_log_render();
}

void state_ingame_exit(){
    // cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
}