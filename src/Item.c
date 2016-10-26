
#include "Item.h"

#include "GameDefinitions.h"

#include "Player.h"

#include "UI_PlayerStats.h"

#include "Level.h"

#include "Renderer.h"

#include "UI_Log.h"

#define ITEM_MAX_ITEMS 7


u8 activeItems;

u8 item_spawnedKey;

Item itemArray[ITEM_MAX_ITEMS];

Item* item_get_at(u8 index){
    return (itemArray+index);
}

void item_init_items(){
    cpct_memset(itemArray, 0, ITEM_MAX_ITEMS*sizeof(Item));
    activeItems=0;
    item_spawnedKey=0;
    // if(level_get_level()<()
    // if(level_get_level()<KING_LEVEL){
        // while(activeItems<ITEM_MAX_ITEMS){
            // item_try_new_spawn();
        // }
    // }
}

u8 item_try_new_spawn(){
    Vec2u pos;
    
    pos.x=cpct_getRandom_mxor_u8()%MAP_WIDTH;
    pos.y=cpct_getRandom_mxor_u8()%MAP_HEIGHT;
    
    return (item_try_new_spawn_at(&pos));
}

void item_new_item(Vec2u* pos){
    u8 i=ITEM_MAX_ITEMS, x, y;// r;
    Item* item=(itemArray+ITEM_MAX_ITEMS);
    
    u8* map = (u8*)(MAP_MEM);
    
    x=pos->x;
    y=pos->y;
    
    while(i){
        --i;
        --item;
        if(item->value==0){
            item->id=i;
        
            if((!item_spawnedKey) && (((cpct_getRandom_mxor_u8()%16)==0)||level_get_level()==KING_LEVEL)){//1/16 is key
                item->type=0;
                item_spawnedKey=1;
            }
            else{
                // r = (cpct_getRandom_mxor_u8()&7);
                // item->type = ((r<4)?3:((r<6)?4:((r==6)?1:2)));
                item->type = (cpct_getRandom_mxor_u8()&3)+1;
            }
             
             
            if(item->type == 1){
                item->value = 48 +level_get_level() + (cpct_getRandom_mxor_u8()&7);
            }
            else if(item->type == 2){
                item->value = 4 + level_get_level() + (cpct_getRandom_mxor_u8()&7);
            }
            else{
                item->value=1;
            }
            
            item->position.x = x;
            item->position.y = y;
            
            map[x+(y*MAP_WIDTH)] |=((i+1)<<4);
            
            ++activeItems;
            break;
        }
    }
}

u8 item_try_new_spawn_at(Vec2u* pos){
    u8 x,y;
    u8* map = ((u8*)MAP_MEM);
    x=pos->x;
    y=pos->y;
    
    if(activeItems<ITEM_MAX_ITEMS){
        if(((map[x+(y*MAP_WIDTH)])&(CELL_WALL_MASK|CELL_ITEM_MASK))==0){
            item_new_item(pos);
            return 1;
        }
    }
    return 0;
}

void item_pick_item(Item* i){
    char * object;
    switch(i->type){
        case 0:{//key
            player_has_key=1;
            ui_playerstats_render_key();
            object = "KEY";
            break;
        }
        case 1:{
            player_attack_value=(i->value>player_attack_value)?i->value:player_attack_value;
            ui_playerstats_render_attack();
            object="SWORD";
            break;
        }
        case 2:{
            player_defense_value = (i->value>player_defense_value)?i->value:player_defense_value;
            ui_playerstats_render_defense();
            object="ARMOR";
            break;
        }
        case 3:{
            ++player_potion_count;
            ui_playerstats_render_potions();
            object="POTION";
            break;
        }
        case 4:{
            ++player_scroll_count;
            ui_playerstats_render_scrolls();
            object="SCROLL";
            break;
        }
    }
    
    ui_log_add_log("PICKED",3);
    ui_log_add_log(object,6);
    ui_log_render();
    
    item_destroy_item(i);
}

void item_destroy_item(Item* i){
    u8* mapPos = (u8*)(MAP_MEM + i->position.x + (i->position.y*MAP_WIDTH));
    
    --activeItems;
    
    i->value=0;
    
    *mapPos = *mapPos&(CELL_WALL_MASK|CELL_ENEMY_MASK);
    
}

u8 item_use_potion(){
    if(player_potion_count){
        --player_potion_count;
        if(player_health_points<(255-ITEM_POTION_HEAL)){
            player_health_points+=ITEM_POTION_HEAL;
        }
        else{
            player_health_points=255;
        }
        ui_playerstats_render_hp();
        return 1;
    }
    return 0;
}

u8 item_use_scroll(){
    u16 pos = (cpct_getRandom_mxor_u16()%1024);
    if(player_scroll_count){
        while(*(u8*)(MAP_MEM+pos)!=CELLTYPE_FLOOR){
            pos = (pos+1)%1024;
        }
        --player_scroll_count;
        *(u8*)&(player_position.x) = (pos%MAP_WIDTH);
        *(u8*)&(player_position.y) = (pos/MAP_HEIGHT);
        return 1;
    }
    return 0;
}

