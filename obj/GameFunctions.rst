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
                             17 	.globl _cpct_memset
                             18 	.globl _cpct_setInterruptHandler
                             19 	.globl _cpct_disableFirmware
                             20 	.globl _r_counter
                             21 	.globl _game_init
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DATA
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _INITIALIZED
   4179                      33 _r_counter::
   4179                      34 	.ds 1
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
   0085                      59 _game_interrupt_handler::
                             60 ;src/GameFunctions.c:13: ++r_counter;
   0085 21 79 41      [10]   61 	ld	hl, #_r_counter+0
   0088 34            [11]   62 	inc	(hl)
   0089 C9            [10]   63 	ret
                             64 ;src/GameFunctions.c:16: void game_init(){
                             65 ;	---------------------------------
                             66 ; Function game_init
                             67 ; ---------------------------------
   008A                      68 _game_init::
                             69 ;src/GameFunctions.c:17: cpct_disableFirmware();
   008A CD 6B 3F      [17]   70 	call	_cpct_disableFirmware
                             71 ;src/GameFunctions.c:18: cpct_setVideoMode(0);
   008D 2E 00         [ 7]   72 	ld	l,#0x00
   008F CD 47 3F      [17]   73 	call	_cpct_setVideoMode
                             74 ;src/GameFunctions.c:19: cpct_fw2hw(g_palette,16);
   0092 21 10 00      [10]   75 	ld	hl,#0x0010
   0095 E5            [11]   76 	push	hl
   0096 21 95 0A      [10]   77 	ld	hl,#_g_palette
   0099 E5            [11]   78 	push	hl
   009A CD A0 3E      [17]   79 	call	_cpct_fw2hw
                             80 ;src/GameFunctions.c:20: cpct_setInterruptHandler(game_interrupt_handler);
   009D 21 85 00      [10]   81 	ld	hl,#_game_interrupt_handler
   00A0 CD 9C 40      [17]   82 	call	_cpct_setInterruptHandler
                             83 ;src/GameFunctions.c:21: level_init_palettes();
   00A3 CD 08 01      [17]   84 	call	_level_init_palettes
                             85 ;src/GameFunctions.c:22: cpct_setPalette(g_palette,16);
   00A6 21 10 00      [10]   86 	ld	hl,#0x0010
   00A9 E5            [11]   87 	push	hl
   00AA 21 95 0A      [10]   88 	ld	hl,#_g_palette
   00AD E5            [11]   89 	push	hl
   00AE CD BC 3D      [17]   90 	call	_cpct_setPalette
                             91 ;src/GameFunctions.c:23: cpct_setBorder(g_palette[1]);
   00B1 21 96 0A      [10]   92 	ld	hl, #_g_palette + 1
   00B4 46            [ 7]   93 	ld	b,(hl)
   00B5 C5            [11]   94 	push	bc
   00B6 33            [ 6]   95 	inc	sp
   00B7 3E 10         [ 7]   96 	ld	a,#0x10
   00B9 F5            [11]   97 	push	af
   00BA 33            [ 6]   98 	inc	sp
   00BB CD D3 3D      [17]   99 	call	_cpct_setPALColour
                            100 ;src/GameFunctions.c:25: cpct_memset(CPCT_VMEM_START, g_colors[0], 0x4000);
   00BE 21 A5 0A      [10]  101 	ld	hl, #_g_colors + 0
   00C1 46            [ 7]  102 	ld	b,(hl)
   00C2 21 00 40      [10]  103 	ld	hl,#0x4000
   00C5 E5            [11]  104 	push	hl
   00C6 C5            [11]  105 	push	bc
   00C7 33            [ 6]  106 	inc	sp
   00C8 26 C0         [ 7]  107 	ld	h, #0xC0
   00CA E5            [11]  108 	push	hl
   00CB CD 5D 3F      [17]  109 	call	_cpct_memset
   00CE C9            [10]  110 	ret
                            111 	.area _CODE
                            112 	.area _INITIALIZER
   417D                     113 __xinit__r_counter:
   417D 00                  114 	.db #0x00	; 0
                            115 	.area _CABS (ABS)
