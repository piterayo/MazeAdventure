                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module GameFunctions
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _game_interrupt_handler
                             12 	.globl _level_init_palettes
                             13 	.globl _cpct_setPALColour
                             14 	.globl _cpct_setPalette
                             15 	.globl _cpct_fw2hw
                             16 	.globl _cpct_setVideoMode
                             17 	.globl _cpct_setInterruptHandler
                             18 	.globl _cpct_disableFirmware
                             19 	.globl _camelot_warriors_mode
                             20 	.globl _textures_on
                             21 	.globl _music_on
                             22 	.globl _r_counter
                             23 	.globl _movement_directionArray
                             24 	.globl _game_init
                             25 ;--------------------------------------------------------
                             26 ; special function registers
                             27 ;--------------------------------------------------------
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DATA
   7E16                      32 _r_counter::
   7E16                      33 	.ds 2
   7E18                      34 _music_on::
   7E18                      35 	.ds 1
   7E19                      36 _textures_on::
   7E19                      37 	.ds 1
   7E1A                      38 _camelot_warriors_mode::
   7E1A                      39 	.ds 1
                             40 ;--------------------------------------------------------
                             41 ; ram data
                             42 ;--------------------------------------------------------
                             43 	.area _INITIALIZED
                             44 ;--------------------------------------------------------
                             45 ; absolute external ram data
                             46 ;--------------------------------------------------------
                             47 	.area _DABS (ABS)
                             48 ;--------------------------------------------------------
                             49 ; global & static initialisations
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _GSINIT
                             53 	.area _GSFINAL
                             54 	.area _GSINIT
                             55 ;--------------------------------------------------------
                             56 ; Home
                             57 ;--------------------------------------------------------
                             58 	.area _HOME
                             59 	.area _HOME
                             60 ;--------------------------------------------------------
                             61 ; code
                             62 ;--------------------------------------------------------
                             63 	.area _CODE
                             64 ;src/GameFunctions.c:16: void game_interrupt_handler(){
                             65 ;	---------------------------------
                             66 ; Function game_interrupt_handler
                             67 ; ---------------------------------
   0BAA                      68 _game_interrupt_handler::
                             69 ;src/GameFunctions.c:17: ++r_counter;
   0BAA 21 16 7E      [10]   70 	ld	hl, #_r_counter+0
   0BAD 34            [11]   71 	inc	(hl)
   0BAE C0            [11]   72 	ret	NZ
   0BAF 21 17 7E      [10]   73 	ld	hl, #_r_counter+1
   0BB2 34            [11]   74 	inc	(hl)
   0BB3 C9            [10]   75 	ret
                             76 ;src/GameFunctions.c:25: void game_init(){
                             77 ;	---------------------------------
                             78 ; Function game_init
                             79 ; ---------------------------------
   0BB4                      80 _game_init::
                             81 ;src/GameFunctions.c:26: cpct_disableFirmware();
   0BB4 CD 60 7C      [17]   82 	call	_cpct_disableFirmware
                             83 ;src/GameFunctions.c:27: cpct_setVideoMode(0);
   0BB7 2E 00         [ 7]   84 	ld	l,#0x00
   0BB9 CD 3C 7C      [17]   85 	call	_cpct_setVideoMode
                             86 ;src/GameFunctions.c:29: cpct_fw2hw(g_palette,16);
   0BBC 21 10 00      [10]   87 	ld	hl,#0x0010
   0BBF E5            [11]   88 	push	hl
   0BC0 21 56 1A      [10]   89 	ld	hl,#_g_palette
   0BC3 E5            [11]   90 	push	hl
   0BC4 CD 08 7B      [17]   91 	call	_cpct_fw2hw
                             92 ;src/GameFunctions.c:31: cpct_setInterruptHandler(game_interrupt_handler);
   0BC7 21 AA 0B      [10]   93 	ld	hl,#_game_interrupt_handler
   0BCA CD 71 7D      [17]   94 	call	_cpct_setInterruptHandler
                             95 ;src/GameFunctions.c:32: level_init_palettes();
   0BCD CD E5 0F      [17]   96 	call	_level_init_palettes
                             97 ;src/GameFunctions.c:33: cpct_setPalette(g_palette,16);
   0BD0 21 10 00      [10]   98 	ld	hl,#0x0010
   0BD3 E5            [11]   99 	push	hl
   0BD4 21 56 1A      [10]  100 	ld	hl,#_g_palette
   0BD7 E5            [11]  101 	push	hl
   0BD8 CD 29 7A      [17]  102 	call	_cpct_setPalette
                            103 ;src/GameFunctions.c:34: cpct_setBorder(g_palette[1]);
   0BDB 21 57 1A      [10]  104 	ld	hl, #_g_palette + 1
   0BDE 46            [ 7]  105 	ld	b,(hl)
   0BDF C5            [11]  106 	push	bc
   0BE0 33            [ 6]  107 	inc	sp
   0BE1 3E 10         [ 7]  108 	ld	a,#0x10
   0BE3 F5            [11]  109 	push	af
   0BE4 33            [ 6]  110 	inc	sp
   0BE5 CD 40 7A      [17]  111 	call	_cpct_setPALColour
                            112 ;src/GameFunctions.c:36: music_on = 1;
   0BE8 21 18 7E      [10]  113 	ld	hl,#_music_on + 0
   0BEB 36 01         [10]  114 	ld	(hl), #0x01
                            115 ;src/GameFunctions.c:37: textures_on = 1;
   0BED 21 19 7E      [10]  116 	ld	hl,#_textures_on + 0
   0BF0 36 01         [10]  117 	ld	(hl), #0x01
                            118 ;src/GameFunctions.c:40: camelot_warriors_mode=0;
   0BF2 21 1A 7E      [10]  119 	ld	hl,#_camelot_warriors_mode + 0
   0BF5 36 00         [10]  120 	ld	(hl), #0x00
   0BF7 C9            [10]  121 	ret
   0BF8                     122 _movement_directionArray:
   0BF8 01                  123 	.db #0x01	;  1
   0BF9 00                  124 	.db #0x00	;  0
   0BFA 00                  125 	.db #0x00	;  0
   0BFB FF                  126 	.db #0xFF	; -1
   0BFC FF                  127 	.db #0xFF	; -1
   0BFD 00                  128 	.db #0x00	;  0
   0BFE 00                  129 	.db #0x00	;  0
   0BFF 01                  130 	.db #0x01	;  1
                            131 	.area _CODE
                            132 	.area _INITIALIZER
                            133 	.area _CABS (ABS)
