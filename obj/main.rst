                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module main
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 	.globl _init
                             13 	.globl _interrupt_handler
                             14 	.globl _statemanager_main_loop
                             15 	.globl _statemanager_set_state
                             16 	.globl _level_init_palettes
                             17 	.globl _init_generator
                             18 	.globl _cpct_setPALColour
                             19 	.globl _cpct_setPalette
                             20 	.globl _cpct_fw2hw
                             21 	.globl _cpct_setVideoMode
                             22 	.globl _cpct_scanKeyboard_f
                             23 	.globl _cpct_memset
                             24 	.globl _cpct_setInterruptHandler
                             25 	.globl _cpct_disableFirmware
                             26 ;--------------------------------------------------------
                             27 ; special function registers
                             28 ;--------------------------------------------------------
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _DATA
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _INITIALIZED
                             37 ;--------------------------------------------------------
                             38 ; absolute external ram data
                             39 ;--------------------------------------------------------
                             40 	.area _DABS (ABS)
                             41 ;--------------------------------------------------------
                             42 ; global & static initialisations
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _GSINIT
                             46 	.area _GSFINAL
                             47 	.area _GSINIT
                             48 ;--------------------------------------------------------
                             49 ; Home
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _HOME
                             53 ;--------------------------------------------------------
                             54 ; code
                             55 ;--------------------------------------------------------
                             56 	.area _CODE
                             57 ;src/main.c:29: void interrupt_handler(){
                             58 ;	---------------------------------
                             59 ; Function interrupt_handler
                             60 ; ---------------------------------
   5114                      61 _interrupt_handler::
                             62 ;src/main.c:30: cpct_setBorder(g_palette[0]);
   5114 21 3B 5A      [10]   63 	ld	hl, #_g_palette + 0
   5117 46            [ 7]   64 	ld	b,(hl)
   5118 C5            [11]   65 	push	bc
   5119 33            [ 6]   66 	inc	sp
   511A 3E 10         [ 7]   67 	ld	a,#0x10
   511C F5            [11]   68 	push	af
   511D 33            [ 6]   69 	inc	sp
   511E CD AE 8C      [17]   70 	call	_cpct_setPALColour
                             71 ;src/main.c:33: cpct_setBorder(g_palette[1]);
   5121 21 3C 5A      [10]   72 	ld	hl, #_g_palette + 1
   5124 46            [ 7]   73 	ld	b,(hl)
   5125 C5            [11]   74 	push	bc
   5126 33            [ 6]   75 	inc	sp
   5127 3E 10         [ 7]   76 	ld	a,#0x10
   5129 F5            [11]   77 	push	af
   512A 33            [ 6]   78 	inc	sp
   512B CD AE 8C      [17]   79 	call	_cpct_setPALColour
   512E C9            [10]   80 	ret
                             81 ;src/main.c:36: void init(){
                             82 ;	---------------------------------
                             83 ; Function init
                             84 ; ---------------------------------
   512F                      85 _init::
                             86 ;src/main.c:37: cpct_disableFirmware();
   512F CD 07 8F      [17]   87 	call	_cpct_disableFirmware
                             88 ;src/main.c:38: cpct_setVideoMode(0);
   5132 2E 00         [ 7]   89 	ld	l,#0x00
   5134 CD D3 8E      [17]   90 	call	_cpct_setVideoMode
                             91 ;src/main.c:39: cpct_fw2hw(g_palette,16);
   5137 21 10 00      [10]   92 	ld	hl,#0x0010
   513A E5            [11]   93 	push	hl
   513B 21 3B 5A      [10]   94 	ld	hl,#_g_palette
   513E E5            [11]   95 	push	hl
   513F CD 2C 8E      [17]   96 	call	_cpct_fw2hw
                             97 ;src/main.c:40: cpct_setInterruptHandler(interrupt_handler);
   5142 21 14 51      [10]   98 	ld	hl,#_interrupt_handler
   5145 CD 38 90      [17]   99 	call	_cpct_setInterruptHandler
                            100 ;src/main.c:41: level_init_palettes();
   5148 CD 45 50      [17]  101 	call	_level_init_palettes
                            102 ;src/main.c:42: cpct_setPalette(g_palette,16);
   514B 21 10 00      [10]  103 	ld	hl,#0x0010
   514E E5            [11]  104 	push	hl
   514F 21 3B 5A      [10]  105 	ld	hl,#_g_palette
   5152 E5            [11]  106 	push	hl
   5153 CD 97 8C      [17]  107 	call	_cpct_setPalette
                            108 ;src/main.c:43: cpct_setBorder(g_palette[12]);
   5156 21 47 5A      [10]  109 	ld	hl, #_g_palette + 12
   5159 46            [ 7]  110 	ld	b,(hl)
   515A C5            [11]  111 	push	bc
   515B 33            [ 6]  112 	inc	sp
   515C 3E 10         [ 7]  113 	ld	a,#0x10
   515E F5            [11]  114 	push	af
   515F 33            [ 6]  115 	inc	sp
   5160 CD AE 8C      [17]  116 	call	_cpct_setPALColour
                            117 ;src/main.c:45: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
   5163 21 57 5A      [10]  118 	ld	hl, #(_g_colors + 0x000c) + 0
   5166 46            [ 7]  119 	ld	b,(hl)
   5167 21 00 40      [10]  120 	ld	hl,#0x4000
   516A E5            [11]  121 	push	hl
   516B C5            [11]  122 	push	bc
   516C 33            [ 6]  123 	inc	sp
   516D 26 C0         [ 7]  124 	ld	h, #0xC0
   516F E5            [11]  125 	push	hl
   5170 CD F1 8E      [17]  126 	call	_cpct_memset
                            127 ;src/main.c:47: cpct_scanKeyboard_f();
   5173 CD 2D 8C      [17]  128 	call	_cpct_scanKeyboard_f
                            129 ;src/main.c:48: init_generator();
   5176 CD 87 51      [17]  130 	call	_init_generator
   5179 C9            [10]  131 	ret
                            132 ;src/main.c:51: void main(void) {
                            133 ;	---------------------------------
                            134 ; Function main
                            135 ; ---------------------------------
   517A                     136 _main::
                            137 ;src/main.c:52: init();
   517A CD 2F 51      [17]  138 	call	_init
                            139 ;src/main.c:54: statemanager_set_state(STATE_MAINMENU);
   517D AF            [ 4]  140 	xor	a, a
   517E F5            [11]  141 	push	af
   517F 33            [ 6]  142 	inc	sp
   5180 CD 10 6C      [17]  143 	call	_statemanager_set_state
   5183 33            [ 6]  144 	inc	sp
                            145 ;src/main.c:56: statemanager_main_loop();
   5184 C3 F0 6C      [10]  146 	jp  _statemanager_main_loop
                            147 	.area _CODE
                            148 	.area _INITIALIZER
                            149 	.area _CABS (ABS)
