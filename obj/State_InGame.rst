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
                             11 	.globl _renderCompass
                             12 	.globl _level_load_level
                             13 	.globl _draw_minimap_to_buffer
                             14 	.globl _render_draw_to_buffer
                             15 	.globl _generate_level
                             16 	.globl _statemanager_input_accepted
                             17 	.globl _statemanager_set_state
                             18 	.globl _cpct_drawSprite
                             19 	.globl _cpct_isKeyPressed
                             20 	.globl _cpct_memset
                             21 	.globl _needRender
                             22 	.globl _isInitialized
                             23 	.globl _state_ingame_enter
                             24 	.globl _state_ingame_input
                             25 	.globl _state_ingame_update
                             26 	.globl _state_ingame_render
                             27 	.globl _state_ingame_exit
                             28 ;--------------------------------------------------------
                             29 ; special function registers
                             30 ;--------------------------------------------------------
                             31 ;--------------------------------------------------------
                             32 ; ram data
                             33 ;--------------------------------------------------------
                             34 	.area _DATA
                             35 ;--------------------------------------------------------
                             36 ; ram data
                             37 ;--------------------------------------------------------
                             38 	.area _INITIALIZED
                             39 ;--------------------------------------------------------
                             40 ; absolute external ram data
                             41 ;--------------------------------------------------------
                             42 	.area _DABS (ABS)
                             43 ;--------------------------------------------------------
                             44 ; global & static initialisations
                             45 ;--------------------------------------------------------
                             46 	.area _HOME
                             47 	.area _GSINIT
                             48 	.area _GSFINAL
                             49 	.area _GSINIT
                             50 ;--------------------------------------------------------
                             51 ; Home
                             52 ;--------------------------------------------------------
                             53 	.area _HOME
                             54 	.area _HOME
                             55 ;--------------------------------------------------------
                             56 ; code
                             57 ;--------------------------------------------------------
                             58 	.area _CODE
                             59 ;src/State_InGame.c:18: void state_ingame_enter(){
                             60 ;	---------------------------------
                             61 ; Function state_ingame_enter
                             62 ; ---------------------------------
   69E4                      63 _state_ingame_enter::
                             64 ;src/State_InGame.c:19: if(!isInitialized){
   69E4 3A 13 6A      [13]   65 	ld	a,(#_isInitialized + 0)
   69E7 B7            [ 4]   66 	or	a, a
   69E8 20 15         [12]   67 	jr	NZ,00102$
                             68 ;src/State_InGame.c:20: generate_level();
   69EA CD 73 58      [17]   69 	call	_generate_level
                             70 ;src/State_InGame.c:21: level_load_level(0);
   69ED AF            [ 4]   71 	xor	a, a
   69EE F5            [11]   72 	push	af
   69EF 33            [ 6]   73 	inc	sp
   69F0 CD C9 50      [17]   74 	call	_level_load_level
   69F3 33            [ 6]   75 	inc	sp
                             76 ;src/State_InGame.c:22: render_draw_to_buffer();
   69F4 CD 54 5D      [17]   77 	call	_render_draw_to_buffer
                             78 ;src/State_InGame.c:23: draw_minimap_to_buffer();
   69F7 CD AE 68      [17]   79 	call	_draw_minimap_to_buffer
                             80 ;src/State_InGame.c:24: *(u8*)&isInitialized = 1;
   69FA 21 13 6A      [10]   81 	ld	hl,#_isInitialized
   69FD 36 01         [10]   82 	ld	(hl),#0x01
   69FF                      83 00102$:
                             84 ;src/State_InGame.c:26: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
   69FF 21 57 5A      [10]   85 	ld	hl,#_g_colors+12
   6A02 46            [ 7]   86 	ld	b,(hl)
   6A03 21 00 40      [10]   87 	ld	hl,#0x4000
   6A06 E5            [11]   88 	push	hl
   6A07 C5            [11]   89 	push	bc
   6A08 33            [ 6]   90 	inc	sp
   6A09 26 C0         [ 7]   91 	ld	h, #0xC0
   6A0B E5            [11]   92 	push	hl
   6A0C CD F1 8E      [17]   93 	call	_cpct_memset
                             94 ;src/State_InGame.c:27: state_ingame_render();
   6A0F CD 51 6B      [17]   95 	call	_state_ingame_render
   6A12 C9            [10]   96 	ret
   6A13                      97 _isInitialized:
   6A13 00                   98 	.db #0x00	; 0
   6A14                      99 _needRender:
   6A14 00                  100 	.db #0x00	; 0
                            101 ;src/State_InGame.c:30: void state_ingame_input(){
                            102 ;	---------------------------------
                            103 ; Function state_ingame_input
                            104 ; ---------------------------------
   6A15                     105 _state_ingame_input::
                            106 ;src/State_InGame.c:32: if(cpct_isKeyPressed(Key_CursorLeft)){
   6A15 21 01 01      [10]  107 	ld	hl,#0x0101
   6A18 CD 21 8C      [17]  108 	call	_cpct_isKeyPressed
   6A1B 7D            [ 4]  109 	ld	a, l
   6A1C B7            [ 4]  110 	or	a, a
   6A1D 28 35         [12]  111 	jr	Z,00122$
                            112 ;src/State_InGame.c:33: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
   6A1F 01 83 58      [10]  113 	ld	bc,#_PLAYER_directionIndex+0
   6A22 3A 83 58      [13]  114 	ld	a,(#_PLAYER_directionIndex + 0)
   6A25 C6 02         [ 7]  115 	add	a, #0x02
   6A27 E6 07         [ 7]  116 	and	a, #0x07
   6A29 02            [ 7]  117 	ld	(bc),a
                            118 ;src/State_InGame.c:34: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   6A2A 01 81 58      [10]  119 	ld	bc,#_PLAYER_direction+0
   6A2D 11 84 58      [10]  120 	ld	de,#_PLAYER_directionArray+0
   6A30 FD 21 83 58   [14]  121 	ld	iy,#_PLAYER_directionIndex
   6A34 FD 6E 00      [19]  122 	ld	l,0 (iy)
   6A37 26 00         [ 7]  123 	ld	h,#0x00
   6A39 19            [11]  124 	add	hl,de
   6A3A 7E            [ 7]  125 	ld	a,(hl)
   6A3B 02            [ 7]  126 	ld	(bc),a
                            127 ;src/State_InGame.c:35: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   6A3C 01 82 58      [10]  128 	ld	bc,#_PLAYER_direction+1
   6A3F FD 21 83 58   [14]  129 	ld	iy,#_PLAYER_directionIndex
   6A43 FD 6E 00      [19]  130 	ld	l,0 (iy)
   6A46 2C            [ 4]  131 	inc	l
   6A47 26 00         [ 7]  132 	ld	h,#0x00
   6A49 19            [11]  133 	add	hl,de
   6A4A 7E            [ 7]  134 	ld	a,(hl)
   6A4B 02            [ 7]  135 	ld	(bc),a
                            136 ;src/State_InGame.c:37: *(u8*)&needRender = 1;
   6A4C 21 14 6A      [10]  137 	ld	hl,#_needRender
   6A4F 36 01         [10]  138 	ld	(hl),#0x01
                            139 ;src/State_InGame.c:38: statemanager_input_accepted();
   6A51 C3 0A 6C      [10]  140 	jp  _statemanager_input_accepted
   6A54                     141 00122$:
                            142 ;src/State_InGame.c:40: else if(cpct_isKeyPressed(Key_CursorRight)){
   6A54 21 00 02      [10]  143 	ld	hl,#0x0200
   6A57 CD 21 8C      [17]  144 	call	_cpct_isKeyPressed
   6A5A 7D            [ 4]  145 	ld	a,l
   6A5B B7            [ 4]  146 	or	a, a
   6A5C 28 33         [12]  147 	jr	Z,00119$
                            148 ;src/State_InGame.c:41: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
   6A5E 01 83 58      [10]  149 	ld	bc,#_PLAYER_directionIndex+0
   6A61 3A 83 58      [13]  150 	ld	a,(#_PLAYER_directionIndex + 0)
   6A64 C6 FE         [ 7]  151 	add	a,#0xFE
   6A66 E6 07         [ 7]  152 	and	a, #0x07
   6A68 02            [ 7]  153 	ld	(bc),a
                            154 ;src/State_InGame.c:42: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   6A69 11 81 58      [10]  155 	ld	de,#_PLAYER_direction+0
   6A6C 01 84 58      [10]  156 	ld	bc,#_PLAYER_directionArray+0
   6A6F FD 21 83 58   [14]  157 	ld	iy,#_PLAYER_directionIndex
   6A73 FD 6E 00      [19]  158 	ld	l,0 (iy)
   6A76 26 00         [ 7]  159 	ld	h,#0x00
   6A78 09            [11]  160 	add	hl,bc
   6A79 7E            [ 7]  161 	ld	a,(hl)
   6A7A 12            [ 7]  162 	ld	(de),a
                            163 ;src/State_InGame.c:43: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   6A7B 21 83 58      [10]  164 	ld	hl,#_PLAYER_directionIndex + 0
   6A7E 5E            [ 7]  165 	ld	e, (hl)
   6A7F 1C            [ 4]  166 	inc	e
   6A80 6B            [ 4]  167 	ld	l,e
   6A81 26 00         [ 7]  168 	ld	h,#0x00
   6A83 09            [11]  169 	add	hl,bc
   6A84 4E            [ 7]  170 	ld	c,(hl)
   6A85 21 82 58      [10]  171 	ld	hl,#(_PLAYER_direction + 0x0001)
   6A88 71            [ 7]  172 	ld	(hl),c
                            173 ;src/State_InGame.c:44: *(u8*)&needRender = 1;
   6A89 21 14 6A      [10]  174 	ld	hl,#_needRender
   6A8C 36 01         [10]  175 	ld	(hl),#0x01
                            176 ;src/State_InGame.c:45: statemanager_input_accepted();
   6A8E C3 0A 6C      [10]  177 	jp  _statemanager_input_accepted
   6A91                     178 00119$:
                            179 ;src/State_InGame.c:47: else if(cpct_isKeyPressed(Key_CursorUp)){
   6A91 21 00 01      [10]  180 	ld	hl,#0x0100
   6A94 CD 21 8C      [17]  181 	call	_cpct_isKeyPressed
   6A97 7D            [ 4]  182 	ld	a,l
   6A98 B7            [ 4]  183 	or	a, a
   6A99 28 22         [12]  184 	jr	Z,00116$
                            185 ;src/State_InGame.c:48: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
   6A9B 21 7F 58      [10]  186 	ld	hl,#_PLAYER_position+0
   6A9E 4D            [ 4]  187 	ld	c, l
   6A9F 44            [ 4]  188 	ld	b, h
   6AA0 56            [ 7]  189 	ld	d,(hl)
   6AA1 21 81 58      [10]  190 	ld	hl,#_PLAYER_direction+0
   6AA4 5E            [ 7]  191 	ld	e,(hl)
   6AA5 7A            [ 4]  192 	ld	a,d
   6AA6 83            [ 4]  193 	add	a, e
   6AA7 02            [ 7]  194 	ld	(bc),a
                            195 ;src/State_InGame.c:49: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
   6AA8 21 80 58      [10]  196 	ld	hl,#_PLAYER_position+1
   6AAB 4D            [ 4]  197 	ld	c, l
   6AAC 44            [ 4]  198 	ld	b, h
   6AAD 56            [ 7]  199 	ld	d,(hl)
   6AAE 21 82 58      [10]  200 	ld	hl,#_PLAYER_direction+1
   6AB1 5E            [ 7]  201 	ld	e,(hl)
   6AB2 7A            [ 4]  202 	ld	a,d
   6AB3 83            [ 4]  203 	add	a, e
   6AB4 02            [ 7]  204 	ld	(bc),a
                            205 ;src/State_InGame.c:51: *(u8*)&needRender = 1;
   6AB5 21 14 6A      [10]  206 	ld	hl,#_needRender
   6AB8 36 01         [10]  207 	ld	(hl),#0x01
                            208 ;src/State_InGame.c:52: statemanager_input_accepted();
   6ABA C3 0A 6C      [10]  209 	jp  _statemanager_input_accepted
   6ABD                     210 00116$:
                            211 ;src/State_InGame.c:54: else if(cpct_isKeyPressed(Key_CursorDown)){
   6ABD 21 00 04      [10]  212 	ld	hl,#0x0400
   6AC0 CD 21 8C      [17]  213 	call	_cpct_isKeyPressed
   6AC3 7D            [ 4]  214 	ld	a,l
   6AC4 B7            [ 4]  215 	or	a, a
   6AC5 28 22         [12]  216 	jr	Z,00113$
                            217 ;src/State_InGame.c:55: *(i8*)&(PLAYER_position.x) = PLAYER_position.x - PLAYER_direction.x;
   6AC7 21 7F 58      [10]  218 	ld	hl,#_PLAYER_position+0
   6ACA 4D            [ 4]  219 	ld	c, l
   6ACB 44            [ 4]  220 	ld	b, h
   6ACC 56            [ 7]  221 	ld	d,(hl)
   6ACD 21 81 58      [10]  222 	ld	hl,#_PLAYER_direction+0
   6AD0 5E            [ 7]  223 	ld	e,(hl)
   6AD1 7A            [ 4]  224 	ld	a,d
   6AD2 93            [ 4]  225 	sub	a, e
   6AD3 02            [ 7]  226 	ld	(bc),a
                            227 ;src/State_InGame.c:56: *(i8*)&(PLAYER_position.y) = PLAYER_position.y - PLAYER_direction.y;
   6AD4 21 80 58      [10]  228 	ld	hl,#_PLAYER_position+1
   6AD7 4D            [ 4]  229 	ld	c, l
   6AD8 44            [ 4]  230 	ld	b, h
   6AD9 56            [ 7]  231 	ld	d,(hl)
   6ADA 21 82 58      [10]  232 	ld	hl,#_PLAYER_direction+1
   6ADD 5E            [ 7]  233 	ld	e,(hl)
   6ADE 7A            [ 4]  234 	ld	a,d
   6ADF 93            [ 4]  235 	sub	a, e
   6AE0 02            [ 7]  236 	ld	(bc),a
                            237 ;src/State_InGame.c:58: *(u8*)&needRender = 1;
   6AE1 21 14 6A      [10]  238 	ld	hl,#_needRender
   6AE4 36 01         [10]  239 	ld	(hl),#0x01
                            240 ;src/State_InGame.c:59: statemanager_input_accepted();
   6AE6 C3 0A 6C      [10]  241 	jp  _statemanager_input_accepted
   6AE9                     242 00113$:
                            243 ;src/State_InGame.c:61: else if(cpct_isKeyPressed(Key_0)){
   6AE9 21 04 01      [10]  244 	ld	hl,#0x0104
   6AEC CD 21 8C      [17]  245 	call	_cpct_isKeyPressed
   6AEF 7D            [ 4]  246 	ld	a,l
   6AF0 B7            [ 4]  247 	or	a, a
   6AF1 28 0A         [12]  248 	jr	Z,00110$
                            249 ;src/State_InGame.c:62: level_load_level(0);
   6AF3 AF            [ 4]  250 	xor	a, a
   6AF4 F5            [11]  251 	push	af
   6AF5 33            [ 6]  252 	inc	sp
   6AF6 CD C9 50      [17]  253 	call	_level_load_level
   6AF9 33            [ 6]  254 	inc	sp
                            255 ;src/State_InGame.c:63: statemanager_input_accepted();
   6AFA C3 0A 6C      [10]  256 	jp  _statemanager_input_accepted
   6AFD                     257 00110$:
                            258 ;src/State_InGame.c:65: else if(cpct_isKeyPressed(Key_1)){ 
   6AFD 21 08 01      [10]  259 	ld	hl,#0x0108
   6B00 CD 21 8C      [17]  260 	call	_cpct_isKeyPressed
   6B03 7D            [ 4]  261 	ld	a,l
   6B04 B7            [ 4]  262 	or	a, a
   6B05 28 0B         [12]  263 	jr	Z,00107$
                            264 ;src/State_InGame.c:66: level_load_level(9);
   6B07 3E 09         [ 7]  265 	ld	a,#0x09
   6B09 F5            [11]  266 	push	af
   6B0A 33            [ 6]  267 	inc	sp
   6B0B CD C9 50      [17]  268 	call	_level_load_level
   6B0E 33            [ 6]  269 	inc	sp
                            270 ;src/State_InGame.c:67: statemanager_input_accepted();
   6B0F C3 0A 6C      [10]  271 	jp  _statemanager_input_accepted
   6B12                     272 00107$:
                            273 ;src/State_InGame.c:69: else if(cpct_isKeyPressed(Key_T)){
   6B12 21 06 08      [10]  274 	ld	hl,#0x0806
   6B15 CD 21 8C      [17]  275 	call	_cpct_isKeyPressed
   6B18 7D            [ 4]  276 	ld	a,l
   6B19 B7            [ 4]  277 	or	a, a
   6B1A 28 10         [12]  278 	jr	Z,00104$
                            279 ;src/State_InGame.c:70: *(u8*)&g_texturedWalls = !g_texturedWalls;
   6B1C 3A 5D 5A      [13]  280 	ld	a,(#_g_texturedWalls + 0)
   6B1F D6 01         [ 7]  281 	sub	a,#0x01
   6B21 3E 00         [ 7]  282 	ld	a,#0x00
   6B23 17            [ 4]  283 	rla
   6B24 4F            [ 4]  284 	ld	c,a
   6B25 21 5D 5A      [10]  285 	ld	hl,#_g_texturedWalls
   6B28 71            [ 7]  286 	ld	(hl),c
                            287 ;src/State_InGame.c:71: statemanager_input_accepted();
   6B29 C3 0A 6C      [10]  288 	jp  _statemanager_input_accepted
   6B2C                     289 00104$:
                            290 ;src/State_InGame.c:73: else if(cpct_isKeyPressed(Key_P)){
   6B2C 21 03 08      [10]  291 	ld	hl,#0x0803
   6B2F CD 21 8C      [17]  292 	call	_cpct_isKeyPressed
   6B32 7D            [ 4]  293 	ld	a,l
   6B33 B7            [ 4]  294 	or	a, a
   6B34 C8            [11]  295 	ret	Z
                            296 ;src/State_InGame.c:74: statemanager_set_state(STATE_PAUSEMENU);
   6B35 3E 02         [ 7]  297 	ld	a,#0x02
   6B37 F5            [11]  298 	push	af
   6B38 33            [ 6]  299 	inc	sp
   6B39 CD 10 6C      [17]  300 	call	_statemanager_set_state
   6B3C 33            [ 6]  301 	inc	sp
                            302 ;src/State_InGame.c:75: statemanager_input_accepted();
   6B3D C3 0A 6C      [10]  303 	jp  _statemanager_input_accepted
                            304 ;src/State_InGame.c:79: void state_ingame_update(){
                            305 ;	---------------------------------
                            306 ; Function state_ingame_update
                            307 ; ---------------------------------
   6B40                     308 _state_ingame_update::
                            309 ;src/State_InGame.c:80: if(needRender){
   6B40 3A 14 6A      [13]  310 	ld	a,(#_needRender + 0)
   6B43 B7            [ 4]  311 	or	a, a
   6B44 C8            [11]  312 	ret	Z
                            313 ;src/State_InGame.c:81: render_draw_to_buffer();
   6B45 CD 54 5D      [17]  314 	call	_render_draw_to_buffer
                            315 ;src/State_InGame.c:82: draw_minimap_to_buffer();
   6B48 CD AE 68      [17]  316 	call	_draw_minimap_to_buffer
                            317 ;src/State_InGame.c:83: *(u8*)&needRender = 0;
   6B4B 21 14 6A      [10]  318 	ld	hl,#_needRender
   6B4E 36 00         [10]  319 	ld	(hl),#0x00
   6B50 C9            [10]  320 	ret
                            321 ;src/State_InGame.c:88: void state_ingame_render(){
                            322 ;	---------------------------------
                            323 ; Function state_ingame_render
                            324 ; ---------------------------------
   6B51                     325 _state_ingame_render::
                            326 ;src/State_InGame.c:89: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   6B51 21 28 64      [10]  327 	ld	hl,#0x6428
   6B54 E5            [11]  328 	push	hl
   6B55 21 B4 C0      [10]  329 	ld	hl,#0xC0B4
   6B58 E5            [11]  330 	push	hl
   6B59 21 40 29      [10]  331 	ld	hl,#0x2940
   6B5C E5            [11]  332 	push	hl
   6B5D CD DE 8C      [17]  333 	call	_cpct_drawSprite
                            334 ;src/State_InGame.c:90: renderCompass();
   6B60 CD 65 6F      [17]  335 	call	_renderCompass
                            336 ;src/State_InGame.c:91: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   6B63 21 10 40      [10]  337 	ld	hl,#0x4010
   6B66 E5            [11]  338 	push	hl
   6B67 21 70 C5      [10]  339 	ld	hl,#0xC570
   6B6A E5            [11]  340 	push	hl
   6B6B 21 E0 38      [10]  341 	ld	hl,#0x38E0
   6B6E E5            [11]  342 	push	hl
   6B6F CD DE 8C      [17]  343 	call	_cpct_drawSprite
   6B72 C9            [10]  344 	ret
                            345 ;src/State_InGame.c:94: void state_ingame_exit(){
                            346 ;	---------------------------------
                            347 ; Function state_ingame_exit
                            348 ; ---------------------------------
   6B73                     349 _state_ingame_exit::
                            350 ;src/State_InGame.c:95: *(u8*)&isInitialized = 0;
   6B73 21 13 6A      [10]  351 	ld	hl,#_isInitialized
   6B76 36 00         [10]  352 	ld	(hl),#0x00
   6B78 C9            [10]  353 	ret
                            354 	.area _CODE
                            355 	.area _INITIALIZER
                            356 	.area _CABS (ABS)
