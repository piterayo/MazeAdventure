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
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _INITIALIZED
   4AA9                      32 _r_counter::
   4AA9                      33 	.ds 1
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
   007B 21 A9 4A      [10]   60 	ld	hl, #_r_counter+0
   007E 34            [11]   61 	inc	(hl)
   007F C9            [10]   62 	ret
                             63 ;src/GameFunctions.c:15: void game_init(){
                             64 ;	---------------------------------
                             65 ; Function game_init
                             66 ; ---------------------------------
   0080                      67 _game_init::
                             68 ;src/GameFunctions.c:16: cpct_disableFirmware();
   0080 CD BB 48      [17]   69 	call	_cpct_disableFirmware
                             70 ;src/GameFunctions.c:17: cpct_setVideoMode(0);
   0083 2E 00         [ 7]   71 	ld	l,#0x00
   0085 CD 97 48      [17]   72 	call	_cpct_setVideoMode
                             73 ;src/GameFunctions.c:18: cpct_fw2hw(g_palette,16);
   0088 21 10 00      [10]   74 	ld	hl,#0x0010
   008B E5            [11]   75 	push	hl
   008C 21 93 0A      [10]   76 	ld	hl,#_g_palette
   008F E5            [11]   77 	push	hl
   0090 CD 29 48      [17]   78 	call	_cpct_fw2hw
                             79 ;src/GameFunctions.c:19: cpct_setInterruptHandler(game_interrupt_handler);
   0093 21 7B 00      [10]   80 	ld	hl,#_game_interrupt_handler
   0096 CD CC 49      [17]   81 	call	_cpct_setInterruptHandler
                             82 ;src/GameFunctions.c:20: level_init_palettes();
   0099 CD EE 00      [17]   83 	call	_level_init_palettes
                             84 ;src/GameFunctions.c:21: cpct_setPalette(g_palette,16);
   009C 21 10 00      [10]   85 	ld	hl,#0x0010
   009F E5            [11]   86 	push	hl
   00A0 21 93 0A      [10]   87 	ld	hl,#_g_palette
   00A3 E5            [11]   88 	push	hl
   00A4 CD 04 47      [17]   89 	call	_cpct_setPalette
                             90 ;src/GameFunctions.c:22: cpct_setBorder(g_palette[1]);
   00A7 21 94 0A      [10]   91 	ld	hl, #_g_palette + 1
   00AA 46            [ 7]   92 	ld	b,(hl)
   00AB C5            [11]   93 	push	bc
   00AC 33            [ 6]   94 	inc	sp
   00AD 3E 10         [ 7]   95 	ld	a,#0x10
   00AF F5            [11]   96 	push	af
   00B0 33            [ 6]   97 	inc	sp
   00B1 CD 1B 47      [17]   98 	call	_cpct_setPALColour
   00B4 C9            [10]   99 	ret
                            100 	.area _CODE
                            101 	.area _INITIALIZER
   4AB6                     102 __xinit__r_counter:
   4AB6 00                  103 	.db #0x00	; 0
                            104 	.area _CABS (ABS)
