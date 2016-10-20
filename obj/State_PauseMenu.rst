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
   1E7C                      66 _state_pausemenu_enter::
                             67 ;src/State_PauseMenu.c:15: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
   1E7C 21 A7 0A      [10]   68 	ld	hl, #_g_colors + 4
   1E7F 46            [ 7]   69 	ld	b,(hl)
   1E80 21 22 90      [10]   70 	ld	hl,#0x9022
   1E83 E5            [11]   71 	push	hl
   1E84 C5            [11]   72 	push	bc
   1E85 33            [ 6]   73 	inc	sp
   1E86 21 07 E1      [10]   74 	ld	hl,#0xE107
   1E89 E5            [11]   75 	push	hl
   1E8A CD C0 4D      [17]   76 	call	_cpct_drawSolidBox
   1E8D F1            [10]   77 	pop	af
   1E8E F1            [10]   78 	pop	af
   1E8F 33            [ 6]   79 	inc	sp
                             80 ;src/State_PauseMenu.c:16: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
   1E90 21 A4 0A      [10]   81 	ld	hl, #_g_colors + 1
   1E93 46            [ 7]   82 	ld	b,(hl)
   1E94 21 20 88      [10]   83 	ld	hl,#0x8820
   1E97 E5            [11]   84 	push	hl
   1E98 C5            [11]   85 	push	bc
   1E99 33            [ 6]   86 	inc	sp
   1E9A 21 58 C1      [10]   87 	ld	hl,#0xC158
   1E9D E5            [11]   88 	push	hl
   1E9E CD C0 4D      [17]   89 	call	_cpct_drawSolidBox
   1EA1 F1            [10]   90 	pop	af
   1EA2 F1            [10]   91 	pop	af
   1EA3 33            [ 6]   92 	inc	sp
                             93 ;src/State_PauseMenu.c:17: ui_pausemenu_init();
   1EA4 CD 24 28      [17]   94 	call	_ui_pausemenu_init
                             95 ;src/State_PauseMenu.c:18: ui_pausemenu_render_all();
   1EA7 C3 2D 29      [10]   96 	jp  _ui_pausemenu_render_all
                             97 ;src/State_PauseMenu.c:21: void state_pausemenu_return() {
                             98 ;	---------------------------------
                             99 ; Function state_pausemenu_return
                            100 ; ---------------------------------
   1EAA                     101 _state_pausemenu_return::
                            102 ;src/State_PauseMenu.c:22: ui_pausemenu_render_all();
   1EAA C3 2D 29      [10]  103 	jp  _ui_pausemenu_render_all
                            104 ;src/State_PauseMenu.c:25: void state_pausemenu_input(){
                            105 ;	---------------------------------
                            106 ; Function state_pausemenu_input
                            107 ; ---------------------------------
   1EAD                     108 _state_pausemenu_input::
                            109 ;src/State_PauseMenu.c:27: if(cpct_isKeyPressed(Key_CursorUp)){
   1EAD 21 00 01      [10]  110 	ld	hl,#0x0100
   1EB0 CD AD 4B      [17]  111 	call	_cpct_isKeyPressed
   1EB3 7D            [ 4]  112 	ld	a,l
   1EB4 B7            [ 4]  113 	or	a, a
   1EB5 28 06         [12]  114 	jr	Z,00107$
                            115 ;src/State_PauseMenu.c:28: ui_pausemenu_previous_entry();
   1EB7 CD 8E 28      [17]  116 	call	_ui_pausemenu_previous_entry
                            117 ;src/State_PauseMenu.c:29: statemanager_input_accepted();
   1EBA C3 82 1D      [10]  118 	jp  _statemanager_input_accepted
   1EBD                     119 00107$:
                            120 ;src/State_PauseMenu.c:31: else if(cpct_isKeyPressed(Key_CursorDown)){
   1EBD 21 00 04      [10]  121 	ld	hl,#0x0400
   1EC0 CD AD 4B      [17]  122 	call	_cpct_isKeyPressed
   1EC3 7D            [ 4]  123 	ld	a,l
   1EC4 B7            [ 4]  124 	or	a, a
   1EC5 28 06         [12]  125 	jr	Z,00104$
                            126 ;src/State_PauseMenu.c:32: ui_pausemenu_next_entry();
   1EC7 CD 80 28      [17]  127 	call	_ui_pausemenu_next_entry
                            128 ;src/State_PauseMenu.c:33: statemanager_input_accepted();
   1ECA C3 82 1D      [10]  129 	jp  _statemanager_input_accepted
   1ECD                     130 00104$:
                            131 ;src/State_PauseMenu.c:35: else if(cpct_isKeyPressed(Key_Return)){
   1ECD 21 02 04      [10]  132 	ld	hl,#0x0402
   1ED0 CD AD 4B      [17]  133 	call	_cpct_isKeyPressed
   1ED3 7D            [ 4]  134 	ld	a,l
   1ED4 B7            [ 4]  135 	or	a, a
   1ED5 C8            [11]  136 	ret	Z
                            137 ;src/State_PauseMenu.c:36: ui_pausemenu_select_entry();
   1ED6 CD 9E 28      [17]  138 	call	_ui_pausemenu_select_entry
                            139 ;src/State_PauseMenu.c:37: statemanager_input_accepted();
   1ED9 C3 82 1D      [10]  140 	jp  _statemanager_input_accepted
                            141 ;src/State_PauseMenu.c:42: void state_pausemenu_update(){
                            142 ;	---------------------------------
                            143 ; Function state_pausemenu_update
                            144 ; ---------------------------------
   1EDC                     145 _state_pausemenu_update::
                            146 ;src/State_PauseMenu.c:43: if(ui_pausemenu_is_selected()){
   1EDC CD 78 28      [17]  147 	call	_ui_pausemenu_is_selected
   1EDF 7D            [ 4]  148 	ld	a,l
   1EE0 B7            [ 4]  149 	or	a, a
   1EE1 CA A4 28      [10]  150 	jp	Z,_ui_pausemenu_unselect_entry
                            151 ;src/State_PauseMenu.c:44: ui_pausemenu_render_refresh();
   1EE4 CD 14 29      [17]  152 	call	_ui_pausemenu_render_refresh
                            153 ;src/State_PauseMenu.c:45: switch(ui_pausemenu_get_entry()){
   1EE7 CD 70 28      [17]  154 	call	_ui_pausemenu_get_entry
   1EEA 5D            [ 4]  155 	ld	e,l
   1EEB 3E 03         [ 7]  156 	ld	a,#0x03
   1EED 93            [ 4]  157 	sub	a, e
   1EEE DA A4 28      [10]  158 	jp	C,_ui_pausemenu_unselect_entry
   1EF1 16 00         [ 7]  159 	ld	d,#0x00
   1EF3 21 FA 1E      [10]  160 	ld	hl,#00118$
   1EF6 19            [11]  161 	add	hl,de
   1EF7 19            [11]  162 	add	hl,de
   1EF8 19            [11]  163 	add	hl,de
   1EF9 E9            [ 4]  164 	jp	(hl)
   1EFA                     165 00118$:
   1EFA C3 06 1F      [10]  166 	jp	00101$
   1EFD C3 A4 28      [10]  167 	jp	_ui_pausemenu_unselect_entry
   1F00 C3 A4 28      [10]  168 	jp	_ui_pausemenu_unselect_entry
   1F03 C3 12 1F      [10]  169 	jp	00104$
                            170 ;src/State_PauseMenu.c:46: case 0:{
   1F06                     171 00101$:
                            172 ;src/State_PauseMenu.c:47: statemanager_close_state();
   1F06 CD 38 1E      [17]  173 	call	_statemanager_close_state
                            174 ;src/State_PauseMenu.c:48: break;
   1F09 C3 A4 28      [10]  175 	jp	_ui_pausemenu_unselect_entry
                            176 ;src/State_PauseMenu.c:50: case 1:{
                            177 ;src/State_PauseMenu.c:52: break;
   1F0C C3 A4 28      [10]  178 	jp	_ui_pausemenu_unselect_entry
                            179 ;src/State_PauseMenu.c:54: case 2:{
                            180 ;src/State_PauseMenu.c:56: break;
   1F0F C3 A4 28      [10]  181 	jp	_ui_pausemenu_unselect_entry
                            182 ;src/State_PauseMenu.c:58: case 3:{
   1F12                     183 00104$:
                            184 ;src/State_PauseMenu.c:59: statemanager_set_state(STATE_MAINMENU);
   1F12 2E 00         [ 7]  185 	ld	l,#0x00
   1F14 CD 88 1D      [17]  186 	call	_statemanager_set_state
                            187 ;src/State_PauseMenu.c:62: }
                            188 ;src/State_PauseMenu.c:64: ui_pausemenu_unselect_entry();
   1F17 C3 A4 28      [10]  189 	jp  _ui_pausemenu_unselect_entry
                            190 ;src/State_PauseMenu.c:67: void state_pausemenu_render() {
                            191 ;	---------------------------------
                            192 ; Function state_pausemenu_render
                            193 ; ---------------------------------
   1F1A                     194 _state_pausemenu_render::
                            195 ;src/State_PauseMenu.c:68: ui_pausemenu_render_refresh();
   1F1A C3 14 29      [10]  196 	jp  _ui_pausemenu_render_refresh
                            197 ;src/State_PauseMenu.c:71: void state_pausemenu_exit(){
                            198 ;	---------------------------------
                            199 ; Function state_pausemenu_exit
                            200 ; ---------------------------------
   1F1D                     201 _state_pausemenu_exit::
                            202 ;src/State_PauseMenu.c:72: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[1], 34, 144);
   1F1D 21 A4 0A      [10]  203 	ld	hl, #(_g_colors + 0x0001) + 0
   1F20 46            [ 7]  204 	ld	b,(hl)
   1F21 21 22 90      [10]  205 	ld	hl,#0x9022
   1F24 E5            [11]  206 	push	hl
   1F25 C5            [11]  207 	push	bc
   1F26 33            [ 6]  208 	inc	sp
   1F27 21 07 E1      [10]  209 	ld	hl,#0xE107
   1F2A E5            [11]  210 	push	hl
   1F2B CD C0 4D      [17]  211 	call	_cpct_drawSolidBox
   1F2E F1            [10]  212 	pop	af
   1F2F F1            [10]  213 	pop	af
   1F30 33            [ 6]  214 	inc	sp
   1F31 C9            [10]  215 	ret
                            216 	.area _CODE
                            217 	.area _INITIALIZER
                            218 	.area _CABS (ABS)
