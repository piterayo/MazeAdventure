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
                             20 	.globl _movement_directionArray
                             21 	.globl _game_init
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DATA
   5B26                      29 _r_counter::
   5B26                      30 	.ds 2
                             31 ;--------------------------------------------------------
                             32 ; ram data
                             33 ;--------------------------------------------------------
                             34 	.area _INITIALIZED
                             35 ;--------------------------------------------------------
                             36 ; absolute external ram data
                             37 ;--------------------------------------------------------
                             38 	.area _DABS (ABS)
                             39 ;--------------------------------------------------------
                             40 ; global & static initialisations
                             41 ;--------------------------------------------------------
                             42 	.area _HOME
                             43 	.area _GSINIT
                             44 	.area _GSFINAL
                             45 	.area _GSINIT
                             46 ;--------------------------------------------------------
                             47 ; Home
                             48 ;--------------------------------------------------------
                             49 	.area _HOME
                             50 	.area _HOME
                             51 ;--------------------------------------------------------
                             52 ; code
                             53 ;--------------------------------------------------------
                             54 	.area _CODE
                             55 ;src/GameFunctions.c:11: void game_interrupt_handler(){
                             56 ;	---------------------------------
                             57 ; Function game_interrupt_handler
                             58 ; ---------------------------------
   0677                      59 _game_interrupt_handler::
                             60 ;src/GameFunctions.c:12: ++r_counter;
   0677 21 26 5B      [10]   61 	ld	hl, #_r_counter+0
   067A 34            [11]   62 	inc	(hl)
   067B C0            [11]   63 	ret	NZ
   067C 21 27 5B      [10]   64 	ld	hl, #_r_counter+1
   067F 34            [11]   65 	inc	(hl)
   0680 C9            [10]   66 	ret
                             67 ;src/GameFunctions.c:20: void game_init(){
                             68 ;	---------------------------------
                             69 ; Function game_init
                             70 ; ---------------------------------
   0681                      71 _game_init::
                             72 ;src/GameFunctions.c:21: cpct_disableFirmware();
   0681 CD 52 59      [17]   73 	call	_cpct_disableFirmware
                             74 ;src/GameFunctions.c:22: cpct_setVideoMode(0);
   0684 2E 00         [ 7]   75 	ld	l,#0x00
   0686 CD 2E 59      [17]   76 	call	_cpct_setVideoMode
                             77 ;src/GameFunctions.c:24: cpct_fw2hw(g_palette,16);
   0689 21 10 00      [10]   78 	ld	hl,#0x0010
   068C E5            [11]   79 	push	hl
   068D 21 56 10      [10]   80 	ld	hl,#_g_palette
   0690 E5            [11]   81 	push	hl
   0691 CD 7B 58      [17]   82 	call	_cpct_fw2hw
                             83 ;src/GameFunctions.c:26: cpct_setInterruptHandler(game_interrupt_handler);
   0694 21 77 06      [10]   84 	ld	hl,#_game_interrupt_handler
   0697 CD 63 5A      [17]   85 	call	_cpct_setInterruptHandler
                             86 ;src/GameFunctions.c:27: level_init_palettes();
   069A CD F2 06      [17]   87 	call	_level_init_palettes
                             88 ;src/GameFunctions.c:28: cpct_setPalette(g_palette,16);
   069D 21 10 00      [10]   89 	ld	hl,#0x0010
   06A0 E5            [11]   90 	push	hl
   06A1 21 56 10      [10]   91 	ld	hl,#_g_palette
   06A4 E5            [11]   92 	push	hl
   06A5 CD 5B 57      [17]   93 	call	_cpct_setPalette
                             94 ;src/GameFunctions.c:29: cpct_setBorder(g_palette[1]);
   06A8 21 57 10      [10]   95 	ld	hl, #_g_palette + 1
   06AB 46            [ 7]   96 	ld	b,(hl)
   06AC C5            [11]   97 	push	bc
   06AD 33            [ 6]   98 	inc	sp
   06AE 3E 10         [ 7]   99 	ld	a,#0x10
   06B0 F5            [11]  100 	push	af
   06B1 33            [ 6]  101 	inc	sp
   06B2 CD 72 57      [17]  102 	call	_cpct_setPALColour
   06B5 C9            [10]  103 	ret
   06B6                     104 _movement_directionArray:
   06B6 01                  105 	.db #0x01	;  1
   06B7 00                  106 	.db #0x00	;  0
   06B8 00                  107 	.db #0x00	;  0
   06B9 FF                  108 	.db #0xFF	; -1
   06BA FF                  109 	.db #0xFF	; -1
   06BB 00                  110 	.db #0x00	;  0
   06BC 00                  111 	.db #0x00	;  0
   06BD 01                  112 	.db #0x01	;  1
                            113 	.area _CODE
                            114 	.area _INITIALIZER
                            115 	.area _CABS (ABS)
