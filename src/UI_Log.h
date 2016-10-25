
#ifndef UI_LOG_H
#define UI_LOG_H

#include <cpctelera.h>


extern void ui_log_init();

extern void ui_log_add_log(const char* const newLog, u8 color);

extern void ui_log_render();



#endif