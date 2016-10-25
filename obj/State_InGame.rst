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
   7D89                      66 _updateRenderBuffer::
   7D89                      67 	.ds 1
   7D8A                      68 _action::
   7D8A                      69 	.ds 1
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
   2F48                      98 _state_ingame_enter::
                             99 ;src/State_InGame.c:38: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   2F48 21 67 1A      [10]  100 	ld	hl, #(_g_colors + 0x0001) + 0
   2F4B 46            [ 7]  101 	ld	b,(hl)
   2F4C 21 00 40      [10]  102 	ld	hl,#0x4000
   2F4F E5            [11]  103 	push	hl
   2F50 C5            [11]  104 	push	bc
   2F51 33            [ 6]  105 	inc	sp
   2F52 26 C0         [ 7]  106 	ld	h, #0xC0
   2F54 E5            [11]  107 	push	hl
   2F55 CD 74 7B      [17]  108 	call	_cpct_memset
                            109 ;src/State_InGame.c:40: ui_log_init();
   2F58 CD 19 47      [17]  110 	call	_ui_log_init
                            111 ;src/State_InGame.c:42: action=NONE;
   2F5B 21 8A 7D      [10]  112 	ld	hl,#_action + 0
   2F5E 36 00         [10]  113 	ld	(hl), #0x00
                            114 ;src/State_InGame.c:44: ui_gamemenu_init();
   2F60 CD 52 42      [17]  115 	call	_ui_gamemenu_init
                            116 ;src/State_InGame.c:45: ui_gamemenu_render_all();
   2F63 CD D3 43      [17]  117 	call	_ui_gamemenu_render_all
                            118 ;src/State_InGame.c:46: ui_playerstats_render_all();
   2F66 CD BF 4B      [17]  119 	call	_ui_playerstats_render_all
                            120 ;src/State_InGame.c:47: ui_log_render();
   2F69 CD A6 47      [17]  121 	call	_ui_log_render
                            122 ;src/State_InGame.c:48: state_ingame_render();
   2F6C CD 72 31      [17]  123 	call	_state_ingame_render
   2F6F C9            [10]  124 	ret
                            125 ;src/State_InGame.c:51: void state_ingame_update_turn(){
                            126 ;	---------------------------------
                            127 ; Function state_ingame_update_turn
                            128 ; ---------------------------------
   2F70                     129 _state_ingame_update_turn::
                            130 ;src/State_InGame.c:52: enemy_update();
   2F70 CD 6F 0B      [17]  131 	call	_enemy_update
                            132 ;src/State_InGame.c:53: if(level_get_level()!=KING_LEVEL) enemy_try_new_spawn();
   2F73 CD A7 0F      [17]  133 	call	_level_get_level
   2F76 7D            [ 4]  134 	ld	a,l
   2F77 D6 20         [ 7]  135 	sub	a, #0x20
   2F79 28 03         [12]  136 	jr	Z,00102$
   2F7B CD BC 03      [17]  137 	call	_enemy_try_new_spawn
   2F7E                     138 00102$:
                            139 ;src/State_InGame.c:54: ui_gamemenu_update_action();
   2F7E CD 33 44      [17]  140 	call	_ui_gamemenu_update_action
                            141 ;src/State_InGame.c:56: if(player_is_dead){//Game over
   2F81 3A 68 7D      [13]  142 	ld	a,(#_player_is_dead + 0)
   2F84 B7            [ 4]  143 	or	a, a
   2F85 28 08         [12]  144 	jr	Z,00104$
                            145 ;src/State_InGame.c:57: statemanager_set_state(STATE_GAMEOVER);
   2F87 3E 05         [ 7]  146 	ld	a,#0x05
   2F89 F5            [11]  147 	push	af
   2F8A 33            [ 6]  148 	inc	sp
   2F8B CD 96 38      [17]  149 	call	_statemanager_set_state
   2F8E 33            [ 6]  150 	inc	sp
   2F8F                     151 00104$:
                            152 ;src/State_InGame.c:59: updateRenderBuffer = 1;
   2F8F 21 89 7D      [10]  153 	ld	hl,#_updateRenderBuffer + 0
   2F92 36 01         [10]  154 	ld	(hl), #0x01
   2F94 C9            [10]  155 	ret
                            156 ;src/State_InGame.c:62: void state_ingame_update_buffers(){
                            157 ;	---------------------------------
                            158 ; Function state_ingame_update_buffers
                            159 ; ---------------------------------
   2F95                     160 _state_ingame_update_buffers::
                            161 ;src/State_InGame.c:63: render_draw_to_buffer();
   2F95 CD 69 1E      [17]  162 	call	_render_draw_to_buffer
                            163 ;src/State_InGame.c:64: draw_minimap_to_buffer();
   2F98 C3 2F 2A      [10]  164 	jp  _draw_minimap_to_buffer
                            165 ;src/State_InGame.c:67: void state_ingame_return(){
                            166 ;	---------------------------------
                            167 ; Function state_ingame_return
                            168 ; ---------------------------------
   2F9B                     169 _state_ingame_return::
                            170 ;src/State_InGame.c:68: if(state_inventory_object_used()){
   2F9B CD CD 31      [17]  171 	call	_state_inventory_object_used
   2F9E 7D            [ 4]  172 	ld	a,l
   2F9F B7            [ 4]  173 	or	a, a
   2FA0 28 06         [12]  174 	jr	Z,00102$
                            175 ;src/State_InGame.c:69: state_ingame_update_turn();
   2FA2 CD 70 2F      [17]  176 	call	_state_ingame_update_turn
                            177 ;src/State_InGame.c:70: state_ingame_update_buffers();
   2FA5 CD 95 2F      [17]  178 	call	_state_ingame_update_buffers
   2FA8                     179 00102$:
                            180 ;src/State_InGame.c:72: ui_gamemenu_unselect_entry();
   2FA8 CD 28 43      [17]  181 	call	_ui_gamemenu_unselect_entry
                            182 ;src/State_InGame.c:73: ui_gamemenu_render_all();
   2FAB CD D3 43      [17]  183 	call	_ui_gamemenu_render_all
                            184 ;src/State_InGame.c:74: ui_playerstats_render_all();
   2FAE CD BF 4B      [17]  185 	call	_ui_playerstats_render_all
                            186 ;src/State_InGame.c:75: ui_log_render();
   2FB1 CD A6 47      [17]  187 	call	_ui_log_render
                            188 ;src/State_InGame.c:76: state_ingame_render();
   2FB4 C3 72 31      [10]  189 	jp  _state_ingame_render
                            190 ;src/State_InGame.c:79: void state_ingame_input(){
                            191 ;	---------------------------------
                            192 ; Function state_ingame_input
                            193 ; ---------------------------------
   2FB7                     194 _state_ingame_input::
                            195 ;src/State_InGame.c:81: if(cpct_isKeyPressed(Key_CursorLeft)){
   2FB7 21 01 01      [10]  196 	ld	hl,#0x0101
   2FBA CD 3F 79      [17]  197 	call	_cpct_isKeyPressed
   2FBD 7D            [ 4]  198 	ld	a,l
   2FBE B7            [ 4]  199 	or	a, a
   2FBF 28 06         [12]  200 	jr	Z,00116$
                            201 ;src/State_InGame.c:82: ui_gamemenu_previous_entry();
   2FC1 CD 18 43      [17]  202 	call	_ui_gamemenu_previous_entry
                            203 ;src/State_InGame.c:83: statemanager_input_accepted();
   2FC4 C3 90 38      [10]  204 	jp  _statemanager_input_accepted
   2FC7                     205 00116$:
                            206 ;src/State_InGame.c:85: else if(cpct_isKeyPressed(Key_CursorRight)){
   2FC7 21 00 02      [10]  207 	ld	hl,#0x0200
   2FCA CD 3F 79      [17]  208 	call	_cpct_isKeyPressed
   2FCD 7D            [ 4]  209 	ld	a,l
   2FCE B7            [ 4]  210 	or	a, a
   2FCF 28 06         [12]  211 	jr	Z,00113$
                            212 ;src/State_InGame.c:86: ui_gamemenu_next_entry();
   2FD1 CD 0B 43      [17]  213 	call	_ui_gamemenu_next_entry
                            214 ;src/State_InGame.c:87: statemanager_input_accepted();
   2FD4 C3 90 38      [10]  215 	jp  _statemanager_input_accepted
   2FD7                     216 00113$:
                            217 ;src/State_InGame.c:89: else if(cpct_isKeyPressed(Key_CursorUp)){
   2FD7 21 00 01      [10]  218 	ld	hl,#0x0100
   2FDA CD 3F 79      [17]  219 	call	_cpct_isKeyPressed
   2FDD 7D            [ 4]  220 	ld	a,l
   2FDE B7            [ 4]  221 	or	a, a
   2FDF 28 06         [12]  222 	jr	Z,00110$
                            223 ;src/State_InGame.c:90: ui_gamemenu_above_entry();
   2FE1 CD D3 42      [17]  224 	call	_ui_gamemenu_above_entry
                            225 ;src/State_InGame.c:91: statemanager_input_accepted();
   2FE4 C3 90 38      [10]  226 	jp  _statemanager_input_accepted
   2FE7                     227 00110$:
                            228 ;src/State_InGame.c:93: else if(cpct_isKeyPressed(Key_CursorDown)){
   2FE7 21 00 04      [10]  229 	ld	hl,#0x0400
   2FEA CD 3F 79      [17]  230 	call	_cpct_isKeyPressed
   2FED 7D            [ 4]  231 	ld	a,l
   2FEE B7            [ 4]  232 	or	a, a
   2FEF 28 06         [12]  233 	jr	Z,00107$
                            234 ;src/State_InGame.c:94: ui_gamemenu_below_entry();
   2FF1 CD F4 42      [17]  235 	call	_ui_gamemenu_below_entry
                            236 ;src/State_InGame.c:95: statemanager_input_accepted();
   2FF4 C3 90 38      [10]  237 	jp  _statemanager_input_accepted
   2FF7                     238 00107$:
                            239 ;src/State_InGame.c:97: else if(cpct_isKeyPressed(Key_Return)){
   2FF7 21 02 04      [10]  240 	ld	hl,#0x0402
   2FFA CD 3F 79      [17]  241 	call	_cpct_isKeyPressed
   2FFD 7D            [ 4]  242 	ld	a,l
   2FFE B7            [ 4]  243 	or	a, a
   2FFF 28 06         [12]  244 	jr	Z,00104$
                            245 ;src/State_InGame.c:98: ui_gamemenu_select_entry();
   3001 CD 2E 43      [17]  246 	call	_ui_gamemenu_select_entry
                            247 ;src/State_InGame.c:99: statemanager_input_accepted();
   3004 C3 90 38      [10]  248 	jp  _statemanager_input_accepted
   3007                     249 00104$:
                            250 ;src/State_InGame.c:101: else if(cpct_isKeyPressed(Key_Tab)){
   3007 21 08 10      [10]  251 	ld	hl,#0x1008
   300A CD 3F 79      [17]  252 	call	_cpct_isKeyPressed
   300D 7D            [ 4]  253 	ld	a,l
   300E B7            [ 4]  254 	or	a, a
   300F C8            [11]  255 	ret	Z
                            256 ;src/State_InGame.c:102: level_set_level(level_get_level()+1);
   3010 CD A7 0F      [17]  257 	call	_level_get_level
   3013 45            [ 4]  258 	ld	b,l
   3014 04            [ 4]  259 	inc	b
   3015 C5            [11]  260 	push	bc
   3016 33            [ 6]  261 	inc	sp
   3017 CD DC 0F      [17]  262 	call	_level_set_level
   301A 33            [ 6]  263 	inc	sp
                            264 ;src/State_InGame.c:103: statemanager_close_state();
   301B CD 39 39      [17]  265 	call	_statemanager_close_state
                            266 ;src/State_InGame.c:104: statemanager_set_state(STATE_LOADLEVEL);
   301E 3E 03         [ 7]  267 	ld	a,#0x03
   3020 F5            [11]  268 	push	af
   3021 33            [ 6]  269 	inc	sp
   3022 CD 96 38      [17]  270 	call	_statemanager_set_state
   3025 33            [ 6]  271 	inc	sp
                            272 ;src/State_InGame.c:105: statemanager_input_accepted();
   3026 C3 90 38      [10]  273 	jp  _statemanager_input_accepted
                            274 ;src/State_InGame.c:109: void state_ingame_update(){
                            275 ;	---------------------------------
                            276 ; Function state_ingame_update
                            277 ; ---------------------------------
   3029                     278 _state_ingame_update::
   3029 DD E5         [15]  279 	push	ix
   302B DD 21 00 00   [14]  280 	ld	ix,#0
   302F DD 39         [15]  281 	add	ix,sp
   3031 3B            [ 6]  282 	dec	sp
                            283 ;src/State_InGame.c:110: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
   3032 21 2C 18      [10]  284 	ld	hl,#_player_position+0
   3035 4E            [ 7]  285 	ld	c,(hl)
   3036 06 00         [ 7]  286 	ld	b,#0x00
   3038 3A 2E 18      [13]  287 	ld	a, (#_player_direction + 0)
   303B 6F            [ 4]  288 	ld	l,a
   303C 17            [ 4]  289 	rla
   303D 9F            [ 4]  290 	sbc	a, a
   303E 67            [ 4]  291 	ld	h,a
   303F 09            [11]  292 	add	hl,bc
   3040 01 D0 88      [10]  293 	ld	bc,#0x88D0
   3043 09            [11]  294 	add	hl,bc
   3044 4D            [ 4]  295 	ld	c,l
   3045 44            [ 4]  296 	ld	b,h
   3046 21 2D 18      [10]  297 	ld	hl,#_player_position+1
   3049 5E            [ 7]  298 	ld	e,(hl)
   304A 16 00         [ 7]  299 	ld	d,#0x00
   304C 3A 2F 18      [13]  300 	ld	a, (#(_player_direction + 0x0001) + 0)
   304F 6F            [ 4]  301 	ld	l,a
   3050 17            [ 4]  302 	rla
   3051 9F            [ 4]  303 	sbc	a, a
   3052 67            [ 4]  304 	ld	h,a
   3053 19            [11]  305 	add	hl,de
   3054 29            [11]  306 	add	hl, hl
   3055 29            [11]  307 	add	hl, hl
   3056 29            [11]  308 	add	hl, hl
   3057 29            [11]  309 	add	hl, hl
   3058 29            [11]  310 	add	hl, hl
   3059 09            [11]  311 	add	hl,bc
   305A 7E            [ 7]  312 	ld	a,(hl)
   305B DD 77 FF      [19]  313 	ld	-1 (ix),a
                            314 ;src/State_InGame.c:113: updateRenderBuffer=0;
   305E 21 89 7D      [10]  315 	ld	hl,#_updateRenderBuffer + 0
   3061 36 00         [10]  316 	ld	(hl), #0x00
                            317 ;src/State_InGame.c:115: if(ui_gamemenu_is_selected()){
   3063 CD 2B 44      [17]  318 	call	_ui_gamemenu_is_selected
   3066 7D            [ 4]  319 	ld	a,l
   3067 B7            [ 4]  320 	or	a, a
   3068 CA 57 31      [10]  321 	jp	Z,00116$
                            322 ;src/State_InGame.c:116: ui_gamemenu_render_refresh();
   306B CD AB 43      [17]  323 	call	_ui_gamemenu_render_refresh
                            324 ;src/State_InGame.c:117: switch(ui_gamemenu_get_entry()){
   306E CD 23 44      [17]  325 	call	_ui_gamemenu_get_entry
   3071 5D            [ 4]  326 	ld	e,l
   3072 3E 06         [ 7]  327 	ld	a,#0x06
   3074 93            [ 4]  328 	sub	a, e
   3075 DA 57 31      [10]  329 	jp	C,00116$
   3078 16 00         [ 7]  330 	ld	d,#0x00
   307A 21 81 30      [10]  331 	ld	hl,#00151$
   307D 19            [11]  332 	add	hl,de
   307E 19            [11]  333 	add	hl,de
   307F 19            [11]  334 	add	hl,de
   3080 E9            [ 4]  335 	jp	(hl)
   3081                     336 00151$:
   3081 C3 96 30      [10]  337 	jp	00101$
   3084 C3 04 31      [10]  338 	jp	00106$
   3087 C3 0E 31      [10]  339 	jp	00107$
   308A C3 1E 31      [10]  340 	jp	00108$
   308D C3 35 31      [10]  341 	jp	00111$
   3090 C3 45 31      [10]  342 	jp	00112$
   3093 C3 4F 31      [10]  343 	jp	00113$
                            344 ;src/State_InGame.c:118: case 0:{//ACTION BUTTON
   3096                     345 00101$:
                            346 ;src/State_InGame.c:120: switch(ui_gamemenu_get_action()){
   3096 CD CC 44      [17]  347 	call	_ui_gamemenu_get_action
   3099 5D            [ 4]  348 	ld	e,l
   309A 7B            [ 4]  349 	ld	a,e
   309B D6 01         [ 7]  350 	sub	a, #0x01
   309D 38 60         [12]  351 	jr	C,00105$
   309F 3E 03         [ 7]  352 	ld	a,#0x03
   30A1 93            [ 4]  353 	sub	a, e
   30A2 38 5B         [12]  354 	jr	C,00105$
   30A4 1D            [ 4]  355 	dec	e
   30A5 16 00         [ 7]  356 	ld	d,#0x00
   30A7 21 AD 30      [10]  357 	ld	hl,#00152$
   30AA 19            [11]  358 	add	hl,de
   30AB 19            [11]  359 	add	hl,de
                            360 ;src/State_InGame.c:121: case 1:{
   30AC E9            [ 4]  361 	jp	(hl)
   30AD                     362 00152$:
   30AD 18 04         [12]  363 	jr	00102$
   30AF 18 1A         [12]  364 	jr	00103$
   30B1 18 2E         [12]  365 	jr	00104$
   30B3                     366 00102$:
                            367 ;src/State_InGame.c:122: level_set_level(level_get_level()+1);
   30B3 CD A7 0F      [17]  368 	call	_level_get_level
   30B6 45            [ 4]  369 	ld	b,l
   30B7 04            [ 4]  370 	inc	b
   30B8 C5            [11]  371 	push	bc
   30B9 33            [ 6]  372 	inc	sp
   30BA CD DC 0F      [17]  373 	call	_level_set_level
   30BD 33            [ 6]  374 	inc	sp
                            375 ;src/State_InGame.c:123: statemanager_close_state();
   30BE CD 39 39      [17]  376 	call	_statemanager_close_state
                            377 ;src/State_InGame.c:124: statemanager_set_state(STATE_LOADLEVEL);
   30C1 3E 03         [ 7]  378 	ld	a,#0x03
   30C3 F5            [11]  379 	push	af
   30C4 33            [ 6]  380 	inc	sp
   30C5 CD 96 38      [17]  381 	call	_statemanager_set_state
   30C8 33            [ 6]  382 	inc	sp
                            383 ;src/State_InGame.c:126: break;
   30C9 18 34         [12]  384 	jr	00105$
                            385 ;src/State_InGame.c:128: case 2:{
   30CB                     386 00103$:
                            387 ;src/State_InGame.c:129: action=ATTACK;
   30CB 21 8A 7D      [10]  388 	ld	hl,#_action + 0
   30CE 36 02         [10]  389 	ld	(hl), #0x02
                            390 ;src/State_InGame.c:130: enemy_attack_enemy(enemy_get_at(forward-1));
   30D0 DD 46 FF      [19]  391 	ld	b,-1 (ix)
   30D3 05            [ 4]  392 	dec	b
   30D4 C5            [11]  393 	push	bc
   30D5 33            [ 6]  394 	inc	sp
   30D6 CD 40 00      [17]  395 	call	_enemy_get_at
   30D9 33            [ 6]  396 	inc	sp
   30DA E5            [11]  397 	push	hl
   30DB CD 4A 06      [17]  398 	call	_enemy_attack_enemy
   30DE F1            [10]  399 	pop	af
                            400 ;src/State_InGame.c:131: break;
   30DF 18 1E         [12]  401 	jr	00105$
                            402 ;src/State_InGame.c:133: case 3:{
   30E1                     403 00104$:
                            404 ;src/State_InGame.c:134: action=PICK_OBJECT;
   30E1 21 8A 7D      [10]  405 	ld	hl,#_action + 0
   30E4 36 03         [10]  406 	ld	(hl), #0x03
                            407 ;src/State_InGame.c:135: item_pick_item(item_get_at((forward)>>4)-1);
   30E6 DD 7E FF      [19]  408 	ld	a,-1 (ix)
   30E9 07            [ 4]  409 	rlca
   30EA 07            [ 4]  410 	rlca
   30EB 07            [ 4]  411 	rlca
   30EC 07            [ 4]  412 	rlca
   30ED E6 0F         [ 7]  413 	and	a,#0x0F
   30EF 47            [ 4]  414 	ld	b,a
   30F0 C5            [11]  415 	push	bc
   30F1 33            [ 6]  416 	inc	sp
   30F2 CD 00 0C      [17]  417 	call	_item_get_at
   30F5 33            [ 6]  418 	inc	sp
   30F6 01 FB FF      [10]  419 	ld	bc, #0xFFFB
   30F9 09            [11]  420 	add	hl,bc
   30FA E5            [11]  421 	push	hl
   30FB CD 15 0E      [17]  422 	call	_item_pick_item
   30FE F1            [10]  423 	pop	af
                            424 ;src/State_InGame.c:139: }
   30FF                     425 00105$:
                            426 ;src/State_InGame.c:140: ui_gamemenu_unselect_entry();
   30FF CD 28 43      [17]  427 	call	_ui_gamemenu_unselect_entry
                            428 ;src/State_InGame.c:141: break;
   3102 18 53         [12]  429 	jr	00116$
                            430 ;src/State_InGame.c:143: case 1:{//INVENTORY
   3104                     431 00106$:
                            432 ;src/State_InGame.c:145: statemanager_set_state(STATE_INVENTORY);                
   3104 3E 08         [ 7]  433 	ld	a,#0x08
   3106 F5            [11]  434 	push	af
   3107 33            [ 6]  435 	inc	sp
   3108 CD 96 38      [17]  436 	call	_statemanager_set_state
   310B 33            [ 6]  437 	inc	sp
                            438 ;src/State_InGame.c:147: break;
   310C 18 49         [12]  439 	jr	00116$
                            440 ;src/State_InGame.c:149: case 2:{//TURN LEFT
   310E                     441 00107$:
                            442 ;src/State_InGame.c:151: player_turn_left();
   310E CD 30 18      [17]  443 	call	_player_turn_left
                            444 ;src/State_InGame.c:152: ui_gamemenu_update_action();
   3111 CD 33 44      [17]  445 	call	_ui_gamemenu_update_action
                            446 ;src/State_InGame.c:154: updateRenderBuffer = 1;
   3114 21 89 7D      [10]  447 	ld	hl,#_updateRenderBuffer + 0
   3117 36 01         [10]  448 	ld	(hl), #0x01
                            449 ;src/State_InGame.c:155: ui_gamemenu_unselect_entry();
   3119 CD 28 43      [17]  450 	call	_ui_gamemenu_unselect_entry
                            451 ;src/State_InGame.c:156: break;
   311C 18 39         [12]  452 	jr	00116$
                            453 ;src/State_InGame.c:158: case 3:{//MOVE
   311E                     454 00108$:
                            455 ;src/State_InGame.c:159: if(ui_gamemenu_get_movement()){//BYPASS IF FOR NOCLIP
   311E CD C4 44      [17]  456 	call	_ui_gamemenu_get_movement
   3121 7D            [ 4]  457 	ld	a,l
   3122 B7            [ 4]  458 	or	a, a
   3123 28 0B         [12]  459 	jr	Z,00110$
                            460 ;src/State_InGame.c:161: player_move_forward();
   3125 CD 82 18      [17]  461 	call	_player_move_forward
                            462 ;src/State_InGame.c:162: ui_gamemenu_update_action();
   3128 CD 33 44      [17]  463 	call	_ui_gamemenu_update_action
                            464 ;src/State_InGame.c:163: action=MOVE;
   312B 21 8A 7D      [10]  465 	ld	hl,#_action + 0
   312E 36 01         [10]  466 	ld	(hl), #0x01
   3130                     467 00110$:
                            468 ;src/State_InGame.c:167: ui_gamemenu_unselect_entry();
   3130 CD 28 43      [17]  469 	call	_ui_gamemenu_unselect_entry
                            470 ;src/State_InGame.c:168: break;
   3133 18 22         [12]  471 	jr	00116$
                            472 ;src/State_InGame.c:170: case 4:{//TURN RIGHT
   3135                     473 00111$:
                            474 ;src/State_InGame.c:171: player_turn_right();
   3135 CD 59 18      [17]  475 	call	_player_turn_right
                            476 ;src/State_InGame.c:172: ui_gamemenu_update_action();
   3138 CD 33 44      [17]  477 	call	_ui_gamemenu_update_action
                            478 ;src/State_InGame.c:173: ui_gamemenu_unselect_entry();
   313B CD 28 43      [17]  479 	call	_ui_gamemenu_unselect_entry
                            480 ;src/State_InGame.c:175: updateRenderBuffer = 1;
   313E 21 89 7D      [10]  481 	ld	hl,#_updateRenderBuffer + 0
   3141 36 01         [10]  482 	ld	(hl), #0x01
                            483 ;src/State_InGame.c:177: break;
   3143 18 12         [12]  484 	jr	00116$
                            485 ;src/State_InGame.c:179: case 5:{//WAIT
   3145                     486 00112$:
                            487 ;src/State_InGame.c:180: action=WAIT;
   3145 21 8A 7D      [10]  488 	ld	hl,#_action + 0
   3148 36 04         [10]  489 	ld	(hl), #0x04
                            490 ;src/State_InGame.c:181: ui_gamemenu_unselect_entry();
   314A CD 28 43      [17]  491 	call	_ui_gamemenu_unselect_entry
                            492 ;src/State_InGame.c:182: break;
   314D 18 08         [12]  493 	jr	00116$
                            494 ;src/State_InGame.c:184: case 6:{//PAUSE
   314F                     495 00113$:
                            496 ;src/State_InGame.c:185: statemanager_set_state(STATE_PAUSEMENU);
   314F 3E 02         [ 7]  497 	ld	a,#0x02
   3151 F5            [11]  498 	push	af
   3152 33            [ 6]  499 	inc	sp
   3153 CD 96 38      [17]  500 	call	_statemanager_set_state
   3156 33            [ 6]  501 	inc	sp
                            502 ;src/State_InGame.c:188: }
   3157                     503 00116$:
                            504 ;src/State_InGame.c:191: if(action!=NONE){
   3157 3A 8A 7D      [13]  505 	ld	a,(#_action + 0)
   315A B7            [ 4]  506 	or	a, a
   315B 28 03         [12]  507 	jr	Z,00118$
                            508 ;src/State_InGame.c:192: state_ingame_update_turn();
   315D CD 70 2F      [17]  509 	call	_state_ingame_update_turn
   3160                     510 00118$:
                            511 ;src/State_InGame.c:195: if(updateRenderBuffer){
   3160 3A 89 7D      [13]  512 	ld	a,(#_updateRenderBuffer + 0)
   3163 B7            [ 4]  513 	or	a, a
   3164 28 03         [12]  514 	jr	Z,00120$
                            515 ;src/State_InGame.c:196: state_ingame_update_buffers();
   3166 CD 95 2F      [17]  516 	call	_state_ingame_update_buffers
   3169                     517 00120$:
                            518 ;src/State_InGame.c:198: action=NONE;
   3169 21 8A 7D      [10]  519 	ld	hl,#_action + 0
   316C 36 00         [10]  520 	ld	(hl), #0x00
   316E 33            [ 6]  521 	inc	sp
   316F DD E1         [14]  522 	pop	ix
   3171 C9            [10]  523 	ret
                            524 ;src/State_InGame.c:202: void state_ingame_render(){
                            525 ;	---------------------------------
                            526 ; Function state_ingame_render
                            527 ; ---------------------------------
   3172                     528 _state_ingame_render::
                            529 ;src/State_InGame.c:203: ui_gamemenu_render_refresh();
   3172 CD AB 43      [17]  530 	call	_ui_gamemenu_render_refresh
                            531 ;src/State_InGame.c:204: renderCompass();
   3175 CD 36 42      [17]  532 	call	_renderCompass
                            533 ;src/State_InGame.c:205: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   3178 21 28 64      [10]  534 	ld	hl,#0x6428
   317B E5            [11]  535 	push	hl
   317C 21 B4 C0      [10]  536 	ld	hl,#0xC0B4
   317F E5            [11]  537 	push	hl
   3180 21 50 AA      [10]  538 	ld	hl,#0xAA50
   3183 E5            [11]  539 	push	hl
   3184 CD 6E 79      [17]  540 	call	_cpct_drawSprite
                            541 ;src/State_InGame.c:206: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   3187 21 10 40      [10]  542 	ld	hl,#0x4010
   318A E5            [11]  543 	push	hl
   318B 21 20 C5      [10]  544 	ld	hl,#0xC520
   318E E5            [11]  545 	push	hl
   318F 21 F0 B9      [10]  546 	ld	hl,#0xB9F0
   3192 E5            [11]  547 	push	hl
   3193 CD 6E 79      [17]  548 	call	_cpct_drawSprite
   3196 C9            [10]  549 	ret
                            550 ;src/State_InGame.c:209: void state_ingame_exit(){
                            551 ;	---------------------------------
                            552 ; Function state_ingame_exit
                            553 ; ---------------------------------
   3197                     554 _state_ingame_exit::
                            555 ;src/State_InGame.c:211: }
   3197 C9            [10]  556 	ret
                            557 	.area _CODE
                            558 	.area _INITIALIZER
                            559 	.area _CABS (ABS)
