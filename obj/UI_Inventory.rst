                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_Inventory
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_inventory_render_button
                             12 	.globl _print_transparent_text
                             13 	.globl _cpct_drawSolidBox
                             14 	.globl _ui_inventory_entrySelected
                             15 	.globl _ui_inventory_entryIndex
                             16 	.globl _ui_inventory_lastEntry
                             17 	.globl _ui_inventory_buttonText
                             18 	.globl _ui_inventory_entriesTextPosition
                             19 	.globl _ui_inventory_entriesPosition
                             20 	.globl _ui_inventory_init
                             21 	.globl _ui_inventory_get_entry
                             22 	.globl _ui_inventory_is_selected
                             23 	.globl _ui_inventory_next_entry
                             24 	.globl _ui_inventory_previous_entry
                             25 	.globl _ui_inventory_select_entry
                             26 	.globl _ui_inventory_unselect_entry
                             27 	.globl _ui_inventory_render_refresh
                             28 	.globl _ui_inventory_render_all
                             29 ;--------------------------------------------------------
                             30 ; special function registers
                             31 ;--------------------------------------------------------
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _DATA
   7DA7                      36 _ui_inventory_lastEntry::
   7DA7                      37 	.ds 1
   7DA8                      38 _ui_inventory_entryIndex::
   7DA8                      39 	.ds 1
   7DA9                      40 _ui_inventory_entrySelected::
   7DA9                      41 	.ds 1
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
                             66 ;src/UI_Inventory.c:54: void ui_inventory_init(){
                             67 ;	---------------------------------
                             68 ; Function ui_inventory_init
                             69 ; ---------------------------------
   44D4                      70 _ui_inventory_init::
                             71 ;src/UI_Inventory.c:55: ui_inventory_lastEntry=0;
   44D4 21 A7 7D      [10]   72 	ld	hl,#_ui_inventory_lastEntry + 0
   44D7 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_Inventory.c:56: ui_inventory_entryIndex=0;
   44D9 21 A8 7D      [10]   75 	ld	hl,#_ui_inventory_entryIndex + 0
   44DC 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_Inventory.c:57: ui_inventory_entrySelected=0;
   44DE 21 A9 7D      [10]   78 	ld	hl,#_ui_inventory_entrySelected + 0
   44E1 36 00         [10]   79 	ld	(hl), #0x00
   44E3 C9            [10]   80 	ret
   44E4                      81 _ui_inventory_entriesPosition:
   44E4 FB C2                82 	.dw #0xC2FB
   44E6 9B E3                83 	.dw #0xE39B
   44E8 82 C4                84 	.dw #0xC482
   44EA                      85 _ui_inventory_entriesTextPosition:
   44EA FE EA                86 	.dw #0xEAFE
   44EC EE CB                87 	.dw #0xCBEE
   44EE 84 EC                88 	.dw #0xEC84
   44F0                      89 _ui_inventory_buttonText:
   44F0 F6 44                90 	.dw __str_0
   44F2 F6 44                91 	.dw __str_0
   44F4 FA 44                92 	.dw __str_1
   44F6                      93 __str_0:
   44F6 55 53 45             94 	.ascii "USE"
   44F9 00                   95 	.db 0x00
   44FA                      96 __str_1:
   44FA 45 58 49 54          97 	.ascii "EXIT"
   44FE 00                   98 	.db 0x00
                             99 ;src/UI_Inventory.c:61: u8 ui_inventory_get_entry(){
                            100 ;	---------------------------------
                            101 ; Function ui_inventory_get_entry
                            102 ; ---------------------------------
   44FF                     103 _ui_inventory_get_entry::
                            104 ;src/UI_Inventory.c:62: return ui_inventory_entryIndex;
   44FF FD 21 A8 7D   [14]  105 	ld	iy,#_ui_inventory_entryIndex
   4503 FD 6E 00      [19]  106 	ld	l,0 (iy)
   4506 C9            [10]  107 	ret
                            108 ;src/UI_Inventory.c:65: u8 ui_inventory_is_selected(){
                            109 ;	---------------------------------
                            110 ; Function ui_inventory_is_selected
                            111 ; ---------------------------------
   4507                     112 _ui_inventory_is_selected::
                            113 ;src/UI_Inventory.c:66: return ui_inventory_entrySelected;
   4507 FD 21 A9 7D   [14]  114 	ld	iy,#_ui_inventory_entrySelected
   450B FD 6E 00      [19]  115 	ld	l,0 (iy)
   450E C9            [10]  116 	ret
                            117 ;src/UI_Inventory.c:69: void ui_inventory_next_entry(){
                            118 ;	---------------------------------
                            119 ; Function ui_inventory_next_entry
                            120 ; ---------------------------------
   450F                     121 _ui_inventory_next_entry::
                            122 ;src/UI_Inventory.c:70: if(ui_inventory_entryIndex<(UI_INVENTORY_ENTRIES-1)){
                            123 ;src/UI_Inventory.c:71: ui_inventory_lastEntry=ui_inventory_entryIndex;
   450F 3A A8 7D      [13]  124 	ld	a,(#_ui_inventory_entryIndex + 0)
   4512 FE 02         [ 7]  125 	cp	a,#0x02
   4514 D0            [11]  126 	ret	NC
   4515 32 A7 7D      [13]  127 	ld	(#_ui_inventory_lastEntry + 0),a
                            128 ;src/UI_Inventory.c:72: ++ui_inventory_entryIndex;
   4518 21 A8 7D      [10]  129 	ld	hl, #_ui_inventory_entryIndex+0
   451B 34            [11]  130 	inc	(hl)
   451C C9            [10]  131 	ret
                            132 ;src/UI_Inventory.c:76: void ui_inventory_previous_entry(){
                            133 ;	---------------------------------
                            134 ; Function ui_inventory_previous_entry
                            135 ; ---------------------------------
   451D                     136 _ui_inventory_previous_entry::
                            137 ;src/UI_Inventory.c:77: if(ui_inventory_entryIndex>0){
   451D 3A A8 7D      [13]  138 	ld	a,(#_ui_inventory_entryIndex + 0)
   4520 B7            [ 4]  139 	or	a, a
   4521 C8            [11]  140 	ret	Z
                            141 ;src/UI_Inventory.c:78: ui_inventory_lastEntry=ui_inventory_entryIndex;
   4522 3A A8 7D      [13]  142 	ld	a,(#_ui_inventory_entryIndex + 0)
   4525 32 A7 7D      [13]  143 	ld	(#_ui_inventory_lastEntry + 0),a
                            144 ;src/UI_Inventory.c:79: --ui_inventory_entryIndex;
   4528 21 A8 7D      [10]  145 	ld	hl, #_ui_inventory_entryIndex+0
   452B 35            [11]  146 	dec	(hl)
   452C C9            [10]  147 	ret
                            148 ;src/UI_Inventory.c:84: void ui_inventory_select_entry(){
                            149 ;	---------------------------------
                            150 ; Function ui_inventory_select_entry
                            151 ; ---------------------------------
   452D                     152 _ui_inventory_select_entry::
                            153 ;src/UI_Inventory.c:85: ui_inventory_entrySelected=1;
   452D 21 A9 7D      [10]  154 	ld	hl,#_ui_inventory_entrySelected + 0
   4530 36 01         [10]  155 	ld	(hl), #0x01
   4532 C9            [10]  156 	ret
                            157 ;src/UI_Inventory.c:88: void ui_inventory_unselect_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_inventory_unselect_entry
                            160 ; ---------------------------------
   4533                     161 _ui_inventory_unselect_entry::
                            162 ;src/UI_Inventory.c:89: ui_inventory_entrySelected=0;
   4533 21 A9 7D      [10]  163 	ld	hl,#_ui_inventory_entrySelected + 0
   4536 36 00         [10]  164 	ld	(hl), #0x00
   4538 C9            [10]  165 	ret
                            166 ;src/UI_Inventory.c:92: void ui_inventory_render_button(u8 n){
                            167 ;	---------------------------------
                            168 ; Function ui_inventory_render_button
                            169 ; ---------------------------------
   4539                     170 _ui_inventory_render_button::
   4539 DD E5         [15]  171 	push	ix
   453B DD 21 00 00   [14]  172 	ld	ix,#0
   453F DD 39         [15]  173 	add	ix,sp
   4541 3B            [ 6]  174 	dec	sp
                            175 ;src/UI_Inventory.c:94: color = (n==ui_inventory_entryIndex)?((ui_inventory_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4542 DD 7E 04      [19]  176 	ld	a,4 (ix)
   4545 FD 21 A8 7D   [14]  177 	ld	iy,#_ui_inventory_entryIndex
   4549 FD 96 00      [19]  178 	sub	a, 0 (iy)
   454C 20 10         [12]  179 	jr	NZ,00103$
   454E 3A A9 7D      [13]  180 	ld	a,(#_ui_inventory_entrySelected + 0)
   4551 B7            [ 4]  181 	or	a, a
   4552 28 05         [12]  182 	jr	Z,00105$
   4554 3A 6A 1A      [13]  183 	ld	a, (#(_g_colors + 0x0004) + 0)
   4557 18 08         [12]  184 	jr	00104$
   4559                     185 00105$:
   4559 3A 6C 1A      [13]  186 	ld	a, (#(_g_colors + 0x0006) + 0)
   455C 18 03         [12]  187 	jr	00104$
   455E                     188 00103$:
   455E 3A 68 1A      [13]  189 	ld	a, (#(_g_colors + 0x0002) + 0)
   4561                     190 00104$:
   4561 DD 77 FF      [19]  191 	ld	-1 (ix),a
                            192 ;src/UI_Inventory.c:95: cpct_drawSolidBox(ui_inventory_entriesPosition[n],color, UI_INVENTORY_BUTTON_WIDTH, UI_INVENTORY_BUTTON_HEIGHT);
   4564 DD 6E 04      [19]  193 	ld	l,4 (ix)
   4567 26 00         [ 7]  194 	ld	h,#0x00
   4569 29            [11]  195 	add	hl, hl
   456A 4D            [ 4]  196 	ld	c, l
   456B 44            [ 4]  197 	ld	b, h
   456C 21 E4 44      [10]  198 	ld	hl,#_ui_inventory_entriesPosition
   456F 09            [11]  199 	add	hl,bc
   4570 5E            [ 7]  200 	ld	e,(hl)
   4571 23            [ 6]  201 	inc	hl
   4572 56            [ 7]  202 	ld	d,(hl)
   4573 C5            [11]  203 	push	bc
   4574 21 0C 10      [10]  204 	ld	hl,#0x100C
   4577 E5            [11]  205 	push	hl
   4578 DD 7E FF      [19]  206 	ld	a,-1 (ix)
   457B F5            [11]  207 	push	af
   457C 33            [ 6]  208 	inc	sp
   457D D5            [11]  209 	push	de
   457E CD 92 7B      [17]  210 	call	_cpct_drawSolidBox
   4581 F1            [10]  211 	pop	af
   4582 F1            [10]  212 	pop	af
   4583 33            [ 6]  213 	inc	sp
   4584 C1            [10]  214 	pop	bc
                            215 ;src/UI_Inventory.c:96: print_transparent_text(ui_inventory_buttonText[n], ui_inventory_entriesTextPosition[n], 3);
   4585 21 EA 44      [10]  216 	ld	hl,#_ui_inventory_entriesTextPosition
   4588 09            [11]  217 	add	hl,bc
   4589 5E            [ 7]  218 	ld	e,(hl)
   458A 23            [ 6]  219 	inc	hl
   458B 56            [ 7]  220 	ld	d,(hl)
   458C 21 F0 44      [10]  221 	ld	hl,#_ui_inventory_buttonText
   458F 09            [11]  222 	add	hl,bc
   4590 4E            [ 7]  223 	ld	c,(hl)
   4591 23            [ 6]  224 	inc	hl
   4592 46            [ 7]  225 	ld	b,(hl)
   4593 3E 03         [ 7]  226 	ld	a,#0x03
   4595 F5            [11]  227 	push	af
   4596 33            [ 6]  228 	inc	sp
   4597 D5            [11]  229 	push	de
   4598 C5            [11]  230 	push	bc
   4599 CD A0 3F      [17]  231 	call	_print_transparent_text
   459C F1            [10]  232 	pop	af
   459D F1            [10]  233 	pop	af
   459E 33            [ 6]  234 	inc	sp
   459F 33            [ 6]  235 	inc	sp
   45A0 DD E1         [14]  236 	pop	ix
   45A2 C9            [10]  237 	ret
                            238 ;src/UI_Inventory.c:100: void ui_inventory_render_refresh(){
                            239 ;	---------------------------------
                            240 ; Function ui_inventory_render_refresh
                            241 ; ---------------------------------
   45A3                     242 _ui_inventory_render_refresh::
                            243 ;src/UI_Inventory.c:102: ui_inventory_render_button(ui_inventory_entryIndex);
   45A3 3A A8 7D      [13]  244 	ld	a,(_ui_inventory_entryIndex)
   45A6 F5            [11]  245 	push	af
   45A7 33            [ 6]  246 	inc	sp
   45A8 CD 39 45      [17]  247 	call	_ui_inventory_render_button
   45AB 33            [ 6]  248 	inc	sp
                            249 ;src/UI_Inventory.c:103: ui_inventory_render_button(ui_inventory_lastEntry);
   45AC 3A A7 7D      [13]  250 	ld	a,(_ui_inventory_lastEntry)
   45AF F5            [11]  251 	push	af
   45B0 33            [ 6]  252 	inc	sp
   45B1 CD 39 45      [17]  253 	call	_ui_inventory_render_button
   45B4 33            [ 6]  254 	inc	sp
                            255 ;src/UI_Inventory.c:105: ui_inventory_lastEntry=ui_inventory_entryIndex;
   45B5 3A A8 7D      [13]  256 	ld	a,(#_ui_inventory_entryIndex + 0)
   45B8 32 A7 7D      [13]  257 	ld	(#_ui_inventory_lastEntry + 0),a
   45BB C9            [10]  258 	ret
                            259 ;src/UI_Inventory.c:108: void ui_inventory_render_all(){
                            260 ;	---------------------------------
                            261 ; Function ui_inventory_render_all
                            262 ; ---------------------------------
   45BC                     263 _ui_inventory_render_all::
                            264 ;src/UI_Inventory.c:111: print_transparent_text("POTION", UI_INVENTORY_BUTTON_POTIONS_LABEL_POSITION, 3);
   45BC 3E 03         [ 7]  265 	ld	a,#0x03
   45BE F5            [11]  266 	push	af
   45BF 33            [ 6]  267 	inc	sp
   45C0 21 EA EA      [10]  268 	ld	hl,#0xEAEA
   45C3 E5            [11]  269 	push	hl
   45C4 21 F8 45      [10]  270 	ld	hl,#___str_2
   45C7 E5            [11]  271 	push	hl
   45C8 CD A0 3F      [17]  272 	call	_print_transparent_text
   45CB F1            [10]  273 	pop	af
   45CC F1            [10]  274 	pop	af
   45CD 33            [ 6]  275 	inc	sp
                            276 ;src/UI_Inventory.c:112: print_transparent_text("SCROLL", UI_INVENTORY_BUTTON_SCROLLS_LABEL_POSITION, 3);
   45CE 3E 03         [ 7]  277 	ld	a,#0x03
   45D0 F5            [11]  278 	push	af
   45D1 33            [ 6]  279 	inc	sp
   45D2 21 DA CB      [10]  280 	ld	hl,#0xCBDA
   45D5 E5            [11]  281 	push	hl
   45D6 21 FF 45      [10]  282 	ld	hl,#___str_3
   45D9 E5            [11]  283 	push	hl
   45DA CD A0 3F      [17]  284 	call	_print_transparent_text
   45DD F1            [10]  285 	pop	af
   45DE F1            [10]  286 	pop	af
   45DF 33            [ 6]  287 	inc	sp
                            288 ;src/UI_Inventory.c:114: while(n){
   45E0 06 03         [ 7]  289 	ld	b,#0x03
   45E2                     290 00101$:
   45E2 78            [ 4]  291 	ld	a,b
   45E3 B7            [ 4]  292 	or	a, a
   45E4 28 0B         [12]  293 	jr	Z,00103$
                            294 ;src/UI_Inventory.c:115: --n;
   45E6 05            [ 4]  295 	dec	b
                            296 ;src/UI_Inventory.c:116: ui_inventory_render_button(n);
   45E7 C5            [11]  297 	push	bc
   45E8 C5            [11]  298 	push	bc
   45E9 33            [ 6]  299 	inc	sp
   45EA CD 39 45      [17]  300 	call	_ui_inventory_render_button
   45ED 33            [ 6]  301 	inc	sp
   45EE C1            [10]  302 	pop	bc
   45EF 18 F1         [12]  303 	jr	00101$
   45F1                     304 00103$:
                            305 ;src/UI_Inventory.c:119: ui_inventory_lastEntry=ui_inventory_entryIndex;
   45F1 3A A8 7D      [13]  306 	ld	a,(#_ui_inventory_entryIndex + 0)
   45F4 32 A7 7D      [13]  307 	ld	(#_ui_inventory_lastEntry + 0),a
   45F7 C9            [10]  308 	ret
   45F8                     309 ___str_2:
   45F8 50 4F 54 49 4F 4E   310 	.ascii "POTION"
   45FE 00                  311 	.db 0x00
   45FF                     312 ___str_3:
   45FF 53 43 52 4F 4C 4C   313 	.ascii "SCROLL"
   4605 00                  314 	.db 0x00
                            315 	.area _CODE
                            316 	.area _INITIALIZER
                            317 	.area _CABS (ABS)
