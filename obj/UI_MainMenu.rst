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
   5B7B                      36 _ui_mainmenu_lastEntry::
   5B7B                      37 	.ds 1
   5B7C                      38 _ui_mainmenu_entryIndex::
   5B7C                      39 	.ds 1
   5B7D                      40 _ui_mainmenu_entrySelected::
   5B7D                      41 	.ds 1
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
                             66 ;src/UI_MainMenu.c:55: void ui_mainmenu_init(){
                             67 ;	---------------------------------
                             68 ; Function ui_mainmenu_init
                             69 ; ---------------------------------
   2DA6                      70 _ui_mainmenu_init::
                             71 ;src/UI_MainMenu.c:56: ui_mainmenu_lastEntry=0;
   2DA6 21 7B 5B      [10]   72 	ld	hl,#_ui_mainmenu_lastEntry + 0
   2DA9 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_MainMenu.c:57: ui_mainmenu_entryIndex=0;
   2DAB 21 7C 5B      [10]   75 	ld	hl,#_ui_mainmenu_entryIndex + 0
   2DAE 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_MainMenu.c:58: ui_mainmenu_entrySelected=0;
   2DB0 21 7D 5B      [10]   78 	ld	hl,#_ui_mainmenu_entrySelected + 0
   2DB3 36 00         [10]   79 	ld	(hl), #0x00
   2DB5 C9            [10]   80 	ret
   2DB6                      81 _ui_mainmenu_entriesPosition:
   2DB6 2E C4                82 	.dw #0xC42E
   2DB8 CE E4                83 	.dw #0xE4CE
   2DBA BE C5                84 	.dw #0xC5BE
   2DBC 5E E6                85 	.dw #0xE65E
   2DBE 4E C7                86 	.dw #0xC74E
   2DC0                      87 _ui_mainmenu_entriesTextPosition:
   2DC0 30 EC                88 	.dw #0xEC30
   2DC2 1F CD                89 	.dw #0xCD1F
   2DC4 C1 ED                90 	.dw #0xEDC1
   2DC6 B1 CE                91 	.dw #0xCEB1
   2DC8 54 EF                92 	.dw #0xEF54
   2DCA                      93 _ui_mainmenu_buttonText:
   2DCA D4 2D                94 	.dw __str_0
   2DCC DD 2D                95 	.dw __str_1
   2DCE E7 2D                96 	.dw __str_2
   2DD0 EF 2D                97 	.dw __str_3
   2DD2 F7 2D                98 	.dw __str_4
   2DD4                      99 __str_0:
   2DD4 4E 45 57 20 47 41   100 	.ascii "NEW GAME"
        4D 45
   2DDC 00                  101 	.db 0x00
   2DDD                     102 __str_1:
   2DDD 4C 4F 41 44 20 47   103 	.ascii "LOAD GAME"
        41 4D 45
   2DE6 00                  104 	.db 0x00
   2DE7                     105 __str_2:
   2DE7 4F 50 54 49 4F 4E   106 	.ascii "OPTIONS"
        53
   2DEE 00                  107 	.db 0x00
   2DEF                     108 __str_3:
   2DEF 43 52 45 44 49 54   109 	.ascii "CREDITS"
        53
   2DF6 00                  110 	.db 0x00
   2DF7                     111 __str_4:
   2DF7 45 58 49 54         112 	.ascii "EXIT"
   2DFB 00                  113 	.db 0x00
                            114 ;src/UI_MainMenu.c:61: void ui_mainmenu_next_entry(){
                            115 ;	---------------------------------
                            116 ; Function ui_mainmenu_next_entry
                            117 ; ---------------------------------
   2DFC                     118 _ui_mainmenu_next_entry::
                            119 ;src/UI_MainMenu.c:62: if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
                            120 ;src/UI_MainMenu.c:63: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   2DFC 3A 7C 5B      [13]  121 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2DFF FE 04         [ 7]  122 	cp	a,#0x04
   2E01 D0            [11]  123 	ret	NC
   2E02 32 7B 5B      [13]  124 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            125 ;src/UI_MainMenu.c:64: ++ui_mainmenu_entryIndex;
   2E05 21 7C 5B      [10]  126 	ld	hl, #_ui_mainmenu_entryIndex+0
   2E08 34            [11]  127 	inc	(hl)
   2E09 C9            [10]  128 	ret
                            129 ;src/UI_MainMenu.c:68: void ui_mainmenu_previous_entry(){
                            130 ;	---------------------------------
                            131 ; Function ui_mainmenu_previous_entry
                            132 ; ---------------------------------
   2E0A                     133 _ui_mainmenu_previous_entry::
                            134 ;src/UI_MainMenu.c:69: if(ui_mainmenu_entryIndex>0){
   2E0A 3A 7C 5B      [13]  135 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2E0D B7            [ 4]  136 	or	a, a
   2E0E C8            [11]  137 	ret	Z
                            138 ;src/UI_MainMenu.c:70: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   2E0F 3A 7C 5B      [13]  139 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2E12 32 7B 5B      [13]  140 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            141 ;src/UI_MainMenu.c:71: --ui_mainmenu_entryIndex;
   2E15 21 7C 5B      [10]  142 	ld	hl, #_ui_mainmenu_entryIndex+0
   2E18 35            [11]  143 	dec	(hl)
   2E19 C9            [10]  144 	ret
                            145 ;src/UI_MainMenu.c:75: void ui_mainmenu_unselect_entry(){
                            146 ;	---------------------------------
                            147 ; Function ui_mainmenu_unselect_entry
                            148 ; ---------------------------------
   2E1A                     149 _ui_mainmenu_unselect_entry::
                            150 ;src/UI_MainMenu.c:76: ui_mainmenu_entrySelected=0;
   2E1A 21 7D 5B      [10]  151 	ld	hl,#_ui_mainmenu_entrySelected + 0
   2E1D 36 00         [10]  152 	ld	(hl), #0x00
   2E1F C9            [10]  153 	ret
                            154 ;src/UI_MainMenu.c:79: void ui_mainmenu_select_entry(){
                            155 ;	---------------------------------
                            156 ; Function ui_mainmenu_select_entry
                            157 ; ---------------------------------
   2E20                     158 _ui_mainmenu_select_entry::
                            159 ;src/UI_MainMenu.c:80: ui_mainmenu_entrySelected=1;
   2E20 21 7D 5B      [10]  160 	ld	hl,#_ui_mainmenu_entrySelected + 0
   2E23 36 01         [10]  161 	ld	(hl), #0x01
   2E25 C9            [10]  162 	ret
                            163 ;src/UI_MainMenu.c:83: void ui_mainmenu_render_button(u8 n){
                            164 ;	---------------------------------
                            165 ; Function ui_mainmenu_render_button
                            166 ; ---------------------------------
   2E26                     167 _ui_mainmenu_render_button::
   2E26 DD E5         [15]  168 	push	ix
   2E28 DD 21 00 00   [14]  169 	ld	ix,#0
   2E2C DD 39         [15]  170 	add	ix,sp
   2E2E 3B            [ 6]  171 	dec	sp
                            172 ;src/UI_MainMenu.c:85: color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   2E2F DD 7E 04      [19]  173 	ld	a,4 (ix)
   2E32 FD 21 7C 5B   [14]  174 	ld	iy,#_ui_mainmenu_entryIndex
   2E36 FD 96 00      [19]  175 	sub	a, 0 (iy)
   2E39 20 10         [12]  176 	jr	NZ,00103$
   2E3B 3A 7D 5B      [13]  177 	ld	a,(#_ui_mainmenu_entrySelected + 0)
   2E3E B7            [ 4]  178 	or	a, a
   2E3F 28 05         [12]  179 	jr	Z,00105$
   2E41 3A 6A 10      [13]  180 	ld	a, (#(_g_colors + 0x0004) + 0)
   2E44 18 08         [12]  181 	jr	00104$
   2E46                     182 00105$:
   2E46 3A 6C 10      [13]  183 	ld	a, (#(_g_colors + 0x0006) + 0)
   2E49 18 03         [12]  184 	jr	00104$
   2E4B                     185 00103$:
   2E4B 3A 68 10      [13]  186 	ld	a, (#(_g_colors + 0x0002) + 0)
   2E4E                     187 00104$:
   2E4E DD 77 FF      [19]  188 	ld	-1 (ix),a
                            189 ;src/UI_MainMenu.c:86: cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, UI_MAINMENU_BUTTON_WIDTH, UI_MAINMENU_BUTTON_HEIGHT);
   2E51 DD 6E 04      [19]  190 	ld	l,4 (ix)
   2E54 26 00         [ 7]  191 	ld	h,#0x00
   2E56 29            [11]  192 	add	hl, hl
   2E57 4D            [ 4]  193 	ld	c, l
   2E58 44            [ 4]  194 	ld	b, h
   2E59 21 B6 2D      [10]  195 	ld	hl,#_ui_mainmenu_entriesPosition
   2E5C 09            [11]  196 	add	hl,bc
   2E5D 5E            [ 7]  197 	ld	e,(hl)
   2E5E 23            [ 6]  198 	inc	hl
   2E5F 56            [ 7]  199 	ld	d,(hl)
   2E60 C5            [11]  200 	push	bc
   2E61 21 14 10      [10]  201 	ld	hl,#0x1014
   2E64 E5            [11]  202 	push	hl
   2E65 DD 7E FF      [19]  203 	ld	a,-1 (ix)
   2E68 F5            [11]  204 	push	af
   2E69 33            [ 6]  205 	inc	sp
   2E6A D5            [11]  206 	push	de
   2E6B CD 62 59      [17]  207 	call	_cpct_drawSolidBox
   2E6E F1            [10]  208 	pop	af
   2E6F F1            [10]  209 	pop	af
   2E70 33            [ 6]  210 	inc	sp
   2E71 C1            [10]  211 	pop	bc
                            212 ;src/UI_MainMenu.c:87: print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesTextPosition[n], 3);
   2E72 21 C0 2D      [10]  213 	ld	hl,#_ui_mainmenu_entriesTextPosition
   2E75 09            [11]  214 	add	hl,bc
   2E76 5E            [ 7]  215 	ld	e,(hl)
   2E77 23            [ 6]  216 	inc	hl
   2E78 56            [ 7]  217 	ld	d,(hl)
   2E79 21 CA 2D      [10]  218 	ld	hl,#_ui_mainmenu_buttonText
   2E7C 09            [11]  219 	add	hl,bc
   2E7D 4E            [ 7]  220 	ld	c,(hl)
   2E7E 23            [ 6]  221 	inc	hl
   2E7F 46            [ 7]  222 	ld	b,(hl)
   2E80 3E 03         [ 7]  223 	ld	a,#0x03
   2E82 F5            [11]  224 	push	af
   2E83 33            [ 6]  225 	inc	sp
   2E84 D5            [11]  226 	push	de
   2E85 C5            [11]  227 	push	bc
   2E86 CD 59 28      [17]  228 	call	_print_transparent_text
   2E89 F1            [10]  229 	pop	af
   2E8A F1            [10]  230 	pop	af
   2E8B 33            [ 6]  231 	inc	sp
   2E8C 33            [ 6]  232 	inc	sp
   2E8D DD E1         [14]  233 	pop	ix
   2E8F C9            [10]  234 	ret
                            235 ;src/UI_MainMenu.c:90: void ui_mainmenu_render_refresh(){
                            236 ;	---------------------------------
                            237 ; Function ui_mainmenu_render_refresh
                            238 ; ---------------------------------
   2E90                     239 _ui_mainmenu_render_refresh::
                            240 ;src/UI_MainMenu.c:92: ui_mainmenu_render_button(ui_mainmenu_entryIndex);
   2E90 3A 7C 5B      [13]  241 	ld	a,(_ui_mainmenu_entryIndex)
   2E93 F5            [11]  242 	push	af
   2E94 33            [ 6]  243 	inc	sp
   2E95 CD 26 2E      [17]  244 	call	_ui_mainmenu_render_button
   2E98 33            [ 6]  245 	inc	sp
                            246 ;src/UI_MainMenu.c:93: ui_mainmenu_render_button(ui_mainmenu_lastEntry);
   2E99 3A 7B 5B      [13]  247 	ld	a,(_ui_mainmenu_lastEntry)
   2E9C F5            [11]  248 	push	af
   2E9D 33            [ 6]  249 	inc	sp
   2E9E CD 26 2E      [17]  250 	call	_ui_mainmenu_render_button
   2EA1 33            [ 6]  251 	inc	sp
                            252 ;src/UI_MainMenu.c:95: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   2EA2 3A 7C 5B      [13]  253 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2EA5 32 7B 5B      [13]  254 	ld	(#_ui_mainmenu_lastEntry + 0),a
   2EA8 C9            [10]  255 	ret
                            256 ;src/UI_MainMenu.c:99: void ui_mainmenu_render_all(){
                            257 ;	---------------------------------
                            258 ; Function ui_mainmenu_render_all
                            259 ; ---------------------------------
   2EA9                     260 _ui_mainmenu_render_all::
                            261 ;src/UI_MainMenu.c:103: while(n){
   2EA9 06 05         [ 7]  262 	ld	b,#0x05
   2EAB                     263 00101$:
   2EAB 78            [ 4]  264 	ld	a,b
   2EAC B7            [ 4]  265 	or	a, a
   2EAD 28 0B         [12]  266 	jr	Z,00103$
                            267 ;src/UI_MainMenu.c:104: --n;
   2EAF 05            [ 4]  268 	dec	b
                            269 ;src/UI_MainMenu.c:105: ui_mainmenu_render_button(n);
   2EB0 C5            [11]  270 	push	bc
   2EB1 C5            [11]  271 	push	bc
   2EB2 33            [ 6]  272 	inc	sp
   2EB3 CD 26 2E      [17]  273 	call	_ui_mainmenu_render_button
   2EB6 33            [ 6]  274 	inc	sp
   2EB7 C1            [10]  275 	pop	bc
   2EB8 18 F1         [12]  276 	jr	00101$
   2EBA                     277 00103$:
                            278 ;src/UI_MainMenu.c:108: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   2EBA 3A 7C 5B      [13]  279 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2EBD 32 7B 5B      [13]  280 	ld	(#_ui_mainmenu_lastEntry + 0),a
   2EC0 C9            [10]  281 	ret
                            282 ;src/UI_MainMenu.c:111: u8 ui_mainmenu_get_entry(){
                            283 ;	---------------------------------
                            284 ; Function ui_mainmenu_get_entry
                            285 ; ---------------------------------
   2EC1                     286 _ui_mainmenu_get_entry::
                            287 ;src/UI_MainMenu.c:112: return ui_mainmenu_entryIndex;
   2EC1 FD 21 7C 5B   [14]  288 	ld	iy,#_ui_mainmenu_entryIndex
   2EC5 FD 6E 00      [19]  289 	ld	l,0 (iy)
   2EC8 C9            [10]  290 	ret
                            291 ;src/UI_MainMenu.c:115: u8 ui_mainmenu_is_selected(){
                            292 ;	---------------------------------
                            293 ; Function ui_mainmenu_is_selected
                            294 ; ---------------------------------
   2EC9                     295 _ui_mainmenu_is_selected::
                            296 ;src/UI_MainMenu.c:116: return ui_mainmenu_entrySelected;
   2EC9 FD 21 7D 5B   [14]  297 	ld	iy,#_ui_mainmenu_entrySelected
   2ECD FD 6E 00      [19]  298 	ld	l,0 (iy)
   2ED0 C9            [10]  299 	ret
                            300 	.area _CODE
                            301 	.area _INITIALIZER
                            302 	.area _CABS (ABS)
