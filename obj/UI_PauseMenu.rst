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
   7E2A                      36 _ui_pausemenu_lastEntry::
   7E2A                      37 	.ds 1
   7E2B                      38 _ui_pausemenu_entryIndex::
   7E2B                      39 	.ds 1
   7E2C                      40 _ui_pausemenu_entrySelected::
   7E2C                      41 	.ds 1
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
   4AC4                      70 _ui_pausemenu_init::
                             71 ;src/UI_PauseMenu.c:56: ui_pausemenu_lastEntry=0;
   4AC4 21 2A 7E      [10]   72 	ld	hl,#_ui_pausemenu_lastEntry + 0
   4AC7 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_PauseMenu.c:57: ui_pausemenu_entryIndex=0;
   4AC9 21 2B 7E      [10]   75 	ld	hl,#_ui_pausemenu_entryIndex + 0
   4ACC 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_PauseMenu.c:58: ui_pausemenu_entrySelected=0;
   4ACE 21 2C 7E      [10]   78 	ld	hl,#_ui_pausemenu_entrySelected + 0
   4AD1 36 00         [10]   79 	ld	(hl), #0x00
   4AD3 C9            [10]   80 	ret
   4AD4                      81 _ui_pausemenu_entriesPosition:
   4AD4 AA C1                82 	.dw #0xC1AA
   4AD6 EA C2                83 	.dw #0xC2EA
   4AD8 2A C4                84 	.dw #0xC42A
   4ADA 6A C5                85 	.dw #0xC56A
   4ADC                      86 _ui_pausemenu_entriesTextPosition:
   4ADC 00 CA                87 	.dw #0xCA00
   4ADE 42 CB                88 	.dw #0xCB42
   4AE0 7B CC                89 	.dw #0xCC7B
   4AE2 C4 CD                90 	.dw #0xCDC4
   4AE4                      91 _ui_pausemenu_buttonText:
   4AE4 EC 4A                92 	.dw __str_0
   4AE6 F5 4A                93 	.dw __str_1
   4AE8 FD 4A                94 	.dw __str_2
   4AEA 0B 4B                95 	.dw __str_3
   4AEC                      96 __str_0:
   4AEC 43 4F 4E 54 49 4E    97 	.ascii "CONTINUE"
        55 45
   4AF4 00                   98 	.db 0x00
   4AF5                      99 __str_1:
   4AF5 4F 50 54 49 4F 4E   100 	.ascii "OPTIONS"
        53
   4AFC 00                  101 	.db 0x00
   4AFD                     102 __str_2:
   4AFD 53 41 56 45 20 41   103 	.ascii "SAVE AND EXIT"
        4E 44 20 45 58 49
        54
   4B0A 00                  104 	.db 0x00
   4B0B                     105 __str_3:
   4B0B 45 58 49 54         106 	.ascii "EXIT"
   4B0F 00                  107 	.db 0x00
                            108 ;src/UI_PauseMenu.c:61: u8 ui_pausemenu_get_entry(){
                            109 ;	---------------------------------
                            110 ; Function ui_pausemenu_get_entry
                            111 ; ---------------------------------
   4B10                     112 _ui_pausemenu_get_entry::
                            113 ;src/UI_PauseMenu.c:62: return ui_pausemenu_entryIndex;
   4B10 FD 21 2B 7E   [14]  114 	ld	iy,#_ui_pausemenu_entryIndex
   4B14 FD 6E 00      [19]  115 	ld	l,0 (iy)
   4B17 C9            [10]  116 	ret
                            117 ;src/UI_PauseMenu.c:65: u8 ui_pausemenu_is_selected(){
                            118 ;	---------------------------------
                            119 ; Function ui_pausemenu_is_selected
                            120 ; ---------------------------------
   4B18                     121 _ui_pausemenu_is_selected::
                            122 ;src/UI_PauseMenu.c:66: return ui_pausemenu_entrySelected;
   4B18 FD 21 2C 7E   [14]  123 	ld	iy,#_ui_pausemenu_entrySelected
   4B1C FD 6E 00      [19]  124 	ld	l,0 (iy)
   4B1F C9            [10]  125 	ret
                            126 ;src/UI_PauseMenu.c:69: void ui_pausemenu_next_entry(){
                            127 ;	---------------------------------
                            128 ; Function ui_pausemenu_next_entry
                            129 ; ---------------------------------
   4B20                     130 _ui_pausemenu_next_entry::
                            131 ;src/UI_PauseMenu.c:70: if(ui_pausemenu_entryIndex<(UI_PAUSEMENU_ENTRIES-1)){
                            132 ;src/UI_PauseMenu.c:71: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4B20 3A 2B 7E      [13]  133 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4B23 FE 03         [ 7]  134 	cp	a,#0x03
   4B25 D0            [11]  135 	ret	NC
   4B26 32 2A 7E      [13]  136 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            137 ;src/UI_PauseMenu.c:72: ++ui_pausemenu_entryIndex;
   4B29 21 2B 7E      [10]  138 	ld	hl, #_ui_pausemenu_entryIndex+0
   4B2C 34            [11]  139 	inc	(hl)
   4B2D C9            [10]  140 	ret
                            141 ;src/UI_PauseMenu.c:76: void ui_pausemenu_previous_entry(){
                            142 ;	---------------------------------
                            143 ; Function ui_pausemenu_previous_entry
                            144 ; ---------------------------------
   4B2E                     145 _ui_pausemenu_previous_entry::
                            146 ;src/UI_PauseMenu.c:77: if(ui_pausemenu_entryIndex>0){
   4B2E 3A 2B 7E      [13]  147 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4B31 B7            [ 4]  148 	or	a, a
   4B32 C8            [11]  149 	ret	Z
                            150 ;src/UI_PauseMenu.c:78: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4B33 3A 2B 7E      [13]  151 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4B36 32 2A 7E      [13]  152 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            153 ;src/UI_PauseMenu.c:79: --ui_pausemenu_entryIndex;
   4B39 21 2B 7E      [10]  154 	ld	hl, #_ui_pausemenu_entryIndex+0
   4B3C 35            [11]  155 	dec	(hl)
   4B3D C9            [10]  156 	ret
                            157 ;src/UI_PauseMenu.c:83: void ui_pausemenu_select_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_pausemenu_select_entry
                            160 ; ---------------------------------
   4B3E                     161 _ui_pausemenu_select_entry::
                            162 ;src/UI_PauseMenu.c:84: ui_pausemenu_entrySelected=1;
   4B3E 21 2C 7E      [10]  163 	ld	hl,#_ui_pausemenu_entrySelected + 0
   4B41 36 01         [10]  164 	ld	(hl), #0x01
   4B43 C9            [10]  165 	ret
                            166 ;src/UI_PauseMenu.c:87: void ui_pausemenu_unselect_entry(){
                            167 ;	---------------------------------
                            168 ; Function ui_pausemenu_unselect_entry
                            169 ; ---------------------------------
   4B44                     170 _ui_pausemenu_unselect_entry::
                            171 ;src/UI_PauseMenu.c:88: ui_pausemenu_entrySelected=0;
   4B44 21 2C 7E      [10]  172 	ld	hl,#_ui_pausemenu_entrySelected + 0
   4B47 36 00         [10]  173 	ld	(hl), #0x00
   4B49 C9            [10]  174 	ret
                            175 ;src/UI_PauseMenu.c:91: void ui_pausemenu_render_button(u8 n){
                            176 ;	---------------------------------
                            177 ; Function ui_pausemenu_render_button
                            178 ; ---------------------------------
   4B4A                     179 _ui_pausemenu_render_button::
   4B4A DD E5         [15]  180 	push	ix
   4B4C DD 21 00 00   [14]  181 	ld	ix,#0
   4B50 DD 39         [15]  182 	add	ix,sp
   4B52 3B            [ 6]  183 	dec	sp
                            184 ;src/UI_PauseMenu.c:93: color = (n==ui_pausemenu_entryIndex)?((ui_pausemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4B53 DD 7E 04      [19]  185 	ld	a,4 (ix)
   4B56 FD 21 2B 7E   [14]  186 	ld	iy,#_ui_pausemenu_entryIndex
   4B5A FD 96 00      [19]  187 	sub	a, 0 (iy)
   4B5D 20 10         [12]  188 	jr	NZ,00103$
   4B5F 3A 2C 7E      [13]  189 	ld	a,(#_ui_pausemenu_entrySelected + 0)
   4B62 B7            [ 4]  190 	or	a, a
   4B63 28 05         [12]  191 	jr	Z,00105$
   4B65 3A B3 1A      [13]  192 	ld	a, (#(_g_colors + 0x0004) + 0)
   4B68 18 08         [12]  193 	jr	00104$
   4B6A                     194 00105$:
   4B6A 3A B5 1A      [13]  195 	ld	a, (#(_g_colors + 0x0006) + 0)
   4B6D 18 03         [12]  196 	jr	00104$
   4B6F                     197 00103$:
   4B6F 3A B1 1A      [13]  198 	ld	a, (#(_g_colors + 0x0002) + 0)
   4B72                     199 00104$:
   4B72 DD 77 FF      [19]  200 	ld	-1 (ix),a
                            201 ;src/UI_PauseMenu.c:94: cpct_drawSolidBox(ui_pausemenu_entriesPosition[n],color, UI_PAUSEMENU_BUTTON_WIDTH, UI_PAUSEMENU_BUTTON_HEIGHT);
   4B75 DD 6E 04      [19]  202 	ld	l,4 (ix)
   4B78 26 00         [ 7]  203 	ld	h,#0x00
   4B7A 29            [11]  204 	add	hl, hl
   4B7B 4D            [ 4]  205 	ld	c, l
   4B7C 44            [ 4]  206 	ld	b, h
   4B7D 21 D4 4A      [10]  207 	ld	hl,#_ui_pausemenu_entriesPosition
   4B80 09            [11]  208 	add	hl,bc
   4B81 5E            [ 7]  209 	ld	e,(hl)
   4B82 23            [ 6]  210 	inc	hl
   4B83 56            [ 7]  211 	ld	d,(hl)
   4B84 C5            [11]  212 	push	bc
   4B85 21 1C 18      [10]  213 	ld	hl,#0x181C
   4B88 E5            [11]  214 	push	hl
   4B89 DD 7E FF      [19]  215 	ld	a,-1 (ix)
   4B8C F5            [11]  216 	push	af
   4B8D 33            [ 6]  217 	inc	sp
   4B8E D5            [11]  218 	push	de
   4B8F CD B8 7B      [17]  219 	call	_cpct_drawSolidBox
   4B92 F1            [10]  220 	pop	af
   4B93 F1            [10]  221 	pop	af
   4B94 33            [ 6]  222 	inc	sp
   4B95 C1            [10]  223 	pop	bc
                            224 ;src/UI_PauseMenu.c:95: print_transparent_text(ui_pausemenu_buttonText[n], ui_pausemenu_entriesTextPosition[n], 3);
   4B96 21 DC 4A      [10]  225 	ld	hl,#_ui_pausemenu_entriesTextPosition
   4B99 09            [11]  226 	add	hl,bc
   4B9A 5E            [ 7]  227 	ld	e,(hl)
   4B9B 23            [ 6]  228 	inc	hl
   4B9C 56            [ 7]  229 	ld	d,(hl)
   4B9D 21 E4 4A      [10]  230 	ld	hl,#_ui_pausemenu_buttonText
   4BA0 09            [11]  231 	add	hl,bc
   4BA1 4E            [ 7]  232 	ld	c,(hl)
   4BA2 23            [ 6]  233 	inc	hl
   4BA3 46            [ 7]  234 	ld	b,(hl)
   4BA4 3E 03         [ 7]  235 	ld	a,#0x03
   4BA6 F5            [11]  236 	push	af
   4BA7 33            [ 6]  237 	inc	sp
   4BA8 D5            [11]  238 	push	de
   4BA9 C5            [11]  239 	push	bc
   4BAA CD C6 3F      [17]  240 	call	_print_transparent_text
   4BAD F1            [10]  241 	pop	af
   4BAE F1            [10]  242 	pop	af
   4BAF 33            [ 6]  243 	inc	sp
   4BB0 33            [ 6]  244 	inc	sp
   4BB1 DD E1         [14]  245 	pop	ix
   4BB3 C9            [10]  246 	ret
                            247 ;src/UI_PauseMenu.c:98: void ui_pausemenu_render_refresh(){
                            248 ;	---------------------------------
                            249 ; Function ui_pausemenu_render_refresh
                            250 ; ---------------------------------
   4BB4                     251 _ui_pausemenu_render_refresh::
                            252 ;src/UI_PauseMenu.c:100: ui_pausemenu_render_button(ui_pausemenu_entryIndex);
   4BB4 3A 2B 7E      [13]  253 	ld	a,(_ui_pausemenu_entryIndex)
   4BB7 F5            [11]  254 	push	af
   4BB8 33            [ 6]  255 	inc	sp
   4BB9 CD 4A 4B      [17]  256 	call	_ui_pausemenu_render_button
   4BBC 33            [ 6]  257 	inc	sp
                            258 ;src/UI_PauseMenu.c:101: ui_pausemenu_render_button(ui_pausemenu_lastEntry);
   4BBD 3A 2A 7E      [13]  259 	ld	a,(_ui_pausemenu_lastEntry)
   4BC0 F5            [11]  260 	push	af
   4BC1 33            [ 6]  261 	inc	sp
   4BC2 CD 4A 4B      [17]  262 	call	_ui_pausemenu_render_button
   4BC5 33            [ 6]  263 	inc	sp
                            264 ;src/UI_PauseMenu.c:103: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4BC6 3A 2B 7E      [13]  265 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4BC9 32 2A 7E      [13]  266 	ld	(#_ui_pausemenu_lastEntry + 0),a
   4BCC C9            [10]  267 	ret
                            268 ;src/UI_PauseMenu.c:106: void ui_pausemenu_render_all(){
                            269 ;	---------------------------------
                            270 ; Function ui_pausemenu_render_all
                            271 ; ---------------------------------
   4BCD                     272 _ui_pausemenu_render_all::
                            273 ;src/UI_PauseMenu.c:110: while(n){
   4BCD 06 04         [ 7]  274 	ld	b,#0x04
   4BCF                     275 00101$:
   4BCF 78            [ 4]  276 	ld	a,b
   4BD0 B7            [ 4]  277 	or	a, a
   4BD1 28 0B         [12]  278 	jr	Z,00103$
                            279 ;src/UI_PauseMenu.c:111: --n;
   4BD3 05            [ 4]  280 	dec	b
                            281 ;src/UI_PauseMenu.c:112: ui_pausemenu_render_button(n);
   4BD4 C5            [11]  282 	push	bc
   4BD5 C5            [11]  283 	push	bc
   4BD6 33            [ 6]  284 	inc	sp
   4BD7 CD 4A 4B      [17]  285 	call	_ui_pausemenu_render_button
   4BDA 33            [ 6]  286 	inc	sp
   4BDB C1            [10]  287 	pop	bc
   4BDC 18 F1         [12]  288 	jr	00101$
   4BDE                     289 00103$:
                            290 ;src/UI_PauseMenu.c:115: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4BDE 3A 2B 7E      [13]  291 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4BE1 32 2A 7E      [13]  292 	ld	(#_ui_pausemenu_lastEntry + 0),a
   4BE4 C9            [10]  293 	ret
                            294 	.area _CODE
                            295 	.area _INITIALIZER
                            296 	.area _CABS (ABS)
