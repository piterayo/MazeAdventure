
#ifndef UI_INVENTORY_H
#define UI_INVENTORY_H

#include <cpctelera.h>


extern void ui_inventory_init();

extern u8 ui_inventory_get_entry();
extern u8 ui_inventory_is_selected();

extern void ui_inventory_next_entry();
extern void ui_inventory_previous_entry();

extern void ui_inventory_select_entry();
extern void ui_inventory_unselect_entry();

extern void ui_inventory_render_refresh();
extern void ui_inventory_render_all();

#endif