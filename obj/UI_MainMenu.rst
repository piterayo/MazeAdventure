                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_MainMenu
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_mainmenu_render_button
                             12 	.globl _print_transparent_text
                             13 	.globl _cpct_drawSolidBox
                             14 	.globl _ui_mainmenu_entrySelected
                             15 	.globl _ui_mainmenu_entryIndex
                             16 	.globl _ui_mainmenu_lastEntry
                             17 	.globl _ui_mainmenu_buttonText
                             18 	.globl _ui_mainmenu_entriesTextPosition
                             19 	.globl _ui_mainmenu_entriesPosition
                             20 	.globl _ui_mainmenu_init
                             21 	.globl _ui_mainmenu_next_entry
                             22 	.globl _ui_mainmenu_previous_entry
                             23 	.globl _ui_mainmenu_unselect_entry
                             24 	.globl _ui_mainmenu_select_entry
                             25 	.globl _ui_mainmenu_render_refresh
                             26 	.globl _ui_mainmenu_render_all
                             27 	.globl _ui_mainmenu_get_entry
                             28 	.globl _ui_mainmenu_is_selected
                             29 ;--------------------------------------------------------
                             30 ; special function registers
                             31 ;--------------------------------------------------------
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _DATA
                             36 ;--------------------------------------------------------
                             37 ; ram data
                             38 ;--------------------------------------------------------
                             39 	.area _INITIALIZED
   4FAA                      40 _ui_mainmenu_lastEntry::
   4FAA                      41 	.ds 1
   4FAB                      42 _ui_mainmenu_entryIndex::
   4FAB                      43 	.ds 1
   4FAC                      44 _ui_mainmenu_entrySelected::
   4FAC                      45 	.ds 1
                             46 ;--------------------------------------------------------
                             47 ; absolute external ram data
                             48 ;--------------------------------------------------------
                             49 	.area _DABS (ABS)
                             50 ;--------------------------------------------------------
                             51 ; global & static initialisations
                             52 ;--------------------------------------------------------
                             53 	.area _HOME
                             54 	.area _GSINIT
                             55 	.area _GSFINAL
                             56 	.area _GSINIT
                             57 ;--------------------------------------------------------
                             58 ; Home
                             59 ;--------------------------------------------------------
                             60 	.area _HOME
                             61 	.area _HOME
                             62 ;--------------------------------------------------------
                             63 ; code
                             64 ;--------------------------------------------------------
                             65 	.area _CODE
                             66 ;src/UI_MainMenu.c:55: void ui_mainmenu_init(){
                             67 ;	---------------------------------
                             68 ; Function ui_mainmenu_init
                             69 ; ---------------------------------
   26F9                      70 _ui_mainmenu_init::
                             71 ;src/UI_MainMenu.c:56: ui_mainmenu_lastEntry=0;
   26F9 21 AA 4F      [10]   72 	ld	hl,#_ui_mainmenu_lastEntry + 0
   26FC 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_MainMenu.c:57: ui_mainmenu_entryIndex=0;
   26FE 21 AB 4F      [10]   75 	ld	hl,#_ui_mainmenu_entryIndex + 0
   2701 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_MainMenu.c:58: ui_mainmenu_entrySelected=0;
   2703 21 AC 4F      [10]   78 	ld	hl,#_ui_mainmenu_entrySelected + 0
   2706 36 00         [10]   79 	ld	(hl), #0x00
   2708 C9            [10]   80 	ret
   2709                      81 _ui_mainmenu_entriesPosition:
   2709 2E C4                82 	.dw #0xC42E
   270B CE E4                83 	.dw #0xE4CE
   270D BE C5                84 	.dw #0xC5BE
   270F 5E E6                85 	.dw #0xE65E
   2711 4E C7                86 	.dw #0xC74E
   2713                      87 _ui_mainmenu_entriesTextPosition:
   2713 30 EC                88 	.dw #0xEC30
   2715 1F CD                89 	.dw #0xCD1F
   2717 C1 ED                90 	.dw #0xEDC1
   2719 B1 CE                91 	.dw #0xCEB1
   271B 54 EF                92 	.dw #0xEF54
   271D                      93 _ui_mainmenu_buttonText:
   271D 27 27                94 	.dw __str_0
   271F 30 27                95 	.dw __str_1
   2721 3A 27                96 	.dw __str_2
   2723 42 27                97 	.dw __str_3
   2725 4A 27                98 	.dw __str_4
   2727                      99 __str_0:
   2727 4E 45 57 20 47 41   100 	.ascii "NEW GAME"
        4D 45
   272F 00                  101 	.db 0x00
   2730                     102 __str_1:
   2730 4C 4F 41 44 20 47   103 	.ascii "LOAD GAME"
        41 4D 45
   2739 00                  104 	.db 0x00
   273A                     105 __str_2:
   273A 4F 50 54 49 4F 4E   106 	.ascii "OPTIONS"
        53
   2741 00                  107 	.db 0x00
   2742                     108 __str_3:
   2742 43 52 45 44 49 54   109 	.ascii "CREDITS"
        53
   2749 00                  110 	.db 0x00
   274A                     111 __str_4:
   274A 45 58 49 54         112 	.ascii "EXIT"
   274E 00                  113 	.db 0x00
                            114 ;src/UI_MainMenu.c:61: void ui_mainmenu_next_entry(){
                            115 ;	---------------------------------
                            116 ; Function ui_mainmenu_next_entry
                            117 ; ---------------------------------
   274F                     118 _ui_mainmenu_next_entry::
                            119 ;src/UI_MainMenu.c:62: if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
                            120 ;src/UI_MainMenu.c:63: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   274F 3A AB 4F      [13]  121 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2752 FE 04         [ 7]  122 	cp	a,#0x04
   2754 D0            [11]  123 	ret	NC
   2755 32 AA 4F      [13]  124 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            125 ;src/UI_MainMenu.c:64: ++ui_mainmenu_entryIndex;
   2758 21 AB 4F      [10]  126 	ld	hl, #_ui_mainmenu_entryIndex+0
   275B 34            [11]  127 	inc	(hl)
   275C C9            [10]  128 	ret
                            129 ;src/UI_MainMenu.c:68: void ui_mainmenu_previous_entry(){
                            130 ;	---------------------------------
                            131 ; Function ui_mainmenu_previous_entry
                            132 ; ---------------------------------
   275D                     133 _ui_mainmenu_previous_entry::
                            134 ;src/UI_MainMenu.c:69: if(ui_mainmenu_entryIndex>0){
   275D 3A AB 4F      [13]  135 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2760 B7            [ 4]  136 	or	a, a
   2761 C8            [11]  137 	ret	Z
                            138 ;src/UI_MainMenu.c:70: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   2762 3A AB 4F      [13]  139 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2765 32 AA 4F      [13]  140 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            141 ;src/UI_MainMenu.c:71: --ui_mainmenu_entryIndex;
   2768 21 AB 4F      [10]  142 	ld	hl, #_ui_mainmenu_entryIndex+0
   276B 35            [11]  143 	dec	(hl)
   276C C9            [10]  144 	ret
                            145 ;src/UI_MainMenu.c:75: void ui_mainmenu_unselect_entry(){
                            146 ;	---------------------------------
                            147 ; Function ui_mainmenu_unselect_entry
                            148 ; ---------------------------------
   276D                     149 _ui_mainmenu_unselect_entry::
                            150 ;src/UI_MainMenu.c:76: ui_mainmenu_entrySelected=0;
   276D 21 AC 4F      [10]  151 	ld	hl,#_ui_mainmenu_entrySelected + 0
   2770 36 00         [10]  152 	ld	(hl), #0x00
   2772 C9            [10]  153 	ret
                            154 ;src/UI_MainMenu.c:79: void ui_mainmenu_select_entry(){
                            155 ;	---------------------------------
                            156 ; Function ui_mainmenu_select_entry
                            157 ; ---------------------------------
   2773                     158 _ui_mainmenu_select_entry::
                            159 ;src/UI_MainMenu.c:80: ui_mainmenu_entrySelected=1;
   2773 21 AC 4F      [10]  160 	ld	hl,#_ui_mainmenu_entrySelected + 0
   2776 36 01         [10]  161 	ld	(hl), #0x01
   2778 C9            [10]  162 	ret
                            163 ;src/UI_MainMenu.c:83: void ui_mainmenu_render_button(u8 n){
                            164 ;	---------------------------------
                            165 ; Function ui_mainmenu_render_button
                            166 ; ---------------------------------
   2779                     167 _ui_mainmenu_render_button::
   2779 DD E5         [15]  168 	push	ix
   277B DD 21 00 00   [14]  169 	ld	ix,#0
   277F DD 39         [15]  170 	add	ix,sp
   2781 3B            [ 6]  171 	dec	sp
                            172 ;src/UI_MainMenu.c:85: color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   2782 DD 7E 04      [19]  173 	ld	a,4 (ix)
   2785 FD 21 AB 4F   [14]  174 	ld	iy,#_ui_mainmenu_entryIndex
   2789 FD 96 00      [19]  175 	sub	a, 0 (iy)
   278C 20 10         [12]  176 	jr	NZ,00103$
   278E 3A AC 4F      [13]  177 	ld	a,(#_ui_mainmenu_entrySelected + 0)
   2791 B7            [ 4]  178 	or	a, a
   2792 28 05         [12]  179 	jr	Z,00105$
   2794 3A A7 0A      [13]  180 	ld	a, (#(_g_colors + 0x0004) + 0)
   2797 18 08         [12]  181 	jr	00104$
   2799                     182 00105$:
   2799 3A A9 0A      [13]  183 	ld	a, (#(_g_colors + 0x0006) + 0)
   279C 18 03         [12]  184 	jr	00104$
   279E                     185 00103$:
   279E 3A A5 0A      [13]  186 	ld	a, (#(_g_colors + 0x0002) + 0)
   27A1                     187 00104$:
   27A1 DD 77 FF      [19]  188 	ld	-1 (ix),a
                            189 ;src/UI_MainMenu.c:86: cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, UI_MAINMENU_BUTTON_WIDTH, UI_MAINMENU_BUTTON_HEIGHT);
   27A4 DD 6E 04      [19]  190 	ld	l,4 (ix)
   27A7 26 00         [ 7]  191 	ld	h,#0x00
   27A9 29            [11]  192 	add	hl, hl
   27AA 4D            [ 4]  193 	ld	c, l
   27AB 44            [ 4]  194 	ld	b, h
   27AC 21 09 27      [10]  195 	ld	hl,#_ui_mainmenu_entriesPosition
   27AF 09            [11]  196 	add	hl,bc
   27B0 5E            [ 7]  197 	ld	e,(hl)
   27B1 23            [ 6]  198 	inc	hl
   27B2 56            [ 7]  199 	ld	d,(hl)
   27B3 C5            [11]  200 	push	bc
   27B4 21 14 10      [10]  201 	ld	hl,#0x1014
   27B7 E5            [11]  202 	push	hl
   27B8 DD 7E FF      [19]  203 	ld	a,-1 (ix)
   27BB F5            [11]  204 	push	af
   27BC 33            [ 6]  205 	inc	sp
   27BD D5            [11]  206 	push	de
   27BE CD C0 4D      [17]  207 	call	_cpct_drawSolidBox
   27C1 F1            [10]  208 	pop	af
   27C2 F1            [10]  209 	pop	af
   27C3 33            [ 6]  210 	inc	sp
   27C4 C1            [10]  211 	pop	bc
                            212 ;src/UI_MainMenu.c:87: print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesTextPosition[n], 3);
   27C5 21 13 27      [10]  213 	ld	hl,#_ui_mainmenu_entriesTextPosition
   27C8 09            [11]  214 	add	hl,bc
   27C9 5E            [ 7]  215 	ld	e,(hl)
   27CA 23            [ 6]  216 	inc	hl
   27CB 56            [ 7]  217 	ld	d,(hl)
   27CC 21 1D 27      [10]  218 	ld	hl,#_ui_mainmenu_buttonText
   27CF 09            [11]  219 	add	hl,bc
   27D0 4E            [ 7]  220 	ld	c,(hl)
   27D1 23            [ 6]  221 	inc	hl
   27D2 46            [ 7]  222 	ld	b,(hl)
   27D3 3E 03         [ 7]  223 	ld	a,#0x03
   27D5 F5            [11]  224 	push	af
   27D6 33            [ 6]  225 	inc	sp
   27D7 D5            [11]  226 	push	de
   27D8 C5            [11]  227 	push	bc
   27D9 CD 70 22      [17]  228 	call	_print_transparent_text
   27DC F1            [10]  229 	pop	af
   27DD F1            [10]  230 	pop	af
   27DE 33            [ 6]  231 	inc	sp
   27DF 33            [ 6]  232 	inc	sp
   27E0 DD E1         [14]  233 	pop	ix
   27E2 C9            [10]  234 	ret
                            235 ;src/UI_MainMenu.c:90: void ui_mainmenu_render_refresh(){
                            236 ;	---------------------------------
                            237 ; Function ui_mainmenu_render_refresh
                            238 ; ---------------------------------
   27E3                     239 _ui_mainmenu_render_refresh::
                            240 ;src/UI_MainMenu.c:92: ui_mainmenu_render_button(ui_mainmenu_entryIndex);
   27E3 3A AB 4F      [13]  241 	ld	a,(_ui_mainmenu_entryIndex)
   27E6 F5            [11]  242 	push	af
   27E7 33            [ 6]  243 	inc	sp
   27E8 CD 79 27      [17]  244 	call	_ui_mainmenu_render_button
   27EB 33            [ 6]  245 	inc	sp
                            246 ;src/UI_MainMenu.c:93: ui_mainmenu_render_button(ui_mainmenu_lastEntry);
   27EC 3A AA 4F      [13]  247 	ld	a,(_ui_mainmenu_lastEntry)
   27EF F5            [11]  248 	push	af
   27F0 33            [ 6]  249 	inc	sp
   27F1 CD 79 27      [17]  250 	call	_ui_mainmenu_render_button
   27F4 33            [ 6]  251 	inc	sp
                            252 ;src/UI_MainMenu.c:95: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   27F5 3A AB 4F      [13]  253 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   27F8 32 AA 4F      [13]  254 	ld	(#_ui_mainmenu_lastEntry + 0),a
   27FB C9            [10]  255 	ret
                            256 ;src/UI_MainMenu.c:99: void ui_mainmenu_render_all(){
                            257 ;	---------------------------------
                            258 ; Function ui_mainmenu_render_all
                            259 ; ---------------------------------
   27FC                     260 _ui_mainmenu_render_all::
                            261 ;src/UI_MainMenu.c:103: while(n){
   27FC 06 05         [ 7]  262 	ld	b,#0x05
   27FE                     263 00101$:
   27FE 78            [ 4]  264 	ld	a,b
   27FF B7            [ 4]  265 	or	a, a
   2800 28 0B         [12]  266 	jr	Z,00103$
                            267 ;src/UI_MainMenu.c:104: --n;
   2802 05            [ 4]  268 	dec	b
                            269 ;src/UI_MainMenu.c:105: ui_mainmenu_render_button(n);
   2803 C5            [11]  270 	push	bc
   2804 C5            [11]  271 	push	bc
   2805 33            [ 6]  272 	inc	sp
   2806 CD 79 27      [17]  273 	call	_ui_mainmenu_render_button
   2809 33            [ 6]  274 	inc	sp
   280A C1            [10]  275 	pop	bc
   280B 18 F1         [12]  276 	jr	00101$
   280D                     277 00103$:
                            278 ;src/UI_MainMenu.c:108: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   280D 3A AB 4F      [13]  279 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2810 32 AA 4F      [13]  280 	ld	(#_ui_mainmenu_lastEntry + 0),a
   2813 C9            [10]  281 	ret
                            282 ;src/UI_MainMenu.c:111: u8 ui_mainmenu_get_entry(){
                            283 ;	---------------------------------
                            284 ; Function ui_mainmenu_get_entry
                            285 ; ---------------------------------
   2814                     286 _ui_mainmenu_get_entry::
                            287 ;src/UI_MainMenu.c:112: return ui_mainmenu_entryIndex;
   2814 FD 21 AB 4F   [14]  288 	ld	iy,#_ui_mainmenu_entryIndex
   2818 FD 6E 00      [19]  289 	ld	l,0 (iy)
   281B C9            [10]  290 	ret
                            291 ;src/UI_MainMenu.c:115: u8 ui_mainmenu_is_selected(){
                            292 ;	---------------------------------
                            293 ; Function ui_mainmenu_is_selected
                            294 ; ---------------------------------
   281C                     295 _ui_mainmenu_is_selected::
                            296 ;src/UI_MainMenu.c:116: return ui_mainmenu_entrySelected;
   281C FD 21 AC 4F   [14]  297 	ld	iy,#_ui_mainmenu_entrySelected
   2820 FD 6E 00      [19]  298 	ld	l,0 (iy)
   2823 C9            [10]  299 	ret
                            300 	.area _CODE
                            301 	.area _INITIALIZER
   4FB6                     302 __xinit__ui_mainmenu_lastEntry:
   4FB6 00                  303 	.db #0x00	; 0
   4FB7                     304 __xinit__ui_mainmenu_entryIndex:
   4FB7 00                  305 	.db #0x00	; 0
   4FB8                     306 __xinit__ui_mainmenu_entrySelected:
   4FB8 00                  307 	.db #0x00	; 0
                            308 	.area _CABS (ABS)
