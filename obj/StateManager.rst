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
                             18 	.globl _cpct_isAnyKeyPressed_f
                             19 	.globl _cpct_scanKeyboard_f
                             20 	.globl _last_keyboardStatusBuffer
                             21 	.globl _gameRunning
                             22 	.globl _inputReceived
                             23 	.globl _changeToState
                             24 	.globl _currentState
                             25 	.globl _closeState
                             26 	.globl _stateArray
                             27 	.globl _statemanager_input_accepted
                             28 	.globl _statemanager_set_state
                             29 	.globl _statemanager_close_state
                             30 	.globl _statemanager_exit_game
                             31 	.globl _statemanager_main_loop
                             32 ;--------------------------------------------------------
                             33 ; special function registers
                             34 ;--------------------------------------------------------
                             35 ;--------------------------------------------------------
                             36 ; ram data
                             37 ;--------------------------------------------------------
                             38 	.area _DATA
                             39 ;--------------------------------------------------------
                             40 ; ram data
                             41 ;--------------------------------------------------------
                             42 	.area _INITIALIZED
                             43 ;--------------------------------------------------------
                             44 ; absolute external ram data
                             45 ;--------------------------------------------------------
                             46 	.area _DABS (ABS)
                             47 ;--------------------------------------------------------
                             48 ; global & static initialisations
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _GSINIT
                             52 	.area _GSFINAL
                             53 	.area _GSINIT
                             54 ;--------------------------------------------------------
                             55 ; Home
                             56 ;--------------------------------------------------------
                             57 	.area _HOME
                             58 	.area _HOME
                             59 ;--------------------------------------------------------
                             60 ; code
                             61 ;--------------------------------------------------------
                             62 	.area _CODE
                             63 ;src/StateManager.c:168: void statemanager_drop_state(){
                             64 ;	---------------------------------
                             65 ; Function statemanager_drop_state
                             66 ; ---------------------------------
   38B3                      67 _statemanager_drop_state::
                             68 ;src/StateManager.c:169: if(closeState){
   38B3 3A A3 39      [13]   69 	ld	a,(#_closeState + 0)
   38B6 B7            [ 4]   70 	or	a, a
   38B7 C8            [11]   71 	ret	Z
                             72 ;src/StateManager.c:170: stateArray[currentState].exitState();
   38B8 01 09 39      [10]   73 	ld	bc,#_stateArray+0
   38BB 21 A4 39      [10]   74 	ld	hl,#_currentState + 0
   38BE 5E            [ 7]   75 	ld	e, (hl)
   38BF 16 00         [ 7]   76 	ld	d,#0x00
   38C1 6B            [ 4]   77 	ld	l, e
   38C2 62            [ 4]   78 	ld	h, d
   38C3 29            [11]   79 	add	hl, hl
   38C4 19            [11]   80 	add	hl, de
   38C5 29            [11]   81 	add	hl, hl
   38C6 19            [11]   82 	add	hl, de
   38C7 29            [11]   83 	add	hl, hl
   38C8 09            [11]   84 	add	hl,bc
   38C9 11 0C 00      [10]   85 	ld	de, #0x000C
   38CC 19            [11]   86 	add	hl, de
   38CD 5E            [ 7]   87 	ld	e,(hl)
   38CE 23            [ 6]   88 	inc	hl
   38CF 66            [ 7]   89 	ld	h,(hl)
   38D0 C5            [11]   90 	push	bc
   38D1 6B            [ 4]   91 	ld	l, e
   38D2 CD 56 84      [17]   92 	call	___sdcc_call_hl
   38D5 C1            [10]   93 	pop	bc
                             94 ;src/StateManager.c:171: *(u8*)&currentState = stateArray[currentState].lastStateid;
   38D6 21 A4 39      [10]   95 	ld	hl,#_currentState + 0
   38D9 5E            [ 7]   96 	ld	e, (hl)
   38DA 16 00         [ 7]   97 	ld	d,#0x00
   38DC 6B            [ 4]   98 	ld	l, e
   38DD 62            [ 4]   99 	ld	h, d
   38DE 29            [11]  100 	add	hl, hl
   38DF 19            [11]  101 	add	hl, de
   38E0 29            [11]  102 	add	hl, hl
   38E1 19            [11]  103 	add	hl, de
   38E2 29            [11]  104 	add	hl, hl
   38E3 09            [11]  105 	add	hl,bc
   38E4 23            [ 6]  106 	inc	hl
   38E5 5E            [ 7]  107 	ld	e,(hl)
   38E6 21 A4 39      [10]  108 	ld	hl,#_currentState
   38E9 73            [ 7]  109 	ld	(hl),e
                            110 ;src/StateManager.c:172: stateArray[currentState].returnState();
   38EA 21 A4 39      [10]  111 	ld	hl,#_currentState + 0
   38ED 5E            [ 7]  112 	ld	e, (hl)
   38EE 16 00         [ 7]  113 	ld	d,#0x00
   38F0 6B            [ 4]  114 	ld	l, e
   38F1 62            [ 4]  115 	ld	h, d
   38F2 29            [11]  116 	add	hl, hl
   38F3 19            [11]  117 	add	hl, de
   38F4 29            [11]  118 	add	hl, hl
   38F5 19            [11]  119 	add	hl, de
   38F6 29            [11]  120 	add	hl, hl
   38F7 09            [11]  121 	add	hl,bc
   38F8 11 04 00      [10]  122 	ld	de, #0x0004
   38FB 19            [11]  123 	add	hl, de
   38FC 7E            [ 7]  124 	ld	a, (hl)
   38FD 23            [ 6]  125 	inc	hl
   38FE 66            [ 7]  126 	ld	h,(hl)
   38FF 6F            [ 4]  127 	ld	l,a
   3900 CD 56 84      [17]  128 	call	___sdcc_call_hl
                            129 ;src/StateManager.c:173: *(u8*)&closeState=0;
   3903 21 A3 39      [10]  130 	ld	hl,#_closeState
   3906 36 00         [10]  131 	ld	(hl),#0x00
   3908 C9            [10]  132 	ret
   3909                     133 _stateArray:
   3909 00                  134 	.db #0x00	; 0
   390A 00                  135 	.db #0x00	; 0
   390B DA 37               136 	.dw _state_mainmenu_enter
   390D 02 38               137 	.dw _state_mainmenu_return
   390F 19 38               138 	.dw _state_mainmenu_input
   3911 48 38               139 	.dw _state_mainmenu_update
   3913 AF 38               140 	.dw _state_mainmenu_render
   3915 B2 38               141 	.dw _state_mainmenu_exit
   3917 01                  142 	.db #0x01	; 1
   3918 00                  143 	.db #0x00	; 0
   3919 C8 30               144 	.dw _state_ingame_enter
   391B 1B 31               145 	.dw _state_ingame_return
   391D 37 31               146 	.dw _state_ingame_input
   391F 86 31               147 	.dw _state_ingame_update
   3921 CF 32               148 	.dw _state_ingame_render
   3923 F4 32               149 	.dw _state_ingame_exit
   3925 02                  150 	.db #0x02	; 2
   3926 00                  151 	.db #0x00	; 0
   3927 B0 3B               152 	.dw _state_pausemenu_enter
   3929 DE 3B               153 	.dw _state_pausemenu_return
   392B 09 3C               154 	.dw _state_pausemenu_input
   392D 38 3C               155 	.dw _state_pausemenu_update
   392F 83 3C               156 	.dw _state_pausemenu_render
   3931 86 3C               157 	.dw _state_pausemenu_exit
   3933 03                  158 	.db #0x03	; 3
   3934 00                  159 	.db #0x00	; 0
   3935 6B 36               160 	.dw _state_loadlevel_enter
   3937 D3 36               161 	.dw _state_loadlevel_return
   3939 D4 36               162 	.dw _state_loadlevel_input
   393B D7 36               163 	.dw _state_loadlevel_update
   393D F4 36               164 	.dw _state_loadlevel_render
   393F F5 36               165 	.dw _state_loadlevel_exit
   3941 04                  166 	.db #0x04	; 4
   3942 00                  167 	.db #0x00	; 0
   3943 E2 3A               168 	.dw _state_options_enter
   3945 10 3B               169 	.dw _state_options_return
   3947 11 3B               170 	.dw _state_options_input
   3949 40 3B               171 	.dw _state_options_update
   394B 98 3B               172 	.dw _state_options_render
   394D 9B 3B               173 	.dw _state_options_exit
   394F 05                  174 	.db #0x05	; 5
   3950 00                  175 	.db #0x00	; 0
   3951 4E 30               176 	.dw _state_gameover_enter
   3953 B4 30               177 	.dw _state_gameover_return
   3955 B5 30               178 	.dw _state_gameover_input
   3957 BE 30               179 	.dw _state_gameover_update
   3959 C6 30               180 	.dw _state_gameover_render
   395B C7 30               181 	.dw _state_gameover_exit
   395D 06                  182 	.db #0x06	; 6
   395E 00                  183 	.db #0x00	; 0
   395F 4A 2F               184 	.dw _state_credits_enter
   3961 2B 30               185 	.dw _state_credits_return
   3963 2C 30               186 	.dw _state_credits_input
   3965 35 30               187 	.dw _state_credits_update
   3967 38 30               188 	.dw _state_credits_render
   3969 39 30               189 	.dw _state_credits_exit
   396B 07                  190 	.db #0x07	; 7
   396C 00                  191 	.db #0x00	; 0
   396D 0C 3D               192 	.dw _state_victory_enter
   396F 73 3D               193 	.dw _state_victory_return
   3971 74 3D               194 	.dw _state_victory_input
   3973 7D 3D               195 	.dw _state_victory_update
   3975 85 3D               196 	.dw _state_victory_render
   3977 86 3D               197 	.dw _state_victory_exit
   3979 08                  198 	.db #0x08	; 8
   397A 00                  199 	.db #0x00	; 0
   397B F5 32               200 	.dw _state_inventory_enter
   397D 29 33               201 	.dw _state_inventory_return
   397F 32 33               202 	.dw _state_inventory_input
   3981 61 33               203 	.dw _state_inventory_update
   3983 94 33               204 	.dw _state_inventory_render
   3985 97 33               205 	.dw _state_inventory_exit
   3987 09                  206 	.db #0x09	; 9
   3988 00                  207 	.db #0x00	; 0
   3989 9B 3C               208 	.dw _state_saveexit_enter
   398B F8 3C               209 	.dw _state_saveexit_return
   398D F9 3C               210 	.dw _state_saveexit_input
   398F 09 3D               211 	.dw _state_saveexit_update
   3991 0A 3D               212 	.dw _state_saveexit_render
   3993 0B 3D               213 	.dw _state_saveexit_exit
   3995 0A                  214 	.db #0x0A	; 10
   3996 00                  215 	.db #0x00	; 0
   3997 AC 33               216 	.dw _state_loadgame_enter
   3999 DD 33               217 	.dw _state_loadgame_return
   399B DE 33               218 	.dw _state_loadgame_input
   399D 2A 36               219 	.dw _state_loadgame_update
   399F 53 36               220 	.dw _state_loadgame_render
   39A1 56 36               221 	.dw _state_loadgame_exit
   39A3                     222 _closeState:
   39A3 00                  223 	.db #0x00	; 0
   39A4                     224 _currentState:
   39A4 00                  225 	.db #0x00	; 0
   39A5                     226 _changeToState:
   39A5 00                  227 	.db #0x00	; 0
   39A6                     228 _inputReceived:
   39A6 00                  229 	.db #0x00	; 0
   39A7                     230 _gameRunning:
   39A7 01                  231 	.db #0x01	; 1
   39A8                     232 _last_keyboardStatusBuffer:
   39A8 FF                  233 	.db #0xFF	; 255
   39A9 FF                  234 	.db #0xFF	; 255
   39AA FF                  235 	.db #0xFF	; 255
   39AB FF                  236 	.db #0xFF	; 255
   39AC FF                  237 	.db #0xFF	; 255
   39AD FF                  238 	.db #0xFF	; 255
   39AE FF                  239 	.db #0xFF	; 255
   39AF FF                  240 	.db #0xFF	; 255
   39B0 FF                  241 	.db #0xFF	; 255
   39B1 FF                  242 	.db #0xFF	; 255
                            243 ;src/StateManager.c:177: void statemanager_change_state(){
                            244 ;	---------------------------------
                            245 ; Function statemanager_change_state
                            246 ; ---------------------------------
   39B2                     247 _statemanager_change_state::
                            248 ;src/StateManager.c:178: if(changeToState){
   39B2 21 A5 39      [10]  249 	ld	hl,#_changeToState + 0
   39B5 4E            [ 7]  250 	ld	c, (hl)
   39B6 3A A5 39      [13]  251 	ld	a,(#_changeToState + 0)
   39B9 B7            [ 4]  252 	or	a, a
   39BA C8            [11]  253 	ret	Z
                            254 ;src/StateManager.c:179: *(u8*)&(stateArray[changeToState-1].lastStateid) = currentState;
   39BB 11 09 39      [10]  255 	ld	de,#_stateArray+0
   39BE 0D            [ 4]  256 	dec	c
   39BF 06 00         [ 7]  257 	ld	b,#0x00
   39C1 69            [ 4]  258 	ld	l, c
   39C2 60            [ 4]  259 	ld	h, b
   39C3 29            [11]  260 	add	hl, hl
   39C4 09            [11]  261 	add	hl, bc
   39C5 29            [11]  262 	add	hl, hl
   39C6 09            [11]  263 	add	hl, bc
   39C7 29            [11]  264 	add	hl, hl
   39C8 19            [11]  265 	add	hl,de
   39C9 23            [ 6]  266 	inc	hl
   39CA FD 21 A4 39   [14]  267 	ld	iy,#_currentState
   39CE FD 4E 00      [19]  268 	ld	c,0 (iy)
   39D1 71            [ 7]  269 	ld	(hl),c
                            270 ;src/StateManager.c:180: *(u8*)&currentState = changeToState-1;
   39D2 21 A4 39      [10]  271 	ld	hl,#_currentState+0
   39D5 FD 21 A5 39   [14]  272 	ld	iy,#_changeToState
   39D9 FD 4E 00      [19]  273 	ld	c,0 (iy)
   39DC 0D            [ 4]  274 	dec	c
   39DD 71            [ 7]  275 	ld	(hl),c
                            276 ;src/StateManager.c:181: stateArray[currentState].enterState();
   39DE 21 A4 39      [10]  277 	ld	hl,#_currentState + 0
   39E1 4E            [ 7]  278 	ld	c, (hl)
   39E2 06 00         [ 7]  279 	ld	b,#0x00
   39E4 69            [ 4]  280 	ld	l, c
   39E5 60            [ 4]  281 	ld	h, b
   39E6 29            [11]  282 	add	hl, hl
   39E7 09            [11]  283 	add	hl, bc
   39E8 29            [11]  284 	add	hl, hl
   39E9 09            [11]  285 	add	hl, bc
   39EA 29            [11]  286 	add	hl, hl
   39EB 19            [11]  287 	add	hl,de
   39EC 23            [ 6]  288 	inc	hl
   39ED 23            [ 6]  289 	inc	hl
   39EE 4E            [ 7]  290 	ld	c,(hl)
   39EF 23            [ 6]  291 	inc	hl
   39F0 66            [ 7]  292 	ld	h,(hl)
   39F1 69            [ 4]  293 	ld	l, c
   39F2 CD 56 84      [17]  294 	call	___sdcc_call_hl
                            295 ;src/StateManager.c:182: *(u8*)&changeToState = 0;
   39F5 21 A5 39      [10]  296 	ld	hl,#_changeToState
   39F8 36 00         [10]  297 	ld	(hl),#0x00
   39FA C9            [10]  298 	ret
                            299 ;src/StateManager.c:186: void statemanager_input_accepted(){
                            300 ;	---------------------------------
                            301 ; Function statemanager_input_accepted
                            302 ; ---------------------------------
   39FB                     303 _statemanager_input_accepted::
                            304 ;src/StateManager.c:187: *(u8*)&inputReceived=1;
   39FB 21 A6 39      [10]  305 	ld	hl,#_inputReceived
   39FE 36 01         [10]  306 	ld	(hl),#0x01
   3A00 C9            [10]  307 	ret
                            308 ;src/StateManager.c:190: void statemanager_set_state(u8 state) {
                            309 ;	---------------------------------
                            310 ; Function statemanager_set_state
                            311 ; ---------------------------------
   3A01                     312 _statemanager_set_state::
                            313 ;src/StateManager.c:191: *(u8*)&changeToState = state+1;
   3A01 01 A5 39      [10]  314 	ld	bc,#_changeToState+0
   3A04 21 02 00      [10]  315 	ld	hl, #2+0
   3A07 39            [11]  316 	add	hl, sp
   3A08 7E            [ 7]  317 	ld	a, (hl)
   3A09 3C            [ 4]  318 	inc	a
   3A0A 02            [ 7]  319 	ld	(bc),a
   3A0B C9            [10]  320 	ret
                            321 ;src/StateManager.c:194: void scan_input(){
                            322 ;	---------------------------------
                            323 ; Function scan_input
                            324 ; ---------------------------------
   3A0C                     325 _scan_input::
   3A0C DD E5         [15]  326 	push	ix
   3A0E DD 21 00 00   [14]  327 	ld	ix,#0
   3A12 DD 39         [15]  328 	add	ix,sp
   3A14 F5            [11]  329 	push	af
                            330 ;src/StateManager.c:196: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
                            331 ;src/StateManager.c:197: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
                            332 ;src/StateManager.c:199: cpct_scanKeyboard_f();
   3A15 CD 49 7A      [17]  333 	call	_cpct_scanKeyboard_f
                            334 ;src/StateManager.c:200: while(n){
   3A18 1E 0A         [ 7]  335 	ld	e,#0x0A
   3A1A 01 E4 83      [10]  336 	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
   3A1D FD 21 B2 39   [14]  337 	ld	iy,#(_last_keyboardStatusBuffer + 0x000a)
   3A21                     338 00101$:
   3A21 7B            [ 4]  339 	ld	a,e
   3A22 B7            [ 4]  340 	or	a, a
   3A23 28 1D         [12]  341 	jr	Z,00103$
                            342 ;src/StateManager.c:201: --n;
   3A25 1D            [ 4]  343 	dec	e
                            344 ;src/StateManager.c:202: --currentStatus;
   3A26 0B            [ 6]  345 	dec	bc
                            346 ;src/StateManager.c:203: --lastStatus;
   3A27 FD 2B         [10]  347 	dec	iy
                            348 ;src/StateManager.c:205: t=*(currentStatus);
   3A29 0A            [ 7]  349 	ld	a,(bc)
   3A2A 57            [ 4]  350 	ld	d,a
                            351 ;src/StateManager.c:206: *currentStatus=((*lastStatus)|(~t));
   3A2B FD 7E 00      [19]  352 	ld	a, 0 (iy)
   3A2E DD 77 FF      [19]  353 	ld	-1 (ix),a
   3A31 7A            [ 4]  354 	ld	a,d
   3A32 2F            [ 4]  355 	cpl
   3A33 DD 77 FE      [19]  356 	ld	-2 (ix),a
   3A36 DD 7E FF      [19]  357 	ld	a,-1 (ix)
   3A39 DD B6 FE      [19]  358 	or	a, -2 (ix)
   3A3C 02            [ 7]  359 	ld	(bc),a
                            360 ;src/StateManager.c:207: *lastStatus=t;
   3A3D FD 72 00      [19]  361 	ld	0 (iy), d
   3A40 18 DF         [12]  362 	jr	00101$
   3A42                     363 00103$:
                            364 ;src/StateManager.c:211: if(cpct_isAnyKeyPressed_f()) ++r_counter;
   3A42 CD E0 84      [17]  365 	call	_cpct_isAnyKeyPressed_f
   3A45 7D            [ 4]  366 	ld	a,l
   3A46 B7            [ 4]  367 	or	a, a
   3A47 28 0A         [12]  368 	jr	Z,00106$
   3A49 21 D5 86      [10]  369 	ld	hl, #_r_counter+0
   3A4C 34            [11]  370 	inc	(hl)
   3A4D 20 04         [12]  371 	jr	NZ,00121$
   3A4F 21 D6 86      [10]  372 	ld	hl, #_r_counter+1
   3A52 34            [11]  373 	inc	(hl)
   3A53                     374 00121$:
   3A53                     375 00106$:
   3A53 DD F9         [10]  376 	ld	sp, ix
   3A55 DD E1         [14]  377 	pop	ix
   3A57 C9            [10]  378 	ret
                            379 ;src/StateManager.c:214: void statemanager_manage_input(){
                            380 ;	---------------------------------
                            381 ; Function statemanager_manage_input
                            382 ; ---------------------------------
   3A58                     383 _statemanager_manage_input::
                            384 ;src/StateManager.c:215: while(!inputReceived){
   3A58                     385 00101$:
   3A58 3A A6 39      [13]  386 	ld	a,(#_inputReceived + 0)
   3A5B B7            [ 4]  387 	or	a, a
   3A5C 20 21         [12]  388 	jr	NZ,00103$
                            389 ;src/StateManager.c:216: scan_input();
   3A5E CD 0C 3A      [17]  390 	call	_scan_input
                            391 ;src/StateManager.c:217: stateArray[currentState].inputState();
   3A61 21 A4 39      [10]  392 	ld	hl,#_currentState + 0
   3A64 4E            [ 7]  393 	ld	c, (hl)
   3A65 06 00         [ 7]  394 	ld	b,#0x00
   3A67 69            [ 4]  395 	ld	l, c
   3A68 60            [ 4]  396 	ld	h, b
   3A69 29            [11]  397 	add	hl, hl
   3A6A 09            [11]  398 	add	hl, bc
   3A6B 29            [11]  399 	add	hl, hl
   3A6C 09            [11]  400 	add	hl, bc
   3A6D 29            [11]  401 	add	hl, hl
   3A6E 11 09 39      [10]  402 	ld	de,#_stateArray
   3A71 19            [11]  403 	add	hl,de
   3A72 11 06 00      [10]  404 	ld	de, #0x0006
   3A75 19            [11]  405 	add	hl, de
   3A76 4E            [ 7]  406 	ld	c,(hl)
   3A77 23            [ 6]  407 	inc	hl
   3A78 66            [ 7]  408 	ld	h,(hl)
   3A79 69            [ 4]  409 	ld	l, c
   3A7A CD 56 84      [17]  410 	call	___sdcc_call_hl
   3A7D 18 D9         [12]  411 	jr	00101$
   3A7F                     412 00103$:
                            413 ;src/StateManager.c:219: *(u8*)&inputReceived=0;
   3A7F 21 A6 39      [10]  414 	ld	hl,#_inputReceived
   3A82 36 00         [10]  415 	ld	(hl),#0x00
   3A84 C9            [10]  416 	ret
                            417 ;src/StateManager.c:222: void statemanager_render_state(){
                            418 ;	---------------------------------
                            419 ; Function statemanager_render_state
                            420 ; ---------------------------------
   3A85                     421 _statemanager_render_state::
                            422 ;src/StateManager.c:223: cpct_waitVSYNC();
   3A85 CD D8 84      [17]  423 	call	_cpct_waitVSYNC
                            424 ;src/StateManager.c:224: stateArray[currentState].renderState();
   3A88 01 09 39      [10]  425 	ld	bc,#_stateArray+0
   3A8B 21 A4 39      [10]  426 	ld	hl,#_currentState + 0
   3A8E 5E            [ 7]  427 	ld	e, (hl)
   3A8F 16 00         [ 7]  428 	ld	d,#0x00
   3A91 6B            [ 4]  429 	ld	l, e
   3A92 62            [ 4]  430 	ld	h, d
   3A93 29            [11]  431 	add	hl, hl
   3A94 19            [11]  432 	add	hl, de
   3A95 29            [11]  433 	add	hl, hl
   3A96 19            [11]  434 	add	hl, de
   3A97 29            [11]  435 	add	hl, hl
   3A98 09            [11]  436 	add	hl,bc
   3A99 11 0A 00      [10]  437 	ld	de, #0x000A
   3A9C 19            [11]  438 	add	hl, de
   3A9D 4E            [ 7]  439 	ld	c,(hl)
   3A9E 23            [ 6]  440 	inc	hl
   3A9F 66            [ 7]  441 	ld	h,(hl)
   3AA0 69            [ 4]  442 	ld	l, c
   3AA1 C3 56 84      [10]  443 	jp  ___sdcc_call_hl
                            444 ;src/StateManager.c:227: void statemanager_close_state(){
                            445 ;	---------------------------------
                            446 ; Function statemanager_close_state
                            447 ; ---------------------------------
   3AA4                     448 _statemanager_close_state::
                            449 ;src/StateManager.c:228: *(u8*)&closeState=1;
   3AA4 21 A3 39      [10]  450 	ld	hl,#_closeState
   3AA7 36 01         [10]  451 	ld	(hl),#0x01
   3AA9 C9            [10]  452 	ret
                            453 ;src/StateManager.c:231: void statemanager_update_state(){
                            454 ;	---------------------------------
                            455 ; Function statemanager_update_state
                            456 ; ---------------------------------
   3AAA                     457 _statemanager_update_state::
                            458 ;src/StateManager.c:232: stateArray[currentState].updateState();
   3AAA 01 09 39      [10]  459 	ld	bc,#_stateArray+0
   3AAD 21 A4 39      [10]  460 	ld	hl,#_currentState + 0
   3AB0 5E            [ 7]  461 	ld	e, (hl)
   3AB1 16 00         [ 7]  462 	ld	d,#0x00
   3AB3 6B            [ 4]  463 	ld	l, e
   3AB4 62            [ 4]  464 	ld	h, d
   3AB5 29            [11]  465 	add	hl, hl
   3AB6 19            [11]  466 	add	hl, de
   3AB7 29            [11]  467 	add	hl, hl
   3AB8 19            [11]  468 	add	hl, de
   3AB9 29            [11]  469 	add	hl, hl
   3ABA 09            [11]  470 	add	hl,bc
   3ABB 11 08 00      [10]  471 	ld	de, #0x0008
   3ABE 19            [11]  472 	add	hl, de
   3ABF 4E            [ 7]  473 	ld	c,(hl)
   3AC0 23            [ 6]  474 	inc	hl
   3AC1 66            [ 7]  475 	ld	h,(hl)
   3AC2 69            [ 4]  476 	ld	l, c
   3AC3 C3 56 84      [10]  477 	jp  ___sdcc_call_hl
                            478 ;src/StateManager.c:235: void statemanager_exit_game(){
                            479 ;	---------------------------------
                            480 ; Function statemanager_exit_game
                            481 ; ---------------------------------
   3AC6                     482 _statemanager_exit_game::
                            483 ;src/StateManager.c:236: *(u8*)&gameRunning=0;
   3AC6 21 A7 39      [10]  484 	ld	hl,#_gameRunning
   3AC9 36 00         [10]  485 	ld	(hl),#0x00
   3ACB C9            [10]  486 	ret
                            487 ;src/StateManager.c:239: void statemanager_main_loop(){
                            488 ;	---------------------------------
                            489 ; Function statemanager_main_loop
                            490 ; ---------------------------------
   3ACC                     491 _statemanager_main_loop::
                            492 ;src/StateManager.c:240: while(gameRunning) {
   3ACC                     493 00101$:
   3ACC 3A A7 39      [13]  494 	ld	a,(#_gameRunning + 0)
   3ACF B7            [ 4]  495 	or	a, a
   3AD0 C8            [11]  496 	ret	Z
                            497 ;src/StateManager.c:241: statemanager_drop_state();
   3AD1 CD B3 38      [17]  498 	call	_statemanager_drop_state
                            499 ;src/StateManager.c:242: statemanager_change_state();
   3AD4 CD B2 39      [17]  500 	call	_statemanager_change_state
                            501 ;src/StateManager.c:243: statemanager_manage_input();
   3AD7 CD 58 3A      [17]  502 	call	_statemanager_manage_input
                            503 ;src/StateManager.c:244: statemanager_update_state();
   3ADA CD AA 3A      [17]  504 	call	_statemanager_update_state
                            505 ;src/StateManager.c:245: statemanager_render_state();
   3ADD CD 85 3A      [17]  506 	call	_statemanager_render_state
   3AE0 18 EA         [12]  507 	jr	00101$
                            508 	.area _CODE
                            509 	.area _INITIALIZER
                            510 	.area _CABS (ABS)
