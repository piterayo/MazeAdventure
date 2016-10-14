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
                             18 	.globl _statemanager_close_state
                             19 	.globl _cpct_memset
                             20 	.globl _state_loadlevel_enter
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
   1B65                      60 _state_loadlevel_enter::
                             61 ;src/State_LoadLevel.c:11: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1B65 21 B3 0A      [10]   62 	ld	hl,#_g_colors+1
   1B68 46            [ 7]   63 	ld	b,(hl)
   1B69 21 00 40      [10]   64 	ld	hl,#0x4000
   1B6C E5            [11]   65 	push	hl
   1B6D C5            [11]   66 	push	bc
   1B6E 33            [ 6]   67 	inc	sp
   1B6F 26 C0         [ 7]   68 	ld	h, #0xC0
   1B71 E5            [11]   69 	push	hl
   1B72 CD F1 46      [17]   70 	call	_cpct_memset
                             71 ;src/State_LoadLevel.c:13: print_transparent_text("LOADING", 0xe391, 3);
   1B75 3E 03         [ 7]   72 	ld	a,#0x03
   1B77 F5            [11]   73 	push	af
   1B78 33            [ 6]   74 	inc	sp
   1B79 21 91 E3      [10]   75 	ld	hl,#0xE391
   1B7C E5            [11]   76 	push	hl
   1B7D 21 94 1B      [10]   77 	ld	hl,#___str_0
   1B80 E5            [11]   78 	push	hl
   1B81 CD AB 21      [17]   79 	call	_print_transparent_text
   1B84 F1            [10]   80 	pop	af
   1B85 F1            [10]   81 	pop	af
   1B86 33            [ 6]   82 	inc	sp
                             83 ;src/State_LoadLevel.c:15: generate_level();
   1B87 CD 3B 08      [17]   84 	call	_generate_level
                             85 ;src/State_LoadLevel.c:16: level_load_level();
   1B8A CD 5D 01      [17]   86 	call	_level_load_level
                             87 ;src/State_LoadLevel.c:18: render_draw_to_buffer();
   1B8D CD B8 0D      [17]   88 	call	_render_draw_to_buffer
                             89 ;src/State_LoadLevel.c:19: draw_minimap_to_buffer();
   1B90 CD 12 19      [17]   90 	call	_draw_minimap_to_buffer
   1B93 C9            [10]   91 	ret
   1B94                      92 ___str_0:
   1B94 4C 4F 41 44 49 4E    93 	.ascii "LOADING"
        47
   1B9B 00                   94 	.db 0x00
                             95 ;src/State_LoadLevel.c:23: void state_loadlevel_input(){
                             96 ;	---------------------------------
                             97 ; Function state_loadlevel_input
                             98 ; ---------------------------------
   1B9C                      99 _state_loadlevel_input::
                            100 ;src/State_LoadLevel.c:24: statemanager_input_accepted();
   1B9C C3 1D 1D      [10]  101 	jp  _statemanager_input_accepted
                            102 ;src/State_LoadLevel.c:27: void state_loadlevel_update(){
                            103 ;	---------------------------------
                            104 ; Function state_loadlevel_update
                            105 ; ---------------------------------
   1B9F                     106 _state_loadlevel_update::
                            107 ;src/State_LoadLevel.c:28: statemanager_close_state();
   1B9F CD C9 1D      [17]  108 	call	_statemanager_close_state
                            109 ;src/State_LoadLevel.c:29: statemanager_set_state(STATE_INGAME);
   1BA2 3E 01         [ 7]  110 	ld	a,#0x01
   1BA4 F5            [11]  111 	push	af
   1BA5 33            [ 6]  112 	inc	sp
   1BA6 CD 23 1D      [17]  113 	call	_statemanager_set_state
   1BA9 33            [ 6]  114 	inc	sp
   1BAA C9            [10]  115 	ret
                            116 ;src/State_LoadLevel.c:32: void state_loadlevel_render(){
                            117 ;	---------------------------------
                            118 ; Function state_loadlevel_render
                            119 ; ---------------------------------
   1BAB                     120 _state_loadlevel_render::
                            121 ;src/State_LoadLevel.c:34: }
   1BAB C9            [10]  122 	ret
                            123 ;src/State_LoadLevel.c:36: void state_loadlevel_exit(){
                            124 ;	---------------------------------
                            125 ; Function state_loadlevel_exit
                            126 ; ---------------------------------
   1BAC                     127 _state_loadlevel_exit::
                            128 ;src/State_LoadLevel.c:38: }
   1BAC C9            [10]  129 	ret
                            130 	.area _CODE
                            131 	.area _INITIALIZER
                            132 	.area _CABS (ABS)
