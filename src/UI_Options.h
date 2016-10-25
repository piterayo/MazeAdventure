
#ifndef UI_OPTIONS_H
#define UI_OPTIONS_H

#include <cpctelera.h>


extern void ui_options_init();

extern u8 ui_options_get_entry();
extern u8 ui_options_is_selected();

extern void ui_options_next_entry();
extern void ui_options_previous_entry();

extern void ui_options_select_entry();
extern void ui_options_unselect_entry();

extern void ui_options_render_refresh();
extern void ui_options_render_all();

extern void ui_options_set_strings();

#endif