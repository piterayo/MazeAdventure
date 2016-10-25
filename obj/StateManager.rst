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
   3748                      67 _statemanager_drop_state::
                             68 ;src/StateManager.c:169: if(closeState){
   3748 3A 38 38      [13]   69 	ld	a,(#_closeState + 0)
   374B B7            [ 4]   70 	or	a, a
   374C C8            [11]   71 	ret	Z
                             72 ;src/StateManager.c:170: stateArray[currentState].exitState();
   374D 01 9E 37      [10]   73 	ld	bc,#_stateArray+0
   3750 21 39 38      [10]   74 	ld	hl,#_currentState + 0
   3753 5E            [ 7]   75 	ld	e, (hl)
   3754 16 00         [ 7]   76 	ld	d,#0x00
   3756 6B            [ 4]   77 	ld	l, e
   3757 62            [ 4]   78 	ld	h, d
   3758 29            [11]   79 	add	hl, hl
   3759 19            [11]   80 	add	hl, de
   375A 29            [11]   81 	add	hl, hl
   375B 19            [11]   82 	add	hl, de
   375C 29            [11]   83 	add	hl, hl
   375D 09            [11]   84 	add	hl,bc
   375E 11 0C 00      [10]   85 	ld	de, #0x000C
   3761 19            [11]   86 	add	hl, de
   3762 5E            [ 7]   87 	ld	e,(hl)
   3763 23            [ 6]   88 	inc	hl
   3764 66            [ 7]   89 	ld	h,(hl)
   3765 C5            [11]   90 	push	bc
   3766 6B            [ 4]   91 	ld	l, e
   3767 CD 97 7B      [17]   92 	call	___sdcc_call_hl
   376A C1            [10]   93 	pop	bc
                             94 ;src/StateManager.c:171: *(u8*)&currentState = stateArray[currentState].lastStateid;
   376B 21 39 38      [10]   95 	ld	hl,#_currentState + 0
   376E 5E            [ 7]   96 	ld	e, (hl)
   376F 16 00         [ 7]   97 	ld	d,#0x00
   3771 6B            [ 4]   98 	ld	l, e
   3772 62            [ 4]   99 	ld	h, d
   3773 29            [11]  100 	add	hl, hl
   3774 19            [11]  101 	add	hl, de
   3775 29            [11]  102 	add	hl, hl
   3776 19            [11]  103 	add	hl, de
   3777 29            [11]  104 	add	hl, hl
   3778 09            [11]  105 	add	hl,bc
   3779 23            [ 6]  106 	inc	hl
   377A 5E            [ 7]  107 	ld	e,(hl)
   377B 21 39 38      [10]  108 	ld	hl,#_currentState
   377E 73            [ 7]  109 	ld	(hl),e
                            110 ;src/StateManager.c:172: stateArray[currentState].returnState();
   377F 21 39 38      [10]  111 	ld	hl,#_currentState + 0
   3782 5E            [ 7]  112 	ld	e, (hl)
   3783 16 00         [ 7]  113 	ld	d,#0x00
   3785 6B            [ 4]  114 	ld	l, e
   3786 62            [ 4]  115 	ld	h, d
   3787 29            [11]  116 	add	hl, hl
   3788 19            [11]  117 	add	hl, de
   3789 29            [11]  118 	add	hl, hl
   378A 19            [11]  119 	add	hl, de
   378B 29            [11]  120 	add	hl, hl
   378C 09            [11]  121 	add	hl,bc
   378D 11 04 00      [10]  122 	ld	de, #0x0004
   3790 19            [11]  123 	add	hl, de
   3791 7E            [ 7]  124 	ld	a, (hl)
   3792 23            [ 6]  125 	inc	hl
   3793 66            [ 7]  126 	ld	h,(hl)
   3794 6F            [ 4]  127 	ld	l,a
   3795 CD 97 7B      [17]  128 	call	___sdcc_call_hl
                            129 ;src/StateManager.c:173: *(u8*)&closeState=0;
   3798 21 38 38      [10]  130 	ld	hl,#_closeState
   379B 36 00         [10]  131 	ld	(hl),#0x00
   379D C9            [10]  132 	ret
   379E                     133 _stateArray:
   379E 00                  134 	.db #0x00	; 0
   379F 00                  135 	.db #0x00	; 0
   37A0 72 36               136 	.dw _state_mainmenu_enter
   37A2 97 36               137 	.dw _state_mainmenu_return
   37A4 AE 36               138 	.dw _state_mainmenu_input
   37A6 DD 36               139 	.dw _state_mainmenu_update
   37A8 44 37               140 	.dw _state_mainmenu_render
   37AA 47 37               141 	.dw _state_mainmenu_exit
   37AC 01                  142 	.db #0x01	; 1
   37AD 00                  143 	.db #0x00	; 0
   37AE 48 2F               144 	.dw _state_ingame_enter
   37B0 9B 2F               145 	.dw _state_ingame_return
   37B2 B7 2F               146 	.dw _state_ingame_input
   37B4 29 30               147 	.dw _state_ingame_update
   37B6 72 31               148 	.dw _state_ingame_render
   37B8 97 31               149 	.dw _state_ingame_exit
   37BA 02                  150 	.db #0x02	; 2
   37BB 00                  151 	.db #0x00	; 0
   37BC 3C 3A               152 	.dw _state_pausemenu_enter
   37BE 6A 3A               153 	.dw _state_pausemenu_return
   37C0 95 3A               154 	.dw _state_pausemenu_input
   37C2 C4 3A               155 	.dw _state_pausemenu_update
   37C4 0F 3B               156 	.dw _state_pausemenu_render
   37C6 12 3B               157 	.dw _state_pausemenu_exit
   37C8 03                  158 	.db #0x03	; 3
   37C9 00                  159 	.db #0x00	; 0
   37CA 0E 35               160 	.dw _state_loadlevel_enter
   37CC 6E 35               161 	.dw _state_loadlevel_return
   37CE 6F 35               162 	.dw _state_loadlevel_input
   37D0 72 35               163 	.dw _state_loadlevel_update
   37D2 8C 35               164 	.dw _state_loadlevel_render
   37D4 8D 35               165 	.dw _state_loadlevel_exit
   37D6 04                  166 	.db #0x04	; 4
   37D7 00                  167 	.db #0x00	; 0
   37D8 77 39               168 	.dw _state_options_enter
   37DA A5 39               169 	.dw _state_options_return
   37DC A6 39               170 	.dw _state_options_input
   37DE D5 39               171 	.dw _state_options_update
   37E0 24 3A               172 	.dw _state_options_render
   37E2 27 3A               173 	.dw _state_options_exit
   37E4 05                  174 	.db #0x05	; 5
   37E5 00                  175 	.db #0x00	; 0
   37E6 CE 2E               176 	.dw _state_gameover_enter
   37E8 34 2F               177 	.dw _state_gameover_return
   37EA 35 2F               178 	.dw _state_gameover_input
   37EC 3E 2F               179 	.dw _state_gameover_update
   37EE 46 2F               180 	.dw _state_gameover_render
   37F0 47 2F               181 	.dw _state_gameover_exit
   37F2 06                  182 	.db #0x06	; 6
   37F3 00                  183 	.db #0x00	; 0
   37F4 88 2D               184 	.dw _state_credits_enter
   37F6 AB 2E               185 	.dw _state_credits_return
   37F8 AC 2E               186 	.dw _state_credits_input
   37FA B5 2E               187 	.dw _state_credits_update
   37FC B8 2E               188 	.dw _state_credits_render
   37FE B9 2E               189 	.dw _state_credits_exit
   3800 07                  190 	.db #0x07	; 7
   3801 00                  191 	.db #0x00	; 0
   3802 98 3B               192 	.dw _state_victory_enter
   3804 FF 3B               193 	.dw _state_victory_return
   3806 00 3C               194 	.dw _state_victory_input
   3808 09 3C               195 	.dw _state_victory_update
   380A 11 3C               196 	.dw _state_victory_render
   380C 12 3C               197 	.dw _state_victory_exit
   380E 08                  198 	.db #0x08	; 8
   380F 00                  199 	.db #0x00	; 0
   3810 98 31               200 	.dw _state_inventory_enter
   3812 CC 31               201 	.dw _state_inventory_return
   3814 D5 31               202 	.dw _state_inventory_input
   3816 04 32               203 	.dw _state_inventory_update
   3818 37 32               204 	.dw _state_inventory_render
   381A 3A 32               205 	.dw _state_inventory_exit
   381C 09                  206 	.db #0x09	; 9
   381D 00                  207 	.db #0x00	; 0
   381E 27 3B               208 	.dw _state_saveexit_enter
   3820 84 3B               209 	.dw _state_saveexit_return
   3822 85 3B               210 	.dw _state_saveexit_input
   3824 95 3B               211 	.dw _state_saveexit_update
   3826 96 3B               212 	.dw _state_saveexit_render
   3828 97 3B               213 	.dw _state_saveexit_exit
   382A 0A                  214 	.db #0x0A	; 10
   382B 00                  215 	.db #0x00	; 0
   382C 4F 32               216 	.dw _state_loadgame_enter
   382E 80 32               217 	.dw _state_loadgame_return
   3830 81 32               218 	.dw _state_loadgame_input
   3832 CD 34               219 	.dw _state_loadgame_update
   3834 F6 34               220 	.dw _state_loadgame_render
   3836 F9 34               221 	.dw _state_loadgame_exit
   3838                     222 _closeState:
   3838 00                  223 	.db #0x00	; 0
   3839                     224 _currentState:
   3839 00                  225 	.db #0x00	; 0
   383A                     226 _changeToState:
   383A 00                  227 	.db #0x00	; 0
   383B                     228 _inputReceived:
   383B 00                  229 	.db #0x00	; 0
   383C                     230 _gameRunning:
   383C 01                  231 	.db #0x01	; 1
   383D                     232 _last_keyboardStatusBuffer:
   383D FF                  233 	.db #0xFF	; 255
   383E FF                  234 	.db #0xFF	; 255
   383F FF                  235 	.db #0xFF	; 255
   3840 FF                  236 	.db #0xFF	; 255
   3841 FF                  237 	.db #0xFF	; 255
   3842 FF                  238 	.db #0xFF	; 255
   3843 FF                  239 	.db #0xFF	; 255
   3844 FF                  240 	.db #0xFF	; 255
   3845 FF                  241 	.db #0xFF	; 255
   3846 FF                  242 	.db #0xFF	; 255
                            243 ;src/StateManager.c:177: void statemanager_change_state(){
                            244 ;	---------------------------------
                            245 ; Function statemanager_change_state
                            246 ; ---------------------------------
   3847                     247 _statemanager_change_state::
                            248 ;src/StateManager.c:178: if(changeToState){
   3847 21 3A 38      [10]  249 	ld	hl,#_changeToState + 0
   384A 4E            [ 7]  250 	ld	c, (hl)
   384B 3A 3A 38      [13]  251 	ld	a,(#_changeToState + 0)
   384E B7            [ 4]  252 	or	a, a
   384F C8            [11]  253 	ret	Z
                            254 ;src/StateManager.c:179: *(u8*)&(stateArray[changeToState-1].lastStateid) = currentState;
   3850 11 9E 37      [10]  255 	ld	de,#_stateArray+0
   3853 0D            [ 4]  256 	dec	c
   3854 06 00         [ 7]  257 	ld	b,#0x00
   3856 69            [ 4]  258 	ld	l, c
   3857 60            [ 4]  259 	ld	h, b
   3858 29            [11]  260 	add	hl, hl
   3859 09            [11]  261 	add	hl, bc
   385A 29            [11]  262 	add	hl, hl
   385B 09            [11]  263 	add	hl, bc
   385C 29            [11]  264 	add	hl, hl
   385D 19            [11]  265 	add	hl,de
   385E 23            [ 6]  266 	inc	hl
   385F FD 21 39 38   [14]  267 	ld	iy,#_currentState
   3863 FD 4E 00      [19]  268 	ld	c,0 (iy)
   3866 71            [ 7]  269 	ld	(hl),c
                            270 ;src/StateManager.c:180: *(u8*)&currentState = changeToState-1;
   3867 21 39 38      [10]  271 	ld	hl,#_currentState+0
   386A FD 21 3A 38   [14]  272 	ld	iy,#_changeToState
   386E FD 4E 00      [19]  273 	ld	c,0 (iy)
   3871 0D            [ 4]  274 	dec	c
   3872 71            [ 7]  275 	ld	(hl),c
                            276 ;src/StateManager.c:181: stateArray[currentState].enterState();
   3873 21 39 38      [10]  277 	ld	hl,#_currentState + 0
   3876 4E            [ 7]  278 	ld	c, (hl)
   3877 06 00         [ 7]  279 	ld	b,#0x00
   3879 69            [ 4]  280 	ld	l, c
   387A 60            [ 4]  281 	ld	h, b
   387B 29            [11]  282 	add	hl, hl
   387C 09            [11]  283 	add	hl, bc
   387D 29            [11]  284 	add	hl, hl
   387E 09            [11]  285 	add	hl, bc
   387F 29            [11]  286 	add	hl, hl
   3880 19            [11]  287 	add	hl,de
   3881 23            [ 6]  288 	inc	hl
   3882 23            [ 6]  289 	inc	hl
   3883 4E            [ 7]  290 	ld	c,(hl)
   3884 23            [ 6]  291 	inc	hl
   3885 66            [ 7]  292 	ld	h,(hl)
   3886 69            [ 4]  293 	ld	l, c
   3887 CD 97 7B      [17]  294 	call	___sdcc_call_hl
                            295 ;src/StateManager.c:182: *(u8*)&changeToState = 0;
   388A 21 3A 38      [10]  296 	ld	hl,#_changeToState
   388D 36 00         [10]  297 	ld	(hl),#0x00
   388F C9            [10]  298 	ret
                            299 ;src/StateManager.c:186: void statemanager_input_accepted(){
                            300 ;	---------------------------------
                            301 ; Function statemanager_input_accepted
                            302 ; ---------------------------------
   3890                     303 _statemanager_input_accepted::
                            304 ;src/StateManager.c:187: *(u8*)&inputReceived=1;
   3890 21 3B 38      [10]  305 	ld	hl,#_inputReceived
   3893 36 01         [10]  306 	ld	(hl),#0x01
   3895 C9            [10]  307 	ret
                            308 ;src/StateManager.c:190: void statemanager_set_state(u8 state) {
                            309 ;	---------------------------------
                            310 ; Function statemanager_set_state
                            311 ; ---------------------------------
   3896                     312 _statemanager_set_state::
                            313 ;src/StateManager.c:191: *(u8*)&changeToState = state+1;
   3896 01 3A 38      [10]  314 	ld	bc,#_changeToState+0
   3899 21 02 00      [10]  315 	ld	hl, #2+0
   389C 39            [11]  316 	add	hl, sp
   389D 7E            [ 7]  317 	ld	a, (hl)
   389E 3C            [ 4]  318 	inc	a
   389F 02            [ 7]  319 	ld	(bc),a
   38A0 C9            [10]  320 	ret
                            321 ;src/StateManager.c:194: void scan_input(){
                            322 ;	---------------------------------
                            323 ; Function scan_input
                            324 ; ---------------------------------
   38A1                     325 _scan_input::
   38A1 DD E5         [15]  326 	push	ix
   38A3 DD 21 00 00   [14]  327 	ld	ix,#0
   38A7 DD 39         [15]  328 	add	ix,sp
   38A9 F5            [11]  329 	push	af
                            330 ;src/StateManager.c:196: u8* currentStatus=(cpct_keyboardStatusBuffer+n);
                            331 ;src/StateManager.c:197: u8* lastStatus=(((u8*)last_keyboardStatusBuffer)+n);
                            332 ;src/StateManager.c:199: cpct_scanKeyboard_f();
   38AA CD B3 79      [17]  333 	call	_cpct_scanKeyboard_f
                            334 ;src/StateManager.c:200: while(n){
   38AD 1E 0A         [ 7]  335 	ld	e,#0x0A
   38AF 01 25 7B      [10]  336 	ld	bc,#(_cpct_keyboardStatusBuffer + 0x000a)
   38B2 FD 21 47 38   [14]  337 	ld	iy,#(_last_keyboardStatusBuffer + 0x000a)
   38B6                     338 00101$:
   38B6 7B            [ 4]  339 	ld	a,e
   38B7 B7            [ 4]  340 	or	a, a
   38B8 28 1D         [12]  341 	jr	Z,00103$
                            342 ;src/StateManager.c:201: --n;
   38BA 1D            [ 4]  343 	dec	e
                            344 ;src/StateManager.c:202: --currentStatus;
   38BB 0B            [ 6]  345 	dec	bc
                            346 ;src/StateManager.c:203: --lastStatus;
   38BC FD 2B         [10]  347 	dec	iy
                            348 ;src/StateManager.c:205: t=*(currentStatus);
   38BE 0A            [ 7]  349 	ld	a,(bc)
   38BF 57            [ 4]  350 	ld	d,a
                            351 ;src/StateManager.c:206: *currentStatus=((*lastStatus)|(~t));
   38C0 FD 7E 00      [19]  352 	ld	a, 0 (iy)
   38C3 DD 77 FF      [19]  353 	ld	-1 (ix),a
   38C6 7A            [ 4]  354 	ld	a,d
   38C7 2F            [ 4]  355 	cpl
   38C8 DD 77 FE      [19]  356 	ld	-2 (ix),a
   38CB DD 7E FF      [19]  357 	ld	a,-1 (ix)
   38CE DD B6 FE      [19]  358 	or	a, -2 (ix)
   38D1 02            [ 7]  359 	ld	(bc),a
                            360 ;src/StateManager.c:207: *lastStatus=t;
   38D2 FD 72 00      [19]  361 	ld	0 (iy), d
   38D5 18 DF         [12]  362 	jr	00101$
   38D7                     363 00103$:
                            364 ;src/StateManager.c:211: if(cpct_isAnyKeyPressed_f()) ++r_counter;
   38D7 CD 21 7C      [17]  365 	call	_cpct_isAnyKeyPressed_f
   38DA 7D            [ 4]  366 	ld	a,l
   38DB B7            [ 4]  367 	or	a, a
   38DC 28 0A         [12]  368 	jr	Z,00106$
   38DE 21 16 7E      [10]  369 	ld	hl, #_r_counter+0
   38E1 34            [11]  370 	inc	(hl)
   38E2 20 04         [12]  371 	jr	NZ,00121$
   38E4 21 17 7E      [10]  372 	ld	hl, #_r_counter+1
   38E7 34            [11]  373 	inc	(hl)
   38E8                     374 00121$:
   38E8                     375 00106$:
   38E8 DD F9         [10]  376 	ld	sp, ix
   38EA DD E1         [14]  377 	pop	ix
   38EC C9            [10]  378 	ret
                            379 ;src/StateManager.c:214: void statemanager_manage_input(){
                            380 ;	---------------------------------
                            381 ; Function statemanager_manage_input
                            382 ; ---------------------------------
   38ED                     383 _statemanager_manage_input::
                            384 ;src/StateManager.c:215: while(!inputReceived){
   38ED                     385 00101$:
   38ED 3A 3B 38      [13]  386 	ld	a,(#_inputReceived + 0)
   38F0 B7            [ 4]  387 	or	a, a
   38F1 20 21         [12]  388 	jr	NZ,00103$
                            389 ;src/StateManager.c:216: scan_input();
   38F3 CD A1 38      [17]  390 	call	_scan_input
                            391 ;src/StateManager.c:217: stateArray[currentState].inputState();
   38F6 21 39 38      [10]  392 	ld	hl,#_currentState + 0
   38F9 4E            [ 7]  393 	ld	c, (hl)
   38FA 06 00         [ 7]  394 	ld	b,#0x00
   38FC 69            [ 4]  395 	ld	l, c
   38FD 60            [ 4]  396 	ld	h, b
   38FE 29            [11]  397 	add	hl, hl
   38FF 09            [11]  398 	add	hl, bc
   3900 29            [11]  399 	add	hl, hl
   3901 09            [11]  400 	add	hl, bc
   3902 29            [11]  401 	add	hl, hl
   3903 11 9E 37      [10]  402 	ld	de,#_stateArray
   3906 19            [11]  403 	add	hl,de
   3907 11 06 00      [10]  404 	ld	de, #0x0006
   390A 19            [11]  405 	add	hl, de
   390B 4E            [ 7]  406 	ld	c,(hl)
   390C 23            [ 6]  407 	inc	hl
   390D 66            [ 7]  408 	ld	h,(hl)
   390E 69            [ 4]  409 	ld	l, c
   390F CD 97 7B      [17]  410 	call	___sdcc_call_hl
   3912 18 D9         [12]  411 	jr	00101$
   3914                     412 00103$:
                            413 ;src/StateManager.c:219: *(u8*)&inputReceived=0;
   3914 21 3B 38      [10]  414 	ld	hl,#_inputReceived
   3917 36 00         [10]  415 	ld	(hl),#0x00
   3919 C9            [10]  416 	ret
                            417 ;src/StateManager.c:222: void statemanager_render_state(){
                            418 ;	---------------------------------
                            419 ; Function statemanager_render_state
                            420 ; ---------------------------------
   391A                     421 _statemanager_render_state::
                            422 ;src/StateManager.c:223: cpct_waitVSYNC();
   391A CD 19 7C      [17]  423 	call	_cpct_waitVSYNC
                            424 ;src/StateManager.c:224: stateArray[currentState].renderState();
   391D 01 9E 37      [10]  425 	ld	bc,#_stateArray+0
   3920 21 39 38      [10]  426 	ld	hl,#_currentState + 0
   3923 5E            [ 7]  427 	ld	e, (hl)
   3924 16 00         [ 7]  428 	ld	d,#0x00
   3926 6B            [ 4]  429 	ld	l, e
   3927 62            [ 4]  430 	ld	h, d
   3928 29            [11]  431 	add	hl, hl
   3929 19            [11]  432 	add	hl, de
   392A 29            [11]  433 	add	hl, hl
   392B 19            [11]  434 	add	hl, de
   392C 29            [11]  435 	add	hl, hl
   392D 09            [11]  436 	add	hl,bc
   392E 11 0A 00      [10]  437 	ld	de, #0x000A
   3931 19            [11]  438 	add	hl, de
   3932 4E            [ 7]  439 	ld	c,(hl)
   3933 23            [ 6]  440 	inc	hl
   3934 66            [ 7]  441 	ld	h,(hl)
   3935 69            [ 4]  442 	ld	l, c
   3936 C3 97 7B      [10]  443 	jp  ___sdcc_call_hl
                            444 ;src/StateManager.c:227: void statemanager_close_state(){
                            445 ;	---------------------------------
                            446 ; Function statemanager_close_state
                            447 ; ---------------------------------
   3939                     448 _statemanager_close_state::
                            449 ;src/StateManager.c:228: *(u8*)&closeState=1;
   3939 21 38 38      [10]  450 	ld	hl,#_closeState
   393C 36 01         [10]  451 	ld	(hl),#0x01
   393E C9            [10]  452 	ret
                            453 ;src/StateManager.c:231: void statemanager_update_state(){
                            454 ;	---------------------------------
                            455 ; Function statemanager_update_state
                            456 ; ---------------------------------
   393F                     457 _statemanager_update_state::
                            458 ;src/StateManager.c:232: stateArray[currentState].updateState();
   393F 01 9E 37      [10]  459 	ld	bc,#_stateArray+0
   3942 21 39 38      [10]  460 	ld	hl,#_currentState + 0
   3945 5E            [ 7]  461 	ld	e, (hl)
   3946 16 00         [ 7]  462 	ld	d,#0x00
   3948 6B            [ 4]  463 	ld	l, e
   3949 62            [ 4]  464 	ld	h, d
   394A 29            [11]  465 	add	hl, hl
   394B 19            [11]  466 	add	hl, de
   394C 29            [11]  467 	add	hl, hl
   394D 19            [11]  468 	add	hl, de
   394E 29            [11]  469 	add	hl, hl
   394F 09            [11]  470 	add	hl,bc
   3950 11 08 00      [10]  471 	ld	de, #0x0008
   3953 19            [11]  472 	add	hl, de
   3954 4E            [ 7]  473 	ld	c,(hl)
   3955 23            [ 6]  474 	inc	hl
   3956 66            [ 7]  475 	ld	h,(hl)
   3957 69            [ 4]  476 	ld	l, c
   3958 C3 97 7B      [10]  477 	jp  ___sdcc_call_hl
                            478 ;src/StateManager.c:235: void statemanager_exit_game(){
                            479 ;	---------------------------------
                            480 ; Function statemanager_exit_game
                            481 ; ---------------------------------
   395B                     482 _statemanager_exit_game::
                            483 ;src/StateManager.c:236: *(u8*)&gameRunning=0;
   395B 21 3C 38      [10]  484 	ld	hl,#_gameRunning
   395E 36 00         [10]  485 	ld	(hl),#0x00
   3960 C9            [10]  486 	ret
                            487 ;src/StateManager.c:239: void statemanager_main_loop(){
                            488 ;	---------------------------------
                            489 ; Function statemanager_main_loop
                            490 ; ---------------------------------
   3961                     491 _statemanager_main_loop::
                            492 ;src/StateManager.c:240: while(gameRunning) {
   3961                     493 00101$:
   3961 3A 3C 38      [13]  494 	ld	a,(#_gameRunning + 0)
   3964 B7            [ 4]  495 	or	a, a
   3965 C8            [11]  496 	ret	Z
                            497 ;src/StateManager.c:241: statemanager_drop_state();
   3966 CD 48 37      [17]  498 	call	_statemanager_drop_state
                            499 ;src/StateManager.c:242: statemanager_change_state();
   3969 CD 47 38      [17]  500 	call	_statemanager_change_state
                            501 ;src/StateManager.c:243: statemanager_manage_input();
   396C CD ED 38      [17]  502 	call	_statemanager_manage_input
                            503 ;src/StateManager.c:244: statemanager_update_state();
   396F CD 3F 39      [17]  504 	call	_statemanager_update_state
                            505 ;src/StateManager.c:245: statemanager_render_state();
   3972 CD 1A 39      [17]  506 	call	_statemanager_render_state
   3975 18 EA         [12]  507 	jr	00101$
                            508 	.area _CODE
                            509 	.area _INITIALIZER
                            510 	.area _CABS (ABS)
