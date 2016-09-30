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

#include "Map.h"
#include "Player.h"
#include "Renderer.h"
#include "Textures.h"

#include "UI_Compass.h"

void init(){
   cpct_disableFirmware();
   cpct_setVideoMode(0);
   cpct_fw2hw(g_palette,16);
   cpct_setPalette(g_palette,16);
   cpct_setBorder(g_palette[0]);
   // Clear Screen
   cpct_memset(CPCT_VMEM_START, g_colors[15], 0x4000);
}

void main(void) {
   init();
   init_generator();
   uncompress_theme_textures(0);
   cpct_setBorder(g_palette[1]);
   generate_map();
   cpct_setBorder(g_palette[15]);
   render_draw_to_buffer();
   cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   draw_minimap_to_buffer();
   cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   
   
   while(1) {
       u8 movement = 0;
         cpct_scanKeyboard_f();
        if(cpct_isKeyPressed(Key_CursorLeft)){
            *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
            *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
            *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
            renderCompass();
            movement =1;
        }
        else if(cpct_isKeyPressed(Key_CursorRight)){
            *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
            *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
            *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
            renderCompass();
            movement =1;
        }
        else if(cpct_isKeyPressed(Key_CursorUp)){
            *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
            *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
            
            movement =1;
        }
        else if(cpct_isKeyPressed(Key_CursorDown)){
            *(i8*)&(PLAYER_position.x) = PLAYER_position.x - PLAYER_direction.x;
            *(i8*)&(PLAYER_position.y) = PLAYER_position.y - PLAYER_direction.y;
            
            movement =1;
        }
        if(movement){
             render_draw_to_buffer();
             cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
             draw_minimap_to_buffer();
             cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
        }
       
       
   }
}