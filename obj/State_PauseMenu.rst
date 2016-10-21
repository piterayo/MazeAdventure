                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_PauseMenu
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_pausemenu_render_all
                             12 	.globl _ui_pausemenu_render_refresh
                             13 	.globl _ui_pausemenu_unselect_entry
                             14 	.globl _ui_pausemenu_select_entry
                             15 	.globl _ui_pausemenu_previous_entry
                             16 	.globl _ui_pausemenu_next_entry
                             17 	.globl _ui_pausemenu_is_selected
                             18 	.globl _ui_pausemenu_get_entry
                             19 	.globl _ui_pausemenu_init
                             20 	.globl _statemanager_input_accepted
                             21 	.globl _statemanager_set_state
                             22 	.globl _statemanager_close_state
                             23 	.globl _cpct_drawSolidBox
                             24 	.globl _cpct_isKeyPressed
                             25 	.globl _state_pausemenu_enter
                             26 	.globl _state_pausemenu_return
                             27 	.globl _state_pausemenu_input
                             28 	.globl _state_pausemenu_update
                             29 	.globl _state_pausemenu_render
                             30 	.globl _state_pausemenu_exit
                             31 ;--------------------------------------------------------
                             32 ; special function registers
                             33 ;--------------------------------------------------------
                             34 ;--------------------------------------------------------
                             35 ; ram data
                             36 ;--------------------------------------------------------
                             37 	.area _DATA
                             38 ;--------------------------------------------------------
                             39 ; ram data
                             40 ;--------------------------------------------------------
                             41 	.area _INITIALIZED
                             42 ;--------------------------------------------------------
                             43 ; absolute external ram data
                             44 ;--------------------------------------------------------
                             45 	.area _DABS (ABS)
                             46 ;--------------------------------------------------------
                             47 ; global & static initialisations
                             48 ;--------------------------------------------------------
                             49 	.area _HOME
                             50 	.area _GSINIT
                             51 	.area _GSFINAL
                             52 	.area _GSINIT
                             53 ;--------------------------------------------------------
                             54 ; Home
                             55 ;--------------------------------------------------------
                             56 	.area _HOME
                             57 	.area _HOME
                             58 ;--------------------------------------------------------
                             59 ; code
                             60 ;--------------------------------------------------------
                             61 	.area _CODE
                             62 ;src/State_PauseMenu.c:14: void state_pausemenu_enter(){
                             63 ;	---------------------------------
                             64 ; Function state_pausemenu_enter
                             65 ; ---------------------------------
   2465                      66 _state_pausemenu_enter::
                             67 ;src/State_PauseMenu.c:15: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
   2465 21 6A 10      [10]   68 	ld	hl, #_g_colors + 4
   2468 46            [ 7]   69 	ld	b,(hl)
   2469 21 22 90      [10]   70 	ld	hl,#0x9022
   246C E5            [11]   71 	push	hl
   246D C5            [11]   72 	push	bc
   246E 33            [ 6]   73 	inc	sp
   246F 21 07 E1      [10]   74 	ld	hl,#0xE107
   2472 E5            [11]   75 	push	hl
   2473 CD 62 59      [17]   76 	call	_cpct_drawSolidBox
   2476 F1            [10]   77 	pop	af
   2477 F1            [10]   78 	pop	af
   2478 33            [ 6]   79 	inc	sp
                             80 ;src/State_PauseMenu.c:16: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
   2479 21 67 10      [10]   81 	ld	hl, #_g_colors + 1
   247C 46            [ 7]   82 	ld	b,(hl)
   247D 21 20 88      [10]   83 	ld	hl,#0x8820
   2480 E5            [11]   84 	push	hl
   2481 C5            [11]   85 	push	bc
   2482 33            [ 6]   86 	inc	sp
   2483 21 58 C1      [10]   87 	ld	hl,#0xC158
   2486 E5            [11]   88 	push	hl
   2487 CD 62 59      [17]   89 	call	_cpct_drawSolidBox
   248A F1            [10]   90 	pop	af
   248B F1            [10]   91 	pop	af
   248C 33            [ 6]   92 	inc	sp
                             93 ;src/State_PauseMenu.c:17: ui_pausemenu_init();
   248D CD D1 2E      [17]   94 	call	_ui_pausemenu_init
                             95 ;src/State_PauseMenu.c:18: ui_pausemenu_render_all();
   2490 C3 DA 2F      [10]   96 	jp  _ui_pausemenu_render_all
                             97 ;src/State_PauseMenu.c:21: void state_pausemenu_return() {
                             98 ;	---------------------------------
                             99 ; Function state_pausemenu_return
                            100 ; ---------------------------------
   2493                     101 _state_pausemenu_return::
                            102 ;src/State_PauseMenu.c:22: ui_pausemenu_render_all();
   2493 C3 DA 2F      [10]  103 	jp  _ui_pausemenu_render_all
                            104 ;src/State_PauseMenu.c:25: void state_pausemenu_input(){
                            105 ;	---------------------------------
                            106 ; Function state_pausemenu_input
                            107 ; ---------------------------------
   2496                     108 _state_pausemenu_input::
                            109 ;src/State_PauseMenu.c:27: if(cpct_isKeyPressed(Key_CursorUp)){
   2496 21 00 01      [10]  110 	ld	hl,#0x0100
   2499 CD 4F 57      [17]  111 	call	_cpct_isKeyPressed
   249C 7D            [ 4]  112 	ld	a,l
   249D B7            [ 4]  113 	or	a, a
   249E 28 06         [12]  114 	jr	Z,00107$
                            115 ;src/State_PauseMenu.c:28: ui_pausemenu_previous_entry();
   24A0 CD 3B 2F      [17]  116 	call	_ui_pausemenu_previous_entry
                            117 ;src/State_PauseMenu.c:29: statemanager_input_accepted();
   24A3 C3 6B 23      [10]  118 	jp  _statemanager_input_accepted
   24A6                     119 00107$:
                            120 ;src/State_PauseMenu.c:31: else if(cpct_isKeyPressed(Key_CursorDown)){
   24A6 21 00 04      [10]  121 	ld	hl,#0x0400
   24A9 CD 4F 57      [17]  122 	call	_cpct_isKeyPressed
   24AC 7D            [ 4]  123 	ld	a,l
   24AD B7            [ 4]  124 	or	a, a
   24AE 28 06         [12]  125 	jr	Z,00104$
                            126 ;src/State_PauseMenu.c:32: ui_pausemenu_next_entry();
   24B0 CD 2D 2F      [17]  127 	call	_ui_pausemenu_next_entry
                            128 ;src/State_PauseMenu.c:33: statemanager_input_accepted();
   24B3 C3 6B 23      [10]  129 	jp  _statemanager_input_accepted
   24B6                     130 00104$:
                            131 ;src/State_PauseMenu.c:35: else if(cpct_isKeyPressed(Key_Return)){
   24B6 21 02 04      [10]  132 	ld	hl,#0x0402
   24B9 CD 4F 57      [17]  133 	call	_cpct_isKeyPressed
   24BC 7D            [ 4]  134 	ld	a,l
   24BD B7            [ 4]  135 	or	a, a
   24BE C8            [11]  136 	ret	Z
                            137 ;src/State_PauseMenu.c:36: ui_pausemenu_select_entry();
   24BF CD 4B 2F      [17]  138 	call	_ui_pausemenu_select_entry
                            139 ;src/State_PauseMenu.c:37: statemanager_input_accepted();
   24C2 C3 6B 23      [10]  140 	jp  _statemanager_input_accepted
                            141 ;src/State_PauseMenu.c:42: void state_pausemenu_update(){
                            142 ;	---------------------------------
                            143 ; Function state_pausemenu_update
                            144 ; ---------------------------------
   24C5                     145 _state_pausemenu_update::
                            146 ;src/State_PauseMenu.c:43: if(ui_pausemenu_is_selected()){
   24C5 CD 25 2F      [17]  147 	call	_ui_pausemenu_is_selected
   24C8 7D            [ 4]  148 	ld	a,l
   24C9 B7            [ 4]  149 	or	a, a
   24CA CA 51 2F      [10]  150 	jp	Z,_ui_pausemenu_unselect_entry
                            151 ;src/State_PauseMenu.c:44: ui_pausemenu_render_refresh();
   24CD CD C1 2F      [17]  152 	call	_ui_pausemenu_render_refresh
                            153 ;src/State_PauseMenu.c:45: switch(ui_pausemenu_get_entry()){
   24D0 CD 1D 2F      [17]  154 	call	_ui_pausemenu_get_entry
   24D3 5D            [ 4]  155 	ld	e,l
   24D4 3E 03         [ 7]  156 	ld	a,#0x03
   24D6 93            [ 4]  157 	sub	a, e
   24D7 DA 51 2F      [10]  158 	jp	C,_ui_pausemenu_unselect_entry
   24DA 16 00         [ 7]  159 	ld	d,#0x00
   24DC 21 E3 24      [10]  160 	ld	hl,#00118$
   24DF 19            [11]  161 	add	hl,de
   24E0 19            [11]  162 	add	hl,de
   24E1 19            [11]  163 	add	hl,de
   24E2 E9            [ 4]  164 	jp	(hl)
   24E3                     165 00118$:
   24E3 C3 EF 24      [10]  166 	jp	00101$
   24E6 C3 51 2F      [10]  167 	jp	_ui_pausemenu_unselect_entry
   24E9 C3 51 2F      [10]  168 	jp	_ui_pausemenu_unselect_entry
   24EC C3 FB 24      [10]  169 	jp	00104$
                            170 ;src/State_PauseMenu.c:46: case 0:{
   24EF                     171 00101$:
                            172 ;src/State_PauseMenu.c:47: statemanager_close_state();
   24EF CD 21 24      [17]  173 	call	_statemanager_close_state
                            174 ;src/State_PauseMenu.c:48: break;
   24F2 C3 51 2F      [10]  175 	jp	_ui_pausemenu_unselect_entry
                            176 ;src/State_PauseMenu.c:50: case 1:{
                            177 ;src/State_PauseMenu.c:52: break;
   24F5 C3 51 2F      [10]  178 	jp	_ui_pausemenu_unselect_entry
                            179 ;src/State_PauseMenu.c:54: case 2:{
                            180 ;src/State_PauseMenu.c:56: break;
   24F8 C3 51 2F      [10]  181 	jp	_ui_pausemenu_unselect_entry
                            182 ;src/State_PauseMenu.c:58: case 3:{
   24FB                     183 00104$:
                            184 ;src/State_PauseMenu.c:59: statemanager_set_state(STATE_MAINMENU);
   24FB 2E 00         [ 7]  185 	ld	l,#0x00
   24FD CD 71 23      [17]  186 	call	_statemanager_set_state
                            187 ;src/State_PauseMenu.c:62: }
                            188 ;src/State_PauseMenu.c:64: ui_pausemenu_unselect_entry();
   2500 C3 51 2F      [10]  189 	jp  _ui_pausemenu_unselect_entry
                            190 ;src/State_PauseMenu.c:67: void state_pausemenu_render() {
                            191 ;	---------------------------------
                            192 ; Function state_pausemenu_render
                            193 ; ---------------------------------
   2503                     194 _state_pausemenu_render::
                            195 ;src/State_PauseMenu.c:68: ui_pausemenu_render_refresh();
   2503 C3 C1 2F      [10]  196 	jp  _ui_pausemenu_render_refresh
                            197 ;src/State_PauseMenu.c:71: void state_pausemenu_exit(){
                            198 ;	---------------------------------
                            199 ; Function state_pausemenu_exit
                            200 ; ---------------------------------
   2506                     201 _state_pausemenu_exit::
                            202 ;src/State_PauseMenu.c:72: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[1], 34, 144);
   2506 21 67 10      [10]  203 	ld	hl, #(_g_colors + 0x0001) + 0
   2509 46            [ 7]  204 	ld	b,(hl)
   250A 21 22 90      [10]  205 	ld	hl,#0x9022
   250D E5            [11]  206 	push	hl
   250E C5            [11]  207 	push	bc
   250F 33            [ 6]  208 	inc	sp
   2510 21 07 E1      [10]  209 	ld	hl,#0xE107
   2513 E5            [11]  210 	push	hl
   2514 CD 62 59      [17]  211 	call	_cpct_drawSolidBox
   2517 F1            [10]  212 	pop	af
   2518 F1            [10]  213 	pop	af
   2519 33            [ 6]  214 	inc	sp
   251A C9            [10]  215 	ret
                            216 	.area _CODE
                            217 	.area _INITIALIZER
                            218 	.area _CABS (ABS)
