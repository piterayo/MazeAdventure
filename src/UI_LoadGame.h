
#ifndef UI_LOADGAME_H
#define UI_LOADGAME_H

#include <cpctelera.h>


extern void ui_loadgame_init();

extern u8 ui_loadgame_get_entry();
extern u8 ui_loadgame_is_selected();

extern void ui_loadgame_next_entry();
extern void ui_loadgame_previous_entry();

extern void ui_loadgame_select_entry();
extern void ui_loadgame_unselect_entry();

extern void ui_loadgame_render_all();

#endif