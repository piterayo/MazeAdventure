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
   8747                      36 _ui_inventory_lastEntry::
   8747                      37 	.ds 1
   8748                      38 _ui_inventory_entryIndex::
   8748                      39 	.ds 1
   8749                      40 _ui_inventory_entrySelected::
   8749                      41 	.ds 1
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
   4648                      70 _ui_inventory_init::
                             71 ;src/UI_Inventory.c:55: ui_inventory_lastEntry=0;
   4648 21 47 87      [10]   72 	ld	hl,#_ui_inventory_lastEntry + 0
   464B 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_Inventory.c:56: ui_inventory_entryIndex=0;
   464D 21 48 87      [10]   75 	ld	hl,#_ui_inventory_entryIndex + 0
   4650 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_Inventory.c:57: ui_inventory_entrySelected=0;
   4652 21 49 87      [10]   78 	ld	hl,#_ui_inventory_entrySelected + 0
   4655 36 00         [10]   79 	ld	(hl), #0x00
   4657 C9            [10]   80 	ret
   4658                      81 _ui_inventory_entriesPosition:
   4658 FB C2                82 	.dw #0xC2FB
   465A 9B E3                83 	.dw #0xE39B
   465C 82 C4                84 	.dw #0xC482
   465E                      85 _ui_inventory_entriesTextPosition:
   465E FE EA                86 	.dw #0xEAFE
   4660 EE CB                87 	.dw #0xCBEE
   4662 84 EC                88 	.dw #0xEC84
   4664                      89 _ui_inventory_buttonText:
   4664 6A 46                90 	.dw __str_0
   4666 6A 46                91 	.dw __str_0
   4668 6E 46                92 	.dw __str_1
   466A                      93 __str_0:
   466A 55 53 45             94 	.ascii "USE"
   466D 00                   95 	.db 0x00
   466E                      96 __str_1:
   466E 45 58 49 54          97 	.ascii "EXIT"
   4672 00                   98 	.db 0x00
                             99 ;src/UI_Inventory.c:61: u8 ui_inventory_get_entry(){
                            100 ;	---------------------------------
                            101 ; Function ui_inventory_get_entry
                            102 ; ---------------------------------
   4673                     103 _ui_inventory_get_entry::
                            104 ;src/UI_Inventory.c:62: return ui_inventory_entryIndex;
   4673 FD 21 48 87   [14]  105 	ld	iy,#_ui_inventory_entryIndex
   4677 FD 6E 00      [19]  106 	ld	l,0 (iy)
   467A C9            [10]  107 	ret
                            108 ;src/UI_Inventory.c:65: u8 ui_inventory_is_selected(){
                            109 ;	---------------------------------
                            110 ; Function ui_inventory_is_selected
                            111 ; ---------------------------------
   467B                     112 _ui_inventory_is_selected::
                            113 ;src/UI_Inventory.c:66: return ui_inventory_entrySelected;
   467B FD 21 49 87   [14]  114 	ld	iy,#_ui_inventory_entrySelected
   467F FD 6E 00      [19]  115 	ld	l,0 (iy)
   4682 C9            [10]  116 	ret
                            117 ;src/UI_Inventory.c:69: void ui_inventory_next_entry(){
                            118 ;	---------------------------------
                            119 ; Function ui_inventory_next_entry
                            120 ; ---------------------------------
   4683                     121 _ui_inventory_next_entry::
                            122 ;src/UI_Inventory.c:70: if(ui_inventory_entryIndex<(UI_INVENTORY_ENTRIES-1)){
                            123 ;src/UI_Inventory.c:71: ui_inventory_lastEntry=ui_inventory_entryIndex;
   4683 3A 48 87      [13]  124 	ld	a,(#_ui_inventory_entryIndex + 0)
   4686 FE 02         [ 7]  125 	cp	a,#0x02
   4688 D0            [11]  126 	ret	NC
   4689 32 47 87      [13]  127 	ld	(#_ui_inventory_lastEntry + 0),a
                            128 ;src/UI_Inventory.c:72: ++ui_inventory_entryIndex;
   468C 21 48 87      [10]  129 	ld	hl, #_ui_inventory_entryIndex+0
   468F 34            [11]  130 	inc	(hl)
   4690 C9            [10]  131 	ret
                            132 ;src/UI_Inventory.c:76: void ui_inventory_previous_entry(){
                            133 ;	---------------------------------
                            134 ; Function ui_inventory_previous_entry
                            135 ; ---------------------------------
   4691                     136 _ui_inventory_previous_entry::
                            137 ;src/UI_Inventory.c:77: if(ui_inventory_entryIndex>0){
   4691 3A 48 87      [13]  138 	ld	a,(#_ui_inventory_entryIndex + 0)
   4694 B7            [ 4]  139 	or	a, a
   4695 C8            [11]  140 	ret	Z
                            141 ;src/UI_Inventory.c:78: ui_inventory_lastEntry=ui_inventory_entryIndex;
   4696 3A 48 87      [13]  142 	ld	a,(#_ui_inventory_entryIndex + 0)
   4699 32 47 87      [13]  143 	ld	(#_ui_inventory_lastEntry + 0),a
                            144 ;src/UI_Inventory.c:79: --ui_inventory_entryIndex;
   469C 21 48 87      [10]  145 	ld	hl, #_ui_inventory_entryIndex+0
   469F 35            [11]  146 	dec	(hl)
   46A0 C9            [10]  147 	ret
                            148 ;src/UI_Inventory.c:84: void ui_inventory_select_entry(){
                            149 ;	---------------------------------
                            150 ; Function ui_inventory_select_entry
                            151 ; ---------------------------------
   46A1                     152 _ui_inventory_select_entry::
                            153 ;src/UI_Inventory.c:85: ui_inventory_entrySelected=1;
   46A1 21 49 87      [10]  154 	ld	hl,#_ui_inventory_entrySelected + 0
   46A4 36 01         [10]  155 	ld	(hl), #0x01
   46A6 C9            [10]  156 	ret
                            157 ;src/UI_Inventory.c:88: void ui_inventory_unselect_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_inventory_unselect_entry
                            160 ; ---------------------------------
   46A7                     161 _ui_inventory_unselect_entry::
                            162 ;src/UI_Inventory.c:89: ui_inventory_entrySelected=0;
   46A7 21 49 87      [10]  163 	ld	hl,#_ui_inventory_entrySelected + 0
   46AA 36 00         [10]  164 	ld	(hl), #0x00
   46AC C9            [10]  165 	ret
                            166 ;src/UI_Inventory.c:92: void ui_inventory_render_button(u8 n){
                            167 ;	---------------------------------
                            168 ; Function ui_inventory_render_button
                            169 ; ---------------------------------
   46AD                     170 _ui_inventory_render_button::
   46AD DD E5         [15]  171 	push	ix
   46AF DD 21 00 00   [14]  172 	ld	ix,#0
   46B3 DD 39         [15]  173 	add	ix,sp
   46B5 3B            [ 6]  174 	dec	sp
                            175 ;src/UI_Inventory.c:94: color = (n==ui_inventory_entryIndex)?((ui_inventory_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   46B6 DD 7E 04      [19]  176 	ld	a,4 (ix)
   46B9 FD 21 48 87   [14]  177 	ld	iy,#_ui_inventory_entryIndex
   46BD FD 96 00      [19]  178 	sub	a, 0 (iy)
   46C0 20 10         [12]  179 	jr	NZ,00103$
   46C2 3A 49 87      [13]  180 	ld	a,(#_ui_inventory_entrySelected + 0)
   46C5 B7            [ 4]  181 	or	a, a
   46C6 28 05         [12]  182 	jr	Z,00105$
   46C8 3A 2C 1C      [13]  183 	ld	a, (#(_g_colors + 0x0004) + 0)
   46CB 18 08         [12]  184 	jr	00104$
   46CD                     185 00105$:
   46CD 3A 2E 1C      [13]  186 	ld	a, (#(_g_colors + 0x0006) + 0)
   46D0 18 03         [12]  187 	jr	00104$
   46D2                     188 00103$:
   46D2 3A 2A 1C      [13]  189 	ld	a, (#(_g_colors + 0x0002) + 0)
   46D5                     190 00104$:
   46D5 DD 77 FF      [19]  191 	ld	-1 (ix),a
                            192 ;src/UI_Inventory.c:95: cpct_drawSolidBox(ui_inventory_entriesPosition[n],color, UI_INVENTORY_BUTTON_WIDTH, UI_INVENTORY_BUTTON_HEIGHT);
   46D8 DD 6E 04      [19]  193 	ld	l,4 (ix)
   46DB 26 00         [ 7]  194 	ld	h,#0x00
   46DD 29            [11]  195 	add	hl, hl
   46DE 4D            [ 4]  196 	ld	c, l
   46DF 44            [ 4]  197 	ld	b, h
   46E0 21 58 46      [10]  198 	ld	hl,#_ui_inventory_entriesPosition
   46E3 09            [11]  199 	add	hl,bc
   46E4 5E            [ 7]  200 	ld	e,(hl)
   46E5 23            [ 6]  201 	inc	hl
   46E6 56            [ 7]  202 	ld	d,(hl)
   46E7 C5            [11]  203 	push	bc
   46E8 21 0C 10      [10]  204 	ld	hl,#0x100C
   46EB E5            [11]  205 	push	hl
   46EC DD 7E FF      [19]  206 	ld	a,-1 (ix)
   46EF F5            [11]  207 	push	af
   46F0 33            [ 6]  208 	inc	sp
   46F1 D5            [11]  209 	push	de
   46F2 CD 2F 85      [17]  210 	call	_cpct_drawSolidBox
   46F5 F1            [10]  211 	pop	af
   46F6 F1            [10]  212 	pop	af
   46F7 33            [ 6]  213 	inc	sp
   46F8 C1            [10]  214 	pop	bc
                            215 ;src/UI_Inventory.c:96: print_transparent_text(ui_inventory_buttonText[n], ui_inventory_entriesTextPosition[n], 3);
   46F9 21 5E 46      [10]  216 	ld	hl,#_ui_inventory_entriesTextPosition
   46FC 09            [11]  217 	add	hl,bc
   46FD 5E            [ 7]  218 	ld	e,(hl)
   46FE 23            [ 6]  219 	inc	hl
   46FF 56            [ 7]  220 	ld	d,(hl)
   4700 21 64 46      [10]  221 	ld	hl,#_ui_inventory_buttonText
   4703 09            [11]  222 	add	hl,bc
   4704 4E            [ 7]  223 	ld	c,(hl)
   4705 23            [ 6]  224 	inc	hl
   4706 46            [ 7]  225 	ld	b,(hl)
   4707 3E 03         [ 7]  226 	ld	a,#0x03
   4709 F5            [11]  227 	push	af
   470A 33            [ 6]  228 	inc	sp
   470B D5            [11]  229 	push	de
   470C C5            [11]  230 	push	bc
   470D CD 14 41      [17]  231 	call	_print_transparent_text
   4710 F1            [10]  232 	pop	af
   4711 F1            [10]  233 	pop	af
   4712 33            [ 6]  234 	inc	sp
   4713 33            [ 6]  235 	inc	sp
   4714 DD E1         [14]  236 	pop	ix
   4716 C9            [10]  237 	ret
                            238 ;src/UI_Inventory.c:100: void ui_inventory_render_refresh(){
                            239 ;	---------------------------------
                            240 ; Function ui_inventory_render_refresh
                            241 ; ---------------------------------
   4717                     242 _ui_inventory_render_refresh::
                            243 ;src/UI_Inventory.c:102: ui_inventory_render_button(ui_inventory_entryIndex);
   4717 3A 48 87      [13]  244 	ld	a,(_ui_inventory_entryIndex)
   471A F5            [11]  245 	push	af
   471B 33            [ 6]  246 	inc	sp
   471C CD AD 46      [17]  247 	call	_ui_inventory_render_button
   471F 33            [ 6]  248 	inc	sp
                            249 ;src/UI_Inventory.c:103: ui_inventory_render_button(ui_inventory_lastEntry);
   4720 3A 47 87      [13]  250 	ld	a,(_ui_inventory_lastEntry)
   4723 F5            [11]  251 	push	af
   4724 33            [ 6]  252 	inc	sp
   4725 CD AD 46      [17]  253 	call	_ui_inventory_render_button
   4728 33            [ 6]  254 	inc	sp
                            255 ;src/UI_Inventory.c:105: ui_inventory_lastEntry=ui_inventory_entryIndex;
   4729 3A 48 87      [13]  256 	ld	a,(#_ui_inventory_entryIndex + 0)
   472C 32 47 87      [13]  257 	ld	(#_ui_inventory_lastEntry + 0),a
   472F C9            [10]  258 	ret
                            259 ;src/UI_Inventory.c:108: void ui_inventory_render_all(){
                            260 ;	---------------------------------
                            261 ; Function ui_inventory_render_all
                            262 ; ---------------------------------
   4730                     263 _ui_inventory_render_all::
                            264 ;src/UI_Inventory.c:111: print_transparent_text("POTION", UI_INVENTORY_BUTTON_POTIONS_LABEL_POSITION, 3);
   4730 3E 03         [ 7]  265 	ld	a,#0x03
   4732 F5            [11]  266 	push	af
   4733 33            [ 6]  267 	inc	sp
   4734 21 EA EA      [10]  268 	ld	hl,#0xEAEA
   4737 E5            [11]  269 	push	hl
   4738 21 6C 47      [10]  270 	ld	hl,#___str_2
   473B E5            [11]  271 	push	hl
   473C CD 14 41      [17]  272 	call	_print_transparent_text
   473F F1            [10]  273 	pop	af
   4740 F1            [10]  274 	pop	af
   4741 33            [ 6]  275 	inc	sp
                            276 ;src/UI_Inventory.c:112: print_transparent_text("SCROLL", UI_INVENTORY_BUTTON_SCROLLS_LABEL_POSITION, 3);
   4742 3E 03         [ 7]  277 	ld	a,#0x03
   4744 F5            [11]  278 	push	af
   4745 33            [ 6]  279 	inc	sp
   4746 21 DA CB      [10]  280 	ld	hl,#0xCBDA
   4749 E5            [11]  281 	push	hl
   474A 21 73 47      [10]  282 	ld	hl,#___str_3
   474D E5            [11]  283 	push	hl
   474E CD 14 41      [17]  284 	call	_print_transparent_text
   4751 F1            [10]  285 	pop	af
   4752 F1            [10]  286 	pop	af
   4753 33            [ 6]  287 	inc	sp
                            288 ;src/UI_Inventory.c:114: while(n){
   4754 06 03         [ 7]  289 	ld	b,#0x03
   4756                     290 00101$:
   4756 78            [ 4]  291 	ld	a,b
   4757 B7            [ 4]  292 	or	a, a
   4758 28 0B         [12]  293 	jr	Z,00103$
                            294 ;src/UI_Inventory.c:115: --n;
   475A 05            [ 4]  295 	dec	b
                            296 ;src/UI_Inventory.c:116: ui_inventory_render_button(n);
   475B C5            [11]  297 	push	bc
   475C C5            [11]  298 	push	bc
   475D 33            [ 6]  299 	inc	sp
   475E CD AD 46      [17]  300 	call	_ui_inventory_render_button
   4761 33            [ 6]  301 	inc	sp
   4762 C1            [10]  302 	pop	bc
   4763 18 F1         [12]  303 	jr	00101$
   4765                     304 00103$:
                            305 ;src/UI_Inventory.c:119: ui_inventory_lastEntry=ui_inventory_entryIndex;
   4765 3A 48 87      [13]  306 	ld	a,(#_ui_inventory_entryIndex + 0)
   4768 32 47 87      [13]  307 	ld	(#_ui_inventory_lastEntry + 0),a
   476B C9            [10]  308 	ret
   476C                     309 ___str_2:
   476C 50 4F 54 49 4F 4E   310 	.ascii "POTION"
   4772 00                  311 	.db 0x00
   4773                     312 ___str_3:
   4773 53 43 52 4F 4C 4C   313 	.ascii "SCROLL"
   4779 00                  314 	.db 0x00
                            315 	.area _CODE
                            316 	.area _INITIALIZER
                            317 	.area _CABS (ABS)
