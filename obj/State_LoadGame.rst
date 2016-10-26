                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_LoadGame
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_loadgame_render_all
                             12 	.globl _ui_loadgame_unselect_entry
                             13 	.globl _ui_loadgame_select_entry
                             14 	.globl _ui_loadgame_previous_entry
                             15 	.globl _ui_loadgame_next_entry
                             16 	.globl _ui_loadgame_is_selected
                             17 	.globl _ui_loadgame_get_entry
                             18 	.globl _ui_loadgame_init
                             19 	.globl _ui_stringinput_remove_char
                             20 	.globl _ui_stringinput_get_string
                             21 	.globl _ui_stringinput_add_char
                             22 	.globl _ui_stringinput_init
                             23 	.globl _savegame_Load
                             24 	.globl _statemanager_input_accepted
                             25 	.globl _statemanager_close_state
                             26 	.globl _cpct_drawSolidBox
                             27 	.globl _cpct_isKeyPressed
                             28 	.globl _state_loadgame_enter
                             29 	.globl _state_loadgame_return
                             30 	.globl _state_loadgame_input
                             31 	.globl _state_loadgame_update
                             32 	.globl _state_loadgame_render
                             33 	.globl _state_loadgame_exit
                             34 ;--------------------------------------------------------
                             35 ; special function registers
                             36 ;--------------------------------------------------------
                             37 ;--------------------------------------------------------
                             38 ; ram data
                             39 ;--------------------------------------------------------
                             40 	.area _DATA
                             41 ;--------------------------------------------------------
                             42 ; ram data
                             43 ;--------------------------------------------------------
                             44 	.area _INITIALIZED
                             45 ;--------------------------------------------------------
                             46 ; absolute external ram data
                             47 ;--------------------------------------------------------
                             48 	.area _DABS (ABS)
                             49 ;--------------------------------------------------------
                             50 ; global & static initialisations
                             51 ;--------------------------------------------------------
                             52 	.area _HOME
                             53 	.area _GSINIT
                             54 	.area _GSFINAL
                             55 	.area _GSINIT
                             56 ;--------------------------------------------------------
                             57 ; Home
                             58 ;--------------------------------------------------------
                             59 	.area _HOME
                             60 	.area _HOME
                             61 ;--------------------------------------------------------
                             62 ; code
                             63 ;--------------------------------------------------------
                             64 	.area _CODE
                             65 ;src/State_LoadGame.c:17: void state_loadgame_enter(){
                             66 ;	---------------------------------
                             67 ; Function state_loadgame_enter
                             68 ; ---------------------------------
   33AC                      69 _state_loadgame_enter::
                             70 ;src/State_LoadGame.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[4], 44, 42);
   33AC 21 2C 1C      [10]   71 	ld	hl, #_g_colors + 4
   33AF 46            [ 7]   72 	ld	b,(hl)
   33B0 21 2C 2A      [10]   73 	ld	hl,#0x2A2C
   33B3 E5            [11]   74 	push	hl
   33B4 C5            [11]   75 	push	bc
   33B5 33            [ 6]   76 	inc	sp
   33B6 21 E2 FA      [10]   77 	ld	hl,#0xFAE2
   33B9 E5            [11]   78 	push	hl
   33BA CD 2F 85      [17]   79 	call	_cpct_drawSolidBox
   33BD F1            [10]   80 	pop	af
   33BE F1            [10]   81 	pop	af
   33BF 33            [ 6]   82 	inc	sp
                             83 ;src/State_LoadGame.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 19, 83), g_colors[1], 42, 34);
   33C0 21 29 1C      [10]   84 	ld	hl, #_g_colors + 1
   33C3 46            [ 7]   85 	ld	b,(hl)
   33C4 21 2A 22      [10]   86 	ld	hl,#0x222A
   33C7 E5            [11]   87 	push	hl
   33C8 C5            [11]   88 	push	bc
   33C9 33            [ 6]   89 	inc	sp
   33CA 21 33 DB      [10]   90 	ld	hl,#0xDB33
   33CD E5            [11]   91 	push	hl
   33CE CD 2F 85      [17]   92 	call	_cpct_drawSolidBox
   33D1 F1            [10]   93 	pop	af
   33D2 F1            [10]   94 	pop	af
   33D3 33            [ 6]   95 	inc	sp
                             96 ;src/State_LoadGame.c:20: ui_loadgame_init();
   33D4 CD 7A 47      [17]   97 	call	_ui_loadgame_init
                             98 ;src/State_LoadGame.c:21: ui_stringinput_init();
   33D7 CD 87 3D      [17]   99 	call	_ui_stringinput_init
                            100 ;src/State_LoadGame.c:22: ui_loadgame_render_all();
   33DA C3 4B 48      [10]  101 	jp  _ui_loadgame_render_all
                            102 ;src/State_LoadGame.c:25: void state_loadgame_return(){
                            103 ;	---------------------------------
                            104 ; Function state_loadgame_return
                            105 ; ---------------------------------
   33DD                     106 _state_loadgame_return::
                            107 ;src/State_LoadGame.c:27: }
   33DD C9            [10]  108 	ret
                            109 ;src/State_LoadGame.c:30: void state_loadgame_input(){
                            110 ;	---------------------------------
                            111 ; Function state_loadgame_input
                            112 ; ---------------------------------
   33DE                     113 _state_loadgame_input::
                            114 ;src/State_LoadGame.c:33: if(cpct_isKeyPressed(Key_CursorLeft)){
   33DE 21 01 01      [10]  115 	ld	hl,#0x0101
   33E1 CD B3 7A      [17]  116 	call	_cpct_isKeyPressed
   33E4 7D            [ 4]  117 	ld	a,l
   33E5 B7            [ 4]  118 	or	a, a
   33E6 28 06         [12]  119 	jr	Z,00185$
                            120 ;src/State_LoadGame.c:34: ui_loadgame_previous_entry();
   33E8 CD C4 47      [17]  121 	call	_ui_loadgame_previous_entry
                            122 ;src/State_LoadGame.c:35: statemanager_input_accepted();
   33EB C3 FB 39      [10]  123 	jp  _statemanager_input_accepted
   33EE                     124 00185$:
                            125 ;src/State_LoadGame.c:37: else if(cpct_isKeyPressed(Key_CursorRight)){
   33EE 21 00 02      [10]  126 	ld	hl,#0x0200
   33F1 CD B3 7A      [17]  127 	call	_cpct_isKeyPressed
   33F4 7D            [ 4]  128 	ld	a,l
   33F5 B7            [ 4]  129 	or	a, a
   33F6 28 06         [12]  130 	jr	Z,00182$
                            131 ;src/State_LoadGame.c:38: ui_loadgame_next_entry();
   33F8 CD B0 47      [17]  132 	call	_ui_loadgame_next_entry
                            133 ;src/State_LoadGame.c:39: statemanager_input_accepted();
   33FB C3 FB 39      [10]  134 	jp  _statemanager_input_accepted
   33FE                     135 00182$:
                            136 ;src/State_LoadGame.c:41: else if(cpct_isKeyPressed(Key_Return)){
   33FE 21 02 04      [10]  137 	ld	hl,#0x0402
   3401 CD B3 7A      [17]  138 	call	_cpct_isKeyPressed
   3404 7D            [ 4]  139 	ld	a,l
   3405 B7            [ 4]  140 	or	a, a
   3406 28 06         [12]  141 	jr	Z,00179$
                            142 ;src/State_LoadGame.c:42: ui_loadgame_select_entry();
   3408 CD D5 47      [17]  143 	call	_ui_loadgame_select_entry
                            144 ;src/State_LoadGame.c:43: statemanager_input_accepted();
   340B C3 FB 39      [10]  145 	jp  _statemanager_input_accepted
   340E                     146 00179$:
                            147 ;src/State_LoadGame.c:45: else if(cpct_isKeyPressed(Key_0)){
   340E 21 04 01      [10]  148 	ld	hl,#0x0104
   3411 CD B3 7A      [17]  149 	call	_cpct_isKeyPressed
   3414 7D            [ 4]  150 	ld	a,l
   3415 B7            [ 4]  151 	or	a, a
   3416 28 0B         [12]  152 	jr	Z,00176$
                            153 ;src/State_LoadGame.c:46: ui_stringinput_add_char('0');
   3418 3E 30         [ 7]  154 	ld	a,#0x30
   341A F5            [11]  155 	push	af
   341B 33            [ 6]  156 	inc	sp
   341C CD 9B 3D      [17]  157 	call	_ui_stringinput_add_char
   341F 33            [ 6]  158 	inc	sp
                            159 ;src/State_LoadGame.c:47: statemanager_input_accepted();
   3420 C3 FB 39      [10]  160 	jp  _statemanager_input_accepted
   3423                     161 00176$:
                            162 ;src/State_LoadGame.c:49: else if(cpct_isKeyPressed(Key_1)){
   3423 21 08 01      [10]  163 	ld	hl,#0x0108
   3426 CD B3 7A      [17]  164 	call	_cpct_isKeyPressed
   3429 7D            [ 4]  165 	ld	a,l
   342A B7            [ 4]  166 	or	a, a
   342B 28 0B         [12]  167 	jr	Z,00173$
                            168 ;src/State_LoadGame.c:50: ui_stringinput_add_char('1');
   342D 3E 31         [ 7]  169 	ld	a,#0x31
   342F F5            [11]  170 	push	af
   3430 33            [ 6]  171 	inc	sp
   3431 CD 9B 3D      [17]  172 	call	_ui_stringinput_add_char
   3434 33            [ 6]  173 	inc	sp
                            174 ;src/State_LoadGame.c:51: statemanager_input_accepted();
   3435 C3 FB 39      [10]  175 	jp  _statemanager_input_accepted
   3438                     176 00173$:
                            177 ;src/State_LoadGame.c:53: else if(cpct_isKeyPressed(Key_2)){
   3438 21 08 02      [10]  178 	ld	hl,#0x0208
   343B CD B3 7A      [17]  179 	call	_cpct_isKeyPressed
   343E 7D            [ 4]  180 	ld	a,l
   343F B7            [ 4]  181 	or	a, a
   3440 28 0B         [12]  182 	jr	Z,00170$
                            183 ;src/State_LoadGame.c:54: ui_stringinput_add_char('2');
   3442 3E 32         [ 7]  184 	ld	a,#0x32
   3444 F5            [11]  185 	push	af
   3445 33            [ 6]  186 	inc	sp
   3446 CD 9B 3D      [17]  187 	call	_ui_stringinput_add_char
   3449 33            [ 6]  188 	inc	sp
                            189 ;src/State_LoadGame.c:55: statemanager_input_accepted();
   344A C3 FB 39      [10]  190 	jp  _statemanager_input_accepted
   344D                     191 00170$:
                            192 ;src/State_LoadGame.c:57: else if(cpct_isKeyPressed(Key_3)){
   344D 21 07 02      [10]  193 	ld	hl,#0x0207
   3450 CD B3 7A      [17]  194 	call	_cpct_isKeyPressed
   3453 7D            [ 4]  195 	ld	a,l
   3454 B7            [ 4]  196 	or	a, a
   3455 28 0B         [12]  197 	jr	Z,00167$
                            198 ;src/State_LoadGame.c:58: ui_stringinput_add_char('3');
   3457 3E 33         [ 7]  199 	ld	a,#0x33
   3459 F5            [11]  200 	push	af
   345A 33            [ 6]  201 	inc	sp
   345B CD 9B 3D      [17]  202 	call	_ui_stringinput_add_char
   345E 33            [ 6]  203 	inc	sp
                            204 ;src/State_LoadGame.c:59: statemanager_input_accepted();
   345F C3 FB 39      [10]  205 	jp  _statemanager_input_accepted
   3462                     206 00167$:
                            207 ;src/State_LoadGame.c:61: else if(cpct_isKeyPressed(Key_4)){
   3462 21 07 01      [10]  208 	ld	hl,#0x0107
   3465 CD B3 7A      [17]  209 	call	_cpct_isKeyPressed
   3468 7D            [ 4]  210 	ld	a,l
   3469 B7            [ 4]  211 	or	a, a
   346A 28 0B         [12]  212 	jr	Z,00164$
                            213 ;src/State_LoadGame.c:62: ui_stringinput_add_char('4');
   346C 3E 34         [ 7]  214 	ld	a,#0x34
   346E F5            [11]  215 	push	af
   346F 33            [ 6]  216 	inc	sp
   3470 CD 9B 3D      [17]  217 	call	_ui_stringinput_add_char
   3473 33            [ 6]  218 	inc	sp
                            219 ;src/State_LoadGame.c:63: statemanager_input_accepted();
   3474 C3 FB 39      [10]  220 	jp  _statemanager_input_accepted
   3477                     221 00164$:
                            222 ;src/State_LoadGame.c:65: else if(cpct_isKeyPressed(Key_5)){
   3477 21 06 02      [10]  223 	ld	hl,#0x0206
   347A CD B3 7A      [17]  224 	call	_cpct_isKeyPressed
   347D 7D            [ 4]  225 	ld	a,l
   347E B7            [ 4]  226 	or	a, a
   347F 28 0B         [12]  227 	jr	Z,00161$
                            228 ;src/State_LoadGame.c:66: ui_stringinput_add_char('5');
   3481 3E 35         [ 7]  229 	ld	a,#0x35
   3483 F5            [11]  230 	push	af
   3484 33            [ 6]  231 	inc	sp
   3485 CD 9B 3D      [17]  232 	call	_ui_stringinput_add_char
   3488 33            [ 6]  233 	inc	sp
                            234 ;src/State_LoadGame.c:67: statemanager_input_accepted();
   3489 C3 FB 39      [10]  235 	jp  _statemanager_input_accepted
   348C                     236 00161$:
                            237 ;src/State_LoadGame.c:69: else if(cpct_isKeyPressed(Key_6)){
   348C 21 06 01      [10]  238 	ld	hl,#0x0106
   348F CD B3 7A      [17]  239 	call	_cpct_isKeyPressed
   3492 7D            [ 4]  240 	ld	a,l
   3493 B7            [ 4]  241 	or	a, a
   3494 28 0B         [12]  242 	jr	Z,00158$
                            243 ;src/State_LoadGame.c:70: ui_stringinput_add_char('6');
   3496 3E 36         [ 7]  244 	ld	a,#0x36
   3498 F5            [11]  245 	push	af
   3499 33            [ 6]  246 	inc	sp
   349A CD 9B 3D      [17]  247 	call	_ui_stringinput_add_char
   349D 33            [ 6]  248 	inc	sp
                            249 ;src/State_LoadGame.c:71: statemanager_input_accepted();
   349E C3 FB 39      [10]  250 	jp  _statemanager_input_accepted
   34A1                     251 00158$:
                            252 ;src/State_LoadGame.c:73: else if(cpct_isKeyPressed(Key_7)){
   34A1 21 05 02      [10]  253 	ld	hl,#0x0205
   34A4 CD B3 7A      [17]  254 	call	_cpct_isKeyPressed
   34A7 7D            [ 4]  255 	ld	a,l
   34A8 B7            [ 4]  256 	or	a, a
   34A9 28 0B         [12]  257 	jr	Z,00155$
                            258 ;src/State_LoadGame.c:74: ui_stringinput_add_char('7');
   34AB 3E 37         [ 7]  259 	ld	a,#0x37
   34AD F5            [11]  260 	push	af
   34AE 33            [ 6]  261 	inc	sp
   34AF CD 9B 3D      [17]  262 	call	_ui_stringinput_add_char
   34B2 33            [ 6]  263 	inc	sp
                            264 ;src/State_LoadGame.c:75: statemanager_input_accepted();
   34B3 C3 FB 39      [10]  265 	jp  _statemanager_input_accepted
   34B6                     266 00155$:
                            267 ;src/State_LoadGame.c:77: else if(cpct_isKeyPressed(Key_8)){
   34B6 21 05 01      [10]  268 	ld	hl,#0x0105
   34B9 CD B3 7A      [17]  269 	call	_cpct_isKeyPressed
   34BC 7D            [ 4]  270 	ld	a,l
   34BD B7            [ 4]  271 	or	a, a
   34BE 28 0B         [12]  272 	jr	Z,00152$
                            273 ;src/State_LoadGame.c:78: ui_stringinput_add_char('8');
   34C0 3E 38         [ 7]  274 	ld	a,#0x38
   34C2 F5            [11]  275 	push	af
   34C3 33            [ 6]  276 	inc	sp
   34C4 CD 9B 3D      [17]  277 	call	_ui_stringinput_add_char
   34C7 33            [ 6]  278 	inc	sp
                            279 ;src/State_LoadGame.c:79: statemanager_input_accepted();
   34C8 C3 FB 39      [10]  280 	jp  _statemanager_input_accepted
   34CB                     281 00152$:
                            282 ;src/State_LoadGame.c:81: else if(cpct_isKeyPressed(Key_9)){
   34CB 21 04 02      [10]  283 	ld	hl,#0x0204
   34CE CD B3 7A      [17]  284 	call	_cpct_isKeyPressed
   34D1 7D            [ 4]  285 	ld	a,l
   34D2 B7            [ 4]  286 	or	a, a
   34D3 28 0B         [12]  287 	jr	Z,00149$
                            288 ;src/State_LoadGame.c:82: ui_stringinput_add_char('9');
   34D5 3E 39         [ 7]  289 	ld	a,#0x39
   34D7 F5            [11]  290 	push	af
   34D8 33            [ 6]  291 	inc	sp
   34D9 CD 9B 3D      [17]  292 	call	_ui_stringinput_add_char
   34DC 33            [ 6]  293 	inc	sp
                            294 ;src/State_LoadGame.c:83: statemanager_input_accepted();
   34DD C3 FB 39      [10]  295 	jp  _statemanager_input_accepted
   34E0                     296 00149$:
                            297 ;src/State_LoadGame.c:85: else if(cpct_isKeyPressed(Key_A)){
   34E0 21 08 20      [10]  298 	ld	hl,#0x2008
   34E3 CD B3 7A      [17]  299 	call	_cpct_isKeyPressed
   34E6 7D            [ 4]  300 	ld	a,l
   34E7 B7            [ 4]  301 	or	a, a
   34E8 28 0B         [12]  302 	jr	Z,00146$
                            303 ;src/State_LoadGame.c:86: ui_stringinput_add_char('A');
   34EA 3E 41         [ 7]  304 	ld	a,#0x41
   34EC F5            [11]  305 	push	af
   34ED 33            [ 6]  306 	inc	sp
   34EE CD 9B 3D      [17]  307 	call	_ui_stringinput_add_char
   34F1 33            [ 6]  308 	inc	sp
                            309 ;src/State_LoadGame.c:87: statemanager_input_accepted();
   34F2 C3 FB 39      [10]  310 	jp  _statemanager_input_accepted
   34F5                     311 00146$:
                            312 ;src/State_LoadGame.c:89: else if(cpct_isKeyPressed(Key_B)){
   34F5 21 06 40      [10]  313 	ld	hl,#0x4006
   34F8 CD B3 7A      [17]  314 	call	_cpct_isKeyPressed
   34FB 7D            [ 4]  315 	ld	a,l
   34FC B7            [ 4]  316 	or	a, a
   34FD 28 0B         [12]  317 	jr	Z,00143$
                            318 ;src/State_LoadGame.c:90: ui_stringinput_add_char('B');
   34FF 3E 42         [ 7]  319 	ld	a,#0x42
   3501 F5            [11]  320 	push	af
   3502 33            [ 6]  321 	inc	sp
   3503 CD 9B 3D      [17]  322 	call	_ui_stringinput_add_char
   3506 33            [ 6]  323 	inc	sp
                            324 ;src/State_LoadGame.c:91: statemanager_input_accepted();
   3507 C3 FB 39      [10]  325 	jp  _statemanager_input_accepted
   350A                     326 00143$:
                            327 ;src/State_LoadGame.c:93: else if(cpct_isKeyPressed(Key_C)){
   350A 21 07 40      [10]  328 	ld	hl,#0x4007
   350D CD B3 7A      [17]  329 	call	_cpct_isKeyPressed
   3510 7D            [ 4]  330 	ld	a,l
   3511 B7            [ 4]  331 	or	a, a
   3512 28 0B         [12]  332 	jr	Z,00140$
                            333 ;src/State_LoadGame.c:94: ui_stringinput_add_char('C');
   3514 3E 43         [ 7]  334 	ld	a,#0x43
   3516 F5            [11]  335 	push	af
   3517 33            [ 6]  336 	inc	sp
   3518 CD 9B 3D      [17]  337 	call	_ui_stringinput_add_char
   351B 33            [ 6]  338 	inc	sp
                            339 ;src/State_LoadGame.c:95: statemanager_input_accepted();
   351C C3 FB 39      [10]  340 	jp  _statemanager_input_accepted
   351F                     341 00140$:
                            342 ;src/State_LoadGame.c:97: else if(cpct_isKeyPressed(Key_D)){
   351F 21 07 20      [10]  343 	ld	hl,#0x2007
   3522 CD B3 7A      [17]  344 	call	_cpct_isKeyPressed
   3525 7D            [ 4]  345 	ld	a,l
   3526 B7            [ 4]  346 	or	a, a
   3527 28 0B         [12]  347 	jr	Z,00137$
                            348 ;src/State_LoadGame.c:98: ui_stringinput_add_char('D');
   3529 3E 44         [ 7]  349 	ld	a,#0x44
   352B F5            [11]  350 	push	af
   352C 33            [ 6]  351 	inc	sp
   352D CD 9B 3D      [17]  352 	call	_ui_stringinput_add_char
   3530 33            [ 6]  353 	inc	sp
                            354 ;src/State_LoadGame.c:99: statemanager_input_accepted();
   3531 C3 FB 39      [10]  355 	jp  _statemanager_input_accepted
   3534                     356 00137$:
                            357 ;src/State_LoadGame.c:101: else if(cpct_isKeyPressed(Key_E)){
   3534 21 07 04      [10]  358 	ld	hl,#0x0407
   3537 CD B3 7A      [17]  359 	call	_cpct_isKeyPressed
   353A 7D            [ 4]  360 	ld	a,l
   353B B7            [ 4]  361 	or	a, a
   353C 28 0B         [12]  362 	jr	Z,00134$
                            363 ;src/State_LoadGame.c:102: ui_stringinput_add_char('E');
   353E 3E 45         [ 7]  364 	ld	a,#0x45
   3540 F5            [11]  365 	push	af
   3541 33            [ 6]  366 	inc	sp
   3542 CD 9B 3D      [17]  367 	call	_ui_stringinput_add_char
   3545 33            [ 6]  368 	inc	sp
                            369 ;src/State_LoadGame.c:103: statemanager_input_accepted();
   3546 C3 FB 39      [10]  370 	jp  _statemanager_input_accepted
   3549                     371 00134$:
                            372 ;src/State_LoadGame.c:105: else if(cpct_isKeyPressed(Key_F)){
   3549 21 06 20      [10]  373 	ld	hl,#0x2006
   354C CD B3 7A      [17]  374 	call	_cpct_isKeyPressed
   354F 7D            [ 4]  375 	ld	a,l
   3550 B7            [ 4]  376 	or	a, a
   3551 28 0B         [12]  377 	jr	Z,00131$
                            378 ;src/State_LoadGame.c:106: ui_stringinput_add_char('F');
   3553 3E 46         [ 7]  379 	ld	a,#0x46
   3555 F5            [11]  380 	push	af
   3556 33            [ 6]  381 	inc	sp
   3557 CD 9B 3D      [17]  382 	call	_ui_stringinput_add_char
   355A 33            [ 6]  383 	inc	sp
                            384 ;src/State_LoadGame.c:107: statemanager_input_accepted();
   355B C3 FB 39      [10]  385 	jp  _statemanager_input_accepted
   355E                     386 00131$:
                            387 ;src/State_LoadGame.c:109: else if(cpct_isKeyPressed(Key_M)){
   355E 21 04 40      [10]  388 	ld	hl,#0x4004
   3561 CD B3 7A      [17]  389 	call	_cpct_isKeyPressed
   3564 7D            [ 4]  390 	ld	a,l
   3565 B7            [ 4]  391 	or	a, a
   3566 28 0B         [12]  392 	jr	Z,00128$
                            393 ;src/State_LoadGame.c:110: ui_stringinput_add_char('M');
   3568 3E 4D         [ 7]  394 	ld	a,#0x4D
   356A F5            [11]  395 	push	af
   356B 33            [ 6]  396 	inc	sp
   356C CD 9B 3D      [17]  397 	call	_ui_stringinput_add_char
   356F 33            [ 6]  398 	inc	sp
                            399 ;src/State_LoadGame.c:111: statemanager_input_accepted();
   3570 C3 FB 39      [10]  400 	jp  _statemanager_input_accepted
   3573                     401 00128$:
                            402 ;src/State_LoadGame.c:113: else if(cpct_isKeyPressed(Key_I)){
   3573 21 04 08      [10]  403 	ld	hl,#0x0804
   3576 CD B3 7A      [17]  404 	call	_cpct_isKeyPressed
   3579 7D            [ 4]  405 	ld	a,l
   357A B7            [ 4]  406 	or	a, a
   357B 28 0B         [12]  407 	jr	Z,00125$
                            408 ;src/State_LoadGame.c:114: ui_stringinput_add_char('I');
   357D 3E 49         [ 7]  409 	ld	a,#0x49
   357F F5            [11]  410 	push	af
   3580 33            [ 6]  411 	inc	sp
   3581 CD 9B 3D      [17]  412 	call	_ui_stringinput_add_char
   3584 33            [ 6]  413 	inc	sp
                            414 ;src/State_LoadGame.c:115: statemanager_input_accepted();
   3585 C3 FB 39      [10]  415 	jp  _statemanager_input_accepted
   3588                     416 00125$:
                            417 ;src/State_LoadGame.c:117: else if(cpct_isKeyPressed(Key_L)){
   3588 21 04 10      [10]  418 	ld	hl,#0x1004
   358B CD B3 7A      [17]  419 	call	_cpct_isKeyPressed
   358E 7D            [ 4]  420 	ld	a,l
   358F B7            [ 4]  421 	or	a, a
   3590 28 0B         [12]  422 	jr	Z,00122$
                            423 ;src/State_LoadGame.c:118: ui_stringinput_add_char('L');
   3592 3E 4C         [ 7]  424 	ld	a,#0x4C
   3594 F5            [11]  425 	push	af
   3595 33            [ 6]  426 	inc	sp
   3596 CD 9B 3D      [17]  427 	call	_ui_stringinput_add_char
   3599 33            [ 6]  428 	inc	sp
                            429 ;src/State_LoadGame.c:119: statemanager_input_accepted();
   359A C3 FB 39      [10]  430 	jp  _statemanager_input_accepted
   359D                     431 00122$:
                            432 ;src/State_LoadGame.c:121: else if(cpct_isKeyPressed(Key_O)){
   359D 21 04 04      [10]  433 	ld	hl,#0x0404
   35A0 CD B3 7A      [17]  434 	call	_cpct_isKeyPressed
   35A3 7D            [ 4]  435 	ld	a,l
   35A4 B7            [ 4]  436 	or	a, a
   35A5 28 0B         [12]  437 	jr	Z,00119$
                            438 ;src/State_LoadGame.c:122: ui_stringinput_add_char('O');
   35A7 3E 4F         [ 7]  439 	ld	a,#0x4F
   35A9 F5            [11]  440 	push	af
   35AA 33            [ 6]  441 	inc	sp
   35AB CD 9B 3D      [17]  442 	call	_ui_stringinput_add_char
   35AE 33            [ 6]  443 	inc	sp
                            444 ;src/State_LoadGame.c:123: statemanager_input_accepted();
   35AF C3 FB 39      [10]  445 	jp  _statemanager_input_accepted
   35B2                     446 00119$:
                            447 ;src/State_LoadGame.c:125: else if(cpct_isKeyPressed(Key_T)){
   35B2 21 06 08      [10]  448 	ld	hl,#0x0806
   35B5 CD B3 7A      [17]  449 	call	_cpct_isKeyPressed
   35B8 7D            [ 4]  450 	ld	a,l
   35B9 B7            [ 4]  451 	or	a, a
   35BA 28 0B         [12]  452 	jr	Z,00116$
                            453 ;src/State_LoadGame.c:126: ui_stringinput_add_char('T');
   35BC 3E 54         [ 7]  454 	ld	a,#0x54
   35BE F5            [11]  455 	push	af
   35BF 33            [ 6]  456 	inc	sp
   35C0 CD 9B 3D      [17]  457 	call	_ui_stringinput_add_char
   35C3 33            [ 6]  458 	inc	sp
                            459 ;src/State_LoadGame.c:127: statemanager_input_accepted();
   35C4 C3 FB 39      [10]  460 	jp  _statemanager_input_accepted
   35C7                     461 00116$:
                            462 ;src/State_LoadGame.c:129: else if(cpct_isKeyPressed(Key_W)){
   35C7 21 07 08      [10]  463 	ld	hl,#0x0807
   35CA CD B3 7A      [17]  464 	call	_cpct_isKeyPressed
   35CD 7D            [ 4]  465 	ld	a,l
   35CE B7            [ 4]  466 	or	a, a
   35CF 28 0B         [12]  467 	jr	Z,00113$
                            468 ;src/State_LoadGame.c:130: ui_stringinput_add_char('W');
   35D1 3E 57         [ 7]  469 	ld	a,#0x57
   35D3 F5            [11]  470 	push	af
   35D4 33            [ 6]  471 	inc	sp
   35D5 CD 9B 3D      [17]  472 	call	_ui_stringinput_add_char
   35D8 33            [ 6]  473 	inc	sp
                            474 ;src/State_LoadGame.c:131: statemanager_input_accepted();
   35D9 C3 FB 39      [10]  475 	jp  _statemanager_input_accepted
   35DC                     476 00113$:
                            477 ;src/State_LoadGame.c:133: else if(cpct_isKeyPressed(Key_R)){
   35DC 21 06 04      [10]  478 	ld	hl,#0x0406
   35DF CD B3 7A      [17]  479 	call	_cpct_isKeyPressed
   35E2 7D            [ 4]  480 	ld	a,l
   35E3 B7            [ 4]  481 	or	a, a
   35E4 28 0B         [12]  482 	jr	Z,00110$
                            483 ;src/State_LoadGame.c:134: ui_stringinput_add_char('R');
   35E6 3E 52         [ 7]  484 	ld	a,#0x52
   35E8 F5            [11]  485 	push	af
   35E9 33            [ 6]  486 	inc	sp
   35EA CD 9B 3D      [17]  487 	call	_ui_stringinput_add_char
   35ED 33            [ 6]  488 	inc	sp
                            489 ;src/State_LoadGame.c:135: statemanager_input_accepted();
   35EE C3 FB 39      [10]  490 	jp  _statemanager_input_accepted
   35F1                     491 00110$:
                            492 ;src/State_LoadGame.c:137: else if(cpct_isKeyPressed(Key_S)){
   35F1 21 07 10      [10]  493 	ld	hl,#0x1007
   35F4 CD B3 7A      [17]  494 	call	_cpct_isKeyPressed
   35F7 7D            [ 4]  495 	ld	a,l
   35F8 B7            [ 4]  496 	or	a, a
   35F9 28 0B         [12]  497 	jr	Z,00107$
                            498 ;src/State_LoadGame.c:138: ui_stringinput_add_char('S');
   35FB 3E 53         [ 7]  499 	ld	a,#0x53
   35FD F5            [11]  500 	push	af
   35FE 33            [ 6]  501 	inc	sp
   35FF CD 9B 3D      [17]  502 	call	_ui_stringinput_add_char
   3602 33            [ 6]  503 	inc	sp
                            504 ;src/State_LoadGame.c:139: statemanager_input_accepted();
   3603 C3 FB 39      [10]  505 	jp  _statemanager_input_accepted
   3606                     506 00107$:
                            507 ;src/State_LoadGame.c:141: else if(cpct_isKeyPressed(Key_Space)){
   3606 21 05 80      [10]  508 	ld	hl,#0x8005
   3609 CD B3 7A      [17]  509 	call	_cpct_isKeyPressed
   360C 7D            [ 4]  510 	ld	a,l
   360D B7            [ 4]  511 	or	a, a
   360E 28 0B         [12]  512 	jr	Z,00104$
                            513 ;src/State_LoadGame.c:142: ui_stringinput_add_char(' ');
   3610 3E 20         [ 7]  514 	ld	a,#0x20
   3612 F5            [11]  515 	push	af
   3613 33            [ 6]  516 	inc	sp
   3614 CD 9B 3D      [17]  517 	call	_ui_stringinput_add_char
   3617 33            [ 6]  518 	inc	sp
                            519 ;src/State_LoadGame.c:143: statemanager_input_accepted();
   3618 C3 FB 39      [10]  520 	jp  _statemanager_input_accepted
   361B                     521 00104$:
                            522 ;src/State_LoadGame.c:145: else if(cpct_isKeyPressed(Key_Del)){
   361B 21 09 80      [10]  523 	ld	hl,#0x8009
   361E CD B3 7A      [17]  524 	call	_cpct_isKeyPressed
   3621 7D            [ 4]  525 	ld	a,l
   3622 B7            [ 4]  526 	or	a, a
   3623 C8            [11]  527 	ret	Z
                            528 ;src/State_LoadGame.c:146: ui_stringinput_remove_char();
   3624 CD BD 3D      [17]  529 	call	_ui_stringinput_remove_char
                            530 ;src/State_LoadGame.c:147: statemanager_input_accepted();
   3627 C3 FB 39      [10]  531 	jp  _statemanager_input_accepted
                            532 ;src/State_LoadGame.c:151: void state_loadgame_update(){
                            533 ;	---------------------------------
                            534 ; Function state_loadgame_update
                            535 ; ---------------------------------
   362A                     536 _state_loadgame_update::
                            537 ;src/State_LoadGame.c:152: if(ui_loadgame_is_selected()){
   362A CD A8 47      [17]  538 	call	_ui_loadgame_is_selected
   362D 7D            [ 4]  539 	ld	a,l
   362E B7            [ 4]  540 	or	a, a
   362F CA DB 47      [10]  541 	jp	Z,_ui_loadgame_unselect_entry
                            542 ;src/State_LoadGame.c:153: ui_loadgame_render_all();
   3632 CD 4B 48      [17]  543 	call	_ui_loadgame_render_all
                            544 ;src/State_LoadGame.c:154: switch(ui_loadgame_get_entry()){
   3635 CD A0 47      [17]  545 	call	_ui_loadgame_get_entry
   3638 7D            [ 4]  546 	ld	a,l
   3639 B7            [ 4]  547 	or	a, a
   363A 28 06         [12]  548 	jr	Z,00101$
   363C 2D            [ 4]  549 	dec	l
   363D 28 0E         [12]  550 	jr	Z,00102$
   363F C3 DB 47      [10]  551 	jp	_ui_loadgame_unselect_entry
                            552 ;src/State_LoadGame.c:155: case 0:{
   3642                     553 00101$:
                            554 ;src/State_LoadGame.c:156: savegame_Load(ui_stringinput_get_string());
   3642 CD B9 3D      [17]  555 	call	_ui_stringinput_get_string
   3645 E5            [11]  556 	push	hl
   3646 CD AD 2E      [17]  557 	call	_savegame_Load
   3649 F1            [10]  558 	pop	af
                            559 ;src/State_LoadGame.c:157: break;
   364A C3 DB 47      [10]  560 	jp	_ui_loadgame_unselect_entry
                            561 ;src/State_LoadGame.c:159: case 1:{//Try
   364D                     562 00102$:
                            563 ;src/State_LoadGame.c:160: statemanager_close_state();
   364D CD A4 3A      [17]  564 	call	_statemanager_close_state
                            565 ;src/State_LoadGame.c:163: }
                            566 ;src/State_LoadGame.c:165: ui_loadgame_unselect_entry();
   3650 C3 DB 47      [10]  567 	jp  _ui_loadgame_unselect_entry
                            568 ;src/State_LoadGame.c:168: void state_loadgame_render(){
                            569 ;	---------------------------------
                            570 ; Function state_loadgame_render
                            571 ; ---------------------------------
   3653                     572 _state_loadgame_render::
                            573 ;src/State_LoadGame.c:169: ui_loadgame_render_all();
   3653 C3 4B 48      [10]  574 	jp  _ui_loadgame_render_all
                            575 ;src/State_LoadGame.c:172: void state_loadgame_exit(){
                            576 ;	---------------------------------
                            577 ; Function state_loadgame_exit
                            578 ; ---------------------------------
   3656                     579 _state_loadgame_exit::
                            580 ;src/State_LoadGame.c:173: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[1], 44, 42);
   3656 21 29 1C      [10]  581 	ld	hl, #(_g_colors + 0x0001) + 0
   3659 46            [ 7]  582 	ld	b,(hl)
   365A 21 2C 2A      [10]  583 	ld	hl,#0x2A2C
   365D E5            [11]  584 	push	hl
   365E C5            [11]  585 	push	bc
   365F 33            [ 6]  586 	inc	sp
   3660 21 E2 FA      [10]  587 	ld	hl,#0xFAE2
   3663 E5            [11]  588 	push	hl
   3664 CD 2F 85      [17]  589 	call	_cpct_drawSolidBox
   3667 F1            [10]  590 	pop	af
   3668 F1            [10]  591 	pop	af
   3669 33            [ 6]  592 	inc	sp
   366A C9            [10]  593 	ret
                            594 	.area _CODE
                            595 	.area _INITIALIZER
                            596 	.area _CABS (ABS)
