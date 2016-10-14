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
                             11 	.globl _print_transparent_text
                             12 	.globl _cpct_drawSolidBox
                             13 	.globl _entrySelected
                             14 	.globl _entryIndex
                             15 	.globl _lastEntry
                             16 	.globl _buttonWidths
                             17 	.globl _buttonText
                             18 	.globl _entriesPosition
                             19 	.globl _ui_gamemenu_init
                             20 	.globl _ui_gamemenu_next_entry
                             21 	.globl _ui_gamemenu_previous_entry
                             22 	.globl _ui_gamemenu_unselect_entry
                             23 	.globl _ui_gamemenu_select_entry
                             24 	.globl _ui_gamemenu_render_refresh
                             25 	.globl _ui_gamemenu_render_all
                             26 	.globl _ui_gamemenu_get_entry
                             27 	.globl _ui_gamemenu_is_selected
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
   4544                      39 _lastEntry::
   4544                      40 	.ds 1
   4545                      41 _entryIndex::
   4545                      42 	.ds 1
   4546                      43 _entrySelected::
   4546                      44 	.ds 1
                             45 ;--------------------------------------------------------
                             46 ; absolute external ram data
                             47 ;--------------------------------------------------------
                             48 	.area _DABS (ABS)
                             49 ;--------------------------------------------------------
                             50 ; global & static initialisations
                             51 ;--------------------------------------------------------
                             52 	.area _HOME
                             53 	.area _GSINIT
                             54 	.area _GSFINAL
                             55 	.area _GSINIT
                             56 ;--------------------------------------------------------
                             57 ; Home
                             58 ;--------------------------------------------------------
                             59 	.area _HOME
                             60 	.area _HOME
                             61 ;--------------------------------------------------------
                             62 ; code
                             63 ;--------------------------------------------------------
                             64 	.area _CODE
                             65 ;src/UI_GameMenu.c:38: void ui_gamemenu_init(){
                             66 ;	---------------------------------
                             67 ; Function ui_gamemenu_init
                             68 ; ---------------------------------
   23FB                      69 _ui_gamemenu_init::
                             70 ;src/UI_GameMenu.c:39: lastEntry=0;
   23FB 21 44 45      [10]   71 	ld	hl,#_lastEntry + 0
   23FE 36 00         [10]   72 	ld	(hl), #0x00
                             73 ;src/UI_GameMenu.c:40: entryIndex=0;
   2400 21 45 45      [10]   74 	ld	hl,#_entryIndex + 0
   2403 36 00         [10]   75 	ld	(hl), #0x00
                             76 ;src/UI_GameMenu.c:41: entrySelected=0;
   2405 21 46 45      [10]   77 	ld	hl,#_entrySelected + 0
   2408 36 00         [10]   78 	ld	(hl), #0x00
   240A C9            [10]   79 	ret
   240B                      80 _entriesPosition:
   240B 50 C5                81 	.dw #0xC550
   240D E3 C6                82 	.dw #0xC6E3
   240F 66 C5                83 	.dw #0xC566
   2411 84 C5                84 	.dw #0xC584
   2413 93 C5                85 	.dw #0xC593
   2415 23 C7                86 	.dw #0xC723
   2417                      87 _buttonText:
   2417 29 24                88 	.dw __str_0
   2419 2B 24                89 	.dw __str_1
   241B 30 24                90 	.dw __str_2
   241D 32 24                91 	.dw __str_3
   241F 39 24                92 	.dw __str_4
   2421 3D 24                93 	.dw __str_5
   2423                      94 _buttonWidths:
   2423 06                   95 	.db #0x06	; 6
   2424 16                   96 	.db #0x16	; 22
   2425 06                   97 	.db #0x06	; 6
   2426 0D                   98 	.db #0x0D	; 13
   2427 0D                   99 	.db #0x0D	; 13
   2428 0D                  100 	.db #0x0D	; 13
   2429                     101 __str_0:
   2429 3C                  102 	.ascii "<"
   242A 00                  103 	.db 0x00
   242B                     104 __str_1:
   242B 4D 4F 56 45         105 	.ascii "MOVE"
   242F 00                  106 	.db 0x00
   2430                     107 __str_2:
   2430 3E                  108 	.ascii ">"
   2431 00                  109 	.db 0x00
   2432                     110 __str_3:
   2432 41 54 54 41 43 4B   111 	.ascii "ATTACK"
   2438 00                  112 	.db 0x00
   2439                     113 __str_4:
   2439 49 4E 56            114 	.ascii "INV"
   243C 00                  115 	.db 0x00
   243D                     116 __str_5:
   243D 50 41 55 53 45      117 	.ascii "PAUSE"
   2442 00                  118 	.db 0x00
                            119 ;src/UI_GameMenu.c:44: void ui_gamemenu_next_entry(){
                            120 ;	---------------------------------
                            121 ; Function ui_gamemenu_next_entry
                            122 ; ---------------------------------
   2443                     123 _ui_gamemenu_next_entry::
                            124 ;src/UI_GameMenu.c:45: if(entryIndex<(ENTRIES-1)){
                            125 ;src/UI_GameMenu.c:46: lastEntry=entryIndex;
   2443 3A 45 45      [13]  126 	ld	a,(#_entryIndex + 0)
   2446 FE 05         [ 7]  127 	cp	a,#0x05
   2448 D0            [11]  128 	ret	NC
   2449 32 44 45      [13]  129 	ld	(#_lastEntry + 0),a
                            130 ;src/UI_GameMenu.c:47: ++entryIndex;
   244C 21 45 45      [10]  131 	ld	hl, #_entryIndex+0
   244F 34            [11]  132 	inc	(hl)
   2450 C9            [10]  133 	ret
                            134 ;src/UI_GameMenu.c:51: void ui_gamemenu_previous_entry(){
                            135 ;	---------------------------------
                            136 ; Function ui_gamemenu_previous_entry
                            137 ; ---------------------------------
   2451                     138 _ui_gamemenu_previous_entry::
                            139 ;src/UI_GameMenu.c:52: if(entryIndex>0){
   2451 3A 45 45      [13]  140 	ld	a,(#_entryIndex + 0)
   2454 B7            [ 4]  141 	or	a, a
   2455 C8            [11]  142 	ret	Z
                            143 ;src/UI_GameMenu.c:53: lastEntry=entryIndex;
   2456 3A 45 45      [13]  144 	ld	a,(#_entryIndex + 0)
   2459 32 44 45      [13]  145 	ld	(#_lastEntry + 0),a
                            146 ;src/UI_GameMenu.c:54: --entryIndex;
   245C 21 45 45      [10]  147 	ld	hl, #_entryIndex+0
   245F 35            [11]  148 	dec	(hl)
   2460 C9            [10]  149 	ret
                            150 ;src/UI_GameMenu.c:58: void ui_gamemenu_unselect_entry(){
                            151 ;	---------------------------------
                            152 ; Function ui_gamemenu_unselect_entry
                            153 ; ---------------------------------
   2461                     154 _ui_gamemenu_unselect_entry::
                            155 ;src/UI_GameMenu.c:59: entrySelected=0;
   2461 21 46 45      [10]  156 	ld	hl,#_entrySelected + 0
   2464 36 00         [10]  157 	ld	(hl), #0x00
   2466 C9            [10]  158 	ret
                            159 ;src/UI_GameMenu.c:62: void ui_gamemenu_select_entry(){
                            160 ;	---------------------------------
                            161 ; Function ui_gamemenu_select_entry
                            162 ; ---------------------------------
   2467                     163 _ui_gamemenu_select_entry::
                            164 ;src/UI_GameMenu.c:63: entrySelected=1;
   2467 21 46 45      [10]  165 	ld	hl,#_entrySelected + 0
   246A 36 01         [10]  166 	ld	(hl), #0x01
   246C C9            [10]  167 	ret
                            168 ;src/UI_GameMenu.c:67: void ui_gamemenu_render_refresh(){
                            169 ;	---------------------------------
                            170 ; Function ui_gamemenu_render_refresh
                            171 ; ---------------------------------
   246D                     172 _ui_gamemenu_render_refresh::
                            173 ;src/UI_GameMenu.c:70: color = (entrySelected)? g_colors[4]: g_colors[5];
   246D 3A 46 45      [13]  174 	ld	a,(#_entrySelected + 0)
   2470 B7            [ 4]  175 	or	a, a
   2471 28 05         [12]  176 	jr	Z,00105$
   2473 3A A9 0A      [13]  177 	ld	a, (#(_g_colors + 0x0004) + 0)
   2476 18 03         [12]  178 	jr	00106$
   2478                     179 00105$:
   2478 3A AA 0A      [13]  180 	ld	a, (#(_g_colors + 0x0005) + 0)
   247B                     181 00106$:
   247B 4F            [ 4]  182 	ld	c,a
                            183 ;src/UI_GameMenu.c:71: cpct_drawSolidBox(entriesPosition[entryIndex],color, buttonWidths[entryIndex], BUTTON_HEIGHT);
   247C 3A 45 45      [13]  184 	ld	a,(#_entryIndex + 0)
   247F C6 23         [ 7]  185 	add	a, #<(_buttonWidths)
   2481 5F            [ 4]  186 	ld	e,a
   2482 3E 00         [ 7]  187 	ld	a,#0x00
   2484 CE 24         [ 7]  188 	adc	a, #>(_buttonWidths)
   2486 57            [ 4]  189 	ld	d,a
   2487 1A            [ 7]  190 	ld	a,(de)
   2488 47            [ 4]  191 	ld	b,a
   2489 FD 21 45 45   [14]  192 	ld	iy,#_entryIndex
   248D FD 6E 00      [19]  193 	ld	l,0 (iy)
   2490 26 00         [ 7]  194 	ld	h,#0x00
   2492 29            [11]  195 	add	hl, hl
   2493 11 0B 24      [10]  196 	ld	de,#_entriesPosition
   2496 19            [11]  197 	add	hl,de
   2497 5E            [ 7]  198 	ld	e,(hl)
   2498 23            [ 6]  199 	inc	hl
   2499 56            [ 7]  200 	ld	d,(hl)
   249A 3E 18         [ 7]  201 	ld	a,#0x18
   249C F5            [11]  202 	push	af
   249D 33            [ 6]  203 	inc	sp
   249E C5            [11]  204 	push	bc
   249F D5            [11]  205 	push	de
   24A0 CD 44 43      [17]  206 	call	_cpct_drawSolidBox
   24A3 F1            [10]  207 	pop	af
   24A4 F1            [10]  208 	pop	af
   24A5 33            [ 6]  209 	inc	sp
                            210 ;src/UI_GameMenu.c:72: print_transparent_text(buttonText[entryIndex], entriesPosition[entryIndex], 3);
   24A6 FD 21 45 45   [14]  211 	ld	iy,#_entryIndex
   24AA FD 6E 00      [19]  212 	ld	l,0 (iy)
   24AD 26 00         [ 7]  213 	ld	h,#0x00
   24AF 29            [11]  214 	add	hl, hl
   24B0 4D            [ 4]  215 	ld	c, l
   24B1 44            [ 4]  216 	ld	b, h
   24B2 21 0B 24      [10]  217 	ld	hl,#_entriesPosition
   24B5 09            [11]  218 	add	hl,bc
   24B6 5E            [ 7]  219 	ld	e,(hl)
   24B7 23            [ 6]  220 	inc	hl
   24B8 56            [ 7]  221 	ld	d,(hl)
   24B9 21 17 24      [10]  222 	ld	hl,#_buttonText
   24BC 09            [11]  223 	add	hl,bc
   24BD 4E            [ 7]  224 	ld	c,(hl)
   24BE 23            [ 6]  225 	inc	hl
   24BF 46            [ 7]  226 	ld	b,(hl)
   24C0 3E 03         [ 7]  227 	ld	a,#0x03
   24C2 F5            [11]  228 	push	af
   24C3 33            [ 6]  229 	inc	sp
   24C4 D5            [11]  230 	push	de
   24C5 C5            [11]  231 	push	bc
   24C6 CD AE 20      [17]  232 	call	_print_transparent_text
   24C9 F1            [10]  233 	pop	af
   24CA F1            [10]  234 	pop	af
   24CB 33            [ 6]  235 	inc	sp
                            236 ;src/UI_GameMenu.c:74: if(lastEntry!=entryIndex){
   24CC 3A 44 45      [13]  237 	ld	a,(#_lastEntry + 0)
   24CF FD 21 45 45   [14]  238 	ld	iy,#_entryIndex
   24D3 FD 96 00      [19]  239 	sub	a, 0 (iy)
   24D6 C8            [11]  240 	ret	Z
                            241 ;src/UI_GameMenu.c:75: color = g_colors[2];
   24D7 21 A7 0A      [10]  242 	ld	hl,#_g_colors+2
   24DA 5E            [ 7]  243 	ld	e,(hl)
                            244 ;src/UI_GameMenu.c:76: cpct_drawSolidBox(entriesPosition[lastEntry],color, buttonWidths[lastEntry], BUTTON_HEIGHT);
   24DB 3E 23         [ 7]  245 	ld	a,#<(_buttonWidths)
   24DD 21 44 45      [10]  246 	ld	hl,#_lastEntry
   24E0 86            [ 7]  247 	add	a, (hl)
   24E1 4F            [ 4]  248 	ld	c,a
   24E2 3E 24         [ 7]  249 	ld	a,#>(_buttonWidths)
   24E4 CE 00         [ 7]  250 	adc	a, #0x00
   24E6 47            [ 4]  251 	ld	b,a
   24E7 0A            [ 7]  252 	ld	a,(bc)
   24E8 57            [ 4]  253 	ld	d,a
   24E9 FD 21 44 45   [14]  254 	ld	iy,#_lastEntry
   24ED FD 6E 00      [19]  255 	ld	l,0 (iy)
   24F0 26 00         [ 7]  256 	ld	h,#0x00
   24F2 29            [11]  257 	add	hl, hl
   24F3 01 0B 24      [10]  258 	ld	bc,#_entriesPosition
   24F6 09            [11]  259 	add	hl,bc
   24F7 4E            [ 7]  260 	ld	c,(hl)
   24F8 23            [ 6]  261 	inc	hl
   24F9 46            [ 7]  262 	ld	b,(hl)
   24FA 3E 18         [ 7]  263 	ld	a,#0x18
   24FC F5            [11]  264 	push	af
   24FD 33            [ 6]  265 	inc	sp
   24FE D5            [11]  266 	push	de
   24FF C5            [11]  267 	push	bc
   2500 CD 44 43      [17]  268 	call	_cpct_drawSolidBox
   2503 F1            [10]  269 	pop	af
   2504 F1            [10]  270 	pop	af
   2505 33            [ 6]  271 	inc	sp
                            272 ;src/UI_GameMenu.c:77: print_transparent_text(buttonText[lastEntry], entriesPosition[lastEntry], 3);
   2506 FD 21 44 45   [14]  273 	ld	iy,#_lastEntry
   250A FD 6E 00      [19]  274 	ld	l,0 (iy)
   250D 26 00         [ 7]  275 	ld	h,#0x00
   250F 29            [11]  276 	add	hl, hl
   2510 4D            [ 4]  277 	ld	c, l
   2511 44            [ 4]  278 	ld	b, h
   2512 21 0B 24      [10]  279 	ld	hl,#_entriesPosition
   2515 09            [11]  280 	add	hl,bc
   2516 5E            [ 7]  281 	ld	e,(hl)
   2517 23            [ 6]  282 	inc	hl
   2518 56            [ 7]  283 	ld	d,(hl)
   2519 21 17 24      [10]  284 	ld	hl,#_buttonText
   251C 09            [11]  285 	add	hl,bc
   251D 4E            [ 7]  286 	ld	c,(hl)
   251E 23            [ 6]  287 	inc	hl
   251F 46            [ 7]  288 	ld	b,(hl)
   2520 3E 03         [ 7]  289 	ld	a,#0x03
   2522 F5            [11]  290 	push	af
   2523 33            [ 6]  291 	inc	sp
   2524 D5            [11]  292 	push	de
   2525 C5            [11]  293 	push	bc
   2526 CD AE 20      [17]  294 	call	_print_transparent_text
   2529 F1            [10]  295 	pop	af
   252A F1            [10]  296 	pop	af
   252B 33            [ 6]  297 	inc	sp
   252C C9            [10]  298 	ret
                            299 ;src/UI_GameMenu.c:82: void ui_gamemenu_render_all(){
                            300 ;	---------------------------------
                            301 ; Function ui_gamemenu_render_all
                            302 ; ---------------------------------
   252D                     303 _ui_gamemenu_render_all::
   252D DD E5         [15]  304 	push	ix
   252F DD 21 00 00   [14]  305 	ld	ix,#0
   2533 DD 39         [15]  306 	add	ix,sp
   2535 F5            [11]  307 	push	af
   2536 3B            [ 6]  308 	dec	sp
                            309 ;src/UI_GameMenu.c:86: while(n){
   2537 DD 36 FD 06   [19]  310 	ld	-3 (ix),#0x06
   253B                     311 00101$:
   253B DD 7E FD      [19]  312 	ld	a,-3 (ix)
   253E B7            [ 4]  313 	or	a, a
   253F 28 77         [12]  314 	jr	Z,00104$
                            315 ;src/UI_GameMenu.c:87: --n;
   2541 DD 35 FD      [23]  316 	dec	-3 (ix)
                            317 ;src/UI_GameMenu.c:88: color = (n==entryIndex)?((entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
   2544 3A 45 45      [13]  318 	ld	a,(#_entryIndex + 0)
   2547 DD 96 FD      [19]  319 	sub	a, -3 (ix)
   254A 20 10         [12]  320 	jr	NZ,00106$
   254C 3A 46 45      [13]  321 	ld	a,(#_entrySelected + 0)
   254F B7            [ 4]  322 	or	a, a
   2550 28 05         [12]  323 	jr	Z,00108$
   2552 3A A9 0A      [13]  324 	ld	a, (#_g_colors + 4)
   2555 18 08         [12]  325 	jr	00107$
   2557                     326 00108$:
   2557 3A AA 0A      [13]  327 	ld	a, (#_g_colors + 5)
   255A 18 03         [12]  328 	jr	00107$
   255C                     329 00106$:
   255C 3A A7 0A      [13]  330 	ld	a, (#_g_colors + 2)
   255F                     331 00107$:
   255F 4F            [ 4]  332 	ld	c,a
                            333 ;src/UI_GameMenu.c:89: cpct_drawSolidBox(entriesPosition[n],color, buttonWidths[n], BUTTON_HEIGHT);
   2560 3E 23         [ 7]  334 	ld	a,#<(_buttonWidths)
   2562 DD 86 FD      [19]  335 	add	a, -3 (ix)
   2565 6F            [ 4]  336 	ld	l,a
   2566 3E 24         [ 7]  337 	ld	a,#>(_buttonWidths)
   2568 CE 00         [ 7]  338 	adc	a, #0x00
   256A 67            [ 4]  339 	ld	h,a
   256B 46            [ 7]  340 	ld	b,(hl)
   256C DD 6E FD      [19]  341 	ld	l,-3 (ix)
   256F 26 00         [ 7]  342 	ld	h,#0x00
   2571 29            [11]  343 	add	hl, hl
   2572 EB            [ 4]  344 	ex	de,hl
   2573 21 0B 24      [10]  345 	ld	hl,#_entriesPosition
   2576 19            [11]  346 	add	hl,de
   2577 DD 75 FE      [19]  347 	ld	-2 (ix),l
   257A DD 74 FF      [19]  348 	ld	-1 (ix),h
   257D DD 6E FE      [19]  349 	ld	l,-2 (ix)
   2580 DD 66 FF      [19]  350 	ld	h,-1 (ix)
   2583 7E            [ 7]  351 	ld	a, (hl)
   2584 23            [ 6]  352 	inc	hl
   2585 66            [ 7]  353 	ld	h,(hl)
   2586 6F            [ 4]  354 	ld	l,a
   2587 E5            [11]  355 	push	hl
   2588 FD E1         [14]  356 	pop	iy
   258A D5            [11]  357 	push	de
   258B 3E 18         [ 7]  358 	ld	a,#0x18
   258D F5            [11]  359 	push	af
   258E 33            [ 6]  360 	inc	sp
   258F C5            [11]  361 	push	bc
   2590 FD E5         [15]  362 	push	iy
   2592 CD 44 43      [17]  363 	call	_cpct_drawSolidBox
   2595 F1            [10]  364 	pop	af
   2596 F1            [10]  365 	pop	af
   2597 33            [ 6]  366 	inc	sp
   2598 D1            [10]  367 	pop	de
                            368 ;src/UI_GameMenu.c:90: print_transparent_text(buttonText[n], entriesPosition[n], 3);
   2599 DD 6E FE      [19]  369 	ld	l,-2 (ix)
   259C DD 66 FF      [19]  370 	ld	h,-1 (ix)
   259F 4E            [ 7]  371 	ld	c,(hl)
   25A0 23            [ 6]  372 	inc	hl
   25A1 46            [ 7]  373 	ld	b,(hl)
   25A2 21 17 24      [10]  374 	ld	hl,#_buttonText
   25A5 19            [11]  375 	add	hl,de
   25A6 5E            [ 7]  376 	ld	e,(hl)
   25A7 23            [ 6]  377 	inc	hl
   25A8 56            [ 7]  378 	ld	d,(hl)
   25A9 3E 03         [ 7]  379 	ld	a,#0x03
   25AB F5            [11]  380 	push	af
   25AC 33            [ 6]  381 	inc	sp
   25AD C5            [11]  382 	push	bc
   25AE D5            [11]  383 	push	de
   25AF CD AE 20      [17]  384 	call	_print_transparent_text
   25B2 F1            [10]  385 	pop	af
   25B3 F1            [10]  386 	pop	af
   25B4 33            [ 6]  387 	inc	sp
   25B5 C3 3B 25      [10]  388 	jp	00101$
   25B8                     389 00104$:
   25B8 DD F9         [10]  390 	ld	sp, ix
   25BA DD E1         [14]  391 	pop	ix
   25BC C9            [10]  392 	ret
                            393 ;src/UI_GameMenu.c:96: u8 ui_gamemenu_get_entry(){
                            394 ;	---------------------------------
                            395 ; Function ui_gamemenu_get_entry
                            396 ; ---------------------------------
   25BD                     397 _ui_gamemenu_get_entry::
                            398 ;src/UI_GameMenu.c:97: return entryIndex;
   25BD FD 21 45 45   [14]  399 	ld	iy,#_entryIndex
   25C1 FD 6E 00      [19]  400 	ld	l,0 (iy)
   25C4 C9            [10]  401 	ret
                            402 ;src/UI_GameMenu.c:100: u8 ui_gamemenu_is_selected(){
                            403 ;	---------------------------------
                            404 ; Function ui_gamemenu_is_selected
                            405 ; ---------------------------------
   25C5                     406 _ui_gamemenu_is_selected::
                            407 ;src/UI_GameMenu.c:101: return entrySelected;
   25C5 FD 21 46 45   [14]  408 	ld	iy,#_entrySelected
   25C9 FD 6E 00      [19]  409 	ld	l,0 (iy)
   25CC C9            [10]  410 	ret
                            411 	.area _CODE
                            412 	.area _INITIALIZER
   4549                     413 __xinit__lastEntry:
   4549 00                  414 	.db #0x00	; 0
   454A                     415 __xinit__entryIndex:
   454A 00                  416 	.db #0x00	; 0
   454B                     417 __xinit__entrySelected:
   454B 00                  418 	.db #0x00	; 0
                            419 	.area _CABS (ABS)
