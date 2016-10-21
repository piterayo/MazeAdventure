                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_MainMenu
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _level_set_level
                             12 	.globl _print_transparent_text
                             13 	.globl _statemanager_exit_game
                             14 	.globl _statemanager_input_accepted
                             15 	.globl _statemanager_set_state
                             16 	.globl _ui_mainmenu_render_refresh
                             17 	.globl _ui_mainmenu_render_all
                             18 	.globl _ui_mainmenu_unselect_entry
                             19 	.globl _ui_mainmenu_select_entry
                             20 	.globl _ui_mainmenu_previous_entry
                             21 	.globl _ui_mainmenu_next_entry
                             22 	.globl _ui_mainmenu_is_selected
                             23 	.globl _ui_mainmenu_get_entry
                             24 	.globl _ui_mainmenu_init
                             25 	.globl _cpct_isKeyPressed
                             26 	.globl _cpct_memset
                             27 	.globl _state_mainmenu_enter
                             28 	.globl _state_mainmenu_return
                             29 	.globl _state_mainmenu_input
                             30 	.globl _state_mainmenu_update
                             31 	.globl _state_mainmenu_render
                             32 	.globl _state_mainmenu_exit
                             33 ;--------------------------------------------------------
                             34 ; special function registers
                             35 ;--------------------------------------------------------
                             36 ;--------------------------------------------------------
                             37 ; ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DATA
                             40 ;--------------------------------------------------------
                             41 ; ram data
                             42 ;--------------------------------------------------------
                             43 	.area _INITIALIZED
                             44 ;--------------------------------------------------------
                             45 ; absolute external ram data
                             46 ;--------------------------------------------------------
                             47 	.area _DABS (ABS)
                             48 ;--------------------------------------------------------
                             49 ; global & static initialisations
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _GSINIT
                             53 	.area _GSFINAL
                             54 	.area _GSINIT
                             55 ;--------------------------------------------------------
                             56 ; Home
                             57 ;--------------------------------------------------------
                             58 	.area _HOME
                             59 	.area _HOME
                             60 ;--------------------------------------------------------
                             61 ; code
                             62 ;--------------------------------------------------------
                             63 	.area _CODE
                             64 ;src/State_MainMenu.c:16: void state_mainmenu_enter(){
                             65 ;	---------------------------------
                             66 ; Function state_mainmenu_enter
                             67 ; ---------------------------------
   21DB                      68 _state_mainmenu_enter::
                             69 ;src/State_MainMenu.c:18: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   21DB 21 67 10      [10]   70 	ld	hl,#_g_colors+1
   21DE 46            [ 7]   71 	ld	b,(hl)
   21DF 21 00 40      [10]   72 	ld	hl,#0x4000
   21E2 E5            [11]   73 	push	hl
   21E3 C5            [11]   74 	push	bc
   21E4 33            [ 6]   75 	inc	sp
   21E5 26 C0         [ 7]   76 	ld	h, #0xC0
   21E7 E5            [11]   77 	push	hl
   21E8 CD 44 59      [17]   78 	call	_cpct_memset
                             79 ;src/State_MainMenu.c:19: print_transparent_text("MAIN MENU", CPCT_VMEM_START, 3);
   21EB 3E 03         [ 7]   80 	ld	a,#0x03
   21ED F5            [11]   81 	push	af
   21EE 33            [ 6]   82 	inc	sp
   21EF 21 00 C0      [10]   83 	ld	hl,#0xC000
   21F2 E5            [11]   84 	push	hl
   21F3 21 04 22      [10]   85 	ld	hl,#___str_0
   21F6 E5            [11]   86 	push	hl
   21F7 CD 59 28      [17]   87 	call	_print_transparent_text
   21FA F1            [10]   88 	pop	af
   21FB F1            [10]   89 	pop	af
   21FC 33            [ 6]   90 	inc	sp
                             91 ;src/State_MainMenu.c:21: ui_mainmenu_init();
   21FD CD A6 2D      [17]   92 	call	_ui_mainmenu_init
                             93 ;src/State_MainMenu.c:22: ui_mainmenu_render_all();
   2200 CD A9 2E      [17]   94 	call	_ui_mainmenu_render_all
   2203 C9            [10]   95 	ret
   2204                      96 ___str_0:
   2204 4D 41 49 4E 20 4D    97 	.ascii "MAIN MENU"
        45 4E 55
   220D 00                   98 	.db 0x00
                             99 ;src/State_MainMenu.c:26: void state_mainmenu_return() {
                            100 ;	---------------------------------
                            101 ; Function state_mainmenu_return
                            102 ; ---------------------------------
   220E                     103 _state_mainmenu_return::
                            104 ;src/State_MainMenu.c:27: ui_mainmenu_render_all();
   220E C3 A9 2E      [10]  105 	jp  _ui_mainmenu_render_all
                            106 ;src/State_MainMenu.c:30: void state_mainmenu_input(){
                            107 ;	---------------------------------
                            108 ; Function state_mainmenu_input
                            109 ; ---------------------------------
   2211                     110 _state_mainmenu_input::
                            111 ;src/State_MainMenu.c:31: if(cpct_isKeyPressed(Key_CursorUp)){
   2211 21 00 01      [10]  112 	ld	hl,#0x0100
   2214 CD 4F 57      [17]  113 	call	_cpct_isKeyPressed
   2217 7D            [ 4]  114 	ld	a,l
   2218 B7            [ 4]  115 	or	a, a
   2219 28 06         [12]  116 	jr	Z,00107$
                            117 ;src/State_MainMenu.c:32: ui_mainmenu_previous_entry();
   221B CD 0A 2E      [17]  118 	call	_ui_mainmenu_previous_entry
                            119 ;src/State_MainMenu.c:33: statemanager_input_accepted();
   221E C3 6B 23      [10]  120 	jp  _statemanager_input_accepted
   2221                     121 00107$:
                            122 ;src/State_MainMenu.c:35: else if(cpct_isKeyPressed(Key_CursorDown)){
   2221 21 00 04      [10]  123 	ld	hl,#0x0400
   2224 CD 4F 57      [17]  124 	call	_cpct_isKeyPressed
   2227 7D            [ 4]  125 	ld	a,l
   2228 B7            [ 4]  126 	or	a, a
   2229 28 06         [12]  127 	jr	Z,00104$
                            128 ;src/State_MainMenu.c:36: ui_mainmenu_next_entry();
   222B CD FC 2D      [17]  129 	call	_ui_mainmenu_next_entry
                            130 ;src/State_MainMenu.c:37: statemanager_input_accepted();
   222E C3 6B 23      [10]  131 	jp  _statemanager_input_accepted
   2231                     132 00104$:
                            133 ;src/State_MainMenu.c:39: else if(cpct_isKeyPressed(Key_Return)){
   2231 21 02 04      [10]  134 	ld	hl,#0x0402
   2234 CD 4F 57      [17]  135 	call	_cpct_isKeyPressed
   2237 7D            [ 4]  136 	ld	a,l
   2238 B7            [ 4]  137 	or	a, a
   2239 C8            [11]  138 	ret	Z
                            139 ;src/State_MainMenu.c:40: ui_mainmenu_select_entry();
   223A CD 20 2E      [17]  140 	call	_ui_mainmenu_select_entry
                            141 ;src/State_MainMenu.c:41: statemanager_input_accepted();
   223D C3 6B 23      [10]  142 	jp  _statemanager_input_accepted
                            143 ;src/State_MainMenu.c:45: void state_mainmenu_update(){
                            144 ;	---------------------------------
                            145 ; Function state_mainmenu_update
                            146 ; ---------------------------------
   2240                     147 _state_mainmenu_update::
                            148 ;src/State_MainMenu.c:46: if(ui_mainmenu_is_selected()){
   2240 CD C9 2E      [17]  149 	call	_ui_mainmenu_is_selected
   2243 7D            [ 4]  150 	ld	a,l
   2244 B7            [ 4]  151 	or	a, a
   2245 C8            [11]  152 	ret	Z
                            153 ;src/State_MainMenu.c:47: ui_mainmenu_render_refresh();
   2246 CD 90 2E      [17]  154 	call	_ui_mainmenu_render_refresh
                            155 ;src/State_MainMenu.c:48: switch(ui_mainmenu_get_entry()){
   2249 CD C1 2E      [17]  156 	call	_ui_mainmenu_get_entry
   224C 5D            [ 4]  157 	ld	e,l
   224D 3E 04         [ 7]  158 	ld	a,#0x04
   224F 93            [ 4]  159 	sub	a, e
   2250 DA 1A 2E      [10]  160 	jp	C,_ui_mainmenu_unselect_entry
   2253 16 00         [ 7]  161 	ld	d,#0x00
   2255 21 5B 22      [10]  162 	ld	hl,#00119$
   2258 19            [11]  163 	add	hl,de
   2259 19            [11]  164 	add	hl,de
                            165 ;src/State_MainMenu.c:49: case 0:{
   225A E9            [ 4]  166 	jp	(hl)
   225B                     167 00119$:
   225B 18 08         [12]  168 	jr	00101$
   225D 18 1F         [12]  169 	jr	00106$
   225F 18 1D         [12]  170 	jr	00106$
   2261 18 1B         [12]  171 	jr	00106$
   2263 18 16         [12]  172 	jr	00105$
   2265                     173 00101$:
                            174 ;src/State_MainMenu.c:50: level_set_level(0);
   2265 2E 00         [ 7]  175 	ld	l,#0x00
   2267 CD EA 06      [17]  176 	call	_level_set_level
                            177 ;src/State_MainMenu.c:51: statemanager_set_state(STATE_LOADLEVEL);
   226A 2E 03         [ 7]  178 	ld	l,#0x03
   226C CD 71 23      [17]  179 	call	_statemanager_set_state
                            180 ;src/State_MainMenu.c:52: break;
   226F C3 1A 2E      [10]  181 	jp	_ui_mainmenu_unselect_entry
                            182 ;src/State_MainMenu.c:54: case 1:{
                            183 ;src/State_MainMenu.c:56: break;
   2272 C3 1A 2E      [10]  184 	jp	_ui_mainmenu_unselect_entry
                            185 ;src/State_MainMenu.c:58: case 2:{
                            186 ;src/State_MainMenu.c:60: break;
   2275 C3 1A 2E      [10]  187 	jp	_ui_mainmenu_unselect_entry
                            188 ;src/State_MainMenu.c:62: case 3:{
                            189 ;src/State_MainMenu.c:64: break;
   2278 C3 1A 2E      [10]  190 	jp	_ui_mainmenu_unselect_entry
                            191 ;src/State_MainMenu.c:66: case 4:{
   227B                     192 00105$:
                            193 ;src/State_MainMenu.c:67: statemanager_exit_game();
   227B CD 43 24      [17]  194 	call	_statemanager_exit_game
                            195 ;src/State_MainMenu.c:70: }
   227E                     196 00106$:
                            197 ;src/State_MainMenu.c:71: ui_mainmenu_unselect_entry();
   227E C3 1A 2E      [10]  198 	jp  _ui_mainmenu_unselect_entry
                            199 ;src/State_MainMenu.c:75: void state_mainmenu_render() {
                            200 ;	---------------------------------
                            201 ; Function state_mainmenu_render
                            202 ; ---------------------------------
   2281                     203 _state_mainmenu_render::
                            204 ;src/State_MainMenu.c:76: ui_mainmenu_render_refresh();
   2281 C3 90 2E      [10]  205 	jp  _ui_mainmenu_render_refresh
                            206 ;src/State_MainMenu.c:79: void state_mainmenu_exit(){
                            207 ;	---------------------------------
                            208 ; Function state_mainmenu_exit
                            209 ; ---------------------------------
   2284                     210 _state_mainmenu_exit::
                            211 ;src/State_MainMenu.c:81: }
   2284 C9            [10]  212 	ret
                            213 	.area _CODE
                            214 	.area _INITIALIZER
                            215 	.area _CABS (ABS)
