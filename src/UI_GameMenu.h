#ifndef UIGAMEMENU_H
#define UIGAMEMENU_H

#include <cpctelera.h>

extern void ui_gamemenu_init();

extern void ui_gamemenu_update_action();

extern u8 ui_gamemenu_get_action();

extern u8 ui_gamemenu_get_movement();

extern u8 ui_gamemenu_get_entry();
extern u8 ui_gamemenu_is_selected();

extern void ui_gamemenu_next_entry();
extern void ui_gamemenu_previous_entry();
extern void ui_gamemenu_above_entry();
extern void ui_gamemenu_below_entry();

extern void ui_gamemenu_select_entry();
extern void ui_gamemenu_unselect_entry();

extern void ui_gamemenu_render_all();

extern void ui_gamemenu_render_refresh();

#endif