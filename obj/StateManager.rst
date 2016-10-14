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
                             62 ;src/StateManager.c:79: void statemanager_drop_state(){
                             63 ;	---------------------------------
                             64 ; Function statemanager_drop_state
                             65 ; ---------------------------------
   1C5C                      66 _statemanager_drop_state::
                             67 ;src/StateManager.c:80: if(closeState){
   1C5C 3A C7 1C      [13]   68 	ld	a,(#_closeState + 0)
   1C5F B7            [ 4]   69 	or	a, a
   1C60 C8            [11]   70 	ret	Z
                             71 ;src/StateManager.c:81: stateArray[currentState].exitState();
   1C61 01 97 1C      [10]   72 	ld	bc,#_stateArray+0
   1C64 21 C8 1C      [10]   73 	ld	hl,#_currentState + 0
   1C67 5E            [ 7]   74 	ld	e, (hl)
   1C68 16 00         [ 7]   75 	ld	d,#0x00
   1C6A 6B            [ 4]   76 	ld	l, e
   1C6B 62            [ 4]   77 	ld	h, d
   1C6C 29            [11]   78 	add	hl, hl
   1C6D 19            [11]   79 	add	hl, de
   1C6E 29            [11]   80 	add	hl, hl
   1C6F 29            [11]   81 	add	hl, hl
   1C70 09            [11]   82 	add	hl,bc
   1C71 11 0A 00      [10]   83 	ld	de, #0x000A
   1C74 19            [11]   84 	add	hl, de
   1C75 5E            [ 7]   85 	ld	e,(hl)
   1C76 23            [ 6]   86 	inc	hl
   1C77 66            [ 7]   87 	ld	h,(hl)
   1C78 C5            [11]   88 	push	bc
   1C79 6B            [ 4]   89 	ld	l, e
   1C7A CD AE 46      [17]   90 	call	___sdcc_call_hl
   1C7D C1            [10]   91 	pop	bc
                             92 ;src/StateManager.c:82: *(u8*)&currentState = stateArray[currentState].lastStateid;
   1C7E 21 C8 1C      [10]   93 	ld	hl,#_currentState + 0
   1C81 5E            [ 7]   94 	ld	e, (hl)
   1C82 16 00         [ 7]   95 	ld	d,#0x00
   1C84 6B            [ 4]   96 	ld	l, e
   1C85 62            [ 4]   97 	ld	h, d
   1C86 29            [11]   98 	add	hl, hl
   1C87 19            [11]   99 	add	hl, de
   1C88 29            [11]  100 	add	hl, hl
   1C89 29            [11]  101 	add	hl, hl
   1C8A 09            [11]  102 	add	hl,bc
   1C8B 23            [ 6]  103 	inc	hl
   1C8C 4E            [ 7]  104 	ld	c,(hl)
   1C8D 21 C8 1C      [10]  105 	ld	hl,#_currentState
   1C90 71            [ 7]  106 	ld	(hl),c
                            107 ;src/StateManager.c:83: *(u8*)&closeState=0;
   1C91 21 C7 1C      [10]  108 	ld	hl,#_closeState
   1C94 36 00         [10]  109 	ld	(hl),#0x00
   1C96 C9            [10]  110 	ret
   1C97                     111 _stateArray:
   1C97 00                  112 	.db #0x00	; 0
   1C98 00                  113 	.db #0x00	; 0
   1C99 AD 1B               114 	.dw _state_mainmenu_enter
   1C9B E3 1B               115 	.dw _state_mainmenu_input
   1C9D 12 1C               116 	.dw _state_mainmenu_update
   1C9F 58 1C               117 	.dw _state_mainmenu_render
   1CA1 5B 1C               118 	.dw _state_mainmenu_exit
   1CA3 01                  119 	.db #0x01	; 1
   1CA4 00                  120 	.db #0x00	; 0
   1CA5 48 1A               121 	.dw _state_ingame_enter
   1CA7 63 1A               122 	.dw _state_ingame_input
   1CA9 DB 1A               123 	.dw _state_ingame_update
   1CAB 3C 1B               124 	.dw _state_ingame_render
   1CAD 64 1B               125 	.dw _state_ingame_exit
   1CAF 02                  126 	.db #0x02	; 2
   1CB0 00                  127 	.db #0x00	; 0
   1CB1 06 1E               128 	.dw _state_pausemenu_enter
   1CB3 23 1E               129 	.dw _state_pausemenu_input
   1CB5 4C 1E               130 	.dw _state_pausemenu_update
   1CB7 4D 1E               131 	.dw _state_pausemenu_render
   1CB9 4E 1E               132 	.dw _state_pausemenu_exit
   1CBB 03                  133 	.db #0x03	; 3
   1CBC 00                  134 	.db #0x00	; 0
   1CBD 65 1B               135 	.dw _state_loadlevel_enter
   1CBF 9C 1B               136 	.dw _state_loadlevel_input
   1CC1 9F 1B               137 	.dw _state_loadlevel_update
   1CC3 AB 1B               138 	.dw _state_loadlevel_render
   1CC5 AC 1B               139 	.dw _state_loadlevel_exit
   1CC7                     140 _closeState:
   1CC7 00                  141 	.db #0x00	; 0
   1CC8                     142 _currentState:
   1CC8 00                  143 	.db #0x00	; 0
   1CC9                     144 _changeToState:
   1CC9 00                  145 	.db #0x00	; 0
   1CCA                     146 _inputReceived:
   1CCA 00                  147 	.db #0x00	; 0
   1CCB                     148 _gameRunning:
   1CCB 01                  149 	.db #0x01	; 1
   1CCC                     150 _last_keyboardStatusBuffer:
   1CCC FF                  151 	.db #0xFF	; 255
   1CCD FF                  152 	.db #0xFF	; 255
   1CCE FF                  153 	.db #0xFF	; 255
   1CCF FF                  154 	.db #0xFF	; 255
   1CD0 FF                  155 	.db #0xFF	; 255
   1CD1 FF                  156 	.db #0xFF	; 255
   1CD2 FF                  157 	.db #0xFF	; 255
   1CD3 FF                  158 	.db #0xFF	; 255
   1CD4 FF                  159 	.db #0xFF	; 255
   1CD5 FF                  160 	.db #0xFF	; 255
                            161 ;src/StateManager.c:87: void statemanager_change_state(){
                            162 ;	---------------------------------
                            163 ; Function statemanager_change_state
                            164 ; ---------------------------------
   1CD6                     165 _statemanager_change_state::
                            166 ;src/StateManager.c:88: if(changeToState){
   1CD6 21 C9 1C      [10]  167 	ld	hl,#_changeToState + 0
   1CD9 4E            [ 7]  168 	ld	c, (hl)
   1CDA 3A C9 1C      [13]  169 	ld	a,(#_changeToState + 0)
   1CDD B7            [ 4]  170 	or	a, a
   1CDE C8            [11]  171 	ret	Z
                            172 ;src/StateManager.c:89: *(u8*)&(stateArray[changeToState-1].lastStateid) = currentState;
   1CDF 11 97 1C      [10]  173 	ld	de,#_stateArray+0
   1CE2 0D            [ 4]  174 	dec	c
   1CE3 06 00         [ 7]  175 	ld	b,#0x00
   1CE5 69            [ 4]  176 	ld	l, c
   1CE6 60            [ 4]  177 	ld	h, b
   1CE7 29            [11]  178 	add	hl, hl
   1CE8 09            [11]  179 	add	hl, bc
   1CE9 29            [11]  180 	add	hl, hl
   1CEA 29            [11]  181 	add	hl, hl
   1CEB 19            [11]  182 	add	hl,de
   1CEC 23            [ 6]  183 	inc	hl
   1CED FD 21 C8 1C   [14]  184 	ld	iy,#_currentState
   1CF1 FD 4E 00      [19]  185 	ld	c,0 (iy)
   1CF4 71            [ 7]  186 	ld	(hl),c
                            187 ;src/StateManager.c:90: *(u8*)&currentState = changeToState-1;
   1CF5 21 C8 1C      [10]  188 	ld	hl,#_currentState+0
   1CF8 FD 21 C9 1C   [14]  189 	ld	iy,#_changeToState
   1CFC FD 4E 00      [19]  190 	ld	c,0 (iy)
   1CFF 0D            [ 4]  191 	dec	c
   1D00 71            [ 7]  192 	ld	(hl),c
                            193 ;src/StateManager.c:91: stateArray[currentState].enterState();
   1D01 21 C8 1C      [10]  194 	ld	hl,#_currentState + 0
   1D04 4E            [ 7]  195 	ld	c, (hl)
   1D05 06 00         [ 7]  196 	ld	b,#0x00
   1D07 69            [ 4]  197 	ld	l, c
   1D08 60            [ 4]  198 	ld	h, b
   1D09 29            [11]  199 	add	hl, hl
   1D0A 09            [11]  200 	add	hl, bc
   1D0B 29            [11]  201 	add	hl, hl
   1D0C 29            [11]  202 	add	hl, hl
   1D0D 19            [11]  203 	add	hl,de
   1D0E 23            [ 6]  204 	inc	hl
   1D0F 23            [ 6]  205 	inc	hl
   1D10 4E            [ 7]  206 	ld	c,(hl)
   1D11 23            [ 6]  207 	inc	hl
   1D12 66            [ 7]  208 	ld	h,(hl)
   1D13 69            [ 4]  209 	ld	l, c
   1D14 CD AE 46      [17]  210 	call	___sdcc_call_hl
                            211 ;src/StateManager.c:92: *(u8*)&changeToState = 0;
   1D17 21 C9 1C      [10]  212 	ld	hl,#_changeToState
   1D1A 36 00         [10]  213 	ld	(hl),#0x00
   1D1C C9            [10]  214 	ret
                            215 ;src/StateManager.c:96: void statemanager_input_accepted(){
                            216 ;	---------------------------------
                            217 ; Function statemanager_input_accepted
                            218 ; ---------------------------------
   1D1D                     219 _statemanager_input_accepted::
                            220 ;src/StateManager.c:97: *(u8*)&inputReceived=1;
   1D1D 21 CA 1C      [10]  221 	ld	hl,#_inputReceived
   1D20 36 01         [10]  222 	ld	(hl),#0x01
   1D22 C9            [10]  223 	ret
                            224 ;src/StateManager.c:100: void statemanager_set_state(u8 state){
                            225 ;	---------------------------------
                            226 ; Function statemanager_set_state
                            227 ; ---------------------------------
   1D23                     228 _statemanager_set_state::
                            229 ;src/StateManager.c:101: *(u8*)&changeToState = state+1;
   1D23 01 C9 1C      [10]  230 	ld	bc,#_changeToState+0
   1D26 21 02 00      [10]  231 	ld	hl, #2+0
   1D29 39            [11]  232 	add	hl, sp
   1D2A 7E            [ 7]  233 	ld	a, (hl)
   1D2B 3C            [ 4]  234 	inc	a
   1D2C 02            [ 7]  235 	ld	(bc),a
   1D2D C9            [10]  236 	ret
                            237 ;src/StateManager.c:104: void scan_input(){
                            238 ;	---------------------------------
                            239 ; Function scan_input
                            240 ; ---------------------------------
   1D2E                     241 _scan_input::
   1D2E DD E5         [15]  242 	push	ix
   1D30 DD 21 00 00   [14]  243 	ld	ix,#0
   1D34 DD 39         [15]  244 	add	ix,sp
   1D36 F5            [11]  245 	push	af
   1D37 F5            [11]  246 	push	af
   1D38 3B            [ 6]  247 	dec	sp
                            248 ;src/StateManager.c:105: u8 t,n=10, anyKeyPressed=0xFF;
   1D39 DD 36 FD FF   [19]  249 	ld	-3 (ix),#0xFF
                            250 ;src/StateManager.c:106: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
                            251 ;src/StateManager.c:107: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
                            252 ;src/StateManager.c:109: cpct_scanKeyboard_f();
   1D3D CD DA 44      [17]  253 	call	_cpct_scanKeyboard_f
                            254 ;src/StateManager.c:110: while(n){
   1D40 DD 36 FB 0A   [19]  255 	ld	-5 (ix),#0x0A
   1D44 01 92 46      [10]  256 	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
   1D47 11 D6 1C      [10]  257 	ld	de,#(_last_keyboardStatusBuffer + 0x000a)
   1D4A                     258 00101$:
   1D4A DD 7E FB      [19]  259 	ld	a,-5 (ix)
   1D4D B7            [ 4]  260 	or	a, a
   1D4E 28 2A         [12]  261 	jr	Z,00104$
                            262 ;src/StateManager.c:111: --n;
   1D50 DD 35 FB      [23]  263 	dec	-5 (ix)
                            264 ;src/StateManager.c:112: --currentStatus;
   1D53 0B            [ 6]  265 	dec	bc
                            266 ;src/StateManager.c:113: --lastStatus;
   1D54 1B            [ 6]  267 	dec	de
                            268 ;src/StateManager.c:115: t=*(currentStatus);
   1D55 0A            [ 7]  269 	ld	a,(bc)
   1D56 DD 77 FC      [19]  270 	ld	-4 (ix),a
                            271 ;src/StateManager.c:116: anyKeyPressed&=t;
   1D59 DD 7E FD      [19]  272 	ld	a,-3 (ix)
   1D5C DD A6 FC      [19]  273 	and	a, -4 (ix)
   1D5F DD 77 FD      [19]  274 	ld	-3 (ix),a
                            275 ;src/StateManager.c:117: *currentStatus=((*lastStatus)|(~t));
   1D62 1A            [ 7]  276 	ld	a,(de)
   1D63 DD 77 FE      [19]  277 	ld	-2 (ix),a
   1D66 DD 7E FC      [19]  278 	ld	a,-4 (ix)
   1D69 2F            [ 4]  279 	cpl
   1D6A DD 77 FF      [19]  280 	ld	-1 (ix),a
   1D6D DD 7E FE      [19]  281 	ld	a,-2 (ix)
   1D70 DD B6 FF      [19]  282 	or	a, -1 (ix)
   1D73 02            [ 7]  283 	ld	(bc),a
                            284 ;src/StateManager.c:118: *lastStatus=t;
   1D74 DD 7E FC      [19]  285 	ld	a,-4 (ix)
   1D77 12            [ 7]  286 	ld	(de),a
   1D78 18 D0         [12]  287 	jr	00101$
   1D7A                     288 00104$:
   1D7A DD F9         [10]  289 	ld	sp, ix
   1D7C DD E1         [14]  290 	pop	ix
   1D7E C9            [10]  291 	ret
                            292 ;src/StateManager.c:125: void statemanager_manage_input(){
                            293 ;	---------------------------------
                            294 ; Function statemanager_manage_input
                            295 ; ---------------------------------
   1D7F                     296 _statemanager_manage_input::
                            297 ;src/StateManager.c:126: while(!inputReceived){
   1D7F                     298 00101$:
   1D7F 3A CA 1C      [13]  299 	ld	a,(#_inputReceived + 0)
   1D82 B7            [ 4]  300 	or	a, a
   1D83 20 20         [12]  301 	jr	NZ,00103$
                            302 ;src/StateManager.c:127: scan_input();
   1D85 CD 2E 1D      [17]  303 	call	_scan_input
                            304 ;src/StateManager.c:128: stateArray[currentState].inputState();
   1D88 21 C8 1C      [10]  305 	ld	hl,#_currentState + 0
   1D8B 4E            [ 7]  306 	ld	c, (hl)
   1D8C 06 00         [ 7]  307 	ld	b,#0x00
   1D8E 69            [ 4]  308 	ld	l, c
   1D8F 60            [ 4]  309 	ld	h, b
   1D90 29            [11]  310 	add	hl, hl
   1D91 09            [11]  311 	add	hl, bc
   1D92 29            [11]  312 	add	hl, hl
   1D93 29            [11]  313 	add	hl, hl
   1D94 11 97 1C      [10]  314 	ld	de,#_stateArray
   1D97 19            [11]  315 	add	hl,de
   1D98 11 04 00      [10]  316 	ld	de, #0x0004
   1D9B 19            [11]  317 	add	hl, de
   1D9C 4E            [ 7]  318 	ld	c,(hl)
   1D9D 23            [ 6]  319 	inc	hl
   1D9E 66            [ 7]  320 	ld	h,(hl)
   1D9F 69            [ 4]  321 	ld	l, c
   1DA0 CD AE 46      [17]  322 	call	___sdcc_call_hl
   1DA3 18 DA         [12]  323 	jr	00101$
   1DA5                     324 00103$:
                            325 ;src/StateManager.c:130: *(u8*)&inputReceived=0;
   1DA5 21 CA 1C      [10]  326 	ld	hl,#_inputReceived
   1DA8 36 00         [10]  327 	ld	(hl),#0x00
   1DAA C9            [10]  328 	ret
                            329 ;src/StateManager.c:133: void statemanager_render_state(){
                            330 ;	---------------------------------
                            331 ; Function statemanager_render_state
                            332 ; ---------------------------------
   1DAB                     333 _statemanager_render_state::
                            334 ;src/StateManager.c:134: cpct_waitVSYNC();
   1DAB CD DB 46      [17]  335 	call	_cpct_waitVSYNC
                            336 ;src/StateManager.c:135: stateArray[currentState].renderState();
   1DAE 01 97 1C      [10]  337 	ld	bc,#_stateArray+0
   1DB1 21 C8 1C      [10]  338 	ld	hl,#_currentState + 0
   1DB4 5E            [ 7]  339 	ld	e, (hl)
   1DB5 16 00         [ 7]  340 	ld	d,#0x00
   1DB7 6B            [ 4]  341 	ld	l, e
   1DB8 62            [ 4]  342 	ld	h, d
   1DB9 29            [11]  343 	add	hl, hl
   1DBA 19            [11]  344 	add	hl, de
   1DBB 29            [11]  345 	add	hl, hl
   1DBC 29            [11]  346 	add	hl, hl
   1DBD 09            [11]  347 	add	hl,bc
   1DBE 11 08 00      [10]  348 	ld	de, #0x0008
   1DC1 19            [11]  349 	add	hl, de
   1DC2 4E            [ 7]  350 	ld	c,(hl)
   1DC3 23            [ 6]  351 	inc	hl
   1DC4 66            [ 7]  352 	ld	h,(hl)
   1DC5 69            [ 4]  353 	ld	l, c
   1DC6 C3 AE 46      [10]  354 	jp  ___sdcc_call_hl
                            355 ;src/StateManager.c:138: void statemanager_close_state(){
                            356 ;	---------------------------------
                            357 ; Function statemanager_close_state
                            358 ; ---------------------------------
   1DC9                     359 _statemanager_close_state::
                            360 ;src/StateManager.c:139: *(u8*)&closeState=1;
   1DC9 21 C7 1C      [10]  361 	ld	hl,#_closeState
   1DCC 36 01         [10]  362 	ld	(hl),#0x01
   1DCE C9            [10]  363 	ret
                            364 ;src/StateManager.c:142: void statemanager_update_state(){
                            365 ;	---------------------------------
                            366 ; Function statemanager_update_state
                            367 ; ---------------------------------
   1DCF                     368 _statemanager_update_state::
                            369 ;src/StateManager.c:143: stateArray[currentState].updateState();
   1DCF 01 97 1C      [10]  370 	ld	bc,#_stateArray+0
   1DD2 21 C8 1C      [10]  371 	ld	hl,#_currentState + 0
   1DD5 5E            [ 7]  372 	ld	e, (hl)
   1DD6 16 00         [ 7]  373 	ld	d,#0x00
   1DD8 6B            [ 4]  374 	ld	l, e
   1DD9 62            [ 4]  375 	ld	h, d
   1DDA 29            [11]  376 	add	hl, hl
   1DDB 19            [11]  377 	add	hl, de
   1DDC 29            [11]  378 	add	hl, hl
   1DDD 29            [11]  379 	add	hl, hl
   1DDE 09            [11]  380 	add	hl,bc
   1DDF 11 06 00      [10]  381 	ld	de, #0x0006
   1DE2 19            [11]  382 	add	hl, de
   1DE3 4E            [ 7]  383 	ld	c,(hl)
   1DE4 23            [ 6]  384 	inc	hl
   1DE5 66            [ 7]  385 	ld	h,(hl)
   1DE6 69            [ 4]  386 	ld	l, c
   1DE7 C3 AE 46      [10]  387 	jp  ___sdcc_call_hl
                            388 ;src/StateManager.c:146: void statemanager_exit_game(){
                            389 ;	---------------------------------
                            390 ; Function statemanager_exit_game
                            391 ; ---------------------------------
   1DEA                     392 _statemanager_exit_game::
                            393 ;src/StateManager.c:147: *(u8*)&gameRunning=0;
   1DEA 21 CB 1C      [10]  394 	ld	hl,#_gameRunning
   1DED 36 00         [10]  395 	ld	(hl),#0x00
   1DEF C9            [10]  396 	ret
                            397 ;src/StateManager.c:150: void statemanager_main_loop(){
                            398 ;	---------------------------------
                            399 ; Function statemanager_main_loop
                            400 ; ---------------------------------
   1DF0                     401 _statemanager_main_loop::
                            402 ;src/StateManager.c:151: while(gameRunning) {
   1DF0                     403 00101$:
   1DF0 3A CB 1C      [13]  404 	ld	a,(#_gameRunning + 0)
   1DF3 B7            [ 4]  405 	or	a, a
   1DF4 C8            [11]  406 	ret	Z
                            407 ;src/StateManager.c:152: statemanager_drop_state();
   1DF5 CD 5C 1C      [17]  408 	call	_statemanager_drop_state
                            409 ;src/StateManager.c:153: statemanager_change_state();
   1DF8 CD D6 1C      [17]  410 	call	_statemanager_change_state
                            411 ;src/StateManager.c:154: statemanager_manage_input();
   1DFB CD 7F 1D      [17]  412 	call	_statemanager_manage_input
                            413 ;src/StateManager.c:155: statemanager_update_state();
   1DFE CD CF 1D      [17]  414 	call	_statemanager_update_state
                            415 ;src/StateManager.c:156: statemanager_render_state();
   1E01 CD AB 1D      [17]  416 	call	_statemanager_render_state
   1E04 18 EA         [12]  417 	jr	00101$
                            418 	.area _CODE
                            419 	.area _INITIALIZER
                            420 	.area _CABS (ABS)
