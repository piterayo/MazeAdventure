                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_PauseMenu
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_pausemenu_render_button
                             12 	.globl _print_transparent_text
                             13 	.globl _cpct_drawSolidBox
                             14 	.globl _ui_pausemenu_entrySelected
                             15 	.globl _ui_pausemenu_entryIndex
                             16 	.globl _ui_pausemenu_lastEntry
                             17 	.globl _ui_pausemenu_buttonText
                             18 	.globl _ui_pausemenu_entriesTextPosition
                             19 	.globl _ui_pausemenu_entriesPosition
                             20 	.globl _ui_pausemenu_init
                             21 	.globl _ui_pausemenu_get_entry
                             22 	.globl _ui_pausemenu_is_selected
                             23 	.globl _ui_pausemenu_next_entry
                             24 	.globl _ui_pausemenu_previous_entry
                             25 	.globl _ui_pausemenu_select_entry
                             26 	.globl _ui_pausemenu_unselect_entry
                             27 	.globl _ui_pausemenu_render_refresh
                             28 	.globl _ui_pausemenu_render_all
                             29 ;--------------------------------------------------------
                             30 ; special function registers
                             31 ;--------------------------------------------------------
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _DATA
   87A4                      36 _ui_pausemenu_lastEntry::
   87A4                      37 	.ds 1
   87A5                      38 _ui_pausemenu_entryIndex::
   87A5                      39 	.ds 1
   87A6                      40 _ui_pausemenu_entrySelected::
   87A6                      41 	.ds 1
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
                             66 ;src/UI_PauseMenu.c:55: void ui_pausemenu_init(){
                             67 ;	---------------------------------
                             68 ; Function ui_pausemenu_init
                             69 ; ---------------------------------
   4C12                      70 _ui_pausemenu_init::
                             71 ;src/UI_PauseMenu.c:56: ui_pausemenu_lastEntry=0;
   4C12 21 A4 87      [10]   72 	ld	hl,#_ui_pausemenu_lastEntry + 0
   4C15 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_PauseMenu.c:57: ui_pausemenu_entryIndex=0;
   4C17 21 A5 87      [10]   75 	ld	hl,#_ui_pausemenu_entryIndex + 0
   4C1A 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_PauseMenu.c:58: ui_pausemenu_entrySelected=0;
   4C1C 21 A6 87      [10]   78 	ld	hl,#_ui_pausemenu_entrySelected + 0
   4C1F 36 00         [10]   79 	ld	(hl), #0x00
   4C21 C9            [10]   80 	ret
   4C22                      81 _ui_pausemenu_entriesPosition:
   4C22 AA C1                82 	.dw #0xC1AA
   4C24 EA C2                83 	.dw #0xC2EA
   4C26 2A C4                84 	.dw #0xC42A
   4C28 6A C5                85 	.dw #0xC56A
   4C2A                      86 _ui_pausemenu_entriesTextPosition:
   4C2A 00 CA                87 	.dw #0xCA00
   4C2C 42 CB                88 	.dw #0xCB42
   4C2E 7B CC                89 	.dw #0xCC7B
   4C30 C4 CD                90 	.dw #0xCDC4
   4C32                      91 _ui_pausemenu_buttonText:
   4C32 3A 4C                92 	.dw __str_0
   4C34 43 4C                93 	.dw __str_1
   4C36 4B 4C                94 	.dw __str_2
   4C38 59 4C                95 	.dw __str_3
   4C3A                      96 __str_0:
   4C3A 43 4F 4E 54 49 4E    97 	.ascii "CONTINUE"
        55 45
   4C42 00                   98 	.db 0x00
   4C43                      99 __str_1:
   4C43 4F 50 54 49 4F 4E   100 	.ascii "OPTIONS"
        53
   4C4A 00                  101 	.db 0x00
   4C4B                     102 __str_2:
   4C4B 53 41 56 45 20 41   103 	.ascii "SAVE AND EXIT"
        4E 44 20 45 58 49
        54
   4C58 00                  104 	.db 0x00
   4C59                     105 __str_3:
   4C59 45 58 49 54         106 	.ascii "EXIT"
   4C5D 00                  107 	.db 0x00
                            108 ;src/UI_PauseMenu.c:61: u8 ui_pausemenu_get_entry(){
                            109 ;	---------------------------------
                            110 ; Function ui_pausemenu_get_entry
                            111 ; ---------------------------------
   4C5E                     112 _ui_pausemenu_get_entry::
                            113 ;src/UI_PauseMenu.c:62: return ui_pausemenu_entryIndex;
   4C5E FD 21 A5 87   [14]  114 	ld	iy,#_ui_pausemenu_entryIndex
   4C62 FD 6E 00      [19]  115 	ld	l,0 (iy)
   4C65 C9            [10]  116 	ret
                            117 ;src/UI_PauseMenu.c:65: u8 ui_pausemenu_is_selected(){
                            118 ;	---------------------------------
                            119 ; Function ui_pausemenu_is_selected
                            120 ; ---------------------------------
   4C66                     121 _ui_pausemenu_is_selected::
                            122 ;src/UI_PauseMenu.c:66: return ui_pausemenu_entrySelected;
   4C66 FD 21 A6 87   [14]  123 	ld	iy,#_ui_pausemenu_entrySelected
   4C6A FD 6E 00      [19]  124 	ld	l,0 (iy)
   4C6D C9            [10]  125 	ret
                            126 ;src/UI_PauseMenu.c:69: void ui_pausemenu_next_entry(){
                            127 ;	---------------------------------
                            128 ; Function ui_pausemenu_next_entry
                            129 ; ---------------------------------
   4C6E                     130 _ui_pausemenu_next_entry::
                            131 ;src/UI_PauseMenu.c:70: if(ui_pausemenu_entryIndex<(UI_PAUSEMENU_ENTRIES-1)){
                            132 ;src/UI_PauseMenu.c:71: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4C6E 3A A5 87      [13]  133 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4C71 FE 03         [ 7]  134 	cp	a,#0x03
   4C73 D0            [11]  135 	ret	NC
   4C74 32 A4 87      [13]  136 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            137 ;src/UI_PauseMenu.c:72: ++ui_pausemenu_entryIndex;
   4C77 21 A5 87      [10]  138 	ld	hl, #_ui_pausemenu_entryIndex+0
   4C7A 34            [11]  139 	inc	(hl)
   4C7B C9            [10]  140 	ret
                            141 ;src/UI_PauseMenu.c:76: void ui_pausemenu_previous_entry(){
                            142 ;	---------------------------------
                            143 ; Function ui_pausemenu_previous_entry
                            144 ; ---------------------------------
   4C7C                     145 _ui_pausemenu_previous_entry::
                            146 ;src/UI_PauseMenu.c:77: if(ui_pausemenu_entryIndex>0){
   4C7C 3A A5 87      [13]  147 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4C7F B7            [ 4]  148 	or	a, a
   4C80 C8            [11]  149 	ret	Z
                            150 ;src/UI_PauseMenu.c:78: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4C81 3A A5 87      [13]  151 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4C84 32 A4 87      [13]  152 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            153 ;src/UI_PauseMenu.c:79: --ui_pausemenu_entryIndex;
   4C87 21 A5 87      [10]  154 	ld	hl, #_ui_pausemenu_entryIndex+0
   4C8A 35            [11]  155 	dec	(hl)
   4C8B C9            [10]  156 	ret
                            157 ;src/UI_PauseMenu.c:83: void ui_pausemenu_select_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_pausemenu_select_entry
                            160 ; ---------------------------------
   4C8C                     161 _ui_pausemenu_select_entry::
                            162 ;src/UI_PauseMenu.c:84: ui_pausemenu_entrySelected=1;
   4C8C 21 A6 87      [10]  163 	ld	hl,#_ui_pausemenu_entrySelected + 0
   4C8F 36 01         [10]  164 	ld	(hl), #0x01
   4C91 C9            [10]  165 	ret
                            166 ;src/UI_PauseMenu.c:87: void ui_pausemenu_unselect_entry(){
                            167 ;	---------------------------------
                            168 ; Function ui_pausemenu_unselect_entry
                            169 ; ---------------------------------
   4C92                     170 _ui_pausemenu_unselect_entry::
                            171 ;src/UI_PauseMenu.c:88: ui_pausemenu_entrySelected=0;
   4C92 21 A6 87      [10]  172 	ld	hl,#_ui_pausemenu_entrySelected + 0
   4C95 36 00         [10]  173 	ld	(hl), #0x00
   4C97 C9            [10]  174 	ret
                            175 ;src/UI_PauseMenu.c:91: void ui_pausemenu_render_button(u8 n){
                            176 ;	---------------------------------
                            177 ; Function ui_pausemenu_render_button
                            178 ; ---------------------------------
   4C98                     179 _ui_pausemenu_render_button::
   4C98 DD E5         [15]  180 	push	ix
   4C9A DD 21 00 00   [14]  181 	ld	ix,#0
   4C9E DD 39         [15]  182 	add	ix,sp
   4CA0 3B            [ 6]  183 	dec	sp
                            184 ;src/UI_PauseMenu.c:93: color = (n==ui_pausemenu_entryIndex)?((ui_pausemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4CA1 DD 7E 04      [19]  185 	ld	a,4 (ix)
   4CA4 FD 21 A5 87   [14]  186 	ld	iy,#_ui_pausemenu_entryIndex
   4CA8 FD 96 00      [19]  187 	sub	a, 0 (iy)
   4CAB 20 10         [12]  188 	jr	NZ,00103$
   4CAD 3A A6 87      [13]  189 	ld	a,(#_ui_pausemenu_entrySelected + 0)
   4CB0 B7            [ 4]  190 	or	a, a
   4CB1 28 05         [12]  191 	jr	Z,00105$
   4CB3 3A 2C 1C      [13]  192 	ld	a, (#(_g_colors + 0x0004) + 0)
   4CB6 18 08         [12]  193 	jr	00104$
   4CB8                     194 00105$:
   4CB8 3A 2E 1C      [13]  195 	ld	a, (#(_g_colors + 0x0006) + 0)
   4CBB 18 03         [12]  196 	jr	00104$
   4CBD                     197 00103$:
   4CBD 3A 2A 1C      [13]  198 	ld	a, (#(_g_colors + 0x0002) + 0)
   4CC0                     199 00104$:
   4CC0 DD 77 FF      [19]  200 	ld	-1 (ix),a
                            201 ;src/UI_PauseMenu.c:94: cpct_drawSolidBox(ui_pausemenu_entriesPosition[n],color, UI_PAUSEMENU_BUTTON_WIDTH, UI_PAUSEMENU_BUTTON_HEIGHT);
   4CC3 DD 6E 04      [19]  202 	ld	l,4 (ix)
   4CC6 26 00         [ 7]  203 	ld	h,#0x00
   4CC8 29            [11]  204 	add	hl, hl
   4CC9 4D            [ 4]  205 	ld	c, l
   4CCA 44            [ 4]  206 	ld	b, h
   4CCB 21 22 4C      [10]  207 	ld	hl,#_ui_pausemenu_entriesPosition
   4CCE 09            [11]  208 	add	hl,bc
   4CCF 5E            [ 7]  209 	ld	e,(hl)
   4CD0 23            [ 6]  210 	inc	hl
   4CD1 56            [ 7]  211 	ld	d,(hl)
   4CD2 C5            [11]  212 	push	bc
   4CD3 21 1C 18      [10]  213 	ld	hl,#0x181C
   4CD6 E5            [11]  214 	push	hl
   4CD7 DD 7E FF      [19]  215 	ld	a,-1 (ix)
   4CDA F5            [11]  216 	push	af
   4CDB 33            [ 6]  217 	inc	sp
   4CDC D5            [11]  218 	push	de
   4CDD CD 2F 85      [17]  219 	call	_cpct_drawSolidBox
   4CE0 F1            [10]  220 	pop	af
   4CE1 F1            [10]  221 	pop	af
   4CE2 33            [ 6]  222 	inc	sp
   4CE3 C1            [10]  223 	pop	bc
                            224 ;src/UI_PauseMenu.c:95: print_transparent_text(ui_pausemenu_buttonText[n], ui_pausemenu_entriesTextPosition[n], 3);
   4CE4 21 2A 4C      [10]  225 	ld	hl,#_ui_pausemenu_entriesTextPosition
   4CE7 09            [11]  226 	add	hl,bc
   4CE8 5E            [ 7]  227 	ld	e,(hl)
   4CE9 23            [ 6]  228 	inc	hl
   4CEA 56            [ 7]  229 	ld	d,(hl)
   4CEB 21 32 4C      [10]  230 	ld	hl,#_ui_pausemenu_buttonText
   4CEE 09            [11]  231 	add	hl,bc
   4CEF 4E            [ 7]  232 	ld	c,(hl)
   4CF0 23            [ 6]  233 	inc	hl
   4CF1 46            [ 7]  234 	ld	b,(hl)
   4CF2 3E 03         [ 7]  235 	ld	a,#0x03
   4CF4 F5            [11]  236 	push	af
   4CF5 33            [ 6]  237 	inc	sp
   4CF6 D5            [11]  238 	push	de
   4CF7 C5            [11]  239 	push	bc
   4CF8 CD 14 41      [17]  240 	call	_print_transparent_text
   4CFB F1            [10]  241 	pop	af
   4CFC F1            [10]  242 	pop	af
   4CFD 33            [ 6]  243 	inc	sp
   4CFE 33            [ 6]  244 	inc	sp
   4CFF DD E1         [14]  245 	pop	ix
   4D01 C9            [10]  246 	ret
                            247 ;src/UI_PauseMenu.c:98: void ui_pausemenu_render_refresh(){
                            248 ;	---------------------------------
                            249 ; Function ui_pausemenu_render_refresh
                            250 ; ---------------------------------
   4D02                     251 _ui_pausemenu_render_refresh::
                            252 ;src/UI_PauseMenu.c:100: ui_pausemenu_render_button(ui_pausemenu_entryIndex);
   4D02 3A A5 87      [13]  253 	ld	a,(_ui_pausemenu_entryIndex)
   4D05 F5            [11]  254 	push	af
   4D06 33            [ 6]  255 	inc	sp
   4D07 CD 98 4C      [17]  256 	call	_ui_pausemenu_render_button
   4D0A 33            [ 6]  257 	inc	sp
                            258 ;src/UI_PauseMenu.c:101: ui_pausemenu_render_button(ui_pausemenu_lastEntry);
   4D0B 3A A4 87      [13]  259 	ld	a,(_ui_pausemenu_lastEntry)
   4D0E F5            [11]  260 	push	af
   4D0F 33            [ 6]  261 	inc	sp
   4D10 CD 98 4C      [17]  262 	call	_ui_pausemenu_render_button
   4D13 33            [ 6]  263 	inc	sp
                            264 ;src/UI_PauseMenu.c:103: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4D14 3A A5 87      [13]  265 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4D17 32 A4 87      [13]  266 	ld	(#_ui_pausemenu_lastEntry + 0),a
   4D1A C9            [10]  267 	ret
                            268 ;src/UI_PauseMenu.c:106: void ui_pausemenu_render_all(){
                            269 ;	---------------------------------
                            270 ; Function ui_pausemenu_render_all
                            271 ; ---------------------------------
   4D1B                     272 _ui_pausemenu_render_all::
                            273 ;src/UI_PauseMenu.c:110: while(n){
   4D1B 06 04         [ 7]  274 	ld	b,#0x04
   4D1D                     275 00101$:
   4D1D 78            [ 4]  276 	ld	a,b
   4D1E B7            [ 4]  277 	or	a, a
   4D1F 28 0B         [12]  278 	jr	Z,00103$
                            279 ;src/UI_PauseMenu.c:111: --n;
   4D21 05            [ 4]  280 	dec	b
                            281 ;src/UI_PauseMenu.c:112: ui_pausemenu_render_button(n);
   4D22 C5            [11]  282 	push	bc
   4D23 C5            [11]  283 	push	bc
   4D24 33            [ 6]  284 	inc	sp
   4D25 CD 98 4C      [17]  285 	call	_ui_pausemenu_render_button
   4D28 33            [ 6]  286 	inc	sp
   4D29 C1            [10]  287 	pop	bc
   4D2A 18 F1         [12]  288 	jr	00101$
   4D2C                     289 00103$:
                            290 ;src/UI_PauseMenu.c:115: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4D2C 3A A5 87      [13]  291 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4D2F 32 A4 87      [13]  292 	ld	(#_ui_pausemenu_lastEntry + 0),a
   4D32 C9            [10]  293 	ret
                            294 	.area _CODE
                            295 	.area _INITIALIZER
                            296 	.area _CABS (ABS)
