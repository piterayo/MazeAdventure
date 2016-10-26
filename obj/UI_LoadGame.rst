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
   874A                      37 _ui_loadgame_lastEntry::
   874A                      38 	.ds 1
   874B                      39 _ui_loadgame_entryIndex::
   874B                      40 	.ds 1
   874C                      41 _ui_loadgame_entrySelected::
   874C                      42 	.ds 1
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
   477A                      71 _ui_loadgame_init::
                             72 ;src/UI_LoadGame.c:49: ui_loadgame_lastEntry=0;
   477A 21 4A 87      [10]   73 	ld	hl,#_ui_loadgame_lastEntry + 0
   477D 36 00         [10]   74 	ld	(hl), #0x00
                             75 ;src/UI_LoadGame.c:50: ui_loadgame_entryIndex=0;
   477F 21 4B 87      [10]   76 	ld	hl,#_ui_loadgame_entryIndex + 0
   4782 36 00         [10]   77 	ld	(hl), #0x00
                             78 ;src/UI_LoadGame.c:51: ui_loadgame_entrySelected=0;
   4784 21 4C 87      [10]   79 	ld	hl,#_ui_loadgame_entrySelected + 0
   4787 36 00         [10]   80 	ld	(hl), #0x00
   4789 C9            [10]   81 	ret
   478A                      82 _ui_loadgame_entriesPosition:
   478A D8 EB                83 	.dw #0xEBD8
   478C EA EB                84 	.dw #0xEBEA
   478E                      85 _ui_loadgame_entriesTextPosition:
   478E 2A D4                86 	.dw #0xD42A
   4790 3C D4                87 	.dw #0xD43C
   4792                      88 _ui_loadgame_buttonText:
   4792 96 47                89 	.dw __str_0
   4794 9B 47                90 	.dw __str_1
   4796                      91 __str_0:
   4796 4C 4F 41 44          92 	.ascii "LOAD"
   479A 00                   93 	.db 0x00
   479B                      94 __str_1:
   479B 45 58 49 54          95 	.ascii "EXIT"
   479F 00                   96 	.db 0x00
                             97 ;src/UI_LoadGame.c:55: u8 ui_loadgame_get_entry(){
                             98 ;	---------------------------------
                             99 ; Function ui_loadgame_get_entry
                            100 ; ---------------------------------
   47A0                     101 _ui_loadgame_get_entry::
                            102 ;src/UI_LoadGame.c:56: return ui_loadgame_entryIndex;
   47A0 FD 21 4B 87   [14]  103 	ld	iy,#_ui_loadgame_entryIndex
   47A4 FD 6E 00      [19]  104 	ld	l,0 (iy)
   47A7 C9            [10]  105 	ret
                            106 ;src/UI_LoadGame.c:59: u8 ui_loadgame_is_selected(){
                            107 ;	---------------------------------
                            108 ; Function ui_loadgame_is_selected
                            109 ; ---------------------------------
   47A8                     110 _ui_loadgame_is_selected::
                            111 ;src/UI_LoadGame.c:60: return ui_loadgame_entrySelected;
   47A8 FD 21 4C 87   [14]  112 	ld	iy,#_ui_loadgame_entrySelected
   47AC FD 6E 00      [19]  113 	ld	l,0 (iy)
   47AF C9            [10]  114 	ret
                            115 ;src/UI_LoadGame.c:63: void ui_loadgame_next_entry(){
                            116 ;	---------------------------------
                            117 ; Function ui_loadgame_next_entry
                            118 ; ---------------------------------
   47B0                     119 _ui_loadgame_next_entry::
                            120 ;src/UI_LoadGame.c:64: if(ui_loadgame_entryIndex<(UI_LOADGAME_ENTRIES-1)){
   47B0 3A 4B 87      [13]  121 	ld	a,(#_ui_loadgame_entryIndex + 0)
   47B3 EE 80         [ 7]  122 	xor	a, #0x80
   47B5 D6 81         [ 7]  123 	sub	a, #0x81
   47B7 D0            [11]  124 	ret	NC
                            125 ;src/UI_LoadGame.c:65: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
   47B8 3A 4B 87      [13]  126 	ld	a,(#_ui_loadgame_entryIndex + 0)
   47BB 21 4A 87      [10]  127 	ld	hl,#_ui_loadgame_lastEntry + 0
   47BE 77            [ 7]  128 	ld	(hl), a
                            129 ;src/UI_LoadGame.c:66: ++ui_loadgame_entryIndex;
   47BF 21 4B 87      [10]  130 	ld	hl, #_ui_loadgame_entryIndex+0
   47C2 34            [11]  131 	inc	(hl)
   47C3 C9            [10]  132 	ret
                            133 ;src/UI_LoadGame.c:70: void ui_loadgame_previous_entry(){
                            134 ;	---------------------------------
                            135 ; Function ui_loadgame_previous_entry
                            136 ; ---------------------------------
   47C4                     137 _ui_loadgame_previous_entry::
                            138 ;src/UI_LoadGame.c:71: if(ui_loadgame_entryIndex>0){
   47C4 3A 4B 87      [13]  139 	ld	a,(#_ui_loadgame_entryIndex + 0)
   47C7 B7            [ 4]  140 	or	a, a
   47C8 C8            [11]  141 	ret	Z
                            142 ;src/UI_LoadGame.c:72: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
   47C9 3A 4B 87      [13]  143 	ld	a,(#_ui_loadgame_entryIndex + 0)
   47CC 21 4A 87      [10]  144 	ld	hl,#_ui_loadgame_lastEntry + 0
   47CF 77            [ 7]  145 	ld	(hl), a
                            146 ;src/UI_LoadGame.c:73: --ui_loadgame_entryIndex;
   47D0 21 4B 87      [10]  147 	ld	hl, #_ui_loadgame_entryIndex+0
   47D3 35            [11]  148 	dec	(hl)
   47D4 C9            [10]  149 	ret
                            150 ;src/UI_LoadGame.c:78: void ui_loadgame_select_entry(){
                            151 ;	---------------------------------
                            152 ; Function ui_loadgame_select_entry
                            153 ; ---------------------------------
   47D5                     154 _ui_loadgame_select_entry::
                            155 ;src/UI_LoadGame.c:79: ui_loadgame_entrySelected=1;
   47D5 21 4C 87      [10]  156 	ld	hl,#_ui_loadgame_entrySelected + 0
   47D8 36 01         [10]  157 	ld	(hl), #0x01
   47DA C9            [10]  158 	ret
                            159 ;src/UI_LoadGame.c:82: void ui_loadgame_unselect_entry(){
                            160 ;	---------------------------------
                            161 ; Function ui_loadgame_unselect_entry
                            162 ; ---------------------------------
   47DB                     163 _ui_loadgame_unselect_entry::
                            164 ;src/UI_LoadGame.c:83: ui_loadgame_entrySelected=0;
   47DB 21 4C 87      [10]  165 	ld	hl,#_ui_loadgame_entrySelected + 0
   47DE 36 00         [10]  166 	ld	(hl), #0x00
   47E0 C9            [10]  167 	ret
                            168 ;src/UI_LoadGame.c:86: void ui_loadgame_render_button(u8 n){
                            169 ;	---------------------------------
                            170 ; Function ui_loadgame_render_button
                            171 ; ---------------------------------
   47E1                     172 _ui_loadgame_render_button::
   47E1 DD E5         [15]  173 	push	ix
   47E3 DD 21 00 00   [14]  174 	ld	ix,#0
   47E7 DD 39         [15]  175 	add	ix,sp
   47E9 3B            [ 6]  176 	dec	sp
                            177 ;src/UI_LoadGame.c:88: color = (n==ui_loadgame_entryIndex)?((ui_loadgame_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   47EA DD 7E 04      [19]  178 	ld	a,4 (ix)
   47ED FD 21 4B 87   [14]  179 	ld	iy,#_ui_loadgame_entryIndex
   47F1 FD 96 00      [19]  180 	sub	a, 0 (iy)
   47F4 20 10         [12]  181 	jr	NZ,00103$
   47F6 3A 4C 87      [13]  182 	ld	a,(#_ui_loadgame_entrySelected + 0)
   47F9 B7            [ 4]  183 	or	a, a
   47FA 28 05         [12]  184 	jr	Z,00105$
   47FC 3A 2C 1C      [13]  185 	ld	a, (#(_g_colors + 0x0004) + 0)
   47FF 18 08         [12]  186 	jr	00104$
   4801                     187 00105$:
   4801 3A 2E 1C      [13]  188 	ld	a, (#(_g_colors + 0x0006) + 0)
   4804 18 03         [12]  189 	jr	00104$
   4806                     190 00103$:
   4806 3A 2A 1C      [13]  191 	ld	a, (#(_g_colors + 0x0002) + 0)
   4809                     192 00104$:
   4809 DD 77 FF      [19]  193 	ld	-1 (ix),a
                            194 ;src/UI_LoadGame.c:89: cpct_drawSolidBox(ui_loadgame_entriesPosition[n],color, UI_LOADGAME_BUTTON_WIDTH, UI_LOADGAME_BUTTON_HEIGHT);
   480C DD 6E 04      [19]  195 	ld	l,4 (ix)
   480F 26 00         [ 7]  196 	ld	h,#0x00
   4811 29            [11]  197 	add	hl, hl
   4812 4D            [ 4]  198 	ld	c, l
   4813 44            [ 4]  199 	ld	b, h
   4814 21 8A 47      [10]  200 	ld	hl,#_ui_loadgame_entriesPosition
   4817 09            [11]  201 	add	hl,bc
   4818 5E            [ 7]  202 	ld	e,(hl)
   4819 23            [ 6]  203 	inc	hl
   481A 56            [ 7]  204 	ld	d,(hl)
   481B C5            [11]  205 	push	bc
   481C 21 0C 10      [10]  206 	ld	hl,#0x100C
   481F E5            [11]  207 	push	hl
   4820 DD 7E FF      [19]  208 	ld	a,-1 (ix)
   4823 F5            [11]  209 	push	af
   4824 33            [ 6]  210 	inc	sp
   4825 D5            [11]  211 	push	de
   4826 CD 2F 85      [17]  212 	call	_cpct_drawSolidBox
   4829 F1            [10]  213 	pop	af
   482A F1            [10]  214 	pop	af
   482B 33            [ 6]  215 	inc	sp
   482C C1            [10]  216 	pop	bc
                            217 ;src/UI_LoadGame.c:90: print_transparent_text(ui_loadgame_buttonText[n], ui_loadgame_entriesTextPosition[n], 3);
   482D 21 8E 47      [10]  218 	ld	hl,#_ui_loadgame_entriesTextPosition
   4830 09            [11]  219 	add	hl,bc
   4831 5E            [ 7]  220 	ld	e,(hl)
   4832 23            [ 6]  221 	inc	hl
   4833 56            [ 7]  222 	ld	d,(hl)
   4834 21 92 47      [10]  223 	ld	hl,#_ui_loadgame_buttonText
   4837 09            [11]  224 	add	hl,bc
   4838 4E            [ 7]  225 	ld	c,(hl)
   4839 23            [ 6]  226 	inc	hl
   483A 46            [ 7]  227 	ld	b,(hl)
   483B 3E 03         [ 7]  228 	ld	a,#0x03
   483D F5            [11]  229 	push	af
   483E 33            [ 6]  230 	inc	sp
   483F D5            [11]  231 	push	de
   4840 C5            [11]  232 	push	bc
   4841 CD 14 41      [17]  233 	call	_print_transparent_text
   4844 F1            [10]  234 	pop	af
   4845 F1            [10]  235 	pop	af
   4846 33            [ 6]  236 	inc	sp
   4847 33            [ 6]  237 	inc	sp
   4848 DD E1         [14]  238 	pop	ix
   484A C9            [10]  239 	ret
                            240 ;src/UI_LoadGame.c:94: void ui_loadgame_render_all(){
                            241 ;	---------------------------------
                            242 ; Function ui_loadgame_render_all
                            243 ; ---------------------------------
   484B                     244 _ui_loadgame_render_all::
                            245 ;src/UI_LoadGame.c:97: cpct_drawSolidBox(UI_LOADGAME_STRING_POSITION, g_colors[1], 36,6);
   484B 21 29 1C      [10]  246 	ld	hl, #(_g_colors + 0x0001) + 0
   484E 46            [ 7]  247 	ld	b,(hl)
   484F 21 24 06      [10]  248 	ld	hl,#0x0624
   4852 E5            [11]  249 	push	hl
   4853 C5            [11]  250 	push	bc
   4854 33            [ 6]  251 	inc	sp
   4855 21 86 DB      [10]  252 	ld	hl,#0xDB86
   4858 E5            [11]  253 	push	hl
   4859 CD 2F 85      [17]  254 	call	_cpct_drawSolidBox
   485C F1            [10]  255 	pop	af
   485D F1            [10]  256 	pop	af
   485E 33            [ 6]  257 	inc	sp
                            258 ;src/UI_LoadGame.c:98: print_text(ui_stringinput_get_string(),UI_LOADGAME_STRING_POSITION, 1,3);
   485F CD B9 3D      [17]  259 	call	_ui_stringinput_get_string
   4862 4D            [ 4]  260 	ld	c,l
   4863 44            [ 4]  261 	ld	b,h
   4864 21 01 03      [10]  262 	ld	hl,#0x0301
   4867 E5            [11]  263 	push	hl
   4868 21 86 DB      [10]  264 	ld	hl,#0xDB86
   486B E5            [11]  265 	push	hl
   486C C5            [11]  266 	push	bc
   486D CD 39 3F      [17]  267 	call	_print_text
   4870 21 06 00      [10]  268 	ld	hl,#6
   4873 39            [11]  269 	add	hl,sp
   4874 F9            [ 6]  270 	ld	sp,hl
                            271 ;src/UI_LoadGame.c:100: while(n){
   4875 06 02         [ 7]  272 	ld	b,#0x02
   4877                     273 00101$:
   4877 78            [ 4]  274 	ld	a,b
   4878 B7            [ 4]  275 	or	a, a
   4879 28 0B         [12]  276 	jr	Z,00103$
                            277 ;src/UI_LoadGame.c:101: --n;
   487B 05            [ 4]  278 	dec	b
                            279 ;src/UI_LoadGame.c:102: ui_loadgame_render_button(n);
   487C C5            [11]  280 	push	bc
   487D C5            [11]  281 	push	bc
   487E 33            [ 6]  282 	inc	sp
   487F CD E1 47      [17]  283 	call	_ui_loadgame_render_button
   4882 33            [ 6]  284 	inc	sp
   4883 C1            [10]  285 	pop	bc
   4884 18 F1         [12]  286 	jr	00101$
   4886                     287 00103$:
                            288 ;src/UI_LoadGame.c:105: ui_loadgame_lastEntry=ui_loadgame_entryIndex;
   4886 3A 4B 87      [13]  289 	ld	a,(#_ui_loadgame_entryIndex + 0)
   4889 32 4A 87      [13]  290 	ld	(#_ui_loadgame_lastEntry + 0),a
   488C C9            [10]  291 	ret
                            292 	.area _CODE
                            293 	.area _INITIALIZER
                            294 	.area _CABS (ABS)
