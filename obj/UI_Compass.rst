                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_Compass
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _player_get_direction_index
                             12 	.globl _cpct_drawSprite
                             13 	.globl _renderCompass
                             14 ;--------------------------------------------------------
                             15 ; special function registers
                             16 ;--------------------------------------------------------
                             17 ;--------------------------------------------------------
                             18 ; ram data
                             19 ;--------------------------------------------------------
                             20 	.area _DATA
                             21 ;--------------------------------------------------------
                             22 ; ram data
                             23 ;--------------------------------------------------------
                             24 	.area _INITIALIZED
                             25 ;--------------------------------------------------------
                             26 ; absolute external ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DABS (ABS)
                             29 ;--------------------------------------------------------
                             30 ; global & static initialisations
                             31 ;--------------------------------------------------------
                             32 	.area _HOME
                             33 	.area _GSINIT
                             34 	.area _GSFINAL
                             35 	.area _GSINIT
                             36 ;--------------------------------------------------------
                             37 ; Home
                             38 ;--------------------------------------------------------
                             39 	.area _HOME
                             40 	.area _HOME
                             41 ;--------------------------------------------------------
                             42 ; code
                             43 ;--------------------------------------------------------
                             44 	.area _CODE
                             45 ;src/UI_Compass.c:6: void renderCompass(){
                             46 ;	---------------------------------
                             47 ; Function renderCompass
                             48 ; ---------------------------------
   43AA                      49 _renderCompass::
                             50 ;src/UI_Compass.c:7: cpct_drawSprite(compass_tileset[player_get_direction_index()/2],COMPASS_POSITION,8,16);
   43AA CD 5F 1A      [17]   51 	call	_player_get_direction_index
   43AD CB 3D         [ 8]   52 	srl	l
   43AF 26 00         [ 7]   53 	ld	h,#0x00
   43B1 29            [11]   54 	add	hl, hl
   43B2 11 F8 4E      [10]   55 	ld	de,#_compass_tileset
   43B5 19            [11]   56 	add	hl,de
   43B6 4E            [ 7]   57 	ld	c,(hl)
   43B7 23            [ 6]   58 	inc	hl
   43B8 46            [ 7]   59 	ld	b,(hl)
   43B9 21 08 10      [10]   60 	ld	hl,#0x1008
   43BC E5            [11]   61 	push	hl
   43BD 21 24 C0      [10]   62 	ld	hl,#0xC024
   43C0 E5            [11]   63 	push	hl
   43C1 C5            [11]   64 	push	bc
   43C2 CD 0B 83      [17]   65 	call	_cpct_drawSprite
   43C5 C9            [10]   66 	ret
                             67 	.area _CODE
                             68 	.area _INITIALIZER
                             69 	.area _CABS (ABS)
