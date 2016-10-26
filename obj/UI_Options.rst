                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_Options
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_options_render_button
                             12 	.globl _print_transparent_text
                             13 	.globl _cpct_drawSolidBox
                             14 	.globl _ui_options_entrySelected
                             15 	.globl _ui_options_entryIndex
                             16 	.globl _ui_options_lastEntry
                             17 	.globl _ui_options_buttonText
                             18 	.globl _ui_options_on_off
                             19 	.globl _ui_options_entriesTextPosition
                             20 	.globl _ui_options_entriesPosition
                             21 	.globl _ui_options_set_strings
                             22 	.globl _ui_options_init
                             23 	.globl _ui_options_get_entry
                             24 	.globl _ui_options_is_selected
                             25 	.globl _ui_options_next_entry
                             26 	.globl _ui_options_previous_entry
                             27 	.globl _ui_options_select_entry
                             28 	.globl _ui_options_unselect_entry
                             29 	.globl _ui_options_render_refresh
                             30 	.globl _ui_options_render_all
                             31 ;--------------------------------------------------------
                             32 ; special function registers
                             33 ;--------------------------------------------------------
                             34 ;--------------------------------------------------------
                             35 ; ram data
                             36 ;--------------------------------------------------------
                             37 	.area _DATA
   87A1                      38 _ui_options_lastEntry::
   87A1                      39 	.ds 1
   87A2                      40 _ui_options_entryIndex::
   87A2                      41 	.ds 1
   87A3                      42 _ui_options_entrySelected::
   87A3                      43 	.ds 1
                             44 ;--------------------------------------------------------
                             45 ; ram data
                             46 ;--------------------------------------------------------
                             47 	.area _INITIALIZED
                             48 ;--------------------------------------------------------
                             49 ; absolute external ram data
                             50 ;--------------------------------------------------------
                             51 	.area _DABS (ABS)
                             52 ;--------------------------------------------------------
                             53 ; global & static initialisations
                             54 ;--------------------------------------------------------
                             55 	.area _HOME
                             56 	.area _GSINIT
                             57 	.area _GSFINAL
                             58 	.area _GSINIT
                             59 ;--------------------------------------------------------
                             60 ; Home
                             61 ;--------------------------------------------------------
                             62 	.area _HOME
                             63 	.area _HOME
                             64 ;--------------------------------------------------------
                             65 ; code
                             66 ;--------------------------------------------------------
                             67 	.area _CODE
                             68 ;src/UI_Options.c:58: void ui_options_set_strings(){
                             69 ;	---------------------------------
                             70 ; Function ui_options_set_strings
                             71 ; ---------------------------------
   4AAD                      72 _ui_options_set_strings::
                             73 ;src/UI_Options.c:59: *(char**)(ui_options_buttonText)=ui_options_on_off[textures_on];
   4AAD 01 E1 4A      [10]   74 	ld	bc,#_ui_options_on_off+0
   4AB0 FD 21 D8 86   [14]   75 	ld	iy,#_textures_on
   4AB4 FD 6E 00      [19]   76 	ld	l,0 (iy)
   4AB7 26 00         [ 7]   77 	ld	h,#0x00
   4AB9 29            [11]   78 	add	hl, hl
   4ABA 09            [11]   79 	add	hl,bc
   4ABB 5E            [ 7]   80 	ld	e,(hl)
   4ABC 23            [ 6]   81 	inc	hl
   4ABD 56            [ 7]   82 	ld	d,(hl)
   4ABE ED 53 E5 4A   [20]   83 	ld	(_ui_options_buttonText), de
                             84 ;src/UI_Options.c:60: *(char**)(ui_options_buttonText+1)=ui_options_on_off[music_on];
   4AC2 FD 21 D7 86   [14]   85 	ld	iy,#_music_on
   4AC6 FD 6E 00      [19]   86 	ld	l,0 (iy)
   4AC9 26 00         [ 7]   87 	ld	h,#0x00
   4ACB 29            [11]   88 	add	hl, hl
   4ACC 09            [11]   89 	add	hl,bc
   4ACD 4E            [ 7]   90 	ld	c,(hl)
   4ACE 23            [ 6]   91 	inc	hl
   4ACF 46            [ 7]   92 	ld	b,(hl)
   4AD0 ED 43 E7 4A   [20]   93 	ld	((_ui_options_buttonText + 0x0002)), bc
   4AD4 C9            [10]   94 	ret
   4AD5                      95 _ui_options_entriesPosition:
   4AD5 FB C2                96 	.dw #0xC2FB
   4AD7 9B E3                97 	.dw #0xE39B
   4AD9 82 C4                98 	.dw #0xC482
   4ADB                      99 _ui_options_entriesTextPosition:
   4ADB FE EA               100 	.dw #0xEAFE
   4ADD EE CB               101 	.dw #0xCBEE
   4ADF 84 EC               102 	.dw #0xEC84
   4AE1                     103 _ui_options_on_off:
   4AE1 EB 4A               104 	.dw __str_0
   4AE3 EF 4A               105 	.dw __str_1
   4AE5                     106 _ui_options_buttonText:
   4AE5 F2 4A               107 	.dw __str_2
   4AE7 F2 4A               108 	.dw __str_2
   4AE9 F3 4A               109 	.dw __str_3
   4AEB                     110 __str_0:
   4AEB 4F 46 46            111 	.ascii "OFF"
   4AEE 00                  112 	.db 0x00
   4AEF                     113 __str_1:
   4AEF 4F 4E               114 	.ascii "ON"
   4AF1 00                  115 	.db 0x00
   4AF2                     116 __str_2:
   4AF2 00                  117 	.db 0x00
   4AF3                     118 __str_3:
   4AF3 45 58 49 54         119 	.ascii "EXIT"
   4AF7 00                  120 	.db 0x00
                            121 ;src/UI_Options.c:64: void ui_options_init(){
                            122 ;	---------------------------------
                            123 ; Function ui_options_init
                            124 ; ---------------------------------
   4AF8                     125 _ui_options_init::
                            126 ;src/UI_Options.c:65: ui_options_lastEntry=0;
   4AF8 21 A1 87      [10]  127 	ld	hl,#_ui_options_lastEntry + 0
   4AFB 36 00         [10]  128 	ld	(hl), #0x00
                            129 ;src/UI_Options.c:66: ui_options_entryIndex=0;
   4AFD 21 A2 87      [10]  130 	ld	hl,#_ui_options_entryIndex + 0
   4B00 36 00         [10]  131 	ld	(hl), #0x00
                            132 ;src/UI_Options.c:67: ui_options_entrySelected=0;
   4B02 21 A3 87      [10]  133 	ld	hl,#_ui_options_entrySelected + 0
   4B05 36 00         [10]  134 	ld	(hl), #0x00
                            135 ;src/UI_Options.c:68: ui_options_set_strings();
   4B07 C3 AD 4A      [10]  136 	jp  _ui_options_set_strings
                            137 ;src/UI_Options.c:72: u8 ui_options_get_entry(){
                            138 ;	---------------------------------
                            139 ; Function ui_options_get_entry
                            140 ; ---------------------------------
   4B0A                     141 _ui_options_get_entry::
                            142 ;src/UI_Options.c:73: return ui_options_entryIndex;
   4B0A FD 21 A2 87   [14]  143 	ld	iy,#_ui_options_entryIndex
   4B0E FD 6E 00      [19]  144 	ld	l,0 (iy)
   4B11 C9            [10]  145 	ret
                            146 ;src/UI_Options.c:76: u8 ui_options_is_selected(){
                            147 ;	---------------------------------
                            148 ; Function ui_options_is_selected
                            149 ; ---------------------------------
   4B12                     150 _ui_options_is_selected::
                            151 ;src/UI_Options.c:77: return ui_options_entrySelected;
   4B12 FD 21 A3 87   [14]  152 	ld	iy,#_ui_options_entrySelected
   4B16 FD 6E 00      [19]  153 	ld	l,0 (iy)
   4B19 C9            [10]  154 	ret
                            155 ;src/UI_Options.c:80: void ui_options_next_entry(){
                            156 ;	---------------------------------
                            157 ; Function ui_options_next_entry
                            158 ; ---------------------------------
   4B1A                     159 _ui_options_next_entry::
                            160 ;src/UI_Options.c:81: if(ui_options_entryIndex<(UI_OPTIONS_ENTRIES-1)){
                            161 ;src/UI_Options.c:82: ui_options_lastEntry=ui_options_entryIndex;
   4B1A 3A A2 87      [13]  162 	ld	a,(#_ui_options_entryIndex + 0)
   4B1D FE 02         [ 7]  163 	cp	a,#0x02
   4B1F D0            [11]  164 	ret	NC
   4B20 32 A1 87      [13]  165 	ld	(#_ui_options_lastEntry + 0),a
                            166 ;src/UI_Options.c:83: ++ui_options_entryIndex;
   4B23 21 A2 87      [10]  167 	ld	hl, #_ui_options_entryIndex+0
   4B26 34            [11]  168 	inc	(hl)
   4B27 C9            [10]  169 	ret
                            170 ;src/UI_Options.c:87: void ui_options_previous_entry(){
                            171 ;	---------------------------------
                            172 ; Function ui_options_previous_entry
                            173 ; ---------------------------------
   4B28                     174 _ui_options_previous_entry::
                            175 ;src/UI_Options.c:88: if(ui_options_entryIndex>0){
   4B28 3A A2 87      [13]  176 	ld	a,(#_ui_options_entryIndex + 0)
   4B2B B7            [ 4]  177 	or	a, a
   4B2C C8            [11]  178 	ret	Z
                            179 ;src/UI_Options.c:89: ui_options_lastEntry=ui_options_entryIndex;
   4B2D 3A A2 87      [13]  180 	ld	a,(#_ui_options_entryIndex + 0)
   4B30 32 A1 87      [13]  181 	ld	(#_ui_options_lastEntry + 0),a
                            182 ;src/UI_Options.c:90: --ui_options_entryIndex;
   4B33 21 A2 87      [10]  183 	ld	hl, #_ui_options_entryIndex+0
   4B36 35            [11]  184 	dec	(hl)
   4B37 C9            [10]  185 	ret
                            186 ;src/UI_Options.c:95: void ui_options_select_entry(){
                            187 ;	---------------------------------
                            188 ; Function ui_options_select_entry
                            189 ; ---------------------------------
   4B38                     190 _ui_options_select_entry::
                            191 ;src/UI_Options.c:96: ui_options_entrySelected=1;
   4B38 21 A3 87      [10]  192 	ld	hl,#_ui_options_entrySelected + 0
   4B3B 36 01         [10]  193 	ld	(hl), #0x01
   4B3D C9            [10]  194 	ret
                            195 ;src/UI_Options.c:99: void ui_options_unselect_entry(){
                            196 ;	---------------------------------
                            197 ; Function ui_options_unselect_entry
                            198 ; ---------------------------------
   4B3E                     199 _ui_options_unselect_entry::
                            200 ;src/UI_Options.c:100: ui_options_entrySelected=0;
   4B3E 21 A3 87      [10]  201 	ld	hl,#_ui_options_entrySelected + 0
   4B41 36 00         [10]  202 	ld	(hl), #0x00
   4B43 C9            [10]  203 	ret
                            204 ;src/UI_Options.c:103: void ui_options_render_button(u8 n){
                            205 ;	---------------------------------
                            206 ; Function ui_options_render_button
                            207 ; ---------------------------------
   4B44                     208 _ui_options_render_button::
   4B44 DD E5         [15]  209 	push	ix
   4B46 DD 21 00 00   [14]  210 	ld	ix,#0
   4B4A DD 39         [15]  211 	add	ix,sp
   4B4C 3B            [ 6]  212 	dec	sp
                            213 ;src/UI_Options.c:105: color = (n==ui_options_entryIndex)?((ui_options_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4B4D DD 7E 04      [19]  214 	ld	a,4 (ix)
   4B50 FD 21 A2 87   [14]  215 	ld	iy,#_ui_options_entryIndex
   4B54 FD 96 00      [19]  216 	sub	a, 0 (iy)
   4B57 20 10         [12]  217 	jr	NZ,00103$
   4B59 3A A3 87      [13]  218 	ld	a,(#_ui_options_entrySelected + 0)
   4B5C B7            [ 4]  219 	or	a, a
   4B5D 28 05         [12]  220 	jr	Z,00105$
   4B5F 3A 2C 1C      [13]  221 	ld	a, (#(_g_colors + 0x0004) + 0)
   4B62 18 08         [12]  222 	jr	00104$
   4B64                     223 00105$:
   4B64 3A 2E 1C      [13]  224 	ld	a, (#(_g_colors + 0x0006) + 0)
   4B67 18 03         [12]  225 	jr	00104$
   4B69                     226 00103$:
   4B69 3A 2A 1C      [13]  227 	ld	a, (#(_g_colors + 0x0002) + 0)
   4B6C                     228 00104$:
   4B6C DD 77 FF      [19]  229 	ld	-1 (ix),a
                            230 ;src/UI_Options.c:106: cpct_drawSolidBox(ui_options_entriesPosition[n],color, UI_OPTIONS_BUTTON_WIDTH, UI_OPTIONS_BUTTON_HEIGHT);
   4B6F DD 6E 04      [19]  231 	ld	l,4 (ix)
   4B72 26 00         [ 7]  232 	ld	h,#0x00
   4B74 29            [11]  233 	add	hl, hl
   4B75 4D            [ 4]  234 	ld	c, l
   4B76 44            [ 4]  235 	ld	b, h
   4B77 21 D5 4A      [10]  236 	ld	hl,#_ui_options_entriesPosition
   4B7A 09            [11]  237 	add	hl,bc
   4B7B 5E            [ 7]  238 	ld	e,(hl)
   4B7C 23            [ 6]  239 	inc	hl
   4B7D 56            [ 7]  240 	ld	d,(hl)
   4B7E C5            [11]  241 	push	bc
   4B7F 21 0C 10      [10]  242 	ld	hl,#0x100C
   4B82 E5            [11]  243 	push	hl
   4B83 DD 7E FF      [19]  244 	ld	a,-1 (ix)
   4B86 F5            [11]  245 	push	af
   4B87 33            [ 6]  246 	inc	sp
   4B88 D5            [11]  247 	push	de
   4B89 CD 2F 85      [17]  248 	call	_cpct_drawSolidBox
   4B8C F1            [10]  249 	pop	af
   4B8D F1            [10]  250 	pop	af
   4B8E 33            [ 6]  251 	inc	sp
   4B8F C1            [10]  252 	pop	bc
                            253 ;src/UI_Options.c:107: print_transparent_text(ui_options_buttonText[n], ui_options_entriesTextPosition[n], 3);
   4B90 21 DB 4A      [10]  254 	ld	hl,#_ui_options_entriesTextPosition
   4B93 09            [11]  255 	add	hl,bc
   4B94 5E            [ 7]  256 	ld	e,(hl)
   4B95 23            [ 6]  257 	inc	hl
   4B96 56            [ 7]  258 	ld	d,(hl)
   4B97 21 E5 4A      [10]  259 	ld	hl,#_ui_options_buttonText
   4B9A 09            [11]  260 	add	hl,bc
   4B9B 4E            [ 7]  261 	ld	c,(hl)
   4B9C 23            [ 6]  262 	inc	hl
   4B9D 46            [ 7]  263 	ld	b,(hl)
   4B9E 3E 03         [ 7]  264 	ld	a,#0x03
   4BA0 F5            [11]  265 	push	af
   4BA1 33            [ 6]  266 	inc	sp
   4BA2 D5            [11]  267 	push	de
   4BA3 C5            [11]  268 	push	bc
   4BA4 CD 14 41      [17]  269 	call	_print_transparent_text
   4BA7 F1            [10]  270 	pop	af
   4BA8 F1            [10]  271 	pop	af
   4BA9 33            [ 6]  272 	inc	sp
   4BAA 33            [ 6]  273 	inc	sp
   4BAB DD E1         [14]  274 	pop	ix
   4BAD C9            [10]  275 	ret
                            276 ;src/UI_Options.c:111: void ui_options_render_refresh(){
                            277 ;	---------------------------------
                            278 ; Function ui_options_render_refresh
                            279 ; ---------------------------------
   4BAE                     280 _ui_options_render_refresh::
                            281 ;src/UI_Options.c:113: ui_options_render_button(ui_options_entryIndex);
   4BAE 3A A2 87      [13]  282 	ld	a,(_ui_options_entryIndex)
   4BB1 F5            [11]  283 	push	af
   4BB2 33            [ 6]  284 	inc	sp
   4BB3 CD 44 4B      [17]  285 	call	_ui_options_render_button
   4BB6 33            [ 6]  286 	inc	sp
                            287 ;src/UI_Options.c:114: ui_options_render_button(ui_options_lastEntry);
   4BB7 3A A1 87      [13]  288 	ld	a,(_ui_options_lastEntry)
   4BBA F5            [11]  289 	push	af
   4BBB 33            [ 6]  290 	inc	sp
   4BBC CD 44 4B      [17]  291 	call	_ui_options_render_button
   4BBF 33            [ 6]  292 	inc	sp
                            293 ;src/UI_Options.c:116: ui_options_lastEntry=ui_options_entryIndex;
   4BC0 3A A2 87      [13]  294 	ld	a,(#_ui_options_entryIndex + 0)
   4BC3 32 A1 87      [13]  295 	ld	(#_ui_options_lastEntry + 0),a
   4BC6 C9            [10]  296 	ret
                            297 ;src/UI_Options.c:119: void ui_options_render_all(){
                            298 ;	---------------------------------
                            299 ; Function ui_options_render_all
                            300 ; ---------------------------------
   4BC7                     301 _ui_options_render_all::
                            302 ;src/UI_Options.c:122: print_transparent_text("TEXTURES", UI_OPTIONS_BUTTON_TEXT_LABEL_POSITION, 3);
   4BC7 3E 03         [ 7]  303 	ld	a,#0x03
   4BC9 F5            [11]  304 	push	af
   4BCA 33            [ 6]  305 	inc	sp
   4BCB 21 EA EA      [10]  306 	ld	hl,#0xEAEA
   4BCE E5            [11]  307 	push	hl
   4BCF 21 03 4C      [10]  308 	ld	hl,#___str_4
   4BD2 E5            [11]  309 	push	hl
   4BD3 CD 14 41      [17]  310 	call	_print_transparent_text
   4BD6 F1            [10]  311 	pop	af
   4BD7 F1            [10]  312 	pop	af
   4BD8 33            [ 6]  313 	inc	sp
                            314 ;src/UI_Options.c:123: print_transparent_text("MUSIC", UI_OPTIONS_BUTTON_MUSIC_LABEL_POSITION, 3);
   4BD9 3E 03         [ 7]  315 	ld	a,#0x03
   4BDB F5            [11]  316 	push	af
   4BDC 33            [ 6]  317 	inc	sp
   4BDD 21 DA CB      [10]  318 	ld	hl,#0xCBDA
   4BE0 E5            [11]  319 	push	hl
   4BE1 21 0C 4C      [10]  320 	ld	hl,#___str_5
   4BE4 E5            [11]  321 	push	hl
   4BE5 CD 14 41      [17]  322 	call	_print_transparent_text
   4BE8 F1            [10]  323 	pop	af
   4BE9 F1            [10]  324 	pop	af
   4BEA 33            [ 6]  325 	inc	sp
                            326 ;src/UI_Options.c:125: while(n){
   4BEB 06 03         [ 7]  327 	ld	b,#0x03
   4BED                     328 00101$:
   4BED 78            [ 4]  329 	ld	a,b
   4BEE B7            [ 4]  330 	or	a, a
   4BEF 28 0B         [12]  331 	jr	Z,00103$
                            332 ;src/UI_Options.c:126: --n;
   4BF1 05            [ 4]  333 	dec	b
                            334 ;src/UI_Options.c:127: ui_options_render_button(n);
   4BF2 C5            [11]  335 	push	bc
   4BF3 C5            [11]  336 	push	bc
   4BF4 33            [ 6]  337 	inc	sp
   4BF5 CD 44 4B      [17]  338 	call	_ui_options_render_button
   4BF8 33            [ 6]  339 	inc	sp
   4BF9 C1            [10]  340 	pop	bc
   4BFA 18 F1         [12]  341 	jr	00101$
   4BFC                     342 00103$:
                            343 ;src/UI_Options.c:130: ui_options_lastEntry=ui_options_entryIndex;
   4BFC 3A A2 87      [13]  344 	ld	a,(#_ui_options_entryIndex + 0)
   4BFF 32 A1 87      [13]  345 	ld	(#_ui_options_lastEntry + 0),a
   4C02 C9            [10]  346 	ret
   4C03                     347 ___str_4:
   4C03 54 45 58 54 55 52   348 	.ascii "TEXTURES"
        45 53
   4C0B 00                  349 	.db 0x00
   4C0C                     350 ___str_5:
   4C0C 4D 55 53 49 43      351 	.ascii "MUSIC"
   4C11 00                  352 	.db 0x00
                            353 	.area _CODE
                            354 	.area _INITIALIZER
                            355 	.area _CABS (ABS)
