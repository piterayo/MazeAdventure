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
   1BA4                      60 _state_loadlevel_enter::
                             61 ;src/State_LoadLevel.c:11: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1BA4 21 A4 0A      [10]   62 	ld	hl,#_g_colors+1
   1BA7 46            [ 7]   63 	ld	b,(hl)
   1BA8 21 00 40      [10]   64 	ld	hl,#0x4000
   1BAB E5            [11]   65 	push	hl
   1BAC C5            [11]   66 	push	bc
   1BAD 33            [ 6]   67 	inc	sp
   1BAE 26 C0         [ 7]   68 	ld	h, #0xC0
   1BB0 E5            [11]   69 	push	hl
   1BB1 CD A5 48      [17]   70 	call	_cpct_memset
                             71 ;src/State_LoadLevel.c:13: print_transparent_text("LOADING", 0xe391, 3);
   1BB4 3E 03         [ 7]   72 	ld	a,#0x03
   1BB6 F5            [11]   73 	push	af
   1BB7 33            [ 6]   74 	inc	sp
   1BB8 21 91 E3      [10]   75 	ld	hl,#0xE391
   1BBB E5            [11]   76 	push	hl
   1BBC 21 D3 1B      [10]   77 	ld	hl,#___str_0
   1BBF E5            [11]   78 	push	hl
   1BC0 CD 67 22      [17]   79 	call	_print_transparent_text
   1BC3 F1            [10]   80 	pop	af
   1BC4 F1            [10]   81 	pop	af
   1BC5 33            [ 6]   82 	inc	sp
                             83 ;src/State_LoadLevel.c:15: generate_level();
   1BC6 CD 2C 08      [17]   84 	call	_generate_level
                             85 ;src/State_LoadLevel.c:16: level_load_level();
   1BC9 CD 4E 01      [17]   86 	call	_level_load_level
                             87 ;src/State_LoadLevel.c:18: render_draw_to_buffer();
   1BCC CD A9 0D      [17]   88 	call	_render_draw_to_buffer
                             89 ;src/State_LoadLevel.c:19: draw_minimap_to_buffer();
   1BCF CD 03 19      [17]   90 	call	_draw_minimap_to_buffer
   1BD2 C9            [10]   91 	ret
   1BD3                      92 ___str_0:
   1BD3 4C 4F 41 44 49 4E    93 	.ascii "LOADING"
        47
   1BDA 00                   94 	.db 0x00
                             95 ;src/State_LoadLevel.c:23: void state_loadlevel_return(){
                             96 ;	---------------------------------
                             97 ; Function state_loadlevel_return
                             98 ; ---------------------------------
   1BDB                      99 _state_loadlevel_return::
                            100 ;src/State_LoadLevel.c:25: }
   1BDB C9            [10]  101 	ret
                            102 ;src/State_LoadLevel.c:28: void state_loadlevel_input(){
                            103 ;	---------------------------------
                            104 ; Function state_loadlevel_input
                            105 ; ---------------------------------
   1BDC                     106 _state_loadlevel_input::
                            107 ;src/State_LoadLevel.c:29: statemanager_input_accepted();
   1BDC C3 7F 1D      [10]  108 	jp  _statemanager_input_accepted
                            109 ;src/State_LoadLevel.c:32: void state_loadlevel_update(){
                            110 ;	---------------------------------
                            111 ; Function state_loadlevel_update
                            112 ; ---------------------------------
   1BDF                     113 _state_loadlevel_update::
                            114 ;src/State_LoadLevel.c:34: statemanager_set_state(STATE_INGAME);
   1BDF 3E 01         [ 7]  115 	ld	a,#0x01
   1BE1 F5            [11]  116 	push	af
   1BE2 33            [ 6]  117 	inc	sp
   1BE3 CD 85 1D      [17]  118 	call	_statemanager_set_state
   1BE6 33            [ 6]  119 	inc	sp
   1BE7 C9            [10]  120 	ret
                            121 ;src/State_LoadLevel.c:37: void state_loadlevel_render(){
                            122 ;	---------------------------------
                            123 ; Function state_loadlevel_render
                            124 ; ---------------------------------
   1BE8                     125 _state_loadlevel_render::
                            126 ;src/State_LoadLevel.c:39: }
   1BE8 C9            [10]  127 	ret
                            128 ;src/State_LoadLevel.c:41: void state_loadlevel_exit(){
                            129 ;	---------------------------------
                            130 ; Function state_loadlevel_exit
                            131 ; ---------------------------------
   1BE9                     132 _state_loadlevel_exit::
                            133 ;src/State_LoadLevel.c:43: }
   1BE9 C9            [10]  134 	ret
                            135 	.area _CODE
                            136 	.area _INITIALIZER
                            137 	.area _CABS (ABS)
