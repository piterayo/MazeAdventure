                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module StateManager
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _statemanager_update_state
                             12 	.globl _statemanager_render_state
                             13 	.globl _statemanager_manage_input
                             14 	.globl _statemanager_change_state
                             15 	.globl _cpct_scanKeyboard_f
                             16 	.globl _last_keyboardStatusBuffer
                             17 	.globl _inputReceived
                             18 	.globl _changeToState
                             19 	.globl _currentState
                             20 	.globl _stateArray
                             21 	.globl _statemanager_input_accepted
                             22 	.globl _statemanager_set_state
                             23 	.globl _scan_input
                             24 	.globl _statemanager_close_state
                             25 	.globl _statemanager_main_loop
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
   9114                      37 _last_keyboardStatusBuffer::
   9114                      38 	.ds 10
                             39 ;--------------------------------------------------------
                             40 ; absolute external ram data
                             41 ;--------------------------------------------------------
                             42 	.area _DABS (ABS)
                             43 ;--------------------------------------------------------
                             44 ; global & static initialisations
                             45 ;--------------------------------------------------------
                             46 	.area _HOME
                             47 	.area _GSINIT
                             48 	.area _GSFINAL
                             49 	.area _GSINIT
                             50 ;--------------------------------------------------------
                             51 ; Home
                             52 ;--------------------------------------------------------
                             53 	.area _HOME
                             54 	.area _HOME
                             55 ;--------------------------------------------------------
                             56 ; code
                             57 ;--------------------------------------------------------
                             58 	.area _CODE
                             59 ;src/StateManager.c:51: void statemanager_change_state(){
                             60 ;	---------------------------------
                             61 ; Function statemanager_change_state
                             62 ; ---------------------------------
   6BBE                      63 _statemanager_change_state::
                             64 ;src/StateManager.c:52: if(changeToState){
   6BBE 21 08 6C      [10]   65 	ld	hl,#_changeToState + 0
   6BC1 4E            [ 7]   66 	ld	c, (hl)
   6BC2 3A 08 6C      [13]   67 	ld	a,(#_changeToState + 0)
   6BC5 B7            [ 4]   68 	or	a, a
   6BC6 C8            [11]   69 	ret	Z
                             70 ;src/StateManager.c:53: *(u8*)&currentState = changeToState-1;
   6BC7 21 07 6C      [10]   71 	ld	hl,#_currentState+0
   6BCA 0D            [ 4]   72 	dec	c
   6BCB 71            [ 7]   73 	ld	(hl),c
                             74 ;src/StateManager.c:54: stateArray[currentState].enterState();
   6BCC 01 E9 6B      [10]   75 	ld	bc,#_stateArray+0
   6BCF 21 07 6C      [10]   76 	ld	hl,#_currentState + 0
   6BD2 5E            [ 7]   77 	ld	e, (hl)
   6BD3 16 00         [ 7]   78 	ld	d,#0x00
   6BD5 6B            [ 4]   79 	ld	l, e
   6BD6 62            [ 4]   80 	ld	h, d
   6BD7 29            [11]   81 	add	hl, hl
   6BD8 29            [11]   82 	add	hl, hl
   6BD9 19            [11]   83 	add	hl, de
   6BDA 29            [11]   84 	add	hl, hl
   6BDB 09            [11]   85 	add	hl,bc
   6BDC 4E            [ 7]   86 	ld	c,(hl)
   6BDD 23            [ 6]   87 	inc	hl
   6BDE 66            [ 7]   88 	ld	h,(hl)
   6BDF 69            [ 4]   89 	ld	l, c
   6BE0 CD A6 8E      [17]   90 	call	___sdcc_call_hl
                             91 ;src/StateManager.c:55: *(u8*)&changeToState = 0;
   6BE3 21 08 6C      [10]   92 	ld	hl,#_changeToState
   6BE6 36 00         [10]   93 	ld	(hl),#0x00
   6BE8 C9            [10]   94 	ret
   6BE9                      95 _stateArray:
   6BE9 79 6B                96 	.dw _state_mainmenu_enter
   6BEB A7 6B                97 	.dw _state_mainmenu_input
   6BED BB 6B                98 	.dw _state_mainmenu_update
   6BEF BC 6B                99 	.dw _state_mainmenu_render
   6BF1 BD 6B               100 	.dw _state_mainmenu_exit
   6BF3 E4 69               101 	.dw _state_ingame_enter
   6BF5 15 6A               102 	.dw _state_ingame_input
   6BF7 40 6B               103 	.dw _state_ingame_update
   6BF9 51 6B               104 	.dw _state_ingame_render
   6BFB 73 6B               105 	.dw _state_ingame_exit
   6BFD FE 6C               106 	.dw _state_pausemenu_enter
   6BFF 3E 6D               107 	.dw _state_pausemenu_input
   6C01 6E 6D               108 	.dw _state_pausemenu_update
   6C03 6F 6D               109 	.dw _state_pausemenu_render
   6C05 70 6D               110 	.dw _state_pausemenu_exit
   6C07                     111 _currentState:
   6C07 00                  112 	.db #0x00	; 0
   6C08                     113 _changeToState:
   6C08 00                  114 	.db #0x00	; 0
   6C09                     115 _inputReceived:
   6C09 00                  116 	.db #0x00	; 0
                            117 ;src/StateManager.c:59: void statemanager_input_accepted(){
                            118 ;	---------------------------------
                            119 ; Function statemanager_input_accepted
                            120 ; ---------------------------------
   6C0A                     121 _statemanager_input_accepted::
                            122 ;src/StateManager.c:60: *(u8*)&inputReceived=1;
   6C0A 21 09 6C      [10]  123 	ld	hl,#_inputReceived
   6C0D 36 01         [10]  124 	ld	(hl),#0x01
   6C0F C9            [10]  125 	ret
                            126 ;src/StateManager.c:63: void statemanager_set_state(u8 state){
                            127 ;	---------------------------------
                            128 ; Function statemanager_set_state
                            129 ; ---------------------------------
   6C10                     130 _statemanager_set_state::
                            131 ;src/StateManager.c:64: *(u8*)&changeToState = state+1;
   6C10 01 08 6C      [10]  132 	ld	bc,#_changeToState+0
   6C13 21 02 00      [10]  133 	ld	hl, #2+0
   6C16 39            [11]  134 	add	hl, sp
   6C17 7E            [ 7]  135 	ld	a, (hl)
   6C18 3C            [ 4]  136 	inc	a
   6C19 02            [ 7]  137 	ld	(bc),a
   6C1A C9            [10]  138 	ret
                            139 ;src/StateManager.c:67: void scan_input(){
                            140 ;	---------------------------------
                            141 ; Function scan_input
                            142 ; ---------------------------------
   6C1B                     143 _scan_input::
   6C1B DD E5         [15]  144 	push	ix
   6C1D DD 21 00 00   [14]  145 	ld	ix,#0
   6C21 DD 39         [15]  146 	add	ix,sp
   6C23 F5            [11]  147 	push	af
   6C24 F5            [11]  148 	push	af
                            149 ;src/StateManager.c:69: cpct_scanKeyboard_f();
   6C25 CD 2D 8C      [17]  150 	call	_cpct_scanKeyboard_f
                            151 ;src/StateManager.c:70: while(n){
   6C28 DD 36 FC 0A   [19]  152 	ld	-4 (ix),#0x0A
   6C2C                     153 00101$:
   6C2C DD 7E FC      [19]  154 	ld	a,-4 (ix)
   6C2F B7            [ 4]  155 	or	a, a
   6C30 28 35         [12]  156 	jr	Z,00104$
                            157 ;src/StateManager.c:71: --n;
   6C32 DD 35 FC      [23]  158 	dec	-4 (ix)
                            159 ;src/StateManager.c:72: t=cpct_keyboardStatusBuffer[n];
   6C35 3E 3F         [ 7]  160 	ld	a,#<(_cpct_keyboardStatusBuffer)
   6C37 DD 86 FC      [19]  161 	add	a, -4 (ix)
   6C3A 4F            [ 4]  162 	ld	c,a
   6C3B 3E 8E         [ 7]  163 	ld	a,#>(_cpct_keyboardStatusBuffer)
   6C3D CE 00         [ 7]  164 	adc	a, #0x00
   6C3F 47            [ 4]  165 	ld	b,a
   6C40 0A            [ 7]  166 	ld	a,(bc)
   6C41 DD 77 FD      [19]  167 	ld	-3 (ix),a
                            168 ;src/StateManager.c:73: cpct_keyboardStatusBuffer[n]=((last_keyboardStatusBuffer[n])|(~t));
   6C44 3E 14         [ 7]  169 	ld	a,#<(_last_keyboardStatusBuffer)
   6C46 DD 86 FC      [19]  170 	add	a, -4 (ix)
   6C49 5F            [ 4]  171 	ld	e,a
   6C4A 3E 91         [ 7]  172 	ld	a,#>(_last_keyboardStatusBuffer)
   6C4C CE 00         [ 7]  173 	adc	a, #0x00
   6C4E 57            [ 4]  174 	ld	d,a
   6C4F 1A            [ 7]  175 	ld	a,(de)
   6C50 DD 77 FF      [19]  176 	ld	-1 (ix),a
   6C53 DD 7E FD      [19]  177 	ld	a,-3 (ix)
   6C56 2F            [ 4]  178 	cpl
   6C57 DD 77 FE      [19]  179 	ld	-2 (ix),a
   6C5A DD 7E FF      [19]  180 	ld	a,-1 (ix)
   6C5D DD B6 FE      [19]  181 	or	a, -2 (ix)
   6C60 02            [ 7]  182 	ld	(bc),a
                            183 ;src/StateManager.c:74: last_keyboardStatusBuffer[n]=t;
   6C61 DD 7E FD      [19]  184 	ld	a,-3 (ix)
   6C64 12            [ 7]  185 	ld	(de),a
   6C65 18 C5         [12]  186 	jr	00101$
   6C67                     187 00104$:
   6C67 DD F9         [10]  188 	ld	sp, ix
   6C69 DD E1         [14]  189 	pop	ix
   6C6B C9            [10]  190 	ret
                            191 ;src/StateManager.c:78: void statemanager_manage_input(){
                            192 ;	---------------------------------
                            193 ; Function statemanager_manage_input
                            194 ; ---------------------------------
   6C6C                     195 _statemanager_manage_input::
                            196 ;src/StateManager.c:79: while(!inputReceived){
   6C6C                     197 00101$:
   6C6C 3A 09 6C      [13]  198 	ld	a,(#_inputReceived + 0)
   6C6F B7            [ 4]  199 	or	a, a
   6C70 20 1E         [12]  200 	jr	NZ,00103$
                            201 ;src/StateManager.c:80: scan_input();
   6C72 CD 1B 6C      [17]  202 	call	_scan_input
                            203 ;src/StateManager.c:81: stateArray[currentState].inputState();
   6C75 21 07 6C      [10]  204 	ld	hl,#_currentState + 0
   6C78 4E            [ 7]  205 	ld	c, (hl)
   6C79 06 00         [ 7]  206 	ld	b,#0x00
   6C7B 69            [ 4]  207 	ld	l, c
   6C7C 60            [ 4]  208 	ld	h, b
   6C7D 29            [11]  209 	add	hl, hl
   6C7E 29            [11]  210 	add	hl, hl
   6C7F 09            [11]  211 	add	hl, bc
   6C80 29            [11]  212 	add	hl, hl
   6C81 11 E9 6B      [10]  213 	ld	de,#_stateArray
   6C84 19            [11]  214 	add	hl,de
   6C85 23            [ 6]  215 	inc	hl
   6C86 23            [ 6]  216 	inc	hl
   6C87 4E            [ 7]  217 	ld	c,(hl)
   6C88 23            [ 6]  218 	inc	hl
   6C89 66            [ 7]  219 	ld	h,(hl)
   6C8A 69            [ 4]  220 	ld	l, c
   6C8B CD A6 8E      [17]  221 	call	___sdcc_call_hl
   6C8E 18 DC         [12]  222 	jr	00101$
   6C90                     223 00103$:
                            224 ;src/StateManager.c:83: *(u8*)&inputReceived=0;
   6C90 21 09 6C      [10]  225 	ld	hl,#_inputReceived
   6C93 36 00         [10]  226 	ld	(hl),#0x00
   6C95 C9            [10]  227 	ret
                            228 ;src/StateManager.c:86: void statemanager_render_state(){
                            229 ;	---------------------------------
                            230 ; Function statemanager_render_state
                            231 ; ---------------------------------
   6C96                     232 _statemanager_render_state::
                            233 ;src/StateManager.c:87: stateArray[currentState].renderState();
   6C96 01 E9 6B      [10]  234 	ld	bc,#_stateArray+0
   6C99 21 07 6C      [10]  235 	ld	hl,#_currentState + 0
   6C9C 5E            [ 7]  236 	ld	e, (hl)
   6C9D 16 00         [ 7]  237 	ld	d,#0x00
   6C9F 6B            [ 4]  238 	ld	l, e
   6CA0 62            [ 4]  239 	ld	h, d
   6CA1 29            [11]  240 	add	hl, hl
   6CA2 29            [11]  241 	add	hl, hl
   6CA3 19            [11]  242 	add	hl, de
   6CA4 29            [11]  243 	add	hl, hl
   6CA5 09            [11]  244 	add	hl,bc
   6CA6 11 06 00      [10]  245 	ld	de, #0x0006
   6CA9 19            [11]  246 	add	hl, de
   6CAA 4E            [ 7]  247 	ld	c,(hl)
   6CAB 23            [ 6]  248 	inc	hl
   6CAC 66            [ 7]  249 	ld	h,(hl)
   6CAD 69            [ 4]  250 	ld	l, c
   6CAE C3 A6 8E      [10]  251 	jp  ___sdcc_call_hl
                            252 ;src/StateManager.c:90: void statemanager_close_state(u8 state){
                            253 ;	---------------------------------
                            254 ; Function statemanager_close_state
                            255 ; ---------------------------------
   6CB1                     256 _statemanager_close_state::
   6CB1 DD E5         [15]  257 	push	ix
   6CB3 DD 21 00 00   [14]  258 	ld	ix,#0
   6CB7 DD 39         [15]  259 	add	ix,sp
                            260 ;src/StateManager.c:91: stateArray[state].exitState();
   6CB9 01 E9 6B      [10]  261 	ld	bc,#_stateArray+0
   6CBC DD 5E 04      [19]  262 	ld	e,4 (ix)
   6CBF 16 00         [ 7]  263 	ld	d,#0x00
   6CC1 6B            [ 4]  264 	ld	l, e
   6CC2 62            [ 4]  265 	ld	h, d
   6CC3 29            [11]  266 	add	hl, hl
   6CC4 29            [11]  267 	add	hl, hl
   6CC5 19            [11]  268 	add	hl, de
   6CC6 29            [11]  269 	add	hl, hl
   6CC7 09            [11]  270 	add	hl,bc
   6CC8 11 08 00      [10]  271 	ld	de, #0x0008
   6CCB 19            [11]  272 	add	hl, de
   6CCC 4E            [ 7]  273 	ld	c,(hl)
   6CCD 23            [ 6]  274 	inc	hl
   6CCE 66            [ 7]  275 	ld	h,(hl)
   6CCF 69            [ 4]  276 	ld	l, c
   6CD0 DD E1         [14]  277 	pop	ix
   6CD2 C3 A6 8E      [10]  278 	jp	___sdcc_call_hl
                            279 ;src/StateManager.c:94: void statemanager_update_state(){
                            280 ;	---------------------------------
                            281 ; Function statemanager_update_state
                            282 ; ---------------------------------
   6CD5                     283 _statemanager_update_state::
                            284 ;src/StateManager.c:95: stateArray[currentState].updateState();
   6CD5 01 E9 6B      [10]  285 	ld	bc,#_stateArray+0
   6CD8 21 07 6C      [10]  286 	ld	hl,#_currentState + 0
   6CDB 5E            [ 7]  287 	ld	e, (hl)
   6CDC 16 00         [ 7]  288 	ld	d,#0x00
   6CDE 6B            [ 4]  289 	ld	l, e
   6CDF 62            [ 4]  290 	ld	h, d
   6CE0 29            [11]  291 	add	hl, hl
   6CE1 29            [11]  292 	add	hl, hl
   6CE2 19            [11]  293 	add	hl, de
   6CE3 29            [11]  294 	add	hl, hl
   6CE4 09            [11]  295 	add	hl,bc
   6CE5 11 04 00      [10]  296 	ld	de, #0x0004
   6CE8 19            [11]  297 	add	hl, de
   6CE9 4E            [ 7]  298 	ld	c,(hl)
   6CEA 23            [ 6]  299 	inc	hl
   6CEB 66            [ 7]  300 	ld	h,(hl)
   6CEC 69            [ 4]  301 	ld	l, c
   6CED C3 A6 8E      [10]  302 	jp  ___sdcc_call_hl
                            303 ;src/StateManager.c:98: void statemanager_main_loop(){
                            304 ;	---------------------------------
                            305 ; Function statemanager_main_loop
                            306 ; ---------------------------------
   6CF0                     307 _statemanager_main_loop::
                            308 ;src/StateManager.c:99: while(1) {
   6CF0                     309 00102$:
                            310 ;src/StateManager.c:100: statemanager_change_state();
   6CF0 CD BE 6B      [17]  311 	call	_statemanager_change_state
                            312 ;src/StateManager.c:101: statemanager_manage_input();
   6CF3 CD 6C 6C      [17]  313 	call	_statemanager_manage_input
                            314 ;src/StateManager.c:102: statemanager_update_state();
   6CF6 CD D5 6C      [17]  315 	call	_statemanager_update_state
                            316 ;src/StateManager.c:103: statemanager_render_state();
   6CF9 CD 96 6C      [17]  317 	call	_statemanager_render_state
   6CFC 18 F2         [12]  318 	jr	00102$
                            319 	.area _CODE
                            320 	.area _INITIALIZER
   911E                     321 __xinit__last_keyboardStatusBuffer:
   911E FF                  322 	.db #0xFF	; 255
   911F FF                  323 	.db #0xFF	; 255
   9120 FF                  324 	.db #0xFF	; 255
   9121 FF                  325 	.db #0xFF	; 255
   9122 FF                  326 	.db #0xFF	; 255
   9123 FF                  327 	.db #0xFF	; 255
   9124 FF                  328 	.db #0xFF	; 255
   9125 FF                  329 	.db #0xFF	; 255
   9126 FF                  330 	.db #0xFF	; 255
   9127 FF                  331 	.db #0xFF	; 255
                            332 	.area _CABS (ABS)
