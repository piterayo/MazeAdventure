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
                             11 	.globl _cpct_drawSprite
                             12 	.globl _renderCompass
                             13 ;--------------------------------------------------------
                             14 ; special function registers
                             15 ;--------------------------------------------------------
                             16 ;--------------------------------------------------------
                             17 ; ram data
                             18 ;--------------------------------------------------------
                             19 	.area _DATA
                             20 ;--------------------------------------------------------
                             21 ; ram data
                             22 ;--------------------------------------------------------
                             23 	.area _INITIALIZED
                             24 ;--------------------------------------------------------
                             25 ; absolute external ram data
                             26 ;--------------------------------------------------------
                             27 	.area _DABS (ABS)
                             28 ;--------------------------------------------------------
                             29 ; global & static initialisations
                             30 ;--------------------------------------------------------
                             31 	.area _HOME
                             32 	.area _GSINIT
                             33 	.area _GSFINAL
                             34 	.area _GSINIT
                             35 ;--------------------------------------------------------
                             36 ; Home
                             37 ;--------------------------------------------------------
                             38 	.area _HOME
                             39 	.area _HOME
                             40 ;--------------------------------------------------------
                             41 ; code
                             42 ;--------------------------------------------------------
                             43 	.area _CODE
                             44 ;src/UI_Compass.c:6: void renderCompass(){
                             45 ;	---------------------------------
                             46 ; Function renderCompass
                             47 ; ---------------------------------
   540A                      48 _renderCompass::
                             49 ;src/UI_Compass.c:7: cpct_drawSprite(compass_tileset[PLAYER_directionIndex/2],COMPASS_POSITION,8,16);
   540A 01 B2 58      [10]   50 	ld	bc,#_compass_tileset+0
   540D FD 21 2B 48   [14]   51 	ld	iy,#_PLAYER_directionIndex
   5411 FD 6E 00      [19]   52 	ld	l,0 (iy)
   5414 CB 3D         [ 8]   53 	srl	l
   5416 26 00         [ 7]   54 	ld	h,#0x00
   5418 29            [11]   55 	add	hl, hl
   5419 09            [11]   56 	add	hl,bc
   541A 4E            [ 7]   57 	ld	c,(hl)
   541B 23            [ 6]   58 	inc	hl
   541C 46            [ 7]   59 	ld	b,(hl)
   541D 21 08 10      [10]   60 	ld	hl,#0x1008
   5420 E5            [11]   61 	push	hl
   5421 21 24 C0      [10]   62 	ld	hl,#0xC024
   5424 E5            [11]   63 	push	hl
   5425 C5            [11]   64 	push	bc
   5426 CD 5B 63      [17]   65 	call	_cpct_drawSprite
   5429 C9            [10]   66 	ret
                             67 	.area _CODE
                             68 	.area _INITIALIZER
                             69 	.area _CABS (ABS)
