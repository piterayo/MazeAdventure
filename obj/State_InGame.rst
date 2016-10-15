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
                             22 	.globl _ui_gamemenu_get_movement
                             23 	.globl _ui_gamemenu_get_action
                             24 	.globl _ui_gamemenu_update_action
                             25 	.globl _ui_gamemenu_init
                             26 	.globl _renderCompass
                             27 	.globl _level_get_level
                             28 	.globl _level_set_level
                             29 	.globl _draw_minimap_to_buffer
                             30 	.globl _render_draw_to_buffer
                             31 	.globl _player_move_forward
                             32 	.globl _player_turn_right
                             33 	.globl _player_turn_left
                             34 	.globl _statemanager_input_accepted
                             35 	.globl _statemanager_set_state
                             36 	.globl _statemanager_close_state
                             37 	.globl _cpct_drawSprite
                             38 	.globl _cpct_isKeyPressed
                             39 	.globl _cpct_memset
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
                             78 ;src/State_InGame.c:21: void state_ingame_enter(){
                             79 ;	---------------------------------
                             80 ; Function state_ingame_enter
                             81 ; ---------------------------------
   1A39                      82 _state_ingame_enter::
                             83 ;src/State_InGame.c:22: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1A39 21 A4 0A      [10]   84 	ld	hl, #(_g_colors + 0x0001) + 0
   1A3C 46            [ 7]   85 	ld	b,(hl)
   1A3D 21 00 40      [10]   86 	ld	hl,#0x4000
   1A40 E5            [11]   87 	push	hl
   1A41 C5            [11]   88 	push	bc
   1A42 33            [ 6]   89 	inc	sp
   1A43 26 C0         [ 7]   90 	ld	h, #0xC0
   1A45 E5            [11]   91 	push	hl
   1A46 CD A5 48      [17]   92 	call	_cpct_memset
                             93 ;src/State_InGame.c:24: ui_gamemenu_init();
   1A49 CD CF 25      [17]   94 	call	_ui_gamemenu_init
                             95 ;src/State_InGame.c:25: ui_gamemenu_render_all();
   1A4C CD 98 27      [17]   96 	call	_ui_gamemenu_render_all
                             97 ;src/State_InGame.c:26: state_ingame_render();
   1A4F CD 7B 1B      [17]   98 	call	_state_ingame_render
   1A52 C9            [10]   99 	ret
   1A53                     100 _updateRenderBuffer:
   1A53 00                  101 	.db #0x00	; 0
                            102 ;src/State_InGame.c:29: void state_ingame_return(){
                            103 ;	---------------------------------
                            104 ; Function state_ingame_return
                            105 ; ---------------------------------
   1A54                     106 _state_ingame_return::
                            107 ;src/State_InGame.c:30: ui_gamemenu_render_all();
   1A54 CD 98 27      [17]  108 	call	_ui_gamemenu_render_all
                            109 ;src/State_InGame.c:31: state_ingame_render();
   1A57 C3 7B 1B      [10]  110 	jp  _state_ingame_render
                            111 ;src/State_InGame.c:34: void state_ingame_input(){
                            112 ;	---------------------------------
                            113 ; Function state_ingame_input
                            114 ; ---------------------------------
   1A5A                     115 _state_ingame_input::
                            116 ;src/State_InGame.c:36: if(cpct_isKeyPressed(Key_CursorLeft)){
   1A5A 21 01 01      [10]  117 	ld	hl,#0x0101
   1A5D CD F8 46      [17]  118 	call	_cpct_isKeyPressed
   1A60 7D            [ 4]  119 	ld	a,l
   1A61 B7            [ 4]  120 	or	a, a
   1A62 28 06         [12]  121 	jr	Z,00116$
                            122 ;src/State_InGame.c:37: ui_gamemenu_previous_entry();
   1A64 CD 98 26      [17]  123 	call	_ui_gamemenu_previous_entry
                            124 ;src/State_InGame.c:38: statemanager_input_accepted();
   1A67 C3 7F 1D      [10]  125 	jp  _statemanager_input_accepted
   1A6A                     126 00116$:
                            127 ;src/State_InGame.c:40: else if(cpct_isKeyPressed(Key_CursorRight)){
   1A6A 21 00 02      [10]  128 	ld	hl,#0x0200
   1A6D CD F8 46      [17]  129 	call	_cpct_isKeyPressed
   1A70 7D            [ 4]  130 	ld	a,l
   1A71 B7            [ 4]  131 	or	a, a
   1A72 28 06         [12]  132 	jr	Z,00113$
                            133 ;src/State_InGame.c:41: ui_gamemenu_next_entry();
   1A74 CD 8B 26      [17]  134 	call	_ui_gamemenu_next_entry
                            135 ;src/State_InGame.c:42: statemanager_input_accepted();
   1A77 C3 7F 1D      [10]  136 	jp  _statemanager_input_accepted
   1A7A                     137 00113$:
                            138 ;src/State_InGame.c:44: else if(cpct_isKeyPressed(Key_CursorUp)){
   1A7A 21 00 01      [10]  139 	ld	hl,#0x0100
   1A7D CD F8 46      [17]  140 	call	_cpct_isKeyPressed
   1A80 7D            [ 4]  141 	ld	a,l
   1A81 B7            [ 4]  142 	or	a, a
   1A82 28 06         [12]  143 	jr	Z,00110$
                            144 ;src/State_InGame.c:45: ui_gamemenu_above_entry();
   1A84 CD 53 26      [17]  145 	call	_ui_gamemenu_above_entry
                            146 ;src/State_InGame.c:46: statemanager_input_accepted();
   1A87 C3 7F 1D      [10]  147 	jp  _statemanager_input_accepted
   1A8A                     148 00110$:
                            149 ;src/State_InGame.c:48: else if(cpct_isKeyPressed(Key_CursorDown)){
   1A8A 21 00 04      [10]  150 	ld	hl,#0x0400
   1A8D CD F8 46      [17]  151 	call	_cpct_isKeyPressed
   1A90 7D            [ 4]  152 	ld	a,l
   1A91 B7            [ 4]  153 	or	a, a
   1A92 28 06         [12]  154 	jr	Z,00107$
                            155 ;src/State_InGame.c:49: ui_gamemenu_below_entry();
   1A94 CD 74 26      [17]  156 	call	_ui_gamemenu_below_entry
                            157 ;src/State_InGame.c:50: statemanager_input_accepted();
   1A97 C3 7F 1D      [10]  158 	jp  _statemanager_input_accepted
   1A9A                     159 00107$:
                            160 ;src/State_InGame.c:52: else if(cpct_isKeyPressed(Key_Return)){
   1A9A 21 02 04      [10]  161 	ld	hl,#0x0402
   1A9D CD F8 46      [17]  162 	call	_cpct_isKeyPressed
   1AA0 7D            [ 4]  163 	ld	a,l
   1AA1 B7            [ 4]  164 	or	a, a
   1AA2 28 06         [12]  165 	jr	Z,00104$
                            166 ;src/State_InGame.c:53: ui_gamemenu_select_entry();
   1AA4 CD AE 26      [17]  167 	call	_ui_gamemenu_select_entry
                            168 ;src/State_InGame.c:54: statemanager_input_accepted();
   1AA7 C3 7F 1D      [10]  169 	jp  _statemanager_input_accepted
   1AAA                     170 00104$:
                            171 ;src/State_InGame.c:57: else if(cpct_isKeyPressed(Key_T)){
   1AAA 21 06 08      [10]  172 	ld	hl,#0x0806
   1AAD CD F8 46      [17]  173 	call	_cpct_isKeyPressed
   1AB0 7D            [ 4]  174 	ld	a,l
   1AB1 B7            [ 4]  175 	or	a, a
   1AB2 C8            [11]  176 	ret	Z
                            177 ;src/State_InGame.c:58: *(u8*)&g_texturedWalls = !g_texturedWalls;
   1AB3 3A B5 0A      [13]  178 	ld	a,(#_g_texturedWalls + 0)
   1AB6 D6 01         [ 7]  179 	sub	a,#0x01
   1AB8 3E 00         [ 7]  180 	ld	a,#0x00
   1ABA 17            [ 4]  181 	rla
   1ABB 4F            [ 4]  182 	ld	c,a
   1ABC 21 B5 0A      [10]  183 	ld	hl,#_g_texturedWalls
   1ABF 71            [ 7]  184 	ld	(hl),c
                            185 ;src/State_InGame.c:59: statemanager_input_accepted();
   1AC0 C3 7F 1D      [10]  186 	jp  _statemanager_input_accepted
                            187 ;src/State_InGame.c:63: void state_ingame_update(){
                            188 ;	---------------------------------
                            189 ; Function state_ingame_update
                            190 ; ---------------------------------
   1AC3                     191 _state_ingame_update::
                            192 ;src/State_InGame.c:66: if(ui_gamemenu_is_selected()){
   1AC3 CD B8 27      [17]  193 	call	_ui_gamemenu_is_selected
   1AC6 7D            [ 4]  194 	ld	a,l
   1AC7 B7            [ 4]  195 	or	a, a
   1AC8 CA 6A 1B      [10]  196 	jp	Z,00116$
                            197 ;src/State_InGame.c:67: ui_gamemenu_render_refresh();
   1ACB CD 7F 27      [17]  198 	call	_ui_gamemenu_render_refresh
                            199 ;src/State_InGame.c:68: switch(ui_gamemenu_get_entry()){
   1ACE CD B0 27      [17]  200 	call	_ui_gamemenu_get_entry
   1AD1 5D            [ 4]  201 	ld	e,l
   1AD2 3E 06         [ 7]  202 	ld	a,#0x06
   1AD4 93            [ 4]  203 	sub	a, e
   1AD5 DA 67 1B      [10]  204 	jp	C,00114$
   1AD8 16 00         [ 7]  205 	ld	d,#0x00
   1ADA 21 E1 1A      [10]  206 	ld	hl,#00145$
   1ADD 19            [11]  207 	add	hl,de
   1ADE 19            [11]  208 	add	hl,de
   1ADF 19            [11]  209 	add	hl,de
   1AE0 E9            [ 4]  210 	jp	(hl)
   1AE1                     211 00145$:
   1AE1 C3 F6 1A      [10]  212 	jp	00101$
   1AE4 C3 67 1B      [10]  213 	jp	00114$
   1AE7 C3 31 1B      [10]  214 	jp	00107$
   1AEA C3 3E 1B      [10]  215 	jp	00108$
   1AED C3 52 1B      [10]  216 	jp	00111$
   1AF0 C3 67 1B      [10]  217 	jp	00114$
   1AF3 C3 5F 1B      [10]  218 	jp	00113$
                            219 ;src/State_InGame.c:69: case 0:{//ACTION BUTTON
   1AF6                     220 00101$:
                            221 ;src/State_InGame.c:71: switch(ui_gamemenu_get_action()){
   1AF6 CD 38 28      [17]  222 	call	_ui_gamemenu_get_action
   1AF9 5D            [ 4]  223 	ld	e,l
   1AFA 7B            [ 4]  224 	ld	a,e
   1AFB D6 01         [ 7]  225 	sub	a, #0x01
   1AFD 38 68         [12]  226 	jr	C,00114$
   1AFF 3E 03         [ 7]  227 	ld	a,#0x03
   1B01 93            [ 4]  228 	sub	a, e
   1B02 38 63         [12]  229 	jr	C,00114$
   1B04 1D            [ 4]  230 	dec	e
   1B05 16 00         [ 7]  231 	ld	d,#0x00
   1B07 21 0D 1B      [10]  232 	ld	hl,#00146$
   1B0A 19            [11]  233 	add	hl,de
   1B0B 19            [11]  234 	add	hl,de
                            235 ;src/State_InGame.c:72: case 1:{
   1B0C E9            [ 4]  236 	jp	(hl)
   1B0D                     237 00146$:
   1B0D 18 04         [12]  238 	jr	00102$
   1B0F 18 56         [12]  239 	jr	00114$
   1B11 18 54         [12]  240 	jr	00114$
   1B13                     241 00102$:
                            242 ;src/State_InGame.c:73: level_set_level(level_get_level()+1);
   1B13 CD B5 00      [17]  243 	call	_level_get_level
   1B16 45            [ 4]  244 	ld	b,l
   1B17 04            [ 4]  245 	inc	b
   1B18 C5            [11]  246 	push	bc
   1B19 33            [ 6]  247 	inc	sp
   1B1A CD E5 00      [17]  248 	call	_level_set_level
   1B1D 33            [ 6]  249 	inc	sp
                            250 ;src/State_InGame.c:74: statemanager_close_state();
   1B1E CD 33 1E      [17]  251 	call	_statemanager_close_state
                            252 ;src/State_InGame.c:75: statemanager_set_state(STATE_LOADLEVEL);
   1B21 3E 03         [ 7]  253 	ld	a,#0x03
   1B23 F5            [11]  254 	push	af
   1B24 33            [ 6]  255 	inc	sp
   1B25 CD 85 1D      [17]  256 	call	_statemanager_set_state
   1B28 33            [ 6]  257 	inc	sp
                            258 ;src/State_InGame.c:77: break;
   1B29 18 3C         [12]  259 	jr	00114$
                            260 ;src/State_InGame.c:79: case 2:{
                            261 ;src/State_InGame.c:81: break;
   1B2B 18 3A         [12]  262 	jr	00114$
                            263 ;src/State_InGame.c:83: case 3:{
                            264 ;src/State_InGame.c:88: break;
   1B2D 18 38         [12]  265 	jr	00114$
                            266 ;src/State_InGame.c:90: case 1:{//INVENTORY
                            267 ;src/State_InGame.c:93: break;
   1B2F 18 36         [12]  268 	jr	00114$
                            269 ;src/State_InGame.c:95: case 2:{//TURN LEFT
   1B31                     270 00107$:
                            271 ;src/State_InGame.c:97: player_turn_left();
   1B31 CD 5B 08      [17]  272 	call	_player_turn_left
                            273 ;src/State_InGame.c:98: ui_gamemenu_update_action();
   1B34 CD C0 27      [17]  274 	call	_ui_gamemenu_update_action
                            275 ;src/State_InGame.c:100: *(u8*)&updateRenderBuffer = 1;
   1B37 21 53 1A      [10]  276 	ld	hl,#_updateRenderBuffer
   1B3A 36 01         [10]  277 	ld	(hl),#0x01
                            278 ;src/State_InGame.c:101: break;
   1B3C 18 29         [12]  279 	jr	00114$
                            280 ;src/State_InGame.c:103: case 3:{//MOVE
   1B3E                     281 00108$:
                            282 ;src/State_InGame.c:104: if(ui_gamemenu_get_movement()){//BYPASS IF FOR NOCLIP
   1B3E CD 30 28      [17]  283 	call	_ui_gamemenu_get_movement
   1B41 7D            [ 4]  284 	ld	a,l
   1B42 B7            [ 4]  285 	or	a, a
   1B43 28 22         [12]  286 	jr	Z,00114$
                            287 ;src/State_InGame.c:105: player_move_forward();
   1B45 CD C4 08      [17]  288 	call	_player_move_forward
                            289 ;src/State_InGame.c:106: ui_gamemenu_update_action();
   1B48 CD C0 27      [17]  290 	call	_ui_gamemenu_update_action
                            291 ;src/State_InGame.c:107: *(u8*)&updateRenderBuffer = 1;
   1B4B 21 53 1A      [10]  292 	ld	hl,#_updateRenderBuffer
   1B4E 36 01         [10]  293 	ld	(hl),#0x01
                            294 ;src/State_InGame.c:109: break;
   1B50 18 15         [12]  295 	jr	00114$
                            296 ;src/State_InGame.c:111: case 4:{//TURN RIGHT
   1B52                     297 00111$:
                            298 ;src/State_InGame.c:112: player_turn_right();
   1B52 CD 96 08      [17]  299 	call	_player_turn_right
                            300 ;src/State_InGame.c:113: ui_gamemenu_update_action();
   1B55 CD C0 27      [17]  301 	call	_ui_gamemenu_update_action
                            302 ;src/State_InGame.c:115: *(u8*)&updateRenderBuffer = 1;
   1B58 21 53 1A      [10]  303 	ld	hl,#_updateRenderBuffer
                            304 ;src/State_InGame.c:117: break;
                            305 ;src/State_InGame.c:119: case 5:{//WAIT
                            306 ;src/State_InGame.c:121: break;
   1B5B 36 01         [10]  307 	ld	(hl), #0x01
   1B5D 18 08         [12]  308 	jr	00114$
                            309 ;src/State_InGame.c:123: case 6:{//PAUSE
   1B5F                     310 00113$:
                            311 ;src/State_InGame.c:124: statemanager_set_state(STATE_PAUSEMENU);
   1B5F 3E 02         [ 7]  312 	ld	a,#0x02
   1B61 F5            [11]  313 	push	af
   1B62 33            [ 6]  314 	inc	sp
   1B63 CD 85 1D      [17]  315 	call	_statemanager_set_state
   1B66 33            [ 6]  316 	inc	sp
                            317 ;src/State_InGame.c:127: }
   1B67                     318 00114$:
                            319 ;src/State_InGame.c:128: ui_gamemenu_unselect_entry();
   1B67 CD A8 26      [17]  320 	call	_ui_gamemenu_unselect_entry
   1B6A                     321 00116$:
                            322 ;src/State_InGame.c:131: if(updateRenderBuffer){
   1B6A 3A 53 1A      [13]  323 	ld	a,(#_updateRenderBuffer + 0)
   1B6D B7            [ 4]  324 	or	a, a
   1B6E C8            [11]  325 	ret	Z
                            326 ;src/State_InGame.c:132: render_draw_to_buffer();
   1B6F CD A9 0D      [17]  327 	call	_render_draw_to_buffer
                            328 ;src/State_InGame.c:133: draw_minimap_to_buffer();
   1B72 CD 03 19      [17]  329 	call	_draw_minimap_to_buffer
                            330 ;src/State_InGame.c:134: *(u8*)&updateRenderBuffer = 0;
   1B75 21 53 1A      [10]  331 	ld	hl,#_updateRenderBuffer
   1B78 36 00         [10]  332 	ld	(hl),#0x00
   1B7A C9            [10]  333 	ret
                            334 ;src/State_InGame.c:139: void state_ingame_render(){
                            335 ;	---------------------------------
                            336 ; Function state_ingame_render
                            337 ; ---------------------------------
   1B7B                     338 _state_ingame_render::
                            339 ;src/State_InGame.c:140: ui_gamemenu_render_refresh();
   1B7B CD 7F 27      [17]  340 	call	_ui_gamemenu_render_refresh
                            341 ;src/State_InGame.c:141: renderCompass();
   1B7E CD B3 25      [17]  342 	call	_renderCompass
                            343 ;src/State_InGame.c:142: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   1B81 21 28 64      [10]  344 	ld	hl,#0x6428
   1B84 E5            [11]  345 	push	hl
   1B85 21 B4 C0      [10]  346 	ld	hl,#0xC0B4
   1B88 E5            [11]  347 	push	hl
   1B89 21 00 8B      [10]  348 	ld	hl,#0x8B00
   1B8C E5            [11]  349 	push	hl
   1B8D CD 27 47      [17]  350 	call	_cpct_drawSprite
                            351 ;src/State_InGame.c:143: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   1B90 21 10 40      [10]  352 	ld	hl,#0x4010
   1B93 E5            [11]  353 	push	hl
   1B94 21 22 C5      [10]  354 	ld	hl,#0xC522
   1B97 E5            [11]  355 	push	hl
   1B98 21 A0 9A      [10]  356 	ld	hl,#0x9AA0
   1B9B E5            [11]  357 	push	hl
   1B9C CD 27 47      [17]  358 	call	_cpct_drawSprite
                            359 ;src/State_InGame.c:144: ui_playerstats_render();
   1B9F CD 86 2A      [17]  360 	call	_ui_playerstats_render
   1BA2 C9            [10]  361 	ret
                            362 ;src/State_InGame.c:147: void state_ingame_exit(){
                            363 ;	---------------------------------
                            364 ; Function state_ingame_exit
                            365 ; ---------------------------------
   1BA3                     366 _state_ingame_exit::
                            367 ;src/State_InGame.c:149: }
   1BA3 C9            [10]  368 	ret
                            369 	.area _CODE
                            370 	.area _INITIALIZER
                            371 	.area _CABS (ABS)
