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
   1E71                      66 _state_pausemenu_enter::
                             67 ;src/State_PauseMenu.c:15: cpct_drawSolidBox (SCREEN_PTR_AT(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
   1E71 21 A7 0A      [10]   68 	ld	hl, #_g_colors + 4
   1E74 46            [ 7]   69 	ld	b,(hl)
   1E75 21 22 90      [10]   70 	ld	hl,#0x9022
   1E78 E5            [11]   71 	push	hl
   1E79 C5            [11]   72 	push	bc
   1E7A 33            [ 6]   73 	inc	sp
   1E7B 21 07 E1      [10]   74 	ld	hl,#0xE107
   1E7E E5            [11]   75 	push	hl
   1E7F CD CB 48      [17]   76 	call	_cpct_drawSolidBox
   1E82 F1            [10]   77 	pop	af
   1E83 F1            [10]   78 	pop	af
   1E84 33            [ 6]   79 	inc	sp
                             80 ;src/State_PauseMenu.c:16: cpct_drawSolidBox (SCREEN_PTR_AT(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
   1E85 21 A4 0A      [10]   81 	ld	hl, #_g_colors + 1
   1E88 46            [ 7]   82 	ld	b,(hl)
   1E89 21 20 88      [10]   83 	ld	hl,#0x8820
   1E8C E5            [11]   84 	push	hl
   1E8D C5            [11]   85 	push	bc
   1E8E 33            [ 6]   86 	inc	sp
   1E8F 21 58 C1      [10]   87 	ld	hl,#0xC158
   1E92 E5            [11]   88 	push	hl
   1E93 CD CB 48      [17]   89 	call	_cpct_drawSolidBox
   1E96 F1            [10]   90 	pop	af
   1E97 F1            [10]   91 	pop	af
   1E98 33            [ 6]   92 	inc	sp
                             93 ;src/State_PauseMenu.c:17: ui_pausemenu_init();
   1E99 CD 68 29      [17]   94 	call	_ui_pausemenu_init
                             95 ;src/State_PauseMenu.c:18: ui_pausemenu_render_all();
   1E9C C3 6E 2A      [10]   96 	jp  _ui_pausemenu_render_all
                             97 ;src/State_PauseMenu.c:21: void state_pausemenu_return(){
                             98 ;	---------------------------------
                             99 ; Function state_pausemenu_return
                            100 ; ---------------------------------
   1E9F                     101 _state_pausemenu_return::
                            102 ;src/State_PauseMenu.c:22: ui_pausemenu_render_all();
   1E9F C3 6E 2A      [10]  103 	jp  _ui_pausemenu_render_all
                            104 ;src/State_PauseMenu.c:25: void state_pausemenu_input(){
                            105 ;	---------------------------------
                            106 ; Function state_pausemenu_input
                            107 ; ---------------------------------
   1EA2                     108 _state_pausemenu_input::
                            109 ;src/State_PauseMenu.c:27: if(cpct_isKeyPressed(Key_CursorUp)){
   1EA2 21 00 01      [10]  110 	ld	hl,#0x0100
   1EA5 CD F8 46      [17]  111 	call	_cpct_isKeyPressed
   1EA8 7D            [ 4]  112 	ld	a,l
   1EA9 B7            [ 4]  113 	or	a, a
   1EAA 28 06         [12]  114 	jr	Z,00107$
                            115 ;src/State_PauseMenu.c:28: ui_pausemenu_previous_entry();
   1EAC CD D2 29      [17]  116 	call	_ui_pausemenu_previous_entry
                            117 ;src/State_PauseMenu.c:29: statemanager_input_accepted();
   1EAF C3 7F 1D      [10]  118 	jp  _statemanager_input_accepted
   1EB2                     119 00107$:
                            120 ;src/State_PauseMenu.c:31: else if(cpct_isKeyPressed(Key_CursorDown)){
   1EB2 21 00 04      [10]  121 	ld	hl,#0x0400
   1EB5 CD F8 46      [17]  122 	call	_cpct_isKeyPressed
   1EB8 7D            [ 4]  123 	ld	a,l
   1EB9 B7            [ 4]  124 	or	a, a
   1EBA 28 06         [12]  125 	jr	Z,00104$
                            126 ;src/State_PauseMenu.c:32: ui_pausemenu_next_entry();
   1EBC CD C4 29      [17]  127 	call	_ui_pausemenu_next_entry
                            128 ;src/State_PauseMenu.c:33: statemanager_input_accepted();
   1EBF C3 7F 1D      [10]  129 	jp  _statemanager_input_accepted
   1EC2                     130 00104$:
                            131 ;src/State_PauseMenu.c:35: else if(cpct_isKeyPressed(Key_Return)){
   1EC2 21 02 04      [10]  132 	ld	hl,#0x0402
   1EC5 CD F8 46      [17]  133 	call	_cpct_isKeyPressed
   1EC8 7D            [ 4]  134 	ld	a,l
   1EC9 B7            [ 4]  135 	or	a, a
   1ECA C8            [11]  136 	ret	Z
                            137 ;src/State_PauseMenu.c:36: ui_pausemenu_select_entry();
   1ECB CD E2 29      [17]  138 	call	_ui_pausemenu_select_entry
                            139 ;src/State_PauseMenu.c:37: statemanager_input_accepted();
   1ECE C3 7F 1D      [10]  140 	jp  _statemanager_input_accepted
                            141 ;src/State_PauseMenu.c:42: void state_pausemenu_update(){
                            142 ;	---------------------------------
                            143 ; Function state_pausemenu_update
                            144 ; ---------------------------------
   1ED1                     145 _state_pausemenu_update::
                            146 ;src/State_PauseMenu.c:43: if(ui_pausemenu_is_selected()){
   1ED1 CD BC 29      [17]  147 	call	_ui_pausemenu_is_selected
   1ED4 7D            [ 4]  148 	ld	a,l
   1ED5 B7            [ 4]  149 	or	a, a
   1ED6 CA E8 29      [10]  150 	jp	Z,_ui_pausemenu_unselect_entry
                            151 ;src/State_PauseMenu.c:44: ui_pausemenu_render_refresh();
   1ED9 CD 55 2A      [17]  152 	call	_ui_pausemenu_render_refresh
                            153 ;src/State_PauseMenu.c:45: switch(ui_pausemenu_get_entry()){
   1EDC CD B4 29      [17]  154 	call	_ui_pausemenu_get_entry
   1EDF 5D            [ 4]  155 	ld	e,l
   1EE0 3E 03         [ 7]  156 	ld	a,#0x03
   1EE2 93            [ 4]  157 	sub	a, e
   1EE3 DA E8 29      [10]  158 	jp	C,_ui_pausemenu_unselect_entry
   1EE6 16 00         [ 7]  159 	ld	d,#0x00
   1EE8 21 EF 1E      [10]  160 	ld	hl,#00118$
   1EEB 19            [11]  161 	add	hl,de
   1EEC 19            [11]  162 	add	hl,de
   1EED 19            [11]  163 	add	hl,de
   1EEE E9            [ 4]  164 	jp	(hl)
   1EEF                     165 00118$:
   1EEF C3 FB 1E      [10]  166 	jp	00101$
   1EF2 C3 E8 29      [10]  167 	jp	_ui_pausemenu_unselect_entry
   1EF5 C3 E8 29      [10]  168 	jp	_ui_pausemenu_unselect_entry
   1EF8 C3 07 1F      [10]  169 	jp	00104$
                            170 ;src/State_PauseMenu.c:46: case 0:{
   1EFB                     171 00101$:
                            172 ;src/State_PauseMenu.c:47: statemanager_close_state();
   1EFB CD 33 1E      [17]  173 	call	_statemanager_close_state
                            174 ;src/State_PauseMenu.c:48: break;
   1EFE C3 E8 29      [10]  175 	jp	_ui_pausemenu_unselect_entry
                            176 ;src/State_PauseMenu.c:50: case 1:{
                            177 ;src/State_PauseMenu.c:52: break;
   1F01 C3 E8 29      [10]  178 	jp	_ui_pausemenu_unselect_entry
                            179 ;src/State_PauseMenu.c:54: case 2:{
                            180 ;src/State_PauseMenu.c:56: break;
   1F04 C3 E8 29      [10]  181 	jp	_ui_pausemenu_unselect_entry
                            182 ;src/State_PauseMenu.c:58: case 3:{
   1F07                     183 00104$:
                            184 ;src/State_PauseMenu.c:59: statemanager_set_state(STATE_MAINMENU);
   1F07 AF            [ 4]  185 	xor	a, a
   1F08 F5            [11]  186 	push	af
   1F09 33            [ 6]  187 	inc	sp
   1F0A CD 85 1D      [17]  188 	call	_statemanager_set_state
   1F0D 33            [ 6]  189 	inc	sp
                            190 ;src/State_PauseMenu.c:62: }
                            191 ;src/State_PauseMenu.c:64: ui_pausemenu_unselect_entry();
   1F0E C3 E8 29      [10]  192 	jp  _ui_pausemenu_unselect_entry
                            193 ;src/State_PauseMenu.c:67: void state_pausemenu_render(){
                            194 ;	---------------------------------
                            195 ; Function state_pausemenu_render
                            196 ; ---------------------------------
   1F11                     197 _state_pausemenu_render::
                            198 ;src/State_PauseMenu.c:68: ui_pausemenu_render_refresh();
   1F11 C3 55 2A      [10]  199 	jp  _ui_pausemenu_render_refresh
                            200 ;src/State_PauseMenu.c:71: void state_pausemenu_exit(){
                            201 ;	---------------------------------
                            202 ; Function state_pausemenu_exit
                            203 ; ---------------------------------
   1F14                     204 _state_pausemenu_exit::
                            205 ;src/State_PauseMenu.c:72: cpct_drawSolidBox (SCREEN_PTR_AT(CPCT_VMEM_START, 23, 28), g_colors[1], 34, 144);
   1F14 21 A4 0A      [10]  206 	ld	hl, #(_g_colors + 0x0001) + 0
   1F17 46            [ 7]  207 	ld	b,(hl)
   1F18 21 22 90      [10]  208 	ld	hl,#0x9022
   1F1B E5            [11]  209 	push	hl
   1F1C C5            [11]  210 	push	bc
   1F1D 33            [ 6]  211 	inc	sp
   1F1E 21 07 E1      [10]  212 	ld	hl,#0xE107
   1F21 E5            [11]  213 	push	hl
   1F22 CD CB 48      [17]  214 	call	_cpct_drawSolidBox
   1F25 F1            [10]  215 	pop	af
   1F26 F1            [10]  216 	pop	af
   1F27 33            [ 6]  217 	inc	sp
   1F28 C9            [10]  218 	ret
                            219 	.area _CODE
                            220 	.area _INITIALIZER
                            221 	.area _CABS (ABS)
