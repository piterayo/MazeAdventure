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
                             16 	.globl _ui_gamemenu_previous_entry
                             17 	.globl _ui_gamemenu_next_entry
                             18 	.globl _ui_gamemenu_is_selected
                             19 	.globl _ui_gamemenu_get_entry
                             20 	.globl _ui_gamemenu_init
                             21 	.globl _renderCompass
                             22 	.globl _level_load_level
                             23 	.globl _level_set_level
                             24 	.globl _draw_minimap_to_buffer
                             25 	.globl _render_draw_to_buffer
                             26 	.globl _player_move_forward
                             27 	.globl _player_turn_right
                             28 	.globl _player_turn_left
                             29 	.globl _statemanager_input_accepted
                             30 	.globl _statemanager_set_state
                             31 	.globl _cpct_drawSprite
                             32 	.globl _cpct_isKeyPressed
                             33 	.globl _cpct_memset
                             34 	.globl _updateRenderBuffer
                             35 	.globl _state_ingame_enter
                             36 	.globl _state_ingame_input
                             37 	.globl _state_ingame_update
                             38 	.globl _state_ingame_render
                             39 	.globl _state_ingame_exit
                             40 ;--------------------------------------------------------
                             41 ; special function registers
                             42 ;--------------------------------------------------------
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _DATA
                             47 ;--------------------------------------------------------
                             48 ; ram data
                             49 ;--------------------------------------------------------
                             50 	.area _INITIALIZED
                             51 ;--------------------------------------------------------
                             52 ; absolute external ram data
                             53 ;--------------------------------------------------------
                             54 	.area _DABS (ABS)
                             55 ;--------------------------------------------------------
                             56 ; global & static initialisations
                             57 ;--------------------------------------------------------
                             58 	.area _HOME
                             59 	.area _GSINIT
                             60 	.area _GSFINAL
                             61 	.area _GSINIT
                             62 ;--------------------------------------------------------
                             63 ; Home
                             64 ;--------------------------------------------------------
                             65 	.area _HOME
                             66 	.area _HOME
                             67 ;--------------------------------------------------------
                             68 ; code
                             69 ;--------------------------------------------------------
                             70 	.area _CODE
                             71 ;src/State_InGame.c:23: void state_ingame_enter(){
                             72 ;	---------------------------------
                             73 ; Function state_ingame_enter
                             74 ; ---------------------------------
   1A48                      75 _state_ingame_enter::
                             76 ;src/State_InGame.c:24: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1A48 21 B3 0A      [10]   77 	ld	hl, #(_g_colors + 0x0001) + 0
   1A4B 46            [ 7]   78 	ld	b,(hl)
   1A4C 21 00 40      [10]   79 	ld	hl,#0x4000
   1A4F E5            [11]   80 	push	hl
   1A50 C5            [11]   81 	push	bc
   1A51 33            [ 6]   82 	inc	sp
   1A52 26 C0         [ 7]   83 	ld	h, #0xC0
   1A54 E5            [11]   84 	push	hl
   1A55 CD F1 46      [17]   85 	call	_cpct_memset
                             86 ;src/State_InGame.c:26: ui_gamemenu_init();
   1A58 CD 13 25      [17]   87 	call	_ui_gamemenu_init
                             88 ;src/State_InGame.c:29: ui_gamemenu_render_all();
   1A5B CD 65 26      [17]   89 	call	_ui_gamemenu_render_all
                             90 ;src/State_InGame.c:30: state_ingame_render();
   1A5E CD 3C 1B      [17]   91 	call	_state_ingame_render
   1A61 C9            [10]   92 	ret
   1A62                      93 _updateRenderBuffer:
   1A62 00                   94 	.db #0x00	; 0
                             95 ;src/State_InGame.c:33: void state_ingame_input(){
                             96 ;	---------------------------------
                             97 ; Function state_ingame_input
                             98 ; ---------------------------------
   1A63                      99 _state_ingame_input::
                            100 ;src/State_InGame.c:35: if(cpct_isKeyPressed(Key_CursorLeft)){
   1A63 21 01 01      [10]  101 	ld	hl,#0x0101
   1A66 CD 44 45      [17]  102 	call	_cpct_isKeyPressed
   1A69 7D            [ 4]  103 	ld	a,l
   1A6A B7            [ 4]  104 	or	a, a
   1A6B 28 06         [12]  105 	jr	Z,00116$
                            106 ;src/State_InGame.c:36: ui_gamemenu_previous_entry();
   1A6D CD 83 25      [17]  107 	call	_ui_gamemenu_previous_entry
                            108 ;src/State_InGame.c:37: statemanager_input_accepted();
   1A70 C3 1D 1D      [10]  109 	jp  _statemanager_input_accepted
   1A73                     110 00116$:
                            111 ;src/State_InGame.c:39: else if(cpct_isKeyPressed(Key_CursorRight)){
   1A73 21 00 02      [10]  112 	ld	hl,#0x0200
   1A76 CD 44 45      [17]  113 	call	_cpct_isKeyPressed
   1A79 7D            [ 4]  114 	ld	a,l
   1A7A B7            [ 4]  115 	or	a, a
   1A7B 28 06         [12]  116 	jr	Z,00113$
                            117 ;src/State_InGame.c:40: ui_gamemenu_next_entry();
   1A7D CD 75 25      [17]  118 	call	_ui_gamemenu_next_entry
                            119 ;src/State_InGame.c:41: statemanager_input_accepted();
   1A80 C3 1D 1D      [10]  120 	jp  _statemanager_input_accepted
   1A83                     121 00113$:
                            122 ;src/State_InGame.c:43: else if(cpct_isKeyPressed(Key_Return)){
   1A83 21 02 04      [10]  123 	ld	hl,#0x0402
   1A86 CD 44 45      [17]  124 	call	_cpct_isKeyPressed
   1A89 7D            [ 4]  125 	ld	a,l
   1A8A B7            [ 4]  126 	or	a, a
   1A8B 28 06         [12]  127 	jr	Z,00110$
                            128 ;src/State_InGame.c:44: ui_gamemenu_select_entry();
   1A8D CD 99 25      [17]  129 	call	_ui_gamemenu_select_entry
                            130 ;src/State_InGame.c:45: statemanager_input_accepted();
   1A90 C3 1D 1D      [10]  131 	jp  _statemanager_input_accepted
   1A93                     132 00110$:
                            133 ;src/State_InGame.c:48: else if(cpct_isKeyPressed(Key_1)){
   1A93 21 08 01      [10]  134 	ld	hl,#0x0108
   1A96 CD 44 45      [17]  135 	call	_cpct_isKeyPressed
   1A99 7D            [ 4]  136 	ld	a,l
   1A9A B7            [ 4]  137 	or	a, a
   1A9B 28 0D         [12]  138 	jr	Z,00107$
                            139 ;src/State_InGame.c:49: level_set_level(0);
   1A9D AF            [ 4]  140 	xor	a, a
   1A9E F5            [11]  141 	push	af
   1A9F 33            [ 6]  142 	inc	sp
   1AA0 CD F4 00      [17]  143 	call	_level_set_level
   1AA3 33            [ 6]  144 	inc	sp
                            145 ;src/State_InGame.c:50: level_load_level();
   1AA4 CD 5D 01      [17]  146 	call	_level_load_level
                            147 ;src/State_InGame.c:51: statemanager_input_accepted();
   1AA7 C3 1D 1D      [10]  148 	jp  _statemanager_input_accepted
   1AAA                     149 00107$:
                            150 ;src/State_InGame.c:53: else if(cpct_isKeyPressed(Key_2)){ 
   1AAA 21 08 02      [10]  151 	ld	hl,#0x0208
   1AAD CD 44 45      [17]  152 	call	_cpct_isKeyPressed
   1AB0 7D            [ 4]  153 	ld	a,l
   1AB1 B7            [ 4]  154 	or	a, a
   1AB2 28 0E         [12]  155 	jr	Z,00104$
                            156 ;src/State_InGame.c:54: level_set_level(9);
   1AB4 3E 09         [ 7]  157 	ld	a,#0x09
   1AB6 F5            [11]  158 	push	af
   1AB7 33            [ 6]  159 	inc	sp
   1AB8 CD F4 00      [17]  160 	call	_level_set_level
   1ABB 33            [ 6]  161 	inc	sp
                            162 ;src/State_InGame.c:55: level_load_level();
   1ABC CD 5D 01      [17]  163 	call	_level_load_level
                            164 ;src/State_InGame.c:56: statemanager_input_accepted();
   1ABF C3 1D 1D      [10]  165 	jp  _statemanager_input_accepted
   1AC2                     166 00104$:
                            167 ;src/State_InGame.c:58: else if(cpct_isKeyPressed(Key_T)){
   1AC2 21 06 08      [10]  168 	ld	hl,#0x0806
   1AC5 CD 44 45      [17]  169 	call	_cpct_isKeyPressed
   1AC8 7D            [ 4]  170 	ld	a,l
   1AC9 B7            [ 4]  171 	or	a, a
   1ACA C8            [11]  172 	ret	Z
                            173 ;src/State_InGame.c:59: *(u8*)&g_texturedWalls = !g_texturedWalls;
   1ACB 3A C4 0A      [13]  174 	ld	a,(#_g_texturedWalls + 0)
   1ACE D6 01         [ 7]  175 	sub	a,#0x01
   1AD0 3E 00         [ 7]  176 	ld	a,#0x00
   1AD2 17            [ 4]  177 	rla
   1AD3 4F            [ 4]  178 	ld	c,a
   1AD4 21 C4 0A      [10]  179 	ld	hl,#_g_texturedWalls
   1AD7 71            [ 7]  180 	ld	(hl),c
                            181 ;src/State_InGame.c:60: statemanager_input_accepted();
   1AD8 C3 1D 1D      [10]  182 	jp  _statemanager_input_accepted
                            183 ;src/State_InGame.c:64: void state_ingame_update(){
                            184 ;	---------------------------------
                            185 ; Function state_ingame_update
                            186 ; ---------------------------------
   1ADB                     187 _state_ingame_update::
                            188 ;src/State_InGame.c:66: if(ui_gamemenu_is_selected()){
   1ADB CD 03 27      [17]  189 	call	_ui_gamemenu_is_selected
   1ADE 7D            [ 4]  190 	ld	a,l
   1ADF B7            [ 4]  191 	or	a, a
   1AE0 28 49         [12]  192 	jr	Z,00109$
                            193 ;src/State_InGame.c:67: ui_gamemenu_render_refresh();
   1AE2 CD 9F 25      [17]  194 	call	_ui_gamemenu_render_refresh
                            195 ;src/State_InGame.c:68: switch(ui_gamemenu_get_entry()){
   1AE5 CD FB 26      [17]  196 	call	_ui_gamemenu_get_entry
   1AE8 5D            [ 4]  197 	ld	e,l
   1AE9 3E 05         [ 7]  198 	ld	a,#0x05
   1AEB 93            [ 4]  199 	sub	a, e
   1AEC 38 3A         [12]  200 	jr	C,00107$
   1AEE 16 00         [ 7]  201 	ld	d,#0x00
   1AF0 21 F6 1A      [10]  202 	ld	hl,#00126$
   1AF3 19            [11]  203 	add	hl,de
   1AF4 19            [11]  204 	add	hl,de
                            205 ;src/State_InGame.c:69: case 0:{
   1AF5 E9            [ 4]  206 	jp	(hl)
   1AF6                     207 00126$:
   1AF6 18 0A         [12]  208 	jr	00101$
   1AF8 18 12         [12]  209 	jr	00102$
   1AFA 18 1A         [12]  210 	jr	00103$
   1AFC 18 2A         [12]  211 	jr	00107$
   1AFE 18 28         [12]  212 	jr	00107$
   1B00 18 1E         [12]  213 	jr	00106$
   1B02                     214 00101$:
                            215 ;src/State_InGame.c:71: player_turn_left();
   1B02 CD 6A 08      [17]  216 	call	_player_turn_left
                            217 ;src/State_InGame.c:74: *(u8*)&updateRenderBuffer = 1;
   1B05 21 62 1A      [10]  218 	ld	hl,#_updateRenderBuffer
   1B08 36 01         [10]  219 	ld	(hl),#0x01
                            220 ;src/State_InGame.c:75: break;
   1B0A 18 1C         [12]  221 	jr	00107$
                            222 ;src/State_InGame.c:77: case 1:{
   1B0C                     223 00102$:
                            224 ;src/State_InGame.c:79: player_move_forward();
   1B0C CD D3 08      [17]  225 	call	_player_move_forward
                            226 ;src/State_InGame.c:82: *(u8*)&updateRenderBuffer = 1;
   1B0F 21 62 1A      [10]  227 	ld	hl,#_updateRenderBuffer
   1B12 36 01         [10]  228 	ld	(hl),#0x01
                            229 ;src/State_InGame.c:83: break;
   1B14 18 12         [12]  230 	jr	00107$
                            231 ;src/State_InGame.c:85: case 2:{
   1B16                     232 00103$:
                            233 ;src/State_InGame.c:87: player_turn_right();
   1B16 CD A5 08      [17]  234 	call	_player_turn_right
                            235 ;src/State_InGame.c:89: *(u8*)&updateRenderBuffer = 1;
   1B19 21 62 1A      [10]  236 	ld	hl,#_updateRenderBuffer
                            237 ;src/State_InGame.c:90: break;
                            238 ;src/State_InGame.c:92: case 3:{
                            239 ;src/State_InGame.c:94: break;
                            240 ;src/State_InGame.c:96: case 4:{
                            241 ;src/State_InGame.c:98: break;
   1B1C 36 01         [10]  242 	ld	(hl), #0x01
   1B1E 18 08         [12]  243 	jr	00107$
                            244 ;src/State_InGame.c:100: case 5:{
   1B20                     245 00106$:
                            246 ;src/State_InGame.c:101: statemanager_set_state(STATE_PAUSEMENU);
   1B20 3E 02         [ 7]  247 	ld	a,#0x02
   1B22 F5            [11]  248 	push	af
   1B23 33            [ 6]  249 	inc	sp
   1B24 CD 23 1D      [17]  250 	call	_statemanager_set_state
   1B27 33            [ 6]  251 	inc	sp
                            252 ;src/State_InGame.c:104: }
   1B28                     253 00107$:
                            254 ;src/State_InGame.c:105: ui_gamemenu_unselect_entry();
   1B28 CD 93 25      [17]  255 	call	_ui_gamemenu_unselect_entry
   1B2B                     256 00109$:
                            257 ;src/State_InGame.c:108: if(updateRenderBuffer){
   1B2B 3A 62 1A      [13]  258 	ld	a,(#_updateRenderBuffer + 0)
   1B2E B7            [ 4]  259 	or	a, a
   1B2F C8            [11]  260 	ret	Z
                            261 ;src/State_InGame.c:109: render_draw_to_buffer();
   1B30 CD B8 0D      [17]  262 	call	_render_draw_to_buffer
                            263 ;src/State_InGame.c:110: draw_minimap_to_buffer();
   1B33 CD 12 19      [17]  264 	call	_draw_minimap_to_buffer
                            265 ;src/State_InGame.c:111: *(u8*)&updateRenderBuffer = 0;
   1B36 21 62 1A      [10]  266 	ld	hl,#_updateRenderBuffer
   1B39 36 00         [10]  267 	ld	(hl),#0x00
   1B3B C9            [10]  268 	ret
                            269 ;src/State_InGame.c:116: void state_ingame_render(){
                            270 ;	---------------------------------
                            271 ; Function state_ingame_render
                            272 ; ---------------------------------
   1B3C                     273 _state_ingame_render::
                            274 ;src/State_InGame.c:117: ui_gamemenu_render_refresh();
   1B3C CD 9F 25      [17]  275 	call	_ui_gamemenu_render_refresh
                            276 ;src/State_InGame.c:118: ui_playerstats_render();
   1B3F CD D2 28      [17]  277 	call	_ui_playerstats_render
                            278 ;src/State_InGame.c:119: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   1B42 21 28 64      [10]  279 	ld	hl,#0x6428
   1B45 E5            [11]  280 	push	hl
   1B46 21 B4 C0      [10]  281 	ld	hl,#0xC0B4
   1B49 E5            [11]  282 	push	hl
   1B4A 21 00 8B      [10]  283 	ld	hl,#0x8B00
   1B4D E5            [11]  284 	push	hl
   1B4E CD 73 45      [17]  285 	call	_cpct_drawSprite
                            286 ;src/State_InGame.c:120: renderCompass();
   1B51 CD F7 24      [17]  287 	call	_renderCompass
                            288 ;src/State_InGame.c:121: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   1B54 21 10 40      [10]  289 	ld	hl,#0x4010
   1B57 E5            [11]  290 	push	hl
   1B58 21 70 C5      [10]  291 	ld	hl,#0xC570
   1B5B E5            [11]  292 	push	hl
   1B5C 21 A0 9A      [10]  293 	ld	hl,#0x9AA0
   1B5F E5            [11]  294 	push	hl
   1B60 CD 73 45      [17]  295 	call	_cpct_drawSprite
   1B63 C9            [10]  296 	ret
                            297 ;src/State_InGame.c:124: void state_ingame_exit(){
                            298 ;	---------------------------------
                            299 ; Function state_ingame_exit
                            300 ; ---------------------------------
   1B64                     301 _state_ingame_exit::
                            302 ;src/State_InGame.c:126: }
   1B64 C9            [10]  303 	ret
                            304 	.area _CODE
                            305 	.area _INITIALIZER
                            306 	.area _CABS (ABS)
