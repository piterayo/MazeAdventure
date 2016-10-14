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
                             11 	.globl _ui_gamemenu_render_refresh
                             12 	.globl _ui_gamemenu_unselect_entry
                             13 	.globl _ui_gamemenu_select_entry
                             14 	.globl _ui_gamemenu_previous_entry
                             15 	.globl _ui_gamemenu_next_entry
                             16 	.globl _ui_gamemenu_is_selected
                             17 	.globl _ui_gamemenu_get_entry
                             18 	.globl _ui_gamemenu_init
                             19 	.globl _renderCompass
                             20 	.globl _level_load_level
                             21 	.globl _level_set_level
                             22 	.globl _draw_minimap_to_buffer
                             23 	.globl _render_draw_to_buffer
                             24 	.globl _generate_level
                             25 	.globl _statemanager_input_accepted
                             26 	.globl _statemanager_set_state
                             27 	.globl _cpct_drawSprite
                             28 	.globl _cpct_isKeyPressed
                             29 	.globl _cpct_memset
                             30 	.globl _updateRenderBuffer
                             31 	.globl _isInitialized
                             32 	.globl _state_ingame_enter
                             33 	.globl _state_ingame_input
                             34 	.globl _state_ingame_update
                             35 	.globl _state_ingame_render
                             36 	.globl _state_ingame_exit
                             37 ;--------------------------------------------------------
                             38 ; special function registers
                             39 ;--------------------------------------------------------
                             40 ;--------------------------------------------------------
                             41 ; ram data
                             42 ;--------------------------------------------------------
                             43 	.area _DATA
                             44 ;--------------------------------------------------------
                             45 ; ram data
                             46 ;--------------------------------------------------------
                             47 	.area _INITIALIZED
                             48 ;--------------------------------------------------------
                             49 ; absolute external ram data
                             50 ;--------------------------------------------------------
                             51 	.area _DABS (ABS)
                             52 ;--------------------------------------------------------
                             53 ; global & static initialisations
                             54 ;--------------------------------------------------------
                             55 	.area _HOME
                             56 	.area _GSINIT
                             57 	.area _GSFINAL
                             58 	.area _GSINIT
                             59 ;--------------------------------------------------------
                             60 ; Home
                             61 ;--------------------------------------------------------
                             62 	.area _HOME
                             63 	.area _HOME
                             64 ;--------------------------------------------------------
                             65 ; code
                             66 ;--------------------------------------------------------
                             67 	.area _CODE
                             68 ;src/State_InGame.c:22: void state_ingame_enter(){
                             69 ;	---------------------------------
                             70 ; Function state_ingame_enter
                             71 ; ---------------------------------
   1A3B                      72 _state_ingame_enter::
                             73 ;src/State_InGame.c:23: if(!isInitialized){
   1A3B 3A 70 1A      [13]   74 	ld	a,(#_isInitialized + 0)
   1A3E B7            [ 4]   75 	or	a, a
   1A3F 20 1B         [12]   76 	jr	NZ,00102$
                             77 ;src/State_InGame.c:24: generate_level();
   1A41 CD AF 08      [17]   78 	call	_generate_level
                             79 ;src/State_InGame.c:25: level_set_level(0);
   1A44 AF            [ 4]   80 	xor	a, a
   1A45 F5            [11]   81 	push	af
   1A46 33            [ 6]   82 	inc	sp
   1A47 CD FF 00      [17]   83 	call	_level_set_level
   1A4A 33            [ 6]   84 	inc	sp
                             85 ;src/State_InGame.c:26: level_load_level();
   1A4B CD 68 01      [17]   86 	call	_level_load_level
                             87 ;src/State_InGame.c:28: ui_gamemenu_init();
   1A4E CD FB 23      [17]   88 	call	_ui_gamemenu_init
                             89 ;src/State_InGame.c:30: render_draw_to_buffer();
   1A51 CD AB 0D      [17]   90 	call	_render_draw_to_buffer
                             91 ;src/State_InGame.c:31: draw_minimap_to_buffer();
   1A54 CD 05 19      [17]   92 	call	_draw_minimap_to_buffer
                             93 ;src/State_InGame.c:32: *(u8*)&isInitialized = 1;
   1A57 21 70 1A      [10]   94 	ld	hl,#_isInitialized
   1A5A 36 01         [10]   95 	ld	(hl),#0x01
   1A5C                      96 00102$:
                             97 ;src/State_InGame.c:34: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
   1A5C 21 B1 0A      [10]   98 	ld	hl,#_g_colors+12
   1A5F 46            [ 7]   99 	ld	b,(hl)
   1A60 21 00 40      [10]  100 	ld	hl,#0x4000
   1A63 E5            [11]  101 	push	hl
   1A64 C5            [11]  102 	push	bc
   1A65 33            [ 6]  103 	inc	sp
   1A66 26 C0         [ 7]  104 	ld	h, #0xC0
   1A68 E5            [11]  105 	push	hl
   1A69 CD 26 43      [17]  106 	call	_cpct_memset
                            107 ;src/State_InGame.c:35: state_ingame_render();
   1A6C CD C2 1B      [17]  108 	call	_state_ingame_render
   1A6F C9            [10]  109 	ret
   1A70                     110 _isInitialized:
   1A70 00                  111 	.db #0x00	; 0
   1A71                     112 _updateRenderBuffer:
   1A71 00                  113 	.db #0x00	; 0
                            114 ;src/State_InGame.c:38: void state_ingame_input(){
                            115 ;	---------------------------------
                            116 ; Function state_ingame_input
                            117 ; ---------------------------------
   1A72                     118 _state_ingame_input::
                            119 ;src/State_InGame.c:40: if(cpct_isKeyPressed(Key_CursorLeft)){
   1A72 21 01 01      [10]  120 	ld	hl,#0x0101
   1A75 CD 71 41      [17]  121 	call	_cpct_isKeyPressed
   1A78 7D            [ 4]  122 	ld	a,l
   1A79 B7            [ 4]  123 	or	a, a
   1A7A 28 06         [12]  124 	jr	Z,00116$
                            125 ;src/State_InGame.c:41: ui_gamemenu_previous_entry();
   1A7C CD 51 24      [17]  126 	call	_ui_gamemenu_previous_entry
                            127 ;src/State_InGame.c:42: statemanager_input_accepted();
   1A7F C3 89 1C      [10]  128 	jp  _statemanager_input_accepted
   1A82                     129 00116$:
                            130 ;src/State_InGame.c:44: else if(cpct_isKeyPressed(Key_CursorRight)){
   1A82 21 00 02      [10]  131 	ld	hl,#0x0200
   1A85 CD 71 41      [17]  132 	call	_cpct_isKeyPressed
   1A88 7D            [ 4]  133 	ld	a,l
   1A89 B7            [ 4]  134 	or	a, a
   1A8A 28 06         [12]  135 	jr	Z,00113$
                            136 ;src/State_InGame.c:45: ui_gamemenu_next_entry();
   1A8C CD 43 24      [17]  137 	call	_ui_gamemenu_next_entry
                            138 ;src/State_InGame.c:46: statemanager_input_accepted();
   1A8F C3 89 1C      [10]  139 	jp  _statemanager_input_accepted
   1A92                     140 00113$:
                            141 ;src/State_InGame.c:48: else if(cpct_isKeyPressed(Key_Return)){
   1A92 21 02 04      [10]  142 	ld	hl,#0x0402
   1A95 CD 71 41      [17]  143 	call	_cpct_isKeyPressed
   1A98 7D            [ 4]  144 	ld	a,l
   1A99 B7            [ 4]  145 	or	a, a
   1A9A 28 06         [12]  146 	jr	Z,00110$
                            147 ;src/State_InGame.c:49: ui_gamemenu_select_entry();
   1A9C CD 67 24      [17]  148 	call	_ui_gamemenu_select_entry
                            149 ;src/State_InGame.c:50: statemanager_input_accepted();
   1A9F C3 89 1C      [10]  150 	jp  _statemanager_input_accepted
   1AA2                     151 00110$:
                            152 ;src/State_InGame.c:53: else if(cpct_isKeyPressed(Key_1)){
   1AA2 21 08 01      [10]  153 	ld	hl,#0x0108
   1AA5 CD 71 41      [17]  154 	call	_cpct_isKeyPressed
   1AA8 7D            [ 4]  155 	ld	a,l
   1AA9 B7            [ 4]  156 	or	a, a
   1AAA 28 0D         [12]  157 	jr	Z,00107$
                            158 ;src/State_InGame.c:54: level_set_level(0);
   1AAC AF            [ 4]  159 	xor	a, a
   1AAD F5            [11]  160 	push	af
   1AAE 33            [ 6]  161 	inc	sp
   1AAF CD FF 00      [17]  162 	call	_level_set_level
   1AB2 33            [ 6]  163 	inc	sp
                            164 ;src/State_InGame.c:55: level_load_level();
   1AB3 CD 68 01      [17]  165 	call	_level_load_level
                            166 ;src/State_InGame.c:56: statemanager_input_accepted();
   1AB6 C3 89 1C      [10]  167 	jp  _statemanager_input_accepted
   1AB9                     168 00107$:
                            169 ;src/State_InGame.c:58: else if(cpct_isKeyPressed(Key_2)){ 
   1AB9 21 08 02      [10]  170 	ld	hl,#0x0208
   1ABC CD 71 41      [17]  171 	call	_cpct_isKeyPressed
   1ABF 7D            [ 4]  172 	ld	a,l
   1AC0 B7            [ 4]  173 	or	a, a
   1AC1 28 0E         [12]  174 	jr	Z,00104$
                            175 ;src/State_InGame.c:59: level_set_level(9);
   1AC3 3E 09         [ 7]  176 	ld	a,#0x09
   1AC5 F5            [11]  177 	push	af
   1AC6 33            [ 6]  178 	inc	sp
   1AC7 CD FF 00      [17]  179 	call	_level_set_level
   1ACA 33            [ 6]  180 	inc	sp
                            181 ;src/State_InGame.c:60: level_load_level();
   1ACB CD 68 01      [17]  182 	call	_level_load_level
                            183 ;src/State_InGame.c:61: statemanager_input_accepted();
   1ACE C3 89 1C      [10]  184 	jp  _statemanager_input_accepted
   1AD1                     185 00104$:
                            186 ;src/State_InGame.c:63: else if(cpct_isKeyPressed(Key_T)){
   1AD1 21 06 08      [10]  187 	ld	hl,#0x0806
   1AD4 CD 71 41      [17]  188 	call	_cpct_isKeyPressed
   1AD7 7D            [ 4]  189 	ld	a,l
   1AD8 B7            [ 4]  190 	or	a, a
   1AD9 C8            [11]  191 	ret	Z
                            192 ;src/State_InGame.c:64: *(u8*)&g_texturedWalls = !g_texturedWalls;
   1ADA 3A B7 0A      [13]  193 	ld	a,(#_g_texturedWalls + 0)
   1ADD D6 01         [ 7]  194 	sub	a,#0x01
   1ADF 3E 00         [ 7]  195 	ld	a,#0x00
   1AE1 17            [ 4]  196 	rla
   1AE2 4F            [ 4]  197 	ld	c,a
   1AE3 21 B7 0A      [10]  198 	ld	hl,#_g_texturedWalls
   1AE6 71            [ 7]  199 	ld	(hl),c
                            200 ;src/State_InGame.c:65: statemanager_input_accepted();
   1AE7 C3 89 1C      [10]  201 	jp  _statemanager_input_accepted
                            202 ;src/State_InGame.c:69: void state_ingame_update(){
                            203 ;	---------------------------------
                            204 ; Function state_ingame_update
                            205 ; ---------------------------------
   1AEA                     206 _state_ingame_update::
                            207 ;src/State_InGame.c:71: if(ui_gamemenu_is_selected()){
   1AEA CD C5 25      [17]  208 	call	_ui_gamemenu_is_selected
   1AED 7D            [ 4]  209 	ld	a,l
   1AEE B7            [ 4]  210 	or	a, a
   1AEF CA B1 1B      [10]  211 	jp	Z,00109$
                            212 ;src/State_InGame.c:72: ui_gamemenu_render_refresh();
   1AF2 CD 6D 24      [17]  213 	call	_ui_gamemenu_render_refresh
                            214 ;src/State_InGame.c:73: switch(ui_gamemenu_get_entry()){
   1AF5 CD BD 25      [17]  215 	call	_ui_gamemenu_get_entry
   1AF8 5D            [ 4]  216 	ld	e,l
   1AF9 3E 05         [ 7]  217 	ld	a,#0x05
   1AFB 93            [ 4]  218 	sub	a, e
   1AFC DA AE 1B      [10]  219 	jp	C,00107$
                            220 ;src/State_InGame.c:75: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
   1AFF FD 21 E2 08   [14]  221 	ld	iy,#_PLAYER_directionIndex
   1B03 FD 4E 00      [19]  222 	ld	c,0 (iy)
                            223 ;src/State_InGame.c:73: switch(ui_gamemenu_get_entry()){
   1B06 16 00         [ 7]  224 	ld	d,#0x00
   1B08 21 0F 1B      [10]  225 	ld	hl,#00126$
   1B0B 19            [11]  226 	add	hl,de
   1B0C 19            [11]  227 	add	hl,de
   1B0D 19            [11]  228 	add	hl,de
   1B0E E9            [ 4]  229 	jp	(hl)
   1B0F                     230 00126$:
   1B0F C3 21 1B      [10]  231 	jp	00101$
   1B12 C3 53 1B      [10]  232 	jp	00102$
   1B15 C3 74 1B      [10]  233 	jp	00103$
   1B18 C3 AE 1B      [10]  234 	jp	00107$
   1B1B C3 AE 1B      [10]  235 	jp	00107$
   1B1E C3 A6 1B      [10]  236 	jp	00106$
                            237 ;src/State_InGame.c:74: case 0:{
   1B21                     238 00101$:
                            239 ;src/State_InGame.c:75: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
   1B21 11 E2 08      [10]  240 	ld	de,#_PLAYER_directionIndex+0
   1B24 0C            [ 4]  241 	inc	c
   1B25 0C            [ 4]  242 	inc	c
   1B26 79            [ 4]  243 	ld	a,c
   1B27 E6 07         [ 7]  244 	and	a, #0x07
   1B29 12            [ 7]  245 	ld	(de),a
                            246 ;src/State_InGame.c:76: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   1B2A 01 E0 08      [10]  247 	ld	bc,#_PLAYER_direction+0
   1B2D 11 E3 08      [10]  248 	ld	de,#_PLAYER_directionArray+0
   1B30 FD 21 E2 08   [14]  249 	ld	iy,#_PLAYER_directionIndex
   1B34 FD 6E 00      [19]  250 	ld	l,0 (iy)
   1B37 26 00         [ 7]  251 	ld	h,#0x00
   1B39 19            [11]  252 	add	hl,de
   1B3A 7E            [ 7]  253 	ld	a,(hl)
   1B3B 02            [ 7]  254 	ld	(bc),a
                            255 ;src/State_InGame.c:77: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   1B3C 01 E1 08      [10]  256 	ld	bc,#_PLAYER_direction+1
   1B3F FD 21 E2 08   [14]  257 	ld	iy,#_PLAYER_directionIndex
   1B43 FD 6E 00      [19]  258 	ld	l,0 (iy)
   1B46 2C            [ 4]  259 	inc	l
   1B47 26 00         [ 7]  260 	ld	h,#0x00
   1B49 19            [11]  261 	add	hl,de
   1B4A 7E            [ 7]  262 	ld	a,(hl)
   1B4B 02            [ 7]  263 	ld	(bc),a
                            264 ;src/State_InGame.c:79: *(u8*)&updateRenderBuffer = 1;
   1B4C 21 71 1A      [10]  265 	ld	hl,#_updateRenderBuffer
   1B4F 36 01         [10]  266 	ld	(hl),#0x01
                            267 ;src/State_InGame.c:80: break;
   1B51 18 5B         [12]  268 	jr	00107$
                            269 ;src/State_InGame.c:82: case 1:{
   1B53                     270 00102$:
                            271 ;src/State_InGame.c:83: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
   1B53 21 DE 08      [10]  272 	ld	hl,#_PLAYER_position+0
   1B56 4D            [ 4]  273 	ld	c, l
   1B57 44            [ 4]  274 	ld	b, h
   1B58 5E            [ 7]  275 	ld	e,(hl)
   1B59 21 E0 08      [10]  276 	ld	hl,#_PLAYER_direction+0
   1B5C 56            [ 7]  277 	ld	d,(hl)
   1B5D 7B            [ 4]  278 	ld	a,e
   1B5E 82            [ 4]  279 	add	a, d
   1B5F 02            [ 7]  280 	ld	(bc),a
                            281 ;src/State_InGame.c:84: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
   1B60 21 DF 08      [10]  282 	ld	hl,#_PLAYER_position+1
   1B63 4D            [ 4]  283 	ld	c, l
   1B64 44            [ 4]  284 	ld	b, h
   1B65 5E            [ 7]  285 	ld	e,(hl)
   1B66 21 E1 08      [10]  286 	ld	hl,#_PLAYER_direction+1
   1B69 56            [ 7]  287 	ld	d,(hl)
   1B6A 7B            [ 4]  288 	ld	a,e
   1B6B 82            [ 4]  289 	add	a, d
   1B6C 02            [ 7]  290 	ld	(bc),a
                            291 ;src/State_InGame.c:86: *(u8*)&updateRenderBuffer = 1;
   1B6D 21 71 1A      [10]  292 	ld	hl,#_updateRenderBuffer
   1B70 36 01         [10]  293 	ld	(hl),#0x01
                            294 ;src/State_InGame.c:87: break;
   1B72 18 3A         [12]  295 	jr	00107$
                            296 ;src/State_InGame.c:89: case 2:{
   1B74                     297 00103$:
                            298 ;src/State_InGame.c:90: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
   1B74 11 E2 08      [10]  299 	ld	de,#_PLAYER_directionIndex+0
   1B77 0D            [ 4]  300 	dec	c
   1B78 0D            [ 4]  301 	dec	c
   1B79 79            [ 4]  302 	ld	a,c
   1B7A E6 07         [ 7]  303 	and	a, #0x07
   1B7C 12            [ 7]  304 	ld	(de),a
                            305 ;src/State_InGame.c:91: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   1B7D 01 E0 08      [10]  306 	ld	bc,#_PLAYER_direction+0
   1B80 11 E3 08      [10]  307 	ld	de,#_PLAYER_directionArray+0
   1B83 FD 21 E2 08   [14]  308 	ld	iy,#_PLAYER_directionIndex
   1B87 FD 6E 00      [19]  309 	ld	l,0 (iy)
   1B8A 26 00         [ 7]  310 	ld	h,#0x00
   1B8C 19            [11]  311 	add	hl,de
   1B8D 7E            [ 7]  312 	ld	a,(hl)
   1B8E 02            [ 7]  313 	ld	(bc),a
                            314 ;src/State_InGame.c:92: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   1B8F 01 E1 08      [10]  315 	ld	bc,#_PLAYER_direction+1
   1B92 FD 21 E2 08   [14]  316 	ld	iy,#_PLAYER_directionIndex
   1B96 FD 6E 00      [19]  317 	ld	l,0 (iy)
   1B99 2C            [ 4]  318 	inc	l
   1B9A 26 00         [ 7]  319 	ld	h,#0x00
   1B9C 19            [11]  320 	add	hl,de
   1B9D 7E            [ 7]  321 	ld	a,(hl)
   1B9E 02            [ 7]  322 	ld	(bc),a
                            323 ;src/State_InGame.c:94: *(u8*)&updateRenderBuffer = 1;
   1B9F 21 71 1A      [10]  324 	ld	hl,#_updateRenderBuffer
                            325 ;src/State_InGame.c:95: break;
                            326 ;src/State_InGame.c:97: case 3:{
                            327 ;src/State_InGame.c:99: break;
                            328 ;src/State_InGame.c:101: case 4:{
                            329 ;src/State_InGame.c:103: break;
   1BA2 36 01         [10]  330 	ld	(hl), #0x01
   1BA4 18 08         [12]  331 	jr	00107$
                            332 ;src/State_InGame.c:105: case 5:{
   1BA6                     333 00106$:
                            334 ;src/State_InGame.c:106: statemanager_set_state(STATE_PAUSEMENU);
   1BA6 3E 02         [ 7]  335 	ld	a,#0x02
   1BA8 F5            [11]  336 	push	af
   1BA9 33            [ 6]  337 	inc	sp
   1BAA CD 8F 1C      [17]  338 	call	_statemanager_set_state
   1BAD 33            [ 6]  339 	inc	sp
                            340 ;src/State_InGame.c:109: }
   1BAE                     341 00107$:
                            342 ;src/State_InGame.c:110: ui_gamemenu_unselect_entry();
   1BAE CD 61 24      [17]  343 	call	_ui_gamemenu_unselect_entry
   1BB1                     344 00109$:
                            345 ;src/State_InGame.c:113: if(updateRenderBuffer){
   1BB1 3A 71 1A      [13]  346 	ld	a,(#_updateRenderBuffer + 0)
   1BB4 B7            [ 4]  347 	or	a, a
   1BB5 C8            [11]  348 	ret	Z
                            349 ;src/State_InGame.c:114: render_draw_to_buffer();
   1BB6 CD AB 0D      [17]  350 	call	_render_draw_to_buffer
                            351 ;src/State_InGame.c:115: draw_minimap_to_buffer();
   1BB9 CD 05 19      [17]  352 	call	_draw_minimap_to_buffer
                            353 ;src/State_InGame.c:116: *(u8*)&updateRenderBuffer = 0;
   1BBC 21 71 1A      [10]  354 	ld	hl,#_updateRenderBuffer
   1BBF 36 00         [10]  355 	ld	(hl),#0x00
   1BC1 C9            [10]  356 	ret
                            357 ;src/State_InGame.c:121: void state_ingame_render(){
                            358 ;	---------------------------------
                            359 ; Function state_ingame_render
                            360 ; ---------------------------------
   1BC2                     361 _state_ingame_render::
                            362 ;src/State_InGame.c:122: ui_gamemenu_render_refresh();
   1BC2 CD 6D 24      [17]  363 	call	_ui_gamemenu_render_refresh
                            364 ;src/State_InGame.c:123: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   1BC5 21 28 64      [10]  365 	ld	hl,#0x6428
   1BC8 E5            [11]  366 	push	hl
   1BC9 21 B4 C0      [10]  367 	ld	hl,#0xC0B4
   1BCC E5            [11]  368 	push	hl
   1BCD 21 00 8B      [10]  369 	ld	hl,#0x8B00
   1BD0 E5            [11]  370 	push	hl
   1BD1 CD A0 41      [17]  371 	call	_cpct_drawSprite
                            372 ;src/State_InGame.c:124: renderCompass();
   1BD4 CD DB 23      [17]  373 	call	_renderCompass
                            374 ;src/State_InGame.c:125: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   1BD7 21 10 40      [10]  375 	ld	hl,#0x4010
   1BDA E5            [11]  376 	push	hl
   1BDB 21 70 C5      [10]  377 	ld	hl,#0xC570
   1BDE E5            [11]  378 	push	hl
   1BDF 21 A0 9A      [10]  379 	ld	hl,#0x9AA0
   1BE2 E5            [11]  380 	push	hl
   1BE3 CD A0 41      [17]  381 	call	_cpct_drawSprite
   1BE6 C9            [10]  382 	ret
                            383 ;src/State_InGame.c:128: void state_ingame_exit(){
                            384 ;	---------------------------------
                            385 ; Function state_ingame_exit
                            386 ; ---------------------------------
   1BE7                     387 _state_ingame_exit::
                            388 ;src/State_InGame.c:129: *(u8*)&isInitialized = 0;
   1BE7 21 70 1A      [10]  389 	ld	hl,#_isInitialized
   1BEA 36 00         [10]  390 	ld	(hl),#0x00
   1BEC C9            [10]  391 	ret
                            392 	.area _CODE
                            393 	.area _INITIALIZER
                            394 	.area _CABS (ABS)
