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
   8742                      46 _ui_gamemenu_lastEntry::
   8742                      47 	.ds 1
   8743                      48 _ui_gamemenu_entryIndex::
   8743                      49 	.ds 1
   8744                      50 _ui_gamemenu_entrySelected::
   8744                      51 	.ds 1
   8745                      52 _ui_gamemenu_can_move::
   8745                      53 	.ds 1
   8746                      54 _ui_gamemenu_action::
   8746                      55 	.ds 1
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
   43C6                      84 _ui_gamemenu_init::
                             85 ;src/UI_GameMenu.c:78: ui_gamemenu_lastEntry=0;
   43C6 21 42 87      [10]   86 	ld	hl,#_ui_gamemenu_lastEntry + 0
   43C9 36 00         [10]   87 	ld	(hl), #0x00
                             88 ;src/UI_GameMenu.c:79: ui_gamemenu_entryIndex=0;
   43CB 21 43 87      [10]   89 	ld	hl,#_ui_gamemenu_entryIndex + 0
   43CE 36 00         [10]   90 	ld	(hl), #0x00
                             91 ;src/UI_GameMenu.c:80: ui_gamemenu_entrySelected=0;
   43D0 21 44 87      [10]   92 	ld	hl,#_ui_gamemenu_entrySelected + 0
   43D3 36 00         [10]   93 	ld	(hl), #0x00
                             94 ;src/UI_GameMenu.c:81: ui_gamemenu_update_action();
   43D5 C3 A7 45      [10]   95 	jp  _ui_gamemenu_update_action
   43D8                      96 _ui_gamemenu_entriesPosition:
   43D8 50 C5                97 	.dw #0xC550
   43DA 84 C5                98 	.dw #0xC584
   43DC E0 C6                99 	.dw #0xC6E0
   43DE E7 C6               100 	.dw #0xC6E7
   43E0 F6 C6               101 	.dw #0xC6F6
   43E2 14 C7               102 	.dw #0xC714
   43E4 23 C7               103 	.dw #0xC723
   43E6                     104 _ui_gamemenu_entriesTextPosition:
   43E6 A4 CD               105 	.dw #0xCDA4
   43E8 D9 CD               106 	.dw #0xCDD9
   43EA 32 CF               107 	.dw #0xCF32
   43EC 3A CF               108 	.dw #0xCF3A
   43EE 48 CF               109 	.dw #0xCF48
   43F0 67 CF               110 	.dw #0xCF67
   43F2 75 CF               111 	.dw #0xCF75
   43F4                     112 _ui_gamemenu_action_buttonText:
   43F4 0F 44               113 	.dw __str_0
   43F6 1A 44               114 	.dw __str_1
   43F8 23 44               115 	.dw __str_2
   43FA                     116 _ui_gamemenu_buttonText:
   43FA 2D 44               117 	.dw __str_3
   43FC 2E 44               118 	.dw __str_4
   43FE 38 44               119 	.dw __str_5
   4400 2D 44               120 	.dw __str_3
   4402 3A 44               121 	.dw __str_6
   4404 3C 44               122 	.dw __str_7
   4406 41 44               123 	.dw __str_8
   4408                     124 _ui_gamemenu_buttonWidths:
   4408 1C                  125 	.db #0x1C	; 28
   4409 1C                  126 	.db #0x1C	; 28
   440A 06                  127 	.db #0x06	; 6
   440B 0E                  128 	.db #0x0E	; 14
   440C 06                  129 	.db #0x06	; 6
   440D 0D                  130 	.db #0x0D	; 13
   440E 0D                  131 	.db #0x0D	; 13
   440F                     132 __str_0:
   440F 4E 45 58 54 20 4C   133 	.ascii "NEXT LEVEL"
        45 56 45 4C
   4419 00                  134 	.db 0x00
   441A                     135 __str_1:
   441A 20 20 41 54 54 41   136 	.ascii "  ATTACK"
        43 4B
   4422 00                  137 	.db 0x00
   4423                     138 __str_2:
   4423 20 20 50 49 43 4B   139 	.ascii "  PICK UP"
        20 55 50
   442C 00                  140 	.db 0x00
   442D                     141 __str_3:
   442D 00                  142 	.db 0x00
   442E                     143 __str_4:
   442E 49 4E 56 45 4E 54   144 	.ascii "INVENTORY"
        4F 52 59
   4437 00                  145 	.db 0x00
   4438                     146 __str_5:
   4438 3C                  147 	.ascii "<"
   4439 00                  148 	.db 0x00
   443A                     149 __str_6:
   443A 3E                  150 	.ascii ">"
   443B 00                  151 	.db 0x00
   443C                     152 __str_7:
   443C 57 41 49 54         153 	.ascii "WAIT"
   4440 00                  154 	.db 0x00
   4441                     155 __str_8:
   4441 50 41 55 53 45      156 	.ascii "PAUSE"
   4446 00                  157 	.db 0x00
                            158 ;src/UI_GameMenu.c:84: void ui_gamemenu_above_entry(){
                            159 ;	---------------------------------
                            160 ; Function ui_gamemenu_above_entry
                            161 ; ---------------------------------
   4447                     162 _ui_gamemenu_above_entry::
                            163 ;src/UI_GameMenu.c:85: if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
   4447 3A 43 87      [13]  164 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   444A FE 02         [ 7]  165 	cp	a,#0x02
   444C 38 0A         [12]  166 	jr	C,00105$
   444E D6 05         [ 7]  167 	sub	a, #0x05
   4450 30 06         [12]  168 	jr	NC,00105$
                            169 ;src/UI_GameMenu.c:86: ui_gamemenu_entryIndex=0;
   4452 21 43 87      [10]  170 	ld	hl,#_ui_gamemenu_entryIndex + 0
   4455 36 00         [10]  171 	ld	(hl), #0x00
   4457 C9            [10]  172 	ret
   4458                     173 00105$:
                            174 ;src/UI_GameMenu.c:88: else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
   4458 3A 43 87      [13]  175 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   445B FE 05         [ 7]  176 	cp	a,#0x05
   445D 28 03         [12]  177 	jr	Z,00101$
   445F D6 06         [ 7]  178 	sub	a, #0x06
   4461 C0            [11]  179 	ret	NZ
   4462                     180 00101$:
                            181 ;src/UI_GameMenu.c:89: ui_gamemenu_entryIndex=1;
   4462 21 43 87      [10]  182 	ld	hl,#_ui_gamemenu_entryIndex + 0
   4465 36 01         [10]  183 	ld	(hl), #0x01
   4467 C9            [10]  184 	ret
                            185 ;src/UI_GameMenu.c:93: void ui_gamemenu_below_entry(){
                            186 ;	---------------------------------
                            187 ; Function ui_gamemenu_below_entry
                            188 ; ---------------------------------
   4468                     189 _ui_gamemenu_below_entry::
                            190 ;src/UI_GameMenu.c:94: if(ui_gamemenu_entryIndex==0){
   4468 3A 43 87      [13]  191 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   446B B7            [ 4]  192 	or	a, a
   446C 20 06         [12]  193 	jr	NZ,00104$
                            194 ;src/UI_GameMenu.c:95: ui_gamemenu_entryIndex=3;
   446E 21 43 87      [10]  195 	ld	hl,#_ui_gamemenu_entryIndex + 0
   4471 36 03         [10]  196 	ld	(hl), #0x03
   4473 C9            [10]  197 	ret
   4474                     198 00104$:
                            199 ;src/UI_GameMenu.c:97: else if(ui_gamemenu_entryIndex==1){
   4474 3A 43 87      [13]  200 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4477 3D            [ 4]  201 	dec	a
   4478 C0            [11]  202 	ret	NZ
                            203 ;src/UI_GameMenu.c:98: ui_gamemenu_entryIndex=5;
   4479 21 43 87      [10]  204 	ld	hl,#_ui_gamemenu_entryIndex + 0
   447C 36 05         [10]  205 	ld	(hl), #0x05
   447E C9            [10]  206 	ret
                            207 ;src/UI_GameMenu.c:102: void ui_gamemenu_next_entry(){
                            208 ;	---------------------------------
                            209 ; Function ui_gamemenu_next_entry
                            210 ; ---------------------------------
   447F                     211 _ui_gamemenu_next_entry::
                            212 ;src/UI_GameMenu.c:103: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
   447F 3A 43 87      [13]  213 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4482 FE 06         [ 7]  214 	cp	a,#0x06
   4484 D0            [11]  215 	ret	NC
   4485 3D            [ 4]  216 	dec	a
   4486 C8            [11]  217 	ret	Z
                            218 ;src/UI_GameMenu.c:104: ++ui_gamemenu_entryIndex;
   4487 21 43 87      [10]  219 	ld	hl, #_ui_gamemenu_entryIndex+0
   448A 34            [11]  220 	inc	(hl)
   448B C9            [10]  221 	ret
                            222 ;src/UI_GameMenu.c:108: void ui_gamemenu_previous_entry(){
                            223 ;	---------------------------------
                            224 ; Function ui_gamemenu_previous_entry
                            225 ; ---------------------------------
   448C                     226 _ui_gamemenu_previous_entry::
                            227 ;src/UI_GameMenu.c:109: if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
   448C 3A 43 87      [13]  228 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   448F B7            [ 4]  229 	or	a, a
   4490 C8            [11]  230 	ret	Z
   4491 3A 43 87      [13]  231 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4494 D6 02         [ 7]  232 	sub	a, #0x02
   4496 C8            [11]  233 	ret	Z
                            234 ;src/UI_GameMenu.c:110: --ui_gamemenu_entryIndex;
   4497 21 43 87      [10]  235 	ld	hl, #_ui_gamemenu_entryIndex+0
   449A 35            [11]  236 	dec	(hl)
   449B C9            [10]  237 	ret
                            238 ;src/UI_GameMenu.c:114: void ui_gamemenu_unselect_entry(){
                            239 ;	---------------------------------
                            240 ; Function ui_gamemenu_unselect_entry
                            241 ; ---------------------------------
   449C                     242 _ui_gamemenu_unselect_entry::
                            243 ;src/UI_GameMenu.c:115: ui_gamemenu_entrySelected=0;
   449C 21 44 87      [10]  244 	ld	hl,#_ui_gamemenu_entrySelected + 0
   449F 36 00         [10]  245 	ld	(hl), #0x00
   44A1 C9            [10]  246 	ret
                            247 ;src/UI_GameMenu.c:118: void ui_gamemenu_select_entry(){
                            248 ;	---------------------------------
                            249 ; Function ui_gamemenu_select_entry
                            250 ; ---------------------------------
   44A2                     251 _ui_gamemenu_select_entry::
                            252 ;src/UI_GameMenu.c:119: ui_gamemenu_entrySelected=1;
   44A2 21 44 87      [10]  253 	ld	hl,#_ui_gamemenu_entrySelected + 0
   44A5 36 01         [10]  254 	ld	(hl), #0x01
   44A7 C9            [10]  255 	ret
                            256 ;src/UI_GameMenu.c:122: void ui_gamemenu_render_button(u8 n){
                            257 ;	---------------------------------
                            258 ; Function ui_gamemenu_render_button
                            259 ; ---------------------------------
   44A8                     260 _ui_gamemenu_render_button::
   44A8 DD E5         [15]  261 	push	ix
   44AA DD 21 00 00   [14]  262 	ld	ix,#0
   44AE DD 39         [15]  263 	add	ix,sp
   44B0 F5            [11]  264 	push	af
                            265 ;src/UI_GameMenu.c:124: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   44B1 DD 7E 04      [19]  266 	ld	a,4 (ix)
   44B4 FD 21 43 87   [14]  267 	ld	iy,#_ui_gamemenu_entryIndex
   44B8 FD 96 00      [19]  268 	sub	a, 0 (iy)
   44BB 20 10         [12]  269 	jr	NZ,00103$
   44BD 3A 44 87      [13]  270 	ld	a,(#_ui_gamemenu_entrySelected + 0)
   44C0 B7            [ 4]  271 	or	a, a
   44C1 28 05         [12]  272 	jr	Z,00105$
   44C3 3A 2C 1C      [13]  273 	ld	a, (#(_g_colors + 0x0004) + 0)
   44C6 18 08         [12]  274 	jr	00104$
   44C8                     275 00105$:
   44C8 3A 2E 1C      [13]  276 	ld	a, (#(_g_colors + 0x0006) + 0)
   44CB 18 03         [12]  277 	jr	00104$
   44CD                     278 00103$:
   44CD 3A 2A 1C      [13]  279 	ld	a, (#(_g_colors + 0x0002) + 0)
   44D0                     280 00104$:
   44D0 4F            [ 4]  281 	ld	c,a
                            282 ;src/UI_GameMenu.c:125: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
   44D1 11 08 44      [10]  283 	ld	de,#_ui_gamemenu_buttonWidths+0
   44D4 DD 6E 04      [19]  284 	ld	l,4 (ix)
   44D7 26 00         [ 7]  285 	ld	h,#0x00
   44D9 19            [11]  286 	add	hl,de
   44DA 46            [ 7]  287 	ld	b,(hl)
   44DB DD 6E 04      [19]  288 	ld	l,4 (ix)
   44DE 26 00         [ 7]  289 	ld	h,#0x00
   44E0 29            [11]  290 	add	hl, hl
   44E1 EB            [ 4]  291 	ex	de,hl
   44E2 21 D8 43      [10]  292 	ld	hl,#_ui_gamemenu_entriesPosition
   44E5 19            [11]  293 	add	hl,de
   44E6 7E            [ 7]  294 	ld	a,(hl)
   44E7 DD 77 FE      [19]  295 	ld	-2 (ix),a
   44EA 23            [ 6]  296 	inc	hl
   44EB 7E            [ 7]  297 	ld	a,(hl)
   44EC DD 77 FF      [19]  298 	ld	-1 (ix),a
   44EF D5            [11]  299 	push	de
   44F0 3E 18         [ 7]  300 	ld	a,#0x18
   44F2 F5            [11]  301 	push	af
   44F3 33            [ 6]  302 	inc	sp
   44F4 C5            [11]  303 	push	bc
   44F5 DD 6E FE      [19]  304 	ld	l,-2 (ix)
   44F8 DD 66 FF      [19]  305 	ld	h,-1 (ix)
   44FB E5            [11]  306 	push	hl
   44FC CD 2F 85      [17]  307 	call	_cpct_drawSolidBox
   44FF F1            [10]  308 	pop	af
   4500 F1            [10]  309 	pop	af
   4501 33            [ 6]  310 	inc	sp
   4502 D1            [10]  311 	pop	de
                            312 ;src/UI_GameMenu.c:126: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
   4503 21 E6 43      [10]  313 	ld	hl,#_ui_gamemenu_entriesTextPosition
   4506 19            [11]  314 	add	hl,de
   4507 4E            [ 7]  315 	ld	c,(hl)
   4508 23            [ 6]  316 	inc	hl
   4509 46            [ 7]  317 	ld	b,(hl)
   450A 21 FA 43      [10]  318 	ld	hl,#_ui_gamemenu_buttonText
   450D 19            [11]  319 	add	hl,de
   450E 5E            [ 7]  320 	ld	e,(hl)
   450F 23            [ 6]  321 	inc	hl
   4510 56            [ 7]  322 	ld	d,(hl)
   4511 3E 03         [ 7]  323 	ld	a,#0x03
   4513 F5            [11]  324 	push	af
   4514 33            [ 6]  325 	inc	sp
   4515 C5            [11]  326 	push	bc
   4516 D5            [11]  327 	push	de
   4517 CD 14 41      [17]  328 	call	_print_transparent_text
   451A DD F9         [10]  329 	ld	sp,ix
   451C DD E1         [14]  330 	pop	ix
   451E C9            [10]  331 	ret
                            332 ;src/UI_GameMenu.c:138: void ui_gamemenu_render_refresh(){
                            333 ;	---------------------------------
                            334 ; Function ui_gamemenu_render_refresh
                            335 ; ---------------------------------
   451F                     336 _ui_gamemenu_render_refresh::
                            337 ;src/UI_GameMenu.c:140: ui_gamemenu_render_button(ui_gamemenu_entryIndex);
   451F 3A 43 87      [13]  338 	ld	a,(_ui_gamemenu_entryIndex)
   4522 F5            [11]  339 	push	af
   4523 33            [ 6]  340 	inc	sp
   4524 CD A8 44      [17]  341 	call	_ui_gamemenu_render_button
   4527 33            [ 6]  342 	inc	sp
                            343 ;src/UI_GameMenu.c:141: ui_gamemenu_render_button(ui_gamemenu_lastEntry);
   4528 3A 42 87      [13]  344 	ld	a,(_ui_gamemenu_lastEntry)
   452B F5            [11]  345 	push	af
   452C 33            [ 6]  346 	inc	sp
   452D CD A8 44      [17]  347 	call	_ui_gamemenu_render_button
   4530 33            [ 6]  348 	inc	sp
                            349 ;src/UI_GameMenu.c:143: ui_gamemenu_render_button(0);
   4531 AF            [ 4]  350 	xor	a, a
   4532 F5            [11]  351 	push	af
   4533 33            [ 6]  352 	inc	sp
   4534 CD A8 44      [17]  353 	call	_ui_gamemenu_render_button
   4537 33            [ 6]  354 	inc	sp
                            355 ;src/UI_GameMenu.c:144: ui_gamemenu_render_button(3);
   4538 3E 03         [ 7]  356 	ld	a,#0x03
   453A F5            [11]  357 	push	af
   453B 33            [ 6]  358 	inc	sp
   453C CD A8 44      [17]  359 	call	_ui_gamemenu_render_button
   453F 33            [ 6]  360 	inc	sp
                            361 ;src/UI_GameMenu.c:147: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   4540 3A 43 87      [13]  362 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4543 32 42 87      [13]  363 	ld	(#_ui_gamemenu_lastEntry + 0),a
   4546 C9            [10]  364 	ret
                            365 ;src/UI_GameMenu.c:151: void ui_gamemenu_render_all(){
                            366 ;	---------------------------------
                            367 ; Function ui_gamemenu_render_all
                            368 ; ---------------------------------
   4547                     369 _ui_gamemenu_render_all::
                            370 ;src/UI_GameMenu.c:154: print_transparent_text("LEVEL ",UI_GAMEMENU_LEVEL_TEXT_POSITION, 3);
   4547 3E 03         [ 7]  371 	ld	a,#0x03
   4549 F5            [11]  372 	push	af
   454A 33            [ 6]  373 	inc	sp
   454B 21 00 C0      [10]  374 	ld	hl,#0xC000
   454E E5            [11]  375 	push	hl
   454F 21 90 45      [10]  376 	ld	hl,#___str_9
   4552 E5            [11]  377 	push	hl
   4553 CD 14 41      [17]  378 	call	_print_transparent_text
   4556 F1            [10]  379 	pop	af
   4557 F1            [10]  380 	pop	af
   4558 33            [ 6]  381 	inc	sp
                            382 ;src/UI_GameMenu.c:155: print_transparent_text(integer_to_string(level_get_level(),'d'),UI_GAMEMENU_LEVEL_NUMBER_POSITION, 3);
   4559 CD 59 11      [17]  383 	call	_level_get_level
   455C 45            [ 4]  384 	ld	b,l
   455D 3E 64         [ 7]  385 	ld	a,#0x64
   455F F5            [11]  386 	push	af
   4560 33            [ 6]  387 	inc	sp
   4561 C5            [11]  388 	push	bc
   4562 33            [ 6]  389 	inc	sp
   4563 CD D2 3D      [17]  390 	call	_integer_to_string
   4566 F1            [10]  391 	pop	af
   4567 4D            [ 4]  392 	ld	c,l
   4568 44            [ 4]  393 	ld	b,h
   4569 3E 03         [ 7]  394 	ld	a,#0x03
   456B F5            [11]  395 	push	af
   456C 33            [ 6]  396 	inc	sp
   456D 21 0C C0      [10]  397 	ld	hl,#0xC00C
   4570 E5            [11]  398 	push	hl
   4571 C5            [11]  399 	push	bc
   4572 CD 14 41      [17]  400 	call	_print_transparent_text
   4575 F1            [10]  401 	pop	af
   4576 F1            [10]  402 	pop	af
   4577 33            [ 6]  403 	inc	sp
                            404 ;src/UI_GameMenu.c:157: while(n){
   4578 06 07         [ 7]  405 	ld	b,#0x07
   457A                     406 00101$:
   457A 78            [ 4]  407 	ld	a,b
   457B B7            [ 4]  408 	or	a, a
   457C 28 0B         [12]  409 	jr	Z,00103$
                            410 ;src/UI_GameMenu.c:158: --n;
   457E 05            [ 4]  411 	dec	b
                            412 ;src/UI_GameMenu.c:159: ui_gamemenu_render_button(n);
   457F C5            [11]  413 	push	bc
   4580 C5            [11]  414 	push	bc
   4581 33            [ 6]  415 	inc	sp
   4582 CD A8 44      [17]  416 	call	_ui_gamemenu_render_button
   4585 33            [ 6]  417 	inc	sp
   4586 C1            [10]  418 	pop	bc
   4587 18 F1         [12]  419 	jr	00101$
   4589                     420 00103$:
                            421 ;src/UI_GameMenu.c:162: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   4589 3A 43 87      [13]  422 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   458C 32 42 87      [13]  423 	ld	(#_ui_gamemenu_lastEntry + 0),a
   458F C9            [10]  424 	ret
   4590                     425 ___str_9:
   4590 4C 45 56 45 4C 20   426 	.ascii "LEVEL "
   4596 00                  427 	.db 0x00
                            428 ;src/UI_GameMenu.c:165: u8 ui_gamemenu_get_entry(){
                            429 ;	---------------------------------
                            430 ; Function ui_gamemenu_get_entry
                            431 ; ---------------------------------
   4597                     432 _ui_gamemenu_get_entry::
                            433 ;src/UI_GameMenu.c:166: return ui_gamemenu_entryIndex;
   4597 FD 21 43 87   [14]  434 	ld	iy,#_ui_gamemenu_entryIndex
   459B FD 6E 00      [19]  435 	ld	l,0 (iy)
   459E C9            [10]  436 	ret
                            437 ;src/UI_GameMenu.c:169: u8 ui_gamemenu_is_selected(){
                            438 ;	---------------------------------
                            439 ; Function ui_gamemenu_is_selected
                            440 ; ---------------------------------
   459F                     441 _ui_gamemenu_is_selected::
                            442 ;src/UI_GameMenu.c:170: return ui_gamemenu_entrySelected;
   459F FD 21 44 87   [14]  443 	ld	iy,#_ui_gamemenu_entrySelected
   45A3 FD 6E 00      [19]  444 	ld	l,0 (iy)
   45A6 C9            [10]  445 	ret
                            446 ;src/UI_GameMenu.c:173: void ui_gamemenu_update_action(){
                            447 ;	---------------------------------
                            448 ; Function ui_gamemenu_update_action
                            449 ; ---------------------------------
   45A7                     450 _ui_gamemenu_update_action::
                            451 ;src/UI_GameMenu.c:174: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
   45A7 21 EE 19      [10]  452 	ld	hl,#_player_position+0
   45AA 4E            [ 7]  453 	ld	c,(hl)
   45AB 06 00         [ 7]  454 	ld	b,#0x00
   45AD 3A F0 19      [13]  455 	ld	a, (#_player_direction + 0)
   45B0 6F            [ 4]  456 	ld	l,a
   45B1 17            [ 4]  457 	rla
   45B2 9F            [ 4]  458 	sbc	a, a
   45B3 67            [ 4]  459 	ld	h,a
   45B4 09            [11]  460 	add	hl,bc
   45B5 01 D0 88      [10]  461 	ld	bc,#0x88D0
   45B8 09            [11]  462 	add	hl,bc
   45B9 4D            [ 4]  463 	ld	c,l
   45BA 44            [ 4]  464 	ld	b,h
   45BB 21 EF 19      [10]  465 	ld	hl,#_player_position+1
   45BE 5E            [ 7]  466 	ld	e,(hl)
   45BF 16 00         [ 7]  467 	ld	d,#0x00
   45C1 3A F1 19      [13]  468 	ld	a, (#(_player_direction + 0x0001) + 0)
   45C4 6F            [ 4]  469 	ld	l,a
   45C5 17            [ 4]  470 	rla
   45C6 9F            [ 4]  471 	sbc	a, a
   45C7 67            [ 4]  472 	ld	h,a
   45C8 19            [11]  473 	add	hl,de
   45C9 29            [11]  474 	add	hl, hl
   45CA 29            [11]  475 	add	hl, hl
   45CB 29            [11]  476 	add	hl, hl
   45CC 29            [11]  477 	add	hl, hl
   45CD 29            [11]  478 	add	hl, hl
   45CE 09            [11]  479 	add	hl,bc
   45CF 4E            [ 7]  480 	ld	c,(hl)
                            481 ;src/UI_GameMenu.c:177: ui_gamemenu_can_move=0;
   45D0 21 45 87      [10]  482 	ld	hl,#_ui_gamemenu_can_move + 0
   45D3 36 00         [10]  483 	ld	(hl), #0x00
                            484 ;src/UI_GameMenu.c:178: *((char**)(ui_gamemenu_buttonText)+3)="";
   45D5 21 32 46      [10]  485 	ld	hl,#___str_10
   45D8 22 00 44      [16]  486 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
                            487 ;src/UI_GameMenu.c:180: ui_gamemenu_action=0;
   45DB FD 21 46 87   [14]  488 	ld	iy,#_ui_gamemenu_action
   45DF FD 36 00 00   [19]  489 	ld	0 (iy),#0x00
                            490 ;src/UI_GameMenu.c:181: *((char**)ui_gamemenu_buttonText)="";
   45E3 22 FA 43      [16]  491 	ld	(_ui_gamemenu_buttonText), hl
                            492 ;src/UI_GameMenu.c:183: if(forward&CELL_ITEM_MASK){
   45E6 79            [ 4]  493 	ld	a,c
   45E7 E6 70         [ 7]  494 	and	a, #0x70
   45E9 28 0D         [12]  495 	jr	Z,00102$
                            496 ;src/UI_GameMenu.c:184: ui_gamemenu_action=3;
   45EB 21 46 87      [10]  497 	ld	hl,#_ui_gamemenu_action + 0
   45EE 36 03         [10]  498 	ld	(hl), #0x03
                            499 ;src/UI_GameMenu.c:185: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[2];
   45F0 ED 5B F8 43   [20]  500 	ld	de, (#(_ui_gamemenu_action_buttonText + 0x0004) + 0)
   45F4 ED 53 FA 43   [20]  501 	ld	(_ui_gamemenu_buttonText), de
   45F8                     502 00102$:
                            503 ;src/UI_GameMenu.c:187: if(forward&CELL_WALL_MASK){
   45F8 CB 79         [ 8]  504 	bit	7, c
   45FA 28 17         [12]  505 	jr	Z,00111$
                            506 ;src/UI_GameMenu.c:188: if(forward==CELLTYPE_DOOR){
   45FC 79            [ 4]  507 	ld	a,c
   45FD D6 80         [ 7]  508 	sub	a, #0x80
   45FF C0            [11]  509 	ret	NZ
                            510 ;src/UI_GameMenu.c:189: if(player_has_key){
   4600 3A 09 87      [13]  511 	ld	a,(#_player_has_key + 0)
   4603 B7            [ 4]  512 	or	a, a
   4604 C8            [11]  513 	ret	Z
                            514 ;src/UI_GameMenu.c:190: ui_gamemenu_action=1;
   4605 21 46 87      [10]  515 	ld	hl,#_ui_gamemenu_action + 0
   4608 36 01         [10]  516 	ld	(hl), #0x01
                            517 ;src/UI_GameMenu.c:191: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[0];
   460A ED 4B F4 43   [20]  518 	ld	bc, (#_ui_gamemenu_action_buttonText + 0)
   460E ED 43 FA 43   [20]  519 	ld	(_ui_gamemenu_buttonText), bc
   4612 C9            [10]  520 	ret
   4613                     521 00111$:
                            522 ;src/UI_GameMenu.c:195: else if(forward&CELL_ENEMY_MASK){
   4613 79            [ 4]  523 	ld	a,c
   4614 E6 0F         [ 7]  524 	and	a, #0x0F
   4616 28 0E         [12]  525 	jr	Z,00108$
                            526 ;src/UI_GameMenu.c:196: ui_gamemenu_action=2;
   4618 21 46 87      [10]  527 	ld	hl,#_ui_gamemenu_action + 0
   461B 36 02         [10]  528 	ld	(hl), #0x02
                            529 ;src/UI_GameMenu.c:197: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[1];
   461D ED 4B F6 43   [20]  530 	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0002) + 0)
   4621 ED 43 FA 43   [20]  531 	ld	(_ui_gamemenu_buttonText), bc
   4625 C9            [10]  532 	ret
   4626                     533 00108$:
                            534 ;src/UI_GameMenu.c:200: ui_gamemenu_can_move=1;
   4626 21 45 87      [10]  535 	ld	hl,#_ui_gamemenu_can_move + 0
   4629 36 01         [10]  536 	ld	(hl), #0x01
                            537 ;src/UI_GameMenu.c:201: *(char**)(ui_gamemenu_buttonText+3)="MOVE";
   462B 21 33 46      [10]  538 	ld	hl,#___str_11
   462E 22 00 44      [16]  539 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
   4631 C9            [10]  540 	ret
   4632                     541 ___str_10:
   4632 00                  542 	.db 0x00
   4633                     543 ___str_11:
   4633 4D 4F 56 45         544 	.ascii "MOVE"
   4637 00                  545 	.db 0x00
                            546 ;src/UI_GameMenu.c:205: u8 ui_gamemenu_get_movement(){
                            547 ;	---------------------------------
                            548 ; Function ui_gamemenu_get_movement
                            549 ; ---------------------------------
   4638                     550 _ui_gamemenu_get_movement::
                            551 ;src/UI_GameMenu.c:206: return ui_gamemenu_can_move;
   4638 FD 21 45 87   [14]  552 	ld	iy,#_ui_gamemenu_can_move
   463C FD 6E 00      [19]  553 	ld	l,0 (iy)
   463F C9            [10]  554 	ret
                            555 ;src/UI_GameMenu.c:209: u8 ui_gamemenu_get_action(){
                            556 ;	---------------------------------
                            557 ; Function ui_gamemenu_get_action
                            558 ; ---------------------------------
   4640                     559 _ui_gamemenu_get_action::
                            560 ;src/UI_GameMenu.c:210: return ui_gamemenu_action;
   4640 FD 21 46 87   [14]  561 	ld	iy,#_ui_gamemenu_action
   4644 FD 6E 00      [19]  562 	ld	l,0 (iy)
   4647 C9            [10]  563 	ret
                            564 	.area _CODE
                            565 	.area _INITIALIZER
                            566 	.area _CABS (ABS)
