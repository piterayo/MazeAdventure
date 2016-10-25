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
   7DFE                      36 _ui_mainmenu_lastEntry::
   7DFE                      37 	.ds 1
   7DFF                      38 _ui_mainmenu_entryIndex::
   7DFF                      39 	.ds 1
   7E00                      40 _ui_mainmenu_entrySelected::
   7E00                      41 	.ds 1
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
                             66 ;src/UI_MainMenu.c:53: void ui_mainmenu_init(){
                             67 ;	---------------------------------
                             68 ; Function ui_mainmenu_init
                             69 ; ---------------------------------
   4819                      70 _ui_mainmenu_init::
                             71 ;src/UI_MainMenu.c:54: ui_mainmenu_lastEntry=0;
   4819 21 FE 7D      [10]   72 	ld	hl,#_ui_mainmenu_lastEntry + 0
   481C 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_MainMenu.c:55: ui_mainmenu_entryIndex=0;
   481E 21 FF 7D      [10]   75 	ld	hl,#_ui_mainmenu_entryIndex + 0
   4821 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_MainMenu.c:56: ui_mainmenu_entrySelected=0;
   4823 21 00 7E      [10]   78 	ld	hl,#_ui_mainmenu_entrySelected + 0
   4826 36 00         [10]   79 	ld	(hl), #0x00
   4828 C9            [10]   80 	ret
   4829                      81 _ui_mainmenu_entriesPosition:
   4829 1E E0                82 	.dw #0xE01E
   482B 0E C1                83 	.dw #0xC10E
   482D AE E1                84 	.dw #0xE1AE
   482F 9E C2                85 	.dw #0xC29E
   4831                      86 _ui_mainmenu_entriesTextPosition:
   4831 70 C8                87 	.dw #0xC870
   4833 0F E9                88 	.dw #0xE90F
   4835 01 CA                89 	.dw #0xCA01
   4837 A1 EA                90 	.dw #0xEAA1
   4839                      91 _ui_mainmenu_buttonText:
   4839 41 48                92 	.dw __str_0
   483B 4A 48                93 	.dw __str_1
   483D 54 48                94 	.dw __str_2
   483F 5C 48                95 	.dw __str_3
   4841                      96 __str_0:
   4841 4E 45 57 20 47 41    97 	.ascii "NEW GAME"
        4D 45
   4849 00                   98 	.db 0x00
   484A                      99 __str_1:
   484A 4C 4F 41 44 20 47   100 	.ascii "LOAD GAME"
        41 4D 45
   4853 00                  101 	.db 0x00
   4854                     102 __str_2:
   4854 4F 50 54 49 4F 4E   103 	.ascii "OPTIONS"
        53
   485B 00                  104 	.db 0x00
   485C                     105 __str_3:
   485C 43 52 45 44 49 54   106 	.ascii "CREDITS"
        53
   4863 00                  107 	.db 0x00
                            108 ;src/UI_MainMenu.c:59: void ui_mainmenu_next_entry(){
                            109 ;	---------------------------------
                            110 ; Function ui_mainmenu_next_entry
                            111 ; ---------------------------------
   4864                     112 _ui_mainmenu_next_entry::
                            113 ;src/UI_MainMenu.c:60: if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
                            114 ;src/UI_MainMenu.c:61: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   4864 3A FF 7D      [13]  115 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   4867 FE 03         [ 7]  116 	cp	a,#0x03
   4869 D0            [11]  117 	ret	NC
   486A 32 FE 7D      [13]  118 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            119 ;src/UI_MainMenu.c:62: ++ui_mainmenu_entryIndex;
   486D 21 FF 7D      [10]  120 	ld	hl, #_ui_mainmenu_entryIndex+0
   4870 34            [11]  121 	inc	(hl)
   4871 C9            [10]  122 	ret
                            123 ;src/UI_MainMenu.c:66: void ui_mainmenu_previous_entry(){
                            124 ;	---------------------------------
                            125 ; Function ui_mainmenu_previous_entry
                            126 ; ---------------------------------
   4872                     127 _ui_mainmenu_previous_entry::
                            128 ;src/UI_MainMenu.c:67: if(ui_mainmenu_entryIndex>0){
   4872 3A FF 7D      [13]  129 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   4875 B7            [ 4]  130 	or	a, a
   4876 C8            [11]  131 	ret	Z
                            132 ;src/UI_MainMenu.c:68: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   4877 3A FF 7D      [13]  133 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   487A 32 FE 7D      [13]  134 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            135 ;src/UI_MainMenu.c:69: --ui_mainmenu_entryIndex;
   487D 21 FF 7D      [10]  136 	ld	hl, #_ui_mainmenu_entryIndex+0
   4880 35            [11]  137 	dec	(hl)
   4881 C9            [10]  138 	ret
                            139 ;src/UI_MainMenu.c:73: void ui_mainmenu_unselect_entry(){
                            140 ;	---------------------------------
                            141 ; Function ui_mainmenu_unselect_entry
                            142 ; ---------------------------------
   4882                     143 _ui_mainmenu_unselect_entry::
                            144 ;src/UI_MainMenu.c:74: ui_mainmenu_entrySelected=0;
   4882 21 00 7E      [10]  145 	ld	hl,#_ui_mainmenu_entrySelected + 0
   4885 36 00         [10]  146 	ld	(hl), #0x00
   4887 C9            [10]  147 	ret
                            148 ;src/UI_MainMenu.c:77: void ui_mainmenu_select_entry(){
                            149 ;	---------------------------------
                            150 ; Function ui_mainmenu_select_entry
                            151 ; ---------------------------------
   4888                     152 _ui_mainmenu_select_entry::
                            153 ;src/UI_MainMenu.c:78: ui_mainmenu_entrySelected=1;
   4888 21 00 7E      [10]  154 	ld	hl,#_ui_mainmenu_entrySelected + 0
   488B 36 01         [10]  155 	ld	(hl), #0x01
   488D C9            [10]  156 	ret
                            157 ;src/UI_MainMenu.c:81: void ui_mainmenu_render_button(u8 n){
                            158 ;	---------------------------------
                            159 ; Function ui_mainmenu_render_button
                            160 ; ---------------------------------
   488E                     161 _ui_mainmenu_render_button::
   488E DD E5         [15]  162 	push	ix
   4890 DD 21 00 00   [14]  163 	ld	ix,#0
   4894 DD 39         [15]  164 	add	ix,sp
   4896 3B            [ 6]  165 	dec	sp
                            166 ;src/UI_MainMenu.c:83: color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4897 DD 7E 04      [19]  167 	ld	a,4 (ix)
   489A FD 21 FF 7D   [14]  168 	ld	iy,#_ui_mainmenu_entryIndex
   489E FD 96 00      [19]  169 	sub	a, 0 (iy)
   48A1 20 10         [12]  170 	jr	NZ,00103$
   48A3 3A 00 7E      [13]  171 	ld	a,(#_ui_mainmenu_entrySelected + 0)
   48A6 B7            [ 4]  172 	or	a, a
   48A7 28 05         [12]  173 	jr	Z,00105$
   48A9 3A 6A 1A      [13]  174 	ld	a, (#(_g_colors + 0x0004) + 0)
   48AC 18 08         [12]  175 	jr	00104$
   48AE                     176 00105$:
   48AE 3A 6C 1A      [13]  177 	ld	a, (#(_g_colors + 0x0006) + 0)
   48B1 18 03         [12]  178 	jr	00104$
   48B3                     179 00103$:
   48B3 3A 68 1A      [13]  180 	ld	a, (#(_g_colors + 0x0002) + 0)
   48B6                     181 00104$:
   48B6 DD 77 FF      [19]  182 	ld	-1 (ix),a
                            183 ;src/UI_MainMenu.c:84: cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, UI_MAINMENU_BUTTON_WIDTH, UI_MAINMENU_BUTTON_HEIGHT);
   48B9 DD 6E 04      [19]  184 	ld	l,4 (ix)
   48BC 26 00         [ 7]  185 	ld	h,#0x00
   48BE 29            [11]  186 	add	hl, hl
   48BF 4D            [ 4]  187 	ld	c, l
   48C0 44            [ 4]  188 	ld	b, h
   48C1 21 29 48      [10]  189 	ld	hl,#_ui_mainmenu_entriesPosition
   48C4 09            [11]  190 	add	hl,bc
   48C5 5E            [ 7]  191 	ld	e,(hl)
   48C6 23            [ 6]  192 	inc	hl
   48C7 56            [ 7]  193 	ld	d,(hl)
   48C8 C5            [11]  194 	push	bc
   48C9 21 14 10      [10]  195 	ld	hl,#0x1014
   48CC E5            [11]  196 	push	hl
   48CD DD 7E FF      [19]  197 	ld	a,-1 (ix)
   48D0 F5            [11]  198 	push	af
   48D1 33            [ 6]  199 	inc	sp
   48D2 D5            [11]  200 	push	de
   48D3 CD 92 7B      [17]  201 	call	_cpct_drawSolidBox
   48D6 F1            [10]  202 	pop	af
   48D7 F1            [10]  203 	pop	af
   48D8 33            [ 6]  204 	inc	sp
   48D9 C1            [10]  205 	pop	bc
                            206 ;src/UI_MainMenu.c:85: print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesTextPosition[n], 3);
   48DA 21 31 48      [10]  207 	ld	hl,#_ui_mainmenu_entriesTextPosition
   48DD 09            [11]  208 	add	hl,bc
   48DE 5E            [ 7]  209 	ld	e,(hl)
   48DF 23            [ 6]  210 	inc	hl
   48E0 56            [ 7]  211 	ld	d,(hl)
   48E1 21 39 48      [10]  212 	ld	hl,#_ui_mainmenu_buttonText
   48E4 09            [11]  213 	add	hl,bc
   48E5 4E            [ 7]  214 	ld	c,(hl)
   48E6 23            [ 6]  215 	inc	hl
   48E7 46            [ 7]  216 	ld	b,(hl)
   48E8 3E 03         [ 7]  217 	ld	a,#0x03
   48EA F5            [11]  218 	push	af
   48EB 33            [ 6]  219 	inc	sp
   48EC D5            [11]  220 	push	de
   48ED C5            [11]  221 	push	bc
   48EE CD A0 3F      [17]  222 	call	_print_transparent_text
   48F1 F1            [10]  223 	pop	af
   48F2 F1            [10]  224 	pop	af
   48F3 33            [ 6]  225 	inc	sp
   48F4 33            [ 6]  226 	inc	sp
   48F5 DD E1         [14]  227 	pop	ix
   48F7 C9            [10]  228 	ret
                            229 ;src/UI_MainMenu.c:88: void ui_mainmenu_render_refresh(){
                            230 ;	---------------------------------
                            231 ; Function ui_mainmenu_render_refresh
                            232 ; ---------------------------------
   48F8                     233 _ui_mainmenu_render_refresh::
                            234 ;src/UI_MainMenu.c:90: ui_mainmenu_render_button(ui_mainmenu_entryIndex);
   48F8 3A FF 7D      [13]  235 	ld	a,(_ui_mainmenu_entryIndex)
   48FB F5            [11]  236 	push	af
   48FC 33            [ 6]  237 	inc	sp
   48FD CD 8E 48      [17]  238 	call	_ui_mainmenu_render_button
   4900 33            [ 6]  239 	inc	sp
                            240 ;src/UI_MainMenu.c:91: ui_mainmenu_render_button(ui_mainmenu_lastEntry);
   4901 3A FE 7D      [13]  241 	ld	a,(_ui_mainmenu_lastEntry)
   4904 F5            [11]  242 	push	af
   4905 33            [ 6]  243 	inc	sp
   4906 CD 8E 48      [17]  244 	call	_ui_mainmenu_render_button
   4909 33            [ 6]  245 	inc	sp
                            246 ;src/UI_MainMenu.c:93: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   490A 3A FF 7D      [13]  247 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   490D 32 FE 7D      [13]  248 	ld	(#_ui_mainmenu_lastEntry + 0),a
   4910 C9            [10]  249 	ret
                            250 ;src/UI_MainMenu.c:97: void ui_mainmenu_render_all(){
                            251 ;	---------------------------------
                            252 ; Function ui_mainmenu_render_all
                            253 ; ---------------------------------
   4911                     254 _ui_mainmenu_render_all::
                            255 ;src/UI_MainMenu.c:101: while(n){
   4911 06 04         [ 7]  256 	ld	b,#0x04
   4913                     257 00101$:
   4913 78            [ 4]  258 	ld	a,b
   4914 B7            [ 4]  259 	or	a, a
   4915 28 0B         [12]  260 	jr	Z,00103$
                            261 ;src/UI_MainMenu.c:102: --n;
   4917 05            [ 4]  262 	dec	b
                            263 ;src/UI_MainMenu.c:103: ui_mainmenu_render_button(n);
   4918 C5            [11]  264 	push	bc
   4919 C5            [11]  265 	push	bc
   491A 33            [ 6]  266 	inc	sp
   491B CD 8E 48      [17]  267 	call	_ui_mainmenu_render_button
   491E 33            [ 6]  268 	inc	sp
   491F C1            [10]  269 	pop	bc
   4920 18 F1         [12]  270 	jr	00101$
   4922                     271 00103$:
                            272 ;src/UI_MainMenu.c:106: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   4922 3A FF 7D      [13]  273 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   4925 32 FE 7D      [13]  274 	ld	(#_ui_mainmenu_lastEntry + 0),a
   4928 C9            [10]  275 	ret
                            276 ;src/UI_MainMenu.c:109: u8 ui_mainmenu_get_entry(){
                            277 ;	---------------------------------
                            278 ; Function ui_mainmenu_get_entry
                            279 ; ---------------------------------
   4929                     280 _ui_mainmenu_get_entry::
                            281 ;src/UI_MainMenu.c:110: return ui_mainmenu_entryIndex;
   4929 FD 21 FF 7D   [14]  282 	ld	iy,#_ui_mainmenu_entryIndex
   492D FD 6E 00      [19]  283 	ld	l,0 (iy)
   4930 C9            [10]  284 	ret
                            285 ;src/UI_MainMenu.c:113: u8 ui_mainmenu_is_selected(){
                            286 ;	---------------------------------
                            287 ; Function ui_mainmenu_is_selected
                            288 ; ---------------------------------
   4931                     289 _ui_mainmenu_is_selected::
                            290 ;src/UI_MainMenu.c:114: return ui_mainmenu_entrySelected;
   4931 FD 21 00 7E   [14]  291 	ld	iy,#_ui_mainmenu_entrySelected
   4935 FD 6E 00      [19]  292 	ld	l,0 (iy)
   4938 C9            [10]  293 	ret
                            294 	.area _CODE
                            295 	.area _INITIALIZER
                            296 	.area _CABS (ABS)
