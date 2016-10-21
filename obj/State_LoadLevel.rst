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
                             11 	.globl _enemy_init_enemies
                             12 	.globl _level_load_level
                             13 	.globl _generate_level
                             14 	.globl _print_transparent_text
                             15 	.globl _draw_minimap_to_buffer
                             16 	.globl _render_draw_to_buffer
                             17 	.globl _statemanager_input_accepted
                             18 	.globl _statemanager_set_state
                             19 	.globl _cpct_memset
                             20 	.globl _state_loadlevel_enter
                             21 	.globl _state_loadlevel_return
                             22 	.globl _state_loadlevel_input
                             23 	.globl _state_loadlevel_update
                             24 	.globl _state_loadlevel_render
                             25 	.globl _state_loadlevel_exit
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
                             57 ;src/State_LoadLevel.c:11: void state_loadlevel_enter(){
                             58 ;	---------------------------------
                             59 ; Function state_loadlevel_enter
                             60 ; ---------------------------------
   2196                      61 _state_loadlevel_enter::
                             62 ;src/State_LoadLevel.c:13: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   2196 21 67 10      [10]   63 	ld	hl,#_g_colors+1
   2199 46            [ 7]   64 	ld	b,(hl)
   219A 21 00 40      [10]   65 	ld	hl,#0x4000
   219D E5            [11]   66 	push	hl
   219E C5            [11]   67 	push	bc
   219F 33            [ 6]   68 	inc	sp
   21A0 26 C0         [ 7]   69 	ld	h, #0xC0
   21A2 E5            [11]   70 	push	hl
   21A3 CD 44 59      [17]   71 	call	_cpct_memset
                             72 ;src/State_LoadLevel.c:15: print_transparent_text("LOADING", 0xe391, 3);
   21A6 3E 03         [ 7]   73 	ld	a,#0x03
   21A8 F5            [11]   74 	push	af
   21A9 33            [ 6]   75 	inc	sp
   21AA 21 91 E3      [10]   76 	ld	hl,#0xE391
   21AD E5            [11]   77 	push	hl
   21AE 21 C8 21      [10]   78 	ld	hl,#___str_0
   21B1 E5            [11]   79 	push	hl
   21B2 CD 59 28      [17]   80 	call	_print_transparent_text
   21B5 F1            [10]   81 	pop	af
   21B6 F1            [10]   82 	pop	af
   21B7 33            [ 6]   83 	inc	sp
                             84 ;src/State_LoadLevel.c:17: generate_level();
   21B8 CD 06 0E      [17]   85 	call	_generate_level
                             86 ;src/State_LoadLevel.c:18: level_load_level();
   21BB CD 52 07      [17]   87 	call	_level_load_level
                             88 ;src/State_LoadLevel.c:20: enemy_init_enemies();
   21BE CD 4E 00      [17]   89 	call	_enemy_init_enemies
                             90 ;src/State_LoadLevel.c:22: render_draw_to_buffer();
   21C1 CD 72 13      [17]   91 	call	_render_draw_to_buffer
                             92 ;src/State_LoadLevel.c:23: draw_minimap_to_buffer();
   21C4 CD CC 1E      [17]   93 	call	_draw_minimap_to_buffer
   21C7 C9            [10]   94 	ret
   21C8                      95 ___str_0:
   21C8 4C 4F 41 44 49 4E    96 	.ascii "LOADING"
        47
   21CF 00                   97 	.db 0x00
                             98 ;src/State_LoadLevel.c:27: void state_loadlevel_return(){
                             99 ;	---------------------------------
                            100 ; Function state_loadlevel_return
                            101 ; ---------------------------------
   21D0                     102 _state_loadlevel_return::
                            103 ;src/State_LoadLevel.c:29: }
   21D0 C9            [10]  104 	ret
                            105 ;src/State_LoadLevel.c:32: void state_loadlevel_input() {
                            106 ;	---------------------------------
                            107 ; Function state_loadlevel_input
                            108 ; ---------------------------------
   21D1                     109 _state_loadlevel_input::
                            110 ;src/State_LoadLevel.c:33: statemanager_input_accepted();
   21D1 C3 6B 23      [10]  111 	jp  _statemanager_input_accepted
                            112 ;src/State_LoadLevel.c:36: void state_loadlevel_update(){
                            113 ;	---------------------------------
                            114 ; Function state_loadlevel_update
                            115 ; ---------------------------------
   21D4                     116 _state_loadlevel_update::
                            117 ;src/State_LoadLevel.c:37: statemanager_set_state(STATE_INGAME);
   21D4 2E 01         [ 7]  118 	ld	l,#0x01
   21D6 C3 71 23      [10]  119 	jp  _statemanager_set_state
                            120 ;src/State_LoadLevel.c:40: void state_loadlevel_render(){
                            121 ;	---------------------------------
                            122 ; Function state_loadlevel_render
                            123 ; ---------------------------------
   21D9                     124 _state_loadlevel_render::
                            125 ;src/State_LoadLevel.c:42: }
   21D9 C9            [10]  126 	ret
                            127 ;src/State_LoadLevel.c:44: void state_loadlevel_exit(){
                            128 ;	---------------------------------
                            129 ; Function state_loadlevel_exit
                            130 ; ---------------------------------
   21DA                     131 _state_loadlevel_exit::
                            132 ;src/State_LoadLevel.c:46: }
   21DA C9            [10]  133 	ret
                            134 	.area _CODE
                            135 	.area _INITIALIZER
                            136 	.area _CABS (ABS)
