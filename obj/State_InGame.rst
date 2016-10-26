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
                             11 	.globl _state_ingame_update_buffers
                             12 	.globl _state_ingame_update_turn
                             13 	.globl _ui_log_render
                             14 	.globl _ui_log_init
                             15 	.globl _ui_playerstats_render_all
                             16 	.globl _ui_gamemenu_render_refresh
                             17 	.globl _ui_gamemenu_render_all
                             18 	.globl _ui_gamemenu_unselect_entry
                             19 	.globl _ui_gamemenu_select_entry
                             20 	.globl _ui_gamemenu_below_entry
                             21 	.globl _ui_gamemenu_above_entry
                             22 	.globl _ui_gamemenu_previous_entry
                             23 	.globl _ui_gamemenu_next_entry
                             24 	.globl _ui_gamemenu_is_selected
                             25 	.globl _ui_gamemenu_get_entry
                             26 	.globl _ui_gamemenu_get_movement
                             27 	.globl _ui_gamemenu_get_action
                             28 	.globl _ui_gamemenu_update_action
                             29 	.globl _ui_gamemenu_init
                             30 	.globl _renderCompass
                             31 	.globl _state_inventory_object_used
                             32 	.globl _enemy_update
                             33 	.globl _enemy_try_new_spawn
                             34 	.globl _enemy_get_at
                             35 	.globl _enemy_attack_enemy
                             36 	.globl _item_pick_item
                             37 	.globl _item_get_at
                             38 	.globl _level_get_level
                             39 	.globl _level_set_level
                             40 	.globl _draw_minimap_to_buffer
                             41 	.globl _render_draw_to_buffer
                             42 	.globl _player_move_forward
                             43 	.globl _player_turn_right
                             44 	.globl _player_turn_left
                             45 	.globl _statemanager_input_accepted
                             46 	.globl _statemanager_set_state
                             47 	.globl _statemanager_close_state
                             48 	.globl _cpct_drawSprite
                             49 	.globl _cpct_isKeyPressed
                             50 	.globl _cpct_memset
                             51 	.globl _action
                             52 	.globl _updateRenderBuffer
                             53 	.globl _state_ingame_enter
                             54 	.globl _state_ingame_return
                             55 	.globl _state_ingame_input
                             56 	.globl _state_ingame_update
                             57 	.globl _state_ingame_render
                             58 	.globl _state_ingame_exit
                             59 ;--------------------------------------------------------
                             60 ; special function registers
                             61 ;--------------------------------------------------------
                             62 ;--------------------------------------------------------
                             63 ; ram data
                             64 ;--------------------------------------------------------
                             65 	.area _DATA
   8729                      66 _updateRenderBuffer::
   8729                      67 	.ds 1
   872A                      68 _action::
   872A                      69 	.ds 1
                             70 ;--------------------------------------------------------
                             71 ; ram data
                             72 ;--------------------------------------------------------
                             73 	.area _INITIALIZED
                             74 ;--------------------------------------------------------
                             75 ; absolute external ram data
                             76 ;--------------------------------------------------------
                             77 	.area _DABS (ABS)
                             78 ;--------------------------------------------------------
                             79 ; global & static initialisations
                             80 ;--------------------------------------------------------
                             81 	.area _HOME
                             82 	.area _GSINIT
                             83 	.area _GSFINAL
                             84 	.area _GSINIT
                             85 ;--------------------------------------------------------
                             86 ; Home
                             87 ;--------------------------------------------------------
                             88 	.area _HOME
                             89 	.area _HOME
                             90 ;--------------------------------------------------------
                             91 ; code
                             92 ;--------------------------------------------------------
                             93 	.area _CODE
                             94 ;src/State_InGame.c:36: void state_ingame_enter(){
                             95 ;	---------------------------------
                             96 ; Function state_ingame_enter
                             97 ; ---------------------------------
   30C8                      98 _state_ingame_enter::
                             99 ;src/State_InGame.c:38: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   30C8 21 29 1C      [10]  100 	ld	hl, #(_g_colors + 0x0001) + 0
   30CB 46            [ 7]  101 	ld	b,(hl)
   30CC 21 00 40      [10]  102 	ld	hl,#0x4000
   30CF E5            [11]  103 	push	hl
   30D0 C5            [11]  104 	push	bc
   30D1 33            [ 6]  105 	inc	sp
   30D2 26 C0         [ 7]  106 	ld	h, #0xC0
   30D4 E5            [11]  107 	push	hl
   30D5 CD 11 85      [17]  108 	call	_cpct_memset
                            109 ;src/State_InGame.c:40: ui_log_init();
   30D8 CD 8D 48      [17]  110 	call	_ui_log_init
                            111 ;src/State_InGame.c:42: action=NONE;
   30DB 21 2A 87      [10]  112 	ld	hl,#_action + 0
   30DE 36 00         [10]  113 	ld	(hl), #0x00
                            114 ;src/State_InGame.c:44: ui_gamemenu_init();
   30E0 CD C6 43      [17]  115 	call	_ui_gamemenu_init
                            116 ;src/State_InGame.c:45: ui_gamemenu_render_all();
   30E3 CD 47 45      [17]  117 	call	_ui_gamemenu_render_all
                            118 ;src/State_InGame.c:46: ui_playerstats_render_all();
   30E6 CD 33 4D      [17]  119 	call	_ui_playerstats_render_all
                            120 ;src/State_InGame.c:47: ui_log_render();
   30E9 CD 1A 49      [17]  121 	call	_ui_log_render
                            122 ;src/State_InGame.c:48: state_ingame_render();
   30EC CD CF 32      [17]  123 	call	_state_ingame_render
   30EF C9            [10]  124 	ret
                            125 ;src/State_InGame.c:51: void state_ingame_update_turn(){
                            126 ;	---------------------------------
                            127 ; Function state_ingame_update_turn
                            128 ; ---------------------------------
   30F0                     129 _state_ingame_update_turn::
                            130 ;src/State_InGame.c:52: enemy_update();
   30F0 CD 7A 0C      [17]  131 	call	_enemy_update
                            132 ;src/State_InGame.c:53: if(level_get_level()!=KING_LEVEL) enemy_try_new_spawn();
   30F3 CD 59 11      [17]  133 	call	_level_get_level
   30F6 7D            [ 4]  134 	ld	a,l
   30F7 D6 20         [ 7]  135 	sub	a, #0x20
   30F9 28 03         [12]  136 	jr	Z,00102$
   30FB CD C7 04      [17]  137 	call	_enemy_try_new_spawn
   30FE                     138 00102$:
                            139 ;src/State_InGame.c:54: ui_gamemenu_update_action();
   30FE CD A7 45      [17]  140 	call	_ui_gamemenu_update_action
                            141 ;src/State_InGame.c:56: if(player_is_dead){//Game over
   3101 3A 08 87      [13]  142 	ld	a,(#_player_is_dead + 0)
   3104 B7            [ 4]  143 	or	a, a
   3105 28 08         [12]  144 	jr	Z,00104$
                            145 ;src/State_InGame.c:57: statemanager_set_state(STATE_GAMEOVER);
   3107 3E 05         [ 7]  146 	ld	a,#0x05
   3109 F5            [11]  147 	push	af
   310A 33            [ 6]  148 	inc	sp
   310B CD 01 3A      [17]  149 	call	_statemanager_set_state
   310E 33            [ 6]  150 	inc	sp
   310F                     151 00104$:
                            152 ;src/State_InGame.c:59: updateRenderBuffer = 1;
   310F 21 29 87      [10]  153 	ld	hl,#_updateRenderBuffer + 0
   3112 36 01         [10]  154 	ld	(hl), #0x01
   3114 C9            [10]  155 	ret
                            156 ;src/State_InGame.c:62: void state_ingame_update_buffers(){
                            157 ;	---------------------------------
                            158 ; Function state_ingame_update_buffers
                            159 ; ---------------------------------
   3115                     160 _state_ingame_update_buffers::
                            161 ;src/State_InGame.c:63: render_draw_to_buffer();
   3115 CD 2B 20      [17]  162 	call	_render_draw_to_buffer
                            163 ;src/State_InGame.c:64: draw_minimap_to_buffer();
   3118 C3 F1 2B      [10]  164 	jp  _draw_minimap_to_buffer
                            165 ;src/State_InGame.c:67: void state_ingame_return(){
                            166 ;	---------------------------------
                            167 ; Function state_ingame_return
                            168 ; ---------------------------------
   311B                     169 _state_ingame_return::
                            170 ;src/State_InGame.c:68: if(state_inventory_object_used()){
   311B CD 2A 33      [17]  171 	call	_state_inventory_object_used
   311E 7D            [ 4]  172 	ld	a,l
   311F B7            [ 4]  173 	or	a, a
   3120 28 06         [12]  174 	jr	Z,00102$
                            175 ;src/State_InGame.c:69: state_ingame_update_turn();
   3122 CD F0 30      [17]  176 	call	_state_ingame_update_turn
                            177 ;src/State_InGame.c:70: state_ingame_update_buffers();
   3125 CD 15 31      [17]  178 	call	_state_ingame_update_buffers
   3128                     179 00102$:
                            180 ;src/State_InGame.c:72: ui_gamemenu_unselect_entry();
   3128 CD 9C 44      [17]  181 	call	_ui_gamemenu_unselect_entry
                            182 ;src/State_InGame.c:73: ui_gamemenu_render_all();
   312B CD 47 45      [17]  183 	call	_ui_gamemenu_render_all
                            184 ;src/State_InGame.c:74: ui_playerstats_render_all();
   312E CD 33 4D      [17]  185 	call	_ui_playerstats_render_all
                            186 ;src/State_InGame.c:75: ui_log_render();
   3131 CD 1A 49      [17]  187 	call	_ui_log_render
                            188 ;src/State_InGame.c:76: state_ingame_render();
   3134 C3 CF 32      [10]  189 	jp  _state_ingame_render
                            190 ;src/State_InGame.c:79: void state_ingame_input(){
                            191 ;	---------------------------------
                            192 ; Function state_ingame_input
                            193 ; ---------------------------------
   3137                     194 _state_ingame_input::
                            195 ;src/State_InGame.c:81: if(cpct_isKeyPressed(Key_CursorLeft)){
   3137 21 01 01      [10]  196 	ld	hl,#0x0101
   313A CD B3 7A      [17]  197 	call	_cpct_isKeyPressed
   313D 7D            [ 4]  198 	ld	a,l
   313E B7            [ 4]  199 	or	a, a
   313F 28 06         [12]  200 	jr	Z,00113$
                            201 ;src/State_InGame.c:82: ui_gamemenu_previous_entry();
   3141 CD 8C 44      [17]  202 	call	_ui_gamemenu_previous_entry
                            203 ;src/State_InGame.c:83: statemanager_input_accepted();
   3144 C3 FB 39      [10]  204 	jp  _statemanager_input_accepted
   3147                     205 00113$:
                            206 ;src/State_InGame.c:85: else if(cpct_isKeyPressed(Key_CursorRight)){
   3147 21 00 02      [10]  207 	ld	hl,#0x0200
   314A CD B3 7A      [17]  208 	call	_cpct_isKeyPressed
   314D 7D            [ 4]  209 	ld	a,l
   314E B7            [ 4]  210 	or	a, a
   314F 28 06         [12]  211 	jr	Z,00110$
                            212 ;src/State_InGame.c:86: ui_gamemenu_next_entry();
   3151 CD 7F 44      [17]  213 	call	_ui_gamemenu_next_entry
                            214 ;src/State_InGame.c:87: statemanager_input_accepted();
   3154 C3 FB 39      [10]  215 	jp  _statemanager_input_accepted
   3157                     216 00110$:
                            217 ;src/State_InGame.c:89: else if(cpct_isKeyPressed(Key_CursorUp)){
   3157 21 00 01      [10]  218 	ld	hl,#0x0100
   315A CD B3 7A      [17]  219 	call	_cpct_isKeyPressed
   315D 7D            [ 4]  220 	ld	a,l
   315E B7            [ 4]  221 	or	a, a
   315F 28 06         [12]  222 	jr	Z,00107$
                            223 ;src/State_InGame.c:90: ui_gamemenu_above_entry();
   3161 CD 47 44      [17]  224 	call	_ui_gamemenu_above_entry
                            225 ;src/State_InGame.c:91: statemanager_input_accepted();
   3164 C3 FB 39      [10]  226 	jp  _statemanager_input_accepted
   3167                     227 00107$:
                            228 ;src/State_InGame.c:93: else if(cpct_isKeyPressed(Key_CursorDown)){
   3167 21 00 04      [10]  229 	ld	hl,#0x0400
   316A CD B3 7A      [17]  230 	call	_cpct_isKeyPressed
   316D 7D            [ 4]  231 	ld	a,l
   316E B7            [ 4]  232 	or	a, a
   316F 28 06         [12]  233 	jr	Z,00104$
                            234 ;src/State_InGame.c:94: ui_gamemenu_below_entry();
   3171 CD 68 44      [17]  235 	call	_ui_gamemenu_below_entry
                            236 ;src/State_InGame.c:95: statemanager_input_accepted();
   3174 C3 FB 39      [10]  237 	jp  _statemanager_input_accepted
   3177                     238 00104$:
                            239 ;src/State_InGame.c:97: else if(cpct_isKeyPressed(Key_Return)){
   3177 21 02 04      [10]  240 	ld	hl,#0x0402
   317A CD B3 7A      [17]  241 	call	_cpct_isKeyPressed
   317D 7D            [ 4]  242 	ld	a,l
   317E B7            [ 4]  243 	or	a, a
   317F C8            [11]  244 	ret	Z
                            245 ;src/State_InGame.c:98: ui_gamemenu_select_entry();
   3180 CD A2 44      [17]  246 	call	_ui_gamemenu_select_entry
                            247 ;src/State_InGame.c:99: statemanager_input_accepted();
   3183 C3 FB 39      [10]  248 	jp  _statemanager_input_accepted
                            249 ;src/State_InGame.c:109: void state_ingame_update(){
                            250 ;	---------------------------------
                            251 ; Function state_ingame_update
                            252 ; ---------------------------------
   3186                     253 _state_ingame_update::
   3186 DD E5         [15]  254 	push	ix
   3188 DD 21 00 00   [14]  255 	ld	ix,#0
   318C DD 39         [15]  256 	add	ix,sp
   318E 3B            [ 6]  257 	dec	sp
                            258 ;src/State_InGame.c:110: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
   318F 21 EE 19      [10]  259 	ld	hl,#_player_position+0
   3192 4E            [ 7]  260 	ld	c,(hl)
   3193 06 00         [ 7]  261 	ld	b,#0x00
   3195 3A F0 19      [13]  262 	ld	a, (#_player_direction + 0)
   3198 6F            [ 4]  263 	ld	l,a
   3199 17            [ 4]  264 	rla
   319A 9F            [ 4]  265 	sbc	a, a
   319B 67            [ 4]  266 	ld	h,a
   319C 09            [11]  267 	add	hl,bc
   319D 01 D0 88      [10]  268 	ld	bc,#0x88D0
   31A0 09            [11]  269 	add	hl,bc
   31A1 4D            [ 4]  270 	ld	c,l
   31A2 44            [ 4]  271 	ld	b,h
   31A3 21 EF 19      [10]  272 	ld	hl,#_player_position+1
   31A6 5E            [ 7]  273 	ld	e,(hl)
   31A7 16 00         [ 7]  274 	ld	d,#0x00
   31A9 3A F1 19      [13]  275 	ld	a, (#(_player_direction + 0x0001) + 0)
   31AC 6F            [ 4]  276 	ld	l,a
   31AD 17            [ 4]  277 	rla
   31AE 9F            [ 4]  278 	sbc	a, a
   31AF 67            [ 4]  279 	ld	h,a
   31B0 19            [11]  280 	add	hl,de
   31B1 29            [11]  281 	add	hl, hl
   31B2 29            [11]  282 	add	hl, hl
   31B3 29            [11]  283 	add	hl, hl
   31B4 29            [11]  284 	add	hl, hl
   31B5 29            [11]  285 	add	hl, hl
   31B6 09            [11]  286 	add	hl,bc
   31B7 7E            [ 7]  287 	ld	a,(hl)
   31B8 DD 77 FF      [19]  288 	ld	-1 (ix),a
                            289 ;src/State_InGame.c:113: updateRenderBuffer=0;
   31BB 21 29 87      [10]  290 	ld	hl,#_updateRenderBuffer + 0
   31BE 36 00         [10]  291 	ld	(hl), #0x00
                            292 ;src/State_InGame.c:115: if(ui_gamemenu_is_selected()){
   31C0 CD 9F 45      [17]  293 	call	_ui_gamemenu_is_selected
   31C3 7D            [ 4]  294 	ld	a,l
   31C4 B7            [ 4]  295 	or	a, a
   31C5 CA B4 32      [10]  296 	jp	Z,00116$
                            297 ;src/State_InGame.c:116: ui_gamemenu_render_refresh();
   31C8 CD 1F 45      [17]  298 	call	_ui_gamemenu_render_refresh
                            299 ;src/State_InGame.c:117: switch(ui_gamemenu_get_entry()){
   31CB CD 97 45      [17]  300 	call	_ui_gamemenu_get_entry
   31CE 5D            [ 4]  301 	ld	e,l
   31CF 3E 06         [ 7]  302 	ld	a,#0x06
   31D1 93            [ 4]  303 	sub	a, e
   31D2 DA B4 32      [10]  304 	jp	C,00116$
   31D5 16 00         [ 7]  305 	ld	d,#0x00
   31D7 21 DE 31      [10]  306 	ld	hl,#00151$
   31DA 19            [11]  307 	add	hl,de
   31DB 19            [11]  308 	add	hl,de
   31DC 19            [11]  309 	add	hl,de
   31DD E9            [ 4]  310 	jp	(hl)
   31DE                     311 00151$:
   31DE C3 F3 31      [10]  312 	jp	00101$
   31E1 C3 61 32      [10]  313 	jp	00106$
   31E4 C3 6B 32      [10]  314 	jp	00107$
   31E7 C3 7B 32      [10]  315 	jp	00108$
   31EA C3 92 32      [10]  316 	jp	00111$
   31ED C3 A2 32      [10]  317 	jp	00112$
   31F0 C3 AC 32      [10]  318 	jp	00113$
                            319 ;src/State_InGame.c:118: case 0:{//ACTION BUTTON
   31F3                     320 00101$:
                            321 ;src/State_InGame.c:120: switch(ui_gamemenu_get_action()){
   31F3 CD 40 46      [17]  322 	call	_ui_gamemenu_get_action
   31F6 5D            [ 4]  323 	ld	e,l
   31F7 7B            [ 4]  324 	ld	a,e
   31F8 D6 01         [ 7]  325 	sub	a, #0x01
   31FA 38 60         [12]  326 	jr	C,00105$
   31FC 3E 03         [ 7]  327 	ld	a,#0x03
   31FE 93            [ 4]  328 	sub	a, e
   31FF 38 5B         [12]  329 	jr	C,00105$
   3201 1D            [ 4]  330 	dec	e
   3202 16 00         [ 7]  331 	ld	d,#0x00
   3204 21 0A 32      [10]  332 	ld	hl,#00152$
   3207 19            [11]  333 	add	hl,de
   3208 19            [11]  334 	add	hl,de
                            335 ;src/State_InGame.c:121: case 1:{
   3209 E9            [ 4]  336 	jp	(hl)
   320A                     337 00152$:
   320A 18 04         [12]  338 	jr	00102$
   320C 18 1A         [12]  339 	jr	00103$
   320E 18 2E         [12]  340 	jr	00104$
   3210                     341 00102$:
                            342 ;src/State_InGame.c:122: level_set_level(level_get_level()+1);
   3210 CD 59 11      [17]  343 	call	_level_get_level
   3213 45            [ 4]  344 	ld	b,l
   3214 04            [ 4]  345 	inc	b
   3215 C5            [11]  346 	push	bc
   3216 33            [ 6]  347 	inc	sp
   3217 CD 8E 11      [17]  348 	call	_level_set_level
   321A 33            [ 6]  349 	inc	sp
                            350 ;src/State_InGame.c:123: statemanager_close_state();
   321B CD A4 3A      [17]  351 	call	_statemanager_close_state
                            352 ;src/State_InGame.c:124: statemanager_set_state(STATE_LOADLEVEL);
   321E 3E 03         [ 7]  353 	ld	a,#0x03
   3220 F5            [11]  354 	push	af
   3221 33            [ 6]  355 	inc	sp
   3222 CD 01 3A      [17]  356 	call	_statemanager_set_state
   3225 33            [ 6]  357 	inc	sp
                            358 ;src/State_InGame.c:126: break;
   3226 18 34         [12]  359 	jr	00105$
                            360 ;src/State_InGame.c:128: case 2:{
   3228                     361 00103$:
                            362 ;src/State_InGame.c:129: action=ATTACK;
   3228 21 2A 87      [10]  363 	ld	hl,#_action + 0
   322B 36 02         [10]  364 	ld	(hl), #0x02
                            365 ;src/State_InGame.c:130: enemy_attack_enemy(enemy_get_at(forward-1));
   322D DD 46 FF      [19]  366 	ld	b,-1 (ix)
   3230 05            [ 4]  367 	dec	b
   3231 C5            [11]  368 	push	bc
   3232 33            [ 6]  369 	inc	sp
   3233 CD 40 01      [17]  370 	call	_enemy_get_at
   3236 33            [ 6]  371 	inc	sp
   3237 E5            [11]  372 	push	hl
   3238 CD 55 07      [17]  373 	call	_enemy_attack_enemy
   323B F1            [10]  374 	pop	af
                            375 ;src/State_InGame.c:131: break;
   323C 18 1E         [12]  376 	jr	00105$
                            377 ;src/State_InGame.c:133: case 3:{
   323E                     378 00104$:
                            379 ;src/State_InGame.c:134: action=PICK_OBJECT;
   323E 21 2A 87      [10]  380 	ld	hl,#_action + 0
   3241 36 03         [10]  381 	ld	(hl), #0x03
                            382 ;src/State_InGame.c:135: item_pick_item(item_get_at((forward)>>4)-1);
   3243 DD 7E FF      [19]  383 	ld	a,-1 (ix)
   3246 07            [ 4]  384 	rlca
   3247 07            [ 4]  385 	rlca
   3248 07            [ 4]  386 	rlca
   3249 07            [ 4]  387 	rlca
   324A E6 0F         [ 7]  388 	and	a,#0x0F
   324C 47            [ 4]  389 	ld	b,a
   324D C5            [11]  390 	push	bc
   324E 33            [ 6]  391 	inc	sp
   324F CD 69 0D      [17]  392 	call	_item_get_at
   3252 33            [ 6]  393 	inc	sp
   3253 01 FB FF      [10]  394 	ld	bc, #0xFFFB
   3256 09            [11]  395 	add	hl,bc
   3257 E5            [11]  396 	push	hl
   3258 CD C7 0F      [17]  397 	call	_item_pick_item
   325B F1            [10]  398 	pop	af
                            399 ;src/State_InGame.c:139: }
   325C                     400 00105$:
                            401 ;src/State_InGame.c:140: ui_gamemenu_unselect_entry();
   325C CD 9C 44      [17]  402 	call	_ui_gamemenu_unselect_entry
                            403 ;src/State_InGame.c:141: break;
   325F 18 53         [12]  404 	jr	00116$
                            405 ;src/State_InGame.c:143: case 1:{//INVENTORY
   3261                     406 00106$:
                            407 ;src/State_InGame.c:145: statemanager_set_state(STATE_INVENTORY);                
   3261 3E 08         [ 7]  408 	ld	a,#0x08
   3263 F5            [11]  409 	push	af
   3264 33            [ 6]  410 	inc	sp
   3265 CD 01 3A      [17]  411 	call	_statemanager_set_state
   3268 33            [ 6]  412 	inc	sp
                            413 ;src/State_InGame.c:147: break;
   3269 18 49         [12]  414 	jr	00116$
                            415 ;src/State_InGame.c:149: case 2:{//TURN LEFT
   326B                     416 00107$:
                            417 ;src/State_InGame.c:151: player_turn_left();
   326B CD F2 19      [17]  418 	call	_player_turn_left
                            419 ;src/State_InGame.c:152: ui_gamemenu_update_action();
   326E CD A7 45      [17]  420 	call	_ui_gamemenu_update_action
                            421 ;src/State_InGame.c:154: updateRenderBuffer = 1;
   3271 21 29 87      [10]  422 	ld	hl,#_updateRenderBuffer + 0
   3274 36 01         [10]  423 	ld	(hl), #0x01
                            424 ;src/State_InGame.c:155: ui_gamemenu_unselect_entry();
   3276 CD 9C 44      [17]  425 	call	_ui_gamemenu_unselect_entry
                            426 ;src/State_InGame.c:156: break;
   3279 18 39         [12]  427 	jr	00116$
                            428 ;src/State_InGame.c:158: case 3:{//MOVE
   327B                     429 00108$:
                            430 ;src/State_InGame.c:159: if(ui_gamemenu_get_movement()){//BYPASS IF FOR NOCLIP
   327B CD 38 46      [17]  431 	call	_ui_gamemenu_get_movement
   327E 7D            [ 4]  432 	ld	a,l
   327F B7            [ 4]  433 	or	a, a
   3280 28 0B         [12]  434 	jr	Z,00110$
                            435 ;src/State_InGame.c:161: player_move_forward();
   3282 CD 44 1A      [17]  436 	call	_player_move_forward
                            437 ;src/State_InGame.c:162: ui_gamemenu_update_action();
   3285 CD A7 45      [17]  438 	call	_ui_gamemenu_update_action
                            439 ;src/State_InGame.c:163: action=MOVE;
   3288 21 2A 87      [10]  440 	ld	hl,#_action + 0
   328B 36 01         [10]  441 	ld	(hl), #0x01
   328D                     442 00110$:
                            443 ;src/State_InGame.c:167: ui_gamemenu_unselect_entry();
   328D CD 9C 44      [17]  444 	call	_ui_gamemenu_unselect_entry
                            445 ;src/State_InGame.c:168: break;
   3290 18 22         [12]  446 	jr	00116$
                            447 ;src/State_InGame.c:170: case 4:{//TURN RIGHT
   3292                     448 00111$:
                            449 ;src/State_InGame.c:171: player_turn_right();
   3292 CD 1B 1A      [17]  450 	call	_player_turn_right
                            451 ;src/State_InGame.c:172: ui_gamemenu_update_action();
   3295 CD A7 45      [17]  452 	call	_ui_gamemenu_update_action
                            453 ;src/State_InGame.c:173: ui_gamemenu_unselect_entry();
   3298 CD 9C 44      [17]  454 	call	_ui_gamemenu_unselect_entry
                            455 ;src/State_InGame.c:175: updateRenderBuffer = 1;
   329B 21 29 87      [10]  456 	ld	hl,#_updateRenderBuffer + 0
   329E 36 01         [10]  457 	ld	(hl), #0x01
                            458 ;src/State_InGame.c:177: break;
   32A0 18 12         [12]  459 	jr	00116$
                            460 ;src/State_InGame.c:179: case 5:{//WAIT
   32A2                     461 00112$:
                            462 ;src/State_InGame.c:180: action=WAIT;
   32A2 21 2A 87      [10]  463 	ld	hl,#_action + 0
   32A5 36 04         [10]  464 	ld	(hl), #0x04
                            465 ;src/State_InGame.c:181: ui_gamemenu_unselect_entry();
   32A7 CD 9C 44      [17]  466 	call	_ui_gamemenu_unselect_entry
                            467 ;src/State_InGame.c:182: break;
   32AA 18 08         [12]  468 	jr	00116$
                            469 ;src/State_InGame.c:184: case 6:{//PAUSE
   32AC                     470 00113$:
                            471 ;src/State_InGame.c:185: statemanager_set_state(STATE_PAUSEMENU);
   32AC 3E 02         [ 7]  472 	ld	a,#0x02
   32AE F5            [11]  473 	push	af
   32AF 33            [ 6]  474 	inc	sp
   32B0 CD 01 3A      [17]  475 	call	_statemanager_set_state
   32B3 33            [ 6]  476 	inc	sp
                            477 ;src/State_InGame.c:188: }
   32B4                     478 00116$:
                            479 ;src/State_InGame.c:191: if(action!=NONE){
   32B4 3A 2A 87      [13]  480 	ld	a,(#_action + 0)
   32B7 B7            [ 4]  481 	or	a, a
   32B8 28 03         [12]  482 	jr	Z,00118$
                            483 ;src/State_InGame.c:192: state_ingame_update_turn();
   32BA CD F0 30      [17]  484 	call	_state_ingame_update_turn
   32BD                     485 00118$:
                            486 ;src/State_InGame.c:195: if(updateRenderBuffer){
   32BD 3A 29 87      [13]  487 	ld	a,(#_updateRenderBuffer + 0)
   32C0 B7            [ 4]  488 	or	a, a
   32C1 28 03         [12]  489 	jr	Z,00120$
                            490 ;src/State_InGame.c:196: state_ingame_update_buffers();
   32C3 CD 15 31      [17]  491 	call	_state_ingame_update_buffers
   32C6                     492 00120$:
                            493 ;src/State_InGame.c:198: action=NONE;
   32C6 21 2A 87      [10]  494 	ld	hl,#_action + 0
   32C9 36 00         [10]  495 	ld	(hl), #0x00
   32CB 33            [ 6]  496 	inc	sp
   32CC DD E1         [14]  497 	pop	ix
   32CE C9            [10]  498 	ret
                            499 ;src/State_InGame.c:202: void state_ingame_render(){
                            500 ;	---------------------------------
                            501 ; Function state_ingame_render
                            502 ; ---------------------------------
   32CF                     503 _state_ingame_render::
                            504 ;src/State_InGame.c:203: ui_gamemenu_render_refresh();
   32CF CD 1F 45      [17]  505 	call	_ui_gamemenu_render_refresh
                            506 ;src/State_InGame.c:204: renderCompass();
   32D2 CD AA 43      [17]  507 	call	_renderCompass
                            508 ;src/State_InGame.c:205: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   32D5 21 28 64      [10]  509 	ld	hl,#0x6428
   32D8 E5            [11]  510 	push	hl
   32D9 21 B4 C0      [10]  511 	ld	hl,#0xC0B4
   32DC E5            [11]  512 	push	hl
   32DD 21 50 AA      [10]  513 	ld	hl,#0xAA50
   32E0 E5            [11]  514 	push	hl
   32E1 CD 0B 83      [17]  515 	call	_cpct_drawSprite
                            516 ;src/State_InGame.c:206: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   32E4 21 10 40      [10]  517 	ld	hl,#0x4010
   32E7 E5            [11]  518 	push	hl
   32E8 21 20 C5      [10]  519 	ld	hl,#0xC520
   32EB E5            [11]  520 	push	hl
   32EC 21 F0 B9      [10]  521 	ld	hl,#0xB9F0
   32EF E5            [11]  522 	push	hl
   32F0 CD 0B 83      [17]  523 	call	_cpct_drawSprite
   32F3 C9            [10]  524 	ret
                            525 ;src/State_InGame.c:209: void state_ingame_exit(){
                            526 ;	---------------------------------
                            527 ; Function state_ingame_exit
                            528 ; ---------------------------------
   32F4                     529 _state_ingame_exit::
                            530 ;src/State_InGame.c:211: }
   32F4 C9            [10]  531 	ret
                            532 	.area _CODE
                            533 	.area _INITIALIZER
                            534 	.area _CABS (ABS)
