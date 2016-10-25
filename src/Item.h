
#ifndef ITEM_H
#define ITEM_H

#include <cpctelera.h>

#include "Structures.h"

#define ITEM_POTION_HEAL 127

typedef struct Item{
    u8 id;
    
    Vec2u position;
    
    u8 type;
    
    u8 value;//IF 0 ITEM IS NOT ACTIVE
    
}Item;

extern Item* item_get_at(u8 index);

extern void item_init_items();

extern u8 item_try_new_spawn();

extern u8 item_try_new_spawn_at(Vec2u* pos);

extern void item_pick_item(Item* i);

extern void item_destroy_item(Item* i);

extern u8 item_use_potion();

extern u8 item_use_scroll();

#endif