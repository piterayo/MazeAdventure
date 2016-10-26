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
   376E                      67 _statemanager_drop_state::
                             68 ;src/StateManager.c:169: if(closeState){
   376E 3A 5E 38      [13]   69 	ld	a,(#_closeState + 0)
   3771 B7            [ 4]   70 	or	a, a
   3772 C8            [11]   71 	ret	Z
                             72 ;src/StateManager.c:170: stateArray[currentState].exitState();
   3773 01 C4 37      [10]   73 	ld	bc,#_stateArray+0
   3776 21 5F 38      [10]   74 	ld	hl,#_currentState + 0
   3779 5E            [ 7]   75 	ld	e, (hl)
   377A 16 00         [ 7]   76 	ld	d,#0x00
   377C 6B            [ 4]   77 	ld	l, e
   377D 62            [ 4]   78 	ld	h, d
   377E 29            [11]   79 	add	hl, hl
   377F 19            [11]   80 	add	hl, de
   3780 29            [11]   81 	add	hl, hl
   3781 19            [11]   82 	add	hl, de
   3782 29            [11]   83 	add	hl, hl
   3783 09            [11]   84 	add	hl,bc
   3784 11 0C 00      [10]   85 	ld	de, #0x000C
   3787 19            [11]   86 	add	hl, de
   3788 5E            [ 7]   87 	ld	e,(hl)
   3789 23            [ 6]   88 	inc	hl
   378A 66            [ 7]   89 	ld	h,(hl)
   378B C5            [11]   90 	push	bc
   378C 6B            [ 4]   91 	ld	l, e
   378D CD DF 7A      [17]   92 	call	___sdcc_call_hl
   3790 C1            [10]   93 	pop	bc
                             94 ;src/StateManager.c:171: *(u8*)&currentState = stateArray[currentState].lastStateid;
   3791 21 5F 38      [10]   95 	ld	hl,#_currentState + 0
   3794 5E            [ 7]   96 	ld	e, (hl)
   3795 16 00         [ 7]   97 	ld	d,#0x00
   3797 6B            [ 4]   98 	ld	l, e
   3798 62            [ 4]   99 	ld	h, d
   3799 29            [11]  100 	add	hl, hl
   379A 19            [11]  101 	add	hl, de
   379B 29            [11]  102 	add	hl, hl
   379C 19            [11]  103 	add	hl, de
   379D 29            [11]  104 	add	hl, hl
   379E 09            [11]  105 	add	hl,bc
   379F 23            [ 6]  106 	inc	hl
   37A0 5E            [ 7]  107 	ld	e,(hl)
   37A1 21 5F 38      [10]  108 	ld	hl,#_currentState
   37A4 73            [ 7]  109 	ld	(hl),e
                            110 ;src/StateManager.c:172: stateArray[currentState].returnState();
   37A5 21 5F 38      [10]  111 	ld	hl,#_currentState + 0
   37A8 5E            [ 7]  112 	ld	e, (hl)
   37A9 16 00         [ 7]  113 	ld	d,#0x00
   37AB 6B            [ 4]  114 	ld	l, e
   37AC 62            [ 4]  115 	ld	h, d
   37AD 29            [11]  116 	add	hl, hl
   37AE 19            [11]  117 	add	hl, de
   37AF 29            [11]  118 	add	hl, hl
   37B0 19            [11]  119 	add	hl, de
   37B1 29            [11]  120 	add	hl, hl
   37B2 09            [11]  121 	add	hl,bc
   37B3 11 04 00      [10]  122 	ld	de, #0x0004
   37B6 19            [11]  123 	add	hl, de
   37B7 7E            [ 7]  124 	ld	a, (hl)
   37B8 23            [ 6]  125 	inc	hl
   37B9 66            [ 7]  126 	ld	h,(hl)
   37BA 6F            [ 4]  127 	ld	l,a
   37BB CD DF 7A      [17]  128 	call	___sdcc_call_hl
                            129 ;src/StateManager.c:173: *(u8*)&closeState=0;
   37BE 21 5E 38      [10]  130 	ld	hl,#_closeState
   37C1 36 00         [10]  131 	ld	(hl),#0x00
   37C3 C9            [10]  132 	ret
   37C4                     133 _stateArray:
   37C4 00                  134 	.db #0x00	; 0
   37C5 00                  135 	.db #0x00	; 0
   37C6 98 36               136 	.dw _state_mainmenu_enter
   37C8 BD 36               137 	.dw _state_mainmenu_return
   37CA D4 36               138 	.dw _state_mainmenu_input
   37CC 03 37               139 	.dw _state_mainmenu_update
   37CE 6A 37               140 	.dw _state_mainmenu_render
   37D0 6D 37               141 	.dw _state_mainmenu_exit
   37D2 01                  142 	.db #0x01	; 1
   37D3 00                  143 	.db #0x00	; 0
   37D4 91 2F               144 	.dw _state_ingame_enter
   37D6 E4 2F               145 	.dw _state_ingame_return
   37D8 00 30               146 	.dw _state_ingame_input
   37DA 4F 30               147 	.dw _state_ingame_update
   37DC 98 31               148 	.dw _state_ingame_render
   37DE BD 31               149 	.dw _state_ingame_exit
   37E0 02                  150 	.db #0x02	; 2
   37E1 00                  151 	.db #0x00	; 0
   37E2 62 3A               152 	.dw _state_pausemenu_enter
   37E4 90 3A               153 	.dw _state_pausemenu_return
   37E6 BB 3A               154 	.dw _state_pausemenu_input
   37E8 EA 3A               155 	.dw _state_pausemenu_update
   37EA 35 3B               156 	.dw _state_pausemenu_render
   37EC 38 3B               157 	.dw _state_pausemenu_exit
   37EE 03                  158 	.db #0x03	; 3
   37EF 00                  159 	.db #0x00	; 0
   37F0 34 35               160 	.dw _state_loadlevel_enter
   37F2 94 35               161 	.dw _state_loadlevel_return
   37F4 95 35               162 	.dw _state_loadlevel_input
   37F6 98 35               163 	.dw _state_loadlevel_update
   37F8 B2 35               164 	.dw _state_loadlevel_render
   37FA B3 35               165 	.dw _state_loadlevel_exit
   37FC 04                  166 	.db #0x04	; 4
   37FD 00                  167 	.db #0x00	; 0
   37FE 9D 39               168 	.dw _state_options_enter
   3800 CB 39               169 	.dw _state_options_return
   3802 CC 39               170 	.dw _state_options_input
   3804 FB 39               171 	.dw _state_options_update
   3806 4A 3A               172 	.dw _state_options_render
   3808 4D 3A               173 	.dw _state_options_exit
   380A 05                  174 	.db #0x05	; 5
   380B 00                  175 	.db #0x00	; 0
   380C 17 2F               176 	.dw _state_gameover_enter
   380E 7D 2F               177 	.dw _state_gameover_return
   3810 7E 2F               178 	.dw _state_gameover_input
   3812 87 2F               179 	.dw _state_gameover_update
   3814 8F 2F               180 	.dw _state_gameover_render
   3816 90 2F               181 	.dw _state_gameover_exit
   3818 06                  182 	.db #0x06	; 6
   3819 00                  183 	.db #0x00	; 0
   381A D1 2D               184 	.dw _state_credits_enter
   381C F4 2E               185 	.dw _state_credits_return
   381E F5 2E               186 	.dw _state_credits_input
   3820 FE 2E               187 	.dw _state_credits_update
   3822 01 2F               188 	.dw _state_credits_render
   3824 02 2F               189 	.dw _state_credits_exit
   3826 07                  190 	.db #0x07	; 7
   3827 00                  191 	.db #0x00	; 0
   3828 BE 3B               192 	.dw _state_victory_enter
   382A 25 3C               193 	.dw _state_victory_return
   382C 26 3C               194 	.dw _state_victory_input
   382E 2F 3C               195 	.dw _state_victory_update
   3830 37 3C               196 	.dw _state_victory_render
   3832 38 3C               197 	.dw _state_victory_exit
   3834 08                  198 	.db #0x08	; 8
   3835 00                  199 	.db #0x00	; 0
   3836 BE 31               200 	.dw _state_inventory_enter
   3838 F2 31               201 	.dw _state_inventory_return
   383A FB 31               202 	.dw _state_inventory_input
   383C 2A 32               203 	.dw _state_inventory_update
   383E 5D 32               204 	.dw _state_inventory_render
   3840 60 32               205 	.dw _state_inventory_exit
   3842 09                  206 	.db #0x09	; 9
   3843 00                  207 	.db #0x00	; 0
   3844 4D 3B               208 	.dw _state_saveexit_enter
   3846 AA 3B               209 	.dw _state_saveexit_return
   3848 AB 3B               210 	.dw _state_saveexit_input
   384A BB 3B               211 	.dw _state_saveexit_update
   384C BC 3B               212 	.dw _state_saveexit_render
   384E BD 3B               213 	.dw _state_saveexit_exit
   3850 0A                  214 	.db #0x0A	; 10
   3851 00                  215 	.db #0x00	; 0
   3852 75 32               216 	.dw _state_loadgame_enter
   3854 A6 32               217 	.dw _state_loadgame_return
   3856 A7 32               218 	.dw _state_loadgame_input
   3858 F3 34               219 	.dw _state_loadgame_update
   385A 1C 35               220 	.dw _state_loadgame_render
   385C 1F 35               221 	.dw _state_loadgame_exit
   385E                     222 _closeState:
   385E 00                  223 	.db #0x00	; 0
   385F                     224 _currentState:
   385F 00                  225 	.db #0x00	; 0
   3860                     226 _changeToState:
   3860 00                  227 	.db #0x00	; 0
   3861                     228 _inputReceived:
   3861 00                  229 	.db #0x00	; 0
   3862                     230 _gameRunning:
   3862 01                  231 	.db #0x01	; 1
   3863                     232 _last_keyboardStatusBuffer:
   3863 FF                  233 	.db #0xFF	; 255
   3864 FF                  234 	.db #0xFF	; 255
   3865 FF                  235 	.db #0xFF	; 255
   3866 FF                  236 	.db #0xFF	; 255
   3867 FF                  237 	.db #0xFF	; 255
   3868 FF                  238 	.db #0xFF	; 255
   3869 FF                  239 	.db #0xFF	; 255
   386A FF                  240 	.db #0xFF	; 255
   386B FF                  241 	.db #0xFF	; 255
   386C FF                  242 	.db #0xFF	; 255
                            243 ;src/StateManager.c:177: void statemanager_change_state(){
                            244 ;	---------------------------------
                            245 ; Function statemanager_change_state
                            246 ; ---------------------------------
   386D                     247 _statemanager_change_state::
                            248 ;src/StateManager.c:178: if(changeToState){
   386D 21 60 38      [10]  249 	ld	hl,#_changeToState + 0
   3870 4E            [ 7]  250 	ld	c, (hl)
   3871 3A 60 38      [13]  251 	ld	a,(#_changeToState + 0)
   3874 B7            [ 4]  252 	or	a, a
   3875 C8            [11]  253 	ret	Z
                            254 ;src/StateManager.c:179: *(u8*)&(stateArray[changeToState-1].lastStateid) = currentState;
   3876 11 C4 37      [10]  255 	ld	de,#_stateArray+0
   3879 0D            [ 4]  256 	dec	c
   387A 06 00         [ 7]  257 	ld	b,#0x00
   387C 69            [ 4]  258 	ld	l, c
   387D 60            [ 4]  259 	ld	h, b
   387E 29            [11]  260 	add	hl, hl
   387F 09            [11]  261 	add	hl, bc
   3880 29            [11]  262 	add	hl, hl
   3881 09            [11]  263 	add	hl, bc
   3882 29            [11]  264 	add	hl, hl
   3883 19            [11]  265 	add	hl,de
   3884 23            [ 6]  266 	inc	hl
   3885 FD 21 5F 38   [14]  267 	ld	iy,#_currentState
   3889 FD 4E 00      [19]  268 	ld	c,0 (iy)
   388C 71            [ 7]  269 	ld	(hl),c
                            270 ;src/StateManager.c:180: *(u8*)&currentState = changeToState-1;
   388D 21 5F 38      [10]  271 	ld	hl,#_currentState+0
   3890 FD 21 60 38   [14]  272 	ld	iy,#_changeToState
   3894 FD 4E 00      [19]  273 	ld	c,0 (iy)
   3897 0D            [ 4]  274 	dec	c
   3898 71            [ 7]  275 	ld	(hl),c
                            276 ;src/StateManager.c:181: stateArray[currentState].enterState();
   3899 21 5F 38      [10]  277 	ld	hl,#_currentState + 0
   389C 4E            [ 7]  278 	ld	c, (hl)
   389D 06 00         [ 7]  279 	ld	b,#0x00
   389F 69            [ 4]  280 	ld	l, c
   38A0 60            [ 4]  281 	ld	h, b
   38A1 29            [11]  282 	add	hl, hl
   38A2 09            [11]  283 	add	hl, bc
   38A3 29            [11]  284 	add	hl, hl
   38A4 09            [11]  285 	add	hl, bc
   38A5 29            [11]  286 	add	hl, hl
   38A6 19            [11]  287 	add	hl,de
   38A7 23            [ 6]  288 	inc	hl
   38A8 23            [ 6]  289 	inc	hl
   38A9 4E            [ 7]  290 	ld	c,(hl)
   38AA 23            [ 6]  291 	inc	hl
   38AB 66            [ 7]  292 	ld	h,(hl)
   38AC 69            [ 4]  293 	ld	l, c
   38AD CD DF 7A      [17]  294 	call	___sdcc_call_hl
                            295 ;src/StateManager.c:182: *(u8*)&changeToState = 0;
   38B0 21 60 38      [10]  296 	ld	hl,#_changeToState
   38B3 36 00         [10]  297 	ld	(hl),#0x00
   38B5 C9            [10]  298 	ret
                            299 ;src/StateManager.c:186: void statemanager_input_accepted(){
                            300 ;	---------------------------------
                            301 ; Function statemanager_input_accepted
                            302 ; ---------------------------------
   38B6                     303 _statemanager_input_accepted::
                            304 ;src/StateManager.c:187: *(u8*)&inputReceived=1;
   38B6 21 61 38      [10]  305 	ld	hl,#_inputReceived
   38B9 36 01         [10]  306 	ld	(hl),#0x01
   38BB C9            [10]  307 	ret
                            308 ;src/StateManager.c:190: void statemanager_set_state(u8 state) {
                            309 ;	---------------------------------
                            310 ; Function statemanager_set_state
                            311 ; ---------------------------------
   38BC                     312 _statemanager_set_state::
                            313 ;src/StateManager.c:191: *(u8*)&changeToState = state+1;
   38BC 01 60 38      [10]  314 	ld	bc,#_changeToState+0
   38BF 21 02 00      [10]  315 	ld	hl, #2+0
   38C2 39            [11]  316 	add	hl, sp
   38C3 7E            [ 7]  317 	ld	a, (hl)
   38C4 3C            [ 4]  318 	inc	a
   38C5 02            [ 7]  319 	ld	(bc),a
   38C6 C9            [10]  320 	ret
                            321 ;src/StateManager.c:194: void scan_input(){
                            322 ;	---------------------------------
                            323 ; Function scan_input
                            324 ; ---------------------------------
   38C7                     325 _scan_input::
   38C7 DD E5         [15]  326 	push	ix
   38C9 DD 21 00 00   [14]  327 	ld	ix,#0
   38CD DD 39         [15]  328 	add	ix,sp
   38CF F5            [11]  329 	push	af
                            330 ;src/StateManager.c:196: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
                            331 ;src/StateManager.c:197: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
                            332 ;src/StateManager.c:199: cpct_scanKeyboard_f();
   38D0 CD FB 78      [17]  333 	call	_cpct_scanKeyboard_f
                            334 ;src/StateManager.c:200: while(n){
   38D3 1E 0A         [ 7]  335 	ld	e,#0x0A
   38D5 01 6D 7A      [10]  336 	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
   38D8 FD 21 6D 38   [14]  337 	ld	iy,#(_last_keyboardStatusBuffer + 0x000a)
   38DC                     338 00101$:
   38DC 7B            [ 4]  339 	ld	a,e
   38DD B7            [ 4]  340 	or	a, a
   38DE 28 1D         [12]  341 	jr	Z,00103$
                            342 ;src/StateManager.c:201: --n;
   38E0 1D            [ 4]  343 	dec	e
                            344 ;src/StateManager.c:202: --currentStatus;
   38E1 0B            [ 6]  345 	dec	bc
                            346 ;src/StateManager.c:203: --lastStatus;
   38E2 FD 2B         [10]  347 	dec	iy
                            348 ;src/StateManager.c:205: t=*(currentStatus);
   38E4 0A            [ 7]  349 	ld	a,(bc)
   38E5 57            [ 4]  350 	ld	d,a
                            351 ;src/StateManager.c:206: *currentStatus=((*lastStatus)|(~t));
   38E6 FD 7E 00      [19]  352 	ld	a, 0 (iy)
   38E9 DD 77 FF      [19]  353 	ld	-1 (ix),a
   38EC 7A            [ 4]  354 	ld	a,d
   38ED 2F            [ 4]  355 	cpl
   38EE DD 77 FE      [19]  356 	ld	-2 (ix),a
   38F1 DD 7E FF      [19]  357 	ld	a,-1 (ix)
   38F4 DD B6 FE      [19]  358 	or	a, -2 (ix)
   38F7 02            [ 7]  359 	ld	(bc),a
                            360 ;src/StateManager.c:207: *lastStatus=t;
   38F8 FD 72 00      [19]  361 	ld	0 (iy), d
   38FB 18 DF         [12]  362 	jr	00101$
   38FD                     363 00103$:
                            364 ;src/StateManager.c:211: if(cpct_isAnyKeyPressed_f()) ++r_counter;
   38FD CD 69 7B      [17]  365 	call	_cpct_isAnyKeyPressed_f
   3900 7D            [ 4]  366 	ld	a,l
   3901 B7            [ 4]  367 	or	a, a
   3902 28 0A         [12]  368 	jr	Z,00106$
   3904 21 5E 7D      [10]  369 	ld	hl, #_r_counter+0
   3907 34            [11]  370 	inc	(hl)
   3908 20 04         [12]  371 	jr	NZ,00121$
   390A 21 5F 7D      [10]  372 	ld	hl, #_r_counter+1
   390D 34            [11]  373 	inc	(hl)
   390E                     374 00121$:
   390E                     375 00106$:
   390E DD F9         [10]  376 	ld	sp, ix
   3910 DD E1         [14]  377 	pop	ix
   3912 C9            [10]  378 	ret
                            379 ;src/StateManager.c:214: void statemanager_manage_input(){
                            380 ;	---------------------------------
                            381 ; Function statemanager_manage_input
                            382 ; ---------------------------------
   3913                     383 _statemanager_manage_input::
                            384 ;src/StateManager.c:215: while(!inputReceived){
   3913                     385 00101$:
   3913 3A 61 38      [13]  386 	ld	a,(#_inputReceived + 0)
   3916 B7            [ 4]  387 	or	a, a
   3917 20 21         [12]  388 	jr	NZ,00103$
                            389 ;src/StateManager.c:216: scan_input();
   3919 CD C7 38      [17]  390 	call	_scan_input
                            391 ;src/StateManager.c:217: stateArray[currentState].inputState();
   391C 21 5F 38      [10]  392 	ld	hl,#_currentState + 0
   391F 4E            [ 7]  393 	ld	c, (hl)
   3920 06 00         [ 7]  394 	ld	b,#0x00
   3922 69            [ 4]  395 	ld	l, c
   3923 60            [ 4]  396 	ld	h, b
   3924 29            [11]  397 	add	hl, hl
   3925 09            [11]  398 	add	hl, bc
   3926 29            [11]  399 	add	hl, hl
   3927 09            [11]  400 	add	hl, bc
   3928 29            [11]  401 	add	hl, hl
   3929 11 C4 37      [10]  402 	ld	de,#_stateArray
   392C 19            [11]  403 	add	hl,de
   392D 11 06 00      [10]  404 	ld	de, #0x0006
   3930 19            [11]  405 	add	hl, de
   3931 4E            [ 7]  406 	ld	c,(hl)
   3932 23            [ 6]  407 	inc	hl
   3933 66            [ 7]  408 	ld	h,(hl)
   3934 69            [ 4]  409 	ld	l, c
   3935 CD DF 7A      [17]  410 	call	___sdcc_call_hl
   3938 18 D9         [12]  411 	jr	00101$
   393A                     412 00103$:
                            413 ;src/StateManager.c:219: *(u8*)&inputReceived=0;
   393A 21 61 38      [10]  414 	ld	hl,#_inputReceived
   393D 36 00         [10]  415 	ld	(hl),#0x00
   393F C9            [10]  416 	ret
                            417 ;src/StateManager.c:222: void statemanager_render_state(){
                            418 ;	---------------------------------
                            419 ; Function statemanager_render_state
                            420 ; ---------------------------------
   3940                     421 _statemanager_render_state::
                            422 ;src/StateManager.c:223: cpct_waitVSYNC();
   3940 CD 61 7B      [17]  423 	call	_cpct_waitVSYNC
                            424 ;src/StateManager.c:224: stateArray[currentState].renderState();
   3943 01 C4 37      [10]  425 	ld	bc,#_stateArray+0
   3946 21 5F 38      [10]  426 	ld	hl,#_currentState + 0
   3949 5E            [ 7]  427 	ld	e, (hl)
   394A 16 00         [ 7]  428 	ld	d,#0x00
   394C 6B            [ 4]  429 	ld	l, e
   394D 62            [ 4]  430 	ld	h, d
   394E 29            [11]  431 	add	hl, hl
   394F 19            [11]  432 	add	hl, de
   3950 29            [11]  433 	add	hl, hl
   3951 19            [11]  434 	add	hl, de
   3952 29            [11]  435 	add	hl, hl
   3953 09            [11]  436 	add	hl,bc
   3954 11 0A 00      [10]  437 	ld	de, #0x000A
   3957 19            [11]  438 	add	hl, de
   3958 4E            [ 7]  439 	ld	c,(hl)
   3959 23            [ 6]  440 	inc	hl
   395A 66            [ 7]  441 	ld	h,(hl)
   395B 69            [ 4]  442 	ld	l, c
   395C C3 DF 7A      [10]  443 	jp  ___sdcc_call_hl
                            444 ;src/StateManager.c:227: void statemanager_close_state(){
                            445 ;	---------------------------------
                            446 ; Function statemanager_close_state
                            447 ; ---------------------------------
   395F                     448 _statemanager_close_state::
                            449 ;src/StateManager.c:228: *(u8*)&closeState=1;
   395F 21 5E 38      [10]  450 	ld	hl,#_closeState
   3962 36 01         [10]  451 	ld	(hl),#0x01
   3964 C9            [10]  452 	ret
                            453 ;src/StateManager.c:231: void statemanager_update_state(){
                            454 ;	---------------------------------
                            455 ; Function statemanager_update_state
                            456 ; ---------------------------------
   3965                     457 _statemanager_update_state::
                            458 ;src/StateManager.c:232: stateArray[currentState].updateState();
   3965 01 C4 37      [10]  459 	ld	bc,#_stateArray+0
   3968 21 5F 38      [10]  460 	ld	hl,#_currentState + 0
   396B 5E            [ 7]  461 	ld	e, (hl)
   396C 16 00         [ 7]  462 	ld	d,#0x00
   396E 6B            [ 4]  463 	ld	l, e
   396F 62            [ 4]  464 	ld	h, d
   3970 29            [11]  465 	add	hl, hl
   3971 19            [11]  466 	add	hl, de
   3972 29            [11]  467 	add	hl, hl
   3973 19            [11]  468 	add	hl, de
   3974 29            [11]  469 	add	hl, hl
   3975 09            [11]  470 	add	hl,bc
   3976 11 08 00      [10]  471 	ld	de, #0x0008
   3979 19            [11]  472 	add	hl, de
   397A 4E            [ 7]  473 	ld	c,(hl)
   397B 23            [ 6]  474 	inc	hl
   397C 66            [ 7]  475 	ld	h,(hl)
   397D 69            [ 4]  476 	ld	l, c
   397E C3 DF 7A      [10]  477 	jp  ___sdcc_call_hl
                            478 ;src/StateManager.c:235: void statemanager_exit_game(){
                            479 ;	---------------------------------
                            480 ; Function statemanager_exit_game
                            481 ; ---------------------------------
   3981                     482 _statemanager_exit_game::
                            483 ;src/StateManager.c:236: *(u8*)&gameRunning=0;
   3981 21 62 38      [10]  484 	ld	hl,#_gameRunning
   3984 36 00         [10]  485 	ld	(hl),#0x00
   3986 C9            [10]  486 	ret
                            487 ;src/StateManager.c:239: void statemanager_main_loop(){
                            488 ;	---------------------------------
                            489 ; Function statemanager_main_loop
                            490 ; ---------------------------------
   3987                     491 _statemanager_main_loop::
                            492 ;src/StateManager.c:240: while(gameRunning) {
   3987                     493 00101$:
   3987 3A 62 38      [13]  494 	ld	a,(#_gameRunning + 0)
   398A B7            [ 4]  495 	or	a, a
   398B C8            [11]  496 	ret	Z
                            497 ;src/StateManager.c:241: statemanager_drop_state();
   398C CD 6E 37      [17]  498 	call	_statemanager_drop_state
                            499 ;src/StateManager.c:242: statemanager_change_state();
   398F CD 6D 38      [17]  500 	call	_statemanager_change_state
                            501 ;src/StateManager.c:243: statemanager_manage_input();
   3992 CD 13 39      [17]  502 	call	_statemanager_manage_input
                            503 ;src/StateManager.c:244: statemanager_update_state();
   3995 CD 65 39      [17]  504 	call	_statemanager_update_state
                            505 ;src/StateManager.c:245: statemanager_render_state();
   3998 CD 40 39      [17]  506 	call	_statemanager_render_state
   399B 18 EA         [12]  507 	jr	00101$
                            508 	.area _CODE
                            509 	.area _INITIALIZER
                            510 	.area _CABS (ABS)
