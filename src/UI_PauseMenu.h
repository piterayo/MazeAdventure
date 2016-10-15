
#ifndef UI_PAUSEMENU_H
#define UI_PAUSEMENU_H

#include <cpctelera.h>


extern void ui_pausemenu_init();

extern u8 ui_pausemenu_get_entry();
extern u8 ui_pausemenu_is_selected();

extern void ui_pausemenu_next_entry();
extern void ui_pausemenu_previous_entry();

extern void ui_pausemenu_select_entry();
extern void ui_pausemenu_unselect_entry();

extern void ui_pausemenu_render_refresh();
extern void ui_pausemenu_render_all();



#endif