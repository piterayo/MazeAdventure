                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_LoadLevel
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _level_load_level
                             12 	.globl _generate_level
                             13 	.globl _print_transparent_text
                             14 	.globl _draw_minimap_to_buffer
                             15 	.globl _render_draw_to_buffer
                             16 	.globl _statemanager_input_accepted
                             17 	.globl _statemanager_set_state
                             18 	.globl _cpct_memset
                             19 	.globl _state_loadlevel_enter
                             20 	.globl _state_loadlevel_return
                             21 	.globl _state_loadlevel_input
                             22 	.globl _state_loadlevel_update
                             23 	.globl _state_loadlevel_render
                             24 	.globl _state_loadlevel_exit
                             25 ;--------------------------------------------------------
                             26 ; special function registers
                             27 ;--------------------------------------------------------
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DATA
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _INITIALIZED
                             36 ;--------------------------------------------------------
                             37 ; absolute external ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DABS (ABS)
                             40 ;--------------------------------------------------------
                             41 ; global & static initialisations
                             42 ;--------------------------------------------------------
                             43 	.area _HOME
                             44 	.area _GSINIT
                             45 	.area _GSFINAL
                             46 	.area _GSINIT
                             47 ;--------------------------------------------------------
                             48 ; Home
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _HOME
                             52 ;--------------------------------------------------------
                             53 ; code
                             54 ;--------------------------------------------------------
                             55 	.area _CODE
                             56 ;src/State_LoadLevel.c:10: void state_loadlevel_enter(){
                             57 ;	---------------------------------
                             58 ; Function state_loadlevel_enter
                             59 ; ---------------------------------
   1BB0                      60 _state_loadlevel_enter::
                             61 ;src/State_LoadLevel.c:12: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1BB0 21 A4 0A      [10]   62 	ld	hl,#_g_colors+1
   1BB3 46            [ 7]   63 	ld	b,(hl)
   1BB4 21 00 40      [10]   64 	ld	hl,#0x4000
   1BB7 E5            [11]   65 	push	hl
   1BB8 C5            [11]   66 	push	bc
   1BB9 33            [ 6]   67 	inc	sp
   1BBA 26 C0         [ 7]   68 	ld	h, #0xC0
   1BBC E5            [11]   69 	push	hl
   1BBD CD 9A 4D      [17]   70 	call	_cpct_memset
                             71 ;src/State_LoadLevel.c:14: print_transparent_text("LOADING", 0xe391, 3);
   1BC0 3E 03         [ 7]   72 	ld	a,#0x03
   1BC2 F5            [11]   73 	push	af
   1BC3 33            [ 6]   74 	inc	sp
   1BC4 21 91 E3      [10]   75 	ld	hl,#0xE391
   1BC7 E5            [11]   76 	push	hl
   1BC8 21 DF 1B      [10]   77 	ld	hl,#___str_0
   1BCB E5            [11]   78 	push	hl
   1BCC CD 70 22      [17]   79 	call	_print_transparent_text
   1BCF F1            [10]   80 	pop	af
   1BD0 F1            [10]   81 	pop	af
   1BD1 33            [ 6]   82 	inc	sp
                             83 ;src/State_LoadLevel.c:16: generate_level();
   1BD2 CD 1E 08      [17]   84 	call	_generate_level
                             85 ;src/State_LoadLevel.c:17: level_load_level();
   1BD5 CD 4E 01      [17]   86 	call	_level_load_level
                             87 ;src/State_LoadLevel.c:19: render_draw_to_buffer();
   1BD8 CD AD 0D      [17]   88 	call	_render_draw_to_buffer
                             89 ;src/State_LoadLevel.c:20: draw_minimap_to_buffer();
   1BDB CD 07 19      [17]   90 	call	_draw_minimap_to_buffer
   1BDE C9            [10]   91 	ret
   1BDF                      92 ___str_0:
   1BDF 4C 4F 41 44 49 4E    93 	.ascii "LOADING"
        47
   1BE6 00                   94 	.db 0x00
                             95 ;src/State_LoadLevel.c:24: void state_loadlevel_return(){
                             96 ;	---------------------------------
                             97 ; Function state_loadlevel_return
                             98 ; ---------------------------------
   1BE7                      99 _state_loadlevel_return::
                            100 ;src/State_LoadLevel.c:26: }
   1BE7 C9            [10]  101 	ret
                            102 ;src/State_LoadLevel.c:29: void state_loadlevel_input() {
                            103 ;	---------------------------------
                            104 ; Function state_loadlevel_input
                            105 ; ---------------------------------
   1BE8                     106 _state_loadlevel_input::
                            107 ;src/State_LoadLevel.c:30: statemanager_input_accepted();
   1BE8 C3 82 1D      [10]  108 	jp  _statemanager_input_accepted
                            109 ;src/State_LoadLevel.c:33: void state_loadlevel_update(){
                            110 ;	---------------------------------
                            111 ; Function state_loadlevel_update
                            112 ; ---------------------------------
   1BEB                     113 _state_loadlevel_update::
                            114 ;src/State_LoadLevel.c:34: statemanager_set_state(STATE_INGAME);
   1BEB 2E 01         [ 7]  115 	ld	l,#0x01
   1BED C3 88 1D      [10]  116 	jp  _statemanager_set_state
                            117 ;src/State_LoadLevel.c:37: void state_loadlevel_render(){
                            118 ;	---------------------------------
                            119 ; Function state_loadlevel_render
                            120 ; ---------------------------------
   1BF0                     121 _state_loadlevel_render::
                            122 ;src/State_LoadLevel.c:39: }
   1BF0 C9            [10]  123 	ret
                            124 ;src/State_LoadLevel.c:41: void state_loadlevel_exit(){
                            125 ;	---------------------------------
                            126 ; Function state_loadlevel_exit
                            127 ; ---------------------------------
   1BF1                     128 _state_loadlevel_exit::
                            129 ;src/State_LoadLevel.c:43: }
   1BF1 C9            [10]  130 	ret
                            131 	.area _CODE
                            132 	.area _INITIALIZER
                            133 	.area _CABS (ABS)
