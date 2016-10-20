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
                             19 	.globl _r_counter
                             20 	.globl _game_init
                             21 ;--------------------------------------------------------
                             22 ; special function registers
                             23 ;--------------------------------------------------------
                             24 ;--------------------------------------------------------
                             25 ; ram data
                             26 ;--------------------------------------------------------
                             27 	.area _DATA
   4FA1                      28 _r_counter::
   4FA1                      29 	.ds 2
                             30 ;--------------------------------------------------------
                             31 ; ram data
                             32 ;--------------------------------------------------------
                             33 	.area _INITIALIZED
                             34 ;--------------------------------------------------------
                             35 ; absolute external ram data
                             36 ;--------------------------------------------------------
                             37 	.area _DABS (ABS)
                             38 ;--------------------------------------------------------
                             39 ; global & static initialisations
                             40 ;--------------------------------------------------------
                             41 	.area _HOME
                             42 	.area _GSINIT
                             43 	.area _GSFINAL
                             44 	.area _GSINIT
                             45 ;--------------------------------------------------------
                             46 ; Home
                             47 ;--------------------------------------------------------
                             48 	.area _HOME
                             49 	.area _HOME
                             50 ;--------------------------------------------------------
                             51 ; code
                             52 ;--------------------------------------------------------
                             53 	.area _CODE
                             54 ;src/GameFunctions.c:11: void game_interrupt_handler(){
                             55 ;	---------------------------------
                             56 ; Function game_interrupt_handler
                             57 ; ---------------------------------
   007B                      58 _game_interrupt_handler::
                             59 ;src/GameFunctions.c:12: ++r_counter;
   007B 21 A1 4F      [10]   60 	ld	hl, #_r_counter+0
   007E 34            [11]   61 	inc	(hl)
   007F C0            [11]   62 	ret	NZ
   0080 21 A2 4F      [10]   63 	ld	hl, #_r_counter+1
   0083 34            [11]   64 	inc	(hl)
   0084 C9            [10]   65 	ret
                             66 ;src/GameFunctions.c:15: void game_init(){
                             67 ;	---------------------------------
                             68 ; Function game_init
                             69 ; ---------------------------------
   0085                      70 _game_init::
                             71 ;src/GameFunctions.c:16: cpct_disableFirmware();
   0085 CD B0 4D      [17]   72 	call	_cpct_disableFirmware
                             73 ;src/GameFunctions.c:17: cpct_setVideoMode(0);
   0088 2E 00         [ 7]   74 	ld	l,#0x00
   008A CD 8C 4D      [17]   75 	call	_cpct_setVideoMode
                             76 ;src/GameFunctions.c:19: cpct_fw2hw(g_palette,16);
   008D 21 10 00      [10]   77 	ld	hl,#0x0010
   0090 E5            [11]   78 	push	hl
   0091 21 93 0A      [10]   79 	ld	hl,#_g_palette
   0094 E5            [11]   80 	push	hl
   0095 CD D9 4C      [17]   81 	call	_cpct_fw2hw
                             82 ;src/GameFunctions.c:21: cpct_setInterruptHandler(game_interrupt_handler);
   0098 21 7B 00      [10]   83 	ld	hl,#_game_interrupt_handler
   009B CD C1 4E      [17]   84 	call	_cpct_setInterruptHandler
                             85 ;src/GameFunctions.c:22: level_init_palettes();
   009E CD EE 00      [17]   86 	call	_level_init_palettes
                             87 ;src/GameFunctions.c:23: cpct_setPalette(g_palette,16);
   00A1 21 10 00      [10]   88 	ld	hl,#0x0010
   00A4 E5            [11]   89 	push	hl
   00A5 21 93 0A      [10]   90 	ld	hl,#_g_palette
   00A8 E5            [11]   91 	push	hl
   00A9 CD B9 4B      [17]   92 	call	_cpct_setPalette
                             93 ;src/GameFunctions.c:24: cpct_setBorder(g_palette[1]);
   00AC 21 94 0A      [10]   94 	ld	hl, #_g_palette + 1
   00AF 46            [ 7]   95 	ld	b,(hl)
   00B0 C5            [11]   96 	push	bc
   00B1 33            [ 6]   97 	inc	sp
   00B2 3E 10         [ 7]   98 	ld	a,#0x10
   00B4 F5            [11]   99 	push	af
   00B5 33            [ 6]  100 	inc	sp
   00B6 CD D0 4B      [17]  101 	call	_cpct_setPALColour
   00B9 C9            [10]  102 	ret
                            103 	.area _CODE
                            104 	.area _INITIALIZER
                            105 	.area _CABS (ABS)
