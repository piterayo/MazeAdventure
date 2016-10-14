
#include "StateManager.h"
#include "GameFunctions.h"

#include "State_MainMenu.h"
#include "State_InGame.h"
#include "State_PauseMenu.h"
#include "State_LoadLevel.h"

typedef struct State{
    
    u8 id;
    u8 lastStateid;
    
    
    void (* enterState)();
    void (* inputState)();
    void (* updateState)();
    void (* renderState)();
    void (* exitState)();
} State;

const State stateArray[4]={
    //Main Menu
    {
        0,
        0,
        
        state_mainmenu_enter,
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
        state_loadlevel_input,
        state_loadlevel_update,
        state_loadlevel_render,
        state_loadlevel_exit
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

void statemanager_set_state(u8 state){
    *(u8*)&changeToState = state+1;
}

void scan_input(){
    u8 t,n=10, anyKeyPressed=0xFF;
    u8* currentStatus=(cpct_keyboardStatusBuffer+n);
    u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
    
    cpct_scanKeyboard_f();
    while(n){
        --n;
        --currentStatus;
        --lastStatus;
        
        t=*(currentStatus);
        anyKeyPressed&=t;
        *currentStatus=((*lastStatus)|(~t));
        *lastStatus=t;
        
    }
    
    // if(~anyKeyPressed) ++r_counter;
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
