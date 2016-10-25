                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_LoadGame
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_loadgame_render_button
                             12 	.globl _ui_stringinput_get_string
                             13 	.globl _print_transparent_text
                             14 	.globl _print_text
                             15 	.globl _cpct_drawSolidBox
                             16 	.globl _ui_loadgame_entrySelected
                             17 	.globl _ui_loadgame_entryIndex
                             18 	.globl _ui_loadgame_lastEntry
                             19 	.globl _ui_loadgame_buttonText
                             20 	.globl _ui_loadgame_entriesTextPosition
                             21 	.globl _ui_loadgame_entriesPosition
                             22 	.globl _ui_loadgame_init
                             23 	.globl _ui_loadgame_get_entry
                             24 	.globl _ui_loadgame_is_selected
                             25 	.globl _ui_loadgame_next_entry
                             26 	.globl _ui_loadgame_previous_entry
                             27 	.globl _ui_loadgame_select_entry
                             28 	.globl _ui_loadgame_unselect_entry
                             29 	.globl _ui_loadgame_render_all
                             30 ;--------------------------------------------------------
                             31 ; special function registers
                             32 ;--------------------------------------------------------
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DATA
   7DAA                      37 _ui_loadgame_lastEntry::
   7DAA                      38 	.ds 1
   7DAB                      39 _ui_loadgame_entryIndex::
   7DAB                      40 	.ds 1
   7DAC                      41 _ui_loadgame_entrySelected::
   7DAC                      42 	.ds 1
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
                             47 ;--------------------------------------------------------
                             48 ; absolute external ram data
                             49 ;--------------------------------------------------------
                             50 	.area _DABS (ABS)
                             51 ;--------------------------------------------------------
                             52 ; global & static initialisations
                             53 ;--------------------------------------------------------
                             54 	.area _HOME
                             55 	.area _GSINIT
                             56 	.area _GSFINAL
                             57 	.area _GSINIT
                             58 ;--------------------------------------------------------
                             59 ; Home
                             60 ;--------------------------------------------------------
                             61 	.area _HOME
                             62 	.area _HOME
                             63 ;--------------------------------------------------------
                             64 ; code
                             65 ;--------------------------------------------------------
                             66 	.area _CODE
                             67 ;src/UI_LoadGame.c:48: void ui_loadgame_init(){
                             68 ;	---------------------------------
                             69 ; Function ui_loadgame_init
                             70 ; ---------------------------------
   4606                      71 _ui_loadgame_init::
                             72 ;src/UI_LoadGame.c:49: ui_loadgame_lastEntry=0;
   4606 21 AA 7D      [10]   73 	ld	hl,#_ui_loadgame_lastEntry + 0
   4609 36 00         [10]   74 	ld	(hl), #0x00
                             75 ;src/UI_LoadGame.c:50: ui_loadgame_entryIndex=0;
   460B 21 AB 7D      [10]   76 	ld	hl,#_ui_loadgame_entryIndex + 0
   460E 36 00         [10]   77 	ld	(hl), #0x00
                             78 ;src/UI_LoadGame.c:51: ui_loadgame_entrySelected=0;
   4610 21 AC 7D      [10]   79 	ld	hl,#_ui_loadgame_entrySelected + 0
   4613 36 00         [10]   80 	ld	(hl), #0x00
   4615 C9            [10]   81 	ret
   4616                      82 _ui_loadgame_entriesPosition:
   4616 D8 EB                83 	.dw #0xEBD8
   4618 EA EB                84 	.dw #0xEBEA
   461A                      85 _ui_loadgame_entriesTextPosition:
   461A 2A D4                86 	.dw #0xD42A
   461C 3C D4                87 	.dw #0xD43C
   461E                      88 _ui_loadgame_buttonText:
   461E 22 46                89 	.dw __str_0
   4620 27 46                90 	.dw __str_1
   4622                      91 __str_0:
   4622 4C 4F 41 44          92 	.ascii "LOAD"
   4626 00                   93 	.db 0x00
   4627                      94 __str_1:
   4627 45 58 49 54          95 	.ascii "EXIT"
   462B 00                   96 	.db 0x00
                             97 ;src/UI_LoadGame.c:55: u8 ui_loadgame_get_entry(){
                             98 ;	---------------------------------
                             99 ; Function ui_loadgame_get_entry
                            100 ; ---------------------------------
   462C                     101 _ui_loadgame_get_entry::
                            102 ;src/UI_LoadGame.c:56: return ui_loadgame_entryIndex;
   462C FD 21 AB 7D   [14]  103 	ld	iy,#_ui_loadgame_entryIndex
   4630 FD 6E 00      [19]  104 	ld	l,0 (iy)
   4633 C9            [10]  105 	ret
                            106 ;src/UI_LoadGame.c:59: u8 ui_loadgame_is_selected(){
                            107 ;	---------------------------------
                            108 ; Function ui_loadgame_is_selected
                            109 ; ---------------------------------
   4634                     110 _ui_loadgame_is_selected::
                            111 ;src/UI_LoadGame.c:60: return ui_loadgame_entrySelected;
   4634 FD 21 AC 7D   [14]  112 	ld	iy,#_ui_loadgame_entrySelected
   4638 FD 6E 00      [19]  113 	ld	l,0 (iy)
   463B C9            [10]  114 	ret
                            115 ;src/UI_LoadGame.c:63: void ui_loadgame_next_entry(){
                            116 ;	---------------------------------
                            117 ; Function ui_loadgame_next_entry
                            118 ; ---------------------------------
   463C                     119 _ui_loadgame_next_entry::
                            120 ;src/UI_LoadGame.c:64: if(ui_loadgame_entryIndex<(UI_LOADGAME_ENTRIES-1)){
   463C 3A AB 7D      [13]  121 	ld	a,(#_ui_loadgame_entryIndex + 0)
   463F EE 80         [ 7]  122 	xor	a, #0x80
   4641 D6 81         [ 7]  123 	sub	a, #0x81
   4643 D0            [11]  124 	ret	NC
                            125 ;src/UI_LoadGame.c:65: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
   4644 3A AB 7D      [13]  126 	ld	a,(#_ui_loadgame_entryIndex + 0)
   4647 21 AA 7D      [10]  127 	ld	hl,#_ui_loadgame_lastEntry + 0
   464A 77            [ 7]  128 	ld	(hl), a
                            129 ;src/UI_LoadGame.c:66: ++ui_loadgame_entryIndex;
   464B 21 AB 7D      [10]  130 	ld	hl, #_ui_loadgame_entryIndex+0
   464E 34            [11]  131 	inc	(hl)
   464F C9            [10]  132 	ret
                            133 ;src/UI_LoadGame.c:70: void ui_loadgame_previous_entry(){
                            134 ;	---------------------------------
                            135 ; Function ui_loadgame_previous_entry
                            136 ; ---------------------------------
   4650                     137 _ui_loadgame_previous_entry::
                            138 ;src/UI_LoadGame.c:71: if(ui_loadgame_entryIndex>0){
   4650 3A AB 7D      [13]  139 	ld	a,(#_ui_loadgame_entryIndex + 0)
   4653 B7            [ 4]  140 	or	a, a
   4654 C8            [11]  141 	ret	Z
                            142 ;src/UI_LoadGame.c:72: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
   4655 3A AB 7D      [13]  143 	ld	a,(#_ui_loadgame_entryIndex + 0)
   4658 21 AA 7D      [10]  144 	ld	hl,#_ui_loadgame_lastEntry + 0
   465B 77            [ 7]  145 	ld	(hl), a
                            146 ;src/UI_LoadGame.c:73: --ui_loadgame_entryIndex;
   465C 21 AB 7D      [10]  147 	ld	hl, #_ui_loadgame_entryIndex+0
   465F 35            [11]  148 	dec	(hl)
   4660 C9            [10]  149 	ret
                            150 ;src/UI_LoadGame.c:78: void ui_loadgame_select_entry(){
                            151 ;	---------------------------------
                            152 ; Function ui_loadgame_select_entry
                            153 ; ---------------------------------
   4661                     154 _ui_loadgame_select_entry::
                            155 ;src/UI_LoadGame.c:79: ui_loadgame_entrySelected=1;
   4661 21 AC 7D      [10]  156 	ld	hl,#_ui_loadgame_entrySelected + 0
   4664 36 01         [10]  157 	ld	(hl), #0x01
   4666 C9            [10]  158 	ret
                            159 ;src/UI_LoadGame.c:82: void ui_loadgame_unselect_entry(){
                            160 ;	---------------------------------
                            161 ; Function ui_loadgame_unselect_entry
                            162 ; ---------------------------------
   4667                     163 _ui_loadgame_unselect_entry::
                            164 ;src/UI_LoadGame.c:83: ui_loadgame_entrySelected=0;
   4667 21 AC 7D      [10]  165 	ld	hl,#_ui_loadgame_entrySelected + 0
   466A 36 00         [10]  166 	ld	(hl), #0x00
   466C C9            [10]  167 	ret
                            168 ;src/UI_LoadGame.c:86: void ui_loadgame_render_button(u8 n){
                            169 ;	---------------------------------
                            170 ; Function ui_loadgame_render_button
                            171 ; ---------------------------------
   466D                     172 _ui_loadgame_render_button::
   466D DD E5         [15]  173 	push	ix
   466F DD 21 00 00   [14]  174 	ld	ix,#0
   4673 DD 39         [15]  175 	add	ix,sp
   4675 3B            [ 6]  176 	dec	sp
                            177 ;src/UI_LoadGame.c:88: color = (n==ui_loadgame_entryIndex)?((ui_loadgame_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4676 DD 7E 04      [19]  178 	ld	a,4 (ix)
   4679 FD 21 AB 7D   [14]  179 	ld	iy,#_ui_loadgame_entryIndex
   467D FD 96 00      [19]  180 	sub	a, 0 (iy)
   4680 20 10         [12]  181 	jr	NZ,00103$
   4682 3A AC 7D      [13]  182 	ld	a,(#_ui_loadgame_entrySelected + 0)
   4685 B7            [ 4]  183 	or	a, a
   4686 28 05         [12]  184 	jr	Z,00105$
   4688 3A 6A 1A      [13]  185 	ld	a, (#(_g_colors + 0x0004) + 0)
   468B 18 08         [12]  186 	jr	00104$
   468D                     187 00105$:
   468D 3A 6C 1A      [13]  188 	ld	a, (#(_g_colors + 0x0006) + 0)
   4690 18 03         [12]  189 	jr	00104$
   4692                     190 00103$:
   4692 3A 68 1A      [13]  191 	ld	a, (#(_g_colors + 0x0002) + 0)
   4695                     192 00104$:
   4695 DD 77 FF      [19]  193 	ld	-1 (ix),a
                            194 ;src/UI_LoadGame.c:89: cpct_drawSolidBox(ui_loadgame_entriesPosition[n],color, UI_LOADGAME_BUTTON_WIDTH, UI_LOADGAME_BUTTON_HEIGHT);
   4698 DD 6E 04      [19]  195 	ld	l,4 (ix)
   469B 26 00         [ 7]  196 	ld	h,#0x00
   469D 29            [11]  197 	add	hl, hl
   469E 4D            [ 4]  198 	ld	c, l
   469F 44            [ 4]  199 	ld	b, h
   46A0 21 16 46      [10]  200 	ld	hl,#_ui_loadgame_entriesPosition
   46A3 09            [11]  201 	add	hl,bc
   46A4 5E            [ 7]  202 	ld	e,(hl)
   46A5 23            [ 6]  203 	inc	hl
   46A6 56            [ 7]  204 	ld	d,(hl)
   46A7 C5            [11]  205 	push	bc
   46A8 21 0C 10      [10]  206 	ld	hl,#0x100C
   46AB E5            [11]  207 	push	hl
   46AC DD 7E FF      [19]  208 	ld	a,-1 (ix)
   46AF F5            [11]  209 	push	af
   46B0 33            [ 6]  210 	inc	sp
   46B1 D5            [11]  211 	push	de
   46B2 CD 92 7B      [17]  212 	call	_cpct_drawSolidBox
   46B5 F1            [10]  213 	pop	af
   46B6 F1            [10]  214 	pop	af
   46B7 33            [ 6]  215 	inc	sp
   46B8 C1            [10]  216 	pop	bc
                            217 ;src/UI_LoadGame.c:90: print_transparent_text(ui_loadgame_buttonText[n], ui_loadgame_entriesTextPosition[n], 3);
   46B9 21 1A 46      [10]  218 	ld	hl,#_ui_loadgame_entriesTextPosition
   46BC 09            [11]  219 	add	hl,bc
   46BD 5E            [ 7]  220 	ld	e,(hl)
   46BE 23            [ 6]  221 	inc	hl
   46BF 56            [ 7]  222 	ld	d,(hl)
   46C0 21 1E 46      [10]  223 	ld	hl,#_ui_loadgame_buttonText
   46C3 09            [11]  224 	add	hl,bc
   46C4 4E            [ 7]  225 	ld	c,(hl)
   46C5 23            [ 6]  226 	inc	hl
   46C6 46            [ 7]  227 	ld	b,(hl)
   46C7 3E 03         [ 7]  228 	ld	a,#0x03
   46C9 F5            [11]  229 	push	af
   46CA 33            [ 6]  230 	inc	sp
   46CB D5            [11]  231 	push	de
   46CC C5            [11]  232 	push	bc
   46CD CD A0 3F      [17]  233 	call	_print_transparent_text
   46D0 F1            [10]  234 	pop	af
   46D1 F1            [10]  235 	pop	af
   46D2 33            [ 6]  236 	inc	sp
   46D3 33            [ 6]  237 	inc	sp
   46D4 DD E1         [14]  238 	pop	ix
   46D6 C9            [10]  239 	ret
                            240 ;src/UI_LoadGame.c:94: void ui_loadgame_render_all(){
                            241 ;	---------------------------------
                            242 ; Function ui_loadgame_render_all
                            243 ; ---------------------------------
   46D7                     244 _ui_loadgame_render_all::
                            245 ;src/UI_LoadGame.c:97: cpct_drawSolidBox(UI_LOADGAME_STRING_POSITION, g_colors[1], 36,6);
   46D7 21 67 1A      [10]  246 	ld	hl, #(_g_colors + 0x0001) + 0
   46DA 46            [ 7]  247 	ld	b,(hl)
   46DB 21 24 06      [10]  248 	ld	hl,#0x0624
   46DE E5            [11]  249 	push	hl
   46DF C5            [11]  250 	push	bc
   46E0 33            [ 6]  251 	inc	sp
   46E1 21 86 DB      [10]  252 	ld	hl,#0xDB86
   46E4 E5            [11]  253 	push	hl
   46E5 CD 92 7B      [17]  254 	call	_cpct_drawSolidBox
   46E8 F1            [10]  255 	pop	af
   46E9 F1            [10]  256 	pop	af
   46EA 33            [ 6]  257 	inc	sp
                            258 ;src/UI_LoadGame.c:98: print_text(ui_stringinput_get_string(),UI_LOADGAME_STRING_POSITION, 1,3);
   46EB CD 45 3C      [17]  259 	call	_ui_stringinput_get_string
   46EE 4D            [ 4]  260 	ld	c,l
   46EF 44            [ 4]  261 	ld	b,h
   46F0 21 01 03      [10]  262 	ld	hl,#0x0301
   46F3 E5            [11]  263 	push	hl
   46F4 21 86 DB      [10]  264 	ld	hl,#0xDB86
   46F7 E5            [11]  265 	push	hl
   46F8 C5            [11]  266 	push	bc
   46F9 CD C5 3D      [17]  267 	call	_print_text
   46FC 21 06 00      [10]  268 	ld	hl,#6
   46FF 39            [11]  269 	add	hl,sp
   4700 F9            [ 6]  270 	ld	sp,hl
                            271 ;src/UI_LoadGame.c:100: while(n){
   4701 06 02         [ 7]  272 	ld	b,#0x02
   4703                     273 00101$:
   4703 78            [ 4]  274 	ld	a,b
   4704 B7            [ 4]  275 	or	a, a
   4705 28 0B         [12]  276 	jr	Z,00103$
                            277 ;src/UI_LoadGame.c:101: --n;
   4707 05            [ 4]  278 	dec	b
                            279 ;src/UI_LoadGame.c:102: ui_loadgame_render_button(n);
   4708 C5            [11]  280 	push	bc
   4709 C5            [11]  281 	push	bc
   470A 33            [ 6]  282 	inc	sp
   470B CD 6D 46      [17]  283 	call	_ui_loadgame_render_button
   470E 33            [ 6]  284 	inc	sp
   470F C1            [10]  285 	pop	bc
   4710 18 F1         [12]  286 	jr	00101$
   4712                     287 00103$:
                            288 ;src/UI_LoadGame.c:105: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
   4712 3A AB 7D      [13]  289 	ld	a,(#_ui_loadgame_entryIndex + 0)
   4715 32 AA 7D      [13]  290 	ld	(#_ui_loadgame_lastEntry + 0),a
   4718 C9            [10]  291 	ret
                            292 	.area _CODE
                            293 	.area _INITIALIZER
                            294 	.area _CABS (ABS)
