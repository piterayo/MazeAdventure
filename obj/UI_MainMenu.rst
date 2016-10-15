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
                             36 ;--------------------------------------------------------
                             37 ; ram data
                             38 ;--------------------------------------------------------
                             39 	.area _INITIALIZED
   4AB0                      40 _ui_mainmenu_lastEntry::
   4AB0                      41 	.ds 1
   4AB1                      42 _ui_mainmenu_entryIndex::
   4AB1                      43 	.ds 1
   4AB2                      44 _ui_mainmenu_entrySelected::
   4AB2                      45 	.ds 1
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
                             66 ;src/UI_MainMenu.c:55: void ui_mainmenu_init(){
                             67 ;	---------------------------------
                             68 ; Function ui_mainmenu_init
                             69 ; ---------------------------------
   2840                      70 _ui_mainmenu_init::
                             71 ;src/UI_MainMenu.c:56: ui_mainmenu_lastEntry=0;
   2840 21 B0 4A      [10]   72 	ld	hl,#_ui_mainmenu_lastEntry + 0
   2843 36 00         [10]   73 	ld	(hl), #0x00
                             74 ;src/UI_MainMenu.c:57: ui_mainmenu_entryIndex=0;
   2845 21 B1 4A      [10]   75 	ld	hl,#_ui_mainmenu_entryIndex + 0
   2848 36 00         [10]   76 	ld	(hl), #0x00
                             77 ;src/UI_MainMenu.c:58: ui_mainmenu_entrySelected=0;
   284A 21 B2 4A      [10]   78 	ld	hl,#_ui_mainmenu_entrySelected + 0
   284D 36 00         [10]   79 	ld	(hl), #0x00
   284F C9            [10]   80 	ret
   2850                      81 _ui_mainmenu_entriesPosition:
   2850 2E C4                82 	.dw #0xC42E
   2852 CE E4                83 	.dw #0xE4CE
   2854 BE C5                84 	.dw #0xC5BE
   2856 5E E6                85 	.dw #0xE65E
   2858 4E C7                86 	.dw #0xC74E
   285A                      87 _ui_mainmenu_entriesTextPosition:
   285A 30 EC                88 	.dw #0xEC30
   285C 1F CD                89 	.dw #0xCD1F
   285E C1 ED                90 	.dw #0xEDC1
   2860 B1 CE                91 	.dw #0xCEB1
   2862 54 EF                92 	.dw #0xEF54
   2864                      93 _ui_mainmenu_buttonText:
   2864 6E 28                94 	.dw __str_0
   2866 77 28                95 	.dw __str_1
   2868 81 28                96 	.dw __str_2
   286A 89 28                97 	.dw __str_3
   286C 91 28                98 	.dw __str_4
   286E                      99 __str_0:
   286E 4E 45 57 20 47 41   100 	.ascii "NEW GAME"
        4D 45
   2876 00                  101 	.db 0x00
   2877                     102 __str_1:
   2877 4C 4F 41 44 20 47   103 	.ascii "LOAD GAME"
        41 4D 45
   2880 00                  104 	.db 0x00
   2881                     105 __str_2:
   2881 4F 50 54 49 4F 4E   106 	.ascii "OPTIONS"
        53
   2888 00                  107 	.db 0x00
   2889                     108 __str_3:
   2889 43 52 45 44 49 54   109 	.ascii "CREDITS"
        53
   2890 00                  110 	.db 0x00
   2891                     111 __str_4:
   2891 45 58 49 54         112 	.ascii "EXIT"
   2895 00                  113 	.db 0x00
                            114 ;src/UI_MainMenu.c:61: void ui_mainmenu_next_entry(){
                            115 ;	---------------------------------
                            116 ; Function ui_mainmenu_next_entry
                            117 ; ---------------------------------
   2896                     118 _ui_mainmenu_next_entry::
                            119 ;src/UI_MainMenu.c:62: if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
                            120 ;src/UI_MainMenu.c:63: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   2896 3A B1 4A      [13]  121 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2899 FE 04         [ 7]  122 	cp	a,#0x04
   289B D0            [11]  123 	ret	NC
   289C 32 B0 4A      [13]  124 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            125 ;src/UI_MainMenu.c:64: ++ui_mainmenu_entryIndex;
   289F 21 B1 4A      [10]  126 	ld	hl, #_ui_mainmenu_entryIndex+0
   28A2 34            [11]  127 	inc	(hl)
   28A3 C9            [10]  128 	ret
                            129 ;src/UI_MainMenu.c:68: void ui_mainmenu_previous_entry(){
                            130 ;	---------------------------------
                            131 ; Function ui_mainmenu_previous_entry
                            132 ; ---------------------------------
   28A4                     133 _ui_mainmenu_previous_entry::
                            134 ;src/UI_MainMenu.c:69: if(ui_mainmenu_entryIndex>0){
   28A4 3A B1 4A      [13]  135 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   28A7 B7            [ 4]  136 	or	a, a
   28A8 C8            [11]  137 	ret	Z
                            138 ;src/UI_MainMenu.c:70: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   28A9 3A B1 4A      [13]  139 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   28AC 32 B0 4A      [13]  140 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            141 ;src/UI_MainMenu.c:71: --ui_mainmenu_entryIndex;
   28AF 21 B1 4A      [10]  142 	ld	hl, #_ui_mainmenu_entryIndex+0
   28B2 35            [11]  143 	dec	(hl)
   28B3 C9            [10]  144 	ret
                            145 ;src/UI_MainMenu.c:75: void ui_mainmenu_unselect_entry(){
                            146 ;	---------------------------------
                            147 ; Function ui_mainmenu_unselect_entry
                            148 ; ---------------------------------
   28B4                     149 _ui_mainmenu_unselect_entry::
                            150 ;src/UI_MainMenu.c:76: ui_mainmenu_entrySelected=0;
   28B4 21 B2 4A      [10]  151 	ld	hl,#_ui_mainmenu_entrySelected + 0
   28B7 36 00         [10]  152 	ld	(hl), #0x00
   28B9 C9            [10]  153 	ret
                            154 ;src/UI_MainMenu.c:79: void ui_mainmenu_select_entry(){
                            155 ;	---------------------------------
                            156 ; Function ui_mainmenu_select_entry
                            157 ; ---------------------------------
   28BA                     158 _ui_mainmenu_select_entry::
                            159 ;src/UI_MainMenu.c:80: ui_mainmenu_entrySelected=1;
   28BA 21 B2 4A      [10]  160 	ld	hl,#_ui_mainmenu_entrySelected + 0
   28BD 36 01         [10]  161 	ld	(hl), #0x01
   28BF C9            [10]  162 	ret
                            163 ;src/UI_MainMenu.c:83: void ui_mainmenu_render_button(u8 n){
                            164 ;	---------------------------------
                            165 ; Function ui_mainmenu_render_button
                            166 ; ---------------------------------
   28C0                     167 _ui_mainmenu_render_button::
   28C0 DD E5         [15]  168 	push	ix
   28C2 DD 21 00 00   [14]  169 	ld	ix,#0
   28C6 DD 39         [15]  170 	add	ix,sp
                            171 ;src/UI_MainMenu.c:85: color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
   28C8 DD 7E 04      [19]  172 	ld	a,4 (ix)
   28CB FD 21 B1 4A   [14]  173 	ld	iy,#_ui_mainmenu_entryIndex
   28CF FD 96 00      [19]  174 	sub	a, 0 (iy)
   28D2 20 10         [12]  175 	jr	NZ,00103$
   28D4 3A B2 4A      [13]  176 	ld	a,(#_ui_mainmenu_entrySelected + 0)
   28D7 B7            [ 4]  177 	or	a, a
   28D8 28 05         [12]  178 	jr	Z,00105$
   28DA 3A A7 0A      [13]  179 	ld	a, (#(_g_colors + 0x0004) + 0)
   28DD 18 08         [12]  180 	jr	00104$
   28DF                     181 00105$:
   28DF 3A A8 0A      [13]  182 	ld	a, (#(_g_colors + 0x0005) + 0)
   28E2 18 03         [12]  183 	jr	00104$
   28E4                     184 00103$:
   28E4 3A A5 0A      [13]  185 	ld	a, (#(_g_colors + 0x0002) + 0)
   28E7                     186 00104$:
   28E7 47            [ 4]  187 	ld	b,a
                            188 ;src/UI_MainMenu.c:86: cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, UI_MAINMENU_BUTTON_WIDTH, UI_MAINMENU_BUTTON_HEIGHT);
   28E8 DD 6E 04      [19]  189 	ld	l,4 (ix)
   28EB 26 00         [ 7]  190 	ld	h,#0x00
   28ED 29            [11]  191 	add	hl, hl
   28EE EB            [ 4]  192 	ex	de,hl
   28EF 21 50 28      [10]  193 	ld	hl,#_ui_mainmenu_entriesPosition
   28F2 19            [11]  194 	add	hl,de
   28F3 7E            [ 7]  195 	ld	a, (hl)
   28F4 23            [ 6]  196 	inc	hl
   28F5 66            [ 7]  197 	ld	h,(hl)
   28F6 6F            [ 4]  198 	ld	l,a
   28F7 E5            [11]  199 	push	hl
   28F8 FD E1         [14]  200 	pop	iy
   28FA D5            [11]  201 	push	de
   28FB 21 14 10      [10]  202 	ld	hl,#0x1014
   28FE E5            [11]  203 	push	hl
   28FF C5            [11]  204 	push	bc
   2900 33            [ 6]  205 	inc	sp
   2901 FD E5         [15]  206 	push	iy
   2903 CD CB 48      [17]  207 	call	_cpct_drawSolidBox
   2906 F1            [10]  208 	pop	af
   2907 F1            [10]  209 	pop	af
   2908 33            [ 6]  210 	inc	sp
   2909 D1            [10]  211 	pop	de
                            212 ;src/UI_MainMenu.c:87: print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesTextPosition[n], 3);
   290A 21 5A 28      [10]  213 	ld	hl,#_ui_mainmenu_entriesTextPosition
   290D 19            [11]  214 	add	hl,de
   290E 4E            [ 7]  215 	ld	c,(hl)
   290F 23            [ 6]  216 	inc	hl
   2910 46            [ 7]  217 	ld	b,(hl)
   2911 21 64 28      [10]  218 	ld	hl,#_ui_mainmenu_buttonText
   2914 19            [11]  219 	add	hl,de
   2915 5E            [ 7]  220 	ld	e,(hl)
   2916 23            [ 6]  221 	inc	hl
   2917 56            [ 7]  222 	ld	d,(hl)
   2918 3E 03         [ 7]  223 	ld	a,#0x03
   291A F5            [11]  224 	push	af
   291B 33            [ 6]  225 	inc	sp
   291C C5            [11]  226 	push	bc
   291D D5            [11]  227 	push	de
   291E CD 67 22      [17]  228 	call	_print_transparent_text
   2921 F1            [10]  229 	pop	af
   2922 F1            [10]  230 	pop	af
   2923 33            [ 6]  231 	inc	sp
   2924 DD E1         [14]  232 	pop	ix
   2926 C9            [10]  233 	ret
                            234 ;src/UI_MainMenu.c:90: void ui_mainmenu_render_refresh(){
                            235 ;	---------------------------------
                            236 ; Function ui_mainmenu_render_refresh
                            237 ; ---------------------------------
   2927                     238 _ui_mainmenu_render_refresh::
                            239 ;src/UI_MainMenu.c:92: ui_mainmenu_render_button(ui_mainmenu_entryIndex);
   2927 3A B1 4A      [13]  240 	ld	a,(_ui_mainmenu_entryIndex)
   292A F5            [11]  241 	push	af
   292B 33            [ 6]  242 	inc	sp
   292C CD C0 28      [17]  243 	call	_ui_mainmenu_render_button
   292F 33            [ 6]  244 	inc	sp
                            245 ;src/UI_MainMenu.c:93: ui_mainmenu_render_button(ui_mainmenu_lastEntry);
   2930 3A B0 4A      [13]  246 	ld	a,(_ui_mainmenu_lastEntry)
   2933 F5            [11]  247 	push	af
   2934 33            [ 6]  248 	inc	sp
   2935 CD C0 28      [17]  249 	call	_ui_mainmenu_render_button
   2938 33            [ 6]  250 	inc	sp
                            251 ;src/UI_MainMenu.c:95: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   2939 3A B1 4A      [13]  252 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   293C 32 B0 4A      [13]  253 	ld	(#_ui_mainmenu_lastEntry + 0),a
   293F C9            [10]  254 	ret
                            255 ;src/UI_MainMenu.c:99: void ui_mainmenu_render_all(){
                            256 ;	---------------------------------
                            257 ; Function ui_mainmenu_render_all
                            258 ; ---------------------------------
   2940                     259 _ui_mainmenu_render_all::
                            260 ;src/UI_MainMenu.c:103: while(n){
   2940 06 05         [ 7]  261 	ld	b,#0x05
   2942                     262 00101$:
   2942 78            [ 4]  263 	ld	a,b
   2943 B7            [ 4]  264 	or	a, a
   2944 28 0B         [12]  265 	jr	Z,00103$
                            266 ;src/UI_MainMenu.c:104: --n;
   2946 05            [ 4]  267 	dec	b
                            268 ;src/UI_MainMenu.c:105: ui_mainmenu_render_button(n);
   2947 C5            [11]  269 	push	bc
   2948 C5            [11]  270 	push	bc
   2949 33            [ 6]  271 	inc	sp
   294A CD C0 28      [17]  272 	call	_ui_mainmenu_render_button
   294D 33            [ 6]  273 	inc	sp
   294E C1            [10]  274 	pop	bc
   294F 18 F1         [12]  275 	jr	00101$
   2951                     276 00103$:
                            277 ;src/UI_MainMenu.c:108: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   2951 3A B1 4A      [13]  278 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2954 32 B0 4A      [13]  279 	ld	(#_ui_mainmenu_lastEntry + 0),a
   2957 C9            [10]  280 	ret
                            281 ;src/UI_MainMenu.c:111: u8 ui_mainmenu_get_entry(){
                            282 ;	---------------------------------
                            283 ; Function ui_mainmenu_get_entry
                            284 ; ---------------------------------
   2958                     285 _ui_mainmenu_get_entry::
                            286 ;src/UI_MainMenu.c:112: return ui_mainmenu_entryIndex;
   2958 FD 21 B1 4A   [14]  287 	ld	iy,#_ui_mainmenu_entryIndex
   295C FD 6E 00      [19]  288 	ld	l,0 (iy)
   295F C9            [10]  289 	ret
                            290 ;src/UI_MainMenu.c:115: u8 ui_mainmenu_is_selected(){
                            291 ;	---------------------------------
                            292 ; Function ui_mainmenu_is_selected
                            293 ; ---------------------------------
   2960                     294 _ui_mainmenu_is_selected::
                            295 ;src/UI_MainMenu.c:116: return ui_mainmenu_entrySelected;
   2960 FD 21 B2 4A   [14]  296 	ld	iy,#_ui_mainmenu_entrySelected
   2964 FD 6E 00      [19]  297 	ld	l,0 (iy)
   2967 C9            [10]  298 	ret
                            299 	.area _CODE
                            300 	.area _INITIALIZER
   4ABD                     301 __xinit__ui_mainmenu_lastEntry:
   4ABD 00                  302 	.db #0x00	; 0
   4ABE                     303 __xinit__ui_mainmenu_entryIndex:
   4ABE 00                  304 	.db #0x00	; 0
   4ABF                     305 __xinit__ui_mainmenu_entrySelected:
   4ABF 00                  306 	.db #0x00	; 0
                            307 	.area _CABS (ABS)
