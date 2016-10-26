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
   3275                      69 _state_loadgame_enter::
                             70 ;src/State_LoadGame.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[4], 44, 42);
   3275 21 B3 1A      [10]   71 	ld	hl, #_g_colors + 4
   3278 46            [ 7]   72 	ld	b,(hl)
   3279 21 2C 2A      [10]   73 	ld	hl,#0x2A2C
   327C E5            [11]   74 	push	hl
   327D C5            [11]   75 	push	bc
   327E 33            [ 6]   76 	inc	sp
   327F 21 E2 FA      [10]   77 	ld	hl,#0xFAE2
   3282 E5            [11]   78 	push	hl
   3283 CD B8 7B      [17]   79 	call	_cpct_drawSolidBox
   3286 F1            [10]   80 	pop	af
   3287 F1            [10]   81 	pop	af
   3288 33            [ 6]   82 	inc	sp
                             83 ;src/State_LoadGame.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 19, 83), g_colors[1], 42, 34);
   3289 21 B0 1A      [10]   84 	ld	hl, #_g_colors + 1
   328C 46            [ 7]   85 	ld	b,(hl)
   328D 21 2A 22      [10]   86 	ld	hl,#0x222A
   3290 E5            [11]   87 	push	hl
   3291 C5            [11]   88 	push	bc
   3292 33            [ 6]   89 	inc	sp
   3293 21 33 DB      [10]   90 	ld	hl,#0xDB33
   3296 E5            [11]   91 	push	hl
   3297 CD B8 7B      [17]   92 	call	_cpct_drawSolidBox
   329A F1            [10]   93 	pop	af
   329B F1            [10]   94 	pop	af
   329C 33            [ 6]   95 	inc	sp
                             96 ;src/State_LoadGame.c:20: ui_loadgame_init();
   329D CD 2C 46      [17]   97 	call	_ui_loadgame_init
                             98 ;src/State_LoadGame.c:21: ui_stringinput_init();
   32A0 CD 39 3C      [17]   99 	call	_ui_stringinput_init
                            100 ;src/State_LoadGame.c:22: ui_loadgame_render_all();
   32A3 C3 FD 46      [10]  101 	jp  _ui_loadgame_render_all
                            102 ;src/State_LoadGame.c:25: void state_loadgame_return(){
                            103 ;	---------------------------------
                            104 ; Function state_loadgame_return
                            105 ; ---------------------------------
   32A6                     106 _state_loadgame_return::
                            107 ;src/State_LoadGame.c:27: }
   32A6 C9            [10]  108 	ret
                            109 ;src/State_LoadGame.c:30: void state_loadgame_input(){
                            110 ;	---------------------------------
                            111 ; Function state_loadgame_input
                            112 ; ---------------------------------
   32A7                     113 _state_loadgame_input::
                            114 ;src/State_LoadGame.c:33: if(cpct_isKeyPressed(Key_CursorLeft)){
   32A7 21 01 01      [10]  115 	ld	hl,#0x0101
   32AA CD 65 79      [17]  116 	call	_cpct_isKeyPressed
   32AD 7D            [ 4]  117 	ld	a,l
   32AE B7            [ 4]  118 	or	a, a
   32AF 28 06         [12]  119 	jr	Z,00185$
                            120 ;src/State_LoadGame.c:34: ui_loadgame_previous_entry();
   32B1 CD 76 46      [17]  121 	call	_ui_loadgame_previous_entry
                            122 ;src/State_LoadGame.c:35: statemanager_input_accepted();
   32B4 C3 B6 38      [10]  123 	jp  _statemanager_input_accepted
   32B7                     124 00185$:
                            125 ;src/State_LoadGame.c:37: else if(cpct_isKeyPressed(Key_CursorRight)){
   32B7 21 00 02      [10]  126 	ld	hl,#0x0200
   32BA CD 65 79      [17]  127 	call	_cpct_isKeyPressed
   32BD 7D            [ 4]  128 	ld	a,l
   32BE B7            [ 4]  129 	or	a, a
   32BF 28 06         [12]  130 	jr	Z,00182$
                            131 ;src/State_LoadGame.c:38: ui_loadgame_next_entry();
   32C1 CD 62 46      [17]  132 	call	_ui_loadgame_next_entry
                            133 ;src/State_LoadGame.c:39: statemanager_input_accepted();
   32C4 C3 B6 38      [10]  134 	jp  _statemanager_input_accepted
   32C7                     135 00182$:
                            136 ;src/State_LoadGame.c:41: else if(cpct_isKeyPressed(Key_Return)){
   32C7 21 02 04      [10]  137 	ld	hl,#0x0402
   32CA CD 65 79      [17]  138 	call	_cpct_isKeyPressed
   32CD 7D            [ 4]  139 	ld	a,l
   32CE B7            [ 4]  140 	or	a, a
   32CF 28 06         [12]  141 	jr	Z,00179$
                            142 ;src/State_LoadGame.c:42: ui_loadgame_select_entry();
   32D1 CD 87 46      [17]  143 	call	_ui_loadgame_select_entry
                            144 ;src/State_LoadGame.c:43: statemanager_input_accepted();
   32D4 C3 B6 38      [10]  145 	jp  _statemanager_input_accepted
   32D7                     146 00179$:
                            147 ;src/State_LoadGame.c:45: else if(cpct_isKeyPressed(Key_0)){
   32D7 21 04 01      [10]  148 	ld	hl,#0x0104
   32DA CD 65 79      [17]  149 	call	_cpct_isKeyPressed
   32DD 7D            [ 4]  150 	ld	a,l
   32DE B7            [ 4]  151 	or	a, a
   32DF 28 0B         [12]  152 	jr	Z,00176$
                            153 ;src/State_LoadGame.c:46: ui_stringinput_add_char('0');
   32E1 3E 30         [ 7]  154 	ld	a,#0x30
   32E3 F5            [11]  155 	push	af
   32E4 33            [ 6]  156 	inc	sp
   32E5 CD 4D 3C      [17]  157 	call	_ui_stringinput_add_char
   32E8 33            [ 6]  158 	inc	sp
                            159 ;src/State_LoadGame.c:47: statemanager_input_accepted();
   32E9 C3 B6 38      [10]  160 	jp  _statemanager_input_accepted
   32EC                     161 00176$:
                            162 ;src/State_LoadGame.c:49: else if(cpct_isKeyPressed(Key_1)){
   32EC 21 08 01      [10]  163 	ld	hl,#0x0108
   32EF CD 65 79      [17]  164 	call	_cpct_isKeyPressed
   32F2 7D            [ 4]  165 	ld	a,l
   32F3 B7            [ 4]  166 	or	a, a
   32F4 28 0B         [12]  167 	jr	Z,00173$
                            168 ;src/State_LoadGame.c:50: ui_stringinput_add_char('1');
   32F6 3E 31         [ 7]  169 	ld	a,#0x31
   32F8 F5            [11]  170 	push	af
   32F9 33            [ 6]  171 	inc	sp
   32FA CD 4D 3C      [17]  172 	call	_ui_stringinput_add_char
   32FD 33            [ 6]  173 	inc	sp
                            174 ;src/State_LoadGame.c:51: statemanager_input_accepted();
   32FE C3 B6 38      [10]  175 	jp  _statemanager_input_accepted
   3301                     176 00173$:
                            177 ;src/State_LoadGame.c:53: else if(cpct_isKeyPressed(Key_2)){
   3301 21 08 02      [10]  178 	ld	hl,#0x0208
   3304 CD 65 79      [17]  179 	call	_cpct_isKeyPressed
   3307 7D            [ 4]  180 	ld	a,l
   3308 B7            [ 4]  181 	or	a, a
   3309 28 0B         [12]  182 	jr	Z,00170$
                            183 ;src/State_LoadGame.c:54: ui_stringinput_add_char('2');
   330B 3E 32         [ 7]  184 	ld	a,#0x32
   330D F5            [11]  185 	push	af
   330E 33            [ 6]  186 	inc	sp
   330F CD 4D 3C      [17]  187 	call	_ui_stringinput_add_char
   3312 33            [ 6]  188 	inc	sp
                            189 ;src/State_LoadGame.c:55: statemanager_input_accepted();
   3313 C3 B6 38      [10]  190 	jp  _statemanager_input_accepted
   3316                     191 00170$:
                            192 ;src/State_LoadGame.c:57: else if(cpct_isKeyPressed(Key_3)){
   3316 21 07 02      [10]  193 	ld	hl,#0x0207
   3319 CD 65 79      [17]  194 	call	_cpct_isKeyPressed
   331C 7D            [ 4]  195 	ld	a,l
   331D B7            [ 4]  196 	or	a, a
   331E 28 0B         [12]  197 	jr	Z,00167$
                            198 ;src/State_LoadGame.c:58: ui_stringinput_add_char('3');
   3320 3E 33         [ 7]  199 	ld	a,#0x33
   3322 F5            [11]  200 	push	af
   3323 33            [ 6]  201 	inc	sp
   3324 CD 4D 3C      [17]  202 	call	_ui_stringinput_add_char
   3327 33            [ 6]  203 	inc	sp
                            204 ;src/State_LoadGame.c:59: statemanager_input_accepted();
   3328 C3 B6 38      [10]  205 	jp  _statemanager_input_accepted
   332B                     206 00167$:
                            207 ;src/State_LoadGame.c:61: else if(cpct_isKeyPressed(Key_4)){
   332B 21 07 01      [10]  208 	ld	hl,#0x0107
   332E CD 65 79      [17]  209 	call	_cpct_isKeyPressed
   3331 7D            [ 4]  210 	ld	a,l
   3332 B7            [ 4]  211 	or	a, a
   3333 28 0B         [12]  212 	jr	Z,00164$
                            213 ;src/State_LoadGame.c:62: ui_stringinput_add_char('4');
   3335 3E 34         [ 7]  214 	ld	a,#0x34
   3337 F5            [11]  215 	push	af
   3338 33            [ 6]  216 	inc	sp
   3339 CD 4D 3C      [17]  217 	call	_ui_stringinput_add_char
   333C 33            [ 6]  218 	inc	sp
                            219 ;src/State_LoadGame.c:63: statemanager_input_accepted();
   333D C3 B6 38      [10]  220 	jp  _statemanager_input_accepted
   3340                     221 00164$:
                            222 ;src/State_LoadGame.c:65: else if(cpct_isKeyPressed(Key_5)){
   3340 21 06 02      [10]  223 	ld	hl,#0x0206
   3343 CD 65 79      [17]  224 	call	_cpct_isKeyPressed
   3346 7D            [ 4]  225 	ld	a,l
   3347 B7            [ 4]  226 	or	a, a
   3348 28 0B         [12]  227 	jr	Z,00161$
                            228 ;src/State_LoadGame.c:66: ui_stringinput_add_char('5');
   334A 3E 35         [ 7]  229 	ld	a,#0x35
   334C F5            [11]  230 	push	af
   334D 33            [ 6]  231 	inc	sp
   334E CD 4D 3C      [17]  232 	call	_ui_stringinput_add_char
   3351 33            [ 6]  233 	inc	sp
                            234 ;src/State_LoadGame.c:67: statemanager_input_accepted();
   3352 C3 B6 38      [10]  235 	jp  _statemanager_input_accepted
   3355                     236 00161$:
                            237 ;src/State_LoadGame.c:69: else if(cpct_isKeyPressed(Key_6)){
   3355 21 06 01      [10]  238 	ld	hl,#0x0106
   3358 CD 65 79      [17]  239 	call	_cpct_isKeyPressed
   335B 7D            [ 4]  240 	ld	a,l
   335C B7            [ 4]  241 	or	a, a
   335D 28 0B         [12]  242 	jr	Z,00158$
                            243 ;src/State_LoadGame.c:70: ui_stringinput_add_char('6');
   335F 3E 36         [ 7]  244 	ld	a,#0x36
   3361 F5            [11]  245 	push	af
   3362 33            [ 6]  246 	inc	sp
   3363 CD 4D 3C      [17]  247 	call	_ui_stringinput_add_char
   3366 33            [ 6]  248 	inc	sp
                            249 ;src/State_LoadGame.c:71: statemanager_input_accepted();
   3367 C3 B6 38      [10]  250 	jp  _statemanager_input_accepted
   336A                     251 00158$:
                            252 ;src/State_LoadGame.c:73: else if(cpct_isKeyPressed(Key_7)){
   336A 21 05 02      [10]  253 	ld	hl,#0x0205
   336D CD 65 79      [17]  254 	call	_cpct_isKeyPressed
   3370 7D            [ 4]  255 	ld	a,l
   3371 B7            [ 4]  256 	or	a, a
   3372 28 0B         [12]  257 	jr	Z,00155$
                            258 ;src/State_LoadGame.c:74: ui_stringinput_add_char('7');
   3374 3E 37         [ 7]  259 	ld	a,#0x37
   3376 F5            [11]  260 	push	af
   3377 33            [ 6]  261 	inc	sp
   3378 CD 4D 3C      [17]  262 	call	_ui_stringinput_add_char
   337B 33            [ 6]  263 	inc	sp
                            264 ;src/State_LoadGame.c:75: statemanager_input_accepted();
   337C C3 B6 38      [10]  265 	jp  _statemanager_input_accepted
   337F                     266 00155$:
                            267 ;src/State_LoadGame.c:77: else if(cpct_isKeyPressed(Key_8)){
   337F 21 05 01      [10]  268 	ld	hl,#0x0105
   3382 CD 65 79      [17]  269 	call	_cpct_isKeyPressed
   3385 7D            [ 4]  270 	ld	a,l
   3386 B7            [ 4]  271 	or	a, a
   3387 28 0B         [12]  272 	jr	Z,00152$
                            273 ;src/State_LoadGame.c:78: ui_stringinput_add_char('8');
   3389 3E 38         [ 7]  274 	ld	a,#0x38
   338B F5            [11]  275 	push	af
   338C 33            [ 6]  276 	inc	sp
   338D CD 4D 3C      [17]  277 	call	_ui_stringinput_add_char
   3390 33            [ 6]  278 	inc	sp
                            279 ;src/State_LoadGame.c:79: statemanager_input_accepted();
   3391 C3 B6 38      [10]  280 	jp  _statemanager_input_accepted
   3394                     281 00152$:
                            282 ;src/State_LoadGame.c:81: else if(cpct_isKeyPressed(Key_9)){
   3394 21 04 02      [10]  283 	ld	hl,#0x0204
   3397 CD 65 79      [17]  284 	call	_cpct_isKeyPressed
   339A 7D            [ 4]  285 	ld	a,l
   339B B7            [ 4]  286 	or	a, a
   339C 28 0B         [12]  287 	jr	Z,00149$
                            288 ;src/State_LoadGame.c:82: ui_stringinput_add_char('9');
   339E 3E 39         [ 7]  289 	ld	a,#0x39
   33A0 F5            [11]  290 	push	af
   33A1 33            [ 6]  291 	inc	sp
   33A2 CD 4D 3C      [17]  292 	call	_ui_stringinput_add_char
   33A5 33            [ 6]  293 	inc	sp
                            294 ;src/State_LoadGame.c:83: statemanager_input_accepted();
   33A6 C3 B6 38      [10]  295 	jp  _statemanager_input_accepted
   33A9                     296 00149$:
                            297 ;src/State_LoadGame.c:85: else if(cpct_isKeyPressed(Key_A)){
   33A9 21 08 20      [10]  298 	ld	hl,#0x2008
   33AC CD 65 79      [17]  299 	call	_cpct_isKeyPressed
   33AF 7D            [ 4]  300 	ld	a,l
   33B0 B7            [ 4]  301 	or	a, a
   33B1 28 0B         [12]  302 	jr	Z,00146$
                            303 ;src/State_LoadGame.c:86: ui_stringinput_add_char('A');
   33B3 3E 41         [ 7]  304 	ld	a,#0x41
   33B5 F5            [11]  305 	push	af
   33B6 33            [ 6]  306 	inc	sp
   33B7 CD 4D 3C      [17]  307 	call	_ui_stringinput_add_char
   33BA 33            [ 6]  308 	inc	sp
                            309 ;src/State_LoadGame.c:87: statemanager_input_accepted();
   33BB C3 B6 38      [10]  310 	jp  _statemanager_input_accepted
   33BE                     311 00146$:
                            312 ;src/State_LoadGame.c:89: else if(cpct_isKeyPressed(Key_B)){
   33BE 21 06 40      [10]  313 	ld	hl,#0x4006
   33C1 CD 65 79      [17]  314 	call	_cpct_isKeyPressed
   33C4 7D            [ 4]  315 	ld	a,l
   33C5 B7            [ 4]  316 	or	a, a
   33C6 28 0B         [12]  317 	jr	Z,00143$
                            318 ;src/State_LoadGame.c:90: ui_stringinput_add_char('B');
   33C8 3E 42         [ 7]  319 	ld	a,#0x42
   33CA F5            [11]  320 	push	af
   33CB 33            [ 6]  321 	inc	sp
   33CC CD 4D 3C      [17]  322 	call	_ui_stringinput_add_char
   33CF 33            [ 6]  323 	inc	sp
                            324 ;src/State_LoadGame.c:91: statemanager_input_accepted();
   33D0 C3 B6 38      [10]  325 	jp  _statemanager_input_accepted
   33D3                     326 00143$:
                            327 ;src/State_LoadGame.c:93: else if(cpct_isKeyPressed(Key_C)){
   33D3 21 07 40      [10]  328 	ld	hl,#0x4007
   33D6 CD 65 79      [17]  329 	call	_cpct_isKeyPressed
   33D9 7D            [ 4]  330 	ld	a,l
   33DA B7            [ 4]  331 	or	a, a
   33DB 28 0B         [12]  332 	jr	Z,00140$
                            333 ;src/State_LoadGame.c:94: ui_stringinput_add_char('C');
   33DD 3E 43         [ 7]  334 	ld	a,#0x43
   33DF F5            [11]  335 	push	af
   33E0 33            [ 6]  336 	inc	sp
   33E1 CD 4D 3C      [17]  337 	call	_ui_stringinput_add_char
   33E4 33            [ 6]  338 	inc	sp
                            339 ;src/State_LoadGame.c:95: statemanager_input_accepted();
   33E5 C3 B6 38      [10]  340 	jp  _statemanager_input_accepted
   33E8                     341 00140$:
                            342 ;src/State_LoadGame.c:97: else if(cpct_isKeyPressed(Key_D)){
   33E8 21 07 20      [10]  343 	ld	hl,#0x2007
   33EB CD 65 79      [17]  344 	call	_cpct_isKeyPressed
   33EE 7D            [ 4]  345 	ld	a,l
   33EF B7            [ 4]  346 	or	a, a
   33F0 28 0B         [12]  347 	jr	Z,00137$
                            348 ;src/State_LoadGame.c:98: ui_stringinput_add_char('D');
   33F2 3E 44         [ 7]  349 	ld	a,#0x44
   33F4 F5            [11]  350 	push	af
   33F5 33            [ 6]  351 	inc	sp
   33F6 CD 4D 3C      [17]  352 	call	_ui_stringinput_add_char
   33F9 33            [ 6]  353 	inc	sp
                            354 ;src/State_LoadGame.c:99: statemanager_input_accepted();
   33FA C3 B6 38      [10]  355 	jp  _statemanager_input_accepted
   33FD                     356 00137$:
                            357 ;src/State_LoadGame.c:101: else if(cpct_isKeyPressed(Key_E)){
   33FD 21 07 04      [10]  358 	ld	hl,#0x0407
   3400 CD 65 79      [17]  359 	call	_cpct_isKeyPressed
   3403 7D            [ 4]  360 	ld	a,l
   3404 B7            [ 4]  361 	or	a, a
   3405 28 0B         [12]  362 	jr	Z,00134$
                            363 ;src/State_LoadGame.c:102: ui_stringinput_add_char('E');
   3407 3E 45         [ 7]  364 	ld	a,#0x45
   3409 F5            [11]  365 	push	af
   340A 33            [ 6]  366 	inc	sp
   340B CD 4D 3C      [17]  367 	call	_ui_stringinput_add_char
   340E 33            [ 6]  368 	inc	sp
                            369 ;src/State_LoadGame.c:103: statemanager_input_accepted();
   340F C3 B6 38      [10]  370 	jp  _statemanager_input_accepted
   3412                     371 00134$:
                            372 ;src/State_LoadGame.c:105: else if(cpct_isKeyPressed(Key_F)){
   3412 21 06 20      [10]  373 	ld	hl,#0x2006
   3415 CD 65 79      [17]  374 	call	_cpct_isKeyPressed
   3418 7D            [ 4]  375 	ld	a,l
   3419 B7            [ 4]  376 	or	a, a
   341A 28 0B         [12]  377 	jr	Z,00131$
                            378 ;src/State_LoadGame.c:106: ui_stringinput_add_char('F');
   341C 3E 46         [ 7]  379 	ld	a,#0x46
   341E F5            [11]  380 	push	af
   341F 33            [ 6]  381 	inc	sp
   3420 CD 4D 3C      [17]  382 	call	_ui_stringinput_add_char
   3423 33            [ 6]  383 	inc	sp
                            384 ;src/State_LoadGame.c:107: statemanager_input_accepted();
   3424 C3 B6 38      [10]  385 	jp  _statemanager_input_accepted
   3427                     386 00131$:
                            387 ;src/State_LoadGame.c:109: else if(cpct_isKeyPressed(Key_M)){
   3427 21 04 40      [10]  388 	ld	hl,#0x4004
   342A CD 65 79      [17]  389 	call	_cpct_isKeyPressed
   342D 7D            [ 4]  390 	ld	a,l
   342E B7            [ 4]  391 	or	a, a
   342F 28 0B         [12]  392 	jr	Z,00128$
                            393 ;src/State_LoadGame.c:110: ui_stringinput_add_char('M');
   3431 3E 4D         [ 7]  394 	ld	a,#0x4D
   3433 F5            [11]  395 	push	af
   3434 33            [ 6]  396 	inc	sp
   3435 CD 4D 3C      [17]  397 	call	_ui_stringinput_add_char
   3438 33            [ 6]  398 	inc	sp
                            399 ;src/State_LoadGame.c:111: statemanager_input_accepted();
   3439 C3 B6 38      [10]  400 	jp  _statemanager_input_accepted
   343C                     401 00128$:
                            402 ;src/State_LoadGame.c:113: else if(cpct_isKeyPressed(Key_I)){
   343C 21 04 08      [10]  403 	ld	hl,#0x0804
   343F CD 65 79      [17]  404 	call	_cpct_isKeyPressed
   3442 7D            [ 4]  405 	ld	a,l
   3443 B7            [ 4]  406 	or	a, a
   3444 28 0B         [12]  407 	jr	Z,00125$
                            408 ;src/State_LoadGame.c:114: ui_stringinput_add_char('I');
   3446 3E 49         [ 7]  409 	ld	a,#0x49
   3448 F5            [11]  410 	push	af
   3449 33            [ 6]  411 	inc	sp
   344A CD 4D 3C      [17]  412 	call	_ui_stringinput_add_char
   344D 33            [ 6]  413 	inc	sp
                            414 ;src/State_LoadGame.c:115: statemanager_input_accepted();
   344E C3 B6 38      [10]  415 	jp  _statemanager_input_accepted
   3451                     416 00125$:
                            417 ;src/State_LoadGame.c:117: else if(cpct_isKeyPressed(Key_L)){
   3451 21 04 10      [10]  418 	ld	hl,#0x1004
   3454 CD 65 79      [17]  419 	call	_cpct_isKeyPressed
   3457 7D            [ 4]  420 	ld	a,l
   3458 B7            [ 4]  421 	or	a, a
   3459 28 0B         [12]  422 	jr	Z,00122$
                            423 ;src/State_LoadGame.c:118: ui_stringinput_add_char('L');
   345B 3E 4C         [ 7]  424 	ld	a,#0x4C
   345D F5            [11]  425 	push	af
   345E 33            [ 6]  426 	inc	sp
   345F CD 4D 3C      [17]  427 	call	_ui_stringinput_add_char
   3462 33            [ 6]  428 	inc	sp
                            429 ;src/State_LoadGame.c:119: statemanager_input_accepted();
   3463 C3 B6 38      [10]  430 	jp  _statemanager_input_accepted
   3466                     431 00122$:
                            432 ;src/State_LoadGame.c:121: else if(cpct_isKeyPressed(Key_O)){
   3466 21 04 04      [10]  433 	ld	hl,#0x0404
   3469 CD 65 79      [17]  434 	call	_cpct_isKeyPressed
   346C 7D            [ 4]  435 	ld	a,l
   346D B7            [ 4]  436 	or	a, a
   346E 28 0B         [12]  437 	jr	Z,00119$
                            438 ;src/State_LoadGame.c:122: ui_stringinput_add_char('O');
   3470 3E 4F         [ 7]  439 	ld	a,#0x4F
   3472 F5            [11]  440 	push	af
   3473 33            [ 6]  441 	inc	sp
   3474 CD 4D 3C      [17]  442 	call	_ui_stringinput_add_char
   3477 33            [ 6]  443 	inc	sp
                            444 ;src/State_LoadGame.c:123: statemanager_input_accepted();
   3478 C3 B6 38      [10]  445 	jp  _statemanager_input_accepted
   347B                     446 00119$:
                            447 ;src/State_LoadGame.c:125: else if(cpct_isKeyPressed(Key_T)){
   347B 21 06 08      [10]  448 	ld	hl,#0x0806
   347E CD 65 79      [17]  449 	call	_cpct_isKeyPressed
   3481 7D            [ 4]  450 	ld	a,l
   3482 B7            [ 4]  451 	or	a, a
   3483 28 0B         [12]  452 	jr	Z,00116$
                            453 ;src/State_LoadGame.c:126: ui_stringinput_add_char('T');
   3485 3E 54         [ 7]  454 	ld	a,#0x54
   3487 F5            [11]  455 	push	af
   3488 33            [ 6]  456 	inc	sp
   3489 CD 4D 3C      [17]  457 	call	_ui_stringinput_add_char
   348C 33            [ 6]  458 	inc	sp
                            459 ;src/State_LoadGame.c:127: statemanager_input_accepted();
   348D C3 B6 38      [10]  460 	jp  _statemanager_input_accepted
   3490                     461 00116$:
                            462 ;src/State_LoadGame.c:129: else if(cpct_isKeyPressed(Key_W)){
   3490 21 07 08      [10]  463 	ld	hl,#0x0807
   3493 CD 65 79      [17]  464 	call	_cpct_isKeyPressed
   3496 7D            [ 4]  465 	ld	a,l
   3497 B7            [ 4]  466 	or	a, a
   3498 28 0B         [12]  467 	jr	Z,00113$
                            468 ;src/State_LoadGame.c:130: ui_stringinput_add_char('W');
   349A 3E 57         [ 7]  469 	ld	a,#0x57
   349C F5            [11]  470 	push	af
   349D 33            [ 6]  471 	inc	sp
   349E CD 4D 3C      [17]  472 	call	_ui_stringinput_add_char
   34A1 33            [ 6]  473 	inc	sp
                            474 ;src/State_LoadGame.c:131: statemanager_input_accepted();
   34A2 C3 B6 38      [10]  475 	jp  _statemanager_input_accepted
   34A5                     476 00113$:
                            477 ;src/State_LoadGame.c:133: else if(cpct_isKeyPressed(Key_R)){
   34A5 21 06 04      [10]  478 	ld	hl,#0x0406
   34A8 CD 65 79      [17]  479 	call	_cpct_isKeyPressed
   34AB 7D            [ 4]  480 	ld	a,l
   34AC B7            [ 4]  481 	or	a, a
   34AD 28 0B         [12]  482 	jr	Z,00110$
                            483 ;src/State_LoadGame.c:134: ui_stringinput_add_char('R');
   34AF 3E 52         [ 7]  484 	ld	a,#0x52
   34B1 F5            [11]  485 	push	af
   34B2 33            [ 6]  486 	inc	sp
   34B3 CD 4D 3C      [17]  487 	call	_ui_stringinput_add_char
   34B6 33            [ 6]  488 	inc	sp
                            489 ;src/State_LoadGame.c:135: statemanager_input_accepted();
   34B7 C3 B6 38      [10]  490 	jp  _statemanager_input_accepted
   34BA                     491 00110$:
                            492 ;src/State_LoadGame.c:137: else if(cpct_isKeyPressed(Key_S)){
   34BA 21 07 10      [10]  493 	ld	hl,#0x1007
   34BD CD 65 79      [17]  494 	call	_cpct_isKeyPressed
   34C0 7D            [ 4]  495 	ld	a,l
   34C1 B7            [ 4]  496 	or	a, a
   34C2 28 0B         [12]  497 	jr	Z,00107$
                            498 ;src/State_LoadGame.c:138: ui_stringinput_add_char('S');
   34C4 3E 53         [ 7]  499 	ld	a,#0x53
   34C6 F5            [11]  500 	push	af
   34C7 33            [ 6]  501 	inc	sp
   34C8 CD 4D 3C      [17]  502 	call	_ui_stringinput_add_char
   34CB 33            [ 6]  503 	inc	sp
                            504 ;src/State_LoadGame.c:139: statemanager_input_accepted();
   34CC C3 B6 38      [10]  505 	jp  _statemanager_input_accepted
   34CF                     506 00107$:
                            507 ;src/State_LoadGame.c:141: else if(cpct_isKeyPressed(Key_Space)){
   34CF 21 05 80      [10]  508 	ld	hl,#0x8005
   34D2 CD 65 79      [17]  509 	call	_cpct_isKeyPressed
   34D5 7D            [ 4]  510 	ld	a,l
   34D6 B7            [ 4]  511 	or	a, a
   34D7 28 0B         [12]  512 	jr	Z,00104$
                            513 ;src/State_LoadGame.c:142: ui_stringinput_add_char(' ');
   34D9 3E 20         [ 7]  514 	ld	a,#0x20
   34DB F5            [11]  515 	push	af
   34DC 33            [ 6]  516 	inc	sp
   34DD CD 4D 3C      [17]  517 	call	_ui_stringinput_add_char
   34E0 33            [ 6]  518 	inc	sp
                            519 ;src/State_LoadGame.c:143: statemanager_input_accepted();
   34E1 C3 B6 38      [10]  520 	jp  _statemanager_input_accepted
   34E4                     521 00104$:
                            522 ;src/State_LoadGame.c:145: else if(cpct_isKeyPressed(Key_Del)){
   34E4 21 09 80      [10]  523 	ld	hl,#0x8009
   34E7 CD 65 79      [17]  524 	call	_cpct_isKeyPressed
   34EA 7D            [ 4]  525 	ld	a,l
   34EB B7            [ 4]  526 	or	a, a
   34EC C8            [11]  527 	ret	Z
                            528 ;src/State_LoadGame.c:146: ui_stringinput_remove_char();
   34ED CD 6F 3C      [17]  529 	call	_ui_stringinput_remove_char
                            530 ;src/State_LoadGame.c:147: statemanager_input_accepted();
   34F0 C3 B6 38      [10]  531 	jp  _statemanager_input_accepted
                            532 ;src/State_LoadGame.c:151: void state_loadgame_update(){
                            533 ;	---------------------------------
                            534 ; Function state_loadgame_update
                            535 ; ---------------------------------
   34F3                     536 _state_loadgame_update::
                            537 ;src/State_LoadGame.c:152: if(ui_loadgame_is_selected()){
   34F3 CD 5A 46      [17]  538 	call	_ui_loadgame_is_selected
   34F6 7D            [ 4]  539 	ld	a,l
   34F7 B7            [ 4]  540 	or	a, a
   34F8 CA 8D 46      [10]  541 	jp	Z,_ui_loadgame_unselect_entry
                            542 ;src/State_LoadGame.c:153: ui_loadgame_render_all();
   34FB CD FD 46      [17]  543 	call	_ui_loadgame_render_all
                            544 ;src/State_LoadGame.c:154: switch(ui_loadgame_get_entry()){
   34FE CD 52 46      [17]  545 	call	_ui_loadgame_get_entry
   3501 7D            [ 4]  546 	ld	a,l
   3502 B7            [ 4]  547 	or	a, a
   3503 28 06         [12]  548 	jr	Z,00101$
   3505 2D            [ 4]  549 	dec	l
   3506 28 0E         [12]  550 	jr	Z,00102$
   3508 C3 8D 46      [10]  551 	jp	_ui_loadgame_unselect_entry
                            552 ;src/State_LoadGame.c:155: case 0:{
   350B                     553 00101$:
                            554 ;src/State_LoadGame.c:156: savegame_Load(ui_stringinput_get_string());
   350B CD 6B 3C      [17]  555 	call	_ui_stringinput_get_string
   350E E5            [11]  556 	push	hl
   350F CD 34 2D      [17]  557 	call	_savegame_Load
   3512 F1            [10]  558 	pop	af
                            559 ;src/State_LoadGame.c:157: break;
   3513 C3 8D 46      [10]  560 	jp	_ui_loadgame_unselect_entry
                            561 ;src/State_LoadGame.c:159: case 1:{//Try
   3516                     562 00102$:
                            563 ;src/State_LoadGame.c:160: statemanager_close_state();
   3516 CD 5F 39      [17]  564 	call	_statemanager_close_state
                            565 ;src/State_LoadGame.c:163: }
                            566 ;src/State_LoadGame.c:165: ui_loadgame_unselect_entry();
   3519 C3 8D 46      [10]  567 	jp  _ui_loadgame_unselect_entry
                            568 ;src/State_LoadGame.c:168: void state_loadgame_render(){
                            569 ;	---------------------------------
                            570 ; Function state_loadgame_render
                            571 ; ---------------------------------
   351C                     572 _state_loadgame_render::
                            573 ;src/State_LoadGame.c:169: ui_loadgame_render_all();
   351C C3 FD 46      [10]  574 	jp  _ui_loadgame_render_all
                            575 ;src/State_LoadGame.c:172: void state_loadgame_exit(){
                            576 ;	---------------------------------
                            577 ; Function state_loadgame_exit
                            578 ; ---------------------------------
   351F                     579 _state_loadgame_exit::
                            580 ;src/State_LoadGame.c:173: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 18, 79), g_colors[1], 44, 42);
   351F 21 B0 1A      [10]  581 	ld	hl, #(_g_colors + 0x0001) + 0
   3522 46            [ 7]  582 	ld	b,(hl)
   3523 21 2C 2A      [10]  583 	ld	hl,#0x2A2C
   3526 E5            [11]  584 	push	hl
   3527 C5            [11]  585 	push	bc
   3528 33            [ 6]  586 	inc	sp
   3529 21 E2 FA      [10]  587 	ld	hl,#0xFAE2
   352C E5            [11]  588 	push	hl
   352D CD B8 7B      [17]  589 	call	_cpct_drawSolidBox
   3530 F1            [10]  590 	pop	af
   3531 F1            [10]  591 	pop	af
   3532 33            [ 6]  592 	inc	sp
   3533 C9            [10]  593 	ret
                            594 	.area _CODE
                            595 	.area _INITIALIZER
                            596 	.area _CABS (ABS)
