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
                             15 	.globl _cpct_waitVSYNC
                             16 	.globl _cpct_scanKeyboard_f
                             17 	.globl _last_keyboardStatusBuffer
                             18 	.globl _inputReceived
                             19 	.globl _changeToState
                             20 	.globl _currentState
                             21 	.globl _stateArray
                             22 	.globl _statemanager_input_accepted
                             23 	.globl _statemanager_set_state
                             24 	.globl _scan_input
                             25 	.globl _statemanager_close_state
                             26 	.globl _statemanager_main_loop
                             27 ;--------------------------------------------------------
                             28 ; special function registers
                             29 ;--------------------------------------------------------
                             30 ;--------------------------------------------------------
                             31 ; ram data
                             32 ;--------------------------------------------------------
                             33 	.area _DATA
                             34 ;--------------------------------------------------------
                             35 ; ram data
                             36 ;--------------------------------------------------------
                             37 	.area _INITIALIZED
                             38 ;--------------------------------------------------------
                             39 ; absolute external ram data
                             40 ;--------------------------------------------------------
                             41 	.area _DABS (ABS)
                             42 ;--------------------------------------------------------
                             43 ; global & static initialisations
                             44 ;--------------------------------------------------------
                             45 	.area _HOME
                             46 	.area _GSINIT
                             47 	.area _GSFINAL
                             48 	.area _GSINIT
                             49 ;--------------------------------------------------------
                             50 ; Home
                             51 ;--------------------------------------------------------
                             52 	.area _HOME
                             53 	.area _HOME
                             54 ;--------------------------------------------------------
                             55 ; code
                             56 ;--------------------------------------------------------
                             57 	.area _CODE
                             58 ;src/StateManager.c:52: void statemanager_change_state(){
                             59 ;	---------------------------------
                             60 ; Function statemanager_change_state
                             61 ; ---------------------------------
   1C33                      62 _statemanager_change_state::
                             63 ;src/StateManager.c:53: if(changeToState){
   1C33 21 7D 1C      [10]   64 	ld	hl,#_changeToState + 0
   1C36 4E            [ 7]   65 	ld	c, (hl)
   1C37 3A 7D 1C      [13]   66 	ld	a,(#_changeToState + 0)
   1C3A B7            [ 4]   67 	or	a, a
   1C3B C8            [11]   68 	ret	Z
                             69 ;src/StateManager.c:54: *(u8*)&currentState = changeToState-1;
   1C3C 21 7C 1C      [10]   70 	ld	hl,#_currentState+0
   1C3F 0D            [ 4]   71 	dec	c
   1C40 71            [ 7]   72 	ld	(hl),c
                             73 ;src/StateManager.c:55: stateArray[currentState].enterState();
   1C41 01 5E 1C      [10]   74 	ld	bc,#_stateArray+0
   1C44 21 7C 1C      [10]   75 	ld	hl,#_currentState + 0
   1C47 5E            [ 7]   76 	ld	e, (hl)
   1C48 16 00         [ 7]   77 	ld	d,#0x00
   1C4A 6B            [ 4]   78 	ld	l, e
   1C4B 62            [ 4]   79 	ld	h, d
   1C4C 29            [11]   80 	add	hl, hl
   1C4D 29            [11]   81 	add	hl, hl
   1C4E 19            [11]   82 	add	hl, de
   1C4F 29            [11]   83 	add	hl, hl
   1C50 09            [11]   84 	add	hl,bc
   1C51 4E            [ 7]   85 	ld	c,(hl)
   1C52 23            [ 6]   86 	inc	hl
   1C53 66            [ 7]   87 	ld	h,(hl)
   1C54 69            [ 4]   88 	ld	l, c
   1C55 CD DB 42      [17]   89 	call	___sdcc_call_hl
                             90 ;src/StateManager.c:56: *(u8*)&changeToState = 0;
   1C58 21 7D 1C      [10]   91 	ld	hl,#_changeToState
   1C5B 36 00         [10]   92 	ld	(hl),#0x00
   1C5D C9            [10]   93 	ret
   1C5E                      94 _stateArray:
   1C5E ED 1B                95 	.dw _state_mainmenu_enter
   1C60 F0 1B                96 	.dw _state_mainmenu_input
   1C62 04 1C                97 	.dw _state_mainmenu_update
   1C64 05 1C                98 	.dw _state_mainmenu_render
   1C66 32 1C                99 	.dw _state_mainmenu_exit
   1C68 3B 1A               100 	.dw _state_ingame_enter
   1C6A 72 1A               101 	.dw _state_ingame_input
   1C6C EA 1A               102 	.dw _state_ingame_update
   1C6E C2 1B               103 	.dw _state_ingame_render
   1C70 E7 1B               104 	.dw _state_ingame_exit
   1C72 80 1D               105 	.dw _state_pausemenu_enter
   1C74 A7 1D               106 	.dw _state_pausemenu_input
   1C76 D7 1D               107 	.dw _state_pausemenu_update
   1C78 D8 1D               108 	.dw _state_pausemenu_render
   1C7A D9 1D               109 	.dw _state_pausemenu_exit
   1C7C                     110 _currentState:
   1C7C 00                  111 	.db #0x00	; 0
   1C7D                     112 _changeToState:
   1C7D 00                  113 	.db #0x00	; 0
   1C7E                     114 _inputReceived:
   1C7E 00                  115 	.db #0x00	; 0
   1C7F                     116 _last_keyboardStatusBuffer:
   1C7F FF                  117 	.db #0xFF	; 255
   1C80 FF                  118 	.db #0xFF	; 255
   1C81 FF                  119 	.db #0xFF	; 255
   1C82 FF                  120 	.db #0xFF	; 255
   1C83 FF                  121 	.db #0xFF	; 255
   1C84 FF                  122 	.db #0xFF	; 255
   1C85 FF                  123 	.db #0xFF	; 255
   1C86 FF                  124 	.db #0xFF	; 255
   1C87 FF                  125 	.db #0xFF	; 255
   1C88 FF                  126 	.db #0xFF	; 255
                            127 ;src/StateManager.c:60: void statemanager_input_accepted(){
                            128 ;	---------------------------------
                            129 ; Function statemanager_input_accepted
                            130 ; ---------------------------------
   1C89                     131 _statemanager_input_accepted::
                            132 ;src/StateManager.c:61: *(u8*)&inputReceived=1;
   1C89 21 7E 1C      [10]  133 	ld	hl,#_inputReceived
   1C8C 36 01         [10]  134 	ld	(hl),#0x01
   1C8E C9            [10]  135 	ret
                            136 ;src/StateManager.c:64: void statemanager_set_state(u8 state){
                            137 ;	---------------------------------
                            138 ; Function statemanager_set_state
                            139 ; ---------------------------------
   1C8F                     140 _statemanager_set_state::
                            141 ;src/StateManager.c:65: *(u8*)&changeToState = state+1;
   1C8F 01 7D 1C      [10]  142 	ld	bc,#_changeToState+0
   1C92 21 02 00      [10]  143 	ld	hl, #2+0
   1C95 39            [11]  144 	add	hl, sp
   1C96 7E            [ 7]  145 	ld	a, (hl)
   1C97 3C            [ 4]  146 	inc	a
   1C98 02            [ 7]  147 	ld	(bc),a
   1C99 C9            [10]  148 	ret
                            149 ;src/StateManager.c:68: void scan_input(){
                            150 ;	---------------------------------
                            151 ; Function scan_input
                            152 ; ---------------------------------
   1C9A                     153 _scan_input::
   1C9A DD E5         [15]  154 	push	ix
   1C9C DD 21 00 00   [14]  155 	ld	ix,#0
   1CA0 DD 39         [15]  156 	add	ix,sp
   1CA2 F5            [11]  157 	push	af
   1CA3 F5            [11]  158 	push	af
   1CA4 3B            [ 6]  159 	dec	sp
                            160 ;src/StateManager.c:69: u8 t,n=10, anyKeyPressed=0xFF;
   1CA5 DD 36 FD FF   [19]  161 	ld	-3 (ix),#0xFF
                            162 ;src/StateManager.c:70: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
                            163 ;src/StateManager.c:71: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
                            164 ;src/StateManager.c:73: cpct_scanKeyboard_f();
   1CA9 CD 07 41      [17]  165 	call	_cpct_scanKeyboard_f
                            166 ;src/StateManager.c:74: while(n){
   1CAC DD 36 FB 0A   [19]  167 	ld	-5 (ix),#0x0A
   1CB0 01 BF 42      [10]  168 	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
   1CB3 11 89 1C      [10]  169 	ld	de,#(_last_keyboardStatusBuffer + 0x000a)
   1CB6                     170 00101$:
   1CB6 DD 7E FB      [19]  171 	ld	a,-5 (ix)
   1CB9 B7            [ 4]  172 	or	a, a
   1CBA 28 2A         [12]  173 	jr	Z,00104$
                            174 ;src/StateManager.c:75: --n;
   1CBC DD 35 FB      [23]  175 	dec	-5 (ix)
                            176 ;src/StateManager.c:76: --currentStatus;
   1CBF 0B            [ 6]  177 	dec	bc
                            178 ;src/StateManager.c:77: --lastStatus;
   1CC0 1B            [ 6]  179 	dec	de
                            180 ;src/StateManager.c:79: t=*(currentStatus);
   1CC1 0A            [ 7]  181 	ld	a,(bc)
   1CC2 DD 77 FC      [19]  182 	ld	-4 (ix),a
                            183 ;src/StateManager.c:80: anyKeyPressed&=t;
   1CC5 DD 7E FD      [19]  184 	ld	a,-3 (ix)
   1CC8 DD A6 FC      [19]  185 	and	a, -4 (ix)
   1CCB DD 77 FD      [19]  186 	ld	-3 (ix),a
                            187 ;src/StateManager.c:81: *currentStatus=((*lastStatus)|(~t));
   1CCE 1A            [ 7]  188 	ld	a,(de)
   1CCF DD 77 FE      [19]  189 	ld	-2 (ix),a
   1CD2 DD 7E FC      [19]  190 	ld	a,-4 (ix)
   1CD5 2F            [ 4]  191 	cpl
   1CD6 DD 77 FF      [19]  192 	ld	-1 (ix),a
   1CD9 DD 7E FE      [19]  193 	ld	a,-2 (ix)
   1CDC DD B6 FF      [19]  194 	or	a, -1 (ix)
   1CDF 02            [ 7]  195 	ld	(bc),a
                            196 ;src/StateManager.c:82: *lastStatus=t;
   1CE0 DD 7E FC      [19]  197 	ld	a,-4 (ix)
   1CE3 12            [ 7]  198 	ld	(de),a
   1CE4 18 D0         [12]  199 	jr	00101$
   1CE6                     200 00104$:
   1CE6 DD F9         [10]  201 	ld	sp, ix
   1CE8 DD E1         [14]  202 	pop	ix
   1CEA C9            [10]  203 	ret
                            204 ;src/StateManager.c:89: void statemanager_manage_input(){
                            205 ;	---------------------------------
                            206 ; Function statemanager_manage_input
                            207 ; ---------------------------------
   1CEB                     208 _statemanager_manage_input::
                            209 ;src/StateManager.c:90: while(!inputReceived){
   1CEB                     210 00101$:
   1CEB 3A 7E 1C      [13]  211 	ld	a,(#_inputReceived + 0)
   1CEE B7            [ 4]  212 	or	a, a
   1CEF 20 1E         [12]  213 	jr	NZ,00103$
                            214 ;src/StateManager.c:91: scan_input();
   1CF1 CD 9A 1C      [17]  215 	call	_scan_input
                            216 ;src/StateManager.c:92: stateArray[currentState].inputState();
   1CF4 21 7C 1C      [10]  217 	ld	hl,#_currentState + 0
   1CF7 4E            [ 7]  218 	ld	c, (hl)
   1CF8 06 00         [ 7]  219 	ld	b,#0x00
   1CFA 69            [ 4]  220 	ld	l, c
   1CFB 60            [ 4]  221 	ld	h, b
   1CFC 29            [11]  222 	add	hl, hl
   1CFD 29            [11]  223 	add	hl, hl
   1CFE 09            [11]  224 	add	hl, bc
   1CFF 29            [11]  225 	add	hl, hl
   1D00 11 5E 1C      [10]  226 	ld	de,#_stateArray
   1D03 19            [11]  227 	add	hl,de
   1D04 23            [ 6]  228 	inc	hl
   1D05 23            [ 6]  229 	inc	hl
   1D06 4E            [ 7]  230 	ld	c,(hl)
   1D07 23            [ 6]  231 	inc	hl
   1D08 66            [ 7]  232 	ld	h,(hl)
   1D09 69            [ 4]  233 	ld	l, c
   1D0A CD DB 42      [17]  234 	call	___sdcc_call_hl
   1D0D 18 DC         [12]  235 	jr	00101$
   1D0F                     236 00103$:
                            237 ;src/StateManager.c:94: *(u8*)&inputReceived=0;
   1D0F 21 7E 1C      [10]  238 	ld	hl,#_inputReceived
   1D12 36 00         [10]  239 	ld	(hl),#0x00
   1D14 C9            [10]  240 	ret
                            241 ;src/StateManager.c:97: void statemanager_render_state(){
                            242 ;	---------------------------------
                            243 ; Function statemanager_render_state
                            244 ; ---------------------------------
   1D15                     245 _statemanager_render_state::
                            246 ;src/StateManager.c:98: cpct_waitVSYNC();
   1D15 CD 08 43      [17]  247 	call	_cpct_waitVSYNC
                            248 ;src/StateManager.c:99: stateArray[currentState].renderState();
   1D18 01 5E 1C      [10]  249 	ld	bc,#_stateArray+0
   1D1B 21 7C 1C      [10]  250 	ld	hl,#_currentState + 0
   1D1E 5E            [ 7]  251 	ld	e, (hl)
   1D1F 16 00         [ 7]  252 	ld	d,#0x00
   1D21 6B            [ 4]  253 	ld	l, e
   1D22 62            [ 4]  254 	ld	h, d
   1D23 29            [11]  255 	add	hl, hl
   1D24 29            [11]  256 	add	hl, hl
   1D25 19            [11]  257 	add	hl, de
   1D26 29            [11]  258 	add	hl, hl
   1D27 09            [11]  259 	add	hl,bc
   1D28 11 06 00      [10]  260 	ld	de, #0x0006
   1D2B 19            [11]  261 	add	hl, de
   1D2C 4E            [ 7]  262 	ld	c,(hl)
   1D2D 23            [ 6]  263 	inc	hl
   1D2E 66            [ 7]  264 	ld	h,(hl)
   1D2F 69            [ 4]  265 	ld	l, c
   1D30 C3 DB 42      [10]  266 	jp  ___sdcc_call_hl
                            267 ;src/StateManager.c:102: void statemanager_close_state(u8 state){
                            268 ;	---------------------------------
                            269 ; Function statemanager_close_state
                            270 ; ---------------------------------
   1D33                     271 _statemanager_close_state::
   1D33 DD E5         [15]  272 	push	ix
   1D35 DD 21 00 00   [14]  273 	ld	ix,#0
   1D39 DD 39         [15]  274 	add	ix,sp
                            275 ;src/StateManager.c:103: stateArray[state].exitState();
   1D3B 01 5E 1C      [10]  276 	ld	bc,#_stateArray+0
   1D3E DD 5E 04      [19]  277 	ld	e,4 (ix)
   1D41 16 00         [ 7]  278 	ld	d,#0x00
   1D43 6B            [ 4]  279 	ld	l, e
   1D44 62            [ 4]  280 	ld	h, d
   1D45 29            [11]  281 	add	hl, hl
   1D46 29            [11]  282 	add	hl, hl
   1D47 19            [11]  283 	add	hl, de
   1D48 29            [11]  284 	add	hl, hl
   1D49 09            [11]  285 	add	hl,bc
   1D4A 11 08 00      [10]  286 	ld	de, #0x0008
   1D4D 19            [11]  287 	add	hl, de
   1D4E 4E            [ 7]  288 	ld	c,(hl)
   1D4F 23            [ 6]  289 	inc	hl
   1D50 66            [ 7]  290 	ld	h,(hl)
   1D51 69            [ 4]  291 	ld	l, c
   1D52 DD E1         [14]  292 	pop	ix
   1D54 C3 DB 42      [10]  293 	jp	___sdcc_call_hl
                            294 ;src/StateManager.c:106: void statemanager_update_state(){
                            295 ;	---------------------------------
                            296 ; Function statemanager_update_state
                            297 ; ---------------------------------
   1D57                     298 _statemanager_update_state::
                            299 ;src/StateManager.c:107: stateArray[currentState].updateState();
   1D57 01 5E 1C      [10]  300 	ld	bc,#_stateArray+0
   1D5A 21 7C 1C      [10]  301 	ld	hl,#_currentState + 0
   1D5D 5E            [ 7]  302 	ld	e, (hl)
   1D5E 16 00         [ 7]  303 	ld	d,#0x00
   1D60 6B            [ 4]  304 	ld	l, e
   1D61 62            [ 4]  305 	ld	h, d
   1D62 29            [11]  306 	add	hl, hl
   1D63 29            [11]  307 	add	hl, hl
   1D64 19            [11]  308 	add	hl, de
   1D65 29            [11]  309 	add	hl, hl
   1D66 09            [11]  310 	add	hl,bc
   1D67 11 04 00      [10]  311 	ld	de, #0x0004
   1D6A 19            [11]  312 	add	hl, de
   1D6B 4E            [ 7]  313 	ld	c,(hl)
   1D6C 23            [ 6]  314 	inc	hl
   1D6D 66            [ 7]  315 	ld	h,(hl)
   1D6E 69            [ 4]  316 	ld	l, c
   1D6F C3 DB 42      [10]  317 	jp  ___sdcc_call_hl
                            318 ;src/StateManager.c:110: void statemanager_main_loop(){
                            319 ;	---------------------------------
                            320 ; Function statemanager_main_loop
                            321 ; ---------------------------------
   1D72                     322 _statemanager_main_loop::
                            323 ;src/StateManager.c:111: while(1) {
   1D72                     324 00102$:
                            325 ;src/StateManager.c:112: statemanager_change_state();
   1D72 CD 33 1C      [17]  326 	call	_statemanager_change_state
                            327 ;src/StateManager.c:113: statemanager_manage_input();
   1D75 CD EB 1C      [17]  328 	call	_statemanager_manage_input
                            329 ;src/StateManager.c:114: statemanager_update_state();
   1D78 CD 57 1D      [17]  330 	call	_statemanager_update_state
                            331 ;src/StateManager.c:115: statemanager_render_state();
   1D7B CD 15 1D      [17]  332 	call	_statemanager_render_state
   1D7E 18 F2         [12]  333 	jr	00102$
                            334 	.area _CODE
                            335 	.area _INITIALIZER
                            336 	.area _CABS (ABS)
