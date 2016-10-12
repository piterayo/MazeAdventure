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
                             11 	.globl _ui_gamemenu_render
                             12 	.globl _ui_gamemenu_unselect_entry
                             13 	.globl _ui_gamemenu_select_entry
                             14 	.globl _ui_gamemenu_previous_entry
                             15 	.globl _ui_gamemenu_next_entry
                             16 	.globl _ui_gamemenu_is_selected
                             17 	.globl _ui_gamemenu_get_entry
                             18 	.globl _renderCompass
                             19 	.globl _level_load_level
                             20 	.globl _level_set_level
                             21 	.globl _draw_minimap_to_buffer
                             22 	.globl _render_draw_to_buffer
                             23 	.globl _generate_level
                             24 	.globl _statemanager_input_accepted
                             25 	.globl _statemanager_set_state
                             26 	.globl _cpct_drawSprite
                             27 	.globl _cpct_isKeyPressed
                             28 	.globl _cpct_memset
                             29 	.globl _updateRenderBuffer
                             30 	.globl _isInitialized
                             31 	.globl _state_ingame_enter
                             32 	.globl _state_ingame_input
                             33 	.globl _state_ingame_update
                             34 	.globl _state_ingame_render
                             35 	.globl _state_ingame_exit
                             36 ;--------------------------------------------------------
                             37 ; special function registers
                             38 ;--------------------------------------------------------
                             39 ;--------------------------------------------------------
                             40 ; ram data
                             41 ;--------------------------------------------------------
                             42 	.area _DATA
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
                             47 ;--------------------------------------------------------
                             48 ; absolute external ram data
                             49 ;--------------------------------------------------------
                             50 	.area _DABS (ABS)
                             51 ;--------------------------------------------------------
                             52 ; global & static initialisations
                             53 ;--------------------------------------------------------
                             54 	.area _HOME
                             55 	.area _GSINIT
                             56 	.area _GSFINAL
                             57 	.area _GSINIT
                             58 ;--------------------------------------------------------
                             59 ; Home
                             60 ;--------------------------------------------------------
                             61 	.area _HOME
                             62 	.area _HOME
                             63 ;--------------------------------------------------------
                             64 ; code
                             65 ;--------------------------------------------------------
                             66 	.area _CODE
                             67 ;src/State_InGame.c:20: void state_ingame_enter(){
                             68 ;	---------------------------------
                             69 ; Function state_ingame_enter
                             70 ; ---------------------------------
   1A3B                      71 _state_ingame_enter::
                             72 ;src/State_InGame.c:21: if(!isInitialized){
   1A3B 3A 6D 1A      [13]   73 	ld	a,(#_isInitialized + 0)
   1A3E B7            [ 4]   74 	or	a, a
   1A3F 20 18         [12]   75 	jr	NZ,00102$
                             76 ;src/State_InGame.c:22: generate_level();
   1A41 CD AF 08      [17]   77 	call	_generate_level
                             78 ;src/State_InGame.c:23: level_set_level(0);
   1A44 AF            [ 4]   79 	xor	a, a
   1A45 F5            [11]   80 	push	af
   1A46 33            [ 6]   81 	inc	sp
   1A47 CD FF 00      [17]   82 	call	_level_set_level
   1A4A 33            [ 6]   83 	inc	sp
                             84 ;src/State_InGame.c:24: level_load_level();
   1A4B CD 68 01      [17]   85 	call	_level_load_level
                             86 ;src/State_InGame.c:25: render_draw_to_buffer();
   1A4E CD AB 0D      [17]   87 	call	_render_draw_to_buffer
                             88 ;src/State_InGame.c:26: draw_minimap_to_buffer();
   1A51 CD 05 19      [17]   89 	call	_draw_minimap_to_buffer
                             90 ;src/State_InGame.c:27: *(u8*)&isInitialized = 1;
   1A54 21 6D 1A      [10]   91 	ld	hl,#_isInitialized
   1A57 36 01         [10]   92 	ld	(hl),#0x01
   1A59                      93 00102$:
                             94 ;src/State_InGame.c:29: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
   1A59 21 B1 0A      [10]   95 	ld	hl,#_g_colors+12
   1A5C 46            [ 7]   96 	ld	b,(hl)
   1A5D 21 00 40      [10]   97 	ld	hl,#0x4000
   1A60 E5            [11]   98 	push	hl
   1A61 C5            [11]   99 	push	bc
   1A62 33            [ 6]  100 	inc	sp
   1A63 26 C0         [ 7]  101 	ld	h, #0xC0
   1A65 E5            [11]  102 	push	hl
   1A66 CD 5D 3F      [17]  103 	call	_cpct_memset
                            104 ;src/State_InGame.c:30: state_ingame_render();
   1A69 CD BF 1B      [17]  105 	call	_state_ingame_render
   1A6C C9            [10]  106 	ret
   1A6D                     107 _isInitialized:
   1A6D 00                  108 	.db #0x00	; 0
   1A6E                     109 _updateRenderBuffer:
   1A6E 00                  110 	.db #0x00	; 0
                            111 ;src/State_InGame.c:33: void state_ingame_input(){
                            112 ;	---------------------------------
                            113 ; Function state_ingame_input
                            114 ; ---------------------------------
   1A6F                     115 _state_ingame_input::
                            116 ;src/State_InGame.c:35: if(cpct_isKeyPressed(Key_CursorLeft)){
   1A6F 21 01 01      [10]  117 	ld	hl,#0x0101
   1A72 CD B0 3D      [17]  118 	call	_cpct_isKeyPressed
   1A75 7D            [ 4]  119 	ld	a,l
   1A76 B7            [ 4]  120 	or	a, a
   1A77 28 06         [12]  121 	jr	Z,00116$
                            122 ;src/State_InGame.c:36: ui_gamemenu_previous_entry();
   1A79 CD 0D 20      [17]  123 	call	_ui_gamemenu_previous_entry
                            124 ;src/State_InGame.c:37: statemanager_input_accepted();
   1A7C C3 6A 1C      [10]  125 	jp  _statemanager_input_accepted
   1A7F                     126 00116$:
                            127 ;src/State_InGame.c:39: else if(cpct_isKeyPressed(Key_CursorRight)){
   1A7F 21 00 02      [10]  128 	ld	hl,#0x0200
   1A82 CD B0 3D      [17]  129 	call	_cpct_isKeyPressed
   1A85 7D            [ 4]  130 	ld	a,l
   1A86 B7            [ 4]  131 	or	a, a
   1A87 28 06         [12]  132 	jr	Z,00113$
                            133 ;src/State_InGame.c:40: ui_gamemenu_next_entry();
   1A89 CD CD 1F      [17]  134 	call	_ui_gamemenu_next_entry
                            135 ;src/State_InGame.c:41: statemanager_input_accepted();
   1A8C C3 6A 1C      [10]  136 	jp  _statemanager_input_accepted
   1A8F                     137 00113$:
                            138 ;src/State_InGame.c:43: else if(cpct_isKeyPressed(Key_Return)){
   1A8F 21 02 04      [10]  139 	ld	hl,#0x0402
   1A92 CD B0 3D      [17]  140 	call	_cpct_isKeyPressed
   1A95 7D            [ 4]  141 	ld	a,l
   1A96 B7            [ 4]  142 	or	a, a
   1A97 28 06         [12]  143 	jr	Z,00110$
                            144 ;src/State_InGame.c:44: ui_gamemenu_select_entry();
   1A99 CD 1D 20      [17]  145 	call	_ui_gamemenu_select_entry
                            146 ;src/State_InGame.c:45: statemanager_input_accepted();
   1A9C C3 6A 1C      [10]  147 	jp  _statemanager_input_accepted
   1A9F                     148 00110$:
                            149 ;src/State_InGame.c:47: else if(cpct_isKeyPressed(Key_1)){
   1A9F 21 08 01      [10]  150 	ld	hl,#0x0108
   1AA2 CD B0 3D      [17]  151 	call	_cpct_isKeyPressed
   1AA5 7D            [ 4]  152 	ld	a,l
   1AA6 B7            [ 4]  153 	or	a, a
   1AA7 28 0D         [12]  154 	jr	Z,00107$
                            155 ;src/State_InGame.c:48: level_set_level(0);
   1AA9 AF            [ 4]  156 	xor	a, a
   1AAA F5            [11]  157 	push	af
   1AAB 33            [ 6]  158 	inc	sp
   1AAC CD FF 00      [17]  159 	call	_level_set_level
   1AAF 33            [ 6]  160 	inc	sp
                            161 ;src/State_InGame.c:49: level_load_level();
   1AB0 CD 68 01      [17]  162 	call	_level_load_level
                            163 ;src/State_InGame.c:50: statemanager_input_accepted();
   1AB3 C3 6A 1C      [10]  164 	jp  _statemanager_input_accepted
   1AB6                     165 00107$:
                            166 ;src/State_InGame.c:52: else if(cpct_isKeyPressed(Key_2)){ 
   1AB6 21 08 02      [10]  167 	ld	hl,#0x0208
   1AB9 CD B0 3D      [17]  168 	call	_cpct_isKeyPressed
   1ABC 7D            [ 4]  169 	ld	a,l
   1ABD B7            [ 4]  170 	or	a, a
   1ABE 28 0E         [12]  171 	jr	Z,00104$
                            172 ;src/State_InGame.c:53: level_set_level(9);
   1AC0 3E 09         [ 7]  173 	ld	a,#0x09
   1AC2 F5            [11]  174 	push	af
   1AC3 33            [ 6]  175 	inc	sp
   1AC4 CD FF 00      [17]  176 	call	_level_set_level
   1AC7 33            [ 6]  177 	inc	sp
                            178 ;src/State_InGame.c:54: level_load_level();
   1AC8 CD 68 01      [17]  179 	call	_level_load_level
                            180 ;src/State_InGame.c:55: statemanager_input_accepted();
   1ACB C3 6A 1C      [10]  181 	jp  _statemanager_input_accepted
   1ACE                     182 00104$:
                            183 ;src/State_InGame.c:57: else if(cpct_isKeyPressed(Key_T)){
   1ACE 21 06 08      [10]  184 	ld	hl,#0x0806
   1AD1 CD B0 3D      [17]  185 	call	_cpct_isKeyPressed
   1AD4 7D            [ 4]  186 	ld	a,l
   1AD5 B7            [ 4]  187 	or	a, a
   1AD6 C8            [11]  188 	ret	Z
                            189 ;src/State_InGame.c:58: *(u8*)&g_texturedWalls = !g_texturedWalls;
   1AD7 3A B7 0A      [13]  190 	ld	a,(#_g_texturedWalls + 0)
   1ADA D6 01         [ 7]  191 	sub	a,#0x01
   1ADC 3E 00         [ 7]  192 	ld	a,#0x00
   1ADE 17            [ 4]  193 	rla
   1ADF 4F            [ 4]  194 	ld	c,a
   1AE0 21 B7 0A      [10]  195 	ld	hl,#_g_texturedWalls
   1AE3 71            [ 7]  196 	ld	(hl),c
                            197 ;src/State_InGame.c:59: statemanager_input_accepted();
   1AE4 C3 6A 1C      [10]  198 	jp  _statemanager_input_accepted
                            199 ;src/State_InGame.c:63: void state_ingame_update(){
                            200 ;	---------------------------------
                            201 ; Function state_ingame_update
                            202 ; ---------------------------------
   1AE7                     203 _state_ingame_update::
                            204 ;src/State_InGame.c:65: if(ui_gamemenu_is_selected()){
   1AE7 CD A2 20      [17]  205 	call	_ui_gamemenu_is_selected
   1AEA 7D            [ 4]  206 	ld	a,l
   1AEB B7            [ 4]  207 	or	a, a
   1AEC CA AE 1B      [10]  208 	jp	Z,00109$
                            209 ;src/State_InGame.c:66: ui_gamemenu_render();
   1AEF CD 23 20      [17]  210 	call	_ui_gamemenu_render
                            211 ;src/State_InGame.c:67: switch(ui_gamemenu_get_entry()){
   1AF2 CD 9A 20      [17]  212 	call	_ui_gamemenu_get_entry
   1AF5 5D            [ 4]  213 	ld	e,l
   1AF6 3E 05         [ 7]  214 	ld	a,#0x05
   1AF8 93            [ 4]  215 	sub	a, e
   1AF9 DA AB 1B      [10]  216 	jp	C,00107$
                            217 ;src/State_InGame.c:69: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
   1AFC FD 21 E2 08   [14]  218 	ld	iy,#_PLAYER_directionIndex
   1B00 FD 4E 00      [19]  219 	ld	c,0 (iy)
                            220 ;src/State_InGame.c:67: switch(ui_gamemenu_get_entry()){
   1B03 16 00         [ 7]  221 	ld	d,#0x00
   1B05 21 0C 1B      [10]  222 	ld	hl,#00126$
   1B08 19            [11]  223 	add	hl,de
   1B09 19            [11]  224 	add	hl,de
   1B0A 19            [11]  225 	add	hl,de
   1B0B E9            [ 4]  226 	jp	(hl)
   1B0C                     227 00126$:
   1B0C C3 1E 1B      [10]  228 	jp	00101$
   1B0F C3 50 1B      [10]  229 	jp	00102$
   1B12 C3 71 1B      [10]  230 	jp	00103$
   1B15 C3 AB 1B      [10]  231 	jp	00107$
   1B18 C3 AB 1B      [10]  232 	jp	00107$
   1B1B C3 A3 1B      [10]  233 	jp	00106$
                            234 ;src/State_InGame.c:68: case 0:{
   1B1E                     235 00101$:
                            236 ;src/State_InGame.c:69: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
   1B1E 11 E2 08      [10]  237 	ld	de,#_PLAYER_directionIndex+0
   1B21 0C            [ 4]  238 	inc	c
   1B22 0C            [ 4]  239 	inc	c
   1B23 79            [ 4]  240 	ld	a,c
   1B24 E6 07         [ 7]  241 	and	a, #0x07
   1B26 12            [ 7]  242 	ld	(de),a
                            243 ;src/State_InGame.c:70: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   1B27 01 E0 08      [10]  244 	ld	bc,#_PLAYER_direction+0
   1B2A 11 E3 08      [10]  245 	ld	de,#_PLAYER_directionArray+0
   1B2D FD 21 E2 08   [14]  246 	ld	iy,#_PLAYER_directionIndex
   1B31 FD 6E 00      [19]  247 	ld	l,0 (iy)
   1B34 26 00         [ 7]  248 	ld	h,#0x00
   1B36 19            [11]  249 	add	hl,de
   1B37 7E            [ 7]  250 	ld	a,(hl)
   1B38 02            [ 7]  251 	ld	(bc),a
                            252 ;src/State_InGame.c:71: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   1B39 01 E1 08      [10]  253 	ld	bc,#_PLAYER_direction+1
   1B3C FD 21 E2 08   [14]  254 	ld	iy,#_PLAYER_directionIndex
   1B40 FD 6E 00      [19]  255 	ld	l,0 (iy)
   1B43 2C            [ 4]  256 	inc	l
   1B44 26 00         [ 7]  257 	ld	h,#0x00
   1B46 19            [11]  258 	add	hl,de
   1B47 7E            [ 7]  259 	ld	a,(hl)
   1B48 02            [ 7]  260 	ld	(bc),a
                            261 ;src/State_InGame.c:73: *(u8*)&updateRenderBuffer = 1;
   1B49 21 6E 1A      [10]  262 	ld	hl,#_updateRenderBuffer
   1B4C 36 01         [10]  263 	ld	(hl),#0x01
                            264 ;src/State_InGame.c:74: break;
   1B4E 18 5B         [12]  265 	jr	00107$
                            266 ;src/State_InGame.c:76: case 1:{
   1B50                     267 00102$:
                            268 ;src/State_InGame.c:77: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
   1B50 21 DE 08      [10]  269 	ld	hl,#_PLAYER_position+0
   1B53 4D            [ 4]  270 	ld	c, l
   1B54 44            [ 4]  271 	ld	b, h
   1B55 5E            [ 7]  272 	ld	e,(hl)
   1B56 21 E0 08      [10]  273 	ld	hl,#_PLAYER_direction+0
   1B59 56            [ 7]  274 	ld	d,(hl)
   1B5A 7B            [ 4]  275 	ld	a,e
   1B5B 82            [ 4]  276 	add	a, d
   1B5C 02            [ 7]  277 	ld	(bc),a
                            278 ;src/State_InGame.c:78: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
   1B5D 21 DF 08      [10]  279 	ld	hl,#_PLAYER_position+1
   1B60 4D            [ 4]  280 	ld	c, l
   1B61 44            [ 4]  281 	ld	b, h
   1B62 5E            [ 7]  282 	ld	e,(hl)
   1B63 21 E1 08      [10]  283 	ld	hl,#_PLAYER_direction+1
   1B66 56            [ 7]  284 	ld	d,(hl)
   1B67 7B            [ 4]  285 	ld	a,e
   1B68 82            [ 4]  286 	add	a, d
   1B69 02            [ 7]  287 	ld	(bc),a
                            288 ;src/State_InGame.c:80: *(u8*)&updateRenderBuffer = 1;
   1B6A 21 6E 1A      [10]  289 	ld	hl,#_updateRenderBuffer
   1B6D 36 01         [10]  290 	ld	(hl),#0x01
                            291 ;src/State_InGame.c:81: break;
   1B6F 18 3A         [12]  292 	jr	00107$
                            293 ;src/State_InGame.c:83: case 2:{
   1B71                     294 00103$:
                            295 ;src/State_InGame.c:84: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
   1B71 11 E2 08      [10]  296 	ld	de,#_PLAYER_directionIndex+0
   1B74 0D            [ 4]  297 	dec	c
   1B75 0D            [ 4]  298 	dec	c
   1B76 79            [ 4]  299 	ld	a,c
   1B77 E6 07         [ 7]  300 	and	a, #0x07
   1B79 12            [ 7]  301 	ld	(de),a
                            302 ;src/State_InGame.c:85: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   1B7A 01 E0 08      [10]  303 	ld	bc,#_PLAYER_direction+0
   1B7D 11 E3 08      [10]  304 	ld	de,#_PLAYER_directionArray+0
   1B80 FD 21 E2 08   [14]  305 	ld	iy,#_PLAYER_directionIndex
   1B84 FD 6E 00      [19]  306 	ld	l,0 (iy)
   1B87 26 00         [ 7]  307 	ld	h,#0x00
   1B89 19            [11]  308 	add	hl,de
   1B8A 7E            [ 7]  309 	ld	a,(hl)
   1B8B 02            [ 7]  310 	ld	(bc),a
                            311 ;src/State_InGame.c:86: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   1B8C 01 E1 08      [10]  312 	ld	bc,#_PLAYER_direction+1
   1B8F FD 21 E2 08   [14]  313 	ld	iy,#_PLAYER_directionIndex
   1B93 FD 6E 00      [19]  314 	ld	l,0 (iy)
   1B96 2C            [ 4]  315 	inc	l
   1B97 26 00         [ 7]  316 	ld	h,#0x00
   1B99 19            [11]  317 	add	hl,de
   1B9A 7E            [ 7]  318 	ld	a,(hl)
   1B9B 02            [ 7]  319 	ld	(bc),a
                            320 ;src/State_InGame.c:87: *(u8*)&updateRenderBuffer = 1;
   1B9C 21 6E 1A      [10]  321 	ld	hl,#_updateRenderBuffer
                            322 ;src/State_InGame.c:88: break;
                            323 ;src/State_InGame.c:90: case 3:{
                            324 ;src/State_InGame.c:92: break;
                            325 ;src/State_InGame.c:94: case 4:{
                            326 ;src/State_InGame.c:96: break;
   1B9F 36 01         [10]  327 	ld	(hl), #0x01
   1BA1 18 08         [12]  328 	jr	00107$
                            329 ;src/State_InGame.c:98: case 5:{
   1BA3                     330 00106$:
                            331 ;src/State_InGame.c:99: statemanager_set_state(STATE_PAUSEMENU);
   1BA3 3E 02         [ 7]  332 	ld	a,#0x02
   1BA5 F5            [11]  333 	push	af
   1BA6 33            [ 6]  334 	inc	sp
   1BA7 CD 70 1C      [17]  335 	call	_statemanager_set_state
   1BAA 33            [ 6]  336 	inc	sp
                            337 ;src/State_InGame.c:102: }
   1BAB                     338 00107$:
                            339 ;src/State_InGame.c:103: ui_gamemenu_unselect_entry();
   1BAB CD 17 20      [17]  340 	call	_ui_gamemenu_unselect_entry
   1BAE                     341 00109$:
                            342 ;src/State_InGame.c:106: if(updateRenderBuffer){
   1BAE 3A 6E 1A      [13]  343 	ld	a,(#_updateRenderBuffer + 0)
   1BB1 B7            [ 4]  344 	or	a, a
   1BB2 C8            [11]  345 	ret	Z
                            346 ;src/State_InGame.c:107: render_draw_to_buffer();
   1BB3 CD AB 0D      [17]  347 	call	_render_draw_to_buffer
                            348 ;src/State_InGame.c:108: draw_minimap_to_buffer();
   1BB6 CD 05 19      [17]  349 	call	_draw_minimap_to_buffer
                            350 ;src/State_InGame.c:109: *(u8*)&updateRenderBuffer = 0;
   1BB9 21 6E 1A      [10]  351 	ld	hl,#_updateRenderBuffer
   1BBC 36 00         [10]  352 	ld	(hl),#0x00
   1BBE C9            [10]  353 	ret
                            354 ;src/State_InGame.c:114: void state_ingame_render(){
                            355 ;	---------------------------------
                            356 ; Function state_ingame_render
                            357 ; ---------------------------------
   1BBF                     358 _state_ingame_render::
                            359 ;src/State_InGame.c:115: ui_gamemenu_render();
   1BBF CD 23 20      [17]  360 	call	_ui_gamemenu_render
                            361 ;src/State_InGame.c:116: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   1BC2 21 28 64      [10]  362 	ld	hl,#0x6428
   1BC5 E5            [11]  363 	push	hl
   1BC6 21 B4 C0      [10]  364 	ld	hl,#0xC0B4
   1BC9 E5            [11]  365 	push	hl
   1BCA 21 00 8B      [10]  366 	ld	hl,#0x8B00
   1BCD E5            [11]  367 	push	hl
   1BCE CD DF 3D      [17]  368 	call	_cpct_drawSprite
                            369 ;src/State_InGame.c:117: renderCompass();
   1BD1 CD AD 1F      [17]  370 	call	_renderCompass
                            371 ;src/State_InGame.c:118: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   1BD4 21 10 40      [10]  372 	ld	hl,#0x4010
   1BD7 E5            [11]  373 	push	hl
   1BD8 21 70 C5      [10]  374 	ld	hl,#0xC570
   1BDB E5            [11]  375 	push	hl
   1BDC 21 A0 9A      [10]  376 	ld	hl,#0x9AA0
   1BDF E5            [11]  377 	push	hl
   1BE0 CD DF 3D      [17]  378 	call	_cpct_drawSprite
   1BE3 C9            [10]  379 	ret
                            380 ;src/State_InGame.c:121: void state_ingame_exit(){
                            381 ;	---------------------------------
                            382 ; Function state_ingame_exit
                            383 ; ---------------------------------
   1BE4                     384 _state_ingame_exit::
                            385 ;src/State_InGame.c:122: *(u8*)&isInitialized = 0;
   1BE4 21 6D 1A      [10]  386 	ld	hl,#_isInitialized
   1BE7 36 00         [10]  387 	ld	(hl),#0x00
   1BE9 C9            [10]  388 	ret
                            389 	.area _CODE
                            390 	.area _INITIALIZER
                            391 	.area _CABS (ABS)
