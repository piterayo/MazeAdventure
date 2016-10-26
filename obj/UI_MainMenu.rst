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
   879E                      36 _ui_mainmenu_lastEntry::
   879E                      37 	.ds 1
   879F                      38 _ui_mainmenu_entryIndex::
   879F                      39 	.ds 1
   87A0                      40 _ui_mainmenu_entrySelected::
   87A0                      41 	.ds 1
                             42 ;--------------------------------------------------------
                             43 ; ram data
                             44 ;--------------------------------------------------------
                             45 	.area _INITIALIZED
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
                             66 ;src/UI_MainMenu.c:53: void ui_mainmenu_init(){
                             67 ;	---------------------------------
                             68 ; Function ui_mainmenu_init
                             69 ; ---------------------------------
   498D                      70 _ui_mainmenu_init::
                             71 ;src/UI_MainMenu.c:54: ui_mainmenu_lastEntry=0;
   498D 21 9E 87      [10]   72 	ld	hl,#_ui_mainmenu_lastEntry + 0
   4990 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_MainMenu.c:55: ui_mainmenu_entryIndex=0;
   4992 21 9F 87      [10]   75 	ld	hl,#_ui_mainmenu_entryIndex + 0
   4995 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_MainMenu.c:56: ui_mainmenu_entrySelected=0;
   4997 21 A0 87      [10]   78 	ld	hl,#_ui_mainmenu_entrySelected + 0
   499A 36 00         [10]   79 	ld	(hl), #0x00
   499C C9            [10]   80 	ret
   499D                      81 _ui_mainmenu_entriesPosition:
   499D 1E E0                82 	.dw #0xE01E
   499F 0E C1                83 	.dw #0xC10E
   49A1 AE E1                84 	.dw #0xE1AE
   49A3 9E C2                85 	.dw #0xC29E
   49A5                      86 _ui_mainmenu_entriesTextPosition:
   49A5 70 C8                87 	.dw #0xC870
   49A7 0F E9                88 	.dw #0xE90F
   49A9 01 CA                89 	.dw #0xCA01
   49AB A1 EA                90 	.dw #0xEAA1
   49AD                      91 _ui_mainmenu_buttonText:
   49AD B5 49                92 	.dw __str_0
   49AF BE 49                93 	.dw __str_1
   49B1 C8 49                94 	.dw __str_2
   49B3 D0 49                95 	.dw __str_3
   49B5                      96 __str_0:
   49B5 4E 45 57 20 47 41    97 	.ascii "NEW GAME"
        4D 45
   49BD 00                   98 	.db 0x00
   49BE                      99 __str_1:
   49BE 4C 4F 41 44 20 47   100 	.ascii "LOAD GAME"
        41 4D 45
   49C7 00                  101 	.db 0x00
   49C8                     102 __str_2:
   49C8 4F 50 54 49 4F 4E   103 	.ascii "OPTIONS"
        53
   49CF 00                  104 	.db 0x00
   49D0                     105 __str_3:
   49D0 43 52 45 44 49 54   106 	.ascii "CREDITS"
        53
   49D7 00                  107 	.db 0x00
                            108 ;src/UI_MainMenu.c:59: void ui_mainmenu_next_entry(){
                            109 ;	---------------------------------
                            110 ; Function ui_mainmenu_next_entry
                            111 ; ---------------------------------
   49D8                     112 _ui_mainmenu_next_entry::
                            113 ;src/UI_MainMenu.c:60: if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
                            114 ;src/UI_MainMenu.c:61: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   49D8 3A 9F 87      [13]  115 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   49DB FE 03         [ 7]  116 	cp	a,#0x03
   49DD D0            [11]  117 	ret	NC
   49DE 32 9E 87      [13]  118 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            119 ;src/UI_MainMenu.c:62: ++ui_mainmenu_entryIndex;
   49E1 21 9F 87      [10]  120 	ld	hl, #_ui_mainmenu_entryIndex+0
   49E4 34            [11]  121 	inc	(hl)
   49E5 C9            [10]  122 	ret
                            123 ;src/UI_MainMenu.c:66: void ui_mainmenu_previous_entry(){
                            124 ;	---------------------------------
                            125 ; Function ui_mainmenu_previous_entry
                            126 ; ---------------------------------
   49E6                     127 _ui_mainmenu_previous_entry::
                            128 ;src/UI_MainMenu.c:67: if(ui_mainmenu_entryIndex>0){
   49E6 3A 9F 87      [13]  129 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   49E9 B7            [ 4]  130 	or	a, a
   49EA C8            [11]  131 	ret	Z
                            132 ;src/UI_MainMenu.c:68: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   49EB 3A 9F 87      [13]  133 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   49EE 32 9E 87      [13]  134 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            135 ;src/UI_MainMenu.c:69: --ui_mainmenu_entryIndex;
   49F1 21 9F 87      [10]  136 	ld	hl, #_ui_mainmenu_entryIndex+0
   49F4 35            [11]  137 	dec	(hl)
   49F5 C9            [10]  138 	ret
                            139 ;src/UI_MainMenu.c:73: void ui_mainmenu_unselect_entry(){
                            140 ;	---------------------------------
                            141 ; Function ui_mainmenu_unselect_entry
                            142 ; ---------------------------------
   49F6                     143 _ui_mainmenu_unselect_entry::
                            144 ;src/UI_MainMenu.c:74: ui_mainmenu_entrySelected=0;
   49F6 21 A0 87      [10]  145 	ld	hl,#_ui_mainmenu_entrySelected + 0
   49F9 36 00         [10]  146 	ld	(hl), #0x00
   49FB C9            [10]  147 	ret
                            148 ;src/UI_MainMenu.c:77: void ui_mainmenu_select_entry(){
                            149 ;	---------------------------------
                            150 ; Function ui_mainmenu_select_entry
                            151 ; ---------------------------------
   49FC                     152 _ui_mainmenu_select_entry::
                            153 ;src/UI_MainMenu.c:78: ui_mainmenu_entrySelected=1;
   49FC 21 A0 87      [10]  154 	ld	hl,#_ui_mainmenu_entrySelected + 0
   49FF 36 01         [10]  155 	ld	(hl), #0x01
   4A01 C9            [10]  156 	ret
                            157 ;src/UI_MainMenu.c:81: void ui_mainmenu_render_button(u8 n){
                            158 ;	---------------------------------
                            159 ; Function ui_mainmenu_render_button
                            160 ; ---------------------------------
   4A02                     161 _ui_mainmenu_render_button::
   4A02 DD E5         [15]  162 	push	ix
   4A04 DD 21 00 00   [14]  163 	ld	ix,#0
   4A08 DD 39         [15]  164 	add	ix,sp
   4A0A 3B            [ 6]  165 	dec	sp
                            166 ;src/UI_MainMenu.c:83: color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4A0B DD 7E 04      [19]  167 	ld	a,4 (ix)
   4A0E FD 21 9F 87   [14]  168 	ld	iy,#_ui_mainmenu_entryIndex
   4A12 FD 96 00      [19]  169 	sub	a, 0 (iy)
   4A15 20 10         [12]  170 	jr	NZ,00103$
   4A17 3A A0 87      [13]  171 	ld	a,(#_ui_mainmenu_entrySelected + 0)
   4A1A B7            [ 4]  172 	or	a, a
   4A1B 28 05         [12]  173 	jr	Z,00105$
   4A1D 3A 2C 1C      [13]  174 	ld	a, (#(_g_colors + 0x0004) + 0)
   4A20 18 08         [12]  175 	jr	00104$
   4A22                     176 00105$:
   4A22 3A 2E 1C      [13]  177 	ld	a, (#(_g_colors + 0x0006) + 0)
   4A25 18 03         [12]  178 	jr	00104$
   4A27                     179 00103$:
   4A27 3A 2A 1C      [13]  180 	ld	a, (#(_g_colors + 0x0002) + 0)
   4A2A                     181 00104$:
   4A2A DD 77 FF      [19]  182 	ld	-1 (ix),a
                            183 ;src/UI_MainMenu.c:84: cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, UI_MAINMENU_BUTTON_WIDTH, UI_MAINMENU_BUTTON_HEIGHT);
   4A2D DD 6E 04      [19]  184 	ld	l,4 (ix)
   4A30 26 00         [ 7]  185 	ld	h,#0x00
   4A32 29            [11]  186 	add	hl, hl
   4A33 4D            [ 4]  187 	ld	c, l
   4A34 44            [ 4]  188 	ld	b, h
   4A35 21 9D 49      [10]  189 	ld	hl,#_ui_mainmenu_entriesPosition
   4A38 09            [11]  190 	add	hl,bc
   4A39 5E            [ 7]  191 	ld	e,(hl)
   4A3A 23            [ 6]  192 	inc	hl
   4A3B 56            [ 7]  193 	ld	d,(hl)
   4A3C C5            [11]  194 	push	bc
   4A3D 21 14 10      [10]  195 	ld	hl,#0x1014
   4A40 E5            [11]  196 	push	hl
   4A41 DD 7E FF      [19]  197 	ld	a,-1 (ix)
   4A44 F5            [11]  198 	push	af
   4A45 33            [ 6]  199 	inc	sp
   4A46 D5            [11]  200 	push	de
   4A47 CD 2F 85      [17]  201 	call	_cpct_drawSolidBox
   4A4A F1            [10]  202 	pop	af
   4A4B F1            [10]  203 	pop	af
   4A4C 33            [ 6]  204 	inc	sp
   4A4D C1            [10]  205 	pop	bc
                            206 ;src/UI_MainMenu.c:85: print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesTextPosition[n], 3);
   4A4E 21 A5 49      [10]  207 	ld	hl,#_ui_mainmenu_entriesTextPosition
   4A51 09            [11]  208 	add	hl,bc
   4A52 5E            [ 7]  209 	ld	e,(hl)
   4A53 23            [ 6]  210 	inc	hl
   4A54 56            [ 7]  211 	ld	d,(hl)
   4A55 21 AD 49      [10]  212 	ld	hl,#_ui_mainmenu_buttonText
   4A58 09            [11]  213 	add	hl,bc
   4A59 4E            [ 7]  214 	ld	c,(hl)
   4A5A 23            [ 6]  215 	inc	hl
   4A5B 46            [ 7]  216 	ld	b,(hl)
   4A5C 3E 03         [ 7]  217 	ld	a,#0x03
   4A5E F5            [11]  218 	push	af
   4A5F 33            [ 6]  219 	inc	sp
   4A60 D5            [11]  220 	push	de
   4A61 C5            [11]  221 	push	bc
   4A62 CD 14 41      [17]  222 	call	_print_transparent_text
   4A65 F1            [10]  223 	pop	af
   4A66 F1            [10]  224 	pop	af
   4A67 33            [ 6]  225 	inc	sp
   4A68 33            [ 6]  226 	inc	sp
   4A69 DD E1         [14]  227 	pop	ix
   4A6B C9            [10]  228 	ret
                            229 ;src/UI_MainMenu.c:88: void ui_mainmenu_render_refresh(){
                            230 ;	---------------------------------
                            231 ; Function ui_mainmenu_render_refresh
                            232 ; ---------------------------------
   4A6C                     233 _ui_mainmenu_render_refresh::
                            234 ;src/UI_MainMenu.c:90: ui_mainmenu_render_button(ui_mainmenu_entryIndex);
   4A6C 3A 9F 87      [13]  235 	ld	a,(_ui_mainmenu_entryIndex)
   4A6F F5            [11]  236 	push	af
   4A70 33            [ 6]  237 	inc	sp
   4A71 CD 02 4A      [17]  238 	call	_ui_mainmenu_render_button
   4A74 33            [ 6]  239 	inc	sp
                            240 ;src/UI_MainMenu.c:91: ui_mainmenu_render_button(ui_mainmenu_lastEntry);
   4A75 3A 9E 87      [13]  241 	ld	a,(_ui_mainmenu_lastEntry)
   4A78 F5            [11]  242 	push	af
   4A79 33            [ 6]  243 	inc	sp
   4A7A CD 02 4A      [17]  244 	call	_ui_mainmenu_render_button
   4A7D 33            [ 6]  245 	inc	sp
                            246 ;src/UI_MainMenu.c:93: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   4A7E 3A 9F 87      [13]  247 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   4A81 32 9E 87      [13]  248 	ld	(#_ui_mainmenu_lastEntry + 0),a
   4A84 C9            [10]  249 	ret
                            250 ;src/UI_MainMenu.c:97: void ui_mainmenu_render_all(){
                            251 ;	---------------------------------
                            252 ; Function ui_mainmenu_render_all
                            253 ; ---------------------------------
   4A85                     254 _ui_mainmenu_render_all::
                            255 ;src/UI_MainMenu.c:101: while(n){
   4A85 06 04         [ 7]  256 	ld	b,#0x04
   4A87                     257 00101$:
   4A87 78            [ 4]  258 	ld	a,b
   4A88 B7            [ 4]  259 	or	a, a
   4A89 28 0B         [12]  260 	jr	Z,00103$
                            261 ;src/UI_MainMenu.c:102: --n;
   4A8B 05            [ 4]  262 	dec	b
                            263 ;src/UI_MainMenu.c:103: ui_mainmenu_render_button(n);
   4A8C C5            [11]  264 	push	bc
   4A8D C5            [11]  265 	push	bc
   4A8E 33            [ 6]  266 	inc	sp
   4A8F CD 02 4A      [17]  267 	call	_ui_mainmenu_render_button
   4A92 33            [ 6]  268 	inc	sp
   4A93 C1            [10]  269 	pop	bc
   4A94 18 F1         [12]  270 	jr	00101$
   4A96                     271 00103$:
                            272 ;src/UI_MainMenu.c:106: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   4A96 3A 9F 87      [13]  273 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   4A99 32 9E 87      [13]  274 	ld	(#_ui_mainmenu_lastEntry + 0),a
   4A9C C9            [10]  275 	ret
                            276 ;src/UI_MainMenu.c:109: u8 ui_mainmenu_get_entry(){
                            277 ;	---------------------------------
                            278 ; Function ui_mainmenu_get_entry
                            279 ; ---------------------------------
   4A9D                     280 _ui_mainmenu_get_entry::
                            281 ;src/UI_MainMenu.c:110: return ui_mainmenu_entryIndex;
   4A9D FD 21 9F 87   [14]  282 	ld	iy,#_ui_mainmenu_entryIndex
   4AA1 FD 6E 00      [19]  283 	ld	l,0 (iy)
   4AA4 C9            [10]  284 	ret
                            285 ;src/UI_MainMenu.c:113: u8 ui_mainmenu_is_selected(){
                            286 ;	---------------------------------
                            287 ; Function ui_mainmenu_is_selected
                            288 ; ---------------------------------
   4AA5                     289 _ui_mainmenu_is_selected::
                            290 ;src/UI_MainMenu.c:114: return ui_mainmenu_entrySelected;
   4AA5 FD 21 A0 87   [14]  291 	ld	iy,#_ui_mainmenu_entrySelected
   4AA9 FD 6E 00      [19]  292 	ld	l,0 (iy)
   4AAC C9            [10]  293 	ret
                            294 	.area _CODE
                            295 	.area _INITIALIZER
                            296 	.area _CABS (ABS)
