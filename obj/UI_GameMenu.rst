                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_GameMenu
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_gamemenu_render_button
                             12 	.globl _integer_to_string
                             13 	.globl _print_transparent_text
                             14 	.globl _cpct_drawSolidBox
                             15 	.globl _ui_gamemenu_action
                             16 	.globl _ui_gamemenu_can_move
                             17 	.globl _ui_gamemenu_entrySelected
                             18 	.globl _ui_gamemenu_entryIndex
                             19 	.globl _ui_gamemenu_lastEntry
                             20 	.globl _ui_gamemenu_buttonWidths
                             21 	.globl _ui_gamemenu_buttonText
                             22 	.globl _ui_gamemenu_action_buttonText
                             23 	.globl _ui_gamemenu_entriesTextPosition
                             24 	.globl _ui_gamemenu_entriesPosition
                             25 	.globl _ui_gamemenu_init
                             26 	.globl _ui_gamemenu_above_entry
                             27 	.globl _ui_gamemenu_below_entry
                             28 	.globl _ui_gamemenu_next_entry
                             29 	.globl _ui_gamemenu_previous_entry
                             30 	.globl _ui_gamemenu_unselect_entry
                             31 	.globl _ui_gamemenu_select_entry
                             32 	.globl _ui_gamemenu_render_refresh
                             33 	.globl _ui_gamemenu_render_all
                             34 	.globl _ui_gamemenu_get_entry
                             35 	.globl _ui_gamemenu_is_selected
                             36 	.globl _ui_gamemenu_update_action
                             37 	.globl _ui_gamemenu_get_movement
                             38 	.globl _ui_gamemenu_get_action
                             39 ;--------------------------------------------------------
                             40 ; special function registers
                             41 ;--------------------------------------------------------
                             42 ;--------------------------------------------------------
                             43 ; ram data
                             44 ;--------------------------------------------------------
                             45 	.area _DATA
   7DA2                      46 _ui_gamemenu_lastEntry::
   7DA2                      47 	.ds 1
   7DA3                      48 _ui_gamemenu_entryIndex::
   7DA3                      49 	.ds 1
   7DA4                      50 _ui_gamemenu_entrySelected::
   7DA4                      51 	.ds 1
   7DA5                      52 _ui_gamemenu_can_move::
   7DA5                      53 	.ds 1
   7DA6                      54 _ui_gamemenu_action::
   7DA6                      55 	.ds 1
                             56 ;--------------------------------------------------------
                             57 ; ram data
                             58 ;--------------------------------------------------------
                             59 	.area _INITIALIZED
                             60 ;--------------------------------------------------------
                             61 ; absolute external ram data
                             62 ;--------------------------------------------------------
                             63 	.area _DABS (ABS)
                             64 ;--------------------------------------------------------
                             65 ; global & static initialisations
                             66 ;--------------------------------------------------------
                             67 	.area _HOME
                             68 	.area _GSINIT
                             69 	.area _GSFINAL
                             70 	.area _GSINIT
                             71 ;--------------------------------------------------------
                             72 ; Home
                             73 ;--------------------------------------------------------
                             74 	.area _HOME
                             75 	.area _HOME
                             76 ;--------------------------------------------------------
                             77 ; code
                             78 ;--------------------------------------------------------
                             79 	.area _CODE
                             80 ;src/UI_GameMenu.c:77: void ui_gamemenu_init(){
                             81 ;	---------------------------------
                             82 ; Function ui_gamemenu_init
                             83 ; ---------------------------------
   4252                      84 _ui_gamemenu_init::
                             85 ;src/UI_GameMenu.c:78: ui_gamemenu_lastEntry=0;
   4252 21 A2 7D      [10]   86 	ld	hl,#_ui_gamemenu_lastEntry + 0
   4255 36 00         [10]   87 	ld	(hl), #0x00
                             88 ;src/UI_GameMenu.c:79: ui_gamemenu_entryIndex=0;
   4257 21 A3 7D      [10]   89 	ld	hl,#_ui_gamemenu_entryIndex + 0
   425A 36 00         [10]   90 	ld	(hl), #0x00
                             91 ;src/UI_GameMenu.c:80: ui_gamemenu_entrySelected=0;
   425C 21 A4 7D      [10]   92 	ld	hl,#_ui_gamemenu_entrySelected + 0
   425F 36 00         [10]   93 	ld	(hl), #0x00
                             94 ;src/UI_GameMenu.c:81: ui_gamemenu_update_action();
   4261 C3 33 44      [10]   95 	jp  _ui_gamemenu_update_action
   4264                      96 _ui_gamemenu_entriesPosition:
   4264 50 C5                97 	.dw #0xC550
   4266 84 C5                98 	.dw #0xC584
   4268 E0 C6                99 	.dw #0xC6E0
   426A E7 C6               100 	.dw #0xC6E7
   426C F6 C6               101 	.dw #0xC6F6
   426E 14 C7               102 	.dw #0xC714
   4270 23 C7               103 	.dw #0xC723
   4272                     104 _ui_gamemenu_entriesTextPosition:
   4272 A4 CD               105 	.dw #0xCDA4
   4274 D9 CD               106 	.dw #0xCDD9
   4276 32 CF               107 	.dw #0xCF32
   4278 3A CF               108 	.dw #0xCF3A
   427A 48 CF               109 	.dw #0xCF48
   427C 67 CF               110 	.dw #0xCF67
   427E 75 CF               111 	.dw #0xCF75
   4280                     112 _ui_gamemenu_action_buttonText:
   4280 9B 42               113 	.dw __str_0
   4282 A6 42               114 	.dw __str_1
   4284 AF 42               115 	.dw __str_2
   4286                     116 _ui_gamemenu_buttonText:
   4286 B9 42               117 	.dw __str_3
   4288 BA 42               118 	.dw __str_4
   428A C4 42               119 	.dw __str_5
   428C B9 42               120 	.dw __str_3
   428E C6 42               121 	.dw __str_6
   4290 C8 42               122 	.dw __str_7
   4292 CD 42               123 	.dw __str_8
   4294                     124 _ui_gamemenu_buttonWidths:
   4294 1C                  125 	.db #0x1C	; 28
   4295 1C                  126 	.db #0x1C	; 28
   4296 06                  127 	.db #0x06	; 6
   4297 0E                  128 	.db #0x0E	; 14
   4298 06                  129 	.db #0x06	; 6
   4299 0D                  130 	.db #0x0D	; 13
   429A 0D                  131 	.db #0x0D	; 13
   429B                     132 __str_0:
   429B 4E 45 58 54 20 4C   133 	.ascii "NEXT LEVEL"
        45 56 45 4C
   42A5 00                  134 	.db 0x00
   42A6                     135 __str_1:
   42A6 20 20 41 54 54 41   136 	.ascii "  ATTACK"
        43 4B
   42AE 00                  137 	.db 0x00
   42AF                     138 __str_2:
   42AF 20 20 50 49 43 4B   139 	.ascii "  PICK UP"
        20 55 50
   42B8 00                  140 	.db 0x00
   42B9                     141 __str_3:
   42B9 00                  142 	.db 0x00
   42BA                     143 __str_4:
   42BA 49 4E 56 45 4E 54   144 	.ascii "INVENTORY"
        4F 52 59
   42C3 00                  145 	.db 0x00
   42C4                     146 __str_5:
   42C4 3C                  147 	.ascii "<"
   42C5 00                  148 	.db 0x00
   42C6                     149 __str_6:
   42C6 3E                  150 	.ascii ">"
   42C7 00                  151 	.db 0x00
   42C8                     152 __str_7:
   42C8 57 41 49 54         153 	.ascii "WAIT"
   42CC 00                  154 	.db 0x00
   42CD                     155 __str_8:
   42CD 50 41 55 53 45      156 	.ascii "PAUSE"
   42D2 00                  157 	.db 0x00
                            158 ;src/UI_GameMenu.c:84: void ui_gamemenu_above_entry(){
                            159 ;	---------------------------------
                            160 ; Function ui_gamemenu_above_entry
                            161 ; ---------------------------------
   42D3                     162 _ui_gamemenu_above_entry::
                            163 ;src/UI_GameMenu.c:85: if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
   42D3 3A A3 7D      [13]  164 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   42D6 FE 02         [ 7]  165 	cp	a,#0x02
   42D8 38 0A         [12]  166 	jr	C,00105$
   42DA D6 05         [ 7]  167 	sub	a, #0x05
   42DC 30 06         [12]  168 	jr	NC,00105$
                            169 ;src/UI_GameMenu.c:86: ui_gamemenu_entryIndex=0;
   42DE 21 A3 7D      [10]  170 	ld	hl,#_ui_gamemenu_entryIndex + 0
   42E1 36 00         [10]  171 	ld	(hl), #0x00
   42E3 C9            [10]  172 	ret
   42E4                     173 00105$:
                            174 ;src/UI_GameMenu.c:88: else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
   42E4 3A A3 7D      [13]  175 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   42E7 FE 05         [ 7]  176 	cp	a,#0x05
   42E9 28 03         [12]  177 	jr	Z,00101$
   42EB D6 06         [ 7]  178 	sub	a, #0x06
   42ED C0            [11]  179 	ret	NZ
   42EE                     180 00101$:
                            181 ;src/UI_GameMenu.c:89: ui_gamemenu_entryIndex=1;
   42EE 21 A3 7D      [10]  182 	ld	hl,#_ui_gamemenu_entryIndex + 0
   42F1 36 01         [10]  183 	ld	(hl), #0x01
   42F3 C9            [10]  184 	ret
                            185 ;src/UI_GameMenu.c:93: void ui_gamemenu_below_entry(){
                            186 ;	---------------------------------
                            187 ; Function ui_gamemenu_below_entry
                            188 ; ---------------------------------
   42F4                     189 _ui_gamemenu_below_entry::
                            190 ;src/UI_GameMenu.c:94: if(ui_gamemenu_entryIndex==0){
   42F4 3A A3 7D      [13]  191 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   42F7 B7            [ 4]  192 	or	a, a
   42F8 20 06         [12]  193 	jr	NZ,00104$
                            194 ;src/UI_GameMenu.c:95: ui_gamemenu_entryIndex=3;
   42FA 21 A3 7D      [10]  195 	ld	hl,#_ui_gamemenu_entryIndex + 0
   42FD 36 03         [10]  196 	ld	(hl), #0x03
   42FF C9            [10]  197 	ret
   4300                     198 00104$:
                            199 ;src/UI_GameMenu.c:97: else if(ui_gamemenu_entryIndex==1){
   4300 3A A3 7D      [13]  200 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4303 3D            [ 4]  201 	dec	a
   4304 C0            [11]  202 	ret	NZ
                            203 ;src/UI_GameMenu.c:98: ui_gamemenu_entryIndex=5;
   4305 21 A3 7D      [10]  204 	ld	hl,#_ui_gamemenu_entryIndex + 0
   4308 36 05         [10]  205 	ld	(hl), #0x05
   430A C9            [10]  206 	ret
                            207 ;src/UI_GameMenu.c:102: void ui_gamemenu_next_entry(){
                            208 ;	---------------------------------
                            209 ; Function ui_gamemenu_next_entry
                            210 ; ---------------------------------
   430B                     211 _ui_gamemenu_next_entry::
                            212 ;src/UI_GameMenu.c:103: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
   430B 3A A3 7D      [13]  213 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   430E FE 06         [ 7]  214 	cp	a,#0x06
   4310 D0            [11]  215 	ret	NC
   4311 3D            [ 4]  216 	dec	a
   4312 C8            [11]  217 	ret	Z
                            218 ;src/UI_GameMenu.c:104: ++ui_gamemenu_entryIndex;
   4313 21 A3 7D      [10]  219 	ld	hl, #_ui_gamemenu_entryIndex+0
   4316 34            [11]  220 	inc	(hl)
   4317 C9            [10]  221 	ret
                            222 ;src/UI_GameMenu.c:108: void ui_gamemenu_previous_entry(){
                            223 ;	---------------------------------
                            224 ; Function ui_gamemenu_previous_entry
                            225 ; ---------------------------------
   4318                     226 _ui_gamemenu_previous_entry::
                            227 ;src/UI_GameMenu.c:109: if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
   4318 3A A3 7D      [13]  228 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   431B B7            [ 4]  229 	or	a, a
   431C C8            [11]  230 	ret	Z
   431D 3A A3 7D      [13]  231 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4320 D6 02         [ 7]  232 	sub	a, #0x02
   4322 C8            [11]  233 	ret	Z
                            234 ;src/UI_GameMenu.c:110: --ui_gamemenu_entryIndex;
   4323 21 A3 7D      [10]  235 	ld	hl, #_ui_gamemenu_entryIndex+0
   4326 35            [11]  236 	dec	(hl)
   4327 C9            [10]  237 	ret
                            238 ;src/UI_GameMenu.c:114: void ui_gamemenu_unselect_entry(){
                            239 ;	---------------------------------
                            240 ; Function ui_gamemenu_unselect_entry
                            241 ; ---------------------------------
   4328                     242 _ui_gamemenu_unselect_entry::
                            243 ;src/UI_GameMenu.c:115: ui_gamemenu_entrySelected=0;
   4328 21 A4 7D      [10]  244 	ld	hl,#_ui_gamemenu_entrySelected + 0
   432B 36 00         [10]  245 	ld	(hl), #0x00
   432D C9            [10]  246 	ret
                            247 ;src/UI_GameMenu.c:118: void ui_gamemenu_select_entry(){
                            248 ;	---------------------------------
                            249 ; Function ui_gamemenu_select_entry
                            250 ; ---------------------------------
   432E                     251 _ui_gamemenu_select_entry::
                            252 ;src/UI_GameMenu.c:119: ui_gamemenu_entrySelected=1;
   432E 21 A4 7D      [10]  253 	ld	hl,#_ui_gamemenu_entrySelected + 0
   4331 36 01         [10]  254 	ld	(hl), #0x01
   4333 C9            [10]  255 	ret
                            256 ;src/UI_GameMenu.c:122: void ui_gamemenu_render_button(u8 n){
                            257 ;	---------------------------------
                            258 ; Function ui_gamemenu_render_button
                            259 ; ---------------------------------
   4334                     260 _ui_gamemenu_render_button::
   4334 DD E5         [15]  261 	push	ix
   4336 DD 21 00 00   [14]  262 	ld	ix,#0
   433A DD 39         [15]  263 	add	ix,sp
   433C F5            [11]  264 	push	af
                            265 ;src/UI_GameMenu.c:124: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   433D DD 7E 04      [19]  266 	ld	a,4 (ix)
   4340 FD 21 A3 7D   [14]  267 	ld	iy,#_ui_gamemenu_entryIndex
   4344 FD 96 00      [19]  268 	sub	a, 0 (iy)
   4347 20 10         [12]  269 	jr	NZ,00103$
   4349 3A A4 7D      [13]  270 	ld	a,(#_ui_gamemenu_entrySelected + 0)
   434C B7            [ 4]  271 	or	a, a
   434D 28 05         [12]  272 	jr	Z,00105$
   434F 3A 6A 1A      [13]  273 	ld	a, (#(_g_colors + 0x0004) + 0)
   4352 18 08         [12]  274 	jr	00104$
   4354                     275 00105$:
   4354 3A 6C 1A      [13]  276 	ld	a, (#(_g_colors + 0x0006) + 0)
   4357 18 03         [12]  277 	jr	00104$
   4359                     278 00103$:
   4359 3A 68 1A      [13]  279 	ld	a, (#(_g_colors + 0x0002) + 0)
   435C                     280 00104$:
   435C 4F            [ 4]  281 	ld	c,a
                            282 ;src/UI_GameMenu.c:125: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
   435D 11 94 42      [10]  283 	ld	de,#_ui_gamemenu_buttonWidths+0
   4360 DD 6E 04      [19]  284 	ld	l,4 (ix)
   4363 26 00         [ 7]  285 	ld	h,#0x00
   4365 19            [11]  286 	add	hl,de
   4366 46            [ 7]  287 	ld	b,(hl)
   4367 DD 6E 04      [19]  288 	ld	l,4 (ix)
   436A 26 00         [ 7]  289 	ld	h,#0x00
   436C 29            [11]  290 	add	hl, hl
   436D EB            [ 4]  291 	ex	de,hl
   436E 21 64 42      [10]  292 	ld	hl,#_ui_gamemenu_entriesPosition
   4371 19            [11]  293 	add	hl,de
   4372 7E            [ 7]  294 	ld	a,(hl)
   4373 DD 77 FE      [19]  295 	ld	-2 (ix),a
   4376 23            [ 6]  296 	inc	hl
   4377 7E            [ 7]  297 	ld	a,(hl)
   4378 DD 77 FF      [19]  298 	ld	-1 (ix),a
   437B D5            [11]  299 	push	de
   437C 3E 18         [ 7]  300 	ld	a,#0x18
   437E F5            [11]  301 	push	af
   437F 33            [ 6]  302 	inc	sp
   4380 C5            [11]  303 	push	bc
   4381 DD 6E FE      [19]  304 	ld	l,-2 (ix)
   4384 DD 66 FF      [19]  305 	ld	h,-1 (ix)
   4387 E5            [11]  306 	push	hl
   4388 CD 92 7B      [17]  307 	call	_cpct_drawSolidBox
   438B F1            [10]  308 	pop	af
   438C F1            [10]  309 	pop	af
   438D 33            [ 6]  310 	inc	sp
   438E D1            [10]  311 	pop	de
                            312 ;src/UI_GameMenu.c:126: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
   438F 21 72 42      [10]  313 	ld	hl,#_ui_gamemenu_entriesTextPosition
   4392 19            [11]  314 	add	hl,de
   4393 4E            [ 7]  315 	ld	c,(hl)
   4394 23            [ 6]  316 	inc	hl
   4395 46            [ 7]  317 	ld	b,(hl)
   4396 21 86 42      [10]  318 	ld	hl,#_ui_gamemenu_buttonText
   4399 19            [11]  319 	add	hl,de
   439A 5E            [ 7]  320 	ld	e,(hl)
   439B 23            [ 6]  321 	inc	hl
   439C 56            [ 7]  322 	ld	d,(hl)
   439D 3E 03         [ 7]  323 	ld	a,#0x03
   439F F5            [11]  324 	push	af
   43A0 33            [ 6]  325 	inc	sp
   43A1 C5            [11]  326 	push	bc
   43A2 D5            [11]  327 	push	de
   43A3 CD A0 3F      [17]  328 	call	_print_transparent_text
   43A6 DD F9         [10]  329 	ld	sp,ix
   43A8 DD E1         [14]  330 	pop	ix
   43AA C9            [10]  331 	ret
                            332 ;src/UI_GameMenu.c:138: void ui_gamemenu_render_refresh(){
                            333 ;	---------------------------------
                            334 ; Function ui_gamemenu_render_refresh
                            335 ; ---------------------------------
   43AB                     336 _ui_gamemenu_render_refresh::
                            337 ;src/UI_GameMenu.c:140: ui_gamemenu_render_button(ui_gamemenu_entryIndex);
   43AB 3A A3 7D      [13]  338 	ld	a,(_ui_gamemenu_entryIndex)
   43AE F5            [11]  339 	push	af
   43AF 33            [ 6]  340 	inc	sp
   43B0 CD 34 43      [17]  341 	call	_ui_gamemenu_render_button
   43B3 33            [ 6]  342 	inc	sp
                            343 ;src/UI_GameMenu.c:141: ui_gamemenu_render_button(ui_gamemenu_lastEntry);
   43B4 3A A2 7D      [13]  344 	ld	a,(_ui_gamemenu_lastEntry)
   43B7 F5            [11]  345 	push	af
   43B8 33            [ 6]  346 	inc	sp
   43B9 CD 34 43      [17]  347 	call	_ui_gamemenu_render_button
   43BC 33            [ 6]  348 	inc	sp
                            349 ;src/UI_GameMenu.c:143: ui_gamemenu_render_button(0);
   43BD AF            [ 4]  350 	xor	a, a
   43BE F5            [11]  351 	push	af
   43BF 33            [ 6]  352 	inc	sp
   43C0 CD 34 43      [17]  353 	call	_ui_gamemenu_render_button
   43C3 33            [ 6]  354 	inc	sp
                            355 ;src/UI_GameMenu.c:144: ui_gamemenu_render_button(3);
   43C4 3E 03         [ 7]  356 	ld	a,#0x03
   43C6 F5            [11]  357 	push	af
   43C7 33            [ 6]  358 	inc	sp
   43C8 CD 34 43      [17]  359 	call	_ui_gamemenu_render_button
   43CB 33            [ 6]  360 	inc	sp
                            361 ;src/UI_GameMenu.c:147: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   43CC 3A A3 7D      [13]  362 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   43CF 32 A2 7D      [13]  363 	ld	(#_ui_gamemenu_lastEntry + 0),a
   43D2 C9            [10]  364 	ret
                            365 ;src/UI_GameMenu.c:151: void ui_gamemenu_render_all(){
                            366 ;	---------------------------------
                            367 ; Function ui_gamemenu_render_all
                            368 ; ---------------------------------
   43D3                     369 _ui_gamemenu_render_all::
                            370 ;src/UI_GameMenu.c:154: print_transparent_text("LEVEL ",UI_GAMEMENU_LEVEL_TEXT_POSITION, 3);
   43D3 3E 03         [ 7]  371 	ld	a,#0x03
   43D5 F5            [11]  372 	push	af
   43D6 33            [ 6]  373 	inc	sp
   43D7 21 00 C0      [10]  374 	ld	hl,#0xC000
   43DA E5            [11]  375 	push	hl
   43DB 21 1C 44      [10]  376 	ld	hl,#___str_9
   43DE E5            [11]  377 	push	hl
   43DF CD A0 3F      [17]  378 	call	_print_transparent_text
   43E2 F1            [10]  379 	pop	af
   43E3 F1            [10]  380 	pop	af
   43E4 33            [ 6]  381 	inc	sp
                            382 ;src/UI_GameMenu.c:155: print_transparent_text(integer_to_string(level_get_level(),'d'),UI_GAMEMENU_LEVEL_NUMBER_POSITION, 3);
   43E5 CD A7 0F      [17]  383 	call	_level_get_level
   43E8 45            [ 4]  384 	ld	b,l
   43E9 3E 64         [ 7]  385 	ld	a,#0x64
   43EB F5            [11]  386 	push	af
   43EC 33            [ 6]  387 	inc	sp
   43ED C5            [11]  388 	push	bc
   43EE 33            [ 6]  389 	inc	sp
   43EF CD 5E 3C      [17]  390 	call	_integer_to_string
   43F2 F1            [10]  391 	pop	af
   43F3 4D            [ 4]  392 	ld	c,l
   43F4 44            [ 4]  393 	ld	b,h
   43F5 3E 03         [ 7]  394 	ld	a,#0x03
   43F7 F5            [11]  395 	push	af
   43F8 33            [ 6]  396 	inc	sp
   43F9 21 0C C0      [10]  397 	ld	hl,#0xC00C
   43FC E5            [11]  398 	push	hl
   43FD C5            [11]  399 	push	bc
   43FE CD A0 3F      [17]  400 	call	_print_transparent_text
   4401 F1            [10]  401 	pop	af
   4402 F1            [10]  402 	pop	af
   4403 33            [ 6]  403 	inc	sp
                            404 ;src/UI_GameMenu.c:157: while(n){
   4404 06 07         [ 7]  405 	ld	b,#0x07
   4406                     406 00101$:
   4406 78            [ 4]  407 	ld	a,b
   4407 B7            [ 4]  408 	or	a, a
   4408 28 0B         [12]  409 	jr	Z,00103$
                            410 ;src/UI_GameMenu.c:158: --n;
   440A 05            [ 4]  411 	dec	b
                            412 ;src/UI_GameMenu.c:159: ui_gamemenu_render_button(n);
   440B C5            [11]  413 	push	bc
   440C C5            [11]  414 	push	bc
   440D 33            [ 6]  415 	inc	sp
   440E CD 34 43      [17]  416 	call	_ui_gamemenu_render_button
   4411 33            [ 6]  417 	inc	sp
   4412 C1            [10]  418 	pop	bc
   4413 18 F1         [12]  419 	jr	00101$
   4415                     420 00103$:
                            421 ;src/UI_GameMenu.c:162: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   4415 3A A3 7D      [13]  422 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4418 32 A2 7D      [13]  423 	ld	(#_ui_gamemenu_lastEntry + 0),a
   441B C9            [10]  424 	ret
   441C                     425 ___str_9:
   441C 4C 45 56 45 4C 20   426 	.ascii "LEVEL "
   4422 00                  427 	.db 0x00
                            428 ;src/UI_GameMenu.c:165: u8 ui_gamemenu_get_entry(){
                            429 ;	---------------------------------
                            430 ; Function ui_gamemenu_get_entry
                            431 ; ---------------------------------
   4423                     432 _ui_gamemenu_get_entry::
                            433 ;src/UI_GameMenu.c:166: return ui_gamemenu_entryIndex;
   4423 FD 21 A3 7D   [14]  434 	ld	iy,#_ui_gamemenu_entryIndex
   4427 FD 6E 00      [19]  435 	ld	l,0 (iy)
   442A C9            [10]  436 	ret
                            437 ;src/UI_GameMenu.c:169: u8 ui_gamemenu_is_selected(){
                            438 ;	---------------------------------
                            439 ; Function ui_gamemenu_is_selected
                            440 ; ---------------------------------
   442B                     441 _ui_gamemenu_is_selected::
                            442 ;src/UI_GameMenu.c:170: return ui_gamemenu_entrySelected;
   442B FD 21 A4 7D   [14]  443 	ld	iy,#_ui_gamemenu_entrySelected
   442F FD 6E 00      [19]  444 	ld	l,0 (iy)
   4432 C9            [10]  445 	ret
                            446 ;src/UI_GameMenu.c:173: void ui_gamemenu_update_action(){
                            447 ;	---------------------------------
                            448 ; Function ui_gamemenu_update_action
                            449 ; ---------------------------------
   4433                     450 _ui_gamemenu_update_action::
                            451 ;src/UI_GameMenu.c:174: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
   4433 21 2C 18      [10]  452 	ld	hl,#_player_position+0
   4436 4E            [ 7]  453 	ld	c,(hl)
   4437 06 00         [ 7]  454 	ld	b,#0x00
   4439 3A 2E 18      [13]  455 	ld	a, (#_player_direction + 0)
   443C 6F            [ 4]  456 	ld	l,a
   443D 17            [ 4]  457 	rla
   443E 9F            [ 4]  458 	sbc	a, a
   443F 67            [ 4]  459 	ld	h,a
   4440 09            [11]  460 	add	hl,bc
   4441 01 D0 88      [10]  461 	ld	bc,#0x88D0
   4444 09            [11]  462 	add	hl,bc
   4445 4D            [ 4]  463 	ld	c,l
   4446 44            [ 4]  464 	ld	b,h
   4447 21 2D 18      [10]  465 	ld	hl,#_player_position+1
   444A 5E            [ 7]  466 	ld	e,(hl)
   444B 16 00         [ 7]  467 	ld	d,#0x00
   444D 3A 2F 18      [13]  468 	ld	a, (#(_player_direction + 0x0001) + 0)
   4450 6F            [ 4]  469 	ld	l,a
   4451 17            [ 4]  470 	rla
   4452 9F            [ 4]  471 	sbc	a, a
   4453 67            [ 4]  472 	ld	h,a
   4454 19            [11]  473 	add	hl,de
   4455 29            [11]  474 	add	hl, hl
   4456 29            [11]  475 	add	hl, hl
   4457 29            [11]  476 	add	hl, hl
   4458 29            [11]  477 	add	hl, hl
   4459 29            [11]  478 	add	hl, hl
   445A 09            [11]  479 	add	hl,bc
   445B 4E            [ 7]  480 	ld	c,(hl)
                            481 ;src/UI_GameMenu.c:177: ui_gamemenu_can_move=0;
   445C 21 A5 7D      [10]  482 	ld	hl,#_ui_gamemenu_can_move + 0
   445F 36 00         [10]  483 	ld	(hl), #0x00
                            484 ;src/UI_GameMenu.c:178: *((char**)(ui_gamemenu_buttonText)+3)="";
   4461 21 BE 44      [10]  485 	ld	hl,#___str_10
   4464 22 8C 42      [16]  486 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
                            487 ;src/UI_GameMenu.c:180: ui_gamemenu_action=0;
   4467 FD 21 A6 7D   [14]  488 	ld	iy,#_ui_gamemenu_action
   446B FD 36 00 00   [19]  489 	ld	0 (iy),#0x00
                            490 ;src/UI_GameMenu.c:181: *((char**)ui_gamemenu_buttonText)="";
   446F 22 86 42      [16]  491 	ld	(_ui_gamemenu_buttonText), hl
                            492 ;src/UI_GameMenu.c:183: if(forward&CELL_ITEM_MASK){
   4472 79            [ 4]  493 	ld	a,c
   4473 E6 70         [ 7]  494 	and	a, #0x70
   4475 28 0D         [12]  495 	jr	Z,00102$
                            496 ;src/UI_GameMenu.c:184: ui_gamemenu_action=3;
   4477 21 A6 7D      [10]  497 	ld	hl,#_ui_gamemenu_action + 0
   447A 36 03         [10]  498 	ld	(hl), #0x03
                            499 ;src/UI_GameMenu.c:185: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[2];
   447C ED 5B 84 42   [20]  500 	ld	de, (#(_ui_gamemenu_action_buttonText + 0x0004) + 0)
   4480 ED 53 86 42   [20]  501 	ld	(_ui_gamemenu_buttonText), de
   4484                     502 00102$:
                            503 ;src/UI_GameMenu.c:187: if(forward&CELL_WALL_MASK){
   4484 CB 79         [ 8]  504 	bit	7, c
   4486 28 17         [12]  505 	jr	Z,00111$
                            506 ;src/UI_GameMenu.c:188: if(forward==CELLTYPE_DOOR){
   4488 79            [ 4]  507 	ld	a,c
   4489 D6 80         [ 7]  508 	sub	a, #0x80
   448B C0            [11]  509 	ret	NZ
                            510 ;src/UI_GameMenu.c:189: if(player_has_key){
   448C 3A 69 7D      [13]  511 	ld	a,(#_player_has_key + 0)
   448F B7            [ 4]  512 	or	a, a
   4490 C8            [11]  513 	ret	Z
                            514 ;src/UI_GameMenu.c:190: ui_gamemenu_action=1;
   4491 21 A6 7D      [10]  515 	ld	hl,#_ui_gamemenu_action + 0
   4494 36 01         [10]  516 	ld	(hl), #0x01
                            517 ;src/UI_GameMenu.c:191: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[0];
   4496 ED 4B 80 42   [20]  518 	ld	bc, (#_ui_gamemenu_action_buttonText + 0)
   449A ED 43 86 42   [20]  519 	ld	(_ui_gamemenu_buttonText), bc
   449E C9            [10]  520 	ret
   449F                     521 00111$:
                            522 ;src/UI_GameMenu.c:195: else if(forward&CELL_ENEMY_MASK){
   449F 79            [ 4]  523 	ld	a,c
   44A0 E6 0F         [ 7]  524 	and	a, #0x0F
   44A2 28 0E         [12]  525 	jr	Z,00108$
                            526 ;src/UI_GameMenu.c:196: ui_gamemenu_action=2;
   44A4 21 A6 7D      [10]  527 	ld	hl,#_ui_gamemenu_action + 0
   44A7 36 02         [10]  528 	ld	(hl), #0x02
                            529 ;src/UI_GameMenu.c:197: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[1];
   44A9 ED 4B 82 42   [20]  530 	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0002) + 0)
   44AD ED 43 86 42   [20]  531 	ld	(_ui_gamemenu_buttonText), bc
   44B1 C9            [10]  532 	ret
   44B2                     533 00108$:
                            534 ;src/UI_GameMenu.c:200: ui_gamemenu_can_move=1;
   44B2 21 A5 7D      [10]  535 	ld	hl,#_ui_gamemenu_can_move + 0
   44B5 36 01         [10]  536 	ld	(hl), #0x01
                            537 ;src/UI_GameMenu.c:201: *(char**)(ui_gamemenu_buttonText+3)="MOVE";
   44B7 21 BF 44      [10]  538 	ld	hl,#___str_11
   44BA 22 8C 42      [16]  539 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
   44BD C9            [10]  540 	ret
   44BE                     541 ___str_10:
   44BE 00                  542 	.db 0x00
   44BF                     543 ___str_11:
   44BF 4D 4F 56 45         544 	.ascii "MOVE"
   44C3 00                  545 	.db 0x00
                            546 ;src/UI_GameMenu.c:205: u8 ui_gamemenu_get_movement(){
                            547 ;	---------------------------------
                            548 ; Function ui_gamemenu_get_movement
                            549 ; ---------------------------------
   44C4                     550 _ui_gamemenu_get_movement::
                            551 ;src/UI_GameMenu.c:206: return ui_gamemenu_can_move;
   44C4 FD 21 A5 7D   [14]  552 	ld	iy,#_ui_gamemenu_can_move
   44C8 FD 6E 00      [19]  553 	ld	l,0 (iy)
   44CB C9            [10]  554 	ret
                            555 ;src/UI_GameMenu.c:209: u8 ui_gamemenu_get_action(){
                            556 ;	---------------------------------
                            557 ; Function ui_gamemenu_get_action
                            558 ; ---------------------------------
   44CC                     559 _ui_gamemenu_get_action::
                            560 ;src/UI_GameMenu.c:210: return ui_gamemenu_action;
   44CC FD 21 A6 7D   [14]  561 	ld	iy,#_ui_gamemenu_action
   44D0 FD 6E 00      [19]  562 	ld	l,0 (iy)
   44D3 C9            [10]  563 	ret
                            564 	.area _CODE
                            565 	.area _INITIALIZER
                            566 	.area _CABS (ABS)
