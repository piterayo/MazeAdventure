
#include "SaveGame.h"

#include "StateManager.h"

#include "State_LoadLevel.h"

#include "GameDefinitions.h"

#include "GameFunctions.h"

#include "Player.h"

#include "Level.h"

#include "Map.h"

#define CHECKSUM_MASK   0b10101010
#define SAVE_MASK       0b11011011


#define SAVESTRING_SIZE 19
#define SAVEDATA_SIZE 9

SaveData save;

u8 * const saveArray=(u8* const)&save;

char saveString[SAVESTRING_SIZE];

u8 str_cmp(char* a, char* b){
    u8 sum=0;
    while(*a){
        sum+=*a;
        ++a;
    }
    
    while(*b){
        sum-=*b;
        ++b;
    }
    
    return sum;
}

void savegame_string_to_save(char* in){
    u8 i = 0,j;
    u8 val;
    // u8* saveArray=(u8*)save;
    
    while(i<SAVEDATA_SIZE){
        val=0;
        for(j=2;j;--j){
            val=val<<4;
            if((*in)>47 && (*in)<=57){//Number
                val=val|(*in)-48;
            }
            else{
                val=val|(*in)-65+10;
            }
            ++in;
        }
        
        saveArray[i]=val;
        ++i;
    }
    
    
}

u8 savegame_checksave(){
    u8 i = SAVEDATA_SIZE-1;
    u8 checksum=0;
    // u8* saveArray=(u8*)save;
    
    while(i){
        --i;
        checksum+=(saveArray[i]^SAVE_MASK);
    }
    checksum=checksum^CHECKSUM_MASK^SAVE_MASK;
    return (checksum==save.checksum);
    
    
}

void savegame_to_string(){
    u8 i = 0;
    u8 val;
    char* string = saveString;
    saveString[SAVESTRING_SIZE-1]=0;
    // u8* saveArray=(u8*)save;
    
    while(i<SAVEDATA_SIZE){
        val = saveArray[i]>>4;
        if(val<10) *string=48+val;
        else *string=65+(val-10);
        
        ++string;
        val = saveArray[i]&0x0F;
        if(val<10) *string=48+val;
        else *string=65+(val-10);
        
        ++string;
        ++i;
    }
}

void savegame_Save(){
    u8 i = SAVEDATA_SIZE-1;
    // u8* saveArray=(u8*)save;
    
    save.seed = map_get_seed();
    
    save.potions = player_potion_count;
    save.scrolls = player_scroll_count;
    
    save.player_hp = player_health_points;
    save.player_attack = player_attack_value;
    save.player_defense = player_defense_value;
    
    save.level = level_get_level();
    
    save.checksum=0;
    while(i){
        --i;
        save.checksum+=saveArray[i];
    }
    
    i =  SAVEDATA_SIZE;
    
    while(i){
        --i;
        saveArray[i] = saveArray[i]^SAVE_MASK;
    }
    
    save.checksum = save.checksum^CHECKSUM_MASK;
    
    savegame_to_string();
    
}

void savegame_decrypt_save(){
    u8 i = SAVEDATA_SIZE;
    
    while(i){
        --i;
        saveArray[i] = saveArray[i]^SAVE_MASK;
    }
}

u8 savegame_Load(char * loadstring){
    if(!str_cmp(loadstring,"CAMELOT WARRIORS")){
        level_set_level(0);
        camelot_warriors_mode=1;
        player_init();
        statemanager_set_state(STATE_LOADLEVEL);
        
        return 1;
    }
    else{
        savegame_string_to_save(loadstring);
        if(savegame_checksave()){
            savegame_decrypt_save();
            level_set_level(save.level);
            
            player_health_points=save.player_hp;
            player_attack_value=save.player_attack;
            player_defense_value=save.player_defense;
            
            player_potion_count = save.potions;
            player_scroll_count = save.scrolls;
            
            level_seed=save.seed;
            
            statemanager_set_state(STATE_LOADLEVEL);
            
            return 1;
        }
    }
    return 0;
}

char* savegame_get_saveString(){
    return saveString;
}