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
   7E01                      38 _ui_options_lastEntry::
   7E01                      39 	.ds 1
   7E02                      40 _ui_options_entryIndex::
   7E02                      41 	.ds 1
   7E03                      42 _ui_options_entrySelected::
   7E03                      43 	.ds 1
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
   4939                      72 _ui_options_set_strings::
                             73 ;src/UI_Options.c:59: *(char**)(ui_options_buttonText)=ui_options_on_off[textures_on];
   4939 01 6D 49      [10]   74 	ld	bc,#_ui_options_on_off+0
   493C FD 21 3B 7D   [14]   75 	ld	iy,#_textures_on
   4940 FD 6E 00      [19]   76 	ld	l,0 (iy)
   4943 26 00         [ 7]   77 	ld	h,#0x00
   4945 29            [11]   78 	add	hl, hl
   4946 09            [11]   79 	add	hl,bc
   4947 5E            [ 7]   80 	ld	e,(hl)
   4948 23            [ 6]   81 	inc	hl
   4949 56            [ 7]   82 	ld	d,(hl)
   494A ED 53 71 49   [20]   83 	ld	(_ui_options_buttonText), de
                             84 ;src/UI_Options.c:60: *(char**)(ui_options_buttonText+1)=ui_options_on_off[music_on];
   494E FD 21 3A 7D   [14]   85 	ld	iy,#_music_on
   4952 FD 6E 00      [19]   86 	ld	l,0 (iy)
   4955 26 00         [ 7]   87 	ld	h,#0x00
   4957 29            [11]   88 	add	hl, hl
   4958 09            [11]   89 	add	hl,bc
   4959 4E            [ 7]   90 	ld	c,(hl)
   495A 23            [ 6]   91 	inc	hl
   495B 46            [ 7]   92 	ld	b,(hl)
   495C ED 43 73 49   [20]   93 	ld	((_ui_options_buttonText + 0x0002)), bc
   4960 C9            [10]   94 	ret
   4961                      95 _ui_options_entriesPosition:
   4961 FB C2                96 	.dw #0xC2FB
   4963 9B E3                97 	.dw #0xE39B
   4965 82 C4                98 	.dw #0xC482
   4967                      99 _ui_options_entriesTextPosition:
   4967 FE EA               100 	.dw #0xEAFE
   4969 EE CB               101 	.dw #0xCBEE
   496B 84 EC               102 	.dw #0xEC84
   496D                     103 _ui_options_on_off:
   496D 77 49               104 	.dw __str_0
   496F 7B 49               105 	.dw __str_1
   4971                     106 _ui_options_buttonText:
   4971 7E 49               107 	.dw __str_2
   4973 7E 49               108 	.dw __str_2
   4975 7F 49               109 	.dw __str_3
   4977                     110 __str_0:
   4977 4F 46 46            111 	.ascii "OFF"
   497A 00                  112 	.db 0x00
   497B                     113 __str_1:
   497B 4F 4E               114 	.ascii "ON"
   497D 00                  115 	.db 0x00
   497E                     116 __str_2:
   497E 00                  117 	.db 0x00
   497F                     118 __str_3:
   497F 45 58 49 54         119 	.ascii "EXIT"
   4983 00                  120 	.db 0x00
                            121 ;src/UI_Options.c:64: void ui_options_init(){
                            122 ;	---------------------------------
                            123 ; Function ui_options_init
                            124 ; ---------------------------------
   4984                     125 _ui_options_init::
                            126 ;src/UI_Options.c:65: ui_options_lastEntry=0;
   4984 21 01 7E      [10]  127 	ld	hl,#_ui_options_lastEntry + 0
   4987 36 00         [10]  128 	ld	(hl), #0x00
                            129 ;src/UI_Options.c:66: ui_options_entryIndex=0;
   4989 21 02 7E      [10]  130 	ld	hl,#_ui_options_entryIndex + 0
   498C 36 00         [10]  131 	ld	(hl), #0x00
                            132 ;src/UI_Options.c:67: ui_options_entrySelected=0;
   498E 21 03 7E      [10]  133 	ld	hl,#_ui_options_entrySelected + 0
   4991 36 00         [10]  134 	ld	(hl), #0x00
                            135 ;src/UI_Options.c:68: ui_options_set_strings();
   4993 C3 39 49      [10]  136 	jp  _ui_options_set_strings
                            137 ;src/UI_Options.c:72: u8 ui_options_get_entry(){
                            138 ;	---------------------------------
                            139 ; Function ui_options_get_entry
                            140 ; ---------------------------------
   4996                     141 _ui_options_get_entry::
                            142 ;src/UI_Options.c:73: return ui_options_entryIndex;
   4996 FD 21 02 7E   [14]  143 	ld	iy,#_ui_options_entryIndex
   499A FD 6E 00      [19]  144 	ld	l,0 (iy)
   499D C9            [10]  145 	ret
                            146 ;src/UI_Options.c:76: u8 ui_options_is_selected(){
                            147 ;	---------------------------------
                            148 ; Function ui_options_is_selected
                            149 ; ---------------------------------
   499E                     150 _ui_options_is_selected::
                            151 ;src/UI_Options.c:77: return ui_options_entrySelected;
   499E FD 21 03 7E   [14]  152 	ld	iy,#_ui_options_entrySelected
   49A2 FD 6E 00      [19]  153 	ld	l,0 (iy)
   49A5 C9            [10]  154 	ret
                            155 ;src/UI_Options.c:80: void ui_options_next_entry(){
                            156 ;	---------------------------------
                            157 ; Function ui_options_next_entry
                            158 ; ---------------------------------
   49A6                     159 _ui_options_next_entry::
                            160 ;src/UI_Options.c:81: if(ui_options_entryIndex<(UI_OPTIONS_ENTRIES-1)){
                            161 ;src/UI_Options.c:82: ui_options_lastEntry=ui_options_entryIndex;
   49A6 3A 02 7E      [13]  162 	ld	a,(#_ui_options_entryIndex + 0)
   49A9 FE 02         [ 7]  163 	cp	a,#0x02
   49AB D0            [11]  164 	ret	NC
   49AC 32 01 7E      [13]  165 	ld	(#_ui_options_lastEntry + 0),a
                            166 ;src/UI_Options.c:83: ++ui_options_entryIndex;
   49AF 21 02 7E      [10]  167 	ld	hl, #_ui_options_entryIndex+0
   49B2 34            [11]  168 	inc	(hl)
   49B3 C9            [10]  169 	ret
                            170 ;src/UI_Options.c:87: void ui_options_previous_entry(){
                            171 ;	---------------------------------
                            172 ; Function ui_options_previous_entry
                            173 ; ---------------------------------
   49B4                     174 _ui_options_previous_entry::
                            175 ;src/UI_Options.c:88: if(ui_options_entryIndex>0){
   49B4 3A 02 7E      [13]  176 	ld	a,(#_ui_options_entryIndex + 0)
   49B7 B7            [ 4]  177 	or	a, a
   49B8 C8            [11]  178 	ret	Z
                            179 ;src/UI_Options.c:89: ui_options_lastEntry=ui_options_entryIndex;
   49B9 3A 02 7E      [13]  180 	ld	a,(#_ui_options_entryIndex + 0)
   49BC 32 01 7E      [13]  181 	ld	(#_ui_options_lastEntry + 0),a
                            182 ;src/UI_Options.c:90: --ui_options_entryIndex;
   49BF 21 02 7E      [10]  183 	ld	hl, #_ui_options_entryIndex+0
   49C2 35            [11]  184 	dec	(hl)
   49C3 C9            [10]  185 	ret
                            186 ;src/UI_Options.c:95: void ui_options_select_entry(){
                            187 ;	---------------------------------
                            188 ; Function ui_options_select_entry
                            189 ; ---------------------------------
   49C4                     190 _ui_options_select_entry::
                            191 ;src/UI_Options.c:96: ui_options_entrySelected=1;
   49C4 21 03 7E      [10]  192 	ld	hl,#_ui_options_entrySelected + 0
   49C7 36 01         [10]  193 	ld	(hl), #0x01
   49C9 C9            [10]  194 	ret
                            195 ;src/UI_Options.c:99: void ui_options_unselect_entry(){
                            196 ;	---------------------------------
                            197 ; Function ui_options_unselect_entry
                            198 ; ---------------------------------
   49CA                     199 _ui_options_unselect_entry::
                            200 ;src/UI_Options.c:100: ui_options_entrySelected=0;
   49CA 21 03 7E      [10]  201 	ld	hl,#_ui_options_entrySelected + 0
   49CD 36 00         [10]  202 	ld	(hl), #0x00
   49CF C9            [10]  203 	ret
                            204 ;src/UI_Options.c:103: void ui_options_render_button(u8 n){
                            205 ;	---------------------------------
                            206 ; Function ui_options_render_button
                            207 ; ---------------------------------
   49D0                     208 _ui_options_render_button::
   49D0 DD E5         [15]  209 	push	ix
   49D2 DD 21 00 00   [14]  210 	ld	ix,#0
   49D6 DD 39         [15]  211 	add	ix,sp
   49D8 3B            [ 6]  212 	dec	sp
                            213 ;src/UI_Options.c:105: color = (n==ui_options_entryIndex)?((ui_options_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   49D9 DD 7E 04      [19]  214 	ld	a,4 (ix)
   49DC FD 21 02 7E   [14]  215 	ld	iy,#_ui_options_entryIndex
   49E0 FD 96 00      [19]  216 	sub	a, 0 (iy)
   49E3 20 10         [12]  217 	jr	NZ,00103$
   49E5 3A 03 7E      [13]  218 	ld	a,(#_ui_options_entrySelected + 0)
   49E8 B7            [ 4]  219 	or	a, a
   49E9 28 05         [12]  220 	jr	Z,00105$
   49EB 3A 6A 1A      [13]  221 	ld	a, (#(_g_colors + 0x0004) + 0)
   49EE 18 08         [12]  222 	jr	00104$
   49F0                     223 00105$:
   49F0 3A 6C 1A      [13]  224 	ld	a, (#(_g_colors + 0x0006) + 0)
   49F3 18 03         [12]  225 	jr	00104$
   49F5                     226 00103$:
   49F5 3A 68 1A      [13]  227 	ld	a, (#(_g_colors + 0x0002) + 0)
   49F8                     228 00104$:
   49F8 DD 77 FF      [19]  229 	ld	-1 (ix),a
                            230 ;src/UI_Options.c:106: cpct_drawSolidBox(ui_options_entriesPosition[n],color, UI_OPTIONS_BUTTON_WIDTH, UI_OPTIONS_BUTTON_HEIGHT);
   49FB DD 6E 04      [19]  231 	ld	l,4 (ix)
   49FE 26 00         [ 7]  232 	ld	h,#0x00
   4A00 29            [11]  233 	add	hl, hl
   4A01 4D            [ 4]  234 	ld	c, l
   4A02 44            [ 4]  235 	ld	b, h
   4A03 21 61 49      [10]  236 	ld	hl,#_ui_options_entriesPosition
   4A06 09            [11]  237 	add	hl,bc
   4A07 5E            [ 7]  238 	ld	e,(hl)
   4A08 23            [ 6]  239 	inc	hl
   4A09 56            [ 7]  240 	ld	d,(hl)
   4A0A C5            [11]  241 	push	bc
   4A0B 21 0C 10      [10]  242 	ld	hl,#0x100C
   4A0E E5            [11]  243 	push	hl
   4A0F DD 7E FF      [19]  244 	ld	a,-1 (ix)
   4A12 F5            [11]  245 	push	af
   4A13 33            [ 6]  246 	inc	sp
   4A14 D5            [11]  247 	push	de
   4A15 CD 92 7B      [17]  248 	call	_cpct_drawSolidBox
   4A18 F1            [10]  249 	pop	af
   4A19 F1            [10]  250 	pop	af
   4A1A 33            [ 6]  251 	inc	sp
   4A1B C1            [10]  252 	pop	bc
                            253 ;src/UI_Options.c:107: print_transparent_text(ui_options_buttonText[n], ui_options_entriesTextPosition[n], 3);
   4A1C 21 67 49      [10]  254 	ld	hl,#_ui_options_entriesTextPosition
   4A1F 09            [11]  255 	add	hl,bc
   4A20 5E            [ 7]  256 	ld	e,(hl)
   4A21 23            [ 6]  257 	inc	hl
   4A22 56            [ 7]  258 	ld	d,(hl)
   4A23 21 71 49      [10]  259 	ld	hl,#_ui_options_buttonText
   4A26 09            [11]  260 	add	hl,bc
   4A27 4E            [ 7]  261 	ld	c,(hl)
   4A28 23            [ 6]  262 	inc	hl
   4A29 46            [ 7]  263 	ld	b,(hl)
   4A2A 3E 03         [ 7]  264 	ld	a,#0x03
   4A2C F5            [11]  265 	push	af
   4A2D 33            [ 6]  266 	inc	sp
   4A2E D5            [11]  267 	push	de
   4A2F C5            [11]  268 	push	bc
   4A30 CD A0 3F      [17]  269 	call	_print_transparent_text
   4A33 F1            [10]  270 	pop	af
   4A34 F1            [10]  271 	pop	af
   4A35 33            [ 6]  272 	inc	sp
   4A36 33            [ 6]  273 	inc	sp
   4A37 DD E1         [14]  274 	pop	ix
   4A39 C9            [10]  275 	ret
                            276 ;src/UI_Options.c:111: void ui_options_render_refresh(){
                            277 ;	---------------------------------
                            278 ; Function ui_options_render_refresh
                            279 ; ---------------------------------
   4A3A                     280 _ui_options_render_refresh::
                            281 ;src/UI_Options.c:113: ui_options_render_button(ui_options_entryIndex);
   4A3A 3A 02 7E      [13]  282 	ld	a,(_ui_options_entryIndex)
   4A3D F5            [11]  283 	push	af
   4A3E 33            [ 6]  284 	inc	sp
   4A3F CD D0 49      [17]  285 	call	_ui_options_render_button
   4A42 33            [ 6]  286 	inc	sp
                            287 ;src/UI_Options.c:114: ui_options_render_button(ui_options_lastEntry);
   4A43 3A 01 7E      [13]  288 	ld	a,(_ui_options_lastEntry)
   4A46 F5            [11]  289 	push	af
   4A47 33            [ 6]  290 	inc	sp
   4A48 CD D0 49      [17]  291 	call	_ui_options_render_button
   4A4B 33            [ 6]  292 	inc	sp
                            293 ;src/UI_Options.c:116: ui_options_lastEntry=ui_options_entryIndex;
   4A4C 3A 02 7E      [13]  294 	ld	a,(#_ui_options_entryIndex + 0)
   4A4F 32 01 7E      [13]  295 	ld	(#_ui_options_lastEntry + 0),a
   4A52 C9            [10]  296 	ret
                            297 ;src/UI_Options.c:119: void ui_options_render_all(){
                            298 ;	---------------------------------
                            299 ; Function ui_options_render_all
                            300 ; ---------------------------------
   4A53                     301 _ui_options_render_all::
                            302 ;src/UI_Options.c:122: print_transparent_text("TEXTURES", UI_OPTIONS_BUTTON_TEXT_LABEL_POSITION, 3);
   4A53 3E 03         [ 7]  303 	ld	a,#0x03
   4A55 F5            [11]  304 	push	af
   4A56 33            [ 6]  305 	inc	sp
   4A57 21 EA EA      [10]  306 	ld	hl,#0xEAEA
   4A5A E5            [11]  307 	push	hl
   4A5B 21 8F 4A      [10]  308 	ld	hl,#___str_4
   4A5E E5            [11]  309 	push	hl
   4A5F CD A0 3F      [17]  310 	call	_print_transparent_text
   4A62 F1            [10]  311 	pop	af
   4A63 F1            [10]  312 	pop	af
   4A64 33            [ 6]  313 	inc	sp
                            314 ;src/UI_Options.c:123: print_transparent_text("MUSIC", UI_OPTIONS_BUTTON_MUSIC_LABEL_POSITION, 3);
   4A65 3E 03         [ 7]  315 	ld	a,#0x03
   4A67 F5            [11]  316 	push	af
   4A68 33            [ 6]  317 	inc	sp
   4A69 21 DA CB      [10]  318 	ld	hl,#0xCBDA
   4A6C E5            [11]  319 	push	hl
   4A6D 21 98 4A      [10]  320 	ld	hl,#___str_5
   4A70 E5            [11]  321 	push	hl
   4A71 CD A0 3F      [17]  322 	call	_print_transparent_text
   4A74 F1            [10]  323 	pop	af
   4A75 F1            [10]  324 	pop	af
   4A76 33            [ 6]  325 	inc	sp
                            326 ;src/UI_Options.c:125: while(n){
   4A77 06 03         [ 7]  327 	ld	b,#0x03
   4A79                     328 00101$:
   4A79 78            [ 4]  329 	ld	a,b
   4A7A B7            [ 4]  330 	or	a, a
   4A7B 28 0B         [12]  331 	jr	Z,00103$
                            332 ;src/UI_Options.c:126: --n;
   4A7D 05            [ 4]  333 	dec	b
                            334 ;src/UI_Options.c:127: ui_options_render_button(n);
   4A7E C5            [11]  335 	push	bc
   4A7F C5            [11]  336 	push	bc
   4A80 33            [ 6]  337 	inc	sp
   4A81 CD D0 49      [17]  338 	call	_ui_options_render_button
   4A84 33            [ 6]  339 	inc	sp
   4A85 C1            [10]  340 	pop	bc
   4A86 18 F1         [12]  341 	jr	00101$
   4A88                     342 00103$:
                            343 ;src/UI_Options.c:130: ui_options_lastEntry=ui_options_entryIndex;
   4A88 3A 02 7E      [13]  344 	ld	a,(#_ui_options_entryIndex + 0)
   4A8B 32 01 7E      [13]  345 	ld	(#_ui_options_lastEntry + 0),a
   4A8E C9            [10]  346 	ret
   4A8F                     347 ___str_4:
   4A8F 54 45 58 54 55 52   348 	.ascii "TEXTURES"
        45 53
   4A97 00                  349 	.db 0x00
   4A98                     350 ___str_5:
   4A98 4D 55 53 49 43      351 	.ascii "MUSIC"
   4A9D 00                  352 	.db 0x00
                            353 	.area _CODE
                            354 	.area _INITIALIZER
                            355 	.area _CABS (ABS)
