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
                             36 ;--------------------------------------------------------
                             37 ; ram data
                             38 ;--------------------------------------------------------
                             39 	.area _INITIALIZED
   4AB3                      40 _ui_pausemenu_lastEntry::
   4AB3                      41 	.ds 1
   4AB4                      42 _ui_pausemenu_entryIndex::
   4AB4                      43 	.ds 1
   4AB5                      44 _ui_pausemenu_entrySelected::
   4AB5                      45 	.ds 1
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
   2968                      70 _ui_pausemenu_init::
                             71 ;src/UI_PauseMenu.c:58: ui_pausemenu_lastEntry=0;
   2968 21 B3 4A      [10]   72 	ld	hl,#_ui_pausemenu_lastEntry + 0
   296B 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_PauseMenu.c:59: ui_pausemenu_entryIndex=0;
   296D 21 B4 4A      [10]   75 	ld	hl,#_ui_pausemenu_entryIndex + 0
   2970 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_PauseMenu.c:60: ui_pausemenu_entrySelected=0;
   2972 21 B5 4A      [10]   78 	ld	hl,#_ui_pausemenu_entrySelected + 0
   2975 36 00         [10]   79 	ld	(hl), #0x00
   2977 C9            [10]   80 	ret
   2978                      81 _ui_pausemenu_entriesPosition:
   2978 AA C1                82 	.dw #0xC1AA
   297A EA C2                83 	.dw #0xC2EA
   297C 2A C4                84 	.dw #0xC42A
   297E 6A C5                85 	.dw #0xC56A
   2980                      86 _ui_pausemenu_entriesTextPosition:
   2980 00 CA                87 	.dw #0xCA00
   2982 42 CB                88 	.dw #0xCB42
   2984 7C CC                89 	.dw #0xCC7C
   2986 C4 CD                90 	.dw #0xCDC4
   2988                      91 _ui_pausemenu_buttonText:
   2988 90 29                92 	.dw __str_0
   298A 99 29                93 	.dw __str_1
   298C A1 29                94 	.dw __str_2
   298E AF 29                95 	.dw __str_3
   2990                      96 __str_0:
   2990 43 4F 4E 54 49 4E    97 	.ascii "CONTINUE"
        55 45
   2998 00                   98 	.db 0x00
   2999                      99 __str_1:
   2999 4F 50 54 49 4F 4E   100 	.ascii "OPTIONS"
        53
   29A0 00                  101 	.db 0x00
   29A1                     102 __str_2:
   29A1 53 41 56 45 20 41   103 	.ascii "SAVE AND EXIT"
        4E 44 20 45 58 49
        54
   29AE 00                  104 	.db 0x00
   29AF                     105 __str_3:
   29AF 45 58 49 54         106 	.ascii "EXIT"
   29B3 00                  107 	.db 0x00
                            108 ;src/UI_PauseMenu.c:63: u8 ui_pausemenu_get_entry(){
                            109 ;	---------------------------------
                            110 ; Function ui_pausemenu_get_entry
                            111 ; ---------------------------------
   29B4                     112 _ui_pausemenu_get_entry::
                            113 ;src/UI_PauseMenu.c:64: return ui_pausemenu_entryIndex;
   29B4 FD 21 B4 4A   [14]  114 	ld	iy,#_ui_pausemenu_entryIndex
   29B8 FD 6E 00      [19]  115 	ld	l,0 (iy)
   29BB C9            [10]  116 	ret
                            117 ;src/UI_PauseMenu.c:67: u8 ui_pausemenu_is_selected(){
                            118 ;	---------------------------------
                            119 ; Function ui_pausemenu_is_selected
                            120 ; ---------------------------------
   29BC                     121 _ui_pausemenu_is_selected::
                            122 ;src/UI_PauseMenu.c:68: return ui_pausemenu_entrySelected;
   29BC FD 21 B5 4A   [14]  123 	ld	iy,#_ui_pausemenu_entrySelected
   29C0 FD 6E 00      [19]  124 	ld	l,0 (iy)
   29C3 C9            [10]  125 	ret
                            126 ;src/UI_PauseMenu.c:71: void ui_pausemenu_next_entry(){
                            127 ;	---------------------------------
                            128 ; Function ui_pausemenu_next_entry
                            129 ; ---------------------------------
   29C4                     130 _ui_pausemenu_next_entry::
                            131 ;src/UI_PauseMenu.c:72: if(ui_pausemenu_entryIndex<(UI_PAUSEMENU_ENTRIES-1)){
                            132 ;src/UI_PauseMenu.c:73: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   29C4 3A B4 4A      [13]  133 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   29C7 FE 03         [ 7]  134 	cp	a,#0x03
   29C9 D0            [11]  135 	ret	NC
   29CA 32 B3 4A      [13]  136 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            137 ;src/UI_PauseMenu.c:74: ++ui_pausemenu_entryIndex;
   29CD 21 B4 4A      [10]  138 	ld	hl, #_ui_pausemenu_entryIndex+0
   29D0 34            [11]  139 	inc	(hl)
   29D1 C9            [10]  140 	ret
                            141 ;src/UI_PauseMenu.c:78: void ui_pausemenu_previous_entry(){
                            142 ;	---------------------------------
                            143 ; Function ui_pausemenu_previous_entry
                            144 ; ---------------------------------
   29D2                     145 _ui_pausemenu_previous_entry::
                            146 ;src/UI_PauseMenu.c:79: if(ui_pausemenu_entryIndex>0){
   29D2 3A B4 4A      [13]  147 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   29D5 B7            [ 4]  148 	or	a, a
   29D6 C8            [11]  149 	ret	Z
                            150 ;src/UI_PauseMenu.c:80: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   29D7 3A B4 4A      [13]  151 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   29DA 32 B3 4A      [13]  152 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            153 ;src/UI_PauseMenu.c:81: --ui_pausemenu_entryIndex;
   29DD 21 B4 4A      [10]  154 	ld	hl, #_ui_pausemenu_entryIndex+0
   29E0 35            [11]  155 	dec	(hl)
   29E1 C9            [10]  156 	ret
                            157 ;src/UI_PauseMenu.c:85: void ui_pausemenu_select_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_pausemenu_select_entry
                            160 ; ---------------------------------
   29E2                     161 _ui_pausemenu_select_entry::
                            162 ;src/UI_PauseMenu.c:86: ui_pausemenu_entrySelected=1;
   29E2 21 B5 4A      [10]  163 	ld	hl,#_ui_pausemenu_entrySelected + 0
   29E5 36 01         [10]  164 	ld	(hl), #0x01
   29E7 C9            [10]  165 	ret
                            166 ;src/UI_PauseMenu.c:89: void ui_pausemenu_unselect_entry(){
                            167 ;	---------------------------------
                            168 ; Function ui_pausemenu_unselect_entry
                            169 ; ---------------------------------
   29E8                     170 _ui_pausemenu_unselect_entry::
                            171 ;src/UI_PauseMenu.c:90: ui_pausemenu_entrySelected=0;
   29E8 21 B5 4A      [10]  172 	ld	hl,#_ui_pausemenu_entrySelected + 0
   29EB 36 00         [10]  173 	ld	(hl), #0x00
   29ED C9            [10]  174 	ret
                            175 ;src/UI_PauseMenu.c:93: void ui_pausemenu_render_button(u8 n){
                            176 ;	---------------------------------
                            177 ; Function ui_pausemenu_render_button
                            178 ; ---------------------------------
   29EE                     179 _ui_pausemenu_render_button::
   29EE DD E5         [15]  180 	push	ix
   29F0 DD 21 00 00   [14]  181 	ld	ix,#0
   29F4 DD 39         [15]  182 	add	ix,sp
                            183 ;src/UI_PauseMenu.c:95: color = (n==ui_pausemenu_entryIndex)?((ui_pausemenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
   29F6 DD 7E 04      [19]  184 	ld	a,4 (ix)
   29F9 FD 21 B4 4A   [14]  185 	ld	iy,#_ui_pausemenu_entryIndex
   29FD FD 96 00      [19]  186 	sub	a, 0 (iy)
   2A00 20 10         [12]  187 	jr	NZ,00103$
   2A02 3A B5 4A      [13]  188 	ld	a,(#_ui_pausemenu_entrySelected + 0)
   2A05 B7            [ 4]  189 	or	a, a
   2A06 28 05         [12]  190 	jr	Z,00105$
   2A08 3A A7 0A      [13]  191 	ld	a, (#(_g_colors + 0x0004) + 0)
   2A0B 18 08         [12]  192 	jr	00104$
   2A0D                     193 00105$:
   2A0D 3A A8 0A      [13]  194 	ld	a, (#(_g_colors + 0x0005) + 0)
   2A10 18 03         [12]  195 	jr	00104$
   2A12                     196 00103$:
   2A12 3A A5 0A      [13]  197 	ld	a, (#(_g_colors + 0x0002) + 0)
   2A15                     198 00104$:
   2A15 47            [ 4]  199 	ld	b,a
                            200 ;src/UI_PauseMenu.c:96: cpct_drawSolidBox(ui_pausemenu_entriesPosition[n],color, UI_PAUSEMENU_BUTTON_WIDTH, UI_PAUSEMENU_BUTTON_HEIGHT);
   2A16 DD 6E 04      [19]  201 	ld	l,4 (ix)
   2A19 26 00         [ 7]  202 	ld	h,#0x00
   2A1B 29            [11]  203 	add	hl, hl
   2A1C EB            [ 4]  204 	ex	de,hl
   2A1D 21 78 29      [10]  205 	ld	hl,#_ui_pausemenu_entriesPosition
   2A20 19            [11]  206 	add	hl,de
   2A21 7E            [ 7]  207 	ld	a, (hl)
   2A22 23            [ 6]  208 	inc	hl
   2A23 66            [ 7]  209 	ld	h,(hl)
   2A24 6F            [ 4]  210 	ld	l,a
   2A25 E5            [11]  211 	push	hl
   2A26 FD E1         [14]  212 	pop	iy
   2A28 D5            [11]  213 	push	de
   2A29 21 1C 18      [10]  214 	ld	hl,#0x181C
   2A2C E5            [11]  215 	push	hl
   2A2D C5            [11]  216 	push	bc
   2A2E 33            [ 6]  217 	inc	sp
   2A2F FD E5         [15]  218 	push	iy
   2A31 CD CB 48      [17]  219 	call	_cpct_drawSolidBox
   2A34 F1            [10]  220 	pop	af
   2A35 F1            [10]  221 	pop	af
   2A36 33            [ 6]  222 	inc	sp
   2A37 D1            [10]  223 	pop	de
                            224 ;src/UI_PauseMenu.c:97: print_transparent_text(ui_pausemenu_buttonText[n], ui_pausemenu_entriesTextPosition[n], 3);
   2A38 21 80 29      [10]  225 	ld	hl,#_ui_pausemenu_entriesTextPosition
   2A3B 19            [11]  226 	add	hl,de
   2A3C 4E            [ 7]  227 	ld	c,(hl)
   2A3D 23            [ 6]  228 	inc	hl
   2A3E 46            [ 7]  229 	ld	b,(hl)
   2A3F 21 88 29      [10]  230 	ld	hl,#_ui_pausemenu_buttonText
   2A42 19            [11]  231 	add	hl,de
   2A43 5E            [ 7]  232 	ld	e,(hl)
   2A44 23            [ 6]  233 	inc	hl
   2A45 56            [ 7]  234 	ld	d,(hl)
   2A46 3E 03         [ 7]  235 	ld	a,#0x03
   2A48 F5            [11]  236 	push	af
   2A49 33            [ 6]  237 	inc	sp
   2A4A C5            [11]  238 	push	bc
   2A4B D5            [11]  239 	push	de
   2A4C CD 67 22      [17]  240 	call	_print_transparent_text
   2A4F F1            [10]  241 	pop	af
   2A50 F1            [10]  242 	pop	af
   2A51 33            [ 6]  243 	inc	sp
   2A52 DD E1         [14]  244 	pop	ix
   2A54 C9            [10]  245 	ret
                            246 ;src/UI_PauseMenu.c:100: void ui_pausemenu_render_refresh(){
                            247 ;	---------------------------------
                            248 ; Function ui_pausemenu_render_refresh
                            249 ; ---------------------------------
   2A55                     250 _ui_pausemenu_render_refresh::
                            251 ;src/UI_PauseMenu.c:102: ui_pausemenu_render_button(ui_pausemenu_entryIndex);
   2A55 3A B4 4A      [13]  252 	ld	a,(_ui_pausemenu_entryIndex)
   2A58 F5            [11]  253 	push	af
   2A59 33            [ 6]  254 	inc	sp
   2A5A CD EE 29      [17]  255 	call	_ui_pausemenu_render_button
   2A5D 33            [ 6]  256 	inc	sp
                            257 ;src/UI_PauseMenu.c:103: ui_pausemenu_render_button(ui_pausemenu_lastEntry);
   2A5E 3A B3 4A      [13]  258 	ld	a,(_ui_pausemenu_lastEntry)
   2A61 F5            [11]  259 	push	af
   2A62 33            [ 6]  260 	inc	sp
   2A63 CD EE 29      [17]  261 	call	_ui_pausemenu_render_button
   2A66 33            [ 6]  262 	inc	sp
                            263 ;src/UI_PauseMenu.c:105: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   2A67 3A B4 4A      [13]  264 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2A6A 32 B3 4A      [13]  265 	ld	(#_ui_pausemenu_lastEntry + 0),a
   2A6D C9            [10]  266 	ret
                            267 ;src/UI_PauseMenu.c:108: void ui_pausemenu_render_all(){
                            268 ;	---------------------------------
                            269 ; Function ui_pausemenu_render_all
                            270 ; ---------------------------------
   2A6E                     271 _ui_pausemenu_render_all::
                            272 ;src/UI_PauseMenu.c:112: while(n){
   2A6E 06 04         [ 7]  273 	ld	b,#0x04
   2A70                     274 00101$:
   2A70 78            [ 4]  275 	ld	a,b
   2A71 B7            [ 4]  276 	or	a, a
   2A72 28 0B         [12]  277 	jr	Z,00103$
                            278 ;src/UI_PauseMenu.c:113: --n;
   2A74 05            [ 4]  279 	dec	b
                            280 ;src/UI_PauseMenu.c:114: ui_pausemenu_render_button(n);
   2A75 C5            [11]  281 	push	bc
   2A76 C5            [11]  282 	push	bc
   2A77 33            [ 6]  283 	inc	sp
   2A78 CD EE 29      [17]  284 	call	_ui_pausemenu_render_button
   2A7B 33            [ 6]  285 	inc	sp
   2A7C C1            [10]  286 	pop	bc
   2A7D 18 F1         [12]  287 	jr	00101$
   2A7F                     288 00103$:
                            289 ;src/UI_PauseMenu.c:117: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   2A7F 3A B4 4A      [13]  290 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2A82 32 B3 4A      [13]  291 	ld	(#_ui_pausemenu_lastEntry + 0),a
   2A85 C9            [10]  292 	ret
                            293 	.area _CODE
                            294 	.area _INITIALIZER
   4AC0                     295 __xinit__ui_pausemenu_lastEntry:
   4AC0 00                  296 	.db #0x00	; 0
   4AC1                     297 __xinit__ui_pausemenu_entryIndex:
   4AC1 00                  298 	.db #0x00	; 0
   4AC2                     299 __xinit__ui_pausemenu_entrySelected:
   4AC2 00                  300 	.db #0x00	; 0
                            301 	.area _CABS (ABS)
