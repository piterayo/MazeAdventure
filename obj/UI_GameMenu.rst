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
   4AAB                      49 _ui_gamemenu_lastEntry::
   4AAB                      50 	.ds 1
   4AAC                      51 _ui_gamemenu_entryIndex::
   4AAC                      52 	.ds 1
   4AAD                      53 _ui_gamemenu_entrySelected::
   4AAD                      54 	.ds 1
   4AAE                      55 _ui_gamemenu_can_move::
   4AAE                      56 	.ds 1
   4AAF                      57 _ui_gamemenu_action::
   4AAF                      58 	.ds 1
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
                             79 ;src/UI_GameMenu.c:72: void ui_gamemenu_init(){
                             80 ;	---------------------------------
                             81 ; Function ui_gamemenu_init
                             82 ; ---------------------------------
   25CF                      83 _ui_gamemenu_init::
                             84 ;src/UI_GameMenu.c:73: ui_gamemenu_lastEntry=0;
   25CF 21 AB 4A      [10]   85 	ld	hl,#_ui_gamemenu_lastEntry + 0
   25D2 36 00         [10]   86 	ld	(hl), #0x00
                             87 ;src/UI_GameMenu.c:74: ui_gamemenu_entryIndex=0;
   25D4 21 AC 4A      [10]   88 	ld	hl,#_ui_gamemenu_entryIndex + 0
   25D7 36 00         [10]   89 	ld	(hl), #0x00
                             90 ;src/UI_GameMenu.c:75: ui_gamemenu_entrySelected=0;
   25D9 21 AD 4A      [10]   91 	ld	hl,#_ui_gamemenu_entrySelected + 0
   25DC 36 00         [10]   92 	ld	(hl), #0x00
                             93 ;src/UI_GameMenu.c:76: ui_gamemenu_update_action();
   25DE C3 C0 27      [10]   94 	jp  _ui_gamemenu_update_action
   25E1                      95 _ui_gamemenu_entriesPosition:
   25E1 50 C5                96 	.dw #0xC550
   25E3 84 C5                97 	.dw #0xC584
   25E5 E0 C6                98 	.dw #0xC6E0
   25E7 E7 C6                99 	.dw #0xC6E7
   25E9 F6 C6               100 	.dw #0xC6F6
   25EB 14 C7               101 	.dw #0xC714
   25ED 23 C7               102 	.dw #0xC723
   25EF                     103 _ui_gamemenu_entriesTextPosition:
   25EF A4 CD               104 	.dw #0xCDA4
   25F1 D9 CD               105 	.dw #0xCDD9
   25F3 32 CF               106 	.dw #0xCF32
   25F5 3A CF               107 	.dw #0xCF3A
   25F7 48 CF               108 	.dw #0xCF48
   25F9 67 CF               109 	.dw #0xCF67
   25FB 75 CF               110 	.dw #0xCF75
   25FD                     111 _ui_gamemenu_action_buttonText:
   25FD 1A 26               112 	.dw __str_0
   25FF 25 26               113 	.dw __str_1
   2601 2E 26               114 	.dw __str_2
   2603 00                  115 	.db 0x00
   2604 00                  116 	.db 0x00
   2605                     117 _ui_gamemenu_buttonText:
   2605 39 26               118 	.dw __str_3
   2607 3A 26               119 	.dw __str_4
   2609 44 26               120 	.dw __str_5
   260B 39 26               121 	.dw __str_3
   260D 46 26               122 	.dw __str_6
   260F 48 26               123 	.dw __str_7
   2611 4D 26               124 	.dw __str_8
   2613                     125 _ui_gamemenu_buttonWidths:
   2613 1C                  126 	.db #0x1C	; 28
   2614 1C                  127 	.db #0x1C	; 28
   2615 06                  128 	.db #0x06	; 6
   2616 0E                  129 	.db #0x0E	; 14
   2617 06                  130 	.db #0x06	; 6
   2618 0D                  131 	.db #0x0D	; 13
   2619 0D                  132 	.db #0x0D	; 13
   261A                     133 __str_0:
   261A 4E 45 58 54 20 4C   134 	.ascii "NEXT LEVEL"
        45 56 45 4C
   2624 00                  135 	.db 0x00
   2625                     136 __str_1:
   2625 20 20 41 54 54 41   137 	.ascii "  ATTACK"
        43 4B
   262D 00                  138 	.db 0x00
   262E                     139 __str_2:
   262E 20 20 20 50 49 43   140 	.ascii "   PICK UP"
        4B 20 55 50
   2638 00                  141 	.db 0x00
   2639                     142 __str_3:
   2639 00                  143 	.db 0x00
   263A                     144 __str_4:
   263A 49 4E 56 45 4E 54   145 	.ascii "INVENTORY"
        4F 52 59
   2643 00                  146 	.db 0x00
   2644                     147 __str_5:
   2644 3C                  148 	.ascii "<"
   2645 00                  149 	.db 0x00
   2646                     150 __str_6:
   2646 3E                  151 	.ascii ">"
   2647 00                  152 	.db 0x00
   2648                     153 __str_7:
   2648 57 41 49 54         154 	.ascii "WAIT"
   264C 00                  155 	.db 0x00
   264D                     156 __str_8:
   264D 50 41 55 53 45      157 	.ascii "PAUSE"
   2652 00                  158 	.db 0x00
                            159 ;src/UI_GameMenu.c:79: void ui_gamemenu_above_entry(){
                            160 ;	---------------------------------
                            161 ; Function ui_gamemenu_above_entry
                            162 ; ---------------------------------
   2653                     163 _ui_gamemenu_above_entry::
                            164 ;src/UI_GameMenu.c:80: if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
   2653 3A AC 4A      [13]  165 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2656 FE 02         [ 7]  166 	cp	a,#0x02
   2658 38 0A         [12]  167 	jr	C,00105$
   265A D6 05         [ 7]  168 	sub	a, #0x05
   265C 30 06         [12]  169 	jr	NC,00105$
                            170 ;src/UI_GameMenu.c:81: ui_gamemenu_entryIndex=0;
   265E 21 AC 4A      [10]  171 	ld	hl,#_ui_gamemenu_entryIndex + 0
   2661 36 00         [10]  172 	ld	(hl), #0x00
   2663 C9            [10]  173 	ret
   2664                     174 00105$:
                            175 ;src/UI_GameMenu.c:83: else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
   2664 3A AC 4A      [13]  176 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2667 FE 05         [ 7]  177 	cp	a,#0x05
   2669 28 03         [12]  178 	jr	Z,00101$
   266B D6 06         [ 7]  179 	sub	a, #0x06
   266D C0            [11]  180 	ret	NZ
   266E                     181 00101$:
                            182 ;src/UI_GameMenu.c:84: ui_gamemenu_entryIndex=1;
   266E 21 AC 4A      [10]  183 	ld	hl,#_ui_gamemenu_entryIndex + 0
   2671 36 01         [10]  184 	ld	(hl), #0x01
   2673 C9            [10]  185 	ret
                            186 ;src/UI_GameMenu.c:88: void ui_gamemenu_below_entry(){
                            187 ;	---------------------------------
                            188 ; Function ui_gamemenu_below_entry
                            189 ; ---------------------------------
   2674                     190 _ui_gamemenu_below_entry::
                            191 ;src/UI_GameMenu.c:89: if(ui_gamemenu_entryIndex==0){
   2674 3A AC 4A      [13]  192 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2677 B7            [ 4]  193 	or	a, a
   2678 20 06         [12]  194 	jr	NZ,00104$
                            195 ;src/UI_GameMenu.c:90: ui_gamemenu_entryIndex=3;
   267A 21 AC 4A      [10]  196 	ld	hl,#_ui_gamemenu_entryIndex + 0
   267D 36 03         [10]  197 	ld	(hl), #0x03
   267F C9            [10]  198 	ret
   2680                     199 00104$:
                            200 ;src/UI_GameMenu.c:92: else if(ui_gamemenu_entryIndex==1){
   2680 3A AC 4A      [13]  201 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2683 3D            [ 4]  202 	dec	a
   2684 C0            [11]  203 	ret	NZ
                            204 ;src/UI_GameMenu.c:93: ui_gamemenu_entryIndex=5;
   2685 21 AC 4A      [10]  205 	ld	hl,#_ui_gamemenu_entryIndex + 0
   2688 36 05         [10]  206 	ld	(hl), #0x05
   268A C9            [10]  207 	ret
                            208 ;src/UI_GameMenu.c:97: void ui_gamemenu_next_entry(){
                            209 ;	---------------------------------
                            210 ; Function ui_gamemenu_next_entry
                            211 ; ---------------------------------
   268B                     212 _ui_gamemenu_next_entry::
                            213 ;src/UI_GameMenu.c:98: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
   268B 3A AC 4A      [13]  214 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   268E FE 06         [ 7]  215 	cp	a,#0x06
   2690 D0            [11]  216 	ret	NC
   2691 3D            [ 4]  217 	dec	a
   2692 C8            [11]  218 	ret	Z
                            219 ;src/UI_GameMenu.c:99: ++ui_gamemenu_entryIndex;
   2693 21 AC 4A      [10]  220 	ld	hl, #_ui_gamemenu_entryIndex+0
   2696 34            [11]  221 	inc	(hl)
   2697 C9            [10]  222 	ret
                            223 ;src/UI_GameMenu.c:103: void ui_gamemenu_previous_entry(){
                            224 ;	---------------------------------
                            225 ; Function ui_gamemenu_previous_entry
                            226 ; ---------------------------------
   2698                     227 _ui_gamemenu_previous_entry::
                            228 ;src/UI_GameMenu.c:104: if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
   2698 3A AC 4A      [13]  229 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   269B B7            [ 4]  230 	or	a, a
   269C C8            [11]  231 	ret	Z
   269D 3A AC 4A      [13]  232 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   26A0 D6 02         [ 7]  233 	sub	a, #0x02
   26A2 C8            [11]  234 	ret	Z
                            235 ;src/UI_GameMenu.c:105: --ui_gamemenu_entryIndex;
   26A3 21 AC 4A      [10]  236 	ld	hl, #_ui_gamemenu_entryIndex+0
   26A6 35            [11]  237 	dec	(hl)
   26A7 C9            [10]  238 	ret
                            239 ;src/UI_GameMenu.c:109: void ui_gamemenu_unselect_entry(){
                            240 ;	---------------------------------
                            241 ; Function ui_gamemenu_unselect_entry
                            242 ; ---------------------------------
   26A8                     243 _ui_gamemenu_unselect_entry::
                            244 ;src/UI_GameMenu.c:110: ui_gamemenu_entrySelected=0;
   26A8 21 AD 4A      [10]  245 	ld	hl,#_ui_gamemenu_entrySelected + 0
   26AB 36 00         [10]  246 	ld	(hl), #0x00
   26AD C9            [10]  247 	ret
                            248 ;src/UI_GameMenu.c:113: void ui_gamemenu_select_entry(){
                            249 ;	---------------------------------
                            250 ; Function ui_gamemenu_select_entry
                            251 ; ---------------------------------
   26AE                     252 _ui_gamemenu_select_entry::
                            253 ;src/UI_GameMenu.c:114: ui_gamemenu_entrySelected=1;
   26AE 21 AD 4A      [10]  254 	ld	hl,#_ui_gamemenu_entrySelected + 0
   26B1 36 01         [10]  255 	ld	(hl), #0x01
   26B3 C9            [10]  256 	ret
                            257 ;src/UI_GameMenu.c:117: void ui_gamemenu_render_button(u8 n){
                            258 ;	---------------------------------
                            259 ; Function ui_gamemenu_render_button
                            260 ; ---------------------------------
   26B4                     261 _ui_gamemenu_render_button::
   26B4 DD E5         [15]  262 	push	ix
   26B6 DD 21 00 00   [14]  263 	ld	ix,#0
   26BA DD 39         [15]  264 	add	ix,sp
                            265 ;src/UI_GameMenu.c:119: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
   26BC DD 7E 04      [19]  266 	ld	a,4 (ix)
   26BF FD 21 AC 4A   [14]  267 	ld	iy,#_ui_gamemenu_entryIndex
   26C3 FD 96 00      [19]  268 	sub	a, 0 (iy)
   26C6 20 10         [12]  269 	jr	NZ,00111$
   26C8 3A AD 4A      [13]  270 	ld	a,(#_ui_gamemenu_entrySelected + 0)
   26CB B7            [ 4]  271 	or	a, a
   26CC 28 05         [12]  272 	jr	Z,00113$
   26CE 3A A7 0A      [13]  273 	ld	a, (#(_g_colors + 0x0004) + 0)
   26D1 18 08         [12]  274 	jr	00112$
   26D3                     275 00113$:
   26D3 3A A8 0A      [13]  276 	ld	a, (#(_g_colors + 0x0005) + 0)
   26D6 18 03         [12]  277 	jr	00112$
   26D8                     278 00111$:
   26D8 3A A5 0A      [13]  279 	ld	a, (#(_g_colors + 0x0002) + 0)
   26DB                     280 00112$:
   26DB 4F            [ 4]  281 	ld	c,a
                            282 ;src/UI_GameMenu.c:120: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
   26DC 11 13 26      [10]  283 	ld	de,#_ui_gamemenu_buttonWidths+0
   26DF DD 6E 04      [19]  284 	ld	l,4 (ix)
   26E2 26 00         [ 7]  285 	ld	h,#0x00
   26E4 19            [11]  286 	add	hl,de
   26E5 46            [ 7]  287 	ld	b,(hl)
   26E6 DD 6E 04      [19]  288 	ld	l,4 (ix)
   26E9 26 00         [ 7]  289 	ld	h,#0x00
   26EB 29            [11]  290 	add	hl, hl
   26EC EB            [ 4]  291 	ex	de,hl
   26ED 21 E1 25      [10]  292 	ld	hl,#_ui_gamemenu_entriesPosition
   26F0 19            [11]  293 	add	hl,de
   26F1 7E            [ 7]  294 	ld	a, (hl)
   26F2 23            [ 6]  295 	inc	hl
   26F3 66            [ 7]  296 	ld	h,(hl)
   26F4 6F            [ 4]  297 	ld	l,a
   26F5 E5            [11]  298 	push	hl
   26F6 FD E1         [14]  299 	pop	iy
   26F8 D5            [11]  300 	push	de
   26F9 3E 18         [ 7]  301 	ld	a,#0x18
   26FB F5            [11]  302 	push	af
   26FC 33            [ 6]  303 	inc	sp
   26FD C5            [11]  304 	push	bc
   26FE FD E5         [15]  305 	push	iy
   2700 CD CB 48      [17]  306 	call	_cpct_drawSolidBox
   2703 F1            [10]  307 	pop	af
   2704 F1            [10]  308 	pop	af
   2705 33            [ 6]  309 	inc	sp
   2706 D1            [10]  310 	pop	de
                            311 ;src/UI_GameMenu.c:121: if(n==0 && ui_gamemenu_action){
   2707 DD 7E 04      [19]  312 	ld	a,4 (ix)
   270A B7            [ 4]  313 	or	a, a
   270B 20 2B         [12]  314 	jr	NZ,00106$
   270D 3A AF 4A      [13]  315 	ld	a,(#_ui_gamemenu_action + 0)
   2710 B7            [ 4]  316 	or	a, a
   2711 28 25         [12]  317 	jr	Z,00106$
                            318 ;src/UI_GameMenu.c:122: print_transparent_text(ui_gamemenu_action_buttonText[ui_gamemenu_action-1], ui_gamemenu_entriesTextPosition[n], 3);
   2713 21 EF 25      [10]  319 	ld	hl,#_ui_gamemenu_entriesTextPosition
   2716 19            [11]  320 	add	hl,de
   2717 4E            [ 7]  321 	ld	c,(hl)
   2718 23            [ 6]  322 	inc	hl
   2719 46            [ 7]  323 	ld	b,(hl)
   271A 21 AF 4A      [10]  324 	ld	hl,#_ui_gamemenu_action + 0
   271D 5E            [ 7]  325 	ld	e, (hl)
   271E 1D            [ 4]  326 	dec	e
   271F 26 00         [ 7]  327 	ld	h,#0x00
   2721 6B            [ 4]  328 	ld	l, e
   2722 29            [11]  329 	add	hl, hl
   2723 11 FD 25      [10]  330 	ld	de,#_ui_gamemenu_action_buttonText
   2726 19            [11]  331 	add	hl,de
   2727 5E            [ 7]  332 	ld	e,(hl)
   2728 23            [ 6]  333 	inc	hl
   2729 56            [ 7]  334 	ld	d,(hl)
   272A 3E 03         [ 7]  335 	ld	a,#0x03
   272C F5            [11]  336 	push	af
   272D 33            [ 6]  337 	inc	sp
   272E C5            [11]  338 	push	bc
   272F D5            [11]  339 	push	de
   2730 CD 67 22      [17]  340 	call	_print_transparent_text
   2733 F1            [10]  341 	pop	af
   2734 F1            [10]  342 	pop	af
   2735 33            [ 6]  343 	inc	sp
   2736 18 3F         [12]  344 	jr	00109$
   2738                     345 00106$:
                            346 ;src/UI_GameMenu.c:124: else if(n==3 && ui_gamemenu_can_move){
   2738 DD 7E 04      [19]  347 	ld	a,4 (ix)
   273B D6 03         [ 7]  348 	sub	a, #0x03
   273D 20 1E         [12]  349 	jr	NZ,00102$
   273F 3A AE 4A      [13]  350 	ld	a,(#_ui_gamemenu_can_move + 0)
   2742 B7            [ 4]  351 	or	a, a
   2743 28 18         [12]  352 	jr	Z,00102$
                            353 ;src/UI_GameMenu.c:125: print_transparent_text("MOVE", ui_gamemenu_entriesTextPosition[n], 3);
   2745 21 EF 25      [10]  354 	ld	hl,#_ui_gamemenu_entriesTextPosition
   2748 19            [11]  355 	add	hl,de
   2749 4E            [ 7]  356 	ld	c,(hl)
   274A 23            [ 6]  357 	inc	hl
   274B 46            [ 7]  358 	ld	b,(hl)
   274C 3E 03         [ 7]  359 	ld	a,#0x03
   274E F5            [11]  360 	push	af
   274F 33            [ 6]  361 	inc	sp
   2750 C5            [11]  362 	push	bc
   2751 21 7A 27      [10]  363 	ld	hl,#___str_9
   2754 E5            [11]  364 	push	hl
   2755 CD 67 22      [17]  365 	call	_print_transparent_text
   2758 F1            [10]  366 	pop	af
   2759 F1            [10]  367 	pop	af
   275A 33            [ 6]  368 	inc	sp
   275B 18 1A         [12]  369 	jr	00109$
   275D                     370 00102$:
                            371 ;src/UI_GameMenu.c:128: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
   275D 21 EF 25      [10]  372 	ld	hl,#_ui_gamemenu_entriesTextPosition
   2760 19            [11]  373 	add	hl,de
   2761 4E            [ 7]  374 	ld	c,(hl)
   2762 23            [ 6]  375 	inc	hl
   2763 46            [ 7]  376 	ld	b,(hl)
   2764 21 05 26      [10]  377 	ld	hl,#_ui_gamemenu_buttonText
   2767 19            [11]  378 	add	hl,de
   2768 5E            [ 7]  379 	ld	e,(hl)
   2769 23            [ 6]  380 	inc	hl
   276A 56            [ 7]  381 	ld	d,(hl)
   276B 3E 03         [ 7]  382 	ld	a,#0x03
   276D F5            [11]  383 	push	af
   276E 33            [ 6]  384 	inc	sp
   276F C5            [11]  385 	push	bc
   2770 D5            [11]  386 	push	de
   2771 CD 67 22      [17]  387 	call	_print_transparent_text
   2774 F1            [10]  388 	pop	af
   2775 F1            [10]  389 	pop	af
   2776 33            [ 6]  390 	inc	sp
   2777                     391 00109$:
   2777 DD E1         [14]  392 	pop	ix
   2779 C9            [10]  393 	ret
   277A                     394 ___str_9:
   277A 4D 4F 56 45         395 	.ascii "MOVE"
   277E 00                  396 	.db 0x00
                            397 ;src/UI_GameMenu.c:132: void ui_gamemenu_render_refresh(){
                            398 ;	---------------------------------
                            399 ; Function ui_gamemenu_render_refresh
                            400 ; ---------------------------------
   277F                     401 _ui_gamemenu_render_refresh::
                            402 ;src/UI_GameMenu.c:134: ui_gamemenu_render_button(ui_gamemenu_entryIndex);
   277F 3A AC 4A      [13]  403 	ld	a,(_ui_gamemenu_entryIndex)
   2782 F5            [11]  404 	push	af
   2783 33            [ 6]  405 	inc	sp
   2784 CD B4 26      [17]  406 	call	_ui_gamemenu_render_button
   2787 33            [ 6]  407 	inc	sp
                            408 ;src/UI_GameMenu.c:135: ui_gamemenu_render_button(ui_gamemenu_lastEntry);
   2788 3A AB 4A      [13]  409 	ld	a,(_ui_gamemenu_lastEntry)
   278B F5            [11]  410 	push	af
   278C 33            [ 6]  411 	inc	sp
   278D CD B4 26      [17]  412 	call	_ui_gamemenu_render_button
   2790 33            [ 6]  413 	inc	sp
                            414 ;src/UI_GameMenu.c:138: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   2791 3A AC 4A      [13]  415 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2794 32 AB 4A      [13]  416 	ld	(#_ui_gamemenu_lastEntry + 0),a
   2797 C9            [10]  417 	ret
                            418 ;src/UI_GameMenu.c:142: void ui_gamemenu_render_all(){
                            419 ;	---------------------------------
                            420 ; Function ui_gamemenu_render_all
                            421 ; ---------------------------------
   2798                     422 _ui_gamemenu_render_all::
                            423 ;src/UI_GameMenu.c:146: while(n){
   2798 06 07         [ 7]  424 	ld	b,#0x07
   279A                     425 00101$:
   279A 78            [ 4]  426 	ld	a,b
   279B B7            [ 4]  427 	or	a, a
   279C 28 0B         [12]  428 	jr	Z,00103$
                            429 ;src/UI_GameMenu.c:147: --n;
   279E 05            [ 4]  430 	dec	b
                            431 ;src/UI_GameMenu.c:148: ui_gamemenu_render_button(n);
   279F C5            [11]  432 	push	bc
   27A0 C5            [11]  433 	push	bc
   27A1 33            [ 6]  434 	inc	sp
   27A2 CD B4 26      [17]  435 	call	_ui_gamemenu_render_button
   27A5 33            [ 6]  436 	inc	sp
   27A6 C1            [10]  437 	pop	bc
   27A7 18 F1         [12]  438 	jr	00101$
   27A9                     439 00103$:
                            440 ;src/UI_GameMenu.c:151: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   27A9 3A AC 4A      [13]  441 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   27AC 32 AB 4A      [13]  442 	ld	(#_ui_gamemenu_lastEntry + 0),a
   27AF C9            [10]  443 	ret
                            444 ;src/UI_GameMenu.c:154: u8 ui_gamemenu_get_entry(){
                            445 ;	---------------------------------
                            446 ; Function ui_gamemenu_get_entry
                            447 ; ---------------------------------
   27B0                     448 _ui_gamemenu_get_entry::
                            449 ;src/UI_GameMenu.c:155: return ui_gamemenu_entryIndex;
   27B0 FD 21 AC 4A   [14]  450 	ld	iy,#_ui_gamemenu_entryIndex
   27B4 FD 6E 00      [19]  451 	ld	l,0 (iy)
   27B7 C9            [10]  452 	ret
                            453 ;src/UI_GameMenu.c:158: u8 ui_gamemenu_is_selected(){
                            454 ;	---------------------------------
                            455 ; Function ui_gamemenu_is_selected
                            456 ; ---------------------------------
   27B8                     457 _ui_gamemenu_is_selected::
                            458 ;src/UI_GameMenu.c:159: return ui_gamemenu_entrySelected;
   27B8 FD 21 AD 4A   [14]  459 	ld	iy,#_ui_gamemenu_entrySelected
   27BC FD 6E 00      [19]  460 	ld	l,0 (iy)
   27BF C9            [10]  461 	ret
                            462 ;src/UI_GameMenu.c:162: void ui_gamemenu_update_action(){
                            463 ;	---------------------------------
                            464 ; Function ui_gamemenu_update_action
                            465 ; ---------------------------------
   27C0                     466 _ui_gamemenu_update_action::
                            467 ;src/UI_GameMenu.c:163: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
   27C0 21 89 08      [10]  468 	ld	hl, #_player_position + 0
   27C3 4E            [ 7]  469 	ld	c,(hl)
   27C4 06 00         [ 7]  470 	ld	b,#0x00
   27C6 3A 8B 08      [13]  471 	ld	a, (#_player_direction + 0)
   27C9 6F            [ 4]  472 	ld	l,a
   27CA 17            [ 4]  473 	rla
   27CB 9F            [ 4]  474 	sbc	a, a
   27CC 67            [ 4]  475 	ld	h,a
   27CD 09            [11]  476 	add	hl,bc
   27CE 01 00 60      [10]  477 	ld	bc,#0x6000
   27D1 09            [11]  478 	add	hl,bc
   27D2 4D            [ 4]  479 	ld	c,l
   27D3 44            [ 4]  480 	ld	b,h
   27D4 21 8A 08      [10]  481 	ld	hl, #(_player_position + 0x0001) + 0
   27D7 5E            [ 7]  482 	ld	e,(hl)
   27D8 16 00         [ 7]  483 	ld	d,#0x00
   27DA 3A 8C 08      [13]  484 	ld	a, (#(_player_direction + 0x0001) + 0)
   27DD 6F            [ 4]  485 	ld	l,a
   27DE 17            [ 4]  486 	rla
   27DF 9F            [ 4]  487 	sbc	a, a
   27E0 67            [ 4]  488 	ld	h,a
   27E1 19            [11]  489 	add	hl,de
   27E2 29            [11]  490 	add	hl, hl
   27E3 29            [11]  491 	add	hl, hl
   27E4 29            [11]  492 	add	hl, hl
   27E5 29            [11]  493 	add	hl, hl
   27E6 29            [11]  494 	add	hl, hl
   27E7 09            [11]  495 	add	hl,bc
   27E8 4E            [ 7]  496 	ld	c,(hl)
                            497 ;src/UI_GameMenu.c:165: ui_gamemenu_can_move=0;
   27E9 21 AE 4A      [10]  498 	ld	hl,#_ui_gamemenu_can_move + 0
   27EC 36 00         [10]  499 	ld	(hl), #0x00
                            500 ;src/UI_GameMenu.c:166: ui_gamemenu_action=0;
   27EE 21 AF 4A      [10]  501 	ld	hl,#_ui_gamemenu_action + 0
   27F1 36 00         [10]  502 	ld	(hl), #0x00
                            503 ;src/UI_GameMenu.c:168: if(forward&CELL_WALL_MASK){
   27F3 CB 79         [ 8]  504 	bit	7, c
   27F5 28 0C         [12]  505 	jr	Z,00110$
                            506 ;src/UI_GameMenu.c:169: if(forward==CELLTYPE_DOOR){
   27F7 79            [ 4]  507 	ld	a,c
   27F8 D6 80         [ 7]  508 	sub	a, #0x80
   27FA 20 24         [12]  509 	jr	NZ,00111$
                            510 ;src/UI_GameMenu.c:170: ui_gamemenu_action=1;
   27FC 21 AF 4A      [10]  511 	ld	hl,#_ui_gamemenu_action + 0
   27FF 36 01         [10]  512 	ld	(hl), #0x01
   2801 18 1D         [12]  513 	jr	00111$
   2803                     514 00110$:
                            515 ;src/UI_GameMenu.c:173: else if(forward&CELL_ENEMY_MASK) ui_gamemenu_action=2;
   2803 79            [ 4]  516 	ld	a,c
   2804 E6 0F         [ 7]  517 	and	a, #0x0F
   2806 28 07         [12]  518 	jr	Z,00107$
   2808 21 AF 4A      [10]  519 	ld	hl,#_ui_gamemenu_action + 0
   280B 36 02         [10]  520 	ld	(hl), #0x02
   280D 18 11         [12]  521 	jr	00111$
   280F                     522 00107$:
                            523 ;src/UI_GameMenu.c:174: else if(forward&CELL_ITEM_MASK) ui_gamemenu_action=3;
   280F 79            [ 4]  524 	ld	a,c
   2810 E6 70         [ 7]  525 	and	a, #0x70
   2812 28 07         [12]  526 	jr	Z,00104$
   2814 21 AF 4A      [10]  527 	ld	hl,#_ui_gamemenu_action + 0
   2817 36 03         [10]  528 	ld	(hl), #0x03
   2819 18 05         [12]  529 	jr	00111$
   281B                     530 00104$:
                            531 ;src/UI_GameMenu.c:176: ui_gamemenu_can_move=1;
   281B 21 AE 4A      [10]  532 	ld	hl,#_ui_gamemenu_can_move + 0
   281E 36 01         [10]  533 	ld	(hl), #0x01
   2820                     534 00111$:
                            535 ;src/UI_GameMenu.c:178: ui_gamemenu_render_button(0);
   2820 AF            [ 4]  536 	xor	a, a
   2821 F5            [11]  537 	push	af
   2822 33            [ 6]  538 	inc	sp
   2823 CD B4 26      [17]  539 	call	_ui_gamemenu_render_button
   2826 33            [ 6]  540 	inc	sp
                            541 ;src/UI_GameMenu.c:179: ui_gamemenu_render_button(3);
   2827 3E 03         [ 7]  542 	ld	a,#0x03
   2829 F5            [11]  543 	push	af
   282A 33            [ 6]  544 	inc	sp
   282B CD B4 26      [17]  545 	call	_ui_gamemenu_render_button
   282E 33            [ 6]  546 	inc	sp
   282F C9            [10]  547 	ret
                            548 ;src/UI_GameMenu.c:182: u8 ui_gamemenu_get_movement(){
                            549 ;	---------------------------------
                            550 ; Function ui_gamemenu_get_movement
                            551 ; ---------------------------------
   2830                     552 _ui_gamemenu_get_movement::
                            553 ;src/UI_GameMenu.c:183: return ui_gamemenu_can_move;
   2830 FD 21 AE 4A   [14]  554 	ld	iy,#_ui_gamemenu_can_move
   2834 FD 6E 00      [19]  555 	ld	l,0 (iy)
   2837 C9            [10]  556 	ret
                            557 ;src/UI_GameMenu.c:186: u8 ui_gamemenu_get_action(){
                            558 ;	---------------------------------
                            559 ; Function ui_gamemenu_get_action
                            560 ; ---------------------------------
   2838                     561 _ui_gamemenu_get_action::
                            562 ;src/UI_GameMenu.c:187: return ui_gamemenu_action;
   2838 FD 21 AF 4A   [14]  563 	ld	iy,#_ui_gamemenu_action
   283C FD 6E 00      [19]  564 	ld	l,0 (iy)
   283F C9            [10]  565 	ret
                            566 	.area _CODE
                            567 	.area _INITIALIZER
   4AB8                     568 __xinit__ui_gamemenu_lastEntry:
   4AB8 00                  569 	.db #0x00	; 0
   4AB9                     570 __xinit__ui_gamemenu_entryIndex:
   4AB9 00                  571 	.db #0x00	; 0
   4ABA                     572 __xinit__ui_gamemenu_entrySelected:
   4ABA 00                  573 	.db #0x00	; 0
   4ABB                     574 __xinit__ui_gamemenu_can_move:
   4ABB 00                  575 	.db #0x00	; 0
   4ABC                     576 __xinit__ui_gamemenu_action:
   4ABC 00                  577 	.db #0x00	; 0
                            578 	.area _CABS (ABS)
