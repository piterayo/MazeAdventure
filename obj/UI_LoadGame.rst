                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_LoadGame
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_loadgame_render_button
                             12 	.globl _ui_stringinput_get_string
                             13 	.globl _print_transparent_text
                             14 	.globl _print_text
                             15 	.globl _cpct_drawSolidBox
                             16 	.globl _ui_loadgame_entrySelected
                             17 	.globl _ui_loadgame_entryIndex
                             18 	.globl _ui_loadgame_lastEntry
                             19 	.globl _ui_loadgame_buttonText
                             20 	.globl _ui_loadgame_entriesTextPosition
                             21 	.globl _ui_loadgame_entriesPosition
                             22 	.globl _ui_loadgame_init
                             23 	.globl _ui_loadgame_get_entry
                             24 	.globl _ui_loadgame_is_selected
                             25 	.globl _ui_loadgame_next_entry
                             26 	.globl _ui_loadgame_previous_entry
                             27 	.globl _ui_loadgame_select_entry
                             28 	.globl _ui_loadgame_unselect_entry
                             29 	.globl _ui_loadgame_render_all
                             30 ;--------------------------------------------------------
                             31 ; special function registers
                             32 ;--------------------------------------------------------
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DATA
   7DD0                      37 _ui_loadgame_lastEntry::
   7DD0                      38 	.ds 1
   7DD1                      39 _ui_loadgame_entryIndex::
   7DD1                      40 	.ds 1
   7DD2                      41 _ui_loadgame_entrySelected::
   7DD2                      42 	.ds 1
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
                             67 ;src/UI_LoadGame.c:48: void ui_loadgame_init(){
                             68 ;	---------------------------------
                             69 ; Function ui_loadgame_init
                             70 ; ---------------------------------
   462C                      71 _ui_loadgame_init::
                             72 ;src/UI_LoadGame.c:49: ui_loadgame_lastEntry=0;
   462C 21 D0 7D      [10]   73 	ld	hl,#_ui_loadgame_lastEntry + 0
   462F 36 00         [10]   74 	ld	(hl), #0x00
                             75 ;src/UI_LoadGame.c:50: ui_loadgame_entryIndex=0;
   4631 21 D1 7D      [10]   76 	ld	hl,#_ui_loadgame_entryIndex + 0
   4634 36 00         [10]   77 	ld	(hl), #0x00
                             78 ;src/UI_LoadGame.c:51: ui_loadgame_entrySelected=0;
   4636 21 D2 7D      [10]   79 	ld	hl,#_ui_loadgame_entrySelected + 0
   4639 36 00         [10]   80 	ld	(hl), #0x00
   463B C9            [10]   81 	ret
   463C                      82 _ui_loadgame_entriesPosition:
   463C D8 EB                83 	.dw #0xEBD8
   463E EA EB                84 	.dw #0xEBEA
   4640                      85 _ui_loadgame_entriesTextPosition:
   4640 2A D4                86 	.dw #0xD42A
   4642 3C D4                87 	.dw #0xD43C
   4644                      88 _ui_loadgame_buttonText:
   4644 48 46                89 	.dw __str_0
   4646 4D 46                90 	.dw __str_1
   4648                      91 __str_0:
   4648 4C 4F 41 44          92 	.ascii "LOAD"
   464C 00                   93 	.db 0x00
   464D                      94 __str_1:
   464D 45 58 49 54          95 	.ascii "EXIT"
   4651 00                   96 	.db 0x00
                             97 ;src/UI_LoadGame.c:55: u8 ui_loadgame_get_entry(){
                             98 ;	---------------------------------
                             99 ; Function ui_loadgame_get_entry
                            100 ; ---------------------------------
   4652                     101 _ui_loadgame_get_entry::
                            102 ;src/UI_LoadGame.c:56: return ui_loadgame_entryIndex;
   4652 FD 21 D1 7D   [14]  103 	ld	iy,#_ui_loadgame_entryIndex
   4656 FD 6E 00      [19]  104 	ld	l,0 (iy)
   4659 C9            [10]  105 	ret
                            106 ;src/UI_LoadGame.c:59: u8 ui_loadgame_is_selected(){
                            107 ;	---------------------------------
                            108 ; Function ui_loadgame_is_selected
                            109 ; ---------------------------------
   465A                     110 _ui_loadgame_is_selected::
                            111 ;src/UI_LoadGame.c:60: return ui_loadgame_entrySelected;
   465A FD 21 D2 7D   [14]  112 	ld	iy,#_ui_loadgame_entrySelected
   465E FD 6E 00      [19]  113 	ld	l,0 (iy)
   4661 C9            [10]  114 	ret
                            115 ;src/UI_LoadGame.c:63: void ui_loadgame_next_entry(){
                            116 ;	---------------------------------
                            117 ; Function ui_loadgame_next_entry
                            118 ; ---------------------------------
   4662                     119 _ui_loadgame_next_entry::
                            120 ;src/UI_LoadGame.c:64: if(ui_loadgame_entryIndex<(UI_LOADGAME_ENTRIES-1)){
   4662 3A D1 7D      [13]  121 	ld	a,(#_ui_loadgame_entryIndex + 0)
   4665 EE 80         [ 7]  122 	xor	a, #0x80
   4667 D6 81         [ 7]  123 	sub	a, #0x81
   4669 D0            [11]  124 	ret	NC
                            125 ;src/UI_LoadGame.c:65: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
   466A 3A D1 7D      [13]  126 	ld	a,(#_ui_loadgame_entryIndex + 0)
   466D 21 D0 7D      [10]  127 	ld	hl,#_ui_loadgame_lastEntry + 0
   4670 77            [ 7]  128 	ld	(hl), a
                            129 ;src/UI_LoadGame.c:66: ++ui_loadgame_entryIndex;
   4671 21 D1 7D      [10]  130 	ld	hl, #_ui_loadgame_entryIndex+0
   4674 34            [11]  131 	inc	(hl)
   4675 C9            [10]  132 	ret
                            133 ;src/UI_LoadGame.c:70: void ui_loadgame_previous_entry(){
                            134 ;	---------------------------------
                            135 ; Function ui_loadgame_previous_entry
                            136 ; ---------------------------------
   4676                     137 _ui_loadgame_previous_entry::
                            138 ;src/UI_LoadGame.c:71: if(ui_loadgame_entryIndex>0){
   4676 3A D1 7D      [13]  139 	ld	a,(#_ui_loadgame_entryIndex + 0)
   4679 B7            [ 4]  140 	or	a, a
   467A C8            [11]  141 	ret	Z
                            142 ;src/UI_LoadGame.c:72: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
   467B 3A D1 7D      [13]  143 	ld	a,(#_ui_loadgame_entryIndex + 0)
   467E 21 D0 7D      [10]  144 	ld	hl,#_ui_loadgame_lastEntry + 0
   4681 77            [ 7]  145 	ld	(hl), a
                            146 ;src/UI_LoadGame.c:73: --ui_loadgame_entryIndex;
   4682 21 D1 7D      [10]  147 	ld	hl, #_ui_loadgame_entryIndex+0
   4685 35            [11]  148 	dec	(hl)
   4686 C9            [10]  149 	ret
                            150 ;src/UI_LoadGame.c:78: void ui_loadgame_select_entry(){
                            151 ;	---------------------------------
                            152 ; Function ui_loadgame_select_entry
                            153 ; ---------------------------------
   4687                     154 _ui_loadgame_select_entry::
                            155 ;src/UI_LoadGame.c:79: ui_loadgame_entrySelected=1;
   4687 21 D2 7D      [10]  156 	ld	hl,#_ui_loadgame_entrySelected + 0
   468A 36 01         [10]  157 	ld	(hl), #0x01
   468C C9            [10]  158 	ret
                            159 ;src/UI_LoadGame.c:82: void ui_loadgame_unselect_entry(){
                            160 ;	---------------------------------
                            161 ; Function ui_loadgame_unselect_entry
                            162 ; ---------------------------------
   468D                     163 _ui_loadgame_unselect_entry::
                            164 ;src/UI_LoadGame.c:83: ui_loadgame_entrySelected=0;
   468D 21 D2 7D      [10]  165 	ld	hl,#_ui_loadgame_entrySelected + 0
   4690 36 00         [10]  166 	ld	(hl), #0x00
   4692 C9            [10]  167 	ret
                            168 ;src/UI_LoadGame.c:86: void ui_loadgame_render_button(u8 n){
                            169 ;	---------------------------------
                            170 ; Function ui_loadgame_render_button
                            171 ; ---------------------------------
   4693                     172 _ui_loadgame_render_button::
   4693 DD E5         [15]  173 	push	ix
   4695 DD 21 00 00   [14]  174 	ld	ix,#0
   4699 DD 39         [15]  175 	add	ix,sp
   469B 3B            [ 6]  176 	dec	sp
                            177 ;src/UI_LoadGame.c:88: color = (n==ui_loadgame_entryIndex)?((ui_loadgame_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   469C DD 7E 04      [19]  178 	ld	a,4 (ix)
   469F FD 21 D1 7D   [14]  179 	ld	iy,#_ui_loadgame_entryIndex
   46A3 FD 96 00      [19]  180 	sub	a, 0 (iy)
   46A6 20 10         [12]  181 	jr	NZ,00103$
   46A8 3A D2 7D      [13]  182 	ld	a,(#_ui_loadgame_entrySelected + 0)
   46AB B7            [ 4]  183 	or	a, a
   46AC 28 05         [12]  184 	jr	Z,00105$
   46AE 3A B3 1A      [13]  185 	ld	a, (#(_g_colors + 0x0004) + 0)
   46B1 18 08         [12]  186 	jr	00104$
   46B3                     187 00105$:
   46B3 3A B5 1A      [13]  188 	ld	a, (#(_g_colors + 0x0006) + 0)
   46B6 18 03         [12]  189 	jr	00104$
   46B8                     190 00103$:
   46B8 3A B1 1A      [13]  191 	ld	a, (#(_g_colors + 0x0002) + 0)
   46BB                     192 00104$:
   46BB DD 77 FF      [19]  193 	ld	-1 (ix),a
                            194 ;src/UI_LoadGame.c:89: cpct_drawSolidBox(ui_loadgame_entriesPosition[n],color, UI_LOADGAME_BUTTON_WIDTH, UI_LOADGAME_BUTTON_HEIGHT);
   46BE DD 6E 04      [19]  195 	ld	l,4 (ix)
   46C1 26 00         [ 7]  196 	ld	h,#0x00
   46C3 29            [11]  197 	add	hl, hl
   46C4 4D            [ 4]  198 	ld	c, l
   46C5 44            [ 4]  199 	ld	b, h
   46C6 21 3C 46      [10]  200 	ld	hl,#_ui_loadgame_entriesPosition
   46C9 09            [11]  201 	add	hl,bc
   46CA 5E            [ 7]  202 	ld	e,(hl)
   46CB 23            [ 6]  203 	inc	hl
   46CC 56            [ 7]  204 	ld	d,(hl)
   46CD C5            [11]  205 	push	bc
   46CE 21 0C 10      [10]  206 	ld	hl,#0x100C
   46D1 E5            [11]  207 	push	hl
   46D2 DD 7E FF      [19]  208 	ld	a,-1 (ix)
   46D5 F5            [11]  209 	push	af
   46D6 33            [ 6]  210 	inc	sp
   46D7 D5            [11]  211 	push	de
   46D8 CD B8 7B      [17]  212 	call	_cpct_drawSolidBox
   46DB F1            [10]  213 	pop	af
   46DC F1            [10]  214 	pop	af
   46DD 33            [ 6]  215 	inc	sp
   46DE C1            [10]  216 	pop	bc
                            217 ;src/UI_LoadGame.c:90: print_transparent_text(ui_loadgame_buttonText[n], ui_loadgame_entriesTextPosition[n], 3);
   46DF 21 40 46      [10]  218 	ld	hl,#_ui_loadgame_entriesTextPosition
   46E2 09            [11]  219 	add	hl,bc
   46E3 5E            [ 7]  220 	ld	e,(hl)
   46E4 23            [ 6]  221 	inc	hl
   46E5 56            [ 7]  222 	ld	d,(hl)
   46E6 21 44 46      [10]  223 	ld	hl,#_ui_loadgame_buttonText
   46E9 09            [11]  224 	add	hl,bc
   46EA 4E            [ 7]  225 	ld	c,(hl)
   46EB 23            [ 6]  226 	inc	hl
   46EC 46            [ 7]  227 	ld	b,(hl)
   46ED 3E 03         [ 7]  228 	ld	a,#0x03
   46EF F5            [11]  229 	push	af
   46F0 33            [ 6]  230 	inc	sp
   46F1 D5            [11]  231 	push	de
   46F2 C5            [11]  232 	push	bc
   46F3 CD C6 3F      [17]  233 	call	_print_transparent_text
   46F6 F1            [10]  234 	pop	af
   46F7 F1            [10]  235 	pop	af
   46F8 33            [ 6]  236 	inc	sp
   46F9 33            [ 6]  237 	inc	sp
   46FA DD E1         [14]  238 	pop	ix
   46FC C9            [10]  239 	ret
                            240 ;src/UI_LoadGame.c:94: void ui_loadgame_render_all(){
                            241 ;	---------------------------------
                            242 ; Function ui_loadgame_render_all
                            243 ; ---------------------------------
   46FD                     244 _ui_loadgame_render_all::
                            245 ;src/UI_LoadGame.c:97: cpct_drawSolidBox(UI_LOADGAME_STRING_POSITION, g_colors[1], 36,6);
   46FD 21 B0 1A      [10]  246 	ld	hl, #(_g_colors + 0x0001) + 0
   4700 46            [ 7]  247 	ld	b,(hl)
   4701 21 24 06      [10]  248 	ld	hl,#0x0624
   4704 E5            [11]  249 	push	hl
   4705 C5            [11]  250 	push	bc
   4706 33            [ 6]  251 	inc	sp
   4707 21 86 DB      [10]  252 	ld	hl,#0xDB86
   470A E5            [11]  253 	push	hl
   470B CD B8 7B      [17]  254 	call	_cpct_drawSolidBox
   470E F1            [10]  255 	pop	af
   470F F1            [10]  256 	pop	af
   4710 33            [ 6]  257 	inc	sp
                            258 ;src/UI_LoadGame.c:98: print_text(ui_stringinput_get_string(),UI_LOADGAME_STRING_POSITION, 1,3);
   4711 CD 6B 3C      [17]  259 	call	_ui_stringinput_get_string
   4714 4D            [ 4]  260 	ld	c,l
   4715 44            [ 4]  261 	ld	b,h
   4716 21 01 03      [10]  262 	ld	hl,#0x0301
   4719 E5            [11]  263 	push	hl
   471A 21 86 DB      [10]  264 	ld	hl,#0xDB86
   471D E5            [11]  265 	push	hl
   471E C5            [11]  266 	push	bc
   471F CD EB 3D      [17]  267 	call	_print_text
   4722 21 06 00      [10]  268 	ld	hl,#6
   4725 39            [11]  269 	add	hl,sp
   4726 F9            [ 6]  270 	ld	sp,hl
                            271 ;src/UI_LoadGame.c:100: while(n){
   4727 06 02         [ 7]  272 	ld	b,#0x02
   4729                     273 00101$:
   4729 78            [ 4]  274 	ld	a,b
   472A B7            [ 4]  275 	or	a, a
   472B 28 0B         [12]  276 	jr	Z,00103$
                            277 ;src/UI_LoadGame.c:101: --n;
   472D 05            [ 4]  278 	dec	b
                            279 ;src/UI_LoadGame.c:102: ui_loadgame_render_button(n);
   472E C5            [11]  280 	push	bc
   472F C5            [11]  281 	push	bc
   4730 33            [ 6]  282 	inc	sp
   4731 CD 93 46      [17]  283 	call	_ui_loadgame_render_button
   4734 33            [ 6]  284 	inc	sp
   4735 C1            [10]  285 	pop	bc
   4736 18 F1         [12]  286 	jr	00101$
   4738                     287 00103$:
                            288 ;src/UI_LoadGame.c:105: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
   4738 3A D1 7D      [13]  289 	ld	a,(#_ui_loadgame_entryIndex + 0)
   473B 32 D0 7D      [13]  290 	ld	(#_ui_loadgame_lastEntry + 0),a
   473E C9            [10]  291 	ret
                            292 	.area _CODE
                            293 	.area _INITIALIZER
                            294 	.area _CABS (ABS)
