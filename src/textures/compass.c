#include "compass.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2015
u8* const compass_tileset[4] = { 
	compass_compass_0, compass_compass_1, compass_compass_2, compass_compass_3
};
// Tile compass_compass_0: 16x16 pixels, 8x16 bytes.
const u8 compass_compass_0[8 * 16] = {
	0xc0, 0xc0, 0xc4, 0xcc, 0xcc, 0xc8, 0xc0, 0xc0,
	0xc0, 0xc4, 0x8c, 0x0c, 0x0c, 0x4c, 0xc8, 0xc0,
	0xc0, 0x8c, 0x48, 0xc0, 0xc0, 0x84, 0x4c, 0xc0,
	0xc4, 0x48, 0xc0, 0xc0, 0xc0, 0xc0, 0x84, 0xc8,
	0xc4, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc8,
	0x8c, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0x4c,
	0xcc, 0xcc, 0xcc, 0xcc, 0xc0, 0xc0, 0xc0, 0xc4,
	0xcc, 0xcc, 0xcc, 0xcc, 0xc0, 0xc0, 0xc0, 0xc4,
	0x8c, 0x0c, 0x0c, 0x0c, 0xc0, 0xc0, 0xc0, 0xc4,
	0xc8, 0xc0, 0xc0, 0x30, 0x30, 0xc0, 0xc0, 0xc4,
	0x4c, 0xc0, 0xc0, 0x60, 0xc0, 0xc0, 0xc0, 0x8c,
	0xc4, 0xc0, 0xc0, 0x30, 0x60, 0xc0, 0xc0, 0xc8,
	0x84, 0xc8, 0xc0, 0x60, 0xc0, 0xc0, 0xc4, 0x48,
	0xc0, 0x4c, 0xc8, 0x30, 0x30, 0xc4, 0x8c, 0xc0,
	0xc0, 0x84, 0x4c, 0xcc, 0xcc, 0x8c, 0x48, 0xc0,
	0xc0, 0xc0, 0x84, 0x0c, 0x0c, 0x48, 0xc0, 0xc0
};

// Tile compass_compass_1: 16x16 pixels, 8x16 bytes.
const u8 compass_compass_1[8 * 16] = {
	0xc0, 0xc0, 0xc4, 0xcc, 0xcc, 0xc8, 0xc0, 0xc0,
	0xc0, 0xc4, 0x8c, 0x4c, 0x8c, 0x4c, 0xc8, 0xc0,
	0xc0, 0x8c, 0x48, 0xc4, 0xc8, 0x84, 0x4c, 0xc0,
	0xc4, 0x48, 0xc0, 0xc4, 0xc8, 0xc0, 0x84, 0xc8,
	0xc4, 0xc0, 0xc0, 0xc4, 0xc8, 0xc0, 0xc0, 0xc8,
	0x8c, 0xc0, 0xc0, 0xc4, 0xc8, 0xc0, 0xc0, 0x4c,
	0xc8, 0xc0, 0xc0, 0xc4, 0xc8, 0xc0, 0xc0, 0xc4,
	0xc8, 0xc0, 0xc0, 0x84, 0x48, 0xc0, 0xc0, 0xc4,
	0xc8, 0xc0, 0xc0, 0x60, 0x90, 0xc0, 0xc0, 0xc4,
	0xc8, 0xc0, 0xc0, 0x30, 0x90, 0xc0, 0xc0, 0xc4,
	0x4c, 0xc0, 0xc0, 0x30, 0x90, 0xc0, 0xc0, 0x8c,
	0xc4, 0xc0, 0xc0, 0x60, 0x30, 0xc0, 0xc0, 0xc8,
	0x84, 0xc8, 0xc0, 0x60, 0x30, 0xc0, 0xc4, 0x48,
	0xc0, 0x4c, 0xc8, 0x60, 0x90, 0xc4, 0x8c, 0xc0,
	0xc0, 0x84, 0x4c, 0xcc, 0xcc, 0x8c, 0x48, 0xc0,
	0xc0, 0xc0, 0x84, 0x0c, 0x0c, 0x48, 0xc0, 0xc0
};

