
#include "StateManager.h"
#include "GameFunctions.h"

#include "State_MainMenu.h"
#include "State_InGame.h"
#include "State_PauseMenu.h"
#include "State_LoadLevel.h"
#include "State_Options.h"
#include "State_GameOver.h"
#include "State_Credits.h"
#include "State_Victory.h"
#include "State_Inventory.h"
#include "State_SaveExit.h"
#include "State_LoadGame.h"

typedef struct State{
    
    u8 id;
    u8 lastStateid;
    
    
    void (* enterState)();
    void (* returnState)();
    void (* inputState)();
    void (* updateState)();
    void (* renderState)();
    void (* exitState)();
} State;

const State stateArray[11]={
    //Main Menu
    {
        0,
        0,
        
        state_mainmenu_enter,
        state_mainmenu_return,
        state_mainmenu_input,
        state_mainmenu_update,
        state_mainmenu_render,
        state_mainmenu_exit
    },
    //InGame
    {
        1,
        0,
        state_ingame_enter,
        state_ingame_return,
        state_ingame_input,
        state_ingame_update,
        state_ingame_render,
        state_ingame_exit
    },
    //Pause Menu
    {
        2,
        0,
        state_pausemenu_enter,
        state_pausemenu_return,
        state_pausemenu_input,
        state_pausemenu_update,
        state_pausemenu_render,
        state_pausemenu_exit
    },
    //Load Level
    {
        3,
        0,
        state_loadlevel_enter,
        state_loadlevel_return,
        state_loadlevel_input,
        state_loadlevel_update,
        state_loadlevel_render,
        state_loadlevel_exit
    },
    //Options
    {
        4,
        0,
        state_options_enter,
        state_options_return,
        state_options_input,
        state_options_update,
        state_options_render,
        state_options_exit
    },
    //Game Over
    {
        5,
        0,
        state_gameover_enter,
        state_gameover_return,
        state_gameover_input,
        state_gameover_update,
        state_gameover_render,
        state_gameover_exit
    },
    //Credits
    {
        6,
        0,
        state_credits_enter,
        state_credits_return,
        state_credits_input,
        state_credits_update,
        state_credits_render,
        state_credits_exit
    },
    //Victory
    {
        7,
        0,
        state_victory_enter,
        state_victory_return,
        state_victory_input,
        state_victory_update,
        state_victory_render,
        state_victory_exit
    },
    //Inventory
    {
        8,
        0,
        state_inventory_enter,
        state_inventory_return,
        state_inventory_input,
        state_inventory_update,
        state_inventory_render,
        state_inventory_exit
    },
    //Save and exit
    {
        9,
        0,
        state_saveexit_enter,
        state_saveexit_return,
        state_saveexit_input,
        state_saveexit_update,
        state_saveexit_render,
        state_saveexit_exit
    },
    //Load game
    {
        10,
        0,
        state_loadgame_enter,
        state_loadgame_return,
        state_loadgame_input,
        state_loadgame_update,
        state_loadgame_render,
        state_loadgame_exit
    },
};

const u8 closeState=0;

const u8 currentState=0;

const u8 changeToState = 0;

const u8 inputReceived = 0;

const u8 gameRunning = 1;

const u8 last_keyboardStatusBuffer[10]={0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF};

void statemanager_drop_state(){
    if(closeState){
        stateArray[currentState].exitState();
        *(u8*)&currentState = stateArray[currentState].lastStateid;
        stateArray[currentState].returnState();
        *(u8*)&closeState=0;
    }
}

void statemanager_change_state(){
    if(changeToState){
        *(u8*)&(stateArray[changeToState-1].lastStateid) = currentState;
        *(u8*)&currentState = changeToState-1;
        stateArray[currentState].enterState();
        *(u8*)&changeToState = 0;
    }
}

void statemanager_input_accepted(){
    *(u8*)&inputReceived=1;
}

void statemanager_set_state(u8 state) {
    *(u8*)&changeToState = state+1;
}

void scan_input(){
    u8 t,n=10;
    u8* currentStatus=(cpct_keyboardStatusBuffer+n);
    u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
    
    cpct_scanKeyboard_f();
    while(n){
        --n;
        --currentStatus;
        --lastStatus;
        
        t=*(currentStatus);
        *currentStatus=((*lastStatus)|(~t));
        *lastStatus=t;
        
    }
    
    if(cpct_isAnyKeyPressed_f()) ++r_counter;
}

void statemanager_manage_input(){
    while(!inputReceived){
        scan_input();
        stateArray[currentState].inputState();
    }
    *(u8*)&inputReceived=0;
}

void statemanager_render_state(){
    cpct_waitVSYNC();
    stateArray[currentState].renderState();
}

void statemanager_close_state(){
    *(u8*)&closeState=1;
}

void statemanager_update_state(){
    stateArray[currentState].updateState();
}

void statemanager_exit_game(){
    *(u8*)&gameRunning=0;
}

void statemanager_main_loop(){
   while(gameRunning) {
       statemanager_drop_state();
       statemanager_change_state();
       statemanager_manage_input();
       statemanager_update_state();
       statemanager_render_state();
   }
}
