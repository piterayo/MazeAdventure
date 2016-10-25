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
                             11 	.globl _savegame_Save
                             12 	.globl _enemy_init_enemies
                             13 	.globl _level_load_level
                             14 	.globl _level_get_level
                             15 	.globl _generate_level
                             16 	.globl _generate_level_with_seed
                             17 	.globl _print_transparent_text
                             18 	.globl _draw_minimap_to_buffer
                             19 	.globl _render_draw_to_buffer
                             20 	.globl _statemanager_input_accepted
                             21 	.globl _statemanager_set_state
                             22 	.globl _cpct_memset
                             23 	.globl _level_seed
                             24 	.globl _state_loadlevel_enter
                             25 	.globl _state_loadlevel_return
                             26 	.globl _state_loadlevel_input
                             27 	.globl _state_loadlevel_update
                             28 	.globl _state_loadlevel_render
                             29 	.globl _state_loadlevel_exit
                             30 ;--------------------------------------------------------
                             31 ; special function registers
                             32 ;--------------------------------------------------------
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DATA
   7D8C                      37 _level_seed::
   7D8C                      38 	.ds 2
                             39 ;--------------------------------------------------------
                             40 ; ram data
                             41 ;--------------------------------------------------------
                             42 	.area _INITIALIZED
                             43 ;--------------------------------------------------------
                             44 ; absolute external ram data
                             45 ;--------------------------------------------------------
                             46 	.area _DABS (ABS)
                             47 ;--------------------------------------------------------
                             48 ; global & static initialisations
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _GSINIT
                             52 	.area _GSFINAL
                             53 	.area _GSINIT
                             54 ;--------------------------------------------------------
                             55 ; Home
                             56 ;--------------------------------------------------------
                             57 	.area _HOME
                             58 	.area _HOME
                             59 ;--------------------------------------------------------
                             60 ; code
                             61 ;--------------------------------------------------------
                             62 	.area _CODE
                             63 ;src/State_LoadLevel.c:16: void state_loadlevel_enter(){
                             64 ;	---------------------------------
                             65 ; Function state_loadlevel_enter
                             66 ; ---------------------------------
   350E                      67 _state_loadlevel_enter::
                             68 ;src/State_LoadLevel.c:18: if(level_get_level()<=(KING_LEVEL)){
   350E CD A7 0F      [17]   69 	call	_level_get_level
   3511 3E 20         [ 7]   70 	ld	a,#0x20
   3513 95            [ 4]   71 	sub	a, l
   3514 D8            [11]   72 	ret	C
                             73 ;src/State_LoadLevel.c:19: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   3515 21 67 1A      [10]   74 	ld	hl,#_g_colors+1
   3518 46            [ 7]   75 	ld	b,(hl)
   3519 21 00 40      [10]   76 	ld	hl,#0x4000
   351C E5            [11]   77 	push	hl
   351D C5            [11]   78 	push	bc
   351E 33            [ 6]   79 	inc	sp
   351F 26 C0         [ 7]   80 	ld	h, #0xC0
   3521 E5            [11]   81 	push	hl
   3522 CD 74 7B      [17]   82 	call	_cpct_memset
                             83 ;src/State_LoadLevel.c:21: print_transparent_text("LOADING", 0xe391, 3);
   3525 3E 03         [ 7]   84 	ld	a,#0x03
   3527 F5            [11]   85 	push	af
   3528 33            [ 6]   86 	inc	sp
   3529 21 91 E3      [10]   87 	ld	hl,#0xE391
   352C E5            [11]   88 	push	hl
   352D 21 66 35      [10]   89 	ld	hl,#___str_0
   3530 E5            [11]   90 	push	hl
   3531 CD A0 3F      [17]   91 	call	_print_transparent_text
   3534 F1            [10]   92 	pop	af
   3535 F1            [10]   93 	pop	af
   3536 33            [ 6]   94 	inc	sp
                             95 ;src/State_LoadLevel.c:23: if(level_seed) generate_level_with_seed(level_seed);
   3537 3A 8D 7D      [13]   96 	ld	a,(#_level_seed + 1)
   353A 21 8C 7D      [10]   97 	ld	hl,#_level_seed + 0
   353D B6            [ 7]   98 	or	a,(hl)
   353E 28 0A         [12]   99 	jr	Z,00102$
   3540 2A 8C 7D      [16]  100 	ld	hl,(_level_seed)
   3543 E5            [11]  101 	push	hl
   3544 CD CC 17      [17]  102 	call	_generate_level_with_seed
   3547 F1            [10]  103 	pop	af
   3548 18 03         [12]  104 	jr	00103$
   354A                     105 00102$:
                            106 ;src/State_LoadLevel.c:24: else generate_level();
   354A CD C3 17      [17]  107 	call	_generate_level
   354D                     108 00103$:
                            109 ;src/State_LoadLevel.c:25: level_load_level();
   354D CD 6B 10      [17]  110 	call	_level_load_level
                            111 ;src/State_LoadLevel.c:27: enemy_init_enemies();
   3550 CD 57 00      [17]  112 	call	_enemy_init_enemies
                            113 ;src/State_LoadLevel.c:28: item_init_items();
   3553 CD 19 0C      [17]  114 	call	_item_init_items
                            115 ;src/State_LoadLevel.c:30: savegame_Save();
   3556 CD 6C 2C      [17]  116 	call	_savegame_Save
                            117 ;src/State_LoadLevel.c:32: render_draw_to_buffer();
   3559 CD 69 1E      [17]  118 	call	_render_draw_to_buffer
                            119 ;src/State_LoadLevel.c:33: draw_minimap_to_buffer();
   355C CD 2F 2A      [17]  120 	call	_draw_minimap_to_buffer
                            121 ;src/State_LoadLevel.c:34: level_seed=0;
   355F 21 00 00      [10]  122 	ld	hl,#0x0000
   3562 22 8C 7D      [16]  123 	ld	(_level_seed),hl
   3565 C9            [10]  124 	ret
   3566                     125 ___str_0:
   3566 4C 4F 41 44 49 4E   126 	.ascii "LOADING"
        47
   356D 00                  127 	.db 0x00
                            128 ;src/State_LoadLevel.c:39: void state_loadlevel_return(){
                            129 ;	---------------------------------
                            130 ; Function state_loadlevel_return
                            131 ; ---------------------------------
   356E                     132 _state_loadlevel_return::
                            133 ;src/State_LoadLevel.c:41: }
   356E C9            [10]  134 	ret
                            135 ;src/State_LoadLevel.c:44: void state_loadlevel_input() {
                            136 ;	---------------------------------
                            137 ; Function state_loadlevel_input
                            138 ; ---------------------------------
   356F                     139 _state_loadlevel_input::
                            140 ;src/State_LoadLevel.c:45: statemanager_input_accepted();
   356F C3 90 38      [10]  141 	jp  _statemanager_input_accepted
                            142 ;src/State_LoadLevel.c:48: void state_loadlevel_update(){
                            143 ;	---------------------------------
                            144 ; Function state_loadlevel_update
                            145 ; ---------------------------------
   3572                     146 _state_loadlevel_update::
                            147 ;src/State_LoadLevel.c:49: if(level_get_level()<=(KING_LEVEL)){
   3572 CD A7 0F      [17]  148 	call	_level_get_level
   3575 3E 20         [ 7]  149 	ld	a,#0x20
   3577 95            [ 4]  150 	sub	a, l
   3578 38 09         [12]  151 	jr	C,00102$
                            152 ;src/State_LoadLevel.c:50: statemanager_set_state(STATE_INGAME);
   357A 3E 01         [ 7]  153 	ld	a,#0x01
   357C F5            [11]  154 	push	af
   357D 33            [ 6]  155 	inc	sp
   357E CD 96 38      [17]  156 	call	_statemanager_set_state
   3581 33            [ 6]  157 	inc	sp
   3582 C9            [10]  158 	ret
   3583                     159 00102$:
                            160 ;src/State_LoadLevel.c:53: statemanager_set_state(STATE_VICTORY);
   3583 3E 07         [ 7]  161 	ld	a,#0x07
   3585 F5            [11]  162 	push	af
   3586 33            [ 6]  163 	inc	sp
   3587 CD 96 38      [17]  164 	call	_statemanager_set_state
   358A 33            [ 6]  165 	inc	sp
   358B C9            [10]  166 	ret
                            167 ;src/State_LoadLevel.c:57: void state_loadlevel_render(){
                            168 ;	---------------------------------
                            169 ; Function state_loadlevel_render
                            170 ; ---------------------------------
   358C                     171 _state_loadlevel_render::
                            172 ;src/State_LoadLevel.c:59: }
   358C C9            [10]  173 	ret
                            174 ;src/State_LoadLevel.c:61: void state_loadlevel_exit(){
                            175 ;	---------------------------------
                            176 ; Function state_loadlevel_exit
                            177 ; ---------------------------------
   358D                     178 _state_loadlevel_exit::
                            179 ;src/State_LoadLevel.c:63: }
   358D C9            [10]  180 	ret
                            181 	.area _CODE
                            182 	.area _INITIALIZER
                            183 	.area _CABS (ABS)
