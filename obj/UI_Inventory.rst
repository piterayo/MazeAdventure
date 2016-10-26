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
   7DCD                      36 _ui_inventory_lastEntry::
   7DCD                      37 	.ds 1
   7DCE                      38 _ui_inventory_entryIndex::
   7DCE                      39 	.ds 1
   7DCF                      40 _ui_inventory_entrySelected::
   7DCF                      41 	.ds 1
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
   44FA                      70 _ui_inventory_init::
                             71 ;src/UI_Inventory.c:55: ui_inventory_lastEntry=0;
   44FA 21 CD 7D      [10]   72 	ld	hl,#_ui_inventory_lastEntry + 0
   44FD 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_Inventory.c:56: ui_inventory_entryIndex=0;
   44FF 21 CE 7D      [10]   75 	ld	hl,#_ui_inventory_entryIndex + 0
   4502 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_Inventory.c:57: ui_inventory_entrySelected=0;
   4504 21 CF 7D      [10]   78 	ld	hl,#_ui_inventory_entrySelected + 0
   4507 36 00         [10]   79 	ld	(hl), #0x00
   4509 C9            [10]   80 	ret
   450A                      81 _ui_inventory_entriesPosition:
   450A FB C2                82 	.dw #0xC2FB
   450C 9B E3                83 	.dw #0xE39B
   450E 82 C4                84 	.dw #0xC482
   4510                      85 _ui_inventory_entriesTextPosition:
   4510 FE EA                86 	.dw #0xEAFE
   4512 EE CB                87 	.dw #0xCBEE
   4514 84 EC                88 	.dw #0xEC84
   4516                      89 _ui_inventory_buttonText:
   4516 1C 45                90 	.dw __str_0
   4518 1C 45                91 	.dw __str_0
   451A 20 45                92 	.dw __str_1
   451C                      93 __str_0:
   451C 55 53 45             94 	.ascii "USE"
   451F 00                   95 	.db 0x00
   4520                      96 __str_1:
   4520 45 58 49 54          97 	.ascii "EXIT"
   4524 00                   98 	.db 0x00
                             99 ;src/UI_Inventory.c:61: u8 ui_inventory_get_entry(){
                            100 ;	---------------------------------
                            101 ; Function ui_inventory_get_entry
                            102 ; ---------------------------------
   4525                     103 _ui_inventory_get_entry::
                            104 ;src/UI_Inventory.c:62: return ui_inventory_entryIndex;
   4525 FD 21 CE 7D   [14]  105 	ld	iy,#_ui_inventory_entryIndex
   4529 FD 6E 00      [19]  106 	ld	l,0 (iy)
   452C C9            [10]  107 	ret
                            108 ;src/UI_Inventory.c:65: u8 ui_inventory_is_selected(){
                            109 ;	---------------------------------
                            110 ; Function ui_inventory_is_selected
                            111 ; ---------------------------------
   452D                     112 _ui_inventory_is_selected::
                            113 ;src/UI_Inventory.c:66: return ui_inventory_entrySelected;
   452D FD 21 CF 7D   [14]  114 	ld	iy,#_ui_inventory_entrySelected
   4531 FD 6E 00      [19]  115 	ld	l,0 (iy)
   4534 C9            [10]  116 	ret
                            117 ;src/UI_Inventory.c:69: void ui_inventory_next_entry(){
                            118 ;	---------------------------------
                            119 ; Function ui_inventory_next_entry
                            120 ; ---------------------------------
   4535                     121 _ui_inventory_next_entry::
                            122 ;src/UI_Inventory.c:70: if(ui_inventory_entryIndex<(UI_INVENTORY_ENTRIES-1)){
                            123 ;src/UI_Inventory.c:71: ui_inventory_lastEntry=ui_inventory_entryIndex;
   4535 3A CE 7D      [13]  124 	ld	a,(#_ui_inventory_entryIndex + 0)
   4538 FE 02         [ 7]  125 	cp	a,#0x02
   453A D0            [11]  126 	ret	NC
   453B 32 CD 7D      [13]  127 	ld	(#_ui_inventory_lastEntry + 0),a
                            128 ;src/UI_Inventory.c:72: ++ui_inventory_entryIndex;
   453E 21 CE 7D      [10]  129 	ld	hl, #_ui_inventory_entryIndex+0
   4541 34            [11]  130 	inc	(hl)
   4542 C9            [10]  131 	ret
                            132 ;src/UI_Inventory.c:76: void ui_inventory_previous_entry(){
                            133 ;	---------------------------------
                            134 ; Function ui_inventory_previous_entry
                            135 ; ---------------------------------
   4543                     136 _ui_inventory_previous_entry::
                            137 ;src/UI_Inventory.c:77: if(ui_inventory_entryIndex>0){
   4543 3A CE 7D      [13]  138 	ld	a,(#_ui_inventory_entryIndex + 0)
   4546 B7            [ 4]  139 	or	a, a
   4547 C8            [11]  140 	ret	Z
                            141 ;src/UI_Inventory.c:78: ui_inventory_lastEntry=ui_inventory_entryIndex;
   4548 3A CE 7D      [13]  142 	ld	a,(#_ui_inventory_entryIndex + 0)
   454B 32 CD 7D      [13]  143 	ld	(#_ui_inventory_lastEntry + 0),a
                            144 ;src/UI_Inventory.c:79: --ui_inventory_entryIndex;
   454E 21 CE 7D      [10]  145 	ld	hl, #_ui_inventory_entryIndex+0
   4551 35            [11]  146 	dec	(hl)
   4552 C9            [10]  147 	ret
                            148 ;src/UI_Inventory.c:84: void ui_inventory_select_entry(){
                            149 ;	---------------------------------
                            150 ; Function ui_inventory_select_entry
                            151 ; ---------------------------------
   4553                     152 _ui_inventory_select_entry::
                            153 ;src/UI_Inventory.c:85: ui_inventory_entrySelected=1;
   4553 21 CF 7D      [10]  154 	ld	hl,#_ui_inventory_entrySelected + 0
   4556 36 01         [10]  155 	ld	(hl), #0x01
   4558 C9            [10]  156 	ret
                            157 ;src/UI_Inventory.c:88: void ui_inventory_unselect_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_inventory_unselect_entry
                            160 ; ---------------------------------
   4559                     161 _ui_inventory_unselect_entry::
                            162 ;src/UI_Inventory.c:89: ui_inventory_entrySelected=0;
   4559 21 CF 7D      [10]  163 	ld	hl,#_ui_inventory_entrySelected + 0
   455C 36 00         [10]  164 	ld	(hl), #0x00
   455E C9            [10]  165 	ret
                            166 ;src/UI_Inventory.c:92: void ui_inventory_render_button(u8 n){
                            167 ;	---------------------------------
                            168 ; Function ui_inventory_render_button
                            169 ; ---------------------------------
   455F                     170 _ui_inventory_render_button::
   455F DD E5         [15]  171 	push	ix
   4561 DD 21 00 00   [14]  172 	ld	ix,#0
   4565 DD 39         [15]  173 	add	ix,sp
   4567 3B            [ 6]  174 	dec	sp
                            175 ;src/UI_Inventory.c:94: color = (n==ui_inventory_entryIndex)?((ui_inventory_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4568 DD 7E 04      [19]  176 	ld	a,4 (ix)
   456B FD 21 CE 7D   [14]  177 	ld	iy,#_ui_inventory_entryIndex
   456F FD 96 00      [19]  178 	sub	a, 0 (iy)
   4572 20 10         [12]  179 	jr	NZ,00103$
   4574 3A CF 7D      [13]  180 	ld	a,(#_ui_inventory_entrySelected + 0)
   4577 B7            [ 4]  181 	or	a, a
   4578 28 05         [12]  182 	jr	Z,00105$
   457A 3A B3 1A      [13]  183 	ld	a, (#(_g_colors + 0x0004) + 0)
   457D 18 08         [12]  184 	jr	00104$
   457F                     185 00105$:
   457F 3A B5 1A      [13]  186 	ld	a, (#(_g_colors + 0x0006) + 0)
   4582 18 03         [12]  187 	jr	00104$
   4584                     188 00103$:
   4584 3A B1 1A      [13]  189 	ld	a, (#(_g_colors + 0x0002) + 0)
   4587                     190 00104$:
   4587 DD 77 FF      [19]  191 	ld	-1 (ix),a
                            192 ;src/UI_Inventory.c:95: cpct_drawSolidBox(ui_inventory_entriesPosition[n],color, UI_INVENTORY_BUTTON_WIDTH, UI_INVENTORY_BUTTON_HEIGHT);
   458A DD 6E 04      [19]  193 	ld	l,4 (ix)
   458D 26 00         [ 7]  194 	ld	h,#0x00
   458F 29            [11]  195 	add	hl, hl
   4590 4D            [ 4]  196 	ld	c, l
   4591 44            [ 4]  197 	ld	b, h
   4592 21 0A 45      [10]  198 	ld	hl,#_ui_inventory_entriesPosition
   4595 09            [11]  199 	add	hl,bc
   4596 5E            [ 7]  200 	ld	e,(hl)
   4597 23            [ 6]  201 	inc	hl
   4598 56            [ 7]  202 	ld	d,(hl)
   4599 C5            [11]  203 	push	bc
   459A 21 0C 10      [10]  204 	ld	hl,#0x100C
   459D E5            [11]  205 	push	hl
   459E DD 7E FF      [19]  206 	ld	a,-1 (ix)
   45A1 F5            [11]  207 	push	af
   45A2 33            [ 6]  208 	inc	sp
   45A3 D5            [11]  209 	push	de
   45A4 CD B8 7B      [17]  210 	call	_cpct_drawSolidBox
   45A7 F1            [10]  211 	pop	af
   45A8 F1            [10]  212 	pop	af
   45A9 33            [ 6]  213 	inc	sp
   45AA C1            [10]  214 	pop	bc
                            215 ;src/UI_Inventory.c:96: print_transparent_text(ui_inventory_buttonText[n], ui_inventory_entriesTextPosition[n], 3);
   45AB 21 10 45      [10]  216 	ld	hl,#_ui_inventory_entriesTextPosition
   45AE 09            [11]  217 	add	hl,bc
   45AF 5E            [ 7]  218 	ld	e,(hl)
   45B0 23            [ 6]  219 	inc	hl
   45B1 56            [ 7]  220 	ld	d,(hl)
   45B2 21 16 45      [10]  221 	ld	hl,#_ui_inventory_buttonText
   45B5 09            [11]  222 	add	hl,bc
   45B6 4E            [ 7]  223 	ld	c,(hl)
   45B7 23            [ 6]  224 	inc	hl
   45B8 46            [ 7]  225 	ld	b,(hl)
   45B9 3E 03         [ 7]  226 	ld	a,#0x03
   45BB F5            [11]  227 	push	af
   45BC 33            [ 6]  228 	inc	sp
   45BD D5            [11]  229 	push	de
   45BE C5            [11]  230 	push	bc
   45BF CD C6 3F      [17]  231 	call	_print_transparent_text
   45C2 F1            [10]  232 	pop	af
   45C3 F1            [10]  233 	pop	af
   45C4 33            [ 6]  234 	inc	sp
   45C5 33            [ 6]  235 	inc	sp
   45C6 DD E1         [14]  236 	pop	ix
   45C8 C9            [10]  237 	ret
                            238 ;src/UI_Inventory.c:100: void ui_inventory_render_refresh(){
                            239 ;	---------------------------------
                            240 ; Function ui_inventory_render_refresh
                            241 ; ---------------------------------
   45C9                     242 _ui_inventory_render_refresh::
                            243 ;src/UI_Inventory.c:102: ui_inventory_render_button(ui_inventory_entryIndex);
   45C9 3A CE 7D      [13]  244 	ld	a,(_ui_inventory_entryIndex)
   45CC F5            [11]  245 	push	af
   45CD 33            [ 6]  246 	inc	sp
   45CE CD 5F 45      [17]  247 	call	_ui_inventory_render_button
   45D1 33            [ 6]  248 	inc	sp
                            249 ;src/UI_Inventory.c:103: ui_inventory_render_button(ui_inventory_lastEntry);
   45D2 3A CD 7D      [13]  250 	ld	a,(_ui_inventory_lastEntry)
   45D5 F5            [11]  251 	push	af
   45D6 33            [ 6]  252 	inc	sp
   45D7 CD 5F 45      [17]  253 	call	_ui_inventory_render_button
   45DA 33            [ 6]  254 	inc	sp
                            255 ;src/UI_Inventory.c:105: ui_inventory_lastEntry=ui_inventory_entryIndex;
   45DB 3A CE 7D      [13]  256 	ld	a,(#_ui_inventory_entryIndex + 0)
   45DE 32 CD 7D      [13]  257 	ld	(#_ui_inventory_lastEntry + 0),a
   45E1 C9            [10]  258 	ret
                            259 ;src/UI_Inventory.c:108: void ui_inventory_render_all(){
                            260 ;	---------------------------------
                            261 ; Function ui_inventory_render_all
                            262 ; ---------------------------------
   45E2                     263 _ui_inventory_render_all::
                            264 ;src/UI_Inventory.c:111: print_transparent_text("POTION", UI_INVENTORY_BUTTON_POTIONS_LABEL_POSITION, 3);
   45E2 3E 03         [ 7]  265 	ld	a,#0x03
   45E4 F5            [11]  266 	push	af
   45E5 33            [ 6]  267 	inc	sp
   45E6 21 EA EA      [10]  268 	ld	hl,#0xEAEA
   45E9 E5            [11]  269 	push	hl
   45EA 21 1E 46      [10]  270 	ld	hl,#___str_2
   45ED E5            [11]  271 	push	hl
   45EE CD C6 3F      [17]  272 	call	_print_transparent_text
   45F1 F1            [10]  273 	pop	af
   45F2 F1            [10]  274 	pop	af
   45F3 33            [ 6]  275 	inc	sp
                            276 ;src/UI_Inventory.c:112: print_transparent_text("SCROLL", UI_INVENTORY_BUTTON_SCROLLS_LABEL_POSITION, 3);
   45F4 3E 03         [ 7]  277 	ld	a,#0x03
   45F6 F5            [11]  278 	push	af
   45F7 33            [ 6]  279 	inc	sp
   45F8 21 DA CB      [10]  280 	ld	hl,#0xCBDA
   45FB E5            [11]  281 	push	hl
   45FC 21 25 46      [10]  282 	ld	hl,#___str_3
   45FF E5            [11]  283 	push	hl
   4600 CD C6 3F      [17]  284 	call	_print_transparent_text
   4603 F1            [10]  285 	pop	af
   4604 F1            [10]  286 	pop	af
   4605 33            [ 6]  287 	inc	sp
                            288 ;src/UI_Inventory.c:114: while(n){
   4606 06 03         [ 7]  289 	ld	b,#0x03
   4608                     290 00101$:
   4608 78            [ 4]  291 	ld	a,b
   4609 B7            [ 4]  292 	or	a, a
   460A 28 0B         [12]  293 	jr	Z,00103$
                            294 ;src/UI_Inventory.c:115: --n;
   460C 05            [ 4]  295 	dec	b
                            296 ;src/UI_Inventory.c:116: ui_inventory_render_button(n);
   460D C5            [11]  297 	push	bc
   460E C5            [11]  298 	push	bc
   460F 33            [ 6]  299 	inc	sp
   4610 CD 5F 45      [17]  300 	call	_ui_inventory_render_button
   4613 33            [ 6]  301 	inc	sp
   4614 C1            [10]  302 	pop	bc
   4615 18 F1         [12]  303 	jr	00101$
   4617                     304 00103$:
                            305 ;src/UI_Inventory.c:119: ui_inventory_lastEntry=ui_inventory_entryIndex;
   4617 3A CE 7D      [13]  306 	ld	a,(#_ui_inventory_entryIndex + 0)
   461A 32 CD 7D      [13]  307 	ld	(#_ui_inventory_lastEntry + 0),a
   461D C9            [10]  308 	ret
   461E                     309 ___str_2:
   461E 50 4F 54 49 4F 4E   310 	.ascii "POTION"
   4624 00                  311 	.db 0x00
   4625                     312 ___str_3:
   4625 53 43 52 4F 4C 4C   313 	.ascii "SCROLL"
   462B 00                  314 	.db 0x00
                            315 	.area _CODE
                            316 	.area _INITIALIZER
                            317 	.area _CABS (ABS)
