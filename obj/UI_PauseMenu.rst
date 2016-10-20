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
   4FAD                      40 _ui_pausemenu_lastEntry::
   4FAD                      41 	.ds 1
   4FAE                      42 _ui_pausemenu_entryIndex::
   4FAE                      43 	.ds 1
   4FAF                      44 _ui_pausemenu_entrySelected::
   4FAF                      45 	.ds 1
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
   2824                      70 _ui_pausemenu_init::
                             71 ;src/UI_PauseMenu.c:58: ui_pausemenu_lastEntry=0;
   2824 21 AD 4F      [10]   72 	ld	hl,#_ui_pausemenu_lastEntry + 0
   2827 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_PauseMenu.c:59: ui_pausemenu_entryIndex=0;
   2829 21 AE 4F      [10]   75 	ld	hl,#_ui_pausemenu_entryIndex + 0
   282C 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_PauseMenu.c:60: ui_pausemenu_entrySelected=0;
   282E 21 AF 4F      [10]   78 	ld	hl,#_ui_pausemenu_entrySelected + 0
   2831 36 00         [10]   79 	ld	(hl), #0x00
   2833 C9            [10]   80 	ret
   2834                      81 _ui_pausemenu_entriesPosition:
   2834 AA C1                82 	.dw #0xC1AA
   2836 EA C2                83 	.dw #0xC2EA
   2838 2A C4                84 	.dw #0xC42A
   283A 6A C5                85 	.dw #0xC56A
   283C                      86 _ui_pausemenu_entriesTextPosition:
   283C 00 CA                87 	.dw #0xCA00
   283E 42 CB                88 	.dw #0xCB42
   2840 7B CC                89 	.dw #0xCC7B
   2842 C4 CD                90 	.dw #0xCDC4
   2844                      91 _ui_pausemenu_buttonText:
   2844 4C 28                92 	.dw __str_0
   2846 55 28                93 	.dw __str_1
   2848 5D 28                94 	.dw __str_2
   284A 6B 28                95 	.dw __str_3
   284C                      96 __str_0:
   284C 43 4F 4E 54 49 4E    97 	.ascii "CONTINUE"
        55 45
   2854 00                   98 	.db 0x00
   2855                      99 __str_1:
   2855 4F 50 54 49 4F 4E   100 	.ascii "OPTIONS"
        53
   285C 00                  101 	.db 0x00
   285D                     102 __str_2:
   285D 53 41 56 45 20 41   103 	.ascii "SAVE AND EXIT"
        4E 44 20 45 58 49
        54
   286A 00                  104 	.db 0x00
   286B                     105 __str_3:
   286B 45 58 49 54         106 	.ascii "EXIT"
   286F 00                  107 	.db 0x00
                            108 ;src/UI_PauseMenu.c:63: u8 ui_pausemenu_get_entry(){
                            109 ;	---------------------------------
                            110 ; Function ui_pausemenu_get_entry
                            111 ; ---------------------------------
   2870                     112 _ui_pausemenu_get_entry::
                            113 ;src/UI_PauseMenu.c:64: return ui_pausemenu_entryIndex;
   2870 FD 21 AE 4F   [14]  114 	ld	iy,#_ui_pausemenu_entryIndex
   2874 FD 6E 00      [19]  115 	ld	l,0 (iy)
   2877 C9            [10]  116 	ret
                            117 ;src/UI_PauseMenu.c:67: u8 ui_pausemenu_is_selected(){
                            118 ;	---------------------------------
                            119 ; Function ui_pausemenu_is_selected
                            120 ; ---------------------------------
   2878                     121 _ui_pausemenu_is_selected::
                            122 ;src/UI_PauseMenu.c:68: return ui_pausemenu_entrySelected;
   2878 FD 21 AF 4F   [14]  123 	ld	iy,#_ui_pausemenu_entrySelected
   287C FD 6E 00      [19]  124 	ld	l,0 (iy)
   287F C9            [10]  125 	ret
                            126 ;src/UI_PauseMenu.c:71: void ui_pausemenu_next_entry(){
                            127 ;	---------------------------------
                            128 ; Function ui_pausemenu_next_entry
                            129 ; ---------------------------------
   2880                     130 _ui_pausemenu_next_entry::
                            131 ;src/UI_PauseMenu.c:72: if(ui_pausemenu_entryIndex<(UI_PAUSEMENU_ENTRIES-1)){
                            132 ;src/UI_PauseMenu.c:73: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   2880 3A AE 4F      [13]  133 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2883 FE 03         [ 7]  134 	cp	a,#0x03
   2885 D0            [11]  135 	ret	NC
   2886 32 AD 4F      [13]  136 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            137 ;src/UI_PauseMenu.c:74: ++ui_pausemenu_entryIndex;
   2889 21 AE 4F      [10]  138 	ld	hl, #_ui_pausemenu_entryIndex+0
   288C 34            [11]  139 	inc	(hl)
   288D C9            [10]  140 	ret
                            141 ;src/UI_PauseMenu.c:78: void ui_pausemenu_previous_entry(){
                            142 ;	---------------------------------
                            143 ; Function ui_pausemenu_previous_entry
                            144 ; ---------------------------------
   288E                     145 _ui_pausemenu_previous_entry::
                            146 ;src/UI_PauseMenu.c:79: if(ui_pausemenu_entryIndex>0){
   288E 3A AE 4F      [13]  147 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2891 B7            [ 4]  148 	or	a, a
   2892 C8            [11]  149 	ret	Z
                            150 ;src/UI_PauseMenu.c:80: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   2893 3A AE 4F      [13]  151 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2896 32 AD 4F      [13]  152 	ld	(#_ui_pausemenu_lastEntry + 0),a
                            153 ;src/UI_PauseMenu.c:81: --ui_pausemenu_entryIndex;
   2899 21 AE 4F      [10]  154 	ld	hl, #_ui_pausemenu_entryIndex+0
   289C 35            [11]  155 	dec	(hl)
   289D C9            [10]  156 	ret
                            157 ;src/UI_PauseMenu.c:85: void ui_pausemenu_select_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_pausemenu_select_entry
                            160 ; ---------------------------------
   289E                     161 _ui_pausemenu_select_entry::
                            162 ;src/UI_PauseMenu.c:86: ui_pausemenu_entrySelected=1;
   289E 21 AF 4F      [10]  163 	ld	hl,#_ui_pausemenu_entrySelected + 0
   28A1 36 01         [10]  164 	ld	(hl), #0x01
   28A3 C9            [10]  165 	ret
                            166 ;src/UI_PauseMenu.c:89: void ui_pausemenu_unselect_entry(){
                            167 ;	---------------------------------
                            168 ; Function ui_pausemenu_unselect_entry
                            169 ; ---------------------------------
   28A4                     170 _ui_pausemenu_unselect_entry::
                            171 ;src/UI_PauseMenu.c:90: ui_pausemenu_entrySelected=0;
   28A4 21 AF 4F      [10]  172 	ld	hl,#_ui_pausemenu_entrySelected + 0
   28A7 36 00         [10]  173 	ld	(hl), #0x00
   28A9 C9            [10]  174 	ret
                            175 ;src/UI_PauseMenu.c:93: void ui_pausemenu_render_button(u8 n){
                            176 ;	---------------------------------
                            177 ; Function ui_pausemenu_render_button
                            178 ; ---------------------------------
   28AA                     179 _ui_pausemenu_render_button::
   28AA DD E5         [15]  180 	push	ix
   28AC DD 21 00 00   [14]  181 	ld	ix,#0
   28B0 DD 39         [15]  182 	add	ix,sp
   28B2 3B            [ 6]  183 	dec	sp
                            184 ;src/UI_PauseMenu.c:95: color = (n==ui_pausemenu_entryIndex)?((ui_pausemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   28B3 DD 7E 04      [19]  185 	ld	a,4 (ix)
   28B6 FD 21 AE 4F   [14]  186 	ld	iy,#_ui_pausemenu_entryIndex
   28BA FD 96 00      [19]  187 	sub	a, 0 (iy)
   28BD 20 10         [12]  188 	jr	NZ,00103$
   28BF 3A AF 4F      [13]  189 	ld	a,(#_ui_pausemenu_entrySelected + 0)
   28C2 B7            [ 4]  190 	or	a, a
   28C3 28 05         [12]  191 	jr	Z,00105$
   28C5 3A A7 0A      [13]  192 	ld	a, (#(_g_colors + 0x0004) + 0)
   28C8 18 08         [12]  193 	jr	00104$
   28CA                     194 00105$:
   28CA 3A A9 0A      [13]  195 	ld	a, (#(_g_colors + 0x0006) + 0)
   28CD 18 03         [12]  196 	jr	00104$
   28CF                     197 00103$:
   28CF 3A A5 0A      [13]  198 	ld	a, (#(_g_colors + 0x0002) + 0)
   28D2                     199 00104$:
   28D2 DD 77 FF      [19]  200 	ld	-1 (ix),a
                            201 ;src/UI_PauseMenu.c:96: cpct_drawSolidBox(ui_pausemenu_entriesPosition[n],color, UI_PAUSEMENU_BUTTON_WIDTH, UI_PAUSEMENU_BUTTON_HEIGHT);
   28D5 DD 6E 04      [19]  202 	ld	l,4 (ix)
   28D8 26 00         [ 7]  203 	ld	h,#0x00
   28DA 29            [11]  204 	add	hl, hl
   28DB 4D            [ 4]  205 	ld	c, l
   28DC 44            [ 4]  206 	ld	b, h
   28DD 21 34 28      [10]  207 	ld	hl,#_ui_pausemenu_entriesPosition
   28E0 09            [11]  208 	add	hl,bc
   28E1 5E            [ 7]  209 	ld	e,(hl)
   28E2 23            [ 6]  210 	inc	hl
   28E3 56            [ 7]  211 	ld	d,(hl)
   28E4 C5            [11]  212 	push	bc
   28E5 21 1C 18      [10]  213 	ld	hl,#0x181C
   28E8 E5            [11]  214 	push	hl
   28E9 DD 7E FF      [19]  215 	ld	a,-1 (ix)
   28EC F5            [11]  216 	push	af
   28ED 33            [ 6]  217 	inc	sp
   28EE D5            [11]  218 	push	de
   28EF CD C0 4D      [17]  219 	call	_cpct_drawSolidBox
   28F2 F1            [10]  220 	pop	af
   28F3 F1            [10]  221 	pop	af
   28F4 33            [ 6]  222 	inc	sp
   28F5 C1            [10]  223 	pop	bc
                            224 ;src/UI_PauseMenu.c:97: print_transparent_text(ui_pausemenu_buttonText[n], ui_pausemenu_entriesTextPosition[n], 3);
   28F6 21 3C 28      [10]  225 	ld	hl,#_ui_pausemenu_entriesTextPosition
   28F9 09            [11]  226 	add	hl,bc
   28FA 5E            [ 7]  227 	ld	e,(hl)
   28FB 23            [ 6]  228 	inc	hl
   28FC 56            [ 7]  229 	ld	d,(hl)
   28FD 21 44 28      [10]  230 	ld	hl,#_ui_pausemenu_buttonText
   2900 09            [11]  231 	add	hl,bc
   2901 4E            [ 7]  232 	ld	c,(hl)
   2902 23            [ 6]  233 	inc	hl
   2903 46            [ 7]  234 	ld	b,(hl)
   2904 3E 03         [ 7]  235 	ld	a,#0x03
   2906 F5            [11]  236 	push	af
   2907 33            [ 6]  237 	inc	sp
   2908 D5            [11]  238 	push	de
   2909 C5            [11]  239 	push	bc
   290A CD 70 22      [17]  240 	call	_print_transparent_text
   290D F1            [10]  241 	pop	af
   290E F1            [10]  242 	pop	af
   290F 33            [ 6]  243 	inc	sp
   2910 33            [ 6]  244 	inc	sp
   2911 DD E1         [14]  245 	pop	ix
   2913 C9            [10]  246 	ret
                            247 ;src/UI_PauseMenu.c:100: void ui_pausemenu_render_refresh(){
                            248 ;	---------------------------------
                            249 ; Function ui_pausemenu_render_refresh
                            250 ; ---------------------------------
   2914                     251 _ui_pausemenu_render_refresh::
                            252 ;src/UI_PauseMenu.c:102: ui_pausemenu_render_button(ui_pausemenu_entryIndex);
   2914 3A AE 4F      [13]  253 	ld	a,(_ui_pausemenu_entryIndex)
   2917 F5            [11]  254 	push	af
   2918 33            [ 6]  255 	inc	sp
   2919 CD AA 28      [17]  256 	call	_ui_pausemenu_render_button
   291C 33            [ 6]  257 	inc	sp
                            258 ;src/UI_PauseMenu.c:103: ui_pausemenu_render_button(ui_pausemenu_lastEntry);
   291D 3A AD 4F      [13]  259 	ld	a,(_ui_pausemenu_lastEntry)
   2920 F5            [11]  260 	push	af
   2921 33            [ 6]  261 	inc	sp
   2922 CD AA 28      [17]  262 	call	_ui_pausemenu_render_button
   2925 33            [ 6]  263 	inc	sp
                            264 ;src/UI_PauseMenu.c:105: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   2926 3A AE 4F      [13]  265 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2929 32 AD 4F      [13]  266 	ld	(#_ui_pausemenu_lastEntry + 0),a
   292C C9            [10]  267 	ret
                            268 ;src/UI_PauseMenu.c:108: void ui_pausemenu_render_all(){
                            269 ;	---------------------------------
                            270 ; Function ui_pausemenu_render_all
                            271 ; ---------------------------------
   292D                     272 _ui_pausemenu_render_all::
                            273 ;src/UI_PauseMenu.c:112: while(n){
   292D 06 04         [ 7]  274 	ld	b,#0x04
   292F                     275 00101$:
   292F 78            [ 4]  276 	ld	a,b
   2930 B7            [ 4]  277 	or	a, a
   2931 28 0B         [12]  278 	jr	Z,00103$
                            279 ;src/UI_PauseMenu.c:113: --n;
   2933 05            [ 4]  280 	dec	b
                            281 ;src/UI_PauseMenu.c:114: ui_pausemenu_render_button(n);
   2934 C5            [11]  282 	push	bc
   2935 C5            [11]  283 	push	bc
   2936 33            [ 6]  284 	inc	sp
   2937 CD AA 28      [17]  285 	call	_ui_pausemenu_render_button
   293A 33            [ 6]  286 	inc	sp
   293B C1            [10]  287 	pop	bc
   293C 18 F1         [12]  288 	jr	00101$
   293E                     289 00103$:
                            290 ;src/UI_PauseMenu.c:117: ui_pausemenu_lastEntry=ui_pausemenu_entryIndex;
   293E 3A AE 4F      [13]  291 	ld	a,(#_ui_pausemenu_entryIndex + 0)
   2941 32 AD 4F      [13]  292 	ld	(#_ui_pausemenu_lastEntry + 0),a
   2944 C9            [10]  293 	ret
                            294 	.area _CODE
                            295 	.area _INITIALIZER
   4FB9                     296 __xinit__ui_pausemenu_lastEntry:
   4FB9 00                  297 	.db #0x00	; 0
   4FBA                     298 __xinit__ui_pausemenu_entryIndex:
   4FBA 00                  299 	.db #0x00	; 0
   4FBB                     300 __xinit__ui_pausemenu_entrySelected:
   4FBB 00                  301 	.db #0x00	; 0
                            302 	.area _CABS (ABS)
