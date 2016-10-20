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
                             11 	.globl _ui_playerstats_render
                             12 	.globl _ui_gamemenu_render_refresh
                             13 	.globl _ui_gamemenu_render_all
                             14 	.globl _ui_gamemenu_unselect_entry
                             15 	.globl _ui_gamemenu_select_entry
                             16 	.globl _ui_gamemenu_below_entry
                             17 	.globl _ui_gamemenu_above_entry
                             18 	.globl _ui_gamemenu_previous_entry
                             19 	.globl _ui_gamemenu_next_entry
                             20 	.globl _ui_gamemenu_is_selected
                             21 	.globl _ui_gamemenu_get_entry
                             22 	.globl _ui_gamemenu_get_action
                             23 	.globl _ui_gamemenu_update_action
                             24 	.globl _ui_gamemenu_init
                             25 	.globl _renderCompass
                             26 	.globl _level_get_level
                             27 	.globl _level_set_level
                             28 	.globl _draw_minimap_to_buffer
                             29 	.globl _render_draw_to_buffer
                             30 	.globl _player_move_forward
                             31 	.globl _player_turn_right
                             32 	.globl _player_turn_left
                             33 	.globl _statemanager_input_accepted
                             34 	.globl _statemanager_set_state
                             35 	.globl _statemanager_close_state
                             36 	.globl _cpct_drawSprite
                             37 	.globl _cpct_isKeyPressed
                             38 	.globl _cpct_memset
                             39 	.globl _action
                             40 	.globl _updateRenderBuffer
                             41 	.globl _state_ingame_enter
                             42 	.globl _state_ingame_return
                             43 	.globl _state_ingame_input
                             44 	.globl _state_ingame_update
                             45 	.globl _state_ingame_render
                             46 	.globl _state_ingame_exit
                             47 ;--------------------------------------------------------
                             48 ; special function registers
                             49 ;--------------------------------------------------------
                             50 ;--------------------------------------------------------
                             51 ; ram data
                             52 ;--------------------------------------------------------
                             53 	.area _DATA
                             54 ;--------------------------------------------------------
                             55 ; ram data
                             56 ;--------------------------------------------------------
                             57 	.area _INITIALIZED
                             58 ;--------------------------------------------------------
                             59 ; absolute external ram data
                             60 ;--------------------------------------------------------
                             61 	.area _DABS (ABS)
                             62 ;--------------------------------------------------------
                             63 ; global & static initialisations
                             64 ;--------------------------------------------------------
                             65 	.area _HOME
                             66 	.area _GSINIT
                             67 	.area _GSFINAL
                             68 	.area _GSINIT
                             69 ;--------------------------------------------------------
                             70 ; Home
                             71 ;--------------------------------------------------------
                             72 	.area _HOME
                             73 	.area _HOME
                             74 ;--------------------------------------------------------
                             75 ; code
                             76 ;--------------------------------------------------------
                             77 	.area _CODE
                             78 ;src/State_InGame.c:27: void state_ingame_enter(){
                             79 ;	---------------------------------
                             80 ; Function state_ingame_enter
                             81 ; ---------------------------------
   1A3D                      82 _state_ingame_enter::
                             83 ;src/State_InGame.c:29: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1A3D 21 A4 0A      [10]   84 	ld	hl, #(_g_colors + 0x0001) + 0
   1A40 46            [ 7]   85 	ld	b,(hl)
   1A41 21 00 40      [10]   86 	ld	hl,#0x4000
   1A44 E5            [11]   87 	push	hl
   1A45 C5            [11]   88 	push	bc
   1A46 33            [ 6]   89 	inc	sp
   1A47 26 C0         [ 7]   90 	ld	h, #0xC0
   1A49 E5            [11]   91 	push	hl
   1A4A CD 9A 4D      [17]   92 	call	_cpct_memset
                             93 ;src/State_InGame.c:31: ui_gamemenu_init();
   1A4D CD AE 24      [17]   94 	call	_ui_gamemenu_init
                             95 ;src/State_InGame.c:32: ui_gamemenu_render_all();
   1A50 CD 21 26      [17]   96 	call	_ui_gamemenu_render_all
                             97 ;src/State_InGame.c:33: state_ingame_render();
   1A53 CD 87 1B      [17]   98 	call	_state_ingame_render
   1A56 C9            [10]   99 	ret
   1A57                     100 _updateRenderBuffer:
   1A57 00                  101 	.db #0x00	; 0
   1A58                     102 _action:
   1A58 00                  103 	.db #0x00	; 0
                            104 ;src/State_InGame.c:36: void state_ingame_return(){
                            105 ;	---------------------------------
                            106 ; Function state_ingame_return
                            107 ; ---------------------------------
   1A59                     108 _state_ingame_return::
                            109 ;src/State_InGame.c:37: ui_gamemenu_render_all();
   1A59 CD 21 26      [17]  110 	call	_ui_gamemenu_render_all
                            111 ;src/State_InGame.c:38: state_ingame_render();
   1A5C C3 87 1B      [10]  112 	jp  _state_ingame_render
                            113 ;src/State_InGame.c:41: void state_ingame_input(){
                            114 ;	---------------------------------
                            115 ; Function state_ingame_input
                            116 ; ---------------------------------
   1A5F                     117 _state_ingame_input::
                            118 ;src/State_InGame.c:43: if(cpct_isKeyPressed(Key_CursorLeft)){
   1A5F 21 01 01      [10]  119 	ld	hl,#0x0101
   1A62 CD AD 4B      [17]  120 	call	_cpct_isKeyPressed
   1A65 7D            [ 4]  121 	ld	a,l
   1A66 B7            [ 4]  122 	or	a, a
   1A67 28 06         [12]  123 	jr	Z,00119$
                            124 ;src/State_InGame.c:44: ui_gamemenu_previous_entry();
   1A69 CD 75 25      [17]  125 	call	_ui_gamemenu_previous_entry
                            126 ;src/State_InGame.c:45: statemanager_input_accepted();
   1A6C C3 82 1D      [10]  127 	jp  _statemanager_input_accepted
   1A6F                     128 00119$:
                            129 ;src/State_InGame.c:47: else if(cpct_isKeyPressed(Key_CursorRight)){
   1A6F 21 00 02      [10]  130 	ld	hl,#0x0200
   1A72 CD AD 4B      [17]  131 	call	_cpct_isKeyPressed
   1A75 7D            [ 4]  132 	ld	a,l
   1A76 B7            [ 4]  133 	or	a, a
   1A77 28 06         [12]  134 	jr	Z,00116$
                            135 ;src/State_InGame.c:48: ui_gamemenu_next_entry();
   1A79 CD 68 25      [17]  136 	call	_ui_gamemenu_next_entry
                            137 ;src/State_InGame.c:49: statemanager_input_accepted();
   1A7C C3 82 1D      [10]  138 	jp  _statemanager_input_accepted
   1A7F                     139 00116$:
                            140 ;src/State_InGame.c:51: else if(cpct_isKeyPressed(Key_CursorUp)){
   1A7F 21 00 01      [10]  141 	ld	hl,#0x0100
   1A82 CD AD 4B      [17]  142 	call	_cpct_isKeyPressed
   1A85 7D            [ 4]  143 	ld	a,l
   1A86 B7            [ 4]  144 	or	a, a
   1A87 28 06         [12]  145 	jr	Z,00113$
                            146 ;src/State_InGame.c:52: ui_gamemenu_above_entry();
   1A89 CD 30 25      [17]  147 	call	_ui_gamemenu_above_entry
                            148 ;src/State_InGame.c:53: statemanager_input_accepted();
   1A8C C3 82 1D      [10]  149 	jp  _statemanager_input_accepted
   1A8F                     150 00113$:
                            151 ;src/State_InGame.c:55: else if(cpct_isKeyPressed(Key_CursorDown)){
   1A8F 21 00 04      [10]  152 	ld	hl,#0x0400
   1A92 CD AD 4B      [17]  153 	call	_cpct_isKeyPressed
   1A95 7D            [ 4]  154 	ld	a,l
   1A96 B7            [ 4]  155 	or	a, a
   1A97 28 06         [12]  156 	jr	Z,00110$
                            157 ;src/State_InGame.c:56: ui_gamemenu_below_entry();
   1A99 CD 51 25      [17]  158 	call	_ui_gamemenu_below_entry
                            159 ;src/State_InGame.c:57: statemanager_input_accepted();
   1A9C C3 82 1D      [10]  160 	jp  _statemanager_input_accepted
   1A9F                     161 00110$:
                            162 ;src/State_InGame.c:59: else if(cpct_isKeyPressed(Key_Return)){
   1A9F 21 02 04      [10]  163 	ld	hl,#0x0402
   1AA2 CD AD 4B      [17]  164 	call	_cpct_isKeyPressed
   1AA5 7D            [ 4]  165 	ld	a,l
   1AA6 B7            [ 4]  166 	or	a, a
   1AA7 28 06         [12]  167 	jr	Z,00107$
                            168 ;src/State_InGame.c:60: ui_gamemenu_select_entry();
   1AA9 CD 8B 25      [17]  169 	call	_ui_gamemenu_select_entry
                            170 ;src/State_InGame.c:61: statemanager_input_accepted();
   1AAC C3 82 1D      [10]  171 	jp  _statemanager_input_accepted
   1AAF                     172 00107$:
                            173 ;src/State_InGame.c:64: else if(cpct_isKeyPressed(Key_T)){
   1AAF 21 06 08      [10]  174 	ld	hl,#0x0806
   1AB2 CD AD 4B      [17]  175 	call	_cpct_isKeyPressed
   1AB5 7D            [ 4]  176 	ld	a,l
   1AB6 B7            [ 4]  177 	or	a, a
   1AB7 28 10         [12]  178 	jr	Z,00104$
                            179 ;src/State_InGame.c:65: *(u8*)&g_texturedWalls = !g_texturedWalls;
   1AB9 3A B5 0A      [13]  180 	ld	a,(#_g_texturedWalls + 0)
   1ABC D6 01         [ 7]  181 	sub	a,#0x01
   1ABE 3E 00         [ 7]  182 	ld	a,#0x00
   1AC0 17            [ 4]  183 	rla
   1AC1 4F            [ 4]  184 	ld	c,a
   1AC2 21 B5 0A      [10]  185 	ld	hl,#_g_texturedWalls
   1AC5 71            [ 7]  186 	ld	(hl),c
                            187 ;src/State_InGame.c:66: statemanager_input_accepted();
   1AC6 C3 82 1D      [10]  188 	jp  _statemanager_input_accepted
   1AC9                     189 00104$:
                            190 ;src/State_InGame.c:68: else if(cpct_isKeyPressed(Key_Tab)){
   1AC9 21 08 10      [10]  191 	ld	hl,#0x1008
   1ACC CD AD 4B      [17]  192 	call	_cpct_isKeyPressed
   1ACF 7D            [ 4]  193 	ld	a,l
   1AD0 B7            [ 4]  194 	or	a, a
   1AD1 C8            [11]  195 	ret	Z
                            196 ;src/State_InGame.c:69: level_set_level(level_get_level()+1);
   1AD2 CD BA 00      [17]  197 	call	_level_get_level
   1AD5 2C            [ 4]  198 	inc	l
   1AD6 CD E6 00      [17]  199 	call	_level_set_level
                            200 ;src/State_InGame.c:70: statemanager_close_state();
   1AD9 CD 38 1E      [17]  201 	call	_statemanager_close_state
                            202 ;src/State_InGame.c:71: statemanager_set_state(STATE_LOADLEVEL);
   1ADC 2E 03         [ 7]  203 	ld	l,#0x03
   1ADE CD 88 1D      [17]  204 	call	_statemanager_set_state
                            205 ;src/State_InGame.c:72: statemanager_input_accepted();
   1AE1 C3 82 1D      [10]  206 	jp  _statemanager_input_accepted
                            207 ;src/State_InGame.c:76: void state_ingame_update(){
                            208 ;	---------------------------------
                            209 ; Function state_ingame_update
                            210 ; ---------------------------------
   1AE4                     211 _state_ingame_update::
                            212 ;src/State_InGame.c:78: *(u8*)&action=NONE;
   1AE4 21 58 1A      [10]  213 	ld	hl,#_action
   1AE7 36 00         [10]  214 	ld	(hl),#0x00
                            215 ;src/State_InGame.c:80: if(ui_gamemenu_is_selected()){
   1AE9 CD 41 26      [17]  216 	call	_ui_gamemenu_is_selected
   1AEC 7D            [ 4]  217 	ld	a,l
   1AED B7            [ 4]  218 	or	a, a
   1AEE CA 76 1B      [10]  219 	jp	Z,00114$
                            220 ;src/State_InGame.c:81: ui_gamemenu_render_refresh();
   1AF1 CD 08 26      [17]  221 	call	_ui_gamemenu_render_refresh
                            222 ;src/State_InGame.c:82: switch(ui_gamemenu_get_entry()){
   1AF4 CD 39 26      [17]  223 	call	_ui_gamemenu_get_entry
   1AF7 5D            [ 4]  224 	ld	e,l
   1AF8 3E 06         [ 7]  225 	ld	a,#0x06
   1AFA 93            [ 4]  226 	sub	a, e
   1AFB 38 76         [12]  227 	jr	C,00112$
   1AFD 16 00         [ 7]  228 	ld	d,#0x00
   1AFF 21 05 1B      [10]  229 	ld	hl,#00139$
   1B02 19            [11]  230 	add	hl,de
   1B03 19            [11]  231 	add	hl,de
                            232 ;src/State_InGame.c:83: case 0:{//ACTION BUTTON
   1B04 E9            [ 4]  233 	jp	(hl)
   1B05                     234 00139$:
   1B05 18 0C         [12]  235 	jr	00101$
   1B07 18 6A         [12]  236 	jr	00112$
   1B09 18 3C         [12]  237 	jr	00107$
   1B0B 18 47         [12]  238 	jr	00108$
   1B0D 18 52         [12]  239 	jr	00109$
   1B0F 18 62         [12]  240 	jr	00112$
   1B11 18 5B         [12]  241 	jr	00111$
   1B13                     242 00101$:
                            243 ;src/State_InGame.c:85: switch(ui_gamemenu_get_action()){
   1B13 CD F1 26      [17]  244 	call	_ui_gamemenu_get_action
   1B16 5D            [ 4]  245 	ld	e,l
   1B17 7B            [ 4]  246 	ld	a,e
   1B18 D6 01         [ 7]  247 	sub	a, #0x01
   1B1A 38 57         [12]  248 	jr	C,00112$
   1B1C 3E 03         [ 7]  249 	ld	a,#0x03
   1B1E 93            [ 4]  250 	sub	a, e
   1B1F 38 52         [12]  251 	jr	C,00112$
   1B21 1D            [ 4]  252 	dec	e
   1B22 16 00         [ 7]  253 	ld	d,#0x00
   1B24 21 2A 1B      [10]  254 	ld	hl,#00140$
   1B27 19            [11]  255 	add	hl,de
   1B28 19            [11]  256 	add	hl,de
                            257 ;src/State_InGame.c:86: case 1:{
   1B29 E9            [ 4]  258 	jp	(hl)
   1B2A                     259 00140$:
   1B2A 18 04         [12]  260 	jr	00102$
   1B2C 18 45         [12]  261 	jr	00112$
   1B2E 18 43         [12]  262 	jr	00112$
   1B30                     263 00102$:
                            264 ;src/State_InGame.c:87: level_set_level(level_get_level()+1);
   1B30 CD BA 00      [17]  265 	call	_level_get_level
   1B33 2C            [ 4]  266 	inc	l
   1B34 CD E6 00      [17]  267 	call	_level_set_level
                            268 ;src/State_InGame.c:88: statemanager_close_state();
   1B37 CD 38 1E      [17]  269 	call	_statemanager_close_state
                            270 ;src/State_InGame.c:89: statemanager_set_state(STATE_LOADLEVEL);
   1B3A 2E 03         [ 7]  271 	ld	l,#0x03
   1B3C CD 88 1D      [17]  272 	call	_statemanager_set_state
                            273 ;src/State_InGame.c:91: break;
   1B3F 18 32         [12]  274 	jr	00112$
                            275 ;src/State_InGame.c:93: case 2:{
                            276 ;src/State_InGame.c:95: break;
   1B41 18 30         [12]  277 	jr	00112$
                            278 ;src/State_InGame.c:97: case 3:{
                            279 ;src/State_InGame.c:102: break;
   1B43 18 2E         [12]  280 	jr	00112$
                            281 ;src/State_InGame.c:104: case 1:{//INVENTORY
                            282 ;src/State_InGame.c:107: break;
   1B45 18 2C         [12]  283 	jr	00112$
                            284 ;src/State_InGame.c:109: case 2:{//TURN LEFT
   1B47                     285 00107$:
                            286 ;src/State_InGame.c:111: player_turn_left();
   1B47 CD 5B 08      [17]  287 	call	_player_turn_left
                            288 ;src/State_InGame.c:112: ui_gamemenu_update_action();
   1B4A CD 49 26      [17]  289 	call	_ui_gamemenu_update_action
                            290 ;src/State_InGame.c:114: *(u8*)&updateRenderBuffer = 1;
   1B4D 21 57 1A      [10]  291 	ld	hl,#_updateRenderBuffer
   1B50 36 01         [10]  292 	ld	(hl),#0x01
                            293 ;src/State_InGame.c:115: break;
   1B52 18 1F         [12]  294 	jr	00112$
                            295 ;src/State_InGame.c:117: case 3:{//MOVE
   1B54                     296 00108$:
                            297 ;src/State_InGame.c:119: player_move_forward();
   1B54 CD C4 08      [17]  298 	call	_player_move_forward
                            299 ;src/State_InGame.c:120: ui_gamemenu_update_action();
   1B57 CD 49 26      [17]  300 	call	_ui_gamemenu_update_action
                            301 ;src/State_InGame.c:121: *(u8*)&updateRenderBuffer = 1;
   1B5A 21 57 1A      [10]  302 	ld	hl,#_updateRenderBuffer
   1B5D 36 01         [10]  303 	ld	(hl),#0x01
                            304 ;src/State_InGame.c:123: break;
   1B5F 18 12         [12]  305 	jr	00112$
                            306 ;src/State_InGame.c:125: case 4:{//TURN RIGHT
   1B61                     307 00109$:
                            308 ;src/State_InGame.c:126: player_turn_right();
   1B61 CD 96 08      [17]  309 	call	_player_turn_right
                            310 ;src/State_InGame.c:127: ui_gamemenu_update_action();
   1B64 CD 49 26      [17]  311 	call	_ui_gamemenu_update_action
                            312 ;src/State_InGame.c:129: *(u8*)&updateRenderBuffer = 1;
   1B67 21 57 1A      [10]  313 	ld	hl,#_updateRenderBuffer
                            314 ;src/State_InGame.c:131: break;
                            315 ;src/State_InGame.c:133: case 5:{//WAIT
                            316 ;src/State_InGame.c:135: break;
   1B6A 36 01         [10]  317 	ld	(hl), #0x01
   1B6C 18 05         [12]  318 	jr	00112$
                            319 ;src/State_InGame.c:137: case 6:{//PAUSE
   1B6E                     320 00111$:
                            321 ;src/State_InGame.c:138: statemanager_set_state(STATE_PAUSEMENU);
   1B6E 2E 02         [ 7]  322 	ld	l,#0x02
   1B70 CD 88 1D      [17]  323 	call	_statemanager_set_state
                            324 ;src/State_InGame.c:141: }
   1B73                     325 00112$:
                            326 ;src/State_InGame.c:142: ui_gamemenu_unselect_entry();
   1B73 CD 85 25      [17]  327 	call	_ui_gamemenu_unselect_entry
   1B76                     328 00114$:
                            329 ;src/State_InGame.c:145: if(updateRenderBuffer){
   1B76 3A 57 1A      [13]  330 	ld	a,(#_updateRenderBuffer + 0)
   1B79 B7            [ 4]  331 	or	a, a
   1B7A C8            [11]  332 	ret	Z
                            333 ;src/State_InGame.c:146: render_draw_to_buffer();
   1B7B CD AD 0D      [17]  334 	call	_render_draw_to_buffer
                            335 ;src/State_InGame.c:147: draw_minimap_to_buffer();
   1B7E CD 07 19      [17]  336 	call	_draw_minimap_to_buffer
                            337 ;src/State_InGame.c:148: *(u8*)&updateRenderBuffer = 0;
   1B81 21 57 1A      [10]  338 	ld	hl,#_updateRenderBuffer
   1B84 36 00         [10]  339 	ld	(hl),#0x00
   1B86 C9            [10]  340 	ret
                            341 ;src/State_InGame.c:153: void state_ingame_render(){
                            342 ;	---------------------------------
                            343 ; Function state_ingame_render
                            344 ; ---------------------------------
   1B87                     345 _state_ingame_render::
                            346 ;src/State_InGame.c:154: ui_gamemenu_render_refresh();
   1B87 CD 08 26      [17]  347 	call	_ui_gamemenu_render_refresh
                            348 ;src/State_InGame.c:155: renderCompass();
   1B8A CD 92 24      [17]  349 	call	_renderCompass
                            350 ;src/State_InGame.c:156: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   1B8D 21 28 64      [10]  351 	ld	hl,#0x6428
   1B90 E5            [11]  352 	push	hl
   1B91 21 B4 C0      [10]  353 	ld	hl,#0xC0B4
   1B94 E5            [11]  354 	push	hl
   1B95 21 00 9B      [10]  355 	ld	hl,#0x9B00
   1B98 E5            [11]  356 	push	hl
   1B99 CD DC 4B      [17]  357 	call	_cpct_drawSprite
                            358 ;src/State_InGame.c:157: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   1B9C 21 10 40      [10]  359 	ld	hl,#0x4010
   1B9F E5            [11]  360 	push	hl
   1BA0 21 22 C5      [10]  361 	ld	hl,#0xC522
   1BA3 E5            [11]  362 	push	hl
   1BA4 21 A0 AA      [10]  363 	ld	hl,#0xAAA0
   1BA7 E5            [11]  364 	push	hl
   1BA8 CD DC 4B      [17]  365 	call	_cpct_drawSprite
                            366 ;src/State_InGame.c:158: ui_playerstats_render();
   1BAB CD 45 29      [17]  367 	call	_ui_playerstats_render
   1BAE C9            [10]  368 	ret
                            369 ;src/State_InGame.c:161: void state_ingame_exit(){
                            370 ;	---------------------------------
                            371 ; Function state_ingame_exit
                            372 ; ---------------------------------
   1BAF                     373 _state_ingame_exit::
                            374 ;src/State_InGame.c:163: }
   1BAF C9            [10]  375 	ret
                            376 	.area _CODE
                            377 	.area _INITIALIZER
                            378 	.area _CABS (ABS)