// Tile compass_compass_2: 16x16 pixels, 8x16 bytes.
const u8 compass_compass_2[8 * 16] = {
	0xc0, 0xc0, 0xc4, 0xcc, 0xcc, 0xc8, 0xc0, 0xc0,
	0xc0, 0xc4, 0x8c, 0x0c, 0x0c, 0x4c, 0xc8, 0xc0,
	0xc0, 0x8c, 0x48, 0xc0, 0xc0, 0x84, 0x4c, 0xc0,
	0xc4, 0x48, 0xc0, 0xc0, 0xc0, 0xc0, 0x84, 0xc8,
	0xc4, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc8,
	0x8c, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0x4c,
	0xc8, 0xc0, 0xc0, 0xc0, 0xcc, 0xcc, 0xcc, 0xcc,
	0xc8, 0xc0, 0xc0, 0xc0, 0xcc, 0xcc, 0xcc, 0xcc,
	0xc8, 0xc0, 0xc0, 0xc0, 0x0c, 0x0c, 0x0c, 0x4c,
	0xc8, 0xc0, 0x90, 0xc0, 0x90, 0xc0, 0xc0, 0xc4,
	0x4c, 0xc0, 0x90, 0xc0, 0x90, 0xc0, 0xc0, 0x8c,
	0xc4, 0xc0, 0x90, 0x90, 0x90, 0xc0, 0xc0, 0xc8,
	0x84, 0xc8, 0xc0, 0x60, 0x60, 0xc0, 0xc4, 0x48,
	0xc0, 0x4c, 0xc8, 0x60, 0x60, 0xc4, 0x8c, 0xc0,
	0xc0, 0x84, 0x4c, 0xcc, 0xcc, 0x8c, 0x48, 0xc0,
	0xc0, 0xc0, 0x84, 0x0c, 0x0c, 0x48, 0xc0, 0xc0
};

// Tile compass_compass_3: 16x16 pixels, 8x16 bytes.
const u8 compass_compass_3[8 * 16] = {
	0xc0, 0xc0, 0xc4, 0xcc, 0xcc, 0xc8, 0xc0, 0xc0,
	0xc0, 0xc4, 0x8c, 0x0c, 0x0c, 0x4c, 0xc8, 0xc0,
	0xc0, 0x8c, 0x48, 0xc0, 0xc0, 0x84, 0x4c, 0xc0,
	0xc4, 0x48, 0xc0, 0xc0, 0xc0, 0xc0, 0x84, 0xc8,
	0xc4, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc8,
	0x8c, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0x4c,
	0xc8, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc4,
	0xc8, 0xc0, 0xc0, 0xc4, 0xc8, 0xc0, 0xc0, 0xc4,
	0xc8, 0xc0, 0xc0, 0xc4, 0xc8, 0xc0, 0xc0, 0xc4,
	0xc8, 0xc0, 0xc0, 0x64, 0x98, 0xc0, 0xc0, 0xc4,
	0x4c, 0xc0, 0xc0, 0x64, 0xc8, 0xc0, 0xc0, 0x8c,
	0xc4, 0xc0, 0xc0, 0x64, 0x98, 0xc0, 0xc0, 0xc8,
	0x84, 0xc8, 0xc0, 0xc4, 0x98, 0xc0, 0xc4, 0x48,
	0xc0, 0x4c, 0xc8, 0x64, 0x98, 0xc4, 0x8c, 0xc0,
	0xc0, 0x84, 0x4c, 0xcc, 0xcc, 0x8c, 0x48, 0xc0,
	0xc0, 0xc0, 0x84, 0x0c, 0x0c, 0x48, 0xc0, 0xc0
};

