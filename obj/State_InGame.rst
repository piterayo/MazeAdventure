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
   7DAF                      66 _updateRenderBuffer::
   7DAF                      67 	.ds 1
   7DB0                      68 _action::
   7DB0                      69 	.ds 1
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
   2F91                      98 _state_ingame_enter::
                             99 ;src/State_InGame.c:38: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   2F91 21 B0 1A      [10]  100 	ld	hl, #(_g_colors + 0x0001) + 0
   2F94 46            [ 7]  101 	ld	b,(hl)
   2F95 21 00 40      [10]  102 	ld	hl,#0x4000
   2F98 E5            [11]  103 	push	hl
   2F99 C5            [11]  104 	push	bc
   2F9A 33            [ 6]  105 	inc	sp
   2F9B 26 C0         [ 7]  106 	ld	h, #0xC0
   2F9D E5            [11]  107 	push	hl
   2F9E CD 9A 7B      [17]  108 	call	_cpct_memset
                            109 ;src/State_InGame.c:40: ui_log_init();
   2FA1 CD 3F 47      [17]  110 	call	_ui_log_init
                            111 ;src/State_InGame.c:42: action=NONE;
   2FA4 21 B0 7D      [10]  112 	ld	hl,#_action + 0
   2FA7 36 00         [10]  113 	ld	(hl), #0x00
                            114 ;src/State_InGame.c:44: ui_gamemenu_init();
   2FA9 CD 78 42      [17]  115 	call	_ui_gamemenu_init
                            116 ;src/State_InGame.c:45: ui_gamemenu_render_all();
   2FAC CD F9 43      [17]  117 	call	_ui_gamemenu_render_all
                            118 ;src/State_InGame.c:46: ui_playerstats_render_all();
   2FAF CD E5 4B      [17]  119 	call	_ui_playerstats_render_all
                            120 ;src/State_InGame.c:47: ui_log_render();
   2FB2 CD CC 47      [17]  121 	call	_ui_log_render
                            122 ;src/State_InGame.c:48: state_ingame_render();
   2FB5 CD 98 31      [17]  123 	call	_state_ingame_render
   2FB8 C9            [10]  124 	ret
                            125 ;src/State_InGame.c:51: void state_ingame_update_turn(){
                            126 ;	---------------------------------
                            127 ; Function state_ingame_update_turn
                            128 ; ---------------------------------
   2FB9                     129 _state_ingame_update_turn::
                            130 ;src/State_InGame.c:52: enemy_update();
   2FB9 CD 6F 0B      [17]  131 	call	_enemy_update
                            132 ;src/State_InGame.c:53: if(level_get_level()!=KING_LEVEL) enemy_try_new_spawn();
   2FBC CD F0 0F      [17]  133 	call	_level_get_level
   2FBF 7D            [ 4]  134 	ld	a,l
   2FC0 D6 20         [ 7]  135 	sub	a, #0x20
   2FC2 28 03         [12]  136 	jr	Z,00102$
   2FC4 CD BC 03      [17]  137 	call	_enemy_try_new_spawn
   2FC7                     138 00102$:
                            139 ;src/State_InGame.c:54: ui_gamemenu_update_action();
   2FC7 CD 59 44      [17]  140 	call	_ui_gamemenu_update_action
                            141 ;src/State_InGame.c:56: if(player_is_dead){//Game over
   2FCA 3A 8E 7D      [13]  142 	ld	a,(#_player_is_dead + 0)
   2FCD B7            [ 4]  143 	or	a, a
   2FCE 28 08         [12]  144 	jr	Z,00104$
                            145 ;src/State_InGame.c:57: statemanager_set_state(STATE_GAMEOVER);
   2FD0 3E 05         [ 7]  146 	ld	a,#0x05
   2FD2 F5            [11]  147 	push	af
   2FD3 33            [ 6]  148 	inc	sp
   2FD4 CD BC 38      [17]  149 	call	_statemanager_set_state
   2FD7 33            [ 6]  150 	inc	sp
   2FD8                     151 00104$:
                            152 ;src/State_InGame.c:59: updateRenderBuffer = 1;
   2FD8 21 AF 7D      [10]  153 	ld	hl,#_updateRenderBuffer + 0
   2FDB 36 01         [10]  154 	ld	(hl), #0x01
   2FDD C9            [10]  155 	ret
                            156 ;src/State_InGame.c:62: void state_ingame_update_buffers(){
                            157 ;	---------------------------------
                            158 ; Function state_ingame_update_buffers
                            159 ; ---------------------------------
   2FDE                     160 _state_ingame_update_buffers::
                            161 ;src/State_InGame.c:63: render_draw_to_buffer();
   2FDE CD B2 1E      [17]  162 	call	_render_draw_to_buffer
                            163 ;src/State_InGame.c:64: draw_minimap_to_buffer();
   2FE1 C3 78 2A      [10]  164 	jp  _draw_minimap_to_buffer
                            165 ;src/State_InGame.c:67: void state_ingame_return(){
                            166 ;	---------------------------------
                            167 ; Function state_ingame_return
                            168 ; ---------------------------------
   2FE4                     169 _state_ingame_return::
                            170 ;src/State_InGame.c:68: if(state_inventory_object_used()){
   2FE4 CD F3 31      [17]  171 	call	_state_inventory_object_used
   2FE7 7D            [ 4]  172 	ld	a,l
   2FE8 B7            [ 4]  173 	or	a, a
   2FE9 28 06         [12]  174 	jr	Z,00102$
                            175 ;src/State_InGame.c:69: state_ingame_update_turn();
   2FEB CD B9 2F      [17]  176 	call	_state_ingame_update_turn
                            177 ;src/State_InGame.c:70: state_ingame_update_buffers();
   2FEE CD DE 2F      [17]  178 	call	_state_ingame_update_buffers
   2FF1                     179 00102$:
                            180 ;src/State_InGame.c:72: ui_gamemenu_unselect_entry();
   2FF1 CD 4E 43      [17]  181 	call	_ui_gamemenu_unselect_entry
                            182 ;src/State_InGame.c:73: ui_gamemenu_render_all();
   2FF4 CD F9 43      [17]  183 	call	_ui_gamemenu_render_all
                            184 ;src/State_InGame.c:74: ui_playerstats_render_all();
   2FF7 CD E5 4B      [17]  185 	call	_ui_playerstats_render_all
                            186 ;src/State_InGame.c:75: ui_log_render();
   2FFA CD CC 47      [17]  187 	call	_ui_log_render
                            188 ;src/State_InGame.c:76: state_ingame_render();
   2FFD C3 98 31      [10]  189 	jp  _state_ingame_render
                            190 ;src/State_InGame.c:79: void state_ingame_input(){
                            191 ;	---------------------------------
                            192 ; Function state_ingame_input
                            193 ; ---------------------------------
   3000                     194 _state_ingame_input::
                            195 ;src/State_InGame.c:81: if(cpct_isKeyPressed(Key_CursorLeft)){
   3000 21 01 01      [10]  196 	ld	hl,#0x0101
   3003 CD 65 79      [17]  197 	call	_cpct_isKeyPressed
   3006 7D            [ 4]  198 	ld	a,l
   3007 B7            [ 4]  199 	or	a, a
   3008 28 06         [12]  200 	jr	Z,00113$
                            201 ;src/State_InGame.c:82: ui_gamemenu_previous_entry();
   300A CD 3E 43      [17]  202 	call	_ui_gamemenu_previous_entry
                            203 ;src/State_InGame.c:83: statemanager_input_accepted();
   300D C3 B6 38      [10]  204 	jp  _statemanager_input_accepted
   3010                     205 00113$:
                            206 ;src/State_InGame.c:85: else if(cpct_isKeyPressed(Key_CursorRight)){
   3010 21 00 02      [10]  207 	ld	hl,#0x0200
   3013 CD 65 79      [17]  208 	call	_cpct_isKeyPressed
   3016 7D            [ 4]  209 	ld	a,l
   3017 B7            [ 4]  210 	or	a, a
   3018 28 06         [12]  211 	jr	Z,00110$
                            212 ;src/State_InGame.c:86: ui_gamemenu_next_entry();
   301A CD 31 43      [17]  213 	call	_ui_gamemenu_next_entry
                            214 ;src/State_InGame.c:87: statemanager_input_accepted();
   301D C3 B6 38      [10]  215 	jp  _statemanager_input_accepted
   3020                     216 00110$:
                            217 ;src/State_InGame.c:89: else if(cpct_isKeyPressed(Key_CursorUp)){
   3020 21 00 01      [10]  218 	ld	hl,#0x0100
   3023 CD 65 79      [17]  219 	call	_cpct_isKeyPressed
   3026 7D            [ 4]  220 	ld	a,l
   3027 B7            [ 4]  221 	or	a, a
   3028 28 06         [12]  222 	jr	Z,00107$
                            223 ;src/State_InGame.c:90: ui_gamemenu_above_entry();
   302A CD F9 42      [17]  224 	call	_ui_gamemenu_above_entry
                            225 ;src/State_InGame.c:91: statemanager_input_accepted();
   302D C3 B6 38      [10]  226 	jp  _statemanager_input_accepted
   3030                     227 00107$:
                            228 ;src/State_InGame.c:93: else if(cpct_isKeyPressed(Key_CursorDown)){
   3030 21 00 04      [10]  229 	ld	hl,#0x0400
   3033 CD 65 79      [17]  230 	call	_cpct_isKeyPressed
   3036 7D            [ 4]  231 	ld	a,l
   3037 B7            [ 4]  232 	or	a, a
   3038 28 06         [12]  233 	jr	Z,00104$
                            234 ;src/State_InGame.c:94: ui_gamemenu_below_entry();
   303A CD 1A 43      [17]  235 	call	_ui_gamemenu_below_entry
                            236 ;src/State_InGame.c:95: statemanager_input_accepted();
   303D C3 B6 38      [10]  237 	jp  _statemanager_input_accepted
   3040                     238 00104$:
                            239 ;src/State_InGame.c:97: else if(cpct_isKeyPressed(Key_Return)){
   3040 21 02 04      [10]  240 	ld	hl,#0x0402
   3043 CD 65 79      [17]  241 	call	_cpct_isKeyPressed
   3046 7D            [ 4]  242 	ld	a,l
   3047 B7            [ 4]  243 	or	a, a
   3048 C8            [11]  244 	ret	Z
                            245 ;src/State_InGame.c:98: ui_gamemenu_select_entry();
   3049 CD 54 43      [17]  246 	call	_ui_gamemenu_select_entry
                            247 ;src/State_InGame.c:99: statemanager_input_accepted();
   304C C3 B6 38      [10]  248 	jp  _statemanager_input_accepted
                            249 ;src/State_InGame.c:109: void state_ingame_update(){
                            250 ;	---------------------------------
                            251 ; Function state_ingame_update
                            252 ; ---------------------------------
   304F                     253 _state_ingame_update::
   304F DD E5         [15]  254 	push	ix
   3051 DD 21 00 00   [14]  255 	ld	ix,#0
   3055 DD 39         [15]  256 	add	ix,sp
   3057 3B            [ 6]  257 	dec	sp
                            258 ;src/State_InGame.c:110: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
   3058 21 75 18      [10]  259 	ld	hl,#_player_position+0
   305B 4E            [ 7]  260 	ld	c,(hl)
   305C 06 00         [ 7]  261 	ld	b,#0x00
   305E 3A 77 18      [13]  262 	ld	a, (#_player_direction + 0)
   3061 6F            [ 4]  263 	ld	l,a
   3062 17            [ 4]  264 	rla
   3063 9F            [ 4]  265 	sbc	a, a
   3064 67            [ 4]  266 	ld	h,a
   3065 09            [11]  267 	add	hl,bc
   3066 01 D0 88      [10]  268 	ld	bc,#0x88D0
   3069 09            [11]  269 	add	hl,bc
   306A 4D            [ 4]  270 	ld	c,l
   306B 44            [ 4]  271 	ld	b,h
   306C 21 76 18      [10]  272 	ld	hl,#_player_position+1
   306F 5E            [ 7]  273 	ld	e,(hl)
   3070 16 00         [ 7]  274 	ld	d,#0x00
   3072 3A 78 18      [13]  275 	ld	a, (#(_player_direction + 0x0001) + 0)
   3075 6F            [ 4]  276 	ld	l,a
   3076 17            [ 4]  277 	rla
   3077 9F            [ 4]  278 	sbc	a, a
   3078 67            [ 4]  279 	ld	h,a
   3079 19            [11]  280 	add	hl,de
   307A 29            [11]  281 	add	hl, hl
   307B 29            [11]  282 	add	hl, hl
   307C 29            [11]  283 	add	hl, hl
   307D 29            [11]  284 	add	hl, hl
   307E 29            [11]  285 	add	hl, hl
   307F 09            [11]  286 	add	hl,bc
   3080 7E            [ 7]  287 	ld	a,(hl)
   3081 DD 77 FF      [19]  288 	ld	-1 (ix),a
                            289 ;src/State_InGame.c:113: updateRenderBuffer=0;
   3084 21 AF 7D      [10]  290 	ld	hl,#_updateRenderBuffer + 0
   3087 36 00         [10]  291 	ld	(hl), #0x00
                            292 ;src/State_InGame.c:115: if(ui_gamemenu_is_selected()){
   3089 CD 51 44      [17]  293 	call	_ui_gamemenu_is_selected
   308C 7D            [ 4]  294 	ld	a,l
   308D B7            [ 4]  295 	or	a, a
   308E CA 7D 31      [10]  296 	jp	Z,00116$
                            297 ;src/State_InGame.c:116: ui_gamemenu_render_refresh();
   3091 CD D1 43      [17]  298 	call	_ui_gamemenu_render_refresh
                            299 ;src/State_InGame.c:117: switch(ui_gamemenu_get_entry()){
   3094 CD 49 44      [17]  300 	call	_ui_gamemenu_get_entry
   3097 5D            [ 4]  301 	ld	e,l
   3098 3E 06         [ 7]  302 	ld	a,#0x06
   309A 93            [ 4]  303 	sub	a, e
   309B DA 7D 31      [10]  304 	jp	C,00116$
   309E 16 00         [ 7]  305 	ld	d,#0x00
   30A0 21 A7 30      [10]  306 	ld	hl,#00151$
   30A3 19            [11]  307 	add	hl,de
   30A4 19            [11]  308 	add	hl,de
   30A5 19            [11]  309 	add	hl,de
   30A6 E9            [ 4]  310 	jp	(hl)
   30A7                     311 00151$:
   30A7 C3 BC 30      [10]  312 	jp	00101$
   30AA C3 2A 31      [10]  313 	jp	00106$
   30AD C3 34 31      [10]  314 	jp	00107$
   30B0 C3 44 31      [10]  315 	jp	00108$
   30B3 C3 5B 31      [10]  316 	jp	00111$
   30B6 C3 6B 31      [10]  317 	jp	00112$
   30B9 C3 75 31      [10]  318 	jp	00113$
                            319 ;src/State_InGame.c:118: case 0:{//ACTION BUTTON
   30BC                     320 00101$:
                            321 ;src/State_InGame.c:120: switch(ui_gamemenu_get_action()){
   30BC CD F2 44      [17]  322 	call	_ui_gamemenu_get_action
   30BF 5D            [ 4]  323 	ld	e,l
   30C0 7B            [ 4]  324 	ld	a,e
   30C1 D6 01         [ 7]  325 	sub	a, #0x01
   30C3 38 60         [12]  326 	jr	C,00105$
   30C5 3E 03         [ 7]  327 	ld	a,#0x03
   30C7 93            [ 4]  328 	sub	a, e
   30C8 38 5B         [12]  329 	jr	C,00105$
   30CA 1D            [ 4]  330 	dec	e
   30CB 16 00         [ 7]  331 	ld	d,#0x00
   30CD 21 D3 30      [10]  332 	ld	hl,#00152$
   30D0 19            [11]  333 	add	hl,de
   30D1 19            [11]  334 	add	hl,de
                            335 ;src/State_InGame.c:121: case 1:{
   30D2 E9            [ 4]  336 	jp	(hl)
   30D3                     337 00152$:
   30D3 18 04         [12]  338 	jr	00102$
   30D5 18 1A         [12]  339 	jr	00103$
   30D7 18 2E         [12]  340 	jr	00104$
   30D9                     341 00102$:
                            342 ;src/State_InGame.c:122: level_set_level(level_get_level()+1);
   30D9 CD F0 0F      [17]  343 	call	_level_get_level
   30DC 45            [ 4]  344 	ld	b,l
   30DD 04            [ 4]  345 	inc	b
   30DE C5            [11]  346 	push	bc
   30DF 33            [ 6]  347 	inc	sp
   30E0 CD 25 10      [17]  348 	call	_level_set_level
   30E3 33            [ 6]  349 	inc	sp
                            350 ;src/State_InGame.c:123: statemanager_close_state();
   30E4 CD 5F 39      [17]  351 	call	_statemanager_close_state
                            352 ;src/State_InGame.c:124: statemanager_set_state(STATE_LOADLEVEL);
   30E7 3E 03         [ 7]  353 	ld	a,#0x03
   30E9 F5            [11]  354 	push	af
   30EA 33            [ 6]  355 	inc	sp
   30EB CD BC 38      [17]  356 	call	_statemanager_set_state
   30EE 33            [ 6]  357 	inc	sp
                            358 ;src/State_InGame.c:126: break;
   30EF 18 34         [12]  359 	jr	00105$
                            360 ;src/State_InGame.c:128: case 2:{
   30F1                     361 00103$:
                            362 ;src/State_InGame.c:129: action=ATTACK;
   30F1 21 B0 7D      [10]  363 	ld	hl,#_action + 0
   30F4 36 02         [10]  364 	ld	(hl), #0x02
                            365 ;src/State_InGame.c:130: enemy_attack_enemy(enemy_get_at(forward-1));
   30F6 DD 46 FF      [19]  366 	ld	b,-1 (ix)
   30F9 05            [ 4]  367 	dec	b
   30FA C5            [11]  368 	push	bc
   30FB 33            [ 6]  369 	inc	sp
   30FC CD 40 00      [17]  370 	call	_enemy_get_at
   30FF 33            [ 6]  371 	inc	sp
   3100 E5            [11]  372 	push	hl
   3101 CD 4A 06      [17]  373 	call	_enemy_attack_enemy
   3104 F1            [10]  374 	pop	af
                            375 ;src/State_InGame.c:131: break;
   3105 18 1E         [12]  376 	jr	00105$
                            377 ;src/State_InGame.c:133: case 3:{
   3107                     378 00104$:
                            379 ;src/State_InGame.c:134: action=PICK_OBJECT;
   3107 21 B0 7D      [10]  380 	ld	hl,#_action + 0
   310A 36 03         [10]  381 	ld	(hl), #0x03
                            382 ;src/State_InGame.c:135: item_pick_item(item_get_at((forward)>>4)-1);
   310C DD 7E FF      [19]  383 	ld	a,-1 (ix)
   310F 07            [ 4]  384 	rlca
   3110 07            [ 4]  385 	rlca
   3111 07            [ 4]  386 	rlca
   3112 07            [ 4]  387 	rlca
   3113 E6 0F         [ 7]  388 	and	a,#0x0F
   3115 47            [ 4]  389 	ld	b,a
   3116 C5            [11]  390 	push	bc
   3117 33            [ 6]  391 	inc	sp
   3118 CD 00 0C      [17]  392 	call	_item_get_at
   311B 33            [ 6]  393 	inc	sp
   311C 01 FB FF      [10]  394 	ld	bc, #0xFFFB
   311F 09            [11]  395 	add	hl,bc
   3120 E5            [11]  396 	push	hl
   3121 CD 5E 0E      [17]  397 	call	_item_pick_item
   3124 F1            [10]  398 	pop	af
                            399 ;src/State_InGame.c:139: }
   3125                     400 00105$:
                            401 ;src/State_InGame.c:140: ui_gamemenu_unselect_entry();
   3125 CD 4E 43      [17]  402 	call	_ui_gamemenu_unselect_entry
                            403 ;src/State_InGame.c:141: break;
   3128 18 53         [12]  404 	jr	00116$
                            405 ;src/State_InGame.c:143: case 1:{//INVENTORY
   312A                     406 00106$:
                            407 ;src/State_InGame.c:145: statemanager_set_state(STATE_INVENTORY);                
   312A 3E 08         [ 7]  408 	ld	a,#0x08
   312C F5            [11]  409 	push	af
   312D 33            [ 6]  410 	inc	sp
   312E CD BC 38      [17]  411 	call	_statemanager_set_state
   3131 33            [ 6]  412 	inc	sp
                            413 ;src/State_InGame.c:147: break;
   3132 18 49         [12]  414 	jr	00116$
                            415 ;src/State_InGame.c:149: case 2:{//TURN LEFT
   3134                     416 00107$:
                            417 ;src/State_InGame.c:151: player_turn_left();
   3134 CD 79 18      [17]  418 	call	_player_turn_left
                            419 ;src/State_InGame.c:152: ui_gamemenu_update_action();
   3137 CD 59 44      [17]  420 	call	_ui_gamemenu_update_action
                            421 ;src/State_InGame.c:154: updateRenderBuffer = 1;
   313A 21 AF 7D      [10]  422 	ld	hl,#_updateRenderBuffer + 0
   313D 36 01         [10]  423 	ld	(hl), #0x01
                            424 ;src/State_InGame.c:155: ui_gamemenu_unselect_entry();
   313F CD 4E 43      [17]  425 	call	_ui_gamemenu_unselect_entry
                            426 ;src/State_InGame.c:156: break;
   3142 18 39         [12]  427 	jr	00116$
                            428 ;src/State_InGame.c:158: case 3:{//MOVE
   3144                     429 00108$:
                            430 ;src/State_InGame.c:159: if(ui_gamemenu_get_movement()){//BYPASS IF FOR NOCLIP
   3144 CD EA 44      [17]  431 	call	_ui_gamemenu_get_movement
   3147 7D            [ 4]  432 	ld	a,l
   3148 B7            [ 4]  433 	or	a, a
   3149 28 0B         [12]  434 	jr	Z,00110$
                            435 ;src/State_InGame.c:161: player_move_forward();
   314B CD CB 18      [17]  436 	call	_player_move_forward
                            437 ;src/State_InGame.c:162: ui_gamemenu_update_action();
   314E CD 59 44      [17]  438 	call	_ui_gamemenu_update_action
                            439 ;src/State_InGame.c:163: action=MOVE;
   3151 21 B0 7D      [10]  440 	ld	hl,#_action + 0
   3154 36 01         [10]  441 	ld	(hl), #0x01
   3156                     442 00110$:
                            443 ;src/State_InGame.c:167: ui_gamemenu_unselect_entry();
   3156 CD 4E 43      [17]  444 	call	_ui_gamemenu_unselect_entry
                            445 ;src/State_InGame.c:168: break;
   3159 18 22         [12]  446 	jr	00116$
                            447 ;src/State_InGame.c:170: case 4:{//TURN RIGHT
   315B                     448 00111$:
                            449 ;src/State_InGame.c:171: player_turn_right();
   315B CD A2 18      [17]  450 	call	_player_turn_right
                            451 ;src/State_InGame.c:172: ui_gamemenu_update_action();
   315E CD 59 44      [17]  452 	call	_ui_gamemenu_update_action
                            453 ;src/State_InGame.c:173: ui_gamemenu_unselect_entry();
   3161 CD 4E 43      [17]  454 	call	_ui_gamemenu_unselect_entry
                            455 ;src/State_InGame.c:175: updateRenderBuffer = 1;
   3164 21 AF 7D      [10]  456 	ld	hl,#_updateRenderBuffer + 0
   3167 36 01         [10]  457 	ld	(hl), #0x01
                            458 ;src/State_InGame.c:177: break;
   3169 18 12         [12]  459 	jr	00116$
                            460 ;src/State_InGame.c:179: case 5:{//WAIT
   316B                     461 00112$:
                            462 ;src/State_InGame.c:180: action=WAIT;
   316B 21 B0 7D      [10]  463 	ld	hl,#_action + 0
   316E 36 04         [10]  464 	ld	(hl), #0x04
                            465 ;src/State_InGame.c:181: ui_gamemenu_unselect_entry();
   3170 CD 4E 43      [17]  466 	call	_ui_gamemenu_unselect_entry
                            467 ;src/State_InGame.c:182: break;
   3173 18 08         [12]  468 	jr	00116$
                            469 ;src/State_InGame.c:184: case 6:{//PAUSE
   3175                     470 00113$:
                            471 ;src/State_InGame.c:185: statemanager_set_state(STATE_PAUSEMENU);
   3175 3E 02         [ 7]  472 	ld	a,#0x02
   3177 F5            [11]  473 	push	af
   3178 33            [ 6]  474 	inc	sp
   3179 CD BC 38      [17]  475 	call	_statemanager_set_state
   317C 33            [ 6]  476 	inc	sp
                            477 ;src/State_InGame.c:188: }
   317D                     478 00116$:
                            479 ;src/State_InGame.c:191: if(action!=NONE){
   317D 3A B0 7D      [13]  480 	ld	a,(#_action + 0)
   3180 B7            [ 4]  481 	or	a, a
   3181 28 03         [12]  482 	jr	Z,00118$
                            483 ;src/State_InGame.c:192: state_ingame_update_turn();
   3183 CD B9 2F      [17]  484 	call	_state_ingame_update_turn
   3186                     485 00118$:
                            486 ;src/State_InGame.c:195: if(updateRenderBuffer){
   3186 3A AF 7D      [13]  487 	ld	a,(#_updateRenderBuffer + 0)
   3189 B7            [ 4]  488 	or	a, a
   318A 28 03         [12]  489 	jr	Z,00120$
                            490 ;src/State_InGame.c:196: state_ingame_update_buffers();
   318C CD DE 2F      [17]  491 	call	_state_ingame_update_buffers
   318F                     492 00120$:
                            493 ;src/State_InGame.c:198: action=NONE;
   318F 21 B0 7D      [10]  494 	ld	hl,#_action + 0
   3192 36 00         [10]  495 	ld	(hl), #0x00
   3194 33            [ 6]  496 	inc	sp
   3195 DD E1         [14]  497 	pop	ix
   3197 C9            [10]  498 	ret
                            499 ;src/State_InGame.c:202: void state_ingame_render(){
                            500 ;	---------------------------------
                            501 ; Function state_ingame_render
                            502 ; ---------------------------------
   3198                     503 _state_ingame_render::
                            504 ;src/State_InGame.c:203: ui_gamemenu_render_refresh();
   3198 CD D1 43      [17]  505 	call	_ui_gamemenu_render_refresh
                            506 ;src/State_InGame.c:204: renderCompass();
   319B CD 5C 42      [17]  507 	call	_renderCompass
                            508 ;src/State_InGame.c:205: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   319E 21 28 64      [10]  509 	ld	hl,#0x6428
   31A1 E5            [11]  510 	push	hl
   31A2 21 B4 C0      [10]  511 	ld	hl,#0xC0B4
   31A5 E5            [11]  512 	push	hl
   31A6 21 50 AA      [10]  513 	ld	hl,#0xAA50
   31A9 E5            [11]  514 	push	hl
   31AA CD 94 79      [17]  515 	call	_cpct_drawSprite
                            516 ;src/State_InGame.c:206: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   31AD 21 10 40      [10]  517 	ld	hl,#0x4010
   31B0 E5            [11]  518 	push	hl
   31B1 21 20 C5      [10]  519 	ld	hl,#0xC520
   31B4 E5            [11]  520 	push	hl
   31B5 21 F0 B9      [10]  521 	ld	hl,#0xB9F0
   31B8 E5            [11]  522 	push	hl
   31B9 CD 94 79      [17]  523 	call	_cpct_drawSprite
   31BC C9            [10]  524 	ret
                            525 ;src/State_InGame.c:209: void state_ingame_exit(){
                            526 ;	---------------------------------
                            527 ; Function state_ingame_exit
                            528 ; ---------------------------------
   31BD                     529 _state_ingame_exit::
                            530 ;src/State_InGame.c:211: }
   31BD C9            [10]  531 	ret
                            532 	.area _CODE
                            533 	.area _INITIALIZER
                            534 	.area _CABS (ABS)
