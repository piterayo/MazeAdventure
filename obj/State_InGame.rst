                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_InGame
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_log_init
                             12 	.globl _ui_playerstats_render
                             13 	.globl _ui_gamemenu_render_refresh
                             14 	.globl _ui_gamemenu_render_all
                             15 	.globl _ui_gamemenu_unselect_entry
                             16 	.globl _ui_gamemenu_select_entry
                             17 	.globl _ui_gamemenu_below_entry
                             18 	.globl _ui_gamemenu_above_entry
                             19 	.globl _ui_gamemenu_previous_entry
                             20 	.globl _ui_gamemenu_next_entry
                             21 	.globl _ui_gamemenu_is_selected
                             22 	.globl _ui_gamemenu_get_entry
                             23 	.globl _ui_gamemenu_get_action
                             24 	.globl _ui_gamemenu_update_action
                             25 	.globl _ui_gamemenu_init
                             26 	.globl _renderCompass
                             27 	.globl _enemy_update
                             28 	.globl _level_get_level
                             29 	.globl _level_set_level
                             30 	.globl _draw_minimap_to_buffer
                             31 	.globl _render_draw_to_buffer
                             32 	.globl _player_move_forward
                             33 	.globl _player_turn_right
                             34 	.globl _player_turn_left
                             35 	.globl _statemanager_input_accepted
                             36 	.globl _statemanager_set_state
                             37 	.globl _statemanager_close_state
                             38 	.globl _cpct_drawSprite
                             39 	.globl _cpct_isKeyPressed
                             40 	.globl _cpct_memset
                             41 	.globl _action
                             42 	.globl _updateRenderBuffer
                             43 	.globl _state_ingame_enter
                             44 	.globl _state_ingame_return
                             45 	.globl _state_ingame_input
                             46 	.globl _state_ingame_update
                             47 	.globl _state_ingame_render
                             48 	.globl _state_ingame_exit
                             49 ;--------------------------------------------------------
                             50 ; special function registers
                             51 ;--------------------------------------------------------
                             52 ;--------------------------------------------------------
                             53 ; ram data
                             54 ;--------------------------------------------------------
                             55 	.area _DATA
   5B2B                      56 _updateRenderBuffer::
   5B2B                      57 	.ds 1
   5B2C                      58 _action::
   5B2C                      59 	.ds 1
                             60 ;--------------------------------------------------------
                             61 ; ram data
                             62 ;--------------------------------------------------------
                             63 	.area _INITIALIZED
                             64 ;--------------------------------------------------------
                             65 ; absolute external ram data
                             66 ;--------------------------------------------------------
                             67 	.area _DABS (ABS)
                             68 ;--------------------------------------------------------
                             69 ; global & static initialisations
                             70 ;--------------------------------------------------------
                             71 	.area _HOME
                             72 	.area _GSINIT
                             73 	.area _GSFINAL
                             74 	.area _GSINIT
                             75 ;--------------------------------------------------------
                             76 ; Home
                             77 ;--------------------------------------------------------
                             78 	.area _HOME
                             79 	.area _HOME
                             80 ;--------------------------------------------------------
                             81 ; code
                             82 ;--------------------------------------------------------
                             83 	.area _CODE
                             84 ;src/State_InGame.c:30: void state_ingame_enter(){
                             85 ;	---------------------------------
                             86 ; Function state_ingame_enter
                             87 ; ---------------------------------
   2002                      88 _state_ingame_enter::
                             89 ;src/State_InGame.c:32: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   2002 21 67 10      [10]   90 	ld	hl, #(_g_colors + 0x0001) + 0
   2005 46            [ 7]   91 	ld	b,(hl)
   2006 21 00 40      [10]   92 	ld	hl,#0x4000
   2009 E5            [11]   93 	push	hl
   200A C5            [11]   94 	push	bc
   200B 33            [ 6]   95 	inc	sp
   200C 26 C0         [ 7]   96 	ld	h, #0xC0
   200E E5            [11]   97 	push	hl
   200F CD 44 59      [17]   98 	call	_cpct_memset
                             99 ;src/State_InGame.c:34: ui_log_init();
   2012 CD E2 2C      [17]  100 	call	_ui_log_init
                            101 ;src/State_InGame.c:36: ui_gamemenu_init();
   2015 CD 97 2A      [17]  102 	call	_ui_gamemenu_init
                            103 ;src/State_InGame.c:37: ui_gamemenu_render_all();
   2018 CD 0A 2C      [17]  104 	call	_ui_gamemenu_render_all
                            105 ;src/State_InGame.c:38: state_ingame_render();
   201B CD 6A 21      [17]  106 	call	_state_ingame_render
   201E C9            [10]  107 	ret
                            108 ;src/State_InGame.c:41: void state_ingame_return(){
                            109 ;	---------------------------------
                            110 ; Function state_ingame_return
                            111 ; ---------------------------------
   201F                     112 _state_ingame_return::
                            113 ;src/State_InGame.c:42: ui_gamemenu_render_all();
   201F CD 0A 2C      [17]  114 	call	_ui_gamemenu_render_all
                            115 ;src/State_InGame.c:43: state_ingame_render();
   2022 C3 6A 21      [10]  116 	jp  _state_ingame_render
                            117 ;src/State_InGame.c:46: void state_ingame_input(){
                            118 ;	---------------------------------
                            119 ; Function state_ingame_input
                            120 ; ---------------------------------
   2025                     121 _state_ingame_input::
                            122 ;src/State_InGame.c:48: if(cpct_isKeyPressed(Key_CursorLeft)){
   2025 21 01 01      [10]  123 	ld	hl,#0x0101
   2028 CD 4F 57      [17]  124 	call	_cpct_isKeyPressed
   202B 7D            [ 4]  125 	ld	a,l
   202C B7            [ 4]  126 	or	a, a
   202D 28 06         [12]  127 	jr	Z,00119$
                            128 ;src/State_InGame.c:49: ui_gamemenu_previous_entry();
   202F CD 5E 2B      [17]  129 	call	_ui_gamemenu_previous_entry
                            130 ;src/State_InGame.c:50: statemanager_input_accepted();
   2032 C3 6B 23      [10]  131 	jp  _statemanager_input_accepted
   2035                     132 00119$:
                            133 ;src/State_InGame.c:52: else if(cpct_isKeyPressed(Key_CursorRight)){
   2035 21 00 02      [10]  134 	ld	hl,#0x0200
   2038 CD 4F 57      [17]  135 	call	_cpct_isKeyPressed
   203B 7D            [ 4]  136 	ld	a,l
   203C B7            [ 4]  137 	or	a, a
   203D 28 06         [12]  138 	jr	Z,00116$
                            139 ;src/State_InGame.c:53: ui_gamemenu_next_entry();
   203F CD 51 2B      [17]  140 	call	_ui_gamemenu_next_entry
                            141 ;src/State_InGame.c:54: statemanager_input_accepted();
   2042 C3 6B 23      [10]  142 	jp  _statemanager_input_accepted
   2045                     143 00116$:
                            144 ;src/State_InGame.c:56: else if(cpct_isKeyPressed(Key_CursorUp)){
   2045 21 00 01      [10]  145 	ld	hl,#0x0100
   2048 CD 4F 57      [17]  146 	call	_cpct_isKeyPressed
   204B 7D            [ 4]  147 	ld	a,l
   204C B7            [ 4]  148 	or	a, a
   204D 28 06         [12]  149 	jr	Z,00113$
                            150 ;src/State_InGame.c:57: ui_gamemenu_above_entry();
   204F CD 19 2B      [17]  151 	call	_ui_gamemenu_above_entry
                            152 ;src/State_InGame.c:58: statemanager_input_accepted();
   2052 C3 6B 23      [10]  153 	jp  _statemanager_input_accepted
   2055                     154 00113$:
                            155 ;src/State_InGame.c:60: else if(cpct_isKeyPressed(Key_CursorDown)){
   2055 21 00 04      [10]  156 	ld	hl,#0x0400
   2058 CD 4F 57      [17]  157 	call	_cpct_isKeyPressed
   205B 7D            [ 4]  158 	ld	a,l
   205C B7            [ 4]  159 	or	a, a
   205D 28 06         [12]  160 	jr	Z,00110$
                            161 ;src/State_InGame.c:61: ui_gamemenu_below_entry();
   205F CD 3A 2B      [17]  162 	call	_ui_gamemenu_below_entry
                            163 ;src/State_InGame.c:62: statemanager_input_accepted();
   2062 C3 6B 23      [10]  164 	jp  _statemanager_input_accepted
   2065                     165 00110$:
                            166 ;src/State_InGame.c:64: else if(cpct_isKeyPressed(Key_Return)){
   2065 21 02 04      [10]  167 	ld	hl,#0x0402
   2068 CD 4F 57      [17]  168 	call	_cpct_isKeyPressed
   206B 7D            [ 4]  169 	ld	a,l
   206C B7            [ 4]  170 	or	a, a
   206D 28 06         [12]  171 	jr	Z,00107$
                            172 ;src/State_InGame.c:65: ui_gamemenu_select_entry();
   206F CD 74 2B      [17]  173 	call	_ui_gamemenu_select_entry
                            174 ;src/State_InGame.c:66: statemanager_input_accepted();
   2072 C3 6B 23      [10]  175 	jp  _statemanager_input_accepted
   2075                     176 00107$:
                            177 ;src/State_InGame.c:69: else if(cpct_isKeyPressed(Key_T)){
   2075 21 06 08      [10]  178 	ld	hl,#0x0806
   2078 CD 4F 57      [17]  179 	call	_cpct_isKeyPressed
   207B 7D            [ 4]  180 	ld	a,l
   207C B7            [ 4]  181 	or	a, a
   207D 28 10         [12]  182 	jr	Z,00104$
                            183 ;src/State_InGame.c:70: *(u8*)&g_texturedWalls = !g_texturedWalls;
   207F 3A 78 10      [13]  184 	ld	a,(#_g_texturedWalls + 0)
   2082 D6 01         [ 7]  185 	sub	a,#0x01
   2084 3E 00         [ 7]  186 	ld	a,#0x00
   2086 17            [ 4]  187 	rla
   2087 4F            [ 4]  188 	ld	c,a
   2088 21 78 10      [10]  189 	ld	hl,#_g_texturedWalls
   208B 71            [ 7]  190 	ld	(hl),c
                            191 ;src/State_InGame.c:71: statemanager_input_accepted();
   208C C3 6B 23      [10]  192 	jp  _statemanager_input_accepted
   208F                     193 00104$:
                            194 ;src/State_InGame.c:73: else if(cpct_isKeyPressed(Key_Tab)){
   208F 21 08 10      [10]  195 	ld	hl,#0x1008
   2092 CD 4F 57      [17]  196 	call	_cpct_isKeyPressed
   2095 7D            [ 4]  197 	ld	a,l
   2096 B7            [ 4]  198 	or	a, a
   2097 C8            [11]  199 	ret	Z
                            200 ;src/State_InGame.c:74: level_set_level(level_get_level()+1);
   2098 CD BE 06      [17]  201 	call	_level_get_level
   209B 2C            [ 4]  202 	inc	l
   209C CD EA 06      [17]  203 	call	_level_set_level
                            204 ;src/State_InGame.c:75: statemanager_close_state();
   209F CD 21 24      [17]  205 	call	_statemanager_close_state
                            206 ;src/State_InGame.c:76: statemanager_set_state(STATE_LOADLEVEL);
   20A2 2E 03         [ 7]  207 	ld	l,#0x03
   20A4 CD 71 23      [17]  208 	call	_statemanager_set_state
                            209 ;src/State_InGame.c:77: statemanager_input_accepted();
   20A7 C3 6B 23      [10]  210 	jp  _statemanager_input_accepted
                            211 ;src/State_InGame.c:81: void state_ingame_update(){
                            212 ;	---------------------------------
                            213 ; Function state_ingame_update
                            214 ; ---------------------------------
   20AA                     215 _state_ingame_update::
                            216 ;src/State_InGame.c:83: action=NONE;
   20AA 21 2C 5B      [10]  217 	ld	hl,#_action + 0
   20AD 36 00         [10]  218 	ld	(hl), #0x00
                            219 ;src/State_InGame.c:84: updateRenderBuffer=0;
   20AF 21 2B 5B      [10]  220 	ld	hl,#_updateRenderBuffer + 0
   20B2 36 00         [10]  221 	ld	(hl), #0x00
                            222 ;src/State_InGame.c:86: if(ui_gamemenu_is_selected()){
   20B4 CD 2A 2C      [17]  223 	call	_ui_gamemenu_is_selected
   20B7 7D            [ 4]  224 	ld	a,l
   20B8 B7            [ 4]  225 	or	a, a
   20B9 CA 56 21      [10]  226 	jp	Z,00114$
                            227 ;src/State_InGame.c:87: ui_gamemenu_render_refresh();
   20BC CD F1 2B      [17]  228 	call	_ui_gamemenu_render_refresh
                            229 ;src/State_InGame.c:88: switch(ui_gamemenu_get_entry()){
   20BF CD 22 2C      [17]  230 	call	_ui_gamemenu_get_entry
   20C2 5D            [ 4]  231 	ld	e,l
   20C3 3E 06         [ 7]  232 	ld	a,#0x06
   20C5 93            [ 4]  233 	sub	a, e
   20C6 DA 53 21      [10]  234 	jp	C,00112$
   20C9 16 00         [ 7]  235 	ld	d,#0x00
   20CB 21 D2 20      [10]  236 	ld	hl,#00145$
   20CE 19            [11]  237 	add	hl,de
   20CF 19            [11]  238 	add	hl,de
   20D0 19            [11]  239 	add	hl,de
   20D1 E9            [ 4]  240 	jp	(hl)
   20D2                     241 00145$:
   20D2 C3 E7 20      [10]  242 	jp	00101$
   20D5 C3 53 21      [10]  243 	jp	00112$
   20D8 C3 1B 21      [10]  244 	jp	00107$
   20DB C3 28 21      [10]  245 	jp	00108$
   20DE C3 35 21      [10]  246 	jp	00109$
   20E1 C3 42 21      [10]  247 	jp	00110$
   20E4 C3 4E 21      [10]  248 	jp	00111$
                            249 ;src/State_InGame.c:89: case 0:{//ACTION BUTTON
   20E7                     250 00101$:
                            251 ;src/State_InGame.c:91: switch(ui_gamemenu_get_action()){
   20E7 CD DA 2C      [17]  252 	call	_ui_gamemenu_get_action
   20EA 5D            [ 4]  253 	ld	e,l
   20EB 7B            [ 4]  254 	ld	a,e
   20EC D6 01         [ 7]  255 	sub	a, #0x01
   20EE 38 63         [12]  256 	jr	C,00112$
   20F0 3E 03         [ 7]  257 	ld	a,#0x03
   20F2 93            [ 4]  258 	sub	a, e
   20F3 38 5E         [12]  259 	jr	C,00112$
   20F5 1D            [ 4]  260 	dec	e
   20F6 16 00         [ 7]  261 	ld	d,#0x00
   20F8 21 FE 20      [10]  262 	ld	hl,#00146$
   20FB 19            [11]  263 	add	hl,de
   20FC 19            [11]  264 	add	hl,de
                            265 ;src/State_InGame.c:92: case 1:{
   20FD E9            [ 4]  266 	jp	(hl)
   20FE                     267 00146$:
   20FE 18 04         [12]  268 	jr	00102$
   2100 18 51         [12]  269 	jr	00112$
   2102 18 4F         [12]  270 	jr	00112$
   2104                     271 00102$:
                            272 ;src/State_InGame.c:93: level_set_level(level_get_level()+1);
   2104 CD BE 06      [17]  273 	call	_level_get_level
   2107 2C            [ 4]  274 	inc	l
   2108 CD EA 06      [17]  275 	call	_level_set_level
                            276 ;src/State_InGame.c:94: statemanager_close_state();
   210B CD 21 24      [17]  277 	call	_statemanager_close_state
                            278 ;src/State_InGame.c:95: statemanager_set_state(STATE_LOADLEVEL);
   210E 2E 03         [ 7]  279 	ld	l,#0x03
   2110 CD 71 23      [17]  280 	call	_statemanager_set_state
                            281 ;src/State_InGame.c:97: break;
   2113 18 3E         [12]  282 	jr	00112$
                            283 ;src/State_InGame.c:99: case 2:{
                            284 ;src/State_InGame.c:101: break;
   2115 18 3C         [12]  285 	jr	00112$
                            286 ;src/State_InGame.c:103: case 3:{
                            287 ;src/State_InGame.c:108: break;
   2117 18 3A         [12]  288 	jr	00112$
                            289 ;src/State_InGame.c:110: case 1:{//INVENTORY
                            290 ;src/State_InGame.c:113: break;
   2119 18 38         [12]  291 	jr	00112$
                            292 ;src/State_InGame.c:115: case 2:{//TURN LEFT
   211B                     293 00107$:
                            294 ;src/State_InGame.c:117: player_turn_left();
   211B CD 31 0E      [17]  295 	call	_player_turn_left
                            296 ;src/State_InGame.c:118: ui_gamemenu_update_action();
   211E CD 32 2C      [17]  297 	call	_ui_gamemenu_update_action
                            298 ;src/State_InGame.c:120: updateRenderBuffer = 1;
   2121 21 2B 5B      [10]  299 	ld	hl,#_updateRenderBuffer + 0
   2124 36 01         [10]  300 	ld	(hl), #0x01
                            301 ;src/State_InGame.c:121: break;
   2126 18 2B         [12]  302 	jr	00112$
                            303 ;src/State_InGame.c:123: case 3:{//MOVE
   2128                     304 00108$:
                            305 ;src/State_InGame.c:126: player_move_forward();
   2128 CD 87 0E      [17]  306 	call	_player_move_forward
                            307 ;src/State_InGame.c:127: ui_gamemenu_update_action();
   212B CD 32 2C      [17]  308 	call	_ui_gamemenu_update_action
                            309 ;src/State_InGame.c:130: updateRenderBuffer = 1;
   212E 21 2B 5B      [10]  310 	ld	hl,#_updateRenderBuffer + 0
   2131 36 01         [10]  311 	ld	(hl), #0x01
                            312 ;src/State_InGame.c:132: break;
   2133 18 1E         [12]  313 	jr	00112$
                            314 ;src/State_InGame.c:134: case 4:{//TURN RIGHT
   2135                     315 00109$:
                            316 ;src/State_InGame.c:135: player_turn_right();
   2135 CD 5E 0E      [17]  317 	call	_player_turn_right
                            318 ;src/State_InGame.c:136: ui_gamemenu_update_action();
   2138 CD 32 2C      [17]  319 	call	_ui_gamemenu_update_action
                            320 ;src/State_InGame.c:138: updateRenderBuffer = 1;
   213B 21 2B 5B      [10]  321 	ld	hl,#_updateRenderBuffer + 0
   213E 36 01         [10]  322 	ld	(hl), #0x01
                            323 ;src/State_InGame.c:140: break;
   2140 18 11         [12]  324 	jr	00112$
                            325 ;src/State_InGame.c:142: case 5:{//WAIT
   2142                     326 00110$:
                            327 ;src/State_InGame.c:143: action=WAIT;
   2142 21 2C 5B      [10]  328 	ld	hl,#_action + 0
   2145 36 05         [10]  329 	ld	(hl), #0x05
                            330 ;src/State_InGame.c:144: updateRenderBuffer = 1;
   2147 21 2B 5B      [10]  331 	ld	hl,#_updateRenderBuffer + 0
   214A 36 01         [10]  332 	ld	(hl), #0x01
                            333 ;src/State_InGame.c:145: break;
   214C 18 05         [12]  334 	jr	00112$
                            335 ;src/State_InGame.c:147: case 6:{//PAUSE
   214E                     336 00111$:
                            337 ;src/State_InGame.c:148: statemanager_set_state(STATE_PAUSEMENU);
   214E 2E 02         [ 7]  338 	ld	l,#0x02
   2150 CD 71 23      [17]  339 	call	_statemanager_set_state
                            340 ;src/State_InGame.c:151: }
   2153                     341 00112$:
                            342 ;src/State_InGame.c:152: ui_gamemenu_unselect_entry();
   2153 CD 6E 2B      [17]  343 	call	_ui_gamemenu_unselect_entry
   2156                     344 00114$:
                            345 ;src/State_InGame.c:155: if(action!=NONE){
   2156 3A 2C 5B      [13]  346 	ld	a,(#_action + 0)
   2159 B7            [ 4]  347 	or	a, a
   215A 28 03         [12]  348 	jr	Z,00116$
                            349 ;src/State_InGame.c:156: enemy_update();
   215C CD 39 06      [17]  350 	call	_enemy_update
   215F                     351 00116$:
                            352 ;src/State_InGame.c:159: if(updateRenderBuffer){
   215F 3A 2B 5B      [13]  353 	ld	a,(#_updateRenderBuffer + 0)
   2162 B7            [ 4]  354 	or	a, a
   2163 C8            [11]  355 	ret	Z
                            356 ;src/State_InGame.c:160: render_draw_to_buffer();
   2164 CD 72 13      [17]  357 	call	_render_draw_to_buffer
                            358 ;src/State_InGame.c:161: draw_minimap_to_buffer();
   2167 C3 CC 1E      [10]  359 	jp  _draw_minimap_to_buffer
                            360 ;src/State_InGame.c:166: void state_ingame_render(){
                            361 ;	---------------------------------
                            362 ; Function state_ingame_render
                            363 ; ---------------------------------
   216A                     364 _state_ingame_render::
                            365 ;src/State_InGame.c:167: ui_gamemenu_render_refresh();
   216A CD F1 2B      [17]  366 	call	_ui_gamemenu_render_refresh
                            367 ;src/State_InGame.c:168: renderCompass();
   216D CD 7B 2A      [17]  368 	call	_renderCompass
                            369 ;src/State_InGame.c:169: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   2170 21 28 64      [10]  370 	ld	hl,#0x6428
   2173 E5            [11]  371 	push	hl
   2174 21 B4 C0      [10]  372 	ld	hl,#0xC0B4
   2177 E5            [11]  373 	push	hl
   2178 21 00 9B      [10]  374 	ld	hl,#0x9B00
   217B E5            [11]  375 	push	hl
   217C CD 7E 57      [17]  376 	call	_cpct_drawSprite
                            377 ;src/State_InGame.c:170: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   217F 21 10 40      [10]  378 	ld	hl,#0x4010
   2182 E5            [11]  379 	push	hl
   2183 21 20 C5      [10]  380 	ld	hl,#0xC520
   2186 E5            [11]  381 	push	hl
   2187 21 A0 AA      [10]  382 	ld	hl,#0xAAA0
   218A E5            [11]  383 	push	hl
   218B CD 7E 57      [17]  384 	call	_cpct_drawSprite
                            385 ;src/State_InGame.c:171: ui_playerstats_render();
   218E CD F2 2F      [17]  386 	call	_ui_playerstats_render
                            387 ;src/State_InGame.c:172: ui_log_render();
   2191 CD 57 2D      [17]  388 	call	_ui_log_render
   2194 C9            [10]  389 	ret
                            390 ;src/State_InGame.c:175: void state_ingame_exit(){
                            391 ;	---------------------------------
                            392 ; Function state_ingame_exit
                            393 ; ---------------------------------
   2195                     394 _state_ingame_exit::
                            395 ;src/State_InGame.c:177: }
   2195 C9            [10]  396 	ret
                            397 	.area _CODE
                            398 	.area _INITIALIZER
                            399 	.area _CABS (ABS)
