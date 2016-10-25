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
   7E04                      36 _ui_pausemenu_lastEntry::
   7E04                      37 	.ds 1
   7E05                      38 _ui_pausemenu_entryIndex::
   7E05                      39 	.ds 1
   7E06                      40 _ui_pausemenu_entrySelected::
   7E06                      41 	.ds 1
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
   4A9E                      70 _ui_pausemenu_init::
                             71 ;src/UI_PauseMenu.c:56: ui_pausemenu_lastEntry=0;
   4A9E 21 04 7E      [10]   72 	ld	hl,#_ui_pausemenu_lastEntry + 0
   4AA1 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_PauseMenu.c:57: ui_pausemenu_entryIndex=0;
   4AA3 21 05 7E      [10]   75 	ld	hl,#_ui_pausemenu_entryIndex + 0
   4AA6 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_PauseMenu.c:58: ui_pausemenu_entrySelected=0;
   4AA8 21 06 7E      [10]   78 	ld	hl,#_ui_pausemenu_entrySelected + 0
   4AAB 36 00         [10]   79 	ld	(hl), #0x00
   4AAD C9            [10]   80 	ret
   4AAE                      81 _ui_pausemenu_entriesPosition:
   4AAE AA C1                82 	.dw #0xC1AA
   4AB0 EA C2                83 	.dw #0xC2EA
   4AB2 2A C4                84 	.dw #0xC42A
   4AB4 6A C5                85 	.dw #0xC56A
   4AB6                      86 _ui_pausemenu_entriesTextPosition:
   4AB6 00 CA                87 	.dw #0xCA00
   4AB8 42 CB                88 	.dw #0xCB42
   4ABA 7B CC                89 	.dw #0xCC7B
   4ABC C4 CD                90 	.dw #0xCDC4
   4ABE                      91 _ui_pausemenu_buttonText:
   4ABE C6 4A                92 	.dw __str_0
   4AC0 CF 4A                93 	.dw __str_1
   4AC2 D7 4A                94 	.dw __str_2
   4AC4 E5 4A                95 	.dw __str_3
   4AC6                      96 __str_0:
   4AC6 43 4F 4E 54 49 4E    97 	.ascii "CONTINUE"
        55 45
   4ACE 00                   98 	.db 0x00
   4ACF                      99 __str_1:
   4ACF 4F 50 54 49 4F 4E   100 	.ascii "OPTIONS"
        53
   4AD6 00                  101 	.db 0x00
   4AD7                     102 __str_2:
   4AD7 53 41 56 45 20 41   103 	.ascii "SAVE AND EXIT"
        4E 44 20 45 58 49
        54
   4AE4 00                  104 	.db 0x00
   4AE5                     105 __str_3:
   4AE5 45 58 49 54         106 	.ascii "EXIT"
   4AE9 00                  107 	.db 0x00
                            108 ;src/UI_PauseMenu.c:61: u8 ui_pausemenu_get_entry(){
                            109 ;	---------------------------------
                            110 ; Function ui_pausemenu_get_entry
                            111 ; ---------------------------------
   4AEA                     112 _ui_pausemenu_get_entry::
                            113 ;src/UI_PauseMenu.c:62: return ui_pausemenu_entryIndex;
   4AEA FD 21 05 7E   [14]  114 	ld	iy,#_ui_pausemenu_entryIndex
   4AEE FD 6E 00      [19]  115 	ld	l,0 (iy)
   4AF1 C9            [10]  116 	ret
                            117 ;src/UI_PauseMenu.c:65: u8 ui_pausemenu_is_selected(){
                            118 ;	---------------------------------
                            119 ; Function ui_pausemenu_is_selected
                            120 ; ---------------------------------
   4AF2                     121 _ui_pausemenu_is_selected::
                            122 ;src/UI_PauseMenu.c:66: return ui_pausemenu_entrySelected;
   4AF2 FD 21 06 7E   [14]  123 	ld	iy,#_ui_pausemenu_entrySelected
   4AF6 FD 6E 00      [19]  124 	ld	l,0 (iy)
   4AF9 C9            [10]  125 	ret
                            126 ;src/UI_PauseMenu.c:69: void ui_pausemenu_next_entry(){
                            127 ;	---------------------------------
                            128 ; Function ui_pausemenu_next_entry
                            129 ; ---------------------------------
   4AFA                     130 _ui_pausemenu_next_entry::
                            131 ;src/UI_PauseMenu.c:70: if(ui_pausemenu_entryIndex<(UI_PAUSEMENU_ENTRIES-1)){
                            132 ;src/UI_PauseMenu.c:71: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4AFA 3A 05 7E      [13]  133 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4AFD FE 03         [ 7]  134 	cp	a,#0x03
   4AFF D0            [11]  135 	ret	NC
   4B00 32 04 7E      [13]  136 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            137 ;src/UI_PauseMenu.c:72: ++ui_pausemenu_entryIndex;
   4B03 21 05 7E      [10]  138 	ld	hl, #_ui_pausemenu_entryIndex+0
   4B06 34            [11]  139 	inc	(hl)
   4B07 C9            [10]  140 	ret
                            141 ;src/UI_PauseMenu.c:76: void ui_pausemenu_previous_entry(){
                            142 ;	---------------------------------
                            143 ; Function ui_pausemenu_previous_entry
                            144 ; ---------------------------------
   4B08                     145 _ui_pausemenu_previous_entry::
                            146 ;src/UI_PauseMenu.c:77: if(ui_pausemenu_entryIndex>0){
   4B08 3A 05 7E      [13]  147 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4B0B B7            [ 4]  148 	or	a, a
   4B0C C8            [11]  149 	ret	Z
                            150 ;src/UI_PauseMenu.c:78: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4B0D 3A 05 7E      [13]  151 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4B10 32 04 7E      [13]  152 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            153 ;src/UI_PauseMenu.c:79: --ui_pausemenu_entryIndex;
   4B13 21 05 7E      [10]  154 	ld	hl, #_ui_pausemenu_entryIndex+0
   4B16 35            [11]  155 	dec	(hl)
   4B17 C9            [10]  156 	ret
                            157 ;src/UI_PauseMenu.c:83: void ui_pausemenu_select_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_pausemenu_select_entry
                            160 ; ---------------------------------
   4B18                     161 _ui_pausemenu_select_entry::
                            162 ;src/UI_PauseMenu.c:84: ui_pausemenu_entrySelected=1;
   4B18 21 06 7E      [10]  163 	ld	hl,#_ui_pausemenu_entrySelected + 0
   4B1B 36 01         [10]  164 	ld	(hl), #0x01
   4B1D C9            [10]  165 	ret
                            166 ;src/UI_PauseMenu.c:87: void ui_pausemenu_unselect_entry(){
                            167 ;	---------------------------------
                            168 ; Function ui_pausemenu_unselect_entry
                            169 ; ---------------------------------
   4B1E                     170 _ui_pausemenu_unselect_entry::
                            171 ;src/UI_PauseMenu.c:88: ui_pausemenu_entrySelected=0;
   4B1E 21 06 7E      [10]  172 	ld	hl,#_ui_pausemenu_entrySelected + 0
   4B21 36 00         [10]  173 	ld	(hl), #0x00
   4B23 C9            [10]  174 	ret
                            175 ;src/UI_PauseMenu.c:91: void ui_pausemenu_render_button(u8 n){
                            176 ;	---------------------------------
                            177 ; Function ui_pausemenu_render_button
                            178 ; ---------------------------------
   4B24                     179 _ui_pausemenu_render_button::
   4B24 DD E5         [15]  180 	push	ix
   4B26 DD 21 00 00   [14]  181 	ld	ix,#0
   4B2A DD 39         [15]  182 	add	ix,sp
   4B2C 3B            [ 6]  183 	dec	sp
                            184 ;src/UI_PauseMenu.c:93: color = (n==ui_pausemenu_entryIndex)?((ui_pausemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4B2D DD 7E 04      [19]  185 	ld	a,4 (ix)
   4B30 FD 21 05 7E   [14]  186 	ld	iy,#_ui_pausemenu_entryIndex
   4B34 FD 96 00      [19]  187 	sub	a, 0 (iy)
   4B37 20 10         [12]  188 	jr	NZ,00103$
   4B39 3A 06 7E      [13]  189 	ld	a,(#_ui_pausemenu_entrySelected + 0)
   4B3C B7            [ 4]  190 	or	a, a
   4B3D 28 05         [12]  191 	jr	Z,00105$
   4B3F 3A 6A 1A      [13]  192 	ld	a, (#(_g_colors + 0x0004) + 0)
   4B42 18 08         [12]  193 	jr	00104$
   4B44                     194 00105$:
   4B44 3A 6C 1A      [13]  195 	ld	a, (#(_g_colors + 0x0006) + 0)
   4B47 18 03         [12]  196 	jr	00104$
   4B49                     197 00103$:
   4B49 3A 68 1A      [13]  198 	ld	a, (#(_g_colors + 0x0002) + 0)
   4B4C                     199 00104$:
   4B4C DD 77 FF      [19]  200 	ld	-1 (ix),a
                            201 ;src/UI_PauseMenu.c:94: cpct_drawSolidBox(ui_pausemenu_entriesPosition[n],color, UI_PAUSEMENU_BUTTON_WIDTH, UI_PAUSEMENU_BUTTON_HEIGHT);
   4B4F DD 6E 04      [19]  202 	ld	l,4 (ix)
   4B52 26 00         [ 7]  203 	ld	h,#0x00
   4B54 29            [11]  204 	add	hl, hl
   4B55 4D            [ 4]  205 	ld	c, l
   4B56 44            [ 4]  206 	ld	b, h
   4B57 21 AE 4A      [10]  207 	ld	hl,#_ui_pausemenu_entriesPosition
   4B5A 09            [11]  208 	add	hl,bc
   4B5B 5E            [ 7]  209 	ld	e,(hl)
   4B5C 23            [ 6]  210 	inc	hl
   4B5D 56            [ 7]  211 	ld	d,(hl)
   4B5E C5            [11]  212 	push	bc
   4B5F 21 1C 18      [10]  213 	ld	hl,#0x181C
   4B62 E5            [11]  214 	push	hl
   4B63 DD 7E FF      [19]  215 	ld	a,-1 (ix)
   4B66 F5            [11]  216 	push	af
   4B67 33            [ 6]  217 	inc	sp
   4B68 D5            [11]  218 	push	de
   4B69 CD 92 7B      [17]  219 	call	_cpct_drawSolidBox
   4B6C F1            [10]  220 	pop	af
   4B6D F1            [10]  221 	pop	af
   4B6E 33            [ 6]  222 	inc	sp
   4B6F C1            [10]  223 	pop	bc
                            224 ;src/UI_PauseMenu.c:95: print_transparent_text(ui_pausemenu_buttonText[n], ui_pausemenu_entriesTextPosition[n], 3);
   4B70 21 B6 4A      [10]  225 	ld	hl,#_ui_pausemenu_entriesTextPosition
   4B73 09            [11]  226 	add	hl,bc
   4B74 5E            [ 7]  227 	ld	e,(hl)
   4B75 23            [ 6]  228 	inc	hl
   4B76 56            [ 7]  229 	ld	d,(hl)
   4B77 21 BE 4A      [10]  230 	ld	hl,#_ui_pausemenu_buttonText
   4B7A 09            [11]  231 	add	hl,bc
   4B7B 4E            [ 7]  232 	ld	c,(hl)
   4B7C 23            [ 6]  233 	inc	hl
   4B7D 46            [ 7]  234 	ld	b,(hl)
   4B7E 3E 03         [ 7]  235 	ld	a,#0x03
   4B80 F5            [11]  236 	push	af
   4B81 33            [ 6]  237 	inc	sp
   4B82 D5            [11]  238 	push	de
   4B83 C5            [11]  239 	push	bc
   4B84 CD A0 3F      [17]  240 	call	_print_transparent_text
   4B87 F1            [10]  241 	pop	af
   4B88 F1            [10]  242 	pop	af
   4B89 33            [ 6]  243 	inc	sp
   4B8A 33            [ 6]  244 	inc	sp
   4B8B DD E1         [14]  245 	pop	ix
   4B8D C9            [10]  246 	ret
                            247 ;src/UI_PauseMenu.c:98: void ui_pausemenu_render_refresh(){
                            248 ;	---------------------------------
                            249 ; Function ui_pausemenu_render_refresh
                            250 ; ---------------------------------
   4B8E                     251 _ui_pausemenu_render_refresh::
                            252 ;src/UI_PauseMenu.c:100: ui_pausemenu_render_button(ui_pausemenu_entryIndex);
   4B8E 3A 05 7E      [13]  253 	ld	a,(_ui_pausemenu_entryIndex)
   4B91 F5            [11]  254 	push	af
   4B92 33            [ 6]  255 	inc	sp
   4B93 CD 24 4B      [17]  256 	call	_ui_pausemenu_render_button
   4B96 33            [ 6]  257 	inc	sp
                            258 ;src/UI_PauseMenu.c:101: ui_pausemenu_render_button(ui_pausemenu_lastEntry);
   4B97 3A 04 7E      [13]  259 	ld	a,(_ui_pausemenu_lastEntry)
   4B9A F5            [11]  260 	push	af
   4B9B 33            [ 6]  261 	inc	sp
   4B9C CD 24 4B      [17]  262 	call	_ui_pausemenu_render_button
   4B9F 33            [ 6]  263 	inc	sp
                            264 ;src/UI_PauseMenu.c:103: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4BA0 3A 05 7E      [13]  265 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4BA3 32 04 7E      [13]  266 	ld	(#_ui_pausemenu_lastEntry + 0),a
   4BA6 C9            [10]  267 	ret
                            268 ;src/UI_PauseMenu.c:106: void ui_pausemenu_render_all(){
                            269 ;	---------------------------------
                            270 ; Function ui_pausemenu_render_all
                            271 ; ---------------------------------
   4BA7                     272 _ui_pausemenu_render_all::
                            273 ;src/UI_PauseMenu.c:110: while(n){
   4BA7 06 04         [ 7]  274 	ld	b,#0x04
   4BA9                     275 00101$:
   4BA9 78            [ 4]  276 	ld	a,b
   4BAA B7            [ 4]  277 	or	a, a
   4BAB 28 0B         [12]  278 	jr	Z,00103$
                            279 ;src/UI_PauseMenu.c:111: --n;
   4BAD 05            [ 4]  280 	dec	b
                            281 ;src/UI_PauseMenu.c:112: ui_pausemenu_render_button(n);
   4BAE C5            [11]  282 	push	bc
   4BAF C5            [11]  283 	push	bc
   4BB0 33            [ 6]  284 	inc	sp
   4BB1 CD 24 4B      [17]  285 	call	_ui_pausemenu_render_button
   4BB4 33            [ 6]  286 	inc	sp
   4BB5 C1            [10]  287 	pop	bc
   4BB6 18 F1         [12]  288 	jr	00101$
   4BB8                     289 00103$:
                            290 ;src/UI_PauseMenu.c:115: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   4BB8 3A 05 7E      [13]  291 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   4BBB 32 04 7E      [13]  292 	ld	(#_ui_pausemenu_lastEntry + 0),a
   4BBE C9            [10]  293 	ret
                            294 	.area _CODE
                            295 	.area _INITIALIZER
                            296 	.area _CABS (ABS)
