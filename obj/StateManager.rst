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
                             57 ;src/StateManager.c:52: void statemanager_change_state(){
                             58 ;	---------------------------------
                             59 ; Function statemanager_change_state
                             60 ; ---------------------------------
   1C14                      61 _statemanager_change_state::
                             62 ;src/StateManager.c:53: if(changeToState){
   1C14 21 5E 1C      [10]   63 	ld	hl,#_changeToState + 0
   1C17 4E            [ 7]   64 	ld	c, (hl)
   1C18 3A 5E 1C      [13]   65 	ld	a,(#_changeToState + 0)
   1C1B B7            [ 4]   66 	or	a, a
   1C1C C8            [11]   67 	ret	Z
                             68 ;src/StateManager.c:54: *(u8*)&currentState = changeToState-1;
   1C1D 21 5D 1C      [10]   69 	ld	hl,#_currentState+0
   1C20 0D            [ 4]   70 	dec	c
   1C21 71            [ 7]   71 	ld	(hl),c
                             72 ;src/StateManager.c:55: stateArray[currentState].enterState();
   1C22 01 3F 1C      [10]   73 	ld	bc,#_stateArray+0
   1C25 21 5D 1C      [10]   74 	ld	hl,#_currentState + 0
   1C28 5E            [ 7]   75 	ld	e, (hl)
   1C29 16 00         [ 7]   76 	ld	d,#0x00
   1C2B 6B            [ 4]   77 	ld	l, e
   1C2C 62            [ 4]   78 	ld	h, d
   1C2D 29            [11]   79 	add	hl, hl
   1C2E 29            [11]   80 	add	hl, hl
   1C2F 19            [11]   81 	add	hl, de
   1C30 29            [11]   82 	add	hl, hl
   1C31 09            [11]   83 	add	hl,bc
   1C32 4E            [ 7]   84 	ld	c,(hl)
   1C33 23            [ 6]   85 	inc	hl
   1C34 66            [ 7]   86 	ld	h,(hl)
   1C35 69            [ 4]   87 	ld	l, c
   1C36 CD 1A 3F      [17]   88 	call	___sdcc_call_hl
                             89 ;src/StateManager.c:56: *(u8*)&changeToState = 0;
   1C39 21 5E 1C      [10]   90 	ld	hl,#_changeToState
   1C3C 36 00         [10]   91 	ld	(hl),#0x00
   1C3E C9            [10]   92 	ret
   1C3F                      93 _stateArray:
   1C3F EA 1B                94 	.dw _state_mainmenu_enter
   1C41 ED 1B                95 	.dw _state_mainmenu_input
   1C43 01 1C                96 	.dw _state_mainmenu_update
   1C45 02 1C                97 	.dw _state_mainmenu_render
   1C47 13 1C                98 	.dw _state_mainmenu_exit
   1C49 3B 1A                99 	.dw _state_ingame_enter
   1C4B 6F 1A               100 	.dw _state_ingame_input
   1C4D E7 1A               101 	.dw _state_ingame_update
   1C4F BF 1B               102 	.dw _state_ingame_render
   1C51 E4 1B               103 	.dw _state_ingame_exit
   1C53 5E 1D               104 	.dw _state_pausemenu_enter
   1C55 85 1D               105 	.dw _state_pausemenu_input
   1C57 B5 1D               106 	.dw _state_pausemenu_update
   1C59 B6 1D               107 	.dw _state_pausemenu_render
   1C5B B7 1D               108 	.dw _state_pausemenu_exit
   1C5D                     109 _currentState:
   1C5D 00                  110 	.db #0x00	; 0
   1C5E                     111 _changeToState:
   1C5E 00                  112 	.db #0x00	; 0
   1C5F                     113 _inputReceived:
   1C5F 00                  114 	.db #0x00	; 0
   1C60                     115 _last_keyboardStatusBuffer:
   1C60 FF                  116 	.db #0xFF	; 255
   1C61 FF                  117 	.db #0xFF	; 255
   1C62 FF                  118 	.db #0xFF	; 255
   1C63 FF                  119 	.db #0xFF	; 255
   1C64 FF                  120 	.db #0xFF	; 255
   1C65 FF                  121 	.db #0xFF	; 255
   1C66 FF                  122 	.db #0xFF	; 255
   1C67 FF                  123 	.db #0xFF	; 255
   1C68 FF                  124 	.db #0xFF	; 255
   1C69 FF                  125 	.db #0xFF	; 255
                            126 ;src/StateManager.c:60: void statemanager_input_accepted(){
                            127 ;	---------------------------------
                            128 ; Function statemanager_input_accepted
                            129 ; ---------------------------------
   1C6A                     130 _statemanager_input_accepted::
                            131 ;src/StateManager.c:61: *(u8*)&inputReceived=1;
   1C6A 21 5F 1C      [10]  132 	ld	hl,#_inputReceived
   1C6D 36 01         [10]  133 	ld	(hl),#0x01
   1C6F C9            [10]  134 	ret
                            135 ;src/StateManager.c:64: void statemanager_set_state(u8 state){
                            136 ;	---------------------------------
                            137 ; Function statemanager_set_state
                            138 ; ---------------------------------
   1C70                     139 _statemanager_set_state::
                            140 ;src/StateManager.c:65: *(u8*)&changeToState = state+1;
   1C70 01 5E 1C      [10]  141 	ld	bc,#_changeToState+0
   1C73 21 02 00      [10]  142 	ld	hl, #2+0
   1C76 39            [11]  143 	add	hl, sp
   1C77 7E            [ 7]  144 	ld	a, (hl)
   1C78 3C            [ 4]  145 	inc	a
   1C79 02            [ 7]  146 	ld	(bc),a
   1C7A C9            [10]  147 	ret
                            148 ;src/StateManager.c:68: void scan_input(){
                            149 ;	---------------------------------
                            150 ; Function scan_input
                            151 ; ---------------------------------
   1C7B                     152 _scan_input::
   1C7B DD E5         [15]  153 	push	ix
   1C7D DD 21 00 00   [14]  154 	ld	ix,#0
   1C81 DD 39         [15]  155 	add	ix,sp
   1C83 F5            [11]  156 	push	af
   1C84 F5            [11]  157 	push	af
   1C85 3B            [ 6]  158 	dec	sp
                            159 ;src/StateManager.c:69: u8 t,n=10, anyKeyPressed=0xFF;
   1C86 DD 36 FD FF   [19]  160 	ld	-3 (ix),#0xFF
                            161 ;src/StateManager.c:70: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
                            162 ;src/StateManager.c:71: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
                            163 ;src/StateManager.c:73: cpct_scanKeyboard_f();
   1C8A CD 46 3D      [17]  164 	call	_cpct_scanKeyboard_f
                            165 ;src/StateManager.c:74: while(n){
   1C8D DD 36 FB 0A   [19]  166 	ld	-5 (ix),#0x0A
   1C91 01 BD 3E      [10]  167 	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
   1C94 11 6A 1C      [10]  168 	ld	de,#(_last_keyboardStatusBuffer + 0x000a)
   1C97                     169 00101$:
   1C97 DD 7E FB      [19]  170 	ld	a,-5 (ix)
   1C9A B7            [ 4]  171 	or	a, a
   1C9B 28 2A         [12]  172 	jr	Z,00104$
                            173 ;src/StateManager.c:75: --n;
   1C9D DD 35 FB      [23]  174 	dec	-5 (ix)
                            175 ;src/StateManager.c:76: --currentStatus;
   1CA0 0B            [ 6]  176 	dec	bc
                            177 ;src/StateManager.c:77: --lastStatus;
   1CA1 1B            [ 6]  178 	dec	de
                            179 ;src/StateManager.c:79: t=*(currentStatus);
   1CA2 0A            [ 7]  180 	ld	a,(bc)
   1CA3 DD 77 FC      [19]  181 	ld	-4 (ix),a
                            182 ;src/StateManager.c:80: anyKeyPressed&=t;
   1CA6 DD 7E FD      [19]  183 	ld	a,-3 (ix)
   1CA9 DD A6 FC      [19]  184 	and	a, -4 (ix)
   1CAC DD 77 FD      [19]  185 	ld	-3 (ix),a
                            186 ;src/StateManager.c:81: *currentStatus=((*lastStatus)|(~t));
   1CAF 1A            [ 7]  187 	ld	a,(de)
   1CB0 DD 77 FE      [19]  188 	ld	-2 (ix),a
   1CB3 DD 7E FC      [19]  189 	ld	a,-4 (ix)
   1CB6 2F            [ 4]  190 	cpl
   1CB7 DD 77 FF      [19]  191 	ld	-1 (ix),a
   1CBA DD 7E FE      [19]  192 	ld	a,-2 (ix)
   1CBD DD B6 FF      [19]  193 	or	a, -1 (ix)
   1CC0 02            [ 7]  194 	ld	(bc),a
                            195 ;src/StateManager.c:82: *lastStatus=t;
   1CC1 DD 7E FC      [19]  196 	ld	a,-4 (ix)
   1CC4 12            [ 7]  197 	ld	(de),a
   1CC5 18 D0         [12]  198 	jr	00101$
   1CC7                     199 00104$:
   1CC7 DD F9         [10]  200 	ld	sp, ix
   1CC9 DD E1         [14]  201 	pop	ix
   1CCB C9            [10]  202 	ret
                            203 ;src/StateManager.c:89: void statemanager_manage_input(){
                            204 ;	---------------------------------
                            205 ; Function statemanager_manage_input
                            206 ; ---------------------------------
   1CCC                     207 _statemanager_manage_input::
                            208 ;src/StateManager.c:90: while(!inputReceived){
   1CCC                     209 00101$:
   1CCC 3A 5F 1C      [13]  210 	ld	a,(#_inputReceived + 0)
   1CCF B7            [ 4]  211 	or	a, a
   1CD0 20 1E         [12]  212 	jr	NZ,00103$
                            213 ;src/StateManager.c:91: scan_input();
   1CD2 CD 7B 1C      [17]  214 	call	_scan_input
                            215 ;src/StateManager.c:92: stateArray[currentState].inputState();
   1CD5 21 5D 1C      [10]  216 	ld	hl,#_currentState + 0
   1CD8 4E            [ 7]  217 	ld	c, (hl)
   1CD9 06 00         [ 7]  218 	ld	b,#0x00
   1CDB 69            [ 4]  219 	ld	l, c
   1CDC 60            [ 4]  220 	ld	h, b
   1CDD 29            [11]  221 	add	hl, hl
   1CDE 29            [11]  222 	add	hl, hl
   1CDF 09            [11]  223 	add	hl, bc
   1CE0 29            [11]  224 	add	hl, hl
   1CE1 11 3F 1C      [10]  225 	ld	de,#_stateArray
   1CE4 19            [11]  226 	add	hl,de
   1CE5 23            [ 6]  227 	inc	hl
   1CE6 23            [ 6]  228 	inc	hl
   1CE7 4E            [ 7]  229 	ld	c,(hl)
   1CE8 23            [ 6]  230 	inc	hl
   1CE9 66            [ 7]  231 	ld	h,(hl)
   1CEA 69            [ 4]  232 	ld	l, c
   1CEB CD 1A 3F      [17]  233 	call	___sdcc_call_hl
   1CEE 18 DC         [12]  234 	jr	00101$
   1CF0                     235 00103$:
                            236 ;src/StateManager.c:94: *(u8*)&inputReceived=0;
   1CF0 21 5F 1C      [10]  237 	ld	hl,#_inputReceived
   1CF3 36 00         [10]  238 	ld	(hl),#0x00
   1CF5 C9            [10]  239 	ret
                            240 ;src/StateManager.c:97: void statemanager_render_state(){
                            241 ;	---------------------------------
                            242 ; Function statemanager_render_state
                            243 ; ---------------------------------
   1CF6                     244 _statemanager_render_state::
                            245 ;src/StateManager.c:98: stateArray[currentState].renderState();
   1CF6 01 3F 1C      [10]  246 	ld	bc,#_stateArray+0
   1CF9 21 5D 1C      [10]  247 	ld	hl,#_currentState + 0
   1CFC 5E            [ 7]  248 	ld	e, (hl)
   1CFD 16 00         [ 7]  249 	ld	d,#0x00
   1CFF 6B            [ 4]  250 	ld	l, e
   1D00 62            [ 4]  251 	ld	h, d
   1D01 29            [11]  252 	add	hl, hl
   1D02 29            [11]  253 	add	hl, hl
   1D03 19            [11]  254 	add	hl, de
   1D04 29            [11]  255 	add	hl, hl
   1D05 09            [11]  256 	add	hl,bc
   1D06 11 06 00      [10]  257 	ld	de, #0x0006
   1D09 19            [11]  258 	add	hl, de
   1D0A 4E            [ 7]  259 	ld	c,(hl)
   1D0B 23            [ 6]  260 	inc	hl
   1D0C 66            [ 7]  261 	ld	h,(hl)
   1D0D 69            [ 4]  262 	ld	l, c
   1D0E C3 1A 3F      [10]  263 	jp  ___sdcc_call_hl
                            264 ;src/StateManager.c:101: void statemanager_close_state(u8 state){
                            265 ;	---------------------------------
                            266 ; Function statemanager_close_state
                            267 ; ---------------------------------
   1D11                     268 _statemanager_close_state::
   1D11 DD E5         [15]  269 	push	ix
   1D13 DD 21 00 00   [14]  270 	ld	ix,#0
   1D17 DD 39         [15]  271 	add	ix,sp
                            272 ;src/StateManager.c:102: stateArray[state].exitState();
   1D19 01 3F 1C      [10]  273 	ld	bc,#_stateArray+0
   1D1C DD 5E 04      [19]  274 	ld	e,4 (ix)
   1D1F 16 00         [ 7]  275 	ld	d,#0x00
   1D21 6B            [ 4]  276 	ld	l, e
   1D22 62            [ 4]  277 	ld	h, d
   1D23 29            [11]  278 	add	hl, hl
   1D24 29            [11]  279 	add	hl, hl
   1D25 19            [11]  280 	add	hl, de
   1D26 29            [11]  281 	add	hl, hl
   1D27 09            [11]  282 	add	hl,bc
   1D28 11 08 00      [10]  283 	ld	de, #0x0008
   1D2B 19            [11]  284 	add	hl, de
   1D2C 4E            [ 7]  285 	ld	c,(hl)
   1D2D 23            [ 6]  286 	inc	hl
   1D2E 66            [ 7]  287 	ld	h,(hl)
   1D2F 69            [ 4]  288 	ld	l, c
   1D30 DD E1         [14]  289 	pop	ix
   1D32 C3 1A 3F      [10]  290 	jp	___sdcc_call_hl
                            291 ;src/StateManager.c:105: void statemanager_update_state(){
                            292 ;	---------------------------------
                            293 ; Function statemanager_update_state
                            294 ; ---------------------------------
   1D35                     295 _statemanager_update_state::
                            296 ;src/StateManager.c:106: stateArray[currentState].updateState();
   1D35 01 3F 1C      [10]  297 	ld	bc,#_stateArray+0
   1D38 21 5D 1C      [10]  298 	ld	hl,#_currentState + 0
   1D3B 5E            [ 7]  299 	ld	e, (hl)
   1D3C 16 00         [ 7]  300 	ld	d,#0x00
   1D3E 6B            [ 4]  301 	ld	l, e
   1D3F 62            [ 4]  302 	ld	h, d
   1D40 29            [11]  303 	add	hl, hl
   1D41 29            [11]  304 	add	hl, hl
   1D42 19            [11]  305 	add	hl, de
   1D43 29            [11]  306 	add	hl, hl
   1D44 09            [11]  307 	add	hl,bc
   1D45 11 04 00      [10]  308 	ld	de, #0x0004
   1D48 19            [11]  309 	add	hl, de
   1D49 4E            [ 7]  310 	ld	c,(hl)
   1D4A 23            [ 6]  311 	inc	hl
   1D4B 66            [ 7]  312 	ld	h,(hl)
   1D4C 69            [ 4]  313 	ld	l, c
   1D4D C3 1A 3F      [10]  314 	jp  ___sdcc_call_hl
                            315 ;src/StateManager.c:109: void statemanager_main_loop(){
                            316 ;	---------------------------------
                            317 ; Function statemanager_main_loop
                            318 ; ---------------------------------
   1D50                     319 _statemanager_main_loop::
                            320 ;src/StateManager.c:110: while(1) {
   1D50                     321 00102$:
                            322 ;src/StateManager.c:111: statemanager_change_state();
   1D50 CD 14 1C      [17]  323 	call	_statemanager_change_state
                            324 ;src/StateManager.c:112: statemanager_manage_input();
   1D53 CD CC 1C      [17]  325 	call	_statemanager_manage_input
                            326 ;src/StateManager.c:113: statemanager_update_state();
   1D56 CD 35 1D      [17]  327 	call	_statemanager_update_state
                            328 ;src/StateManager.c:114: statemanager_render_state();
   1D59 CD F6 1C      [17]  329 	call	_statemanager_render_state
   1D5C 18 F2         [12]  330 	jr	00102$
                            331 	.area _CODE
                            332 	.area _INITIALIZER
                            333 	.area _CABS (ABS)
