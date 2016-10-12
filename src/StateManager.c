
#include "StateManager.h"
#include "GameFunctions.h"

#include "State_MainMenu.h"
#include "State_InGame.h"
#include "State_PauseMenu.h"

typedef struct State{
    void (* enterState)();
    void (* inputState)();
    void (* updateState)();
    void (* renderState)();
    void (* exitState)();
} State;

const State stateArray[3]={
    //Main Menu
    {
        state_mainmenu_enter,
        state_mainmenu_input,
        state_mainmenu_update,
        state_mainmenu_render,
        state_mainmenu_exit
    },
    //InGame
    {
        state_ingame_enter,
        state_ingame_input,
        state_ingame_update,
        state_ingame_render,
        state_ingame_exit
    },
    //Pause Menu
    {
        state_pausemenu_enter,
        state_pausemenu_input,
        state_pausemenu_update,
        state_pausemenu_render,
        state_pausemenu_exit
    },
};

const u8 currentState=0;

const u8 changeToState = 0;

const u8 inputReceived = 0;

const u8 last_keyboardStatusBuffer[10]={0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF};

void statemanager_change_state(){
    if(changeToState){
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
    stateArray[currentState].renderState();
}

void statemanager_close_state(u8 state){
        stateArray[state].exitState();
}

void statemanager_update_state(){
    stateArray[currentState].updateState();
}

void statemanager_main_loop(){
   while(1) {
       statemanager_change_state();
       statemanager_manage_input();
       statemanager_update_state();
       statemanager_render_state();
   }
}
