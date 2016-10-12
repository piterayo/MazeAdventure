//-----------------------------LICENSE NOTICE------------------------------------
//  This file is part of CPCtelera: An Amstrad CPC Game Engine
//  Copyright (C) 2015 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//------------------------------------------------------------------------------

#include <cpctelera.h>

#include "GlobalDefinitions.h"

#include "Map.h"
#include "Renderer.h"
#include "Level.h"

#include "StateManager.h"

void interrupt_handler(){
    cpct_setBorder(g_palette[0]);
    //scan_input();
    
    cpct_setBorder(g_palette[1]);
}

void init(){
    cpct_disableFirmware();
    cpct_setVideoMode(0);
    cpct_fw2hw(g_palette,16);
    cpct_setInterruptHandler(interrupt_handler);
    level_init_palettes();
    cpct_setPalette(g_palette,16);
    cpct_setBorder(g_palette[12]);
    // Clear Screen
    cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);

    cpct_scanKeyboard_f();
    init_generator();
}

void main(void) {
   init();
   
   statemanager_set_state(STATE_MAINMENU);
   
   statemanager_main_loop();
   
}