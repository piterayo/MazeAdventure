
#ifndef STATE_INVENTORY_H
#define STATE_INVENTORY_H

#include <cpctelera.h>

extern void state_inventory_enter();

extern void state_inventory_return();

extern void state_inventory_input();

extern void state_inventory_update();

extern void state_inventory_render();

extern void state_inventory_exit();

extern u8 state_inventory_object_used();

#endif