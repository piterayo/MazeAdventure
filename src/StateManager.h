
#ifndef STATEMANAGER_H
#define STATEMANAGER_H

#include <cpctelera.h>

extern void statemanager_close_state(u8 state);

extern void statemanager_set_state(u8 state);

extern void statemanager_main_loop();

extern void statemanager_input_accepted();

extern void scan_input();

#endif