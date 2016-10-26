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
   7E27                      38 _ui_options_lastEntry::
   7E27                      39 	.ds 1
   7E28                      40 _ui_options_entryIndex::
   7E28                      41 	.ds 1
   7E29                      42 _ui_options_entrySelected::
   7E29                      43 	.ds 1
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
   495F                      72 _ui_options_set_strings::
                             73 ;src/UI_Options.c:59: *(char**)(ui_options_buttonText)=ui_options_on_off[textures_on];
   495F 01 93 49      [10]   74 	ld	bc,#_ui_options_on_off+0
   4962 FD 21 61 7D   [14]   75 	ld	iy,#_textures_on
   4966 FD 6E 00      [19]   76 	ld	l,0 (iy)
   4969 26 00         [ 7]   77 	ld	h,#0x00
   496B 29            [11]   78 	add	hl, hl
   496C 09            [11]   79 	add	hl,bc
   496D 5E            [ 7]   80 	ld	e,(hl)
   496E 23            [ 6]   81 	inc	hl
   496F 56            [ 7]   82 	ld	d,(hl)
   4970 ED 53 97 49   [20]   83 	ld	(_ui_options_buttonText), de
                             84 ;src/UI_Options.c:60: *(char**)(ui_options_buttonText+1)=ui_options_on_off[music_on];
   4974 FD 21 60 7D   [14]   85 	ld	iy,#_music_on
   4978 FD 6E 00      [19]   86 	ld	l,0 (iy)
   497B 26 00         [ 7]   87 	ld	h,#0x00
   497D 29            [11]   88 	add	hl, hl
   497E 09            [11]   89 	add	hl,bc
   497F 4E            [ 7]   90 	ld	c,(hl)
   4980 23            [ 6]   91 	inc	hl
   4981 46            [ 7]   92 	ld	b,(hl)
   4982 ED 43 99 49   [20]   93 	ld	((_ui_options_buttonText + 0x0002)), bc
   4986 C9            [10]   94 	ret
   4987                      95 _ui_options_entriesPosition:
   4987 FB C2                96 	.dw #0xC2FB
   4989 9B E3                97 	.dw #0xE39B
   498B 82 C4                98 	.dw #0xC482
   498D                      99 _ui_options_entriesTextPosition:
   498D FE EA               100 	.dw #0xEAFE
   498F EE CB               101 	.dw #0xCBEE
   4991 84 EC               102 	.dw #0xEC84
   4993                     103 _ui_options_on_off:
   4993 9D 49               104 	.dw __str_0
   4995 A1 49               105 	.dw __str_1
   4997                     106 _ui_options_buttonText:
   4997 A4 49               107 	.dw __str_2
   4999 A4 49               108 	.dw __str_2
   499B A5 49               109 	.dw __str_3
   499D                     110 __str_0:
   499D 4F 46 46            111 	.ascii "OFF"
   49A0 00                  112 	.db 0x00
   49A1                     113 __str_1:
   49A1 4F 4E               114 	.ascii "ON"
   49A3 00                  115 	.db 0x00
   49A4                     116 __str_2:
   49A4 00                  117 	.db 0x00
   49A5                     118 __str_3:
   49A5 45 58 49 54         119 	.ascii "EXIT"
   49A9 00                  120 	.db 0x00
                            121 ;src/UI_Options.c:64: void ui_options_init(){
                            122 ;	---------------------------------
                            123 ; Function ui_options_init
                            124 ; ---------------------------------
   49AA                     125 _ui_options_init::
                            126 ;src/UI_Options.c:65: ui_options_lastEntry=0;
   49AA 21 27 7E      [10]  127 	ld	hl,#_ui_options_lastEntry + 0
   49AD 36 00         [10]  128 	ld	(hl), #0x00
                            129 ;src/UI_Options.c:66: ui_options_entryIndex=0;
   49AF 21 28 7E      [10]  130 	ld	hl,#_ui_options_entryIndex + 0
   49B2 36 00         [10]  131 	ld	(hl), #0x00
                            132 ;src/UI_Options.c:67: ui_options_entrySelected=0;
   49B4 21 29 7E      [10]  133 	ld	hl,#_ui_options_entrySelected + 0
   49B7 36 00         [10]  134 	ld	(hl), #0x00
                            135 ;src/UI_Options.c:68: ui_options_set_strings();
   49B9 C3 5F 49      [10]  136 	jp  _ui_options_set_strings
                            137 ;src/UI_Options.c:72: u8 ui_options_get_entry(){
                            138 ;	---------------------------------
                            139 ; Function ui_options_get_entry
                            140 ; ---------------------------------
   49BC                     141 _ui_options_get_entry::
                            142 ;src/UI_Options.c:73: return ui_options_entryIndex;
   49BC FD 21 28 7E   [14]  143 	ld	iy,#_ui_options_entryIndex
   49C0 FD 6E 00      [19]  144 	ld	l,0 (iy)
   49C3 C9            [10]  145 	ret
                            146 ;src/UI_Options.c:76: u8 ui_options_is_selected(){
                            147 ;	---------------------------------
                            148 ; Function ui_options_is_selected
                            149 ; ---------------------------------
   49C4                     150 _ui_options_is_selected::
                            151 ;src/UI_Options.c:77: return ui_options_entrySelected;
   49C4 FD 21 29 7E   [14]  152 	ld	iy,#_ui_options_entrySelected
   49C8 FD 6E 00      [19]  153 	ld	l,0 (iy)
   49CB C9            [10]  154 	ret
                            155 ;src/UI_Options.c:80: void ui_options_next_entry(){
                            156 ;	---------------------------------
                            157 ; Function ui_options_next_entry
                            158 ; ---------------------------------
   49CC                     159 _ui_options_next_entry::
                            160 ;src/UI_Options.c:81: if(ui_options_entryIndex<(UI_OPTIONS_ENTRIES-1)){
                            161 ;src/UI_Options.c:82: ui_options_lastEntry=ui_options_entryIndex;
   49CC 3A 28 7E      [13]  162 	ld	a,(#_ui_options_entryIndex + 0)
   49CF FE 02         [ 7]  163 	cp	a,#0x02
   49D1 D0            [11]  164 	ret	NC
   49D2 32 27 7E      [13]  165 	ld	(#_ui_options_lastEntry + 0),a
                            166 ;src/UI_Options.c:83: ++ui_options_entryIndex;
   49D5 21 28 7E      [10]  167 	ld	hl, #_ui_options_entryIndex+0
   49D8 34            [11]  168 	inc	(hl)
   49D9 C9            [10]  169 	ret
                            170 ;src/UI_Options.c:87: void ui_options_previous_entry(){
                            171 ;	---------------------------------
                            172 ; Function ui_options_previous_entry
                            173 ; ---------------------------------
   49DA                     174 _ui_options_previous_entry::
                            175 ;src/UI_Options.c:88: if(ui_options_entryIndex>0){
   49DA 3A 28 7E      [13]  176 	ld	a,(#_ui_options_entryIndex + 0)
   49DD B7            [ 4]  177 	or	a, a
   49DE C8            [11]  178 	ret	Z
                            179 ;src/UI_Options.c:89: ui_options_lastEntry=ui_options_entryIndex;
   49DF 3A 28 7E      [13]  180 	ld	a,(#_ui_options_entryIndex + 0)
   49E2 32 27 7E      [13]  181 	ld	(#_ui_options_lastEntry + 0),a
                            182 ;src/UI_Options.c:90: --ui_options_entryIndex;
   49E5 21 28 7E      [10]  183 	ld	hl, #_ui_options_entryIndex+0
   49E8 35            [11]  184 	dec	(hl)
   49E9 C9            [10]  185 	ret
                            186 ;src/UI_Options.c:95: void ui_options_select_entry(){
                            187 ;	---------------------------------
                            188 ; Function ui_options_select_entry
                            189 ; ---------------------------------
   49EA                     190 _ui_options_select_entry::
                            191 ;src/UI_Options.c:96: ui_options_entrySelected=1;
   49EA 21 29 7E      [10]  192 	ld	hl,#_ui_options_entrySelected + 0
   49ED 36 01         [10]  193 	ld	(hl), #0x01
   49EF C9            [10]  194 	ret
                            195 ;src/UI_Options.c:99: void ui_options_unselect_entry(){
                            196 ;	---------------------------------
                            197 ; Function ui_options_unselect_entry
                            198 ; ---------------------------------
   49F0                     199 _ui_options_unselect_entry::
                            200 ;src/UI_Options.c:100: ui_options_entrySelected=0;
   49F0 21 29 7E      [10]  201 	ld	hl,#_ui_options_entrySelected + 0
   49F3 36 00         [10]  202 	ld	(hl), #0x00
   49F5 C9            [10]  203 	ret
                            204 ;src/UI_Options.c:103: void ui_options_render_button(u8 n){
                            205 ;	---------------------------------
                            206 ; Function ui_options_render_button
                            207 ; ---------------------------------
   49F6                     208 _ui_options_render_button::
   49F6 DD E5         [15]  209 	push	ix
   49F8 DD 21 00 00   [14]  210 	ld	ix,#0
   49FC DD 39         [15]  211 	add	ix,sp
   49FE 3B            [ 6]  212 	dec	sp
                            213 ;src/UI_Options.c:105: color = (n==ui_options_entryIndex)?((ui_options_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   49FF DD 7E 04      [19]  214 	ld	a,4 (ix)
   4A02 FD 21 28 7E   [14]  215 	ld	iy,#_ui_options_entryIndex
   4A06 FD 96 00      [19]  216 	sub	a, 0 (iy)
   4A09 20 10         [12]  217 	jr	NZ,00103$
   4A0B 3A 29 7E      [13]  218 	ld	a,(#_ui_options_entrySelected + 0)
   4A0E B7            [ 4]  219 	or	a, a
   4A0F 28 05         [12]  220 	jr	Z,00105$
   4A11 3A B3 1A      [13]  221 	ld	a, (#(_g_colors + 0x0004) + 0)
   4A14 18 08         [12]  222 	jr	00104$
   4A16                     223 00105$:
   4A16 3A B5 1A      [13]  224 	ld	a, (#(_g_colors + 0x0006) + 0)
   4A19 18 03         [12]  225 	jr	00104$
   4A1B                     226 00103$:
   4A1B 3A B1 1A      [13]  227 	ld	a, (#(_g_colors + 0x0002) + 0)
   4A1E                     228 00104$:
   4A1E DD 77 FF      [19]  229 	ld	-1 (ix),a
                            230 ;src/UI_Options.c:106: cpct_drawSolidBox(ui_options_entriesPosition[n],color, UI_OPTIONS_BUTTON_WIDTH, UI_OPTIONS_BUTTON_HEIGHT);
   4A21 DD 6E 04      [19]  231 	ld	l,4 (ix)
   4A24 26 00         [ 7]  232 	ld	h,#0x00
   4A26 29            [11]  233 	add	hl, hl
   4A27 4D            [ 4]  234 	ld	c, l
   4A28 44            [ 4]  235 	ld	b, h
   4A29 21 87 49      [10]  236 	ld	hl,#_ui_options_entriesPosition
   4A2C 09            [11]  237 	add	hl,bc
   4A2D 5E            [ 7]  238 	ld	e,(hl)
   4A2E 23            [ 6]  239 	inc	hl
   4A2F 56            [ 7]  240 	ld	d,(hl)
   4A30 C5            [11]  241 	push	bc
   4A31 21 0C 10      [10]  242 	ld	hl,#0x100C
   4A34 E5            [11]  243 	push	hl
   4A35 DD 7E FF      [19]  244 	ld	a,-1 (ix)
   4A38 F5            [11]  245 	push	af
   4A39 33            [ 6]  246 	inc	sp
   4A3A D5            [11]  247 	push	de
   4A3B CD B8 7B      [17]  248 	call	_cpct_drawSolidBox
   4A3E F1            [10]  249 	pop	af
   4A3F F1            [10]  250 	pop	af
   4A40 33            [ 6]  251 	inc	sp
   4A41 C1            [10]  252 	pop	bc
                            253 ;src/UI_Options.c:107: print_transparent_text(ui_options_buttonText[n], ui_options_entriesTextPosition[n], 3);
   4A42 21 8D 49      [10]  254 	ld	hl,#_ui_options_entriesTextPosition
   4A45 09            [11]  255 	add	hl,bc
   4A46 5E            [ 7]  256 	ld	e,(hl)
   4A47 23            [ 6]  257 	inc	hl
   4A48 56            [ 7]  258 	ld	d,(hl)
   4A49 21 97 49      [10]  259 	ld	hl,#_ui_options_buttonText
   4A4C 09            [11]  260 	add	hl,bc
   4A4D 4E            [ 7]  261 	ld	c,(hl)
   4A4E 23            [ 6]  262 	inc	hl
   4A4F 46            [ 7]  263 	ld	b,(hl)
   4A50 3E 03         [ 7]  264 	ld	a,#0x03
   4A52 F5            [11]  265 	push	af
   4A53 33            [ 6]  266 	inc	sp
   4A54 D5            [11]  267 	push	de
   4A55 C5            [11]  268 	push	bc
   4A56 CD C6 3F      [17]  269 	call	_print_transparent_text
   4A59 F1            [10]  270 	pop	af
   4A5A F1            [10]  271 	pop	af
   4A5B 33            [ 6]  272 	inc	sp
   4A5C 33            [ 6]  273 	inc	sp
   4A5D DD E1         [14]  274 	pop	ix
   4A5F C9            [10]  275 	ret
                            276 ;src/UI_Options.c:111: void ui_options_render_refresh(){
                            277 ;	---------------------------------
                            278 ; Function ui_options_render_refresh
                            279 ; ---------------------------------
   4A60                     280 _ui_options_render_refresh::
                            281 ;src/UI_Options.c:113: ui_options_render_button(ui_options_entryIndex);
   4A60 3A 28 7E      [13]  282 	ld	a,(_ui_options_entryIndex)
   4A63 F5            [11]  283 	push	af
   4A64 33            [ 6]  284 	inc	sp
   4A65 CD F6 49      [17]  285 	call	_ui_options_render_button
   4A68 33            [ 6]  286 	inc	sp
                            287 ;src/UI_Options.c:114: ui_options_render_button(ui_options_lastEntry);
   4A69 3A 27 7E      [13]  288 	ld	a,(_ui_options_lastEntry)
   4A6C F5            [11]  289 	push	af
   4A6D 33            [ 6]  290 	inc	sp
   4A6E CD F6 49      [17]  291 	call	_ui_options_render_button
   4A71 33            [ 6]  292 	inc	sp
                            293 ;src/UI_Options.c:116: ui_options_lastEntry=ui_options_entryIndex;
   4A72 3A 28 7E      [13]  294 	ld	a,(#_ui_options_entryIndex + 0)
   4A75 32 27 7E      [13]  295 	ld	(#_ui_options_lastEntry + 0),a
   4A78 C9            [10]  296 	ret
                            297 ;src/UI_Options.c:119: void ui_options_render_all(){
                            298 ;	---------------------------------
                            299 ; Function ui_options_render_all
                            300 ; ---------------------------------
   4A79                     301 _ui_options_render_all::
                            302 ;src/UI_Options.c:122: print_transparent_text("TEXTURES", UI_OPTIONS_BUTTON_TEXT_LABEL_POSITION, 3);
   4A79 3E 03         [ 7]  303 	ld	a,#0x03
   4A7B F5            [11]  304 	push	af
   4A7C 33            [ 6]  305 	inc	sp
   4A7D 21 EA EA      [10]  306 	ld	hl,#0xEAEA
   4A80 E5            [11]  307 	push	hl
   4A81 21 B5 4A      [10]  308 	ld	hl,#___str_4
   4A84 E5            [11]  309 	push	hl
   4A85 CD C6 3F      [17]  310 	call	_print_transparent_text
   4A88 F1            [10]  311 	pop	af
   4A89 F1            [10]  312 	pop	af
   4A8A 33            [ 6]  313 	inc	sp
                            314 ;src/UI_Options.c:123: print_transparent_text("MUSIC", UI_OPTIONS_BUTTON_MUSIC_LABEL_POSITION, 3);
   4A8B 3E 03         [ 7]  315 	ld	a,#0x03
   4A8D F5            [11]  316 	push	af
   4A8E 33            [ 6]  317 	inc	sp
   4A8F 21 DA CB      [10]  318 	ld	hl,#0xCBDA
   4A92 E5            [11]  319 	push	hl
   4A93 21 BE 4A      [10]  320 	ld	hl,#___str_5
   4A96 E5            [11]  321 	push	hl
   4A97 CD C6 3F      [17]  322 	call	_print_transparent_text
   4A9A F1            [10]  323 	pop	af
   4A9B F1            [10]  324 	pop	af
   4A9C 33            [ 6]  325 	inc	sp
                            326 ;src/UI_Options.c:125: while(n){
   4A9D 06 03         [ 7]  327 	ld	b,#0x03
   4A9F                     328 00101$:
   4A9F 78            [ 4]  329 	ld	a,b
   4AA0 B7            [ 4]  330 	or	a, a
   4AA1 28 0B         [12]  331 	jr	Z,00103$
                            332 ;src/UI_Options.c:126: --n;
   4AA3 05            [ 4]  333 	dec	b
                            334 ;src/UI_Options.c:127: ui_options_render_button(n);
   4AA4 C5            [11]  335 	push	bc
   4AA5 C5            [11]  336 	push	bc
   4AA6 33            [ 6]  337 	inc	sp
   4AA7 CD F6 49      [17]  338 	call	_ui_options_render_button
   4AAA 33            [ 6]  339 	inc	sp
   4AAB C1            [10]  340 	pop	bc
   4AAC 18 F1         [12]  341 	jr	00101$
   4AAE                     342 00103$:
                            343 ;src/UI_Options.c:130: ui_options_lastEntry=ui_options_entryIndex;
   4AAE 3A 28 7E      [13]  344 	ld	a,(#_ui_options_entryIndex + 0)
   4AB1 32 27 7E      [13]  345 	ld	(#_ui_options_lastEntry + 0),a
   4AB4 C9            [10]  346 	ret
   4AB5                     347 ___str_4:
   4AB5 54 45 58 54 55 52   348 	.ascii "TEXTURES"
        45 53
   4ABD 00                  349 	.db 0x00
   4ABE                     350 ___str_5:
   4ABE 4D 55 53 49 43      351 	.ascii "MUSIC"
   4AC3 00                  352 	.db 0x00
                            353 	.area _CODE
                            354 	.area _INITIALIZER
                            355 	.area _CABS (ABS)
