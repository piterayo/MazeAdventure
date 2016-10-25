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
   324F                      69 _state_loadgame_enter::
                             70 ;src/State_LoadGame.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[4], 44, 42);
   324F 21 6A 1A      [10]   71 	ld	hl, #_g_colors + 4
   3252 46            [ 7]   72 	ld	b,(hl)
   3253 21 2C 2A      [10]   73 	ld	hl,#0x2A2C
   3256 E5            [11]   74 	push	hl
   3257 C5            [11]   75 	push	bc
   3258 33            [ 6]   76 	inc	sp
   3259 21 E2 FA      [10]   77 	ld	hl,#0xFAE2
   325C E5            [11]   78 	push	hl
   325D CD 92 7B      [17]   79 	call	_cpct_drawSolidBox
   3260 F1            [10]   80 	pop	af
   3261 F1            [10]   81 	pop	af
   3262 33            [ 6]   82 	inc	sp
                             83 ;src/State_LoadGame.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 19, 83), g_colors[1], 42, 34);
   3263 21 67 1A      [10]   84 	ld	hl, #_g_colors + 1
   3266 46            [ 7]   85 	ld	b,(hl)
   3267 21 2A 22      [10]   86 	ld	hl,#0x222A
   326A E5            [11]   87 	push	hl
   326B C5            [11]   88 	push	bc
   326C 33            [ 6]   89 	inc	sp
   326D 21 33 DB      [10]   90 	ld	hl,#0xDB33
   3270 E5            [11]   91 	push	hl
   3271 CD 92 7B      [17]   92 	call	_cpct_drawSolidBox
   3274 F1            [10]   93 	pop	af
   3275 F1            [10]   94 	pop	af
   3276 33            [ 6]   95 	inc	sp
                             96 ;src/State_LoadGame.c:20: ui_loadgame_init();
   3277 CD 06 46      [17]   97 	call	_ui_loadgame_init
                             98 ;src/State_LoadGame.c:21: ui_stringinput_init();
   327A CD 13 3C      [17]   99 	call	_ui_stringinput_init
                            100 ;src/State_LoadGame.c:22: ui_loadgame_render_all();
   327D C3 D7 46      [10]  101 	jp  _ui_loadgame_render_all
                            102 ;src/State_LoadGame.c:25: void state_loadgame_return(){
                            103 ;	---------------------------------
                            104 ; Function state_loadgame_return
                            105 ; ---------------------------------
   3280                     106 _state_loadgame_return::
                            107 ;src/State_LoadGame.c:27: }
   3280 C9            [10]  108 	ret
                            109 ;src/State_LoadGame.c:30: void state_loadgame_input(){
                            110 ;	---------------------------------
                            111 ; Function state_loadgame_input
                            112 ; ---------------------------------
   3281                     113 _state_loadgame_input::
                            114 ;src/State_LoadGame.c:33: if(cpct_isKeyPressed(Key_CursorLeft)){
   3281 21 01 01      [10]  115 	ld	hl,#0x0101
   3284 CD 3F 79      [17]  116 	call	_cpct_isKeyPressed
   3287 7D            [ 4]  117 	ld	a,l
   3288 B7            [ 4]  118 	or	a, a
   3289 28 06         [12]  119 	jr	Z,00185$
                            120 ;src/State_LoadGame.c:34: ui_loadgame_previous_entry();
   328B CD 50 46      [17]  121 	call	_ui_loadgame_previous_entry
                            122 ;src/State_LoadGame.c:35: statemanager_input_accepted();
   328E C3 90 38      [10]  123 	jp  _statemanager_input_accepted
   3291                     124 00185$:
                            125 ;src/State_LoadGame.c:37: else if(cpct_isKeyPressed(Key_CursorRight)){
   3291 21 00 02      [10]  126 	ld	hl,#0x0200
   3294 CD 3F 79      [17]  127 	call	_cpct_isKeyPressed
   3297 7D            [ 4]  128 	ld	a,l
   3298 B7            [ 4]  129 	or	a, a
   3299 28 06         [12]  130 	jr	Z,00182$
                            131 ;src/State_LoadGame.c:38: ui_loadgame_next_entry();
   329B CD 3C 46      [17]  132 	call	_ui_loadgame_next_entry
                            133 ;src/State_LoadGame.c:39: statemanager_input_accepted();
   329E C3 90 38      [10]  134 	jp  _statemanager_input_accepted
   32A1                     135 00182$:
                            136 ;src/State_LoadGame.c:41: else if(cpct_isKeyPressed(Key_Return)){
   32A1 21 02 04      [10]  137 	ld	hl,#0x0402
   32A4 CD 3F 79      [17]  138 	call	_cpct_isKeyPressed
   32A7 7D            [ 4]  139 	ld	a,l
   32A8 B7            [ 4]  140 	or	a, a
   32A9 28 06         [12]  141 	jr	Z,00179$
                            142 ;src/State_LoadGame.c:42: ui_loadgame_select_entry();
   32AB CD 61 46      [17]  143 	call	_ui_loadgame_select_entry
                            144 ;src/State_LoadGame.c:43: statemanager_input_accepted();
   32AE C3 90 38      [10]  145 	jp  _statemanager_input_accepted
   32B1                     146 00179$:
                            147 ;src/State_LoadGame.c:45: else if(cpct_isKeyPressed(Key_0)){
   32B1 21 04 01      [10]  148 	ld	hl,#0x0104
   32B4 CD 3F 79      [17]  149 	call	_cpct_isKeyPressed
   32B7 7D            [ 4]  150 	ld	a,l
   32B8 B7            [ 4]  151 	or	a, a
   32B9 28 0B         [12]  152 	jr	Z,00176$
                            153 ;src/State_LoadGame.c:46: ui_stringinput_add_char('0');
   32BB 3E 30         [ 7]  154 	ld	a,#0x30
   32BD F5            [11]  155 	push	af
   32BE 33            [ 6]  156 	inc	sp
   32BF CD 27 3C      [17]  157 	call	_ui_stringinput_add_char
   32C2 33            [ 6]  158 	inc	sp
                            159 ;src/State_LoadGame.c:47: statemanager_input_accepted();
   32C3 C3 90 38      [10]  160 	jp  _statemanager_input_accepted
   32C6                     161 00176$:
                            162 ;src/State_LoadGame.c:49: else if(cpct_isKeyPressed(Key_1)){
   32C6 21 08 01      [10]  163 	ld	hl,#0x0108
   32C9 CD 3F 79      [17]  164 	call	_cpct_isKeyPressed
   32CC 7D            [ 4]  165 	ld	a,l
   32CD B7            [ 4]  166 	or	a, a
   32CE 28 0B         [12]  167 	jr	Z,00173$
                            168 ;src/State_LoadGame.c:50: ui_stringinput_add_char('1');
   32D0 3E 31         [ 7]  169 	ld	a,#0x31
   32D2 F5            [11]  170 	push	af
   32D3 33            [ 6]  171 	inc	sp
   32D4 CD 27 3C      [17]  172 	call	_ui_stringinput_add_char
   32D7 33            [ 6]  173 	inc	sp
                            174 ;src/State_LoadGame.c:51: statemanager_input_accepted();
   32D8 C3 90 38      [10]  175 	jp  _statemanager_input_accepted
   32DB                     176 00173$:
                            177 ;src/State_LoadGame.c:53: else if(cpct_isKeyPressed(Key_2)){
   32DB 21 08 02      [10]  178 	ld	hl,#0x0208
   32DE CD 3F 79      [17]  179 	call	_cpct_isKeyPressed
   32E1 7D            [ 4]  180 	ld	a,l
   32E2 B7            [ 4]  181 	or	a, a
   32E3 28 0B         [12]  182 	jr	Z,00170$
                            183 ;src/State_LoadGame.c:54: ui_stringinput_add_char('2');
   32E5 3E 32         [ 7]  184 	ld	a,#0x32
   32E7 F5            [11]  185 	push	af
   32E8 33            [ 6]  186 	inc	sp
   32E9 CD 27 3C      [17]  187 	call	_ui_stringinput_add_char
   32EC 33            [ 6]  188 	inc	sp
                            189 ;src/State_LoadGame.c:55: statemanager_input_accepted();
   32ED C3 90 38      [10]  190 	jp  _statemanager_input_accepted
   32F0                     191 00170$:
                            192 ;src/State_LoadGame.c:57: else if(cpct_isKeyPressed(Key_3)){
   32F0 21 07 02      [10]  193 	ld	hl,#0x0207
   32F3 CD 3F 79      [17]  194 	call	_cpct_isKeyPressed
   32F6 7D            [ 4]  195 	ld	a,l
   32F7 B7            [ 4]  196 	or	a, a
   32F8 28 0B         [12]  197 	jr	Z,00167$
                            198 ;src/State_LoadGame.c:58: ui_stringinput_add_char('3');
   32FA 3E 33         [ 7]  199 	ld	a,#0x33
   32FC F5            [11]  200 	push	af
   32FD 33            [ 6]  201 	inc	sp
   32FE CD 27 3C      [17]  202 	call	_ui_stringinput_add_char
   3301 33            [ 6]  203 	inc	sp
                            204 ;src/State_LoadGame.c:59: statemanager_input_accepted();
   3302 C3 90 38      [10]  205 	jp  _statemanager_input_accepted
   3305                     206 00167$:
                            207 ;src/State_LoadGame.c:61: else if(cpct_isKeyPressed(Key_4)){
   3305 21 07 01      [10]  208 	ld	hl,#0x0107
   3308 CD 3F 79      [17]  209 	call	_cpct_isKeyPressed
   330B 7D            [ 4]  210 	ld	a,l
   330C B7            [ 4]  211 	or	a, a
   330D 28 0B         [12]  212 	jr	Z,00164$
                            213 ;src/State_LoadGame.c:62: ui_stringinput_add_char('4');
   330F 3E 34         [ 7]  214 	ld	a,#0x34
   3311 F5            [11]  215 	push	af
   3312 33            [ 6]  216 	inc	sp
   3313 CD 27 3C      [17]  217 	call	_ui_stringinput_add_char
   3316 33            [ 6]  218 	inc	sp
                            219 ;src/State_LoadGame.c:63: statemanager_input_accepted();
   3317 C3 90 38      [10]  220 	jp  _statemanager_input_accepted
   331A                     221 00164$:
                            222 ;src/State_LoadGame.c:65: else if(cpct_isKeyPressed(Key_5)){
   331A 21 06 02      [10]  223 	ld	hl,#0x0206
   331D CD 3F 79      [17]  224 	call	_cpct_isKeyPressed
   3320 7D            [ 4]  225 	ld	a,l
   3321 B7            [ 4]  226 	or	a, a
   3322 28 0B         [12]  227 	jr	Z,00161$
                            228 ;src/State_LoadGame.c:66: ui_stringinput_add_char('5');
   3324 3E 35         [ 7]  229 	ld	a,#0x35
   3326 F5            [11]  230 	push	af
   3327 33            [ 6]  231 	inc	sp
   3328 CD 27 3C      [17]  232 	call	_ui_stringinput_add_char
   332B 33            [ 6]  233 	inc	sp
                            234 ;src/State_LoadGame.c:67: statemanager_input_accepted();
   332C C3 90 38      [10]  235 	jp  _statemanager_input_accepted
   332F                     236 00161$:
                            237 ;src/State_LoadGame.c:69: else if(cpct_isKeyPressed(Key_6)){
   332F 21 06 01      [10]  238 	ld	hl,#0x0106
   3332 CD 3F 79      [17]  239 	call	_cpct_isKeyPressed
   3335 7D            [ 4]  240 	ld	a,l
   3336 B7            [ 4]  241 	or	a, a
   3337 28 0B         [12]  242 	jr	Z,00158$
                            243 ;src/State_LoadGame.c:70: ui_stringinput_add_char('6');
   3339 3E 36         [ 7]  244 	ld	a,#0x36
   333B F5            [11]  245 	push	af
   333C 33            [ 6]  246 	inc	sp
   333D CD 27 3C      [17]  247 	call	_ui_stringinput_add_char
   3340 33            [ 6]  248 	inc	sp
                            249 ;src/State_LoadGame.c:71: statemanager_input_accepted();
   3341 C3 90 38      [10]  250 	jp  _statemanager_input_accepted
   3344                     251 00158$:
                            252 ;src/State_LoadGame.c:73: else if(cpct_isKeyPressed(Key_7)){
   3344 21 05 02      [10]  253 	ld	hl,#0x0205
   3347 CD 3F 79      [17]  254 	call	_cpct_isKeyPressed
   334A 7D            [ 4]  255 	ld	a,l
   334B B7            [ 4]  256 	or	a, a
   334C 28 0B         [12]  257 	jr	Z,00155$
                            258 ;src/State_LoadGame.c:74: ui_stringinput_add_char('7');
   334E 3E 37         [ 7]  259 	ld	a,#0x37
   3350 F5            [11]  260 	push	af
   3351 33            [ 6]  261 	inc	sp
   3352 CD 27 3C      [17]  262 	call	_ui_stringinput_add_char
   3355 33            [ 6]  263 	inc	sp
                            264 ;src/State_LoadGame.c:75: statemanager_input_accepted();
   3356 C3 90 38      [10]  265 	jp  _statemanager_input_accepted
   3359                     266 00155$:
                            267 ;src/State_LoadGame.c:77: else if(cpct_isKeyPressed(Key_8)){
   3359 21 05 01      [10]  268 	ld	hl,#0x0105
   335C CD 3F 79      [17]  269 	call	_cpct_isKeyPressed
   335F 7D            [ 4]  270 	ld	a,l
   3360 B7            [ 4]  271 	or	a, a
   3361 28 0B         [12]  272 	jr	Z,00152$
                            273 ;src/State_LoadGame.c:78: ui_stringinput_add_char('8');
   3363 3E 38         [ 7]  274 	ld	a,#0x38
   3365 F5            [11]  275 	push	af
   3366 33            [ 6]  276 	inc	sp
   3367 CD 27 3C      [17]  277 	call	_ui_stringinput_add_char
   336A 33            [ 6]  278 	inc	sp
                            279 ;src/State_LoadGame.c:79: statemanager_input_accepted();
   336B C3 90 38      [10]  280 	jp  _statemanager_input_accepted
   336E                     281 00152$:
                            282 ;src/State_LoadGame.c:81: else if(cpct_isKeyPressed(Key_9)){
   336E 21 04 02      [10]  283 	ld	hl,#0x0204
   3371 CD 3F 79      [17]  284 	call	_cpct_isKeyPressed
   3374 7D            [ 4]  285 	ld	a,l
   3375 B7            [ 4]  286 	or	a, a
   3376 28 0B         [12]  287 	jr	Z,00149$
                            288 ;src/State_LoadGame.c:82: ui_stringinput_add_char('9');
   3378 3E 39         [ 7]  289 	ld	a,#0x39
   337A F5            [11]  290 	push	af
   337B 33            [ 6]  291 	inc	sp
   337C CD 27 3C      [17]  292 	call	_ui_stringinput_add_char
   337F 33            [ 6]  293 	inc	sp
                            294 ;src/State_LoadGame.c:83: statemanager_input_accepted();
   3380 C3 90 38      [10]  295 	jp  _statemanager_input_accepted
   3383                     296 00149$:
                            297 ;src/State_LoadGame.c:85: else if(cpct_isKeyPressed(Key_A)){
   3383 21 08 20      [10]  298 	ld	hl,#0x2008
   3386 CD 3F 79      [17]  299 	call	_cpct_isKeyPressed
   3389 7D            [ 4]  300 	ld	a,l
   338A B7            [ 4]  301 	or	a, a
   338B 28 0B         [12]  302 	jr	Z,00146$
                            303 ;src/State_LoadGame.c:86: ui_stringinput_add_char('A');
   338D 3E 41         [ 7]  304 	ld	a,#0x41
   338F F5            [11]  305 	push	af
   3390 33            [ 6]  306 	inc	sp
   3391 CD 27 3C      [17]  307 	call	_ui_stringinput_add_char
   3394 33            [ 6]  308 	inc	sp
                            309 ;src/State_LoadGame.c:87: statemanager_input_accepted();
   3395 C3 90 38      [10]  310 	jp  _statemanager_input_accepted
   3398                     311 00146$:
                            312 ;src/State_LoadGame.c:89: else if(cpct_isKeyPressed(Key_B)){
   3398 21 06 40      [10]  313 	ld	hl,#0x4006
   339B CD 3F 79      [17]  314 	call	_cpct_isKeyPressed
   339E 7D            [ 4]  315 	ld	a,l
   339F B7            [ 4]  316 	or	a, a
   33A0 28 0B         [12]  317 	jr	Z,00143$
                            318 ;src/State_LoadGame.c:90: ui_stringinput_add_char('B');
   33A2 3E 42         [ 7]  319 	ld	a,#0x42
   33A4 F5            [11]  320 	push	af
   33A5 33            [ 6]  321 	inc	sp
   33A6 CD 27 3C      [17]  322 	call	_ui_stringinput_add_char
   33A9 33            [ 6]  323 	inc	sp
                            324 ;src/State_LoadGame.c:91: statemanager_input_accepted();
   33AA C3 90 38      [10]  325 	jp  _statemanager_input_accepted
   33AD                     326 00143$:
                            327 ;src/State_LoadGame.c:93: else if(cpct_isKeyPressed(Key_C)){
   33AD 21 07 40      [10]  328 	ld	hl,#0x4007
   33B0 CD 3F 79      [17]  329 	call	_cpct_isKeyPressed
   33B3 7D            [ 4]  330 	ld	a,l
   33B4 B7            [ 4]  331 	or	a, a
   33B5 28 0B         [12]  332 	jr	Z,00140$
                            333 ;src/State_LoadGame.c:94: ui_stringinput_add_char('C');
   33B7 3E 43         [ 7]  334 	ld	a,#0x43
   33B9 F5            [11]  335 	push	af
   33BA 33            [ 6]  336 	inc	sp
   33BB CD 27 3C      [17]  337 	call	_ui_stringinput_add_char
   33BE 33            [ 6]  338 	inc	sp
                            339 ;src/State_LoadGame.c:95: statemanager_input_accepted();
   33BF C3 90 38      [10]  340 	jp  _statemanager_input_accepted
   33C2                     341 00140$:
                            342 ;src/State_LoadGame.c:97: else if(cpct_isKeyPressed(Key_D)){
   33C2 21 07 20      [10]  343 	ld	hl,#0x2007
   33C5 CD 3F 79      [17]  344 	call	_cpct_isKeyPressed
   33C8 7D            [ 4]  345 	ld	a,l
   33C9 B7            [ 4]  346 	or	a, a
   33CA 28 0B         [12]  347 	jr	Z,00137$
                            348 ;src/State_LoadGame.c:98: ui_stringinput_add_char('D');
   33CC 3E 44         [ 7]  349 	ld	a,#0x44
   33CE F5            [11]  350 	push	af
   33CF 33            [ 6]  351 	inc	sp
   33D0 CD 27 3C      [17]  352 	call	_ui_stringinput_add_char
   33D3 33            [ 6]  353 	inc	sp
                            354 ;src/State_LoadGame.c:99: statemanager_input_accepted();
   33D4 C3 90 38      [10]  355 	jp  _statemanager_input_accepted
   33D7                     356 00137$:
                            357 ;src/State_LoadGame.c:101: else if(cpct_isKeyPressed(Key_E)){
   33D7 21 07 04      [10]  358 	ld	hl,#0x0407
   33DA CD 3F 79      [17]  359 	call	_cpct_isKeyPressed
   33DD 7D            [ 4]  360 	ld	a,l
   33DE B7            [ 4]  361 	or	a, a
   33DF 28 0B         [12]  362 	jr	Z,00134$
                            363 ;src/State_LoadGame.c:102: ui_stringinput_add_char('E');
   33E1 3E 45         [ 7]  364 	ld	a,#0x45
   33E3 F5            [11]  365 	push	af
   33E4 33            [ 6]  366 	inc	sp
   33E5 CD 27 3C      [17]  367 	call	_ui_stringinput_add_char
   33E8 33            [ 6]  368 	inc	sp
                            369 ;src/State_LoadGame.c:103: statemanager_input_accepted();
   33E9 C3 90 38      [10]  370 	jp  _statemanager_input_accepted
   33EC                     371 00134$:
                            372 ;src/State_LoadGame.c:105: else if(cpct_isKeyPressed(Key_F)){
   33EC 21 06 20      [10]  373 	ld	hl,#0x2006
   33EF CD 3F 79      [17]  374 	call	_cpct_isKeyPressed
   33F2 7D            [ 4]  375 	ld	a,l
   33F3 B7            [ 4]  376 	or	a, a
   33F4 28 0B         [12]  377 	jr	Z,00131$
                            378 ;src/State_LoadGame.c:106: ui_stringinput_add_char('F');
   33F6 3E 46         [ 7]  379 	ld	a,#0x46
   33F8 F5            [11]  380 	push	af
   33F9 33            [ 6]  381 	inc	sp
   33FA CD 27 3C      [17]  382 	call	_ui_stringinput_add_char
   33FD 33            [ 6]  383 	inc	sp
                            384 ;src/State_LoadGame.c:107: statemanager_input_accepted();
   33FE C3 90 38      [10]  385 	jp  _statemanager_input_accepted
   3401                     386 00131$:
                            387 ;src/State_LoadGame.c:109: else if(cpct_isKeyPressed(Key_M)){
   3401 21 04 40      [10]  388 	ld	hl,#0x4004
   3404 CD 3F 79      [17]  389 	call	_cpct_isKeyPressed
   3407 7D            [ 4]  390 	ld	a,l
   3408 B7            [ 4]  391 	or	a, a
   3409 28 0B         [12]  392 	jr	Z,00128$
                            393 ;src/State_LoadGame.c:110: ui_stringinput_add_char('M');
   340B 3E 4D         [ 7]  394 	ld	a,#0x4D
   340D F5            [11]  395 	push	af
   340E 33            [ 6]  396 	inc	sp
   340F CD 27 3C      [17]  397 	call	_ui_stringinput_add_char
   3412 33            [ 6]  398 	inc	sp
                            399 ;src/State_LoadGame.c:111: statemanager_input_accepted();
   3413 C3 90 38      [10]  400 	jp  _statemanager_input_accepted
   3416                     401 00128$:
                            402 ;src/State_LoadGame.c:113: else if(cpct_isKeyPressed(Key_I)){
   3416 21 04 08      [10]  403 	ld	hl,#0x0804
   3419 CD 3F 79      [17]  404 	call	_cpct_isKeyPressed
   341C 7D            [ 4]  405 	ld	a,l
   341D B7            [ 4]  406 	or	a, a
   341E 28 0B         [12]  407 	jr	Z,00125$
                            408 ;src/State_LoadGame.c:114: ui_stringinput_add_char('I');
   3420 3E 49         [ 7]  409 	ld	a,#0x49
   3422 F5            [11]  410 	push	af
   3423 33            [ 6]  411 	inc	sp
   3424 CD 27 3C      [17]  412 	call	_ui_stringinput_add_char
   3427 33            [ 6]  413 	inc	sp
                            414 ;src/State_LoadGame.c:115: statemanager_input_accepted();
   3428 C3 90 38      [10]  415 	jp  _statemanager_input_accepted
   342B                     416 00125$:
                            417 ;src/State_LoadGame.c:117: else if(cpct_isKeyPressed(Key_L)){
   342B 21 04 10      [10]  418 	ld	hl,#0x1004
   342E CD 3F 79      [17]  419 	call	_cpct_isKeyPressed
   3431 7D            [ 4]  420 	ld	a,l
   3432 B7            [ 4]  421 	or	a, a
   3433 28 0B         [12]  422 	jr	Z,00122$
                            423 ;src/State_LoadGame.c:118: ui_stringinput_add_char('L');
   3435 3E 4C         [ 7]  424 	ld	a,#0x4C
   3437 F5            [11]  425 	push	af
   3438 33            [ 6]  426 	inc	sp
   3439 CD 27 3C      [17]  427 	call	_ui_stringinput_add_char
   343C 33            [ 6]  428 	inc	sp
                            429 ;src/State_LoadGame.c:119: statemanager_input_accepted();
   343D C3 90 38      [10]  430 	jp  _statemanager_input_accepted
   3440                     431 00122$:
                            432 ;src/State_LoadGame.c:121: else if(cpct_isKeyPressed(Key_O)){
   3440 21 04 04      [10]  433 	ld	hl,#0x0404
   3443 CD 3F 79      [17]  434 	call	_cpct_isKeyPressed
   3446 7D            [ 4]  435 	ld	a,l
   3447 B7            [ 4]  436 	or	a, a
   3448 28 0B         [12]  437 	jr	Z,00119$
                            438 ;src/State_LoadGame.c:122: ui_stringinput_add_char('O');
   344A 3E 4F         [ 7]  439 	ld	a,#0x4F
   344C F5            [11]  440 	push	af
   344D 33            [ 6]  441 	inc	sp
   344E CD 27 3C      [17]  442 	call	_ui_stringinput_add_char
   3451 33            [ 6]  443 	inc	sp
                            444 ;src/State_LoadGame.c:123: statemanager_input_accepted();
   3452 C3 90 38      [10]  445 	jp  _statemanager_input_accepted
   3455                     446 00119$:
                            447 ;src/State_LoadGame.c:125: else if(cpct_isKeyPressed(Key_T)){
   3455 21 06 08      [10]  448 	ld	hl,#0x0806
   3458 CD 3F 79      [17]  449 	call	_cpct_isKeyPressed
   345B 7D            [ 4]  450 	ld	a,l
   345C B7            [ 4]  451 	or	a, a
   345D 28 0B         [12]  452 	jr	Z,00116$
                            453 ;src/State_LoadGame.c:126: ui_stringinput_add_char('T');
   345F 3E 54         [ 7]  454 	ld	a,#0x54
   3461 F5            [11]  455 	push	af
   3462 33            [ 6]  456 	inc	sp
   3463 CD 27 3C      [17]  457 	call	_ui_stringinput_add_char
   3466 33            [ 6]  458 	inc	sp
                            459 ;src/State_LoadGame.c:127: statemanager_input_accepted();
   3467 C3 90 38      [10]  460 	jp  _statemanager_input_accepted
   346A                     461 00116$:
                            462 ;src/State_LoadGame.c:129: else if(cpct_isKeyPressed(Key_W)){
   346A 21 07 08      [10]  463 	ld	hl,#0x0807
   346D CD 3F 79      [17]  464 	call	_cpct_isKeyPressed
   3470 7D            [ 4]  465 	ld	a,l
   3471 B7            [ 4]  466 	or	a, a
   3472 28 0B         [12]  467 	jr	Z,00113$
                            468 ;src/State_LoadGame.c:130: ui_stringinput_add_char('W');
   3474 3E 57         [ 7]  469 	ld	a,#0x57
   3476 F5            [11]  470 	push	af
   3477 33            [ 6]  471 	inc	sp
   3478 CD 27 3C      [17]  472 	call	_ui_stringinput_add_char
   347B 33            [ 6]  473 	inc	sp
                            474 ;src/State_LoadGame.c:131: statemanager_input_accepted();
   347C C3 90 38      [10]  475 	jp  _statemanager_input_accepted
   347F                     476 00113$:
                            477 ;src/State_LoadGame.c:133: else if(cpct_isKeyPressed(Key_R)){
   347F 21 06 04      [10]  478 	ld	hl,#0x0406
   3482 CD 3F 79      [17]  479 	call	_cpct_isKeyPressed
   3485 7D            [ 4]  480 	ld	a,l
   3486 B7            [ 4]  481 	or	a, a
   3487 28 0B         [12]  482 	jr	Z,00110$
                            483 ;src/State_LoadGame.c:134: ui_stringinput_add_char('R');
   3489 3E 52         [ 7]  484 	ld	a,#0x52
   348B F5            [11]  485 	push	af
   348C 33            [ 6]  486 	inc	sp
   348D CD 27 3C      [17]  487 	call	_ui_stringinput_add_char
   3490 33            [ 6]  488 	inc	sp
                            489 ;src/State_LoadGame.c:135: statemanager_input_accepted();
   3491 C3 90 38      [10]  490 	jp  _statemanager_input_accepted
   3494                     491 00110$:
                            492 ;src/State_LoadGame.c:137: else if(cpct_isKeyPressed(Key_S)){
   3494 21 07 10      [10]  493 	ld	hl,#0x1007
   3497 CD 3F 79      [17]  494 	call	_cpct_isKeyPressed
   349A 7D            [ 4]  495 	ld	a,l
   349B B7            [ 4]  496 	or	a, a
   349C 28 0B         [12]  497 	jr	Z,00107$
                            498 ;src/State_LoadGame.c:138: ui_stringinput_add_char('S');
   349E 3E 53         [ 7]  499 	ld	a,#0x53
   34A0 F5            [11]  500 	push	af
   34A1 33            [ 6]  501 	inc	sp
   34A2 CD 27 3C      [17]  502 	call	_ui_stringinput_add_char
   34A5 33            [ 6]  503 	inc	sp
                            504 ;src/State_LoadGame.c:139: statemanager_input_accepted();
   34A6 C3 90 38      [10]  505 	jp  _statemanager_input_accepted
   34A9                     506 00107$:
                            507 ;src/State_LoadGame.c:141: else if(cpct_isKeyPressed(Key_Space)){
   34A9 21 05 80      [10]  508 	ld	hl,#0x8005
   34AC CD 3F 79      [17]  509 	call	_cpct_isKeyPressed
   34AF 7D            [ 4]  510 	ld	a,l
   34B0 B7            [ 4]  511 	or	a, a
   34B1 28 0B         [12]  512 	jr	Z,00104$
                            513 ;src/State_LoadGame.c:142: ui_stringinput_add_char(' ');
   34B3 3E 20         [ 7]  514 	ld	a,#0x20
   34B5 F5            [11]  515 	push	af
   34B6 33            [ 6]  516 	inc	sp
   34B7 CD 27 3C      [17]  517 	call	_ui_stringinput_add_char
   34BA 33            [ 6]  518 	inc	sp
                            519 ;src/State_LoadGame.c:143: statemanager_input_accepted();
   34BB C3 90 38      [10]  520 	jp  _statemanager_input_accepted
   34BE                     521 00104$:
                            522 ;src/State_LoadGame.c:145: else if(cpct_isKeyPressed(Key_Del)){
   34BE 21 09 80      [10]  523 	ld	hl,#0x8009
   34C1 CD 3F 79      [17]  524 	call	_cpct_isKeyPressed
   34C4 7D            [ 4]  525 	ld	a,l
   34C5 B7            [ 4]  526 	or	a, a
   34C6 C8            [11]  527 	ret	Z
                            528 ;src/State_LoadGame.c:146: ui_stringinput_remove_char();
   34C7 CD 49 3C      [17]  529 	call	_ui_stringinput_remove_char
                            530 ;src/State_LoadGame.c:147: statemanager_input_accepted();
   34CA C3 90 38      [10]  531 	jp  _statemanager_input_accepted
                            532 ;src/State_LoadGame.c:151: void state_loadgame_update(){
                            533 ;	---------------------------------
                            534 ; Function state_loadgame_update
                            535 ; ---------------------------------
   34CD                     536 _state_loadgame_update::
                            537 ;src/State_LoadGame.c:152: if(ui_loadgame_is_selected()){
   34CD CD 34 46      [17]  538 	call	_ui_loadgame_is_selected
   34D0 7D            [ 4]  539 	ld	a,l
   34D1 B7            [ 4]  540 	or	a, a
   34D2 CA 67 46      [10]  541 	jp	Z,_ui_loadgame_unselect_entry
                            542 ;src/State_LoadGame.c:153: ui_loadgame_render_all();
   34D5 CD D7 46      [17]  543 	call	_ui_loadgame_render_all
                            544 ;src/State_LoadGame.c:154: switch(ui_loadgame_get_entry()){
   34D8 CD 2C 46      [17]  545 	call	_ui_loadgame_get_entry
   34DB 7D            [ 4]  546 	ld	a,l
   34DC B7            [ 4]  547 	or	a, a
   34DD 28 06         [12]  548 	jr	Z,00101$
   34DF 2D            [ 4]  549 	dec	l
   34E0 28 0E         [12]  550 	jr	Z,00102$
   34E2 C3 67 46      [10]  551 	jp	_ui_loadgame_unselect_entry
                            552 ;src/State_LoadGame.c:155: case 0:{
   34E5                     553 00101$:
                            554 ;src/State_LoadGame.c:156: savegame_Load(ui_stringinput_get_string());
   34E5 CD 45 3C      [17]  555 	call	_ui_stringinput_get_string
   34E8 E5            [11]  556 	push	hl
   34E9 CD EB 2C      [17]  557 	call	_savegame_Load
   34EC F1            [10]  558 	pop	af
                            559 ;src/State_LoadGame.c:157: break;
   34ED C3 67 46      [10]  560 	jp	_ui_loadgame_unselect_entry
                            561 ;src/State_LoadGame.c:159: case 1:{//Try
   34F0                     562 00102$:
                            563 ;src/State_LoadGame.c:160: statemanager_close_state();
   34F0 CD 39 39      [17]  564 	call	_statemanager_close_state
                            565 ;src/State_LoadGame.c:163: }
                            566 ;src/State_LoadGame.c:165: ui_loadgame_unselect_entry();
   34F3 C3 67 46      [10]  567 	jp  _ui_loadgame_unselect_entry
                            568 ;src/State_LoadGame.c:168: void state_loadgame_render(){
                            569 ;	---------------------------------
                            570 ; Function state_loadgame_render
                            571 ; ---------------------------------
   34F6                     572 _state_loadgame_render::
                            573 ;src/State_LoadGame.c:169: ui_loadgame_render_all();
   34F6 C3 D7 46      [10]  574 	jp  _ui_loadgame_render_all
                            575 ;src/State_LoadGame.c:172: void state_loadgame_exit(){
                            576 ;	---------------------------------
                            577 ; Function state_loadgame_exit
                            578 ; ---------------------------------
   34F9                     579 _state_loadgame_exit::
                            580 ;src/State_LoadGame.c:173: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[1], 44, 42);
   34F9 21 67 1A      [10]  581 	ld	hl, #(_g_colors + 0x0001) + 0
   34FC 46            [ 7]  582 	ld	b,(hl)
   34FD 21 2C 2A      [10]  583 	ld	hl,#0x2A2C
   3500 E5            [11]  584 	push	hl
   3501 C5            [11]  585 	push	bc
   3502 33            [ 6]  586 	inc	sp
   3503 21 E2 FA      [10]  587 	ld	hl,#0xFAE2
   3506 E5            [11]  588 	push	hl
   3507 CD 92 7B      [17]  589 	call	_cpct_drawSolidBox
   350A F1            [10]  590 	pop	af
   350B F1            [10]  591 	pop	af
   350C 33            [ 6]  592 	inc	sp
   350D C9            [10]  593 	ret
                            594 	.area _CODE
                            595 	.area _INITIALIZER
                            596 	.area _CABS (ABS)
