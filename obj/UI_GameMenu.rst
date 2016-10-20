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
                             12 	.globl _print_transparent_text
                             13 	.globl _cpct_drawSolidBox
                             14 	.globl _ui_gamemenu_action
                             15 	.globl _ui_gamemenu_can_move
                             16 	.globl _ui_gamemenu_entrySelected
                             17 	.globl _ui_gamemenu_entryIndex
                             18 	.globl _ui_gamemenu_lastEntry
                             19 	.globl _ui_gamemenu_buttonWidths
                             20 	.globl _ui_gamemenu_buttonText
                             21 	.globl _ui_gamemenu_action_buttonText
                             22 	.globl _ui_gamemenu_entriesTextPosition
                             23 	.globl _ui_gamemenu_entriesPosition
                             24 	.globl _ui_gamemenu_init
                             25 	.globl _ui_gamemenu_above_entry
                             26 	.globl _ui_gamemenu_below_entry
                             27 	.globl _ui_gamemenu_next_entry
                             28 	.globl _ui_gamemenu_previous_entry
                             29 	.globl _ui_gamemenu_unselect_entry
                             30 	.globl _ui_gamemenu_select_entry
                             31 	.globl _ui_gamemenu_render_refresh
                             32 	.globl _ui_gamemenu_render_all
                             33 	.globl _ui_gamemenu_get_entry
                             34 	.globl _ui_gamemenu_is_selected
                             35 	.globl _ui_gamemenu_update_action
                             36 	.globl _ui_gamemenu_get_movement
                             37 	.globl _ui_gamemenu_get_action
                             38 ;--------------------------------------------------------
                             39 ; special function registers
                             40 ;--------------------------------------------------------
                             41 ;--------------------------------------------------------
                             42 ; ram data
                             43 ;--------------------------------------------------------
                             44 	.area _DATA
                             45 ;--------------------------------------------------------
                             46 ; ram data
                             47 ;--------------------------------------------------------
                             48 	.area _INITIALIZED
   4FA5                      49 _ui_gamemenu_lastEntry::
   4FA5                      50 	.ds 1
   4FA6                      51 _ui_gamemenu_entryIndex::
   4FA6                      52 	.ds 1
   4FA7                      53 _ui_gamemenu_entrySelected::
   4FA7                      54 	.ds 1
   4FA8                      55 _ui_gamemenu_can_move::
   4FA8                      56 	.ds 1
   4FA9                      57 _ui_gamemenu_action::
   4FA9                      58 	.ds 1
                             59 ;--------------------------------------------------------
                             60 ; absolute external ram data
                             61 ;--------------------------------------------------------
                             62 	.area _DABS (ABS)
                             63 ;--------------------------------------------------------
                             64 ; global & static initialisations
                             65 ;--------------------------------------------------------
                             66 	.area _HOME
                             67 	.area _GSINIT
                             68 	.area _GSFINAL
                             69 	.area _GSINIT
                             70 ;--------------------------------------------------------
                             71 ; Home
                             72 ;--------------------------------------------------------
                             73 	.area _HOME
                             74 	.area _HOME
                             75 ;--------------------------------------------------------
                             76 ; code
                             77 ;--------------------------------------------------------
                             78 	.area _CODE
                             79 ;src/UI_GameMenu.c:74: void ui_gamemenu_init(){
                             80 ;	---------------------------------
                             81 ; Function ui_gamemenu_init
                             82 ; ---------------------------------
   24AE                      83 _ui_gamemenu_init::
                             84 ;src/UI_GameMenu.c:75: ui_gamemenu_lastEntry=0;
   24AE 21 A5 4F      [10]   85 	ld	hl,#_ui_gamemenu_lastEntry + 0
   24B1 36 00         [10]   86 	ld	(hl), #0x00
                             87 ;src/UI_GameMenu.c:76: ui_gamemenu_entryIndex=0;
   24B3 21 A6 4F      [10]   88 	ld	hl,#_ui_gamemenu_entryIndex + 0
   24B6 36 00         [10]   89 	ld	(hl), #0x00
                             90 ;src/UI_GameMenu.c:77: ui_gamemenu_entrySelected=0;
   24B8 21 A7 4F      [10]   91 	ld	hl,#_ui_gamemenu_entrySelected + 0
   24BB 36 00         [10]   92 	ld	(hl), #0x00
                             93 ;src/UI_GameMenu.c:78: ui_gamemenu_update_action();
   24BD C3 49 26      [10]   94 	jp  _ui_gamemenu_update_action
   24C0                      95 _ui_gamemenu_entriesPosition:
   24C0 50 C5                96 	.dw #0xC550
   24C2 84 C5                97 	.dw #0xC584
   24C4 E0 C6                98 	.dw #0xC6E0
   24C6 E7 C6                99 	.dw #0xC6E7
   24C8 F6 C6               100 	.dw #0xC6F6
   24CA 14 C7               101 	.dw #0xC714
   24CC 23 C7               102 	.dw #0xC723
   24CE                     103 _ui_gamemenu_entriesTextPosition:
   24CE A4 CD               104 	.dw #0xCDA4
   24D0 D9 CD               105 	.dw #0xCDD9
   24D2 32 CF               106 	.dw #0xCF32
   24D4 3A CF               107 	.dw #0xCF3A
   24D6 48 CF               108 	.dw #0xCF48
   24D8 67 CF               109 	.dw #0xCF67
   24DA 75 CF               110 	.dw #0xCF75
   24DC                     111 _ui_gamemenu_action_buttonText:
   24DC F7 24               112 	.dw __str_0
   24DE 02 25               113 	.dw __str_1
   24E0 0B 25               114 	.dw __str_2
   24E2                     115 _ui_gamemenu_buttonText:
   24E2 16 25               116 	.dw __str_3
   24E4 17 25               117 	.dw __str_4
   24E6 21 25               118 	.dw __str_5
   24E8 16 25               119 	.dw __str_3
   24EA 23 25               120 	.dw __str_6
   24EC 25 25               121 	.dw __str_7
   24EE 2A 25               122 	.dw __str_8
   24F0                     123 _ui_gamemenu_buttonWidths:
   24F0 1C                  124 	.db #0x1C	; 28
   24F1 1C                  125 	.db #0x1C	; 28
   24F2 06                  126 	.db #0x06	; 6
   24F3 0E                  127 	.db #0x0E	; 14
   24F4 06                  128 	.db #0x06	; 6
   24F5 0D                  129 	.db #0x0D	; 13
   24F6 0D                  130 	.db #0x0D	; 13
   24F7                     131 __str_0:
   24F7 4E 45 58 54 20 4C   132 	.ascii "NEXT LEVEL"
        45 56 45 4C
   2501 00                  133 	.db 0x00
   2502                     134 __str_1:
   2502 20 20 41 54 54 41   135 	.ascii "  ATTACK"
        43 4B
   250A 00                  136 	.db 0x00
   250B                     137 __str_2:
   250B 20 20 20 50 49 43   138 	.ascii "   PICK UP"
        4B 20 55 50
   2515 00                  139 	.db 0x00
   2516                     140 __str_3:
   2516 00                  141 	.db 0x00
   2517                     142 __str_4:
   2517 49 4E 56 45 4E 54   143 	.ascii "INVENTORY"
        4F 52 59
   2520 00                  144 	.db 0x00
   2521                     145 __str_5:
   2521 3C                  146 	.ascii "<"
   2522 00                  147 	.db 0x00
   2523                     148 __str_6:
   2523 3E                  149 	.ascii ">"
   2524 00                  150 	.db 0x00
   2525                     151 __str_7:
   2525 57 41 49 54         152 	.ascii "WAIT"
   2529 00                  153 	.db 0x00
   252A                     154 __str_8:
   252A 50 41 55 53 45      155 	.ascii "PAUSE"
   252F 00                  156 	.db 0x00
                            157 ;src/UI_GameMenu.c:81: void ui_gamemenu_above_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_gamemenu_above_entry
                            160 ; ---------------------------------
   2530                     161 _ui_gamemenu_above_entry::
                            162 ;src/UI_GameMenu.c:82: if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
   2530 3A A6 4F      [13]  163 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2533 FE 02         [ 7]  164 	cp	a,#0x02
   2535 38 0A         [12]  165 	jr	C,00105$
   2537 D6 05         [ 7]  166 	sub	a, #0x05
   2539 30 06         [12]  167 	jr	NC,00105$
                            168 ;src/UI_GameMenu.c:83: ui_gamemenu_entryIndex=0;
   253B 21 A6 4F      [10]  169 	ld	hl,#_ui_gamemenu_entryIndex + 0
   253E 36 00         [10]  170 	ld	(hl), #0x00
   2540 C9            [10]  171 	ret
   2541                     172 00105$:
                            173 ;src/UI_GameMenu.c:85: else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
   2541 3A A6 4F      [13]  174 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2544 FE 05         [ 7]  175 	cp	a,#0x05
   2546 28 03         [12]  176 	jr	Z,00101$
   2548 D6 06         [ 7]  177 	sub	a, #0x06
   254A C0            [11]  178 	ret	NZ
   254B                     179 00101$:
                            180 ;src/UI_GameMenu.c:86: ui_gamemenu_entryIndex=1;
   254B 21 A6 4F      [10]  181 	ld	hl,#_ui_gamemenu_entryIndex + 0
   254E 36 01         [10]  182 	ld	(hl), #0x01
   2550 C9            [10]  183 	ret
                            184 ;src/UI_GameMenu.c:90: void ui_gamemenu_below_entry(){
                            185 ;	---------------------------------
                            186 ; Function ui_gamemenu_below_entry
                            187 ; ---------------------------------
   2551                     188 _ui_gamemenu_below_entry::
                            189 ;src/UI_GameMenu.c:91: if(ui_gamemenu_entryIndex==0){
   2551 3A A6 4F      [13]  190 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2554 B7            [ 4]  191 	or	a, a
   2555 20 06         [12]  192 	jr	NZ,00104$
                            193 ;src/UI_GameMenu.c:92: ui_gamemenu_entryIndex=3;
   2557 21 A6 4F      [10]  194 	ld	hl,#_ui_gamemenu_entryIndex + 0
   255A 36 03         [10]  195 	ld	(hl), #0x03
   255C C9            [10]  196 	ret
   255D                     197 00104$:
                            198 ;src/UI_GameMenu.c:94: else if(ui_gamemenu_entryIndex==1){
   255D 3A A6 4F      [13]  199 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2560 3D            [ 4]  200 	dec	a
   2561 C0            [11]  201 	ret	NZ
                            202 ;src/UI_GameMenu.c:95: ui_gamemenu_entryIndex=5;
   2562 21 A6 4F      [10]  203 	ld	hl,#_ui_gamemenu_entryIndex + 0
   2565 36 05         [10]  204 	ld	(hl), #0x05
   2567 C9            [10]  205 	ret
                            206 ;src/UI_GameMenu.c:99: void ui_gamemenu_next_entry(){
                            207 ;	---------------------------------
                            208 ; Function ui_gamemenu_next_entry
                            209 ; ---------------------------------
   2568                     210 _ui_gamemenu_next_entry::
                            211 ;src/UI_GameMenu.c:100: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
   2568 3A A6 4F      [13]  212 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   256B FE 06         [ 7]  213 	cp	a,#0x06
   256D D0            [11]  214 	ret	NC
   256E 3D            [ 4]  215 	dec	a
   256F C8            [11]  216 	ret	Z
                            217 ;src/UI_GameMenu.c:101: ++ui_gamemenu_entryIndex;
   2570 21 A6 4F      [10]  218 	ld	hl, #_ui_gamemenu_entryIndex+0
   2573 34            [11]  219 	inc	(hl)
   2574 C9            [10]  220 	ret
                            221 ;src/UI_GameMenu.c:105: void ui_gamemenu_previous_entry(){
                            222 ;	---------------------------------
                            223 ; Function ui_gamemenu_previous_entry
                            224 ; ---------------------------------
   2575                     225 _ui_gamemenu_previous_entry::
                            226 ;src/UI_GameMenu.c:106: if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
   2575 3A A6 4F      [13]  227 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2578 B7            [ 4]  228 	or	a, a
   2579 C8            [11]  229 	ret	Z
   257A 3A A6 4F      [13]  230 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   257D D6 02         [ 7]  231 	sub	a, #0x02
   257F C8            [11]  232 	ret	Z
                            233 ;src/UI_GameMenu.c:107: --ui_gamemenu_entryIndex;
   2580 21 A6 4F      [10]  234 	ld	hl, #_ui_gamemenu_entryIndex+0
   2583 35            [11]  235 	dec	(hl)
   2584 C9            [10]  236 	ret
                            237 ;src/UI_GameMenu.c:111: void ui_gamemenu_unselect_entry(){
                            238 ;	---------------------------------
                            239 ; Function ui_gamemenu_unselect_entry
                            240 ; ---------------------------------
   2585                     241 _ui_gamemenu_unselect_entry::
                            242 ;src/UI_GameMenu.c:112: ui_gamemenu_entrySelected=0;
   2585 21 A7 4F      [10]  243 	ld	hl,#_ui_gamemenu_entrySelected + 0
   2588 36 00         [10]  244 	ld	(hl), #0x00
   258A C9            [10]  245 	ret
                            246 ;src/UI_GameMenu.c:115: void ui_gamemenu_select_entry(){
                            247 ;	---------------------------------
                            248 ; Function ui_gamemenu_select_entry
                            249 ; ---------------------------------
   258B                     250 _ui_gamemenu_select_entry::
                            251 ;src/UI_GameMenu.c:116: ui_gamemenu_entrySelected=1;
   258B 21 A7 4F      [10]  252 	ld	hl,#_ui_gamemenu_entrySelected + 0
   258E 36 01         [10]  253 	ld	(hl), #0x01
   2590 C9            [10]  254 	ret
                            255 ;src/UI_GameMenu.c:119: void ui_gamemenu_render_button(u8 n){
                            256 ;	---------------------------------
                            257 ; Function ui_gamemenu_render_button
                            258 ; ---------------------------------
   2591                     259 _ui_gamemenu_render_button::
   2591 DD E5         [15]  260 	push	ix
   2593 DD 21 00 00   [14]  261 	ld	ix,#0
   2597 DD 39         [15]  262 	add	ix,sp
   2599 F5            [11]  263 	push	af
                            264 ;src/UI_GameMenu.c:121: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   259A DD 7E 04      [19]  265 	ld	a,4 (ix)
   259D FD 21 A6 4F   [14]  266 	ld	iy,#_ui_gamemenu_entryIndex
   25A1 FD 96 00      [19]  267 	sub	a, 0 (iy)
   25A4 20 10         [12]  268 	jr	NZ,00103$
   25A6 3A A7 4F      [13]  269 	ld	a,(#_ui_gamemenu_entrySelected + 0)
   25A9 B7            [ 4]  270 	or	a, a
   25AA 28 05         [12]  271 	jr	Z,00105$
   25AC 3A A7 0A      [13]  272 	ld	a, (#(_g_colors + 0x0004) + 0)
   25AF 18 08         [12]  273 	jr	00104$
   25B1                     274 00105$:
   25B1 3A A9 0A      [13]  275 	ld	a, (#(_g_colors + 0x0006) + 0)
   25B4 18 03         [12]  276 	jr	00104$
   25B6                     277 00103$:
   25B6 3A A5 0A      [13]  278 	ld	a, (#(_g_colors + 0x0002) + 0)
   25B9                     279 00104$:
   25B9 4F            [ 4]  280 	ld	c,a
                            281 ;src/UI_GameMenu.c:122: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
   25BA 11 F0 24      [10]  282 	ld	de,#_ui_gamemenu_buttonWidths+0
   25BD DD 6E 04      [19]  283 	ld	l,4 (ix)
   25C0 26 00         [ 7]  284 	ld	h,#0x00
   25C2 19            [11]  285 	add	hl,de
   25C3 46            [ 7]  286 	ld	b,(hl)
   25C4 DD 6E 04      [19]  287 	ld	l,4 (ix)
   25C7 26 00         [ 7]  288 	ld	h,#0x00
   25C9 29            [11]  289 	add	hl, hl
   25CA EB            [ 4]  290 	ex	de,hl
   25CB 21 C0 24      [10]  291 	ld	hl,#_ui_gamemenu_entriesPosition
   25CE 19            [11]  292 	add	hl,de
   25CF 7E            [ 7]  293 	ld	a,(hl)
   25D0 DD 77 FE      [19]  294 	ld	-2 (ix),a
   25D3 23            [ 6]  295 	inc	hl
   25D4 7E            [ 7]  296 	ld	a,(hl)
   25D5 DD 77 FF      [19]  297 	ld	-1 (ix),a
   25D8 D5            [11]  298 	push	de
   25D9 3E 18         [ 7]  299 	ld	a,#0x18
   25DB F5            [11]  300 	push	af
   25DC 33            [ 6]  301 	inc	sp
   25DD C5            [11]  302 	push	bc
   25DE DD 6E FE      [19]  303 	ld	l,-2 (ix)
   25E1 DD 66 FF      [19]  304 	ld	h,-1 (ix)
   25E4 E5            [11]  305 	push	hl
   25E5 CD C0 4D      [17]  306 	call	_cpct_drawSolidBox
   25E8 F1            [10]  307 	pop	af
   25E9 F1            [10]  308 	pop	af
   25EA 33            [ 6]  309 	inc	sp
   25EB D1            [10]  310 	pop	de
                            311 ;src/UI_GameMenu.c:123: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
   25EC 21 CE 24      [10]  312 	ld	hl,#_ui_gamemenu_entriesTextPosition
   25EF 19            [11]  313 	add	hl,de
   25F0 4E            [ 7]  314 	ld	c,(hl)
   25F1 23            [ 6]  315 	inc	hl
   25F2 46            [ 7]  316 	ld	b,(hl)
   25F3 21 E2 24      [10]  317 	ld	hl,#_ui_gamemenu_buttonText
   25F6 19            [11]  318 	add	hl,de
   25F7 5E            [ 7]  319 	ld	e,(hl)
   25F8 23            [ 6]  320 	inc	hl
   25F9 56            [ 7]  321 	ld	d,(hl)
   25FA 3E 03         [ 7]  322 	ld	a,#0x03
   25FC F5            [11]  323 	push	af
   25FD 33            [ 6]  324 	inc	sp
   25FE C5            [11]  325 	push	bc
   25FF D5            [11]  326 	push	de
   2600 CD 70 22      [17]  327 	call	_print_transparent_text
   2603 DD F9         [10]  328 	ld	sp,ix
   2605 DD E1         [14]  329 	pop	ix
   2607 C9            [10]  330 	ret
                            331 ;src/UI_GameMenu.c:135: void ui_gamemenu_render_refresh(){
                            332 ;	---------------------------------
                            333 ; Function ui_gamemenu_render_refresh
                            334 ; ---------------------------------
   2608                     335 _ui_gamemenu_render_refresh::
                            336 ;src/UI_GameMenu.c:137: ui_gamemenu_render_button(ui_gamemenu_entryIndex);
   2608 3A A6 4F      [13]  337 	ld	a,(_ui_gamemenu_entryIndex)
   260B F5            [11]  338 	push	af
   260C 33            [ 6]  339 	inc	sp
   260D CD 91 25      [17]  340 	call	_ui_gamemenu_render_button
   2610 33            [ 6]  341 	inc	sp
                            342 ;src/UI_GameMenu.c:138: ui_gamemenu_render_button(ui_gamemenu_lastEntry);
   2611 3A A5 4F      [13]  343 	ld	a,(_ui_gamemenu_lastEntry)
   2614 F5            [11]  344 	push	af
   2615 33            [ 6]  345 	inc	sp
   2616 CD 91 25      [17]  346 	call	_ui_gamemenu_render_button
   2619 33            [ 6]  347 	inc	sp
                            348 ;src/UI_GameMenu.c:141: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   261A 3A A6 4F      [13]  349 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   261D 32 A5 4F      [13]  350 	ld	(#_ui_gamemenu_lastEntry + 0),a
   2620 C9            [10]  351 	ret
                            352 ;src/UI_GameMenu.c:145: void ui_gamemenu_render_all(){
                            353 ;	---------------------------------
                            354 ; Function ui_gamemenu_render_all
                            355 ; ---------------------------------
   2621                     356 _ui_gamemenu_render_all::
                            357 ;src/UI_GameMenu.c:149: while(n){
   2621 06 07         [ 7]  358 	ld	b,#0x07
   2623                     359 00101$:
   2623 78            [ 4]  360 	ld	a,b
   2624 B7            [ 4]  361 	or	a, a
   2625 28 0B         [12]  362 	jr	Z,00103$
                            363 ;src/UI_GameMenu.c:150: --n;
   2627 05            [ 4]  364 	dec	b
                            365 ;src/UI_GameMenu.c:151: ui_gamemenu_render_button(n);
   2628 C5            [11]  366 	push	bc
   2629 C5            [11]  367 	push	bc
   262A 33            [ 6]  368 	inc	sp
   262B CD 91 25      [17]  369 	call	_ui_gamemenu_render_button
   262E 33            [ 6]  370 	inc	sp
   262F C1            [10]  371 	pop	bc
   2630 18 F1         [12]  372 	jr	00101$
   2632                     373 00103$:
                            374 ;src/UI_GameMenu.c:154: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   2632 3A A6 4F      [13]  375 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2635 32 A5 4F      [13]  376 	ld	(#_ui_gamemenu_lastEntry + 0),a
   2638 C9            [10]  377 	ret
                            378 ;src/UI_GameMenu.c:157: u8 ui_gamemenu_get_entry(){
                            379 ;	---------------------------------
                            380 ; Function ui_gamemenu_get_entry
                            381 ; ---------------------------------
   2639                     382 _ui_gamemenu_get_entry::
                            383 ;src/UI_GameMenu.c:158: return ui_gamemenu_entryIndex;
   2639 FD 21 A6 4F   [14]  384 	ld	iy,#_ui_gamemenu_entryIndex
   263D FD 6E 00      [19]  385 	ld	l,0 (iy)
   2640 C9            [10]  386 	ret
                            387 ;src/UI_GameMenu.c:161: u8 ui_gamemenu_is_selected(){
                            388 ;	---------------------------------
                            389 ; Function ui_gamemenu_is_selected
                            390 ; ---------------------------------
   2641                     391 _ui_gamemenu_is_selected::
                            392 ;src/UI_GameMenu.c:162: return ui_gamemenu_entrySelected;
   2641 FD 21 A7 4F   [14]  393 	ld	iy,#_ui_gamemenu_entrySelected
   2645 FD 6E 00      [19]  394 	ld	l,0 (iy)
   2648 C9            [10]  395 	ret
                            396 ;src/UI_GameMenu.c:165: void ui_gamemenu_update_action(){
                            397 ;	---------------------------------
                            398 ; Function ui_gamemenu_update_action
                            399 ; ---------------------------------
   2649                     400 _ui_gamemenu_update_action::
                            401 ;src/UI_GameMenu.c:166: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
   2649 21 89 08      [10]  402 	ld	hl,#_player_position+0
   264C 4E            [ 7]  403 	ld	c,(hl)
   264D 06 00         [ 7]  404 	ld	b,#0x00
   264F 3A 8B 08      [13]  405 	ld	a, (#_player_direction + 0)
   2652 6F            [ 4]  406 	ld	l,a
   2653 17            [ 4]  407 	rla
   2654 9F            [ 4]  408 	sbc	a, a
   2655 67            [ 4]  409 	ld	h,a
   2656 09            [11]  410 	add	hl,bc
   2657 01 00 70      [10]  411 	ld	bc,#0x7000
   265A 09            [11]  412 	add	hl,bc
   265B 4D            [ 4]  413 	ld	c,l
   265C 44            [ 4]  414 	ld	b,h
   265D 21 8A 08      [10]  415 	ld	hl,#_player_position+1
   2660 5E            [ 7]  416 	ld	e,(hl)
   2661 16 00         [ 7]  417 	ld	d,#0x00
   2663 3A 8C 08      [13]  418 	ld	a, (#(_player_direction + 0x0001) + 0)
   2666 6F            [ 4]  419 	ld	l,a
   2667 17            [ 4]  420 	rla
   2668 9F            [ 4]  421 	sbc	a, a
   2669 67            [ 4]  422 	ld	h,a
   266A 19            [11]  423 	add	hl,de
   266B 29            [11]  424 	add	hl, hl
   266C 29            [11]  425 	add	hl, hl
   266D 29            [11]  426 	add	hl, hl
   266E 29            [11]  427 	add	hl, hl
   266F 29            [11]  428 	add	hl, hl
   2670 09            [11]  429 	add	hl,bc
   2671 4E            [ 7]  430 	ld	c,(hl)
                            431 ;src/UI_GameMenu.c:169: ui_gamemenu_can_move=0;
   2672 21 A8 4F      [10]  432 	ld	hl,#_ui_gamemenu_can_move + 0
   2675 36 00         [10]  433 	ld	(hl), #0x00
                            434 ;src/UI_GameMenu.c:170: *((char**)(ui_gamemenu_buttonText)+3)="";
   2677 21 E3 26      [10]  435 	ld	hl,#___str_9
   267A 22 E8 24      [16]  436 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
                            437 ;src/UI_GameMenu.c:172: ui_gamemenu_action=0;
   267D FD 21 A9 4F   [14]  438 	ld	iy,#_ui_gamemenu_action
   2681 FD 36 00 00   [19]  439 	ld	0 (iy),#0x00
                            440 ;src/UI_GameMenu.c:173: *((char**)ui_gamemenu_buttonText)="";
   2685 22 E2 24      [16]  441 	ld	(_ui_gamemenu_buttonText), hl
                            442 ;src/UI_GameMenu.c:175: if(forward&CELL_WALL_MASK){
   2688 CB 79         [ 8]  443 	bit	7, c
   268A 28 14         [12]  444 	jr	Z,00110$
                            445 ;src/UI_GameMenu.c:176: if(forward==CELLTYPE_DOOR){
   268C 79            [ 4]  446 	ld	a,c
   268D D6 80         [ 7]  447 	sub	a, #0x80
   268F 20 42         [12]  448 	jr	NZ,00111$
                            449 ;src/UI_GameMenu.c:177: ui_gamemenu_action=1;
   2691 21 A9 4F      [10]  450 	ld	hl,#_ui_gamemenu_action + 0
   2694 36 01         [10]  451 	ld	(hl), #0x01
                            452 ;src/UI_GameMenu.c:178: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[0];
   2696 ED 4B DC 24   [20]  453 	ld	bc, (#_ui_gamemenu_action_buttonText + 0)
   269A ED 43 E2 24   [20]  454 	ld	(_ui_gamemenu_buttonText), bc
   269E 18 33         [12]  455 	jr	00111$
   26A0                     456 00110$:
                            457 ;src/UI_GameMenu.c:181: else if(forward&CELL_ENEMY_MASK){
   26A0 79            [ 4]  458 	ld	a,c
   26A1 E6 0F         [ 7]  459 	and	a, #0x0F
   26A3 28 0F         [12]  460 	jr	Z,00107$
                            461 ;src/UI_GameMenu.c:182: ui_gamemenu_action=2;
   26A5 21 A9 4F      [10]  462 	ld	hl,#_ui_gamemenu_action + 0
   26A8 36 02         [10]  463 	ld	(hl), #0x02
                            464 ;src/UI_GameMenu.c:183: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[1];
   26AA ED 4B DE 24   [20]  465 	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0002) + 0)
   26AE ED 43 E2 24   [20]  466 	ld	(_ui_gamemenu_buttonText), bc
   26B2 18 1F         [12]  467 	jr	00111$
   26B4                     468 00107$:
                            469 ;src/UI_GameMenu.c:185: else if(forward&CELL_ITEM_MASK){
   26B4 79            [ 4]  470 	ld	a,c
   26B5 E6 70         [ 7]  471 	and	a, #0x70
   26B7 28 0F         [12]  472 	jr	Z,00104$
                            473 ;src/UI_GameMenu.c:186: ui_gamemenu_action=3;
   26B9 21 A9 4F      [10]  474 	ld	hl,#_ui_gamemenu_action + 0
   26BC 36 03         [10]  475 	ld	(hl), #0x03
                            476 ;src/UI_GameMenu.c:187: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[2];
   26BE ED 4B E0 24   [20]  477 	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0004) + 0)
   26C2 ED 43 E2 24   [20]  478 	ld	(_ui_gamemenu_buttonText), bc
   26C6 18 0B         [12]  479 	jr	00111$
   26C8                     480 00104$:
                            481 ;src/UI_GameMenu.c:190: ui_gamemenu_can_move=1;
   26C8 21 A8 4F      [10]  482 	ld	hl,#_ui_gamemenu_can_move + 0
   26CB 36 01         [10]  483 	ld	(hl), #0x01
                            484 ;src/UI_GameMenu.c:191: *(char**)(ui_gamemenu_buttonText+3)="MOVE";
   26CD 21 E4 26      [10]  485 	ld	hl,#___str_10
   26D0 22 E8 24      [16]  486 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
   26D3                     487 00111$:
                            488 ;src/UI_GameMenu.c:193: ui_gamemenu_render_button(0);
   26D3 AF            [ 4]  489 	xor	a, a
   26D4 F5            [11]  490 	push	af
   26D5 33            [ 6]  491 	inc	sp
   26D6 CD 91 25      [17]  492 	call	_ui_gamemenu_render_button
   26D9 33            [ 6]  493 	inc	sp
                            494 ;src/UI_GameMenu.c:194: ui_gamemenu_render_button(3);
   26DA 3E 03         [ 7]  495 	ld	a,#0x03
   26DC F5            [11]  496 	push	af
   26DD 33            [ 6]  497 	inc	sp
   26DE CD 91 25      [17]  498 	call	_ui_gamemenu_render_button
   26E1 33            [ 6]  499 	inc	sp
   26E2 C9            [10]  500 	ret
   26E3                     501 ___str_9:
   26E3 00                  502 	.db 0x00
   26E4                     503 ___str_10:
   26E4 4D 4F 56 45         504 	.ascii "MOVE"
   26E8 00                  505 	.db 0x00
                            506 ;src/UI_GameMenu.c:197: u8 ui_gamemenu_get_movement(){
                            507 ;	---------------------------------
                            508 ; Function ui_gamemenu_get_movement
                            509 ; ---------------------------------
   26E9                     510 _ui_gamemenu_get_movement::
                            511 ;src/UI_GameMenu.c:198: return ui_gamemenu_can_move;
   26E9 FD 21 A8 4F   [14]  512 	ld	iy,#_ui_gamemenu_can_move
   26ED FD 6E 00      [19]  513 	ld	l,0 (iy)
   26F0 C9            [10]  514 	ret
                            515 ;src/UI_GameMenu.c:201: u8 ui_gamemenu_get_action(){
                            516 ;	---------------------------------
                            517 ; Function ui_gamemenu_get_action
                            518 ; ---------------------------------
   26F1                     519 _ui_gamemenu_get_action::
                            520 ;src/UI_GameMenu.c:202: return ui_gamemenu_action;
   26F1 FD 21 A9 4F   [14]  521 	ld	iy,#_ui_gamemenu_action
   26F5 FD 6E 00      [19]  522 	ld	l,0 (iy)
   26F8 C9            [10]  523 	ret
                            524 	.area _CODE
                            525 	.area _INITIALIZER
   4FB1                     526 __xinit__ui_gamemenu_lastEntry:
   4FB1 00                  527 	.db #0x00	; 0
   4FB2                     528 __xinit__ui_gamemenu_entryIndex:
   4FB2 00                  529 	.db #0x00	; 0
   4FB3                     530 __xinit__ui_gamemenu_entrySelected:
   4FB3 00                  531 	.db #0x00	; 0
   4FB4                     532 __xinit__ui_gamemenu_can_move:
   4FB4 00                  533 	.db #0x00	; 0
   4FB5                     534 __xinit__ui_gamemenu_action:
   4FB5 00                  535 	.db #0x00	; 0
                            536 	.area _CABS (ABS)
