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
   1C9C                      66 _statemanager_drop_state::
                             67 ;src/StateManager.c:97: if(closeState){
   1C9C 3A 2A 1D      [13]   68 	ld	a,(#_closeState + 0)
   1C9F B7            [ 4]   69 	or	a, a
   1CA0 C8            [11]   70 	ret	Z
                             71 ;src/StateManager.c:98: stateArray[currentState].exitState();
   1CA1 01 F2 1C      [10]   72 	ld	bc,#_stateArray+0
   1CA4 21 2B 1D      [10]   73 	ld	hl,#_currentState + 0
   1CA7 5E            [ 7]   74 	ld	e, (hl)
   1CA8 16 00         [ 7]   75 	ld	d,#0x00
   1CAA 6B            [ 4]   76 	ld	l, e
   1CAB 62            [ 4]   77 	ld	h, d
   1CAC 29            [11]   78 	add	hl, hl
   1CAD 19            [11]   79 	add	hl, de
   1CAE 29            [11]   80 	add	hl, hl
   1CAF 19            [11]   81 	add	hl, de
   1CB0 29            [11]   82 	add	hl, hl
   1CB1 09            [11]   83 	add	hl,bc
   1CB2 11 0C 00      [10]   84 	ld	de, #0x000C
   1CB5 19            [11]   85 	add	hl, de
   1CB6 5E            [ 7]   86 	ld	e,(hl)
   1CB7 23            [ 6]   87 	inc	hl
   1CB8 66            [ 7]   88 	ld	h,(hl)
   1CB9 C5            [11]   89 	push	bc
   1CBA 6B            [ 4]   90 	ld	l, e
   1CBB CD 68 4D      [17]   91 	call	___sdcc_call_hl
   1CBE C1            [10]   92 	pop	bc
                             93 ;src/StateManager.c:99: *(u8*)&currentState = stateArray[currentState].lastStateid;
   1CBF 21 2B 1D      [10]   94 	ld	hl,#_currentState + 0
   1CC2 5E            [ 7]   95 	ld	e, (hl)
   1CC3 16 00         [ 7]   96 	ld	d,#0x00
   1CC5 6B            [ 4]   97 	ld	l, e
   1CC6 62            [ 4]   98 	ld	h, d
   1CC7 29            [11]   99 	add	hl, hl
   1CC8 19            [11]  100 	add	hl, de
   1CC9 29            [11]  101 	add	hl, hl
   1CCA 19            [11]  102 	add	hl, de
   1CCB 29            [11]  103 	add	hl, hl
   1CCC 09            [11]  104 	add	hl,bc
   1CCD 23            [ 6]  105 	inc	hl
   1CCE 5E            [ 7]  106 	ld	e,(hl)
   1CCF 21 2B 1D      [10]  107 	ld	hl,#_currentState
   1CD2 73            [ 7]  108 	ld	(hl),e
                            109 ;src/StateManager.c:100: stateArray[currentState].returnState();
   1CD3 21 2B 1D      [10]  110 	ld	hl,#_currentState + 0
   1CD6 5E            [ 7]  111 	ld	e, (hl)
   1CD7 16 00         [ 7]  112 	ld	d,#0x00
   1CD9 6B            [ 4]  113 	ld	l, e
   1CDA 62            [ 4]  114 	ld	h, d
   1CDB 29            [11]  115 	add	hl, hl
   1CDC 19            [11]  116 	add	hl, de
   1CDD 29            [11]  117 	add	hl, hl
   1CDE 19            [11]  118 	add	hl, de
   1CDF 29            [11]  119 	add	hl, hl
   1CE0 09            [11]  120 	add	hl,bc
   1CE1 11 04 00      [10]  121 	ld	de, #0x0004
   1CE4 19            [11]  122 	add	hl, de
   1CE5 7E            [ 7]  123 	ld	a, (hl)
   1CE6 23            [ 6]  124 	inc	hl
   1CE7 66            [ 7]  125 	ld	h,(hl)
   1CE8 6F            [ 4]  126 	ld	l,a
   1CE9 CD 68 4D      [17]  127 	call	___sdcc_call_hl
                            128 ;src/StateManager.c:101: *(u8*)&closeState=0;
   1CEC 21 2A 1D      [10]  129 	ld	hl,#_closeState
   1CEF 36 00         [10]  130 	ld	(hl),#0x00
   1CF1 C9            [10]  131 	ret
   1CF2                     132 _stateArray:
   1CF2 00                  133 	.db #0x00	; 0
   1CF3 00                  134 	.db #0x00	; 0
   1CF4 F2 1B               135 	.dw _state_mainmenu_enter
   1CF6 25 1C               136 	.dw _state_mainmenu_return
   1CF8 28 1C               137 	.dw _state_mainmenu_input
   1CFA 57 1C               138 	.dw _state_mainmenu_update
   1CFC 98 1C               139 	.dw _state_mainmenu_render
   1CFE 9B 1C               140 	.dw _state_mainmenu_exit
   1D00 01                  141 	.db #0x01	; 1
   1D01 00                  142 	.db #0x00	; 0
   1D02 3D 1A               143 	.dw _state_ingame_enter
   1D04 59 1A               144 	.dw _state_ingame_return
   1D06 5F 1A               145 	.dw _state_ingame_input
   1D08 E4 1A               146 	.dw _state_ingame_update
   1D0A 87 1B               147 	.dw _state_ingame_render
   1D0C AF 1B               148 	.dw _state_ingame_exit
   1D0E 02                  149 	.db #0x02	; 2
   1D0F 00                  150 	.db #0x00	; 0
   1D10 7C 1E               151 	.dw _state_pausemenu_enter
   1D12 AA 1E               152 	.dw _state_pausemenu_return
   1D14 AD 1E               153 	.dw _state_pausemenu_input
   1D16 DC 1E               154 	.dw _state_pausemenu_update
   1D18 1A 1F               155 	.dw _state_pausemenu_render
   1D1A 1D 1F               156 	.dw _state_pausemenu_exit
   1D1C 03                  157 	.db #0x03	; 3
   1D1D 00                  158 	.db #0x00	; 0
   1D1E B0 1B               159 	.dw _state_loadlevel_enter
   1D20 E7 1B               160 	.dw _state_loadlevel_return
   1D22 E8 1B               161 	.dw _state_loadlevel_input
   1D24 EB 1B               162 	.dw _state_loadlevel_update
   1D26 F0 1B               163 	.dw _state_loadlevel_render
   1D28 F1 1B               164 	.dw _state_loadlevel_exit
   1D2A                     165 _closeState:
   1D2A 00                  166 	.db #0x00	; 0
   1D2B                     167 _currentState:
   1D2B 00                  168 	.db #0x00	; 0
   1D2C                     169 _changeToState:
   1D2C 00                  170 	.db #0x00	; 0
   1D2D                     171 _inputReceived:
   1D2D 00                  172 	.db #0x00	; 0
   1D2E                     173 _gameRunning:
   1D2E 01                  174 	.db #0x01	; 1
   1D2F                     175 _last_keyboardStatusBuffer:
   1D2F FF                  176 	.db #0xFF	; 255
   1D30 FF                  177 	.db #0xFF	; 255
   1D31 FF                  178 	.db #0xFF	; 255
   1D32 FF                  179 	.db #0xFF	; 255
   1D33 FF                  180 	.db #0xFF	; 255
   1D34 FF                  181 	.db #0xFF	; 255
   1D35 FF                  182 	.db #0xFF	; 255
   1D36 FF                  183 	.db #0xFF	; 255
   1D37 FF                  184 	.db #0xFF	; 255
   1D38 FF                  185 	.db #0xFF	; 255
                            186 ;src/StateManager.c:105: void statemanager_change_state(){
                            187 ;	---------------------------------
                            188 ; Function statemanager_change_state
                            189 ; ---------------------------------
   1D39                     190 _statemanager_change_state::
                            191 ;src/StateManager.c:106: if(changeToState){
   1D39 21 2C 1D      [10]  192 	ld	hl,#_changeToState + 0
   1D3C 4E            [ 7]  193 	ld	c, (hl)
   1D3D 3A 2C 1D      [13]  194 	ld	a,(#_changeToState + 0)
   1D40 B7            [ 4]  195 	or	a, a
   1D41 C8            [11]  196 	ret	Z
                            197 ;src/StateManager.c:107: *(u8*)&(stateArray[changeToState-1].lastStateid) = currentState;
   1D42 11 F2 1C      [10]  198 	ld	de,#_stateArray+0
   1D45 0D            [ 4]  199 	dec	c
   1D46 06 00         [ 7]  200 	ld	b,#0x00
   1D48 69            [ 4]  201 	ld	l, c
   1D49 60            [ 4]  202 	ld	h, b
   1D4A 29            [11]  203 	add	hl, hl
   1D4B 09            [11]  204 	add	hl, bc
   1D4C 29            [11]  205 	add	hl, hl
   1D4D 09            [11]  206 	add	hl, bc
   1D4E 29            [11]  207 	add	hl, hl
   1D4F 19            [11]  208 	add	hl,de
   1D50 23            [ 6]  209 	inc	hl
   1D51 FD 21 2B 1D   [14]  210 	ld	iy,#_currentState
   1D55 FD 4E 00      [19]  211 	ld	c,0 (iy)
   1D58 71            [ 7]  212 	ld	(hl),c
                            213 ;src/StateManager.c:108: *(u8*)&currentState = changeToState-1;
   1D59 21 2B 1D      [10]  214 	ld	hl,#_currentState+0
   1D5C FD 21 2C 1D   [14]  215 	ld	iy,#_changeToState
   1D60 FD 4E 00      [19]  216 	ld	c,0 (iy)
   1D63 0D            [ 4]  217 	dec	c
   1D64 71            [ 7]  218 	ld	(hl),c
                            219 ;src/StateManager.c:109: stateArray[currentState].enterState();
   1D65 21 2B 1D      [10]  220 	ld	hl,#_currentState + 0
   1D68 4E            [ 7]  221 	ld	c, (hl)
   1D69 06 00         [ 7]  222 	ld	b,#0x00
   1D6B 69            [ 4]  223 	ld	l, c
   1D6C 60            [ 4]  224 	ld	h, b
   1D6D 29            [11]  225 	add	hl, hl
   1D6E 09            [11]  226 	add	hl, bc
   1D6F 29            [11]  227 	add	hl, hl
   1D70 09            [11]  228 	add	hl, bc
   1D71 29            [11]  229 	add	hl, hl
   1D72 19            [11]  230 	add	hl,de
   1D73 23            [ 6]  231 	inc	hl
   1D74 23            [ 6]  232 	inc	hl
   1D75 4E            [ 7]  233 	ld	c,(hl)
   1D76 23            [ 6]  234 	inc	hl
   1D77 66            [ 7]  235 	ld	h,(hl)
   1D78 69            [ 4]  236 	ld	l, c
   1D79 CD 68 4D      [17]  237 	call	___sdcc_call_hl
                            238 ;src/StateManager.c:110: *(u8*)&changeToState = 0;
   1D7C 21 2C 1D      [10]  239 	ld	hl,#_changeToState
   1D7F 36 00         [10]  240 	ld	(hl),#0x00
   1D81 C9            [10]  241 	ret
                            242 ;src/StateManager.c:114: void statemanager_input_accepted(){
                            243 ;	---------------------------------
                            244 ; Function statemanager_input_accepted
                            245 ; ---------------------------------
   1D82                     246 _statemanager_input_accepted::
                            247 ;src/StateManager.c:115: *(u8*)&inputReceived=1;
   1D82 21 2D 1D      [10]  248 	ld	hl,#_inputReceived
   1D85 36 01         [10]  249 	ld	(hl),#0x01
   1D87 C9            [10]  250 	ret
                            251 ;src/StateManager.c:118: void statemanager_set_state(u8 state) __z88dk_fastcall{
                            252 ;	---------------------------------
                            253 ; Function statemanager_set_state
                            254 ; ---------------------------------
   1D88                     255 _statemanager_set_state::
                            256 ;src/StateManager.c:119: *(u8*)&changeToState = state+1;
   1D88 01 2C 1D      [10]  257 	ld	bc,#_changeToState+0
   1D8B 7D            [ 4]  258 	ld	a,l
   1D8C 3C            [ 4]  259 	inc	a
   1D8D 02            [ 7]  260 	ld	(bc),a
   1D8E C9            [10]  261 	ret
                            262 ;src/StateManager.c:122: void scan_input(){
                            263 ;	---------------------------------
                            264 ; Function scan_input
                            265 ; ---------------------------------
   1D8F                     266 _scan_input::
   1D8F DD E5         [15]  267 	push	ix
   1D91 DD 21 00 00   [14]  268 	ld	ix,#0
   1D95 DD 39         [15]  269 	add	ix,sp
   1D97 F5            [11]  270 	push	af
   1D98 3B            [ 6]  271 	dec	sp
                            272 ;src/StateManager.c:123: u8 t,n=10, anyKeyPressed=0xFF;
   1D99 DD 36 FD FF   [19]  273 	ld	-3 (ix),#0xFF
                            274 ;src/StateManager.c:124: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
                            275 ;src/StateManager.c:125: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
                            276 ;src/StateManager.c:127: cpct_scanKeyboard_f();
   1D9D CD 43 4B      [17]  277 	call	_cpct_scanKeyboard_f
                            278 ;src/StateManager.c:128: while(n){
   1DA0 1E 0A         [ 7]  279 	ld	e,#0x0A
   1DA2 01 F6 4C      [10]  280 	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
   1DA5 FD 21 39 1D   [14]  281 	ld	iy,#(_last_keyboardStatusBuffer + 0x000a)
   1DA9                     282 00101$:
   1DA9 7B            [ 4]  283 	ld	a,e
   1DAA B7            [ 4]  284 	or	a, a
   1DAB 28 24         [12]  285 	jr	Z,00103$
                            286 ;src/StateManager.c:129: --n;
   1DAD 1D            [ 4]  287 	dec	e
                            288 ;src/StateManager.c:130: --currentStatus;
   1DAE 0B            [ 6]  289 	dec	bc
                            290 ;src/StateManager.c:131: --lastStatus;
   1DAF FD 2B         [10]  291 	dec	iy
                            292 ;src/StateManager.c:133: t=*(currentStatus);
   1DB1 0A            [ 7]  293 	ld	a,(bc)
   1DB2 57            [ 4]  294 	ld	d,a
                            295 ;src/StateManager.c:134: anyKeyPressed&=t;
   1DB3 DD 7E FD      [19]  296 	ld	a,-3 (ix)
   1DB6 A2            [ 4]  297 	and	a, d
   1DB7 DD 77 FD      [19]  298 	ld	-3 (ix),a
                            299 ;src/StateManager.c:135: *currentStatus=((*lastStatus)|(~t));
   1DBA FD 7E 00      [19]  300 	ld	a, 0 (iy)
   1DBD DD 77 FF      [19]  301 	ld	-1 (ix),a
   1DC0 7A            [ 4]  302 	ld	a,d
   1DC1 2F            [ 4]  303 	cpl
   1DC2 DD 77 FE      [19]  304 	ld	-2 (ix),a
   1DC5 DD 7E FF      [19]  305 	ld	a,-1 (ix)
   1DC8 DD B6 FE      [19]  306 	or	a, -2 (ix)
   1DCB 02            [ 7]  307 	ld	(bc),a
                            308 ;src/StateManager.c:136: *lastStatus=t;
   1DCC FD 72 00      [19]  309 	ld	0 (iy), d
   1DCF 18 D8         [12]  310 	jr	00101$
   1DD1                     311 00103$:
                            312 ;src/StateManager.c:140: if(~anyKeyPressed) ++r_counter;
   1DD1 DD 7E FD      [19]  313 	ld	a, -3 (ix)
   1DD4 06 00         [ 7]  314 	ld	b, #0x00
   1DD6 2F            [ 4]  315 	cpl
   1DD7 4F            [ 4]  316 	ld	c,a
   1DD8 78            [ 4]  317 	ld	a,b
   1DD9 2F            [ 4]  318 	cpl
   1DDA B1            [ 4]  319 	or	a,c
   1DDB 28 0A         [12]  320 	jr	Z,00106$
   1DDD 21 A1 4F      [10]  321 	ld	hl, #_r_counter+0
   1DE0 34            [11]  322 	inc	(hl)
   1DE1 20 04         [12]  323 	jr	NZ,00121$
   1DE3 21 A2 4F      [10]  324 	ld	hl, #_r_counter+1
   1DE6 34            [11]  325 	inc	(hl)
   1DE7                     326 00121$:
   1DE7                     327 00106$:
   1DE7 DD F9         [10]  328 	ld	sp, ix
   1DE9 DD E1         [14]  329 	pop	ix
   1DEB C9            [10]  330 	ret
                            331 ;src/StateManager.c:143: void statemanager_manage_input(){
                            332 ;	---------------------------------
                            333 ; Function statemanager_manage_input
                            334 ; ---------------------------------
   1DEC                     335 _statemanager_manage_input::
                            336 ;src/StateManager.c:144: while(!inputReceived){
   1DEC                     337 00101$:
   1DEC 3A 2D 1D      [13]  338 	ld	a,(#_inputReceived + 0)
   1DEF B7            [ 4]  339 	or	a, a
   1DF0 20 21         [12]  340 	jr	NZ,00103$
                            341 ;src/StateManager.c:145: scan_input();
   1DF2 CD 8F 1D      [17]  342 	call	_scan_input
                            343 ;src/StateManager.c:146: stateArray[currentState].inputState();
   1DF5 21 2B 1D      [10]  344 	ld	hl,#_currentState + 0
   1DF8 4E            [ 7]  345 	ld	c, (hl)
   1DF9 06 00         [ 7]  346 	ld	b,#0x00
   1DFB 69            [ 4]  347 	ld	l, c
   1DFC 60            [ 4]  348 	ld	h, b
   1DFD 29            [11]  349 	add	hl, hl
   1DFE 09            [11]  350 	add	hl, bc
   1DFF 29            [11]  351 	add	hl, hl
   1E00 09            [11]  352 	add	hl, bc
   1E01 29            [11]  353 	add	hl, hl
   1E02 11 F2 1C      [10]  354 	ld	de,#_stateArray
   1E05 19            [11]  355 	add	hl,de
   1E06 11 06 00      [10]  356 	ld	de, #0x0006
   1E09 19            [11]  357 	add	hl, de
   1E0A 4E            [ 7]  358 	ld	c,(hl)
   1E0B 23            [ 6]  359 	inc	hl
   1E0C 66            [ 7]  360 	ld	h,(hl)
   1E0D 69            [ 4]  361 	ld	l, c
   1E0E CD 68 4D      [17]  362 	call	___sdcc_call_hl
   1E11 18 D9         [12]  363 	jr	00101$
   1E13                     364 00103$:
                            365 ;src/StateManager.c:148: *(u8*)&inputReceived=0;
   1E13 21 2D 1D      [10]  366 	ld	hl,#_inputReceived
   1E16 36 00         [10]  367 	ld	(hl),#0x00
   1E18 C9            [10]  368 	ret
                            369 ;src/StateManager.c:151: void statemanager_render_state(){
                            370 ;	---------------------------------
                            371 ; Function statemanager_render_state
                            372 ; ---------------------------------
   1E19                     373 _statemanager_render_state::
                            374 ;src/StateManager.c:152: cpct_waitVSYNC();
   1E19 CD 84 4D      [17]  375 	call	_cpct_waitVSYNC
                            376 ;src/StateManager.c:153: stateArray[currentState].renderState();
   1E1C 01 F2 1C      [10]  377 	ld	bc,#_stateArray+0
   1E1F 21 2B 1D      [10]  378 	ld	hl,#_currentState + 0
   1E22 5E            [ 7]  379 	ld	e, (hl)
   1E23 16 00         [ 7]  380 	ld	d,#0x00
   1E25 6B            [ 4]  381 	ld	l, e
   1E26 62            [ 4]  382 	ld	h, d
   1E27 29            [11]  383 	add	hl, hl
   1E28 19            [11]  384 	add	hl, de
   1E29 29            [11]  385 	add	hl, hl
   1E2A 19            [11]  386 	add	hl, de
   1E2B 29            [11]  387 	add	hl, hl
   1E2C 09            [11]  388 	add	hl,bc
   1E2D 11 0A 00      [10]  389 	ld	de, #0x000A
   1E30 19            [11]  390 	add	hl, de
   1E31 4E            [ 7]  391 	ld	c,(hl)
   1E32 23            [ 6]  392 	inc	hl
   1E33 66            [ 7]  393 	ld	h,(hl)
   1E34 69            [ 4]  394 	ld	l, c
   1E35 C3 68 4D      [10]  395 	jp  ___sdcc_call_hl
                            396 ;src/StateManager.c:156: void statemanager_close_state(){
                            397 ;	---------------------------------
                            398 ; Function statemanager_close_state
                            399 ; ---------------------------------
   1E38                     400 _statemanager_close_state::
                            401 ;src/StateManager.c:157: *(u8*)&closeState=1;
   1E38 21 2A 1D      [10]  402 	ld	hl,#_closeState
   1E3B 36 01         [10]  403 	ld	(hl),#0x01
   1E3D C9            [10]  404 	ret
                            405 ;src/StateManager.c:160: void statemanager_update_state(){
                            406 ;	---------------------------------
                            407 ; Function statemanager_update_state
                            408 ; ---------------------------------
   1E3E                     409 _statemanager_update_state::
                            410 ;src/StateManager.c:161: stateArray[currentState].updateState();
   1E3E 01 F2 1C      [10]  411 	ld	bc,#_stateArray+0
   1E41 21 2B 1D      [10]  412 	ld	hl,#_currentState + 0
   1E44 5E            [ 7]  413 	ld	e, (hl)
   1E45 16 00         [ 7]  414 	ld	d,#0x00
   1E47 6B            [ 4]  415 	ld	l, e
   1E48 62            [ 4]  416 	ld	h, d
   1E49 29            [11]  417 	add	hl, hl
   1E4A 19            [11]  418 	add	hl, de
   1E4B 29            [11]  419 	add	hl, hl
   1E4C 19            [11]  420 	add	hl, de
   1E4D 29            [11]  421 	add	hl, hl
   1E4E 09            [11]  422 	add	hl,bc
   1E4F 11 08 00      [10]  423 	ld	de, #0x0008
   1E52 19            [11]  424 	add	hl, de
   1E53 4E            [ 7]  425 	ld	c,(hl)
   1E54 23            [ 6]  426 	inc	hl
   1E55 66            [ 7]  427 	ld	h,(hl)
   1E56 69            [ 4]  428 	ld	l, c
   1E57 C3 68 4D      [10]  429 	jp  ___sdcc_call_hl
                            430 ;src/StateManager.c:164: void statemanager_exit_game(){
                            431 ;	---------------------------------
                            432 ; Function statemanager_exit_game
                            433 ; ---------------------------------
   1E5A                     434 _statemanager_exit_game::
                            435 ;src/StateManager.c:165: *(u8*)&gameRunning=0;
   1E5A 21 2E 1D      [10]  436 	ld	hl,#_gameRunning
   1E5D 36 00         [10]  437 	ld	(hl),#0x00
   1E5F C9            [10]  438 	ret
                            439 ;src/StateManager.c:168: void statemanager_main_loop(){
                            440 ;	---------------------------------
                            441 ; Function statemanager_main_loop
                            442 ; ---------------------------------
   1E60                     443 _statemanager_main_loop::
                            444 ;src/StateManager.c:169: while(gameRunning) {
   1E60                     445 00101$:
   1E60 3A 2E 1D      [13]  446 	ld	a,(#_gameRunning + 0)
   1E63 B7            [ 4]  447 	or	a, a
   1E64 C8            [11]  448 	ret	Z
                            449 ;src/StateManager.c:170: statemanager_drop_state();
   1E65 CD 9C 1C      [17]  450 	call	_statemanager_drop_state
                            451 ;src/StateManager.c:171: statemanager_change_state();
   1E68 CD 39 1D      [17]  452 	call	_statemanager_change_state
                            453 ;src/StateManager.c:172: statemanager_manage_input();
   1E6B CD EC 1D      [17]  454 	call	_statemanager_manage_input
                            455 ;src/StateManager.c:173: statemanager_update_state();
   1E6E CD 3E 1E      [17]  456 	call	_statemanager_update_state
                            457 ;src/StateManager.c:174: statemanager_render_state();
   1E71 CD 19 1E      [17]  458 	call	_statemanager_render_state
   1E74 18 EA         [12]  459 	jr	00101$
                            460 	.area _CODE
                            461 	.area _INITIALIZER
                            462 	.area _CABS (ABS)
