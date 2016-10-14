
#ifndef UI_MAINMENU_H
#define UI_MAINMENU_H

#include <cpctelera.h>

extern void ui_mainmenu_init();

extern u8 ui_mainmenu_get_entry();
extern u8 ui_mainmenu_is_selected();

extern void ui_mainmenu_next_entry();
extern void ui_mainmenu_previous_entry();

extern void ui_mainmenu_select_entry();
extern void ui_mainmenu_unselect_entry();

extern void ui_mainmenu_render_all();

extern void ui_mainmenu_render_refresh();


#endif

