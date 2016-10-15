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
                             14 	.globl _scan_input
                             15 	.globl _statemanager_change_state
                             16 	.globl _statemanager_drop_state
                             17 	.globl _cpct_waitVSYNC
                             18 	.globl _cpct_scanKeyboard_f
                             19 	.globl _last_keyboardStatusBuffer
                             20 	.globl _gameRunning
                             21 	.globl _inputReceived
                             22 	.globl _changeToState
                             23 	.globl _currentState
                             24 	.globl _closeState
                             25 	.globl _stateArray
                             26 	.globl _statemanager_input_accepted
                             27 	.globl _statemanager_set_state
                             28 	.globl _statemanager_close_state
                             29 	.globl _statemanager_exit_game
                             30 	.globl _statemanager_main_loop
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
                             62 ;src/StateManager.c:84: void statemanager_drop_state(){
                             63 ;	---------------------------------
                             64 ; Function statemanager_drop_state
                             65 ; ---------------------------------
   1C99                      66 _statemanager_drop_state::
                             67 ;src/StateManager.c:85: if(closeState){
   1C99 3A 27 1D      [13]   68 	ld	a,(#_closeState + 0)
   1C9C B7            [ 4]   69 	or	a, a
   1C9D C8            [11]   70 	ret	Z
                             71 ;src/StateManager.c:86: stateArray[currentState].exitState();
   1C9E 01 EF 1C      [10]   72 	ld	bc,#_stateArray+0
   1CA1 21 28 1D      [10]   73 	ld	hl,#_currentState + 0
   1CA4 5E            [ 7]   74 	ld	e, (hl)
   1CA5 16 00         [ 7]   75 	ld	d,#0x00
   1CA7 6B            [ 4]   76 	ld	l, e
   1CA8 62            [ 4]   77 	ld	h, d
   1CA9 29            [11]   78 	add	hl, hl
   1CAA 19            [11]   79 	add	hl, de
   1CAB 29            [11]   80 	add	hl, hl
   1CAC 19            [11]   81 	add	hl, de
   1CAD 29            [11]   82 	add	hl, hl
   1CAE 09            [11]   83 	add	hl,bc
   1CAF 11 0C 00      [10]   84 	ld	de, #0x000C
   1CB2 19            [11]   85 	add	hl, de
   1CB3 5E            [ 7]   86 	ld	e,(hl)
   1CB4 23            [ 6]   87 	inc	hl
   1CB5 66            [ 7]   88 	ld	h,(hl)
   1CB6 C5            [11]   89 	push	bc
   1CB7 6B            [ 4]   90 	ld	l, e
   1CB8 CD 62 48      [17]   91 	call	___sdcc_call_hl
   1CBB C1            [10]   92 	pop	bc
                             93 ;src/StateManager.c:87: *(u8*)&currentState = stateArray[currentState].lastStateid;
   1CBC 21 28 1D      [10]   94 	ld	hl,#_currentState + 0
   1CBF 5E            [ 7]   95 	ld	e, (hl)
   1CC0 16 00         [ 7]   96 	ld	d,#0x00
   1CC2 6B            [ 4]   97 	ld	l, e
   1CC3 62            [ 4]   98 	ld	h, d
   1CC4 29            [11]   99 	add	hl, hl
   1CC5 19            [11]  100 	add	hl, de
   1CC6 29            [11]  101 	add	hl, hl
   1CC7 19            [11]  102 	add	hl, de
   1CC8 29            [11]  103 	add	hl, hl
   1CC9 09            [11]  104 	add	hl,bc
   1CCA 23            [ 6]  105 	inc	hl
   1CCB 5E            [ 7]  106 	ld	e,(hl)
   1CCC 21 28 1D      [10]  107 	ld	hl,#_currentState
   1CCF 73            [ 7]  108 	ld	(hl),e
                            109 ;src/StateManager.c:88: stateArray[currentState].returnState();
   1CD0 21 28 1D      [10]  110 	ld	hl,#_currentState + 0
   1CD3 5E            [ 7]  111 	ld	e, (hl)
   1CD4 16 00         [ 7]  112 	ld	d,#0x00
   1CD6 6B            [ 4]  113 	ld	l, e
   1CD7 62            [ 4]  114 	ld	h, d
   1CD8 29            [11]  115 	add	hl, hl
   1CD9 19            [11]  116 	add	hl, de
   1CDA 29            [11]  117 	add	hl, hl
   1CDB 19            [11]  118 	add	hl, de
   1CDC 29            [11]  119 	add	hl, hl
   1CDD 09            [11]  120 	add	hl,bc
   1CDE 11 04 00      [10]  121 	ld	de, #0x0004
   1CE1 19            [11]  122 	add	hl, de
   1CE2 7E            [ 7]  123 	ld	a, (hl)
   1CE3 23            [ 6]  124 	inc	hl
   1CE4 66            [ 7]  125 	ld	h,(hl)
   1CE5 6F            [ 4]  126 	ld	l,a
   1CE6 CD 62 48      [17]  127 	call	___sdcc_call_hl
                            128 ;src/StateManager.c:89: *(u8*)&closeState=0;
   1CE9 21 27 1D      [10]  129 	ld	hl,#_closeState
   1CEC 36 00         [10]  130 	ld	(hl),#0x00
   1CEE C9            [10]  131 	ret
   1CEF                     132 _stateArray:
   1CEF 00                  133 	.db #0x00	; 0
   1CF0 00                  134 	.db #0x00	; 0
   1CF1 EA 1B               135 	.dw _state_mainmenu_enter
   1CF3 1D 1C               136 	.dw _state_mainmenu_return
   1CF5 20 1C               137 	.dw _state_mainmenu_input
   1CF7 4F 1C               138 	.dw _state_mainmenu_update
   1CF9 95 1C               139 	.dw _state_mainmenu_render
   1CFB 98 1C               140 	.dw _state_mainmenu_exit
   1CFD 01                  141 	.db #0x01	; 1
   1CFE 00                  142 	.db #0x00	; 0
   1CFF 39 1A               143 	.dw _state_ingame_enter
   1D01 54 1A               144 	.dw _state_ingame_return
   1D03 5A 1A               145 	.dw _state_ingame_input
   1D05 C3 1A               146 	.dw _state_ingame_update
   1D07 7B 1B               147 	.dw _state_ingame_render
   1D09 A3 1B               148 	.dw _state_ingame_exit
   1D0B 02                  149 	.db #0x02	; 2
   1D0C 00                  150 	.db #0x00	; 0
   1D0D 71 1E               151 	.dw _state_pausemenu_enter
   1D0F 9F 1E               152 	.dw _state_pausemenu_return
   1D11 A2 1E               153 	.dw _state_pausemenu_input
   1D13 D1 1E               154 	.dw _state_pausemenu_update
   1D15 11 1F               155 	.dw _state_pausemenu_render
   1D17 14 1F               156 	.dw _state_pausemenu_exit
   1D19 03                  157 	.db #0x03	; 3
   1D1A 00                  158 	.db #0x00	; 0
   1D1B A4 1B               159 	.dw _state_loadlevel_enter
   1D1D DB 1B               160 	.dw _state_loadlevel_return
   1D1F DC 1B               161 	.dw _state_loadlevel_input
   1D21 DF 1B               162 	.dw _state_loadlevel_update
   1D23 E8 1B               163 	.dw _state_loadlevel_render
   1D25 E9 1B               164 	.dw _state_loadlevel_exit
   1D27                     165 _closeState:
   1D27 00                  166 	.db #0x00	; 0
   1D28                     167 _currentState:
   1D28 00                  168 	.db #0x00	; 0
   1D29                     169 _changeToState:
   1D29 00                  170 	.db #0x00	; 0
   1D2A                     171 _inputReceived:
   1D2A 00                  172 	.db #0x00	; 0
   1D2B                     173 _gameRunning:
   1D2B 01                  174 	.db #0x01	; 1
   1D2C                     175 _last_keyboardStatusBuffer:
   1D2C FF                  176 	.db #0xFF	; 255
   1D2D FF                  177 	.db #0xFF	; 255
   1D2E FF                  178 	.db #0xFF	; 255
   1D2F FF                  179 	.db #0xFF	; 255
   1D30 FF                  180 	.db #0xFF	; 255
   1D31 FF                  181 	.db #0xFF	; 255
   1D32 FF                  182 	.db #0xFF	; 255
   1D33 FF                  183 	.db #0xFF	; 255
   1D34 FF                  184 	.db #0xFF	; 255
   1D35 FF                  185 	.db #0xFF	; 255
                            186 ;src/StateManager.c:93: void statemanager_change_state(){
                            187 ;	---------------------------------
                            188 ; Function statemanager_change_state
                            189 ; ---------------------------------
   1D36                     190 _statemanager_change_state::
                            191 ;src/StateManager.c:94: if(changeToState){
   1D36 21 29 1D      [10]  192 	ld	hl,#_changeToState + 0
   1D39 4E            [ 7]  193 	ld	c, (hl)
   1D3A 3A 29 1D      [13]  194 	ld	a,(#_changeToState + 0)
   1D3D B7            [ 4]  195 	or	a, a
   1D3E C8            [11]  196 	ret	Z
                            197 ;src/StateManager.c:95: *(u8*)&(stateArray[changeToState-1].lastStateid) = currentState;
   1D3F 11 EF 1C      [10]  198 	ld	de,#_stateArray+0
   1D42 0D            [ 4]  199 	dec	c
   1D43 06 00         [ 7]  200 	ld	b,#0x00
   1D45 69            [ 4]  201 	ld	l, c
   1D46 60            [ 4]  202 	ld	h, b
   1D47 29            [11]  203 	add	hl, hl
   1D48 09            [11]  204 	add	hl, bc
   1D49 29            [11]  205 	add	hl, hl
   1D4A 09            [11]  206 	add	hl, bc
   1D4B 29            [11]  207 	add	hl, hl
   1D4C 19            [11]  208 	add	hl,de
   1D4D 23            [ 6]  209 	inc	hl
   1D4E FD 21 28 1D   [14]  210 	ld	iy,#_currentState
   1D52 FD 4E 00      [19]  211 	ld	c,0 (iy)
   1D55 71            [ 7]  212 	ld	(hl),c
                            213 ;src/StateManager.c:96: *(u8*)&currentState = changeToState-1;
   1D56 21 28 1D      [10]  214 	ld	hl,#_currentState+0
   1D59 FD 21 29 1D   [14]  215 	ld	iy,#_changeToState
   1D5D FD 4E 00      [19]  216 	ld	c,0 (iy)
   1D60 0D            [ 4]  217 	dec	c
   1D61 71            [ 7]  218 	ld	(hl),c
                            219 ;src/StateManager.c:97: stateArray[currentState].enterState();
   1D62 21 28 1D      [10]  220 	ld	hl,#_currentState + 0
   1D65 4E            [ 7]  221 	ld	c, (hl)
   1D66 06 00         [ 7]  222 	ld	b,#0x00
   1D68 69            [ 4]  223 	ld	l, c
   1D69 60            [ 4]  224 	ld	h, b
   1D6A 29            [11]  225 	add	hl, hl
   1D6B 09            [11]  226 	add	hl, bc
   1D6C 29            [11]  227 	add	hl, hl
   1D6D 09            [11]  228 	add	hl, bc
   1D6E 29            [11]  229 	add	hl, hl
   1D6F 19            [11]  230 	add	hl,de
   1D70 23            [ 6]  231 	inc	hl
   1D71 23            [ 6]  232 	inc	hl
   1D72 4E            [ 7]  233 	ld	c,(hl)
   1D73 23            [ 6]  234 	inc	hl
   1D74 66            [ 7]  235 	ld	h,(hl)
   1D75 69            [ 4]  236 	ld	l, c
   1D76 CD 62 48      [17]  237 	call	___sdcc_call_hl
                            238 ;src/StateManager.c:98: *(u8*)&changeToState = 0;
   1D79 21 29 1D      [10]  239 	ld	hl,#_changeToState
   1D7C 36 00         [10]  240 	ld	(hl),#0x00
   1D7E C9            [10]  241 	ret
                            242 ;src/StateManager.c:102: void statemanager_input_accepted(){
                            243 ;	---------------------------------
                            244 ; Function statemanager_input_accepted
                            245 ; ---------------------------------
   1D7F                     246 _statemanager_input_accepted::
                            247 ;src/StateManager.c:103: *(u8*)&inputReceived=1;
   1D7F 21 2A 1D      [10]  248 	ld	hl,#_inputReceived
   1D82 36 01         [10]  249 	ld	(hl),#0x01
   1D84 C9            [10]  250 	ret
                            251 ;src/StateManager.c:106: void statemanager_set_state(u8 state){
                            252 ;	---------------------------------
                            253 ; Function statemanager_set_state
                            254 ; ---------------------------------
   1D85                     255 _statemanager_set_state::
                            256 ;src/StateManager.c:107: *(u8*)&changeToState = state+1;
   1D85 01 29 1D      [10]  257 	ld	bc,#_changeToState+0
   1D88 21 02 00      [10]  258 	ld	hl, #2+0
   1D8B 39            [11]  259 	add	hl, sp
   1D8C 7E            [ 7]  260 	ld	a, (hl)
   1D8D 3C            [ 4]  261 	inc	a
   1D8E 02            [ 7]  262 	ld	(bc),a
   1D8F C9            [10]  263 	ret
                            264 ;src/StateManager.c:110: void scan_input(){
                            265 ;	---------------------------------
                            266 ; Function scan_input
                            267 ; ---------------------------------
   1D90                     268 _scan_input::
   1D90 DD E5         [15]  269 	push	ix
   1D92 DD 21 00 00   [14]  270 	ld	ix,#0
   1D96 DD 39         [15]  271 	add	ix,sp
   1D98 F5            [11]  272 	push	af
   1D99 3B            [ 6]  273 	dec	sp
                            274 ;src/StateManager.c:111: u8 t,n=10, anyKeyPressed=0xFF;
   1D9A DD 36 FD FF   [19]  275 	ld	-3 (ix),#0xFF
                            276 ;src/StateManager.c:112: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
                            277 ;src/StateManager.c:113: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
                            278 ;src/StateManager.c:115: cpct_scanKeyboard_f();
   1D9E CD 8E 46      [17]  279 	call	_cpct_scanKeyboard_f
                            280 ;src/StateManager.c:116: while(n){
   1DA1 1E 0A         [ 7]  281 	ld	e,#0x0A
   1DA3 01 46 48      [10]  282 	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
   1DA6 FD 21 36 1D   [14]  283 	ld	iy,#(_last_keyboardStatusBuffer + 0x000a)
   1DAA                     284 00101$:
   1DAA 7B            [ 4]  285 	ld	a,e
   1DAB B7            [ 4]  286 	or	a, a
   1DAC 28 24         [12]  287 	jr	Z,00103$
                            288 ;src/StateManager.c:117: --n;
   1DAE 1D            [ 4]  289 	dec	e
                            290 ;src/StateManager.c:118: --currentStatus;
   1DAF 0B            [ 6]  291 	dec	bc
                            292 ;src/StateManager.c:119: --lastStatus;
   1DB0 FD 2B         [10]  293 	dec	iy
                            294 ;src/StateManager.c:121: t=*(currentStatus);
   1DB2 0A            [ 7]  295 	ld	a,(bc)
   1DB3 57            [ 4]  296 	ld	d,a
                            297 ;src/StateManager.c:122: anyKeyPressed&=t;
   1DB4 DD 7E FD      [19]  298 	ld	a,-3 (ix)
   1DB7 A2            [ 4]  299 	and	a, d
   1DB8 DD 77 FD      [19]  300 	ld	-3 (ix),a
                            301 ;src/StateManager.c:123: *currentStatus=((*lastStatus)|(~t));
   1DBB FD 7E 00      [19]  302 	ld	a, 0 (iy)
   1DBE DD 77 FF      [19]  303 	ld	-1 (ix),a
   1DC1 7A            [ 4]  304 	ld	a,d
   1DC2 2F            [ 4]  305 	cpl
   1DC3 DD 77 FE      [19]  306 	ld	-2 (ix),a
   1DC6 DD 7E FF      [19]  307 	ld	a,-1 (ix)
   1DC9 DD B6 FE      [19]  308 	or	a, -2 (ix)
   1DCC 02            [ 7]  309 	ld	(bc),a
                            310 ;src/StateManager.c:124: *lastStatus=t;
   1DCD FD 72 00      [19]  311 	ld	0 (iy), d
   1DD0 18 D8         [12]  312 	jr	00101$
   1DD2                     313 00103$:
                            314 ;src/StateManager.c:128: if(~anyKeyPressed) ++r_counter;
   1DD2 DD 7E FD      [19]  315 	ld	a, -3 (ix)
   1DD5 06 00         [ 7]  316 	ld	b, #0x00
   1DD7 2F            [ 4]  317 	cpl
   1DD8 4F            [ 4]  318 	ld	c,a
   1DD9 78            [ 4]  319 	ld	a,b
   1DDA 2F            [ 4]  320 	cpl
   1DDB B1            [ 4]  321 	or	a,c
   1DDC 28 04         [12]  322 	jr	Z,00106$
   1DDE 21 A9 4A      [10]  323 	ld	hl, #_r_counter+0
   1DE1 34            [11]  324 	inc	(hl)
   1DE2                     325 00106$:
   1DE2 DD F9         [10]  326 	ld	sp, ix
   1DE4 DD E1         [14]  327 	pop	ix
   1DE6 C9            [10]  328 	ret
                            329 ;src/StateManager.c:131: void statemanager_manage_input(){
                            330 ;	---------------------------------
                            331 ; Function statemanager_manage_input
                            332 ; ---------------------------------
   1DE7                     333 _statemanager_manage_input::
                            334 ;src/StateManager.c:132: while(!inputReceived){
   1DE7                     335 00101$:
   1DE7 3A 2A 1D      [13]  336 	ld	a,(#_inputReceived + 0)
   1DEA B7            [ 4]  337 	or	a, a
   1DEB 20 21         [12]  338 	jr	NZ,00103$
                            339 ;src/StateManager.c:133: scan_input();
   1DED CD 90 1D      [17]  340 	call	_scan_input
                            341 ;src/StateManager.c:134: stateArray[currentState].inputState();
   1DF0 21 28 1D      [10]  342 	ld	hl,#_currentState + 0
   1DF3 4E            [ 7]  343 	ld	c, (hl)
   1DF4 06 00         [ 7]  344 	ld	b,#0x00
   1DF6 69            [ 4]  345 	ld	l, c
   1DF7 60            [ 4]  346 	ld	h, b
   1DF8 29            [11]  347 	add	hl, hl
   1DF9 09            [11]  348 	add	hl, bc
   1DFA 29            [11]  349 	add	hl, hl
   1DFB 09            [11]  350 	add	hl, bc
   1DFC 29            [11]  351 	add	hl, hl
   1DFD 11 EF 1C      [10]  352 	ld	de,#_stateArray
   1E00 19            [11]  353 	add	hl,de
   1E01 11 06 00      [10]  354 	ld	de, #0x0006
   1E04 19            [11]  355 	add	hl, de
   1E05 4E            [ 7]  356 	ld	c,(hl)
   1E06 23            [ 6]  357 	inc	hl
   1E07 66            [ 7]  358 	ld	h,(hl)
   1E08 69            [ 4]  359 	ld	l, c
   1E09 CD 62 48      [17]  360 	call	___sdcc_call_hl
   1E0C 18 D9         [12]  361 	jr	00101$
   1E0E                     362 00103$:
                            363 ;src/StateManager.c:136: *(u8*)&inputReceived=0;
   1E0E 21 2A 1D      [10]  364 	ld	hl,#_inputReceived
   1E11 36 00         [10]  365 	ld	(hl),#0x00
   1E13 C9            [10]  366 	ret
                            367 ;src/StateManager.c:139: void statemanager_render_state(){
                            368 ;	---------------------------------
                            369 ; Function statemanager_render_state
                            370 ; ---------------------------------
   1E14                     371 _statemanager_render_state::
                            372 ;src/StateManager.c:140: cpct_waitVSYNC();
   1E14 CD 8F 48      [17]  373 	call	_cpct_waitVSYNC
                            374 ;src/StateManager.c:141: stateArray[currentState].renderState();
   1E17 01 EF 1C      [10]  375 	ld	bc,#_stateArray+0
   1E1A 21 28 1D      [10]  376 	ld	hl,#_currentState + 0
   1E1D 5E            [ 7]  377 	ld	e, (hl)
   1E1E 16 00         [ 7]  378 	ld	d,#0x00
   1E20 6B            [ 4]  379 	ld	l, e
   1E21 62            [ 4]  380 	ld	h, d
   1E22 29            [11]  381 	add	hl, hl
   1E23 19            [11]  382 	add	hl, de
   1E24 29            [11]  383 	add	hl, hl
   1E25 19            [11]  384 	add	hl, de
   1E26 29            [11]  385 	add	hl, hl
   1E27 09            [11]  386 	add	hl,bc
   1E28 11 0A 00      [10]  387 	ld	de, #0x000A
   1E2B 19            [11]  388 	add	hl, de
   1E2C 4E            [ 7]  389 	ld	c,(hl)
   1E2D 23            [ 6]  390 	inc	hl
   1E2E 66            [ 7]  391 	ld	h,(hl)
   1E2F 69            [ 4]  392 	ld	l, c
   1E30 C3 62 48      [10]  393 	jp  ___sdcc_call_hl
                            394 ;src/StateManager.c:144: void statemanager_close_state(){
                            395 ;	---------------------------------
                            396 ; Function statemanager_close_state
                            397 ; ---------------------------------
   1E33                     398 _statemanager_close_state::
                            399 ;src/StateManager.c:145: *(u8*)&closeState=1;
   1E33 21 27 1D      [10]  400 	ld	hl,#_closeState
   1E36 36 01         [10]  401 	ld	(hl),#0x01
   1E38 C9            [10]  402 	ret
                            403 ;src/StateManager.c:148: void statemanager_update_state(){
                            404 ;	---------------------------------
                            405 ; Function statemanager_update_state
                            406 ; ---------------------------------
   1E39                     407 _statemanager_update_state::
                            408 ;src/StateManager.c:149: stateArray[currentState].updateState();
   1E39 01 EF 1C      [10]  409 	ld	bc,#_stateArray+0
   1E3C 21 28 1D      [10]  410 	ld	hl,#_currentState + 0
   1E3F 5E            [ 7]  411 	ld	e, (hl)
   1E40 16 00         [ 7]  412 	ld	d,#0x00
   1E42 6B            [ 4]  413 	ld	l, e
   1E43 62            [ 4]  414 	ld	h, d
   1E44 29            [11]  415 	add	hl, hl
   1E45 19            [11]  416 	add	hl, de
   1E46 29            [11]  417 	add	hl, hl
   1E47 19            [11]  418 	add	hl, de
   1E48 29            [11]  419 	add	hl, hl
   1E49 09            [11]  420 	add	hl,bc
   1E4A 11 08 00      [10]  421 	ld	de, #0x0008
   1E4D 19            [11]  422 	add	hl, de
   1E4E 4E            [ 7]  423 	ld	c,(hl)
   1E4F 23            [ 6]  424 	inc	hl
   1E50 66            [ 7]  425 	ld	h,(hl)
   1E51 69            [ 4]  426 	ld	l, c
   1E52 C3 62 48      [10]  427 	jp  ___sdcc_call_hl
                            428 ;src/StateManager.c:152: void statemanager_exit_game(){
                            429 ;	---------------------------------
                            430 ; Function statemanager_exit_game
                            431 ; ---------------------------------
   1E55                     432 _statemanager_exit_game::
                            433 ;src/StateManager.c:153: *(u8*)&gameRunning=0;
   1E55 21 2B 1D      [10]  434 	ld	hl,#_gameRunning
   1E58 36 00         [10]  435 	ld	(hl),#0x00
   1E5A C9            [10]  436 	ret
                            437 ;src/StateManager.c:156: void statemanager_main_loop(){
                            438 ;	---------------------------------
                            439 ; Function statemanager_main_loop
                            440 ; ---------------------------------
   1E5B                     441 _statemanager_main_loop::
                            442 ;src/StateManager.c:157: while(gameRunning) {
   1E5B                     443 00101$:
   1E5B 3A 2B 1D      [13]  444 	ld	a,(#_gameRunning + 0)
   1E5E B7            [ 4]  445 	or	a, a
   1E5F C8            [11]  446 	ret	Z
                            447 ;src/StateManager.c:158: statemanager_drop_state();
   1E60 CD 99 1C      [17]  448 	call	_statemanager_drop_state
                            449 ;src/StateManager.c:159: statemanager_change_state();
   1E63 CD 36 1D      [17]  450 	call	_statemanager_change_state
                            451 ;src/StateManager.c:160: statemanager_manage_input();
   1E66 CD E7 1D      [17]  452 	call	_statemanager_manage_input
                            453 ;src/StateManager.c:161: statemanager_update_state();
   1E69 CD 39 1E      [17]  454 	call	_statemanager_update_state
                            455 ;src/StateManager.c:162: statemanager_render_state();
   1E6C CD 14 1E      [17]  456 	call	_statemanager_render_state
   1E6F 18 EA         [12]  457 	jr	00101$
                            458 	.area _CODE
                            459 	.area _INITIALIZER
                            460 	.area _CABS (ABS)
