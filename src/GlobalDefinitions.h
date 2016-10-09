

#ifndef GLOBALDEFINITIONS_H
#define GLOBALDEFINITIONS_H

//MAP

#define MAP_MEM         0x0040
#define MAP_HEIGHT      32
#define MAP_WIDTH       32
#define MAP_SIZE        1024
#define END_OF_MAP_MEM  0x0440

//TEXTURES

#define UNCOMPRESSED_TEXTURES           0x0440
#define UNCOMPRESSED_SHARED_TEXTURES    0x0440
#define UNCOMPRESSED_LEVEL_TEXTURES     0x0840
#define UNCOMPRESSED_ENEMY_TEXTURES     0x1840
#define UNCOMPRESSED_OBJECT_TEXTURES    0x2140
#define END_OF_TEXTURES                 0x2940 //0x0440 + 0x2700

//RENDER


#define SCREEN_TEXTURE_POSITION     0xC0B4 //PRECALCULAR VMEM_POS

#define SCREEN_TEXTURE_BUFFER       END_OF_TEXTURES //MAP_MEM + MAP_SIZE
#define SCREEN_TEXTURE_HEIGHT       100
#define SCREEN_TEXTURE_WIDTH        80
#define SCREEN_TEXTURE_WIDTH_HALF   40
#define SCREEN_TEXTURE_WIDTH_BYTES  40
#define END_OF_TEXTURE_BUFFER       (END_OF_TEXTURES + 0xFA0)



#define CELLS_IN_VIEW_ARRAY         END_OF_TEXTURE_BUFFER //SCREEN_TEXTURE_BUFFER + SCREEN_TEXTURE_WIDTH_BYTES*SCREEN_TEXTURE_HEIGHT
#define END_OF_CELLS_IN_VIEW_ARRAY  (CELLS_IN_VIEW_ARRAY + 80)



#define SCREEN_TEXTURE_GROUND_SKY_SIZE      (SCREEN_TEXTURE_WIDTH_BYTES*(SCREEN_TEXTURE_HEIGHT/2-1))
#define SCREEN_TEXTURE_HORIZON_WALL_SIZE    (2*SCREEN_TEXTURE_WIDTH_BYTES)
#define SCREEN_TEXTURE_HORIZON_WALL_START   (SCREEN_TEXTURE_BUFFER+SCREEN_TEXTURE_GROUND_SKY_SIZE)
#define SCREEN_TEXTURE_GROUND_START         (SCREEN_TEXTURE_HORIZON_WALL_START+SCREEN_TEXTURE_HORIZON_WALL_SIZE)


#define GENERATOR_DATA_PTR      END_OF_TEXTURES
#define GENERATOR_DATA_END_PTR  (END_OF_TEXTURES + 4096)

#define MINIMAP_POSITION            0xC570 //PRECALCULAR VMEM_POS

#define MINIMAP_BUFFER              0x1C40 //MAP_MEM + MAP_SIZE
#define MINIMAP_HEIGHT              16
#define MINIMAP_HEIGHT_HALF         8
#define MINIMAP_HEIGHT_BYTES        64
#define MINIMAP_WIDTH               16
#define MINIMAP_WIDTH_HALF          8
#define MINIMAP_WIDTH_BYTES         16
#define MINIMAP_HEIGHT_WIDTH_RATIO  4



#define COMPASS_POSITION    0xC024

//MINIMAP COLORS

#define MINIMAP_WALL_COLOR      1
#define MINIMAP_FLOOR_COLOR     3
#define MINIMAP_PLAYER_COLOR    4
#define MINIMAP_EXIT_COLOR      8

#define GROUND_COLOR    6
#define SKY_COLOR       5
#define HORIZON_COLOR   1

//Untextured render

#define WALL1_COLOR 14
#define WALL2_COLOR 13
#define DOOR1_COLOR 12
#define DOOR2_COLOR 15


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

//Items

#define CELL_ITEM1 0b00010000
#define CELL_ITEM2 0b00100000
#define CELL_ITEM3 0b00110000
#define CELL_ITEM4 0b01000000
#define CELL_ITEM5 0b01010000
#define CELL_ITEM6 0b01100000
#define CELL_KEY   0b01110000 //EXIT KEY


#endif