

#ifndef GAMEDEFINITIONS_H
#define GAMEDEFINITIONS_H

//MAX MEMORY NEEDED: 13680 = 0x3570 // 16000 = 3E80

//MIN STACK MEMORY: 0xBE40

#define MANUALLY_ALLOCATED_MEMORY_START (0xBE40-0x3570)


//MAP

#define MAP_MEM         MANUALLY_ALLOCATED_MEMORY_START
#define MAP_HEIGHT      32
#define MAP_WIDTH       32
#define MAP_SIZE        1024
#define END_OF_MAP_MEM  (MAP_MEM+1024)

//TEXTURES

#define UNCOMPRESSED_TEXTURES           END_OF_MAP_MEM
#define UNCOMPRESSED_ENEMY_TEXTURES     (UNCOMPRESSED_TEXTURES+((32*32)*5))
#define UNCOMPRESSED_RAT_TEXTURE        UNCOMPRESSED_ENEMY_TEXTURES
#define UNCOMPRESSED_ENEMY_TEXTURE      (UNCOMPRESSED_RAT_TEXTURE+(24*24))
#define UNCOMPRESSED_OBJECT_TEXTURES    (UNCOMPRESSED_ENEMY_TEXTURE+((24*24)))
#define END_OF_TEXTURES                 (UNCOMPRESSED_OBJECT_TEXTURES+((16*16)*5))

//RENDER


#define SCREEN_TEXTURE_POSITION     (cpctm_screenPtr(CPCT_VMEM_START, 20, 16)) //PRECALCULAR VMEM_POS

#define SCREEN_TEXTURE_BUFFER       END_OF_TEXTURES //MAP_MEM + MAP_SIZE
#define SCREEN_TEXTURE_HEIGHT       100
#define SCREEN_TEXTURE_WIDTH        80
#define SCREEN_TEXTURE_WIDTH_HALF   40
#define SCREEN_TEXTURE_WIDTH_BYTES  40
#define END_OF_TEXTURE_BUFFER       (END_OF_TEXTURES + (SCREEN_TEXTURE_HEIGHT*SCREEN_TEXTURE_WIDTH_BYTES))

//Minimap

#define MINIMAP_POSITION            (cpctm_screenPtr(CPCT_VMEM_START, 32, 128)) //PRECALCULAR VMEM_POS


#define MINIMAP_HEIGHT              16
#define MINIMAP_HEIGHT_HALF         8
#define MINIMAP_HEIGHT_BYTES        64
#define MINIMAP_WIDTH               16
#define MINIMAP_WIDTH_HALF          8
#define MINIMAP_WIDTH_BYTES         16
#define MINIMAP_HEIGHT_WIDTH_RATIO  4

#define MINIMAP_BUFFER              END_OF_TEXTURE_BUFFER //MAP_MEM + MAP_SIZE
#define END_OF_MINIMAP_BUFFER       (END_OF_TEXTURE_BUFFER + (MINIMAP_HEIGHT_BYTES*MINIMAP_WIDTH_BYTES))


#define CELLS_IN_VIEW_ARRAY         END_OF_MINIMAP_BUFFER //SCREEN_TEXTURE_BUFFER + SCREEN_TEXTURE_WIDTH_BYTES*SCREEN_TEXTURE_HEIGHT
#define END_OF_CELLS_IN_VIEW_ARRAY  (CELLS_IN_VIEW_ARRAY + 80)



#define SCREEN_TEXTURE_GROUND_SKY_SIZE      (SCREEN_TEXTURE_WIDTH_BYTES*(SCREEN_TEXTURE_HEIGHT/2-1))
#define SCREEN_TEXTURE_HORIZON_WALL_SIZE    (2*SCREEN_TEXTURE_WIDTH_BYTES)
#define SCREEN_TEXTURE_HORIZON_WALL_START   (SCREEN_TEXTURE_BUFFER+SCREEN_TEXTURE_GROUND_SKY_SIZE)
#define SCREEN_TEXTURE_GROUND_START         (SCREEN_TEXTURE_HORIZON_WALL_START+SCREEN_TEXTURE_HORIZON_WALL_SIZE)


#define GENERATOR_DATA_PTR      END_OF_MAP_MEM
#define GENERATOR_DATA_END_PTR  (END_OF_MAP_MEM + (2*MAP_SIZE)*2)

//MINIMAP COLORS

#define MINIMAP_WALL_COLOR      1
#define MINIMAP_FLOOR_COLOR     3
#define MINIMAP_PLAYER_COLOR    4
#define MINIMAP_EXIT_COLOR      5
#define MINIMAP_ENEMY_COLOR     6



#define TEXTURE_WIDTH       32
#define TEXTURE_HEIGHT      32
#define TEXTURE_HEIGHT_HALF 16

#define ENEMY_SPRITE_WIDTH          24
#define ENEMY_SPRITE_HEIGHT         24
#define ENEMY_SPRITE_HEIGHT_HALF    12

#define ITEM_SPRITE_WIDTH       16
#define ITEM_SPRITE_HEIGHT      16
#define ITEM_SPRITE_HEIGHT_HALF 8

//MAP IDs

#define CELL_WALL_MASK      0b10000000 //IF(CELLID & CELL_WALL_MASK) ISWALL
#define CELL_ENEMY_MASK     0b00001111 //IF(CELLID & CELL_ENEMY_MASK) ISENEMY //MAX 15 active enemies
#define CELL_ITEM_MASK      0b01110000 //IF(CELLID & CELL_ITEM_MASK) ISITEM //MAX 6 different items + key

//Terrain
#define CELLTYPE_FLOOR      0b00000000

#define CELLTYPE_DOOR       0b10000000
#define CELLTYPE_WALL1      0b10000001
#define CELLTYPE_WALL2      0b10000010
#define CELLTYPE_WALL3      0b10000011
#define CELLTYPE_WALL4      0b10000100
#define CELLTYPE_UNDEFINED  0b10000111

//States

#define STATE_MAINMENU      0
#define STATE_INGAME        1
#define STATE_PAUSEMENU     2
#define STATE_LOADLEVEL     3
#define STATE_OPTIONS       4
#define STATE_GAMEOVER      5
#define STATE_CREDITS       6
#define STATE_VICTORY       7
#define STATE_INVENTORY     8
#define STATE_SAVEEXIT      9
#define STATE_LOADGAME      10



#define KING_LEVEL 32
#define KING_LEVEL_WIDTH 9
#define KING_LEVEL_HEIGHT 9

#define KING_LEVEL_PLAYER_X 4
#define KING_LEVEL_PLAYER_Y 7

#define KING_LEVEL_EXIT_X 4
#define KING_LEVEL_EXIT_Y 0

#define KING_LEVEL_KING_X 4
#define KING_LEVEL_KING_Y 2

//Palettes

#define SHARED_COLORS   7
#define VARIABLE_COLORS (16-SHARED_COLORS)


#define SKY_COLOR       SHARED_COLORS
#define GROUND_COLOR    (SHARED_COLORS+1)
#define HORIZON_COLOR   1

//Untextured render

#define DOOR1_COLOR (SHARED_COLORS+2)
#define DOOR2_COLOR (SHARED_COLORS+3)
#define WALL1_COLOR (SHARED_COLORS+4)
#define WALL2_COLOR (SHARED_COLORS+5)

#define BUTTON_COLOR_BACKGROUND 2
#define BUTTON_COLOR_HIGHLIGHT  6
#define BUTTON_COLOR_SELECTED   4



#endif