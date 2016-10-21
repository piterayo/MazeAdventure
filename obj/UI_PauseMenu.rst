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
   5B7E                      36 _ui_pausemenu_lastEntry::
   5B7E                      37 	.ds 1
   5B7F                      38 _ui_pausemenu_entryIndex::
   5B7F                      39 	.ds 1
   5B80                      40 _ui_pausemenu_entrySelected::
   5B80                      41 	.ds 1
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
                             66 ;src/UI_PauseMenu.c:57: void ui_pausemenu_init(){
                             67 ;	---------------------------------
                             68 ; Function ui_pausemenu_init
                             69 ; ---------------------------------
   2ED1                      70 _ui_pausemenu_init::
                             71 ;src/UI_PauseMenu.c:58: ui_pausemenu_lastEntry=0;
   2ED1 21 7E 5B      [10]   72 	ld	hl,#_ui_pausemenu_lastEntry + 0
   2ED4 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_PauseMenu.c:59: ui_pausemenu_entryIndex=0;
   2ED6 21 7F 5B      [10]   75 	ld	hl,#_ui_pausemenu_entryIndex + 0
   2ED9 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_PauseMenu.c:60: ui_pausemenu_entrySelected=0;
   2EDB 21 80 5B      [10]   78 	ld	hl,#_ui_pausemenu_entrySelected + 0
   2EDE 36 00         [10]   79 	ld	(hl), #0x00
   2EE0 C9            [10]   80 	ret
   2EE1                      81 _ui_pausemenu_entriesPosition:
   2EE1 AA C1                82 	.dw #0xC1AA
   2EE3 EA C2                83 	.dw #0xC2EA
   2EE5 2A C4                84 	.dw #0xC42A
   2EE7 6A C5                85 	.dw #0xC56A
   2EE9                      86 _ui_pausemenu_entriesTextPosition:
   2EE9 00 CA                87 	.dw #0xCA00
   2EEB 42 CB                88 	.dw #0xCB42
   2EED 7B CC                89 	.dw #0xCC7B
   2EEF C4 CD                90 	.dw #0xCDC4
   2EF1                      91 _ui_pausemenu_buttonText:
   2EF1 F9 2E                92 	.dw __str_0
   2EF3 02 2F                93 	.dw __str_1
   2EF5 0A 2F                94 	.dw __str_2
   2EF7 18 2F                95 	.dw __str_3
   2EF9                      96 __str_0:
   2EF9 43 4F 4E 54 49 4E    97 	.ascii "CONTINUE"
        55 45
   2F01 00                   98 	.db 0x00
   2F02                      99 __str_1:
   2F02 4F 50 54 49 4F 4E   100 	.ascii "OPTIONS"
        53
   2F09 00                  101 	.db 0x00
   2F0A                     102 __str_2:
   2F0A 53 41 56 45 20 41   103 	.ascii "SAVE AND EXIT"
        4E 44 20 45 58 49
        54
   2F17 00                  104 	.db 0x00
   2F18                     105 __str_3:
   2F18 45 58 49 54         106 	.ascii "EXIT"
   2F1C 00                  107 	.db 0x00
                            108 ;src/UI_PauseMenu.c:63: u8 ui_pausemenu_get_entry(){
                            109 ;	---------------------------------
                            110 ; Function ui_pausemenu_get_entry
                            111 ; ---------------------------------
   2F1D                     112 _ui_pausemenu_get_entry::
                            113 ;src/UI_PauseMenu.c:64: return ui_pausemenu_entryIndex;
   2F1D FD 21 7F 5B   [14]  114 	ld	iy,#_ui_pausemenu_entryIndex
   2F21 FD 6E 00      [19]  115 	ld	l,0 (iy)
   2F24 C9            [10]  116 	ret
                            117 ;src/UI_PauseMenu.c:67: u8 ui_pausemenu_is_selected(){
                            118 ;	---------------------------------
                            119 ; Function ui_pausemenu_is_selected
                            120 ; ---------------------------------
   2F25                     121 _ui_pausemenu_is_selected::
                            122 ;src/UI_PauseMenu.c:68: return ui_pausemenu_entrySelected;
   2F25 FD 21 80 5B   [14]  123 	ld	iy,#_ui_pausemenu_entrySelected
   2F29 FD 6E 00      [19]  124 	ld	l,0 (iy)
   2F2C C9            [10]  125 	ret
                            126 ;src/UI_PauseMenu.c:71: void ui_pausemenu_next_entry(){
                            127 ;	---------------------------------
                            128 ; Function ui_pausemenu_next_entry
                            129 ; ---------------------------------
   2F2D                     130 _ui_pausemenu_next_entry::
                            131 ;src/UI_PauseMenu.c:72: if(ui_pausemenu_entryIndex<(UI_PAUSEMENU_ENTRIES-1)){
                            132 ;src/UI_PauseMenu.c:73: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   2F2D 3A 7F 5B      [13]  133 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2F30 FE 03         [ 7]  134 	cp	a,#0x03
   2F32 D0            [11]  135 	ret	NC
   2F33 32 7E 5B      [13]  136 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            137 ;src/UI_PauseMenu.c:74: ++ui_pausemenu_entryIndex;
   2F36 21 7F 5B      [10]  138 	ld	hl, #_ui_pausemenu_entryIndex+0
   2F39 34            [11]  139 	inc	(hl)
   2F3A C9            [10]  140 	ret
                            141 ;src/UI_PauseMenu.c:78: void ui_pausemenu_previous_entry(){
                            142 ;	---------------------------------
                            143 ; Function ui_pausemenu_previous_entry
                            144 ; ---------------------------------
   2F3B                     145 _ui_pausemenu_previous_entry::
                            146 ;src/UI_PauseMenu.c:79: if(ui_pausemenu_entryIndex>0){
   2F3B 3A 7F 5B      [13]  147 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2F3E B7            [ 4]  148 	or	a, a
   2F3F C8            [11]  149 	ret	Z
                            150 ;src/UI_PauseMenu.c:80: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   2F40 3A 7F 5B      [13]  151 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2F43 32 7E 5B      [13]  152 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            153 ;src/UI_PauseMenu.c:81: --ui_pausemenu_entryIndex;
   2F46 21 7F 5B      [10]  154 	ld	hl, #_ui_pausemenu_entryIndex+0
   2F49 35            [11]  155 	dec	(hl)
   2F4A C9            [10]  156 	ret
                            157 ;src/UI_PauseMenu.c:85: void ui_pausemenu_select_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_pausemenu_select_entry
                            160 ; ---------------------------------
   2F4B                     161 _ui_pausemenu_select_entry::
                            162 ;src/UI_PauseMenu.c:86: ui_pausemenu_entrySelected=1;
   2F4B 21 80 5B      [10]  163 	ld	hl,#_ui_pausemenu_entrySelected + 0
   2F4E 36 01         [10]  164 	ld	(hl), #0x01
   2F50 C9            [10]  165 	ret
                            166 ;src/UI_PauseMenu.c:89: void ui_pausemenu_unselect_entry(){
                            167 ;	---------------------------------
                            168 ; Function ui_pausemenu_unselect_entry
                            169 ; ---------------------------------
   2F51                     170 _ui_pausemenu_unselect_entry::
                            171 ;src/UI_PauseMenu.c:90: ui_pausemenu_entrySelected=0;
   2F51 21 80 5B      [10]  172 	ld	hl,#_ui_pausemenu_entrySelected + 0
   2F54 36 00         [10]  173 	ld	(hl), #0x00
   2F56 C9            [10]  174 	ret
                            175 ;src/UI_PauseMenu.c:93: void ui_pausemenu_render_button(u8 n){
                            176 ;	---------------------------------
                            177 ; Function ui_pausemenu_render_button
                            178 ; ---------------------------------
   2F57                     179 _ui_pausemenu_render_button::
   2F57 DD E5         [15]  180 	push	ix
   2F59 DD 21 00 00   [14]  181 	ld	ix,#0
   2F5D DD 39         [15]  182 	add	ix,sp
   2F5F 3B            [ 6]  183 	dec	sp
                            184 ;src/UI_PauseMenu.c:95: color = (n==ui_pausemenu_entryIndex)?((ui_pausemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   2F60 DD 7E 04      [19]  185 	ld	a,4 (ix)
   2F63 FD 21 7F 5B   [14]  186 	ld	iy,#_ui_pausemenu_entryIndex
   2F67 FD 96 00      [19]  187 	sub	a, 0 (iy)
   2F6A 20 10         [12]  188 	jr	NZ,00103$
   2F6C 3A 80 5B      [13]  189 	ld	a,(#_ui_pausemenu_entrySelected + 0)
   2F6F B7            [ 4]  190 	or	a, a
   2F70 28 05         [12]  191 	jr	Z,00105$
   2F72 3A 6A 10      [13]  192 	ld	a, (#(_g_colors + 0x0004) + 0)
   2F75 18 08         [12]  193 	jr	00104$
   2F77                     194 00105$:
   2F77 3A 6C 10      [13]  195 	ld	a, (#(_g_colors + 0x0006) + 0)
   2F7A 18 03         [12]  196 	jr	00104$
   2F7C                     197 00103$:
   2F7C 3A 68 10      [13]  198 	ld	a, (#(_g_colors + 0x0002) + 0)
   2F7F                     199 00104$:
   2F7F DD 77 FF      [19]  200 	ld	-1 (ix),a
                            201 ;src/UI_PauseMenu.c:96: cpct_drawSolidBox(ui_pausemenu_entriesPosition[n],color, UI_PAUSEMENU_BUTTON_WIDTH, UI_PAUSEMENU_BUTTON_HEIGHT);
   2F82 DD 6E 04      [19]  202 	ld	l,4 (ix)
   2F85 26 00         [ 7]  203 	ld	h,#0x00
   2F87 29            [11]  204 	add	hl, hl
   2F88 4D            [ 4]  205 	ld	c, l
   2F89 44            [ 4]  206 	ld	b, h
   2F8A 21 E1 2E      [10]  207 	ld	hl,#_ui_pausemenu_entriesPosition
   2F8D 09            [11]  208 	add	hl,bc
   2F8E 5E            [ 7]  209 	ld	e,(hl)
   2F8F 23            [ 6]  210 	inc	hl
   2F90 56            [ 7]  211 	ld	d,(hl)
   2F91 C5            [11]  212 	push	bc
   2F92 21 1C 18      [10]  213 	ld	hl,#0x181C
   2F95 E5            [11]  214 	push	hl
   2F96 DD 7E FF      [19]  215 	ld	a,-1 (ix)
   2F99 F5            [11]  216 	push	af
   2F9A 33            [ 6]  217 	inc	sp
   2F9B D5            [11]  218 	push	de
   2F9C CD 62 59      [17]  219 	call	_cpct_drawSolidBox
   2F9F F1            [10]  220 	pop	af
   2FA0 F1            [10]  221 	pop	af
   2FA1 33            [ 6]  222 	inc	sp
   2FA2 C1            [10]  223 	pop	bc
                            224 ;src/UI_PauseMenu.c:97: print_transparent_text(ui_pausemenu_buttonText[n], ui_pausemenu_entriesTextPosition[n], 3);
   2FA3 21 E9 2E      [10]  225 	ld	hl,#_ui_pausemenu_entriesTextPosition
   2FA6 09            [11]  226 	add	hl,bc
   2FA7 5E            [ 7]  227 	ld	e,(hl)
   2FA8 23            [ 6]  228 	inc	hl
   2FA9 56            [ 7]  229 	ld	d,(hl)
   2FAA 21 F1 2E      [10]  230 	ld	hl,#_ui_pausemenu_buttonText
   2FAD 09            [11]  231 	add	hl,bc
   2FAE 4E            [ 7]  232 	ld	c,(hl)
   2FAF 23            [ 6]  233 	inc	hl
   2FB0 46            [ 7]  234 	ld	b,(hl)
   2FB1 3E 03         [ 7]  235 	ld	a,#0x03
   2FB3 F5            [11]  236 	push	af
   2FB4 33            [ 6]  237 	inc	sp
   2FB5 D5            [11]  238 	push	de
   2FB6 C5            [11]  239 	push	bc
   2FB7 CD 59 28      [17]  240 	call	_print_transparent_text
   2FBA F1            [10]  241 	pop	af
   2FBB F1            [10]  242 	pop	af
   2FBC 33            [ 6]  243 	inc	sp
   2FBD 33            [ 6]  244 	inc	sp
   2FBE DD E1         [14]  245 	pop	ix
   2FC0 C9            [10]  246 	ret
                            247 ;src/UI_PauseMenu.c:100: void ui_pausemenu_render_refresh(){
                            248 ;	---------------------------------
                            249 ; Function ui_pausemenu_render_refresh
                            250 ; ---------------------------------
   2FC1                     251 _ui_pausemenu_render_refresh::
                            252 ;src/UI_PauseMenu.c:102: ui_pausemenu_render_button(ui_pausemenu_entryIndex);
   2FC1 3A 7F 5B      [13]  253 	ld	a,(_ui_pausemenu_entryIndex)
   2FC4 F5            [11]  254 	push	af
   2FC5 33            [ 6]  255 	inc	sp
   2FC6 CD 57 2F      [17]  256 	call	_ui_pausemenu_render_button
   2FC9 33            [ 6]  257 	inc	sp
                            258 ;src/UI_PauseMenu.c:103: ui_pausemenu_render_button(ui_pausemenu_lastEntry);
   2FCA 3A 7E 5B      [13]  259 	ld	a,(_ui_pausemenu_lastEntry)
   2FCD F5            [11]  260 	push	af
   2FCE 33            [ 6]  261 	inc	sp
   2FCF CD 57 2F      [17]  262 	call	_ui_pausemenu_render_button
   2FD2 33            [ 6]  263 	inc	sp
                            264 ;src/UI_PauseMenu.c:105: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   2FD3 3A 7F 5B      [13]  265 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2FD6 32 7E 5B      [13]  266 	ld	(#_ui_pausemenu_lastEntry + 0),a
   2FD9 C9            [10]  267 	ret
                            268 ;src/UI_PauseMenu.c:108: void ui_pausemenu_render_all(){
                            269 ;	---------------------------------
                            270 ; Function ui_pausemenu_render_all
                            271 ; ---------------------------------
   2FDA                     272 _ui_pausemenu_render_all::
                            273 ;src/UI_PauseMenu.c:112: while(n){
   2FDA 06 04         [ 7]  274 	ld	b,#0x04
   2FDC                     275 00101$:
   2FDC 78            [ 4]  276 	ld	a,b
   2FDD B7            [ 4]  277 	or	a, a
   2FDE 28 0B         [12]  278 	jr	Z,00103$
                            279 ;src/UI_PauseMenu.c:113: --n;
   2FE0 05            [ 4]  280 	dec	b
                            281 ;src/UI_PauseMenu.c:114: ui_pausemenu_render_button(n);
   2FE1 C5            [11]  282 	push	bc
   2FE2 C5            [11]  283 	push	bc
   2FE3 33            [ 6]  284 	inc	sp
   2FE4 CD 57 2F      [17]  285 	call	_ui_pausemenu_render_button
   2FE7 33            [ 6]  286 	inc	sp
   2FE8 C1            [10]  287 	pop	bc
   2FE9 18 F1         [12]  288 	jr	00101$
   2FEB                     289 00103$:
                            290 ;src/UI_PauseMenu.c:117: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   2FEB 3A 7F 5B      [13]  291 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2FEE 32 7E 5B      [13]  292 	ld	(#_ui_pausemenu_lastEntry + 0),a
   2FF1 C9            [10]  293 	ret
                            294 	.area _CODE
                            295 	.area _INITIALIZER
                            296 	.area _CABS (ABS)
