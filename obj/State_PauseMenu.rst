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
   3A62                      66 _state_pausemenu_enter::
                             67 ;src/State_PauseMenu.c:15: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
   3A62 21 B3 1A      [10]   68 	ld	hl, #_g_colors + 4
   3A65 46            [ 7]   69 	ld	b,(hl)
   3A66 21 22 90      [10]   70 	ld	hl,#0x9022
   3A69 E5            [11]   71 	push	hl
   3A6A C5            [11]   72 	push	bc
   3A6B 33            [ 6]   73 	inc	sp
   3A6C 21 07 E1      [10]   74 	ld	hl,#0xE107
   3A6F E5            [11]   75 	push	hl
   3A70 CD B8 7B      [17]   76 	call	_cpct_drawSolidBox
   3A73 F1            [10]   77 	pop	af
   3A74 F1            [10]   78 	pop	af
   3A75 33            [ 6]   79 	inc	sp
                             80 ;src/State_PauseMenu.c:16: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
   3A76 21 B0 1A      [10]   81 	ld	hl, #_g_colors + 1
   3A79 46            [ 7]   82 	ld	b,(hl)
   3A7A 21 20 88      [10]   83 	ld	hl,#0x8820
   3A7D E5            [11]   84 	push	hl
   3A7E C5            [11]   85 	push	bc
   3A7F 33            [ 6]   86 	inc	sp
   3A80 21 58 C1      [10]   87 	ld	hl,#0xC158
   3A83 E5            [11]   88 	push	hl
   3A84 CD B8 7B      [17]   89 	call	_cpct_drawSolidBox
   3A87 F1            [10]   90 	pop	af
   3A88 F1            [10]   91 	pop	af
   3A89 33            [ 6]   92 	inc	sp
                             93 ;src/State_PauseMenu.c:17: ui_pausemenu_init();
   3A8A CD C4 4A      [17]   94 	call	_ui_pausemenu_init
                             95 ;src/State_PauseMenu.c:18: ui_pausemenu_render_all();
   3A8D C3 CD 4B      [10]   96 	jp  _ui_pausemenu_render_all
                             97 ;src/State_PauseMenu.c:21: void state_pausemenu_return() {
                             98 ;	---------------------------------
                             99 ; Function state_pausemenu_return
                            100 ; ---------------------------------
   3A90                     101 _state_pausemenu_return::
                            102 ;src/State_PauseMenu.c:22: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[4], 34, 144);
   3A90 21 B3 1A      [10]  103 	ld	hl, #_g_colors + 4
   3A93 46            [ 7]  104 	ld	b,(hl)
   3A94 21 22 90      [10]  105 	ld	hl,#0x9022
   3A97 E5            [11]  106 	push	hl
   3A98 C5            [11]  107 	push	bc
   3A99 33            [ 6]  108 	inc	sp
   3A9A 21 07 E1      [10]  109 	ld	hl,#0xE107
   3A9D E5            [11]  110 	push	hl
   3A9E CD B8 7B      [17]  111 	call	_cpct_drawSolidBox
   3AA1 F1            [10]  112 	pop	af
   3AA2 F1            [10]  113 	pop	af
   3AA3 33            [ 6]  114 	inc	sp
                            115 ;src/State_PauseMenu.c:23: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 32), g_colors[1], 32, 136);
   3AA4 21 B0 1A      [10]  116 	ld	hl, #_g_colors + 1
   3AA7 46            [ 7]  117 	ld	b,(hl)
   3AA8 21 20 88      [10]  118 	ld	hl,#0x8820
   3AAB E5            [11]  119 	push	hl
   3AAC C5            [11]  120 	push	bc
   3AAD 33            [ 6]  121 	inc	sp
   3AAE 21 58 C1      [10]  122 	ld	hl,#0xC158
   3AB1 E5            [11]  123 	push	hl
   3AB2 CD B8 7B      [17]  124 	call	_cpct_drawSolidBox
   3AB5 F1            [10]  125 	pop	af
   3AB6 F1            [10]  126 	pop	af
   3AB7 33            [ 6]  127 	inc	sp
                            128 ;src/State_PauseMenu.c:24: ui_pausemenu_render_all();
   3AB8 C3 CD 4B      [10]  129 	jp  _ui_pausemenu_render_all
                            130 ;src/State_PauseMenu.c:27: void state_pausemenu_input(){
                            131 ;	---------------------------------
                            132 ; Function state_pausemenu_input
                            133 ; ---------------------------------
   3ABB                     134 _state_pausemenu_input::
                            135 ;src/State_PauseMenu.c:29: if(cpct_isKeyPressed(Key_CursorUp)){
   3ABB 21 00 01      [10]  136 	ld	hl,#0x0100
   3ABE CD 65 79      [17]  137 	call	_cpct_isKeyPressed
   3AC1 7D            [ 4]  138 	ld	a,l
   3AC2 B7            [ 4]  139 	or	a, a
   3AC3 28 06         [12]  140 	jr	Z,00107$
                            141 ;src/State_PauseMenu.c:30: ui_pausemenu_previous_entry();
   3AC5 CD 2E 4B      [17]  142 	call	_ui_pausemenu_previous_entry
                            143 ;src/State_PauseMenu.c:31: statemanager_input_accepted();
   3AC8 C3 B6 38      [10]  144 	jp  _statemanager_input_accepted
   3ACB                     145 00107$:
                            146 ;src/State_PauseMenu.c:33: else if(cpct_isKeyPressed(Key_CursorDown)){
   3ACB 21 00 04      [10]  147 	ld	hl,#0x0400
   3ACE CD 65 79      [17]  148 	call	_cpct_isKeyPressed
   3AD1 7D            [ 4]  149 	ld	a,l
   3AD2 B7            [ 4]  150 	or	a, a
   3AD3 28 06         [12]  151 	jr	Z,00104$
                            152 ;src/State_PauseMenu.c:34: ui_pausemenu_next_entry();
   3AD5 CD 20 4B      [17]  153 	call	_ui_pausemenu_next_entry
                            154 ;src/State_PauseMenu.c:35: statemanager_input_accepted();
   3AD8 C3 B6 38      [10]  155 	jp  _statemanager_input_accepted
   3ADB                     156 00104$:
                            157 ;src/State_PauseMenu.c:37: else if(cpct_isKeyPressed(Key_Return)){
   3ADB 21 02 04      [10]  158 	ld	hl,#0x0402
   3ADE CD 65 79      [17]  159 	call	_cpct_isKeyPressed
   3AE1 7D            [ 4]  160 	ld	a,l
   3AE2 B7            [ 4]  161 	or	a, a
   3AE3 C8            [11]  162 	ret	Z
                            163 ;src/State_PauseMenu.c:38: ui_pausemenu_select_entry();
   3AE4 CD 3E 4B      [17]  164 	call	_ui_pausemenu_select_entry
                            165 ;src/State_PauseMenu.c:39: statemanager_input_accepted();
   3AE7 C3 B6 38      [10]  166 	jp  _statemanager_input_accepted
                            167 ;src/State_PauseMenu.c:44: void state_pausemenu_update(){
                            168 ;	---------------------------------
                            169 ; Function state_pausemenu_update
                            170 ; ---------------------------------
   3AEA                     171 _state_pausemenu_update::
                            172 ;src/State_PauseMenu.c:45: if(ui_pausemenu_is_selected()){
   3AEA CD 18 4B      [17]  173 	call	_ui_pausemenu_is_selected
   3AED 7D            [ 4]  174 	ld	a,l
   3AEE B7            [ 4]  175 	or	a, a
   3AEF CA 44 4B      [10]  176 	jp	Z,_ui_pausemenu_unselect_entry
                            177 ;src/State_PauseMenu.c:46: ui_pausemenu_render_refresh();
   3AF2 CD B4 4B      [17]  178 	call	_ui_pausemenu_render_refresh
                            179 ;src/State_PauseMenu.c:47: switch(ui_pausemenu_get_entry()){
   3AF5 CD 10 4B      [17]  180 	call	_ui_pausemenu_get_entry
   3AF8 5D            [ 4]  181 	ld	e,l
   3AF9 3E 03         [ 7]  182 	ld	a,#0x03
   3AFB 93            [ 4]  183 	sub	a, e
   3AFC DA 44 4B      [10]  184 	jp	C,_ui_pausemenu_unselect_entry
   3AFF 16 00         [ 7]  185 	ld	d,#0x00
   3B01 21 07 3B      [10]  186 	ld	hl,#00118$
   3B04 19            [11]  187 	add	hl,de
   3B05 19            [11]  188 	add	hl,de
                            189 ;src/State_PauseMenu.c:48: case 0:{
   3B06 E9            [ 4]  190 	jp	(hl)
   3B07                     191 00118$:
   3B07 18 06         [12]  192 	jr	00101$
   3B09 18 0A         [12]  193 	jr	00102$
   3B0B 18 13         [12]  194 	jr	00103$
   3B0D 18 1C         [12]  195 	jr	00104$
   3B0F                     196 00101$:
                            197 ;src/State_PauseMenu.c:49: statemanager_close_state();
   3B0F CD 5F 39      [17]  198 	call	_statemanager_close_state
                            199 ;src/State_PauseMenu.c:50: break;
   3B12 C3 44 4B      [10]  200 	jp	_ui_pausemenu_unselect_entry
                            201 ;src/State_PauseMenu.c:52: case 1:{
   3B15                     202 00102$:
                            203 ;src/State_PauseMenu.c:53: statemanager_set_state(STATE_OPTIONS);
   3B15 3E 04         [ 7]  204 	ld	a,#0x04
   3B17 F5            [11]  205 	push	af
   3B18 33            [ 6]  206 	inc	sp
   3B19 CD BC 38      [17]  207 	call	_statemanager_set_state
   3B1C 33            [ 6]  208 	inc	sp
                            209 ;src/State_PauseMenu.c:54: break;
   3B1D C3 44 4B      [10]  210 	jp	_ui_pausemenu_unselect_entry
                            211 ;src/State_PauseMenu.c:56: case 2:{
   3B20                     212 00103$:
                            213 ;src/State_PauseMenu.c:57: statemanager_set_state(STATE_SAVEEXIT);
   3B20 3E 09         [ 7]  214 	ld	a,#0x09
   3B22 F5            [11]  215 	push	af
   3B23 33            [ 6]  216 	inc	sp
   3B24 CD BC 38      [17]  217 	call	_statemanager_set_state
   3B27 33            [ 6]  218 	inc	sp
                            219 ;src/State_PauseMenu.c:58: break;
   3B28 C3 44 4B      [10]  220 	jp	_ui_pausemenu_unselect_entry
                            221 ;src/State_PauseMenu.c:60: case 3:{
   3B2B                     222 00104$:
                            223 ;src/State_PauseMenu.c:61: statemanager_set_state(STATE_MAINMENU);
   3B2B AF            [ 4]  224 	xor	a, a
   3B2C F5            [11]  225 	push	af
   3B2D 33            [ 6]  226 	inc	sp
   3B2E CD BC 38      [17]  227 	call	_statemanager_set_state
   3B31 33            [ 6]  228 	inc	sp
                            229 ;src/State_PauseMenu.c:64: }
                            230 ;src/State_PauseMenu.c:66: ui_pausemenu_unselect_entry();
   3B32 C3 44 4B      [10]  231 	jp  _ui_pausemenu_unselect_entry
                            232 ;src/State_PauseMenu.c:69: void state_pausemenu_render() {
                            233 ;	---------------------------------
                            234 ; Function state_pausemenu_render
                            235 ; ---------------------------------
   3B35                     236 _state_pausemenu_render::
                            237 ;src/State_PauseMenu.c:70: ui_pausemenu_render_refresh();
   3B35 C3 B4 4B      [10]  238 	jp  _ui_pausemenu_render_refresh
                            239 ;src/State_PauseMenu.c:73: void state_pausemenu_exit(){
                            240 ;	---------------------------------
                            241 ; Function state_pausemenu_exit
                            242 ; ---------------------------------
   3B38                     243 _state_pausemenu_exit::
                            244 ;src/State_PauseMenu.c:74: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 28), g_colors[1], 34, 144);
   3B38 21 B0 1A      [10]  245 	ld	hl, #(_g_colors + 0x0001) + 0
   3B3B 46            [ 7]  246 	ld	b,(hl)
   3B3C 21 22 90      [10]  247 	ld	hl,#0x9022
   3B3F E5            [11]  248 	push	hl
   3B40 C5            [11]  249 	push	bc
   3B41 33            [ 6]  250 	inc	sp
   3B42 21 07 E1      [10]  251 	ld	hl,#0xE107
   3B45 E5            [11]  252 	push	hl
   3B46 CD B8 7B      [17]  253 	call	_cpct_drawSolidBox
   3B49 F1            [10]  254 	pop	af
   3B4A F1            [10]  255 	pop	af
   3B4B 33            [ 6]  256 	inc	sp
   3B4C C9            [10]  257 	ret
                            258 	.area _CODE
                            259 	.area _INITIALIZER
                            260 	.area _CABS (ABS)
