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
                             13 	.globl _ui_gamemenu_action
                             14 	.globl _ui_gamemenu_entrySelected
                             15 	.globl _ui_gamemenu_entryIndex
                             16 	.globl _ui_gamemenu_lastEntry
                             17 	.globl _ui_gamemenu_buttonWidths
                             18 	.globl _ui_gamemenu_buttonText
                             19 	.globl _ui_gamemenu_action_buttonText
                             20 	.globl _ui_gamemenu_entriesPosition
                             21 	.globl _ui_gamemenu_init
                             22 	.globl _ui_gamemenu_next_entry
                             23 	.globl _ui_gamemenu_previous_entry
                             24 	.globl _ui_gamemenu_unselect_entry
                             25 	.globl _ui_gamemenu_select_entry
                             26 	.globl _ui_gamemenu_render_refresh
                             27 	.globl _ui_gamemenu_render_all
                             28 	.globl _ui_gamemenu_get_entry
                             29 	.globl _ui_gamemenu_is_selected
                             30 ;--------------------------------------------------------
                             31 ; special function registers
                             32 ;--------------------------------------------------------
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DATA
                             37 ;--------------------------------------------------------
                             38 ; ram data
                             39 ;--------------------------------------------------------
                             40 	.area _INITIALIZED
   4917                      41 _ui_gamemenu_lastEntry::
   4917                      42 	.ds 1
   4918                      43 _ui_gamemenu_entryIndex::
   4918                      44 	.ds 1
   4919                      45 _ui_gamemenu_entrySelected::
   4919                      46 	.ds 1
   491A                      47 _ui_gamemenu_action::
   491A                      48 	.ds 1
                             49 ;--------------------------------------------------------
                             50 ; absolute external ram data
                             51 ;--------------------------------------------------------
                             52 	.area _DABS (ABS)
                             53 ;--------------------------------------------------------
                             54 ; global & static initialisations
                             55 ;--------------------------------------------------------
                             56 	.area _HOME
                             57 	.area _GSINIT
                             58 	.area _GSFINAL
                             59 	.area _GSINIT
                             60 ;--------------------------------------------------------
                             61 ; Home
                             62 ;--------------------------------------------------------
                             63 	.area _HOME
                             64 	.area _HOME
                             65 ;--------------------------------------------------------
                             66 ; code
                             67 ;--------------------------------------------------------
                             68 	.area _CODE
                             69 ;src/UI_GameMenu.c:44: void ui_gamemenu_init(){
                             70 ;	---------------------------------
                             71 ; Function ui_gamemenu_init
                             72 ; ---------------------------------
   2513                      73 _ui_gamemenu_init::
                             74 ;src/UI_GameMenu.c:45: ui_gamemenu_lastEntry=0;
   2513 21 17 49      [10]   75 	ld	hl,#_ui_gamemenu_lastEntry + 0
   2516 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_GameMenu.c:46: ui_gamemenu_entryIndex=0;
   2518 21 18 49      [10]   78 	ld	hl,#_ui_gamemenu_entryIndex + 0
   251B 36 00         [10]   79 	ld	(hl), #0x00
                             80 ;src/UI_GameMenu.c:47: ui_gamemenu_entrySelected=0;
   251D 21 19 49      [10]   81 	ld	hl,#_ui_gamemenu_entrySelected + 0
   2520 36 00         [10]   82 	ld	(hl), #0x00
   2522 C9            [10]   83 	ret
   2523                      84 _ui_gamemenu_entriesPosition:
   2523 50 C5                85 	.dw #0xC550
   2525 E3 C6                86 	.dw #0xC6E3
   2527 66 C5                87 	.dw #0xC566
   2529 84 C5                88 	.dw #0xC584
   252B 93 C5                89 	.dw #0xC593
   252D 23 C7                90 	.dw #0xC723
   252F                      91 _ui_gamemenu_action_buttonText:
   252F 47 25                92 	.dw __str_0
   2531 4F 25                93 	.dw __str_1
   2533 56 25                94 	.dw __str_2
   2535                      95 _ui_gamemenu_buttonText:
   2535 61 25                96 	.dw __str_3
   2537 63 25                97 	.dw __str_4
   2539 68 25                98 	.dw __str_5
   253B 6A 25                99 	.dw __str_6
   253D 6B 25               100 	.dw __str_7
   253F 6F 25               101 	.dw __str_8
   2541                     102 _ui_gamemenu_buttonWidths:
   2541 06                  103 	.db #0x06	; 6
   2542 16                  104 	.db #0x16	; 22
   2543 06                  105 	.db #0x06	; 6
   2544 0D                  106 	.db #0x0D	; 13
   2545 0D                  107 	.db #0x0D	; 13
   2546 0D                  108 	.db #0x0D	; 13
   2547                     109 __str_0:
   2547 50 49 43 4B 20 55   110 	.ascii "PICK UP"
        50
   254E 00                  111 	.db 0x00
   254F                     112 __str_1:
   254F 41 54 54 41 43 4B   113 	.ascii "ATTACK"
   2555 00                  114 	.db 0x00
   2556                     115 __str_2:
   2556 4E 45 58 54 20 4C   116 	.ascii "NEXT LEVEL"
        45 56 45 4C
   2560 00                  117 	.db 0x00
   2561                     118 __str_3:
   2561 3C                  119 	.ascii "<"
   2562 00                  120 	.db 0x00
   2563                     121 __str_4:
   2563 4D 4F 56 45         122 	.ascii "MOVE"
   2567 00                  123 	.db 0x00
   2568                     124 __str_5:
   2568 3E                  125 	.ascii ">"
   2569 00                  126 	.db 0x00
   256A                     127 __str_6:
   256A 00                  128 	.db 0x00
   256B                     129 __str_7:
   256B 49 4E 56            130 	.ascii "INV"
   256E 00                  131 	.db 0x00
   256F                     132 __str_8:
   256F 50 41 55 53 45      133 	.ascii "PAUSE"
   2574 00                  134 	.db 0x00
                            135 ;src/UI_GameMenu.c:50: void ui_gamemenu_next_entry(){
                            136 ;	---------------------------------
                            137 ; Function ui_gamemenu_next_entry
                            138 ; ---------------------------------
   2575                     139 _ui_gamemenu_next_entry::
                            140 ;src/UI_GameMenu.c:51: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1)){
                            141 ;src/UI_GameMenu.c:52: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   2575 3A 18 49      [13]  142 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2578 FE 05         [ 7]  143 	cp	a,#0x05
   257A D0            [11]  144 	ret	NC
   257B 32 17 49      [13]  145 	ld	(#_ui_gamemenu_lastEntry + 0),a
                            146 ;src/UI_GameMenu.c:53: ++ui_gamemenu_entryIndex;
   257E 21 18 49      [10]  147 	ld	hl, #_ui_gamemenu_entryIndex+0
   2581 34            [11]  148 	inc	(hl)
   2582 C9            [10]  149 	ret
                            150 ;src/UI_GameMenu.c:57: void ui_gamemenu_previous_entry(){
                            151 ;	---------------------------------
                            152 ; Function ui_gamemenu_previous_entry
                            153 ; ---------------------------------
   2583                     154 _ui_gamemenu_previous_entry::
                            155 ;src/UI_GameMenu.c:58: if(ui_gamemenu_entryIndex>0){
   2583 3A 18 49      [13]  156 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2586 B7            [ 4]  157 	or	a, a
   2587 C8            [11]  158 	ret	Z
                            159 ;src/UI_GameMenu.c:59: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   2588 3A 18 49      [13]  160 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   258B 32 17 49      [13]  161 	ld	(#_ui_gamemenu_lastEntry + 0),a
                            162 ;src/UI_GameMenu.c:60: --ui_gamemenu_entryIndex;
   258E 21 18 49      [10]  163 	ld	hl, #_ui_gamemenu_entryIndex+0
   2591 35            [11]  164 	dec	(hl)
   2592 C9            [10]  165 	ret
                            166 ;src/UI_GameMenu.c:64: void ui_gamemenu_unselect_entry(){
                            167 ;	---------------------------------
                            168 ; Function ui_gamemenu_unselect_entry
                            169 ; ---------------------------------
   2593                     170 _ui_gamemenu_unselect_entry::
                            171 ;src/UI_GameMenu.c:65: ui_gamemenu_entrySelected=0;
   2593 21 19 49      [10]  172 	ld	hl,#_ui_gamemenu_entrySelected + 0
   2596 36 00         [10]  173 	ld	(hl), #0x00
   2598 C9            [10]  174 	ret
                            175 ;src/UI_GameMenu.c:68: void ui_gamemenu_select_entry(){
                            176 ;	---------------------------------
                            177 ; Function ui_gamemenu_select_entry
                            178 ; ---------------------------------
   2599                     179 _ui_gamemenu_select_entry::
                            180 ;src/UI_GameMenu.c:69: ui_gamemenu_entrySelected=1;
   2599 21 19 49      [10]  181 	ld	hl,#_ui_gamemenu_entrySelected + 0
   259C 36 01         [10]  182 	ld	(hl), #0x01
   259E C9            [10]  183 	ret
                            184 ;src/UI_GameMenu.c:73: void ui_gamemenu_render_refresh(){
                            185 ;	---------------------------------
                            186 ; Function ui_gamemenu_render_refresh
                            187 ; ---------------------------------
   259F                     188 _ui_gamemenu_render_refresh::
                            189 ;src/UI_GameMenu.c:76: color = (ui_gamemenu_entrySelected)? g_colors[4]: g_colors[5];
   259F 3A 19 49      [13]  190 	ld	a,(#_ui_gamemenu_entrySelected + 0)
   25A2 B7            [ 4]  191 	or	a, a
   25A3 28 05         [12]  192 	jr	Z,00105$
   25A5 3A B6 0A      [13]  193 	ld	a, (#(_g_colors + 0x0004) + 0)
   25A8 18 03         [12]  194 	jr	00106$
   25AA                     195 00105$:
   25AA 3A B7 0A      [13]  196 	ld	a, (#(_g_colors + 0x0005) + 0)
   25AD                     197 00106$:
   25AD 4F            [ 4]  198 	ld	c,a
                            199 ;src/UI_GameMenu.c:77: cpct_drawSolidBox(ui_gamemenu_entriesPosition[ui_gamemenu_entryIndex],color, ui_gamemenu_buttonWidths[ui_gamemenu_entryIndex], UI_GAMEMENU_BUTTON_HEIGHT);
   25AE 3A 18 49      [13]  200 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   25B1 C6 41         [ 7]  201 	add	a, #<(_ui_gamemenu_buttonWidths)
   25B3 5F            [ 4]  202 	ld	e,a
   25B4 3E 00         [ 7]  203 	ld	a,#0x00
   25B6 CE 25         [ 7]  204 	adc	a, #>(_ui_gamemenu_buttonWidths)
   25B8 57            [ 4]  205 	ld	d,a
   25B9 1A            [ 7]  206 	ld	a,(de)
   25BA 47            [ 4]  207 	ld	b,a
   25BB FD 21 18 49   [14]  208 	ld	iy,#_ui_gamemenu_entryIndex
   25BF FD 6E 00      [19]  209 	ld	l,0 (iy)
   25C2 26 00         [ 7]  210 	ld	h,#0x00
   25C4 29            [11]  211 	add	hl, hl
   25C5 11 23 25      [10]  212 	ld	de,#_ui_gamemenu_entriesPosition
   25C8 19            [11]  213 	add	hl,de
   25C9 5E            [ 7]  214 	ld	e,(hl)
   25CA 23            [ 6]  215 	inc	hl
   25CB 56            [ 7]  216 	ld	d,(hl)
   25CC 3E 18         [ 7]  217 	ld	a,#0x18
   25CE F5            [11]  218 	push	af
   25CF 33            [ 6]  219 	inc	sp
   25D0 C5            [11]  220 	push	bc
   25D1 D5            [11]  221 	push	de
   25D2 CD 17 47      [17]  222 	call	_cpct_drawSolidBox
   25D5 F1            [10]  223 	pop	af
   25D6 F1            [10]  224 	pop	af
   25D7 33            [ 6]  225 	inc	sp
                            226 ;src/UI_GameMenu.c:78: print_transparent_text(ui_gamemenu_buttonText[ui_gamemenu_entryIndex], ui_gamemenu_entriesPosition[ui_gamemenu_entryIndex], 3);
   25D8 FD 21 18 49   [14]  227 	ld	iy,#_ui_gamemenu_entryIndex
   25DC FD 6E 00      [19]  228 	ld	l,0 (iy)
   25DF 26 00         [ 7]  229 	ld	h,#0x00
   25E1 29            [11]  230 	add	hl, hl
   25E2 4D            [ 4]  231 	ld	c, l
   25E3 44            [ 4]  232 	ld	b, h
   25E4 21 23 25      [10]  233 	ld	hl,#_ui_gamemenu_entriesPosition
   25E7 09            [11]  234 	add	hl,bc
   25E8 5E            [ 7]  235 	ld	e,(hl)
   25E9 23            [ 6]  236 	inc	hl
   25EA 56            [ 7]  237 	ld	d,(hl)
   25EB 21 35 25      [10]  238 	ld	hl,#_ui_gamemenu_buttonText
   25EE 09            [11]  239 	add	hl,bc
   25EF 4E            [ 7]  240 	ld	c,(hl)
   25F0 23            [ 6]  241 	inc	hl
   25F1 46            [ 7]  242 	ld	b,(hl)
   25F2 3E 03         [ 7]  243 	ld	a,#0x03
   25F4 F5            [11]  244 	push	af
   25F5 33            [ 6]  245 	inc	sp
   25F6 D5            [11]  246 	push	de
   25F7 C5            [11]  247 	push	bc
   25F8 CD AB 21      [17]  248 	call	_print_transparent_text
   25FB F1            [10]  249 	pop	af
   25FC F1            [10]  250 	pop	af
   25FD 33            [ 6]  251 	inc	sp
                            252 ;src/UI_GameMenu.c:80: if(ui_gamemenu_lastEntry!=ui_gamemenu_entryIndex){
   25FE 3A 17 49      [13]  253 	ld	a,(#_ui_gamemenu_lastEntry + 0)
   2601 FD 21 18 49   [14]  254 	ld	iy,#_ui_gamemenu_entryIndex
   2605 FD 96 00      [19]  255 	sub	a, 0 (iy)
   2608 C8            [11]  256 	ret	Z
                            257 ;src/UI_GameMenu.c:81: color = g_colors[2];
   2609 21 B4 0A      [10]  258 	ld	hl,#_g_colors+2
   260C 5E            [ 7]  259 	ld	e,(hl)
                            260 ;src/UI_GameMenu.c:82: cpct_drawSolidBox(ui_gamemenu_entriesPosition[ui_gamemenu_lastEntry],color, ui_gamemenu_buttonWidths[ui_gamemenu_lastEntry], UI_GAMEMENU_BUTTON_HEIGHT);
   260D 3E 41         [ 7]  261 	ld	a,#<(_ui_gamemenu_buttonWidths)
   260F 21 17 49      [10]  262 	ld	hl,#_ui_gamemenu_lastEntry
   2612 86            [ 7]  263 	add	a, (hl)
   2613 4F            [ 4]  264 	ld	c,a
   2614 3E 25         [ 7]  265 	ld	a,#>(_ui_gamemenu_buttonWidths)
   2616 CE 00         [ 7]  266 	adc	a, #0x00
   2618 47            [ 4]  267 	ld	b,a
   2619 0A            [ 7]  268 	ld	a,(bc)
   261A 57            [ 4]  269 	ld	d,a
   261B FD 21 17 49   [14]  270 	ld	iy,#_ui_gamemenu_lastEntry
   261F FD 6E 00      [19]  271 	ld	l,0 (iy)
   2622 26 00         [ 7]  272 	ld	h,#0x00
   2624 29            [11]  273 	add	hl, hl
   2625 01 23 25      [10]  274 	ld	bc,#_ui_gamemenu_entriesPosition
   2628 09            [11]  275 	add	hl,bc
   2629 4E            [ 7]  276 	ld	c,(hl)
   262A 23            [ 6]  277 	inc	hl
   262B 46            [ 7]  278 	ld	b,(hl)
   262C 3E 18         [ 7]  279 	ld	a,#0x18
   262E F5            [11]  280 	push	af
   262F 33            [ 6]  281 	inc	sp
   2630 D5            [11]  282 	push	de
   2631 C5            [11]  283 	push	bc
   2632 CD 17 47      [17]  284 	call	_cpct_drawSolidBox
   2635 F1            [10]  285 	pop	af
   2636 F1            [10]  286 	pop	af
   2637 33            [ 6]  287 	inc	sp
                            288 ;src/UI_GameMenu.c:83: print_transparent_text(ui_gamemenu_buttonText[ui_gamemenu_lastEntry], ui_gamemenu_entriesPosition[ui_gamemenu_lastEntry], 3);
   2638 FD 21 17 49   [14]  289 	ld	iy,#_ui_gamemenu_lastEntry
   263C FD 6E 00      [19]  290 	ld	l,0 (iy)
   263F 26 00         [ 7]  291 	ld	h,#0x00
   2641 29            [11]  292 	add	hl, hl
   2642 4D            [ 4]  293 	ld	c, l
   2643 44            [ 4]  294 	ld	b, h
   2644 21 23 25      [10]  295 	ld	hl,#_ui_gamemenu_entriesPosition
   2647 09            [11]  296 	add	hl,bc
   2648 5E            [ 7]  297 	ld	e,(hl)
   2649 23            [ 6]  298 	inc	hl
   264A 56            [ 7]  299 	ld	d,(hl)
   264B 21 35 25      [10]  300 	ld	hl,#_ui_gamemenu_buttonText
   264E 09            [11]  301 	add	hl,bc
   264F 4E            [ 7]  302 	ld	c,(hl)
   2650 23            [ 6]  303 	inc	hl
   2651 46            [ 7]  304 	ld	b,(hl)
   2652 3E 03         [ 7]  305 	ld	a,#0x03
   2654 F5            [11]  306 	push	af
   2655 33            [ 6]  307 	inc	sp
   2656 D5            [11]  308 	push	de
   2657 C5            [11]  309 	push	bc
   2658 CD AB 21      [17]  310 	call	_print_transparent_text
   265B F1            [10]  311 	pop	af
   265C F1            [10]  312 	pop	af
   265D 33            [ 6]  313 	inc	sp
                            314 ;src/UI_GameMenu.c:84: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   265E 3A 18 49      [13]  315 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2661 32 17 49      [13]  316 	ld	(#_ui_gamemenu_lastEntry + 0),a
   2664 C9            [10]  317 	ret
                            318 ;src/UI_GameMenu.c:89: void ui_gamemenu_render_all(){
                            319 ;	---------------------------------
                            320 ; Function ui_gamemenu_render_all
                            321 ; ---------------------------------
   2665                     322 _ui_gamemenu_render_all::
   2665 DD E5         [15]  323 	push	ix
   2667 DD 21 00 00   [14]  324 	ld	ix,#0
   266B DD 39         [15]  325 	add	ix,sp
   266D F5            [11]  326 	push	af
   266E 3B            [ 6]  327 	dec	sp
                            328 ;src/UI_GameMenu.c:93: while(n){
   266F DD 36 FD 06   [19]  329 	ld	-3 (ix),#0x06
   2673                     330 00101$:
   2673 DD 7E FD      [19]  331 	ld	a,-3 (ix)
   2676 B7            [ 4]  332 	or	a, a
   2677 28 77         [12]  333 	jr	Z,00103$
                            334 ;src/UI_GameMenu.c:94: --n;
   2679 DD 35 FD      [23]  335 	dec	-3 (ix)
                            336 ;src/UI_GameMenu.c:95: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
   267C 3A 18 49      [13]  337 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   267F DD 96 FD      [19]  338 	sub	a, -3 (ix)
   2682 20 10         [12]  339 	jr	NZ,00106$
   2684 3A 19 49      [13]  340 	ld	a,(#_ui_gamemenu_entrySelected + 0)
   2687 B7            [ 4]  341 	or	a, a
   2688 28 05         [12]  342 	jr	Z,00108$
   268A 3A B6 0A      [13]  343 	ld	a, (#_g_colors + 4)
   268D 18 08         [12]  344 	jr	00107$
   268F                     345 00108$:
   268F 3A B7 0A      [13]  346 	ld	a, (#_g_colors + 5)
   2692 18 03         [12]  347 	jr	00107$
   2694                     348 00106$:
   2694 3A B4 0A      [13]  349 	ld	a, (#_g_colors + 2)
   2697                     350 00107$:
   2697 4F            [ 4]  351 	ld	c,a
                            352 ;src/UI_GameMenu.c:96: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
   2698 3E 41         [ 7]  353 	ld	a,#<(_ui_gamemenu_buttonWidths)
   269A DD 86 FD      [19]  354 	add	a, -3 (ix)
   269D 6F            [ 4]  355 	ld	l,a
   269E 3E 25         [ 7]  356 	ld	a,#>(_ui_gamemenu_buttonWidths)
   26A0 CE 00         [ 7]  357 	adc	a, #0x00
   26A2 67            [ 4]  358 	ld	h,a
   26A3 46            [ 7]  359 	ld	b,(hl)
   26A4 DD 6E FD      [19]  360 	ld	l,-3 (ix)
   26A7 26 00         [ 7]  361 	ld	h,#0x00
   26A9 29            [11]  362 	add	hl, hl
   26AA EB            [ 4]  363 	ex	de,hl
   26AB 21 23 25      [10]  364 	ld	hl,#_ui_gamemenu_entriesPosition
   26AE 19            [11]  365 	add	hl,de
   26AF DD 75 FE      [19]  366 	ld	-2 (ix),l
   26B2 DD 74 FF      [19]  367 	ld	-1 (ix),h
   26B5 DD 6E FE      [19]  368 	ld	l,-2 (ix)
   26B8 DD 66 FF      [19]  369 	ld	h,-1 (ix)
   26BB 7E            [ 7]  370 	ld	a, (hl)
   26BC 23            [ 6]  371 	inc	hl
   26BD 66            [ 7]  372 	ld	h,(hl)
   26BE 6F            [ 4]  373 	ld	l,a
   26BF E5            [11]  374 	push	hl
   26C0 FD E1         [14]  375 	pop	iy
   26C2 D5            [11]  376 	push	de
   26C3 3E 18         [ 7]  377 	ld	a,#0x18
   26C5 F5            [11]  378 	push	af
   26C6 33            [ 6]  379 	inc	sp
   26C7 C5            [11]  380 	push	bc
   26C8 FD E5         [15]  381 	push	iy
   26CA CD 17 47      [17]  382 	call	_cpct_drawSolidBox
   26CD F1            [10]  383 	pop	af
   26CE F1            [10]  384 	pop	af
   26CF 33            [ 6]  385 	inc	sp
   26D0 D1            [10]  386 	pop	de
                            387 ;src/UI_GameMenu.c:97: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesPosition[n], 3);
   26D1 DD 6E FE      [19]  388 	ld	l,-2 (ix)
   26D4 DD 66 FF      [19]  389 	ld	h,-1 (ix)
   26D7 4E            [ 7]  390 	ld	c,(hl)
   26D8 23            [ 6]  391 	inc	hl
   26D9 46            [ 7]  392 	ld	b,(hl)
   26DA 21 35 25      [10]  393 	ld	hl,#_ui_gamemenu_buttonText
   26DD 19            [11]  394 	add	hl,de
   26DE 5E            [ 7]  395 	ld	e,(hl)
   26DF 23            [ 6]  396 	inc	hl
   26E0 56            [ 7]  397 	ld	d,(hl)
   26E1 3E 03         [ 7]  398 	ld	a,#0x03
   26E3 F5            [11]  399 	push	af
   26E4 33            [ 6]  400 	inc	sp
   26E5 C5            [11]  401 	push	bc
   26E6 D5            [11]  402 	push	de
   26E7 CD AB 21      [17]  403 	call	_print_transparent_text
   26EA F1            [10]  404 	pop	af
   26EB F1            [10]  405 	pop	af
   26EC 33            [ 6]  406 	inc	sp
   26ED C3 73 26      [10]  407 	jp	00101$
   26F0                     408 00103$:
                            409 ;src/UI_GameMenu.c:100: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   26F0 3A 18 49      [13]  410 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   26F3 32 17 49      [13]  411 	ld	(#_ui_gamemenu_lastEntry + 0),a
   26F6 DD F9         [10]  412 	ld	sp, ix
   26F8 DD E1         [14]  413 	pop	ix
   26FA C9            [10]  414 	ret
                            415 ;src/UI_GameMenu.c:103: u8 ui_gamemenu_get_entry(){
                            416 ;	---------------------------------
                            417 ; Function ui_gamemenu_get_entry
                            418 ; ---------------------------------
   26FB                     419 _ui_gamemenu_get_entry::
                            420 ;src/UI_GameMenu.c:104: return ui_gamemenu_entryIndex;
   26FB FD 21 18 49   [14]  421 	ld	iy,#_ui_gamemenu_entryIndex
   26FF FD 6E 00      [19]  422 	ld	l,0 (iy)
   2702 C9            [10]  423 	ret
                            424 ;src/UI_GameMenu.c:107: u8 ui_gamemenu_is_selected(){
                            425 ;	---------------------------------
                            426 ; Function ui_gamemenu_is_selected
                            427 ; ---------------------------------
   2703                     428 _ui_gamemenu_is_selected::
                            429 ;src/UI_GameMenu.c:108: return ui_gamemenu_entrySelected;
   2703 FD 21 19 49   [14]  430 	ld	iy,#_ui_gamemenu_entrySelected
   2707 FD 6E 00      [19]  431 	ld	l,0 (iy)
   270A C9            [10]  432 	ret
                            433 	.area _CODE
                            434 	.area _INITIALIZER
   4920                     435 __xinit__ui_gamemenu_lastEntry:
   4920 00                  436 	.db #0x00	; 0
   4921                     437 __xinit__ui_gamemenu_entryIndex:
   4921 00                  438 	.db #0x00	; 0
   4922                     439 __xinit__ui_gamemenu_entrySelected:
   4922 00                  440 	.db #0x00	; 0
   4923                     441 __xinit__ui_gamemenu_action:
   4923 00                  442 	.db #0x00	; 0
                            443 	.area _CABS (ABS)
