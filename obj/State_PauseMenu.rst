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
   3BB0                      66 _state_pausemenu_enter::
                             67 ;src/State_PauseMenu.c:15: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
   3BB0 21 2C 1C      [10]   68 	ld	hl, #_g_colors + 4
   3BB3 46            [ 7]   69 	ld	b,(hl)
   3BB4 21 22 90      [10]   70 	ld	hl,#0x9022
   3BB7 E5            [11]   71 	push	hl
   3BB8 C5            [11]   72 	push	bc
   3BB9 33            [ 6]   73 	inc	sp
   3BBA 21 07 E1      [10]   74 	ld	hl,#0xE107
   3BBD E5            [11]   75 	push	hl
   3BBE CD 2F 85      [17]   76 	call	_cpct_drawSolidBox
   3BC1 F1            [10]   77 	pop	af
   3BC2 F1            [10]   78 	pop	af
   3BC3 33            [ 6]   79 	inc	sp
                             80 ;src/State_PauseMenu.c:16: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
   3BC4 21 29 1C      [10]   81 	ld	hl, #_g_colors + 1
   3BC7 46            [ 7]   82 	ld	b,(hl)
   3BC8 21 20 88      [10]   83 	ld	hl,#0x8820
   3BCB E5            [11]   84 	push	hl
   3BCC C5            [11]   85 	push	bc
   3BCD 33            [ 6]   86 	inc	sp
   3BCE 21 58 C1      [10]   87 	ld	hl,#0xC158
   3BD1 E5            [11]   88 	push	hl
   3BD2 CD 2F 85      [17]   89 	call	_cpct_drawSolidBox
   3BD5 F1            [10]   90 	pop	af
   3BD6 F1            [10]   91 	pop	af
   3BD7 33            [ 6]   92 	inc	sp
                             93 ;src/State_PauseMenu.c:17: ui_pausemenu_init();
   3BD8 CD 12 4C      [17]   94 	call	_ui_pausemenu_init
                             95 ;src/State_PauseMenu.c:18: ui_pausemenu_render_all();
   3BDB C3 1B 4D      [10]   96 	jp  _ui_pausemenu_render_all
                             97 ;src/State_PauseMenu.c:21: void state_pausemenu_return() {
                             98 ;	---------------------------------
                             99 ; Function state_pausemenu_return
                            100 ; ---------------------------------
   3BDE                     101 _state_pausemenu_return::
                            102 ;src/State_PauseMenu.c:22: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
   3BDE 21 2C 1C      [10]  103 	ld	hl, #_g_colors + 4
   3BE1 46            [ 7]  104 	ld	b,(hl)
   3BE2 21 22 90      [10]  105 	ld	hl,#0x9022
   3BE5 E5            [11]  106 	push	hl
   3BE6 C5            [11]  107 	push	bc
   3BE7 33            [ 6]  108 	inc	sp
   3BE8 21 07 E1      [10]  109 	ld	hl,#0xE107
   3BEB E5            [11]  110 	push	hl
   3BEC CD 2F 85      [17]  111 	call	_cpct_drawSolidBox
   3BEF F1            [10]  112 	pop	af
   3BF0 F1            [10]  113 	pop	af
   3BF1 33            [ 6]  114 	inc	sp
                            115 ;src/State_PauseMenu.c:23: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
   3BF2 21 29 1C      [10]  116 	ld	hl, #_g_colors + 1
   3BF5 46            [ 7]  117 	ld	b,(hl)
   3BF6 21 20 88      [10]  118 	ld	hl,#0x8820
   3BF9 E5            [11]  119 	push	hl
   3BFA C5            [11]  120 	push	bc
   3BFB 33            [ 6]  121 	inc	sp
   3BFC 21 58 C1      [10]  122 	ld	hl,#0xC158
   3BFF E5            [11]  123 	push	hl
   3C00 CD 2F 85      [17]  124 	call	_cpct_drawSolidBox
   3C03 F1            [10]  125 	pop	af
   3C04 F1            [10]  126 	pop	af
   3C05 33            [ 6]  127 	inc	sp
                            128 ;src/State_PauseMenu.c:24: ui_pausemenu_render_all();
   3C06 C3 1B 4D      [10]  129 	jp  _ui_pausemenu_render_all
                            130 ;src/State_PauseMenu.c:27: void state_pausemenu_input(){
                            131 ;	---------------------------------
                            132 ; Function state_pausemenu_input
                            133 ; ---------------------------------
   3C09                     134 _state_pausemenu_input::
                            135 ;src/State_PauseMenu.c:29: if(cpct_isKeyPressed(Key_CursorUp)){
   3C09 21 00 01      [10]  136 	ld	hl,#0x0100
   3C0C CD B3 7A      [17]  137 	call	_cpct_isKeyPressed
   3C0F 7D            [ 4]  138 	ld	a,l
   3C10 B7            [ 4]  139 	or	a, a
   3C11 28 06         [12]  140 	jr	Z,00107$
                            141 ;src/State_PauseMenu.c:30: ui_pausemenu_previous_entry();
   3C13 CD 7C 4C      [17]  142 	call	_ui_pausemenu_previous_entry
                            143 ;src/State_PauseMenu.c:31: statemanager_input_accepted();
   3C16 C3 FB 39      [10]  144 	jp  _statemanager_input_accepted
   3C19                     145 00107$:
                            146 ;src/State_PauseMenu.c:33: else if(cpct_isKeyPressed(Key_CursorDown)){
   3C19 21 00 04      [10]  147 	ld	hl,#0x0400
   3C1C CD B3 7A      [17]  148 	call	_cpct_isKeyPressed
   3C1F 7D            [ 4]  149 	ld	a,l
   3C20 B7            [ 4]  150 	or	a, a
   3C21 28 06         [12]  151 	jr	Z,00104$
                            152 ;src/State_PauseMenu.c:34: ui_pausemenu_next_entry();
   3C23 CD 6E 4C      [17]  153 	call	_ui_pausemenu_next_entry
                            154 ;src/State_PauseMenu.c:35: statemanager_input_accepted();
   3C26 C3 FB 39      [10]  155 	jp  _statemanager_input_accepted
   3C29                     156 00104$:
                            157 ;src/State_PauseMenu.c:37: else if(cpct_isKeyPressed(Key_Return)){
   3C29 21 02 04      [10]  158 	ld	hl,#0x0402
   3C2C CD B3 7A      [17]  159 	call	_cpct_isKeyPressed
   3C2F 7D            [ 4]  160 	ld	a,l
   3C30 B7            [ 4]  161 	or	a, a
   3C31 C8            [11]  162 	ret	Z
                            163 ;src/State_PauseMenu.c:38: ui_pausemenu_select_entry();
   3C32 CD 8C 4C      [17]  164 	call	_ui_pausemenu_select_entry
                            165 ;src/State_PauseMenu.c:39: statemanager_input_accepted();
   3C35 C3 FB 39      [10]  166 	jp  _statemanager_input_accepted
                            167 ;src/State_PauseMenu.c:44: void state_pausemenu_update(){
                            168 ;	---------------------------------
                            169 ; Function state_pausemenu_update
                            170 ; ---------------------------------
   3C38                     171 _state_pausemenu_update::
                            172 ;src/State_PauseMenu.c:45: if(ui_pausemenu_is_selected()){
   3C38 CD 66 4C      [17]  173 	call	_ui_pausemenu_is_selected
   3C3B 7D            [ 4]  174 	ld	a,l
   3C3C B7            [ 4]  175 	or	a, a
   3C3D CA 92 4C      [10]  176 	jp	Z,_ui_pausemenu_unselect_entry
                            177 ;src/State_PauseMenu.c:46: ui_pausemenu_render_refresh();
   3C40 CD 02 4D      [17]  178 	call	_ui_pausemenu_render_refresh
                            179 ;src/State_PauseMenu.c:47: switch(ui_pausemenu_get_entry()){
   3C43 CD 5E 4C      [17]  180 	call	_ui_pausemenu_get_entry
   3C46 5D            [ 4]  181 	ld	e,l
   3C47 3E 03         [ 7]  182 	ld	a,#0x03
   3C49 93            [ 4]  183 	sub	a, e
   3C4A DA 92 4C      [10]  184 	jp	C,_ui_pausemenu_unselect_entry
   3C4D 16 00         [ 7]  185 	ld	d,#0x00
   3C4F 21 55 3C      [10]  186 	ld	hl,#00118$
   3C52 19            [11]  187 	add	hl,de
   3C53 19            [11]  188 	add	hl,de
                            189 ;src/State_PauseMenu.c:48: case 0:{
   3C54 E9            [ 4]  190 	jp	(hl)
   3C55                     191 00118$:
   3C55 18 06         [12]  192 	jr	00101$
   3C57 18 0A         [12]  193 	jr	00102$
   3C59 18 13         [12]  194 	jr	00103$
   3C5B 18 1C         [12]  195 	jr	00104$
   3C5D                     196 00101$:
                            197 ;src/State_PauseMenu.c:49: statemanager_close_state();
   3C5D CD A4 3A      [17]  198 	call	_statemanager_close_state
                            199 ;src/State_PauseMenu.c:50: break;
   3C60 C3 92 4C      [10]  200 	jp	_ui_pausemenu_unselect_entry
                            201 ;src/State_PauseMenu.c:52: case 1:{
   3C63                     202 00102$:
                            203 ;src/State_PauseMenu.c:53: statemanager_set_state(STATE_OPTIONS);
   3C63 3E 04         [ 7]  204 	ld	a,#0x04
   3C65 F5            [11]  205 	push	af
   3C66 33            [ 6]  206 	inc	sp
   3C67 CD 01 3A      [17]  207 	call	_statemanager_set_state
   3C6A 33            [ 6]  208 	inc	sp
                            209 ;src/State_PauseMenu.c:54: break;
   3C6B C3 92 4C      [10]  210 	jp	_ui_pausemenu_unselect_entry
                            211 ;src/State_PauseMenu.c:56: case 2:{
   3C6E                     212 00103$:
                            213 ;src/State_PauseMenu.c:57: statemanager_set_state(STATE_SAVEEXIT);
   3C6E 3E 09         [ 7]  214 	ld	a,#0x09
   3C70 F5            [11]  215 	push	af
   3C71 33            [ 6]  216 	inc	sp
   3C72 CD 01 3A      [17]  217 	call	_statemanager_set_state
   3C75 33            [ 6]  218 	inc	sp
                            219 ;src/State_PauseMenu.c:58: break;
   3C76 C3 92 4C      [10]  220 	jp	_ui_pausemenu_unselect_entry
                            221 ;src/State_PauseMenu.c:60: case 3:{
   3C79                     222 00104$:
                            223 ;src/State_PauseMenu.c:61: statemanager_set_state(STATE_MAINMENU);
   3C79 AF            [ 4]  224 	xor	a, a
   3C7A F5            [11]  225 	push	af
   3C7B 33            [ 6]  226 	inc	sp
   3C7C CD 01 3A      [17]  227 	call	_statemanager_set_state
   3C7F 33            [ 6]  228 	inc	sp
                            229 ;src/State_PauseMenu.c:64: }
                            230 ;src/State_PauseMenu.c:66: ui_pausemenu_unselect_entry();
   3C80 C3 92 4C      [10]  231 	jp  _ui_pausemenu_unselect_entry
                            232 ;src/State_PauseMenu.c:69: void state_pausemenu_render() {
                            233 ;	---------------------------------
                            234 ; Function state_pausemenu_render
                            235 ; ---------------------------------
   3C83                     236 _state_pausemenu_render::
                            237 ;src/State_PauseMenu.c:70: ui_pausemenu_render_refresh();
   3C83 C3 02 4D      [10]  238 	jp  _ui_pausemenu_render_refresh
                            239 ;src/State_PauseMenu.c:73: void state_pausemenu_exit(){
                            240 ;	---------------------------------
                            241 ; Function state_pausemenu_exit
                            242 ; ---------------------------------
   3C86                     243 _state_pausemenu_exit::
                            244 ;src/State_PauseMenu.c:74: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[1], 34, 144);
   3C86 21 29 1C      [10]  245 	ld	hl, #(_g_colors + 0x0001) + 0
   3C89 46            [ 7]  246 	ld	b,(hl)
   3C8A 21 22 90      [10]  247 	ld	hl,#0x9022
   3C8D E5            [11]  248 	push	hl
   3C8E C5            [11]  249 	push	bc
   3C8F 33            [ 6]  250 	inc	sp
   3C90 21 07 E1      [10]  251 	ld	hl,#0xE107
   3C93 E5            [11]  252 	push	hl
   3C94 CD 2F 85      [17]  253 	call	_cpct_drawSolidBox
   3C97 F1            [10]  254 	pop	af
   3C98 F1            [10]  255 	pop	af
   3C99 33            [ 6]  256 	inc	sp
   3C9A C9            [10]  257 	ret
                            258 	.area _CODE
                            259 	.area _INITIALIZER
                            260 	.area _CABS (ABS)
