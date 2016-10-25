
#ifndef SAVEGAME_H
#define SAVEGAME_H

#include <cpctelera.h>

typedef struct{
    u16 seed;
    
    u8 potions;
    u8 scrolls;
    
    u8 player_hp;
    u8 player_attack;
    u8 player_defense;
    
    u8 level;
    
    u8 checksum;
    
}SaveData;

extern SaveData Save;

extern void savegame_Save();

extern u8 savegame_Load(char * loadstring);

extern char* savegame_get_saveString();

#endif