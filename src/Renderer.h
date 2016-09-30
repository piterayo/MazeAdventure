
#ifndef RENDERER_H
#define RENDERER_H

#include <cpctelera.h>

extern const u8 g_palette[16];

extern const u8 g_colors[16];

extern const u8 pixelMask[2];

extern void render_draw_to_buffer();

extern void draw_minimap_to_buffer();

#endif