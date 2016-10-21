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
                             62 ;src/StateManager.c:96: void statemanager_drop_state(){
                             63 ;	---------------------------------
                             64 ; Function statemanager_drop_state
                             65 ; ---------------------------------
   2285                      66 _statemanager_drop_state::
                             67 ;src/StateManager.c:97: if(closeState){
   2285 3A 13 23      [13]   68 	ld	a,(#_closeState + 0)
   2288 B7            [ 4]   69 	or	a, a
   2289 C8            [11]   70 	ret	Z
                             71 ;src/StateManager.c:98: stateArray[currentState].exitState();
   228A 01 DB 22      [10]   72 	ld	bc,#_stateArray+0
   228D 21 14 23      [10]   73 	ld	hl,#_currentState + 0
   2290 5E            [ 7]   74 	ld	e, (hl)
   2291 16 00         [ 7]   75 	ld	d,#0x00
   2293 6B            [ 4]   76 	ld	l, e
   2294 62            [ 4]   77 	ld	h, d
   2295 29            [11]   78 	add	hl, hl
   2296 19            [11]   79 	add	hl, de
   2297 29            [11]   80 	add	hl, hl
   2298 19            [11]   81 	add	hl, de
   2299 29            [11]   82 	add	hl, hl
   229A 09            [11]   83 	add	hl,bc
   229B 11 0C 00      [10]   84 	ld	de, #0x000C
   229E 19            [11]   85 	add	hl, de
   229F 5E            [ 7]   86 	ld	e,(hl)
   22A0 23            [ 6]   87 	inc	hl
   22A1 66            [ 7]   88 	ld	h,(hl)
   22A2 C5            [11]   89 	push	bc
   22A3 6B            [ 4]   90 	ld	l, e
   22A4 CD 0A 59      [17]   91 	call	___sdcc_call_hl
   22A7 C1            [10]   92 	pop	bc
                             93 ;src/StateManager.c:99: *(u8*)&currentState = stateArray[currentState].lastStateid;
   22A8 21 14 23      [10]   94 	ld	hl,#_currentState + 0
   22AB 5E            [ 7]   95 	ld	e, (hl)
   22AC 16 00         [ 7]   96 	ld	d,#0x00
   22AE 6B            [ 4]   97 	ld	l, e
   22AF 62            [ 4]   98 	ld	h, d
   22B0 29            [11]   99 	add	hl, hl
   22B1 19            [11]  100 	add	hl, de
   22B2 29            [11]  101 	add	hl, hl
   22B3 19            [11]  102 	add	hl, de
   22B4 29            [11]  103 	add	hl, hl
   22B5 09            [11]  104 	add	hl,bc
   22B6 23            [ 6]  105 	inc	hl
   22B7 5E            [ 7]  106 	ld	e,(hl)
   22B8 21 14 23      [10]  107 	ld	hl,#_currentState
   22BB 73            [ 7]  108 	ld	(hl),e
                            109 ;src/StateManager.c:100: stateArray[currentState].returnState();
   22BC 21 14 23      [10]  110 	ld	hl,#_currentState + 0
   22BF 5E            [ 7]  111 	ld	e, (hl)
   22C0 16 00         [ 7]  112 	ld	d,#0x00
   22C2 6B            [ 4]  113 	ld	l, e
   22C3 62            [ 4]  114 	ld	h, d
   22C4 29            [11]  115 	add	hl, hl
   22C5 19            [11]  116 	add	hl, de
   22C6 29            [11]  117 	add	hl, hl
   22C7 19            [11]  118 	add	hl, de
   22C8 29            [11]  119 	add	hl, hl
   22C9 09            [11]  120 	add	hl,bc
   22CA 11 04 00      [10]  121 	ld	de, #0x0004
   22CD 19            [11]  122 	add	hl, de
   22CE 7E            [ 7]  123 	ld	a, (hl)
   22CF 23            [ 6]  124 	inc	hl
   22D0 66            [ 7]  125 	ld	h,(hl)
   22D1 6F            [ 4]  126 	ld	l,a
   22D2 CD 0A 59      [17]  127 	call	___sdcc_call_hl
                            128 ;src/StateManager.c:101: *(u8*)&closeState=0;
   22D5 21 13 23      [10]  129 	ld	hl,#_closeState
   22D8 36 00         [10]  130 	ld	(hl),#0x00
   22DA C9            [10]  131 	ret
   22DB                     132 _stateArray:
   22DB 00                  133 	.db #0x00	; 0
   22DC 00                  134 	.db #0x00	; 0
   22DD DB 21               135 	.dw _state_mainmenu_enter
   22DF 0E 22               136 	.dw _state_mainmenu_return
   22E1 11 22               137 	.dw _state_mainmenu_input
   22E3 40 22               138 	.dw _state_mainmenu_update
   22E5 81 22               139 	.dw _state_mainmenu_render
   22E7 84 22               140 	.dw _state_mainmenu_exit
   22E9 01                  141 	.db #0x01	; 1
   22EA 00                  142 	.db #0x00	; 0
   22EB 02 20               143 	.dw _state_ingame_enter
   22ED 1F 20               144 	.dw _state_ingame_return
   22EF 25 20               145 	.dw _state_ingame_input
   22F1 AA 20               146 	.dw _state_ingame_update
   22F3 6A 21               147 	.dw _state_ingame_render
   22F5 95 21               148 	.dw _state_ingame_exit
   22F7 02                  149 	.db #0x02	; 2
   22F8 00                  150 	.db #0x00	; 0
   22F9 65 24               151 	.dw _state_pausemenu_enter
   22FB 93 24               152 	.dw _state_pausemenu_return
   22FD 96 24               153 	.dw _state_pausemenu_input
   22FF C5 24               154 	.dw _state_pausemenu_update
   2301 03 25               155 	.dw _state_pausemenu_render
   2303 06 25               156 	.dw _state_pausemenu_exit
   2305 03                  157 	.db #0x03	; 3
   2306 00                  158 	.db #0x00	; 0
   2307 96 21               159 	.dw _state_loadlevel_enter
   2309 D0 21               160 	.dw _state_loadlevel_return
   230B D1 21               161 	.dw _state_loadlevel_input
   230D D4 21               162 	.dw _state_loadlevel_update
   230F D9 21               163 	.dw _state_loadlevel_render
   2311 DA 21               164 	.dw _state_loadlevel_exit
   2313                     165 _closeState:
   2313 00                  166 	.db #0x00	; 0
   2314                     167 _currentState:
   2314 00                  168 	.db #0x00	; 0
   2315                     169 _changeToState:
   2315 00                  170 	.db #0x00	; 0
   2316                     171 _inputReceived:
   2316 00                  172 	.db #0x00	; 0
   2317                     173 _gameRunning:
   2317 01                  174 	.db #0x01	; 1
   2318                     175 _last_keyboardStatusBuffer:
   2318 FF                  176 	.db #0xFF	; 255
   2319 FF                  177 	.db #0xFF	; 255
   231A FF                  178 	.db #0xFF	; 255
   231B FF                  179 	.db #0xFF	; 255
   231C FF                  180 	.db #0xFF	; 255
   231D FF                  181 	.db #0xFF	; 255
   231E FF                  182 	.db #0xFF	; 255
   231F FF                  183 	.db #0xFF	; 255
   2320 FF                  184 	.db #0xFF	; 255
   2321 FF                  185 	.db #0xFF	; 255
                            186 ;src/StateManager.c:105: void statemanager_change_state(){
                            187 ;	---------------------------------
                            188 ; Function statemanager_change_state
                            189 ; ---------------------------------
   2322                     190 _statemanager_change_state::
                            191 ;src/StateManager.c:106: if(changeToState){
   2322 21 15 23      [10]  192 	ld	hl,#_changeToState + 0
   2325 4E            [ 7]  193 	ld	c, (hl)
   2326 3A 15 23      [13]  194 	ld	a,(#_changeToState + 0)
   2329 B7            [ 4]  195 	or	a, a
   232A C8            [11]  196 	ret	Z
                            197 ;src/StateManager.c:107: *(u8*)&(stateArray[changeToState-1].lastStateid) = currentState;
   232B 11 DB 22      [10]  198 	ld	de,#_stateArray+0
   232E 0D            [ 4]  199 	dec	c
   232F 06 00         [ 7]  200 	ld	b,#0x00
   2331 69            [ 4]  201 	ld	l, c
   2332 60            [ 4]  202 	ld	h, b
   2333 29            [11]  203 	add	hl, hl
   2334 09            [11]  204 	add	hl, bc
   2335 29            [11]  205 	add	hl, hl
   2336 09            [11]  206 	add	hl, bc
   2337 29            [11]  207 	add	hl, hl
   2338 19            [11]  208 	add	hl,de
   2339 23            [ 6]  209 	inc	hl
   233A FD 21 14 23   [14]  210 	ld	iy,#_currentState
   233E FD 4E 00      [19]  211 	ld	c,0 (iy)
   2341 71            [ 7]  212 	ld	(hl),c
                            213 ;src/StateManager.c:108: *(u8*)&currentState = changeToState-1;
   2342 21 14 23      [10]  214 	ld	hl,#_currentState+0
   2345 FD 21 15 23   [14]  215 	ld	iy,#_changeToState
   2349 FD 4E 00      [19]  216 	ld	c,0 (iy)
   234C 0D            [ 4]  217 	dec	c
   234D 71            [ 7]  218 	ld	(hl),c
                            219 ;src/StateManager.c:109: stateArray[currentState].enterState();
   234E 21 14 23      [10]  220 	ld	hl,#_currentState + 0
   2351 4E            [ 7]  221 	ld	c, (hl)
   2352 06 00         [ 7]  222 	ld	b,#0x00
   2354 69            [ 4]  223 	ld	l, c
   2355 60            [ 4]  224 	ld	h, b
   2356 29            [11]  225 	add	hl, hl
   2357 09            [11]  226 	add	hl, bc
   2358 29            [11]  227 	add	hl, hl
   2359 09            [11]  228 	add	hl, bc
   235A 29            [11]  229 	add	hl, hl
   235B 19            [11]  230 	add	hl,de
   235C 23            [ 6]  231 	inc	hl
   235D 23            [ 6]  232 	inc	hl
   235E 4E            [ 7]  233 	ld	c,(hl)
   235F 23            [ 6]  234 	inc	hl
   2360 66            [ 7]  235 	ld	h,(hl)
   2361 69            [ 4]  236 	ld	l, c
   2362 CD 0A 59      [17]  237 	call	___sdcc_call_hl
                            238 ;src/StateManager.c:110: *(u8*)&changeToState = 0;
   2365 21 15 23      [10]  239 	ld	hl,#_changeToState
   2368 36 00         [10]  240 	ld	(hl),#0x00
   236A C9            [10]  241 	ret
                            242 ;src/StateManager.c:114: void statemanager_input_accepted(){
                            243 ;	---------------------------------
                            244 ; Function statemanager_input_accepted
                            245 ; ---------------------------------
   236B                     246 _statemanager_input_accepted::
                            247 ;src/StateManager.c:115: *(u8*)&inputReceived=1;
   236B 21 16 23      [10]  248 	ld	hl,#_inputReceived
   236E 36 01         [10]  249 	ld	(hl),#0x01
   2370 C9            [10]  250 	ret
                            251 ;src/StateManager.c:118: void statemanager_set_state(u8 state) __z88dk_fastcall{
                            252 ;	---------------------------------
                            253 ; Function statemanager_set_state
                            254 ; ---------------------------------
   2371                     255 _statemanager_set_state::
                            256 ;src/StateManager.c:119: *(u8*)&changeToState = state+1;
   2371 01 15 23      [10]  257 	ld	bc,#_changeToState+0
   2374 7D            [ 4]  258 	ld	a,l
   2375 3C            [ 4]  259 	inc	a
   2376 02            [ 7]  260 	ld	(bc),a
   2377 C9            [10]  261 	ret
                            262 ;src/StateManager.c:122: void scan_input(){
                            263 ;	---------------------------------
                            264 ; Function scan_input
                            265 ; ---------------------------------
   2378                     266 _scan_input::
   2378 DD E5         [15]  267 	push	ix
   237A DD 21 00 00   [14]  268 	ld	ix,#0
   237E DD 39         [15]  269 	add	ix,sp
   2380 F5            [11]  270 	push	af
   2381 3B            [ 6]  271 	dec	sp
                            272 ;src/StateManager.c:123: u8 t,n=10, anyKeyPressed=0xFF;
   2382 DD 36 FD FF   [19]  273 	ld	-3 (ix),#0xFF
                            274 ;src/StateManager.c:124: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
                            275 ;src/StateManager.c:125: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
                            276 ;src/StateManager.c:127: cpct_scanKeyboard_f();
   2386 CD E5 56      [17]  277 	call	_cpct_scanKeyboard_f
                            278 ;src/StateManager.c:128: while(n){
   2389 1E 0A         [ 7]  279 	ld	e,#0x0A
   238B 01 98 58      [10]  280 	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
   238E FD 21 22 23   [14]  281 	ld	iy,#(_last_keyboardStatusBuffer + 0x000a)
   2392                     282 00101$:
   2392 7B            [ 4]  283 	ld	a,e
   2393 B7            [ 4]  284 	or	a, a
   2394 28 24         [12]  285 	jr	Z,00103$
                            286 ;src/StateManager.c:129: --n;
   2396 1D            [ 4]  287 	dec	e
                            288 ;src/StateManager.c:130: --currentStatus;
   2397 0B            [ 6]  289 	dec	bc
                            290 ;src/StateManager.c:131: --lastStatus;
   2398 FD 2B         [10]  291 	dec	iy
                            292 ;src/StateManager.c:133: t=*(currentStatus);
   239A 0A            [ 7]  293 	ld	a,(bc)
   239B 57            [ 4]  294 	ld	d,a
                            295 ;src/StateManager.c:134: anyKeyPressed&=t;
   239C DD 7E FD      [19]  296 	ld	a,-3 (ix)
   239F A2            [ 4]  297 	and	a, d
   23A0 DD 77 FD      [19]  298 	ld	-3 (ix),a
                            299 ;src/StateManager.c:135: *currentStatus=((*lastStatus)|(~t));
   23A3 FD 7E 00      [19]  300 	ld	a, 0 (iy)
   23A6 DD 77 FF      [19]  301 	ld	-1 (ix),a
   23A9 7A            [ 4]  302 	ld	a,d
   23AA 2F            [ 4]  303 	cpl
   23AB DD 77 FE      [19]  304 	ld	-2 (ix),a
   23AE DD 7E FF      [19]  305 	ld	a,-1 (ix)
   23B1 DD B6 FE      [19]  306 	or	a, -2 (ix)
   23B4 02            [ 7]  307 	ld	(bc),a
                            308 ;src/StateManager.c:136: *lastStatus=t;
   23B5 FD 72 00      [19]  309 	ld	0 (iy), d
   23B8 18 D8         [12]  310 	jr	00101$
   23BA                     311 00103$:
                            312 ;src/StateManager.c:140: if(~anyKeyPressed) ++r_counter;
   23BA DD 7E FD      [19]  313 	ld	a, -3 (ix)
   23BD 06 00         [ 7]  314 	ld	b, #0x00
   23BF 2F            [ 4]  315 	cpl
   23C0 4F            [ 4]  316 	ld	c,a
   23C1 78            [ 4]  317 	ld	a,b
   23C2 2F            [ 4]  318 	cpl
   23C3 B1            [ 4]  319 	or	a,c
   23C4 28 0A         [12]  320 	jr	Z,00106$
   23C6 21 26 5B      [10]  321 	ld	hl, #_r_counter+0
   23C9 34            [11]  322 	inc	(hl)
   23CA 20 04         [12]  323 	jr	NZ,00121$
   23CC 21 27 5B      [10]  324 	ld	hl, #_r_counter+1
   23CF 34            [11]  325 	inc	(hl)
   23D0                     326 00121$:
   23D0                     327 00106$:
   23D0 DD F9         [10]  328 	ld	sp, ix
   23D2 DD E1         [14]  329 	pop	ix
   23D4 C9            [10]  330 	ret
                            331 ;src/StateManager.c:143: void statemanager_manage_input(){
                            332 ;	---------------------------------
                            333 ; Function statemanager_manage_input
                            334 ; ---------------------------------
   23D5                     335 _statemanager_manage_input::
                            336 ;src/StateManager.c:144: while(!inputReceived){
   23D5                     337 00101$:
   23D5 3A 16 23      [13]  338 	ld	a,(#_inputReceived + 0)
   23D8 B7            [ 4]  339 	or	a, a
   23D9 20 21         [12]  340 	jr	NZ,00103$
                            341 ;src/StateManager.c:145: scan_input();
   23DB CD 78 23      [17]  342 	call	_scan_input
                            343 ;src/StateManager.c:146: stateArray[currentState].inputState();
   23DE 21 14 23      [10]  344 	ld	hl,#_currentState + 0
   23E1 4E            [ 7]  345 	ld	c, (hl)
   23E2 06 00         [ 7]  346 	ld	b,#0x00
   23E4 69            [ 4]  347 	ld	l, c
   23E5 60            [ 4]  348 	ld	h, b
   23E6 29            [11]  349 	add	hl, hl
   23E7 09            [11]  350 	add	hl, bc
   23E8 29            [11]  351 	add	hl, hl
   23E9 09            [11]  352 	add	hl, bc
   23EA 29            [11]  353 	add	hl, hl
   23EB 11 DB 22      [10]  354 	ld	de,#_stateArray
   23EE 19            [11]  355 	add	hl,de
   23EF 11 06 00      [10]  356 	ld	de, #0x0006
   23F2 19            [11]  357 	add	hl, de
   23F3 4E            [ 7]  358 	ld	c,(hl)
   23F4 23            [ 6]  359 	inc	hl
   23F5 66            [ 7]  360 	ld	h,(hl)
   23F6 69            [ 4]  361 	ld	l, c
   23F7 CD 0A 59      [17]  362 	call	___sdcc_call_hl
   23FA 18 D9         [12]  363 	jr	00101$
   23FC                     364 00103$:
                            365 ;src/StateManager.c:148: *(u8*)&inputReceived=0;
   23FC 21 16 23      [10]  366 	ld	hl,#_inputReceived
   23FF 36 00         [10]  367 	ld	(hl),#0x00
   2401 C9            [10]  368 	ret
                            369 ;src/StateManager.c:151: void statemanager_render_state(){
                            370 ;	---------------------------------
                            371 ; Function statemanager_render_state
                            372 ; ---------------------------------
   2402                     373 _statemanager_render_state::
                            374 ;src/StateManager.c:152: cpct_waitVSYNC();
   2402 CD 26 59      [17]  375 	call	_cpct_waitVSYNC
                            376 ;src/StateManager.c:153: stateArray[currentState].renderState();
   2405 01 DB 22      [10]  377 	ld	bc,#_stateArray+0
   2408 21 14 23      [10]  378 	ld	hl,#_currentState + 0
   240B 5E            [ 7]  379 	ld	e, (hl)
   240C 16 00         [ 7]  380 	ld	d,#0x00
   240E 6B            [ 4]  381 	ld	l, e
   240F 62            [ 4]  382 	ld	h, d
   2410 29            [11]  383 	add	hl, hl
   2411 19            [11]  384 	add	hl, de
   2412 29            [11]  385 	add	hl, hl
   2413 19            [11]  386 	add	hl, de
   2414 29            [11]  387 	add	hl, hl
   2415 09            [11]  388 	add	hl,bc
   2416 11 0A 00      [10]  389 	ld	de, #0x000A
   2419 19            [11]  390 	add	hl, de
   241A 4E            [ 7]  391 	ld	c,(hl)
   241B 23            [ 6]  392 	inc	hl
   241C 66            [ 7]  393 	ld	h,(hl)
   241D 69            [ 4]  394 	ld	l, c
   241E C3 0A 59      [10]  395 	jp  ___sdcc_call_hl
                            396 ;src/StateManager.c:156: void statemanager_close_state(){
                            397 ;	---------------------------------
                            398 ; Function statemanager_close_state
                            399 ; ---------------------------------
   2421                     400 _statemanager_close_state::
                            401 ;src/StateManager.c:157: *(u8*)&closeState=1;
   2421 21 13 23      [10]  402 	ld	hl,#_closeState
   2424 36 01         [10]  403 	ld	(hl),#0x01
   2426 C9            [10]  404 	ret
                            405 ;src/StateManager.c:160: void statemanager_update_state(){
                            406 ;	---------------------------------
                            407 ; Function statemanager_update_state
                            408 ; ---------------------------------
   2427                     409 _statemanager_update_state::
                            410 ;src/StateManager.c:161: stateArray[currentState].updateState();
   2427 01 DB 22      [10]  411 	ld	bc,#_stateArray+0
   242A 21 14 23      [10]  412 	ld	hl,#_currentState + 0
   242D 5E            [ 7]  413 	ld	e, (hl)
   242E 16 00         [ 7]  414 	ld	d,#0x00
   2430 6B            [ 4]  415 	ld	l, e
   2431 62            [ 4]  416 	ld	h, d
   2432 29            [11]  417 	add	hl, hl
   2433 19            [11]  418 	add	hl, de
   2434 29            [11]  419 	add	hl, hl
   2435 19            [11]  420 	add	hl, de
   2436 29            [11]  421 	add	hl, hl
   2437 09            [11]  422 	add	hl,bc
   2438 11 08 00      [10]  423 	ld	de, #0x0008
   243B 19            [11]  424 	add	hl, de
   243C 4E            [ 7]  425 	ld	c,(hl)
   243D 23            [ 6]  426 	inc	hl
   243E 66            [ 7]  427 	ld	h,(hl)
   243F 69            [ 4]  428 	ld	l, c
   2440 C3 0A 59      [10]  429 	jp  ___sdcc_call_hl
                            430 ;src/StateManager.c:164: void statemanager_exit_game(){
                            431 ;	---------------------------------
                            432 ; Function statemanager_exit_game
                            433 ; ---------------------------------
   2443                     434 _statemanager_exit_game::
                            435 ;src/StateManager.c:165: *(u8*)&gameRunning=0;
   2443 21 17 23      [10]  436 	ld	hl,#_gameRunning
   2446 36 00         [10]  437 	ld	(hl),#0x00
   2448 C9            [10]  438 	ret
                            439 ;src/StateManager.c:168: void statemanager_main_loop(){
                            440 ;	---------------------------------
                            441 ; Function statemanager_main_loop
                            442 ; ---------------------------------
   2449                     443 _statemanager_main_loop::
                            444 ;src/StateManager.c:169: while(gameRunning) {
   2449                     445 00101$:
   2449 3A 17 23      [13]  446 	ld	a,(#_gameRunning + 0)
   244C B7            [ 4]  447 	or	a, a
   244D C8            [11]  448 	ret	Z
                            449 ;src/StateManager.c:170: statemanager_drop_state();
   244E CD 85 22      [17]  450 	call	_statemanager_drop_state
                            451 ;src/StateManager.c:171: statemanager_change_state();
   2451 CD 22 23      [17]  452 	call	_statemanager_change_state
                            453 ;src/StateManager.c:172: statemanager_manage_input();
   2454 CD D5 23      [17]  454 	call	_statemanager_manage_input
                            455 ;src/StateManager.c:173: statemanager_update_state();
   2457 CD 27 24      [17]  456 	call	_statemanager_update_state
                            457 ;src/StateManager.c:174: statemanager_render_state();
   245A CD 02 24      [17]  458 	call	_statemanager_render_state
   245D 18 EA         [12]  459 	jr	00101$
                            460 	.area _CODE
                            461 	.area _INITIALIZER
                            462 	.area _CABS (ABS)
