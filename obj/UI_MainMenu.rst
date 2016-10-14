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
                             11 	.globl _print_transparent_text
                             12 	.globl _cpct_drawSolidBox
                             13 	.globl _ui_mainmenu_entrySelected
                             14 	.globl _ui_mainmenu_entryIndex
                             15 	.globl _ui_mainmenu_lastEntry
                             16 	.globl _ui_mainmenu_buttonWidths
                             17 	.globl _ui_mainmenu_buttonText
                             18 	.globl _ui_mainmenu_entriesPosition
                             19 	.globl _ui_mainmenu_init
                             20 	.globl _ui_mainmenu_next_entry
                             21 	.globl _ui_mainmenu_previous_entry
                             22 	.globl _ui_mainmenu_unselect_entry
                             23 	.globl _ui_mainmenu_select_entry
                             24 	.globl _ui_mainmenu_render_refresh
                             25 	.globl _ui_mainmenu_render_all
                             26 	.globl _ui_mainmenu_get_entry
                             27 	.globl _ui_mainmenu_is_selected
                             28 ;--------------------------------------------------------
                             29 ; special function registers
                             30 ;--------------------------------------------------------
                             31 ;--------------------------------------------------------
                             32 ; ram data
                             33 ;--------------------------------------------------------
                             34 	.area _DATA
                             35 ;--------------------------------------------------------
                             36 ; ram data
                             37 ;--------------------------------------------------------
                             38 	.area _INITIALIZED
   491B                      39 _ui_mainmenu_lastEntry::
   491B                      40 	.ds 1
   491C                      41 _ui_mainmenu_entryIndex::
   491C                      42 	.ds 1
   491D                      43 _ui_mainmenu_entrySelected::
   491D                      44 	.ds 1
                             45 ;--------------------------------------------------------
                             46 ; absolute external ram data
                             47 ;--------------------------------------------------------
                             48 	.area _DABS (ABS)
                             49 ;--------------------------------------------------------
                             50 ; global & static initialisations
                             51 ;--------------------------------------------------------
                             52 	.area _HOME
                             53 	.area _GSINIT
                             54 	.area _GSFINAL
                             55 	.area _GSINIT
                             56 ;--------------------------------------------------------
                             57 ; Home
                             58 ;--------------------------------------------------------
                             59 	.area _HOME
                             60 	.area _HOME
                             61 ;--------------------------------------------------------
                             62 ; code
                             63 ;--------------------------------------------------------
                             64 	.area _CODE
                             65 ;src/UI_MainMenu.c:35: void ui_mainmenu_init(){
                             66 ;	---------------------------------
                             67 ; Function ui_mainmenu_init
                             68 ; ---------------------------------
   270B                      69 _ui_mainmenu_init::
                             70 ;src/UI_MainMenu.c:36: ui_mainmenu_lastEntry=0;
   270B 21 1B 49      [10]   71 	ld	hl,#_ui_mainmenu_lastEntry + 0
   270E 36 00         [10]   72 	ld	(hl), #0x00
                             73 ;src/UI_MainMenu.c:37: ui_mainmenu_entryIndex=0;
   2710 21 1C 49      [10]   74 	ld	hl,#_ui_mainmenu_entryIndex + 0
   2713 36 00         [10]   75 	ld	(hl), #0x00
                             76 ;src/UI_MainMenu.c:38: ui_mainmenu_entrySelected=0;
   2715 21 1D 49      [10]   77 	ld	hl,#_ui_mainmenu_entrySelected + 0
   2718 36 00         [10]   78 	ld	(hl), #0x00
   271A C9            [10]   79 	ret
   271B                      80 _ui_mainmenu_entriesPosition:
   271B 10 C4                81 	.dw #0xC410
   271D B0 E4                82 	.dw #0xE4B0
   271F A0 C5                83 	.dw #0xC5A0
   2721 40 E6                84 	.dw #0xE640
   2723 30 C7                85 	.dw #0xC730
   2725                      86 _ui_mainmenu_buttonText:
   2725 30 27                87 	.dw __str_0
   2727 39 27                88 	.dw __str_1
   2729 43 27                89 	.dw __str_2
   272B 4B 27                90 	.dw __str_3
   272D 53 27                91 	.dw __str_4
   272F                      92 _ui_mainmenu_buttonWidths:
   272F 14                   93 	.db #0x14	; 20
   2730                      94 __str_0:
   2730 4E 45 57 20 47 41    95 	.ascii "NEW GAME"
        4D 45
   2738 00                   96 	.db 0x00
   2739                      97 __str_1:
   2739 4C 4F 41 44 20 47    98 	.ascii "LOAD GAME"
        41 4D 45
   2742 00                   99 	.db 0x00
   2743                     100 __str_2:
   2743 4F 50 54 49 4F 4E   101 	.ascii "OPTIONS"
        53
   274A 00                  102 	.db 0x00
   274B                     103 __str_3:
   274B 43 52 45 44 49 54   104 	.ascii "CREDITS"
        53
   2752 00                  105 	.db 0x00
   2753                     106 __str_4:
   2753 45 58 49 54         107 	.ascii "EXIT"
   2757 00                  108 	.db 0x00
                            109 ;src/UI_MainMenu.c:41: void ui_mainmenu_next_entry(){
                            110 ;	---------------------------------
                            111 ; Function ui_mainmenu_next_entry
                            112 ; ---------------------------------
   2758                     113 _ui_mainmenu_next_entry::
                            114 ;src/UI_MainMenu.c:42: if(ui_mainmenu_entryIndex<(UI_MAINMENU_ENTRIES-1)){
                            115 ;src/UI_MainMenu.c:43: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   2758 3A 1C 49      [13]  116 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   275B FE 04         [ 7]  117 	cp	a,#0x04
   275D D0            [11]  118 	ret	NC
   275E 32 1B 49      [13]  119 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            120 ;src/UI_MainMenu.c:44: ++ui_mainmenu_entryIndex;
   2761 21 1C 49      [10]  121 	ld	hl, #_ui_mainmenu_entryIndex+0
   2764 34            [11]  122 	inc	(hl)
   2765 C9            [10]  123 	ret
                            124 ;src/UI_MainMenu.c:48: void ui_mainmenu_previous_entry(){
                            125 ;	---------------------------------
                            126 ; Function ui_mainmenu_previous_entry
                            127 ; ---------------------------------
   2766                     128 _ui_mainmenu_previous_entry::
                            129 ;src/UI_MainMenu.c:49: if(ui_mainmenu_entryIndex>0){
   2766 3A 1C 49      [13]  130 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2769 B7            [ 4]  131 	or	a, a
   276A C8            [11]  132 	ret	Z
                            133 ;src/UI_MainMenu.c:50: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   276B 3A 1C 49      [13]  134 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   276E 32 1B 49      [13]  135 	ld	(#_ui_mainmenu_lastEntry + 0),a
                            136 ;src/UI_MainMenu.c:51: --ui_mainmenu_entryIndex;
   2771 21 1C 49      [10]  137 	ld	hl, #_ui_mainmenu_entryIndex+0
   2774 35            [11]  138 	dec	(hl)
   2775 C9            [10]  139 	ret
                            140 ;src/UI_MainMenu.c:55: void ui_mainmenu_unselect_entry(){
                            141 ;	---------------------------------
                            142 ; Function ui_mainmenu_unselect_entry
                            143 ; ---------------------------------
   2776                     144 _ui_mainmenu_unselect_entry::
                            145 ;src/UI_MainMenu.c:56: ui_mainmenu_entrySelected=0;
   2776 21 1D 49      [10]  146 	ld	hl,#_ui_mainmenu_entrySelected + 0
   2779 36 00         [10]  147 	ld	(hl), #0x00
   277B C9            [10]  148 	ret
                            149 ;src/UI_MainMenu.c:59: void ui_mainmenu_select_entry(){
                            150 ;	---------------------------------
                            151 ; Function ui_mainmenu_select_entry
                            152 ; ---------------------------------
   277C                     153 _ui_mainmenu_select_entry::
                            154 ;src/UI_MainMenu.c:60: ui_mainmenu_entrySelected=1;
   277C 21 1D 49      [10]  155 	ld	hl,#_ui_mainmenu_entrySelected + 0
   277F 36 01         [10]  156 	ld	(hl), #0x01
   2781 C9            [10]  157 	ret
                            158 ;src/UI_MainMenu.c:64: void ui_mainmenu_render_refresh(){
                            159 ;	---------------------------------
                            160 ; Function ui_mainmenu_render_refresh
                            161 ; ---------------------------------
   2782                     162 _ui_mainmenu_render_refresh::
                            163 ;src/UI_MainMenu.c:67: color = (ui_mainmenu_entrySelected)? g_colors[4]: g_colors[5];
   2782 3A 1D 49      [13]  164 	ld	a,(#_ui_mainmenu_entrySelected + 0)
   2785 B7            [ 4]  165 	or	a, a
   2786 28 05         [12]  166 	jr	Z,00105$
   2788 3A B6 0A      [13]  167 	ld	a, (#(_g_colors + 0x0004) + 0)
   278B 18 03         [12]  168 	jr	00106$
   278D                     169 00105$:
   278D 3A B7 0A      [13]  170 	ld	a, (#(_g_colors + 0x0005) + 0)
   2790                     171 00106$:
   2790 5F            [ 4]  172 	ld	e,a
                            173 ;src/UI_MainMenu.c:68: cpct_drawSolidBox(ui_mainmenu_entriesPosition[ui_mainmenu_entryIndex],color, ui_mainmenu_buttonWidths, UI_MAINMENU_BUTTON_HEIGHT);
   2791 21 2F 27      [10]  174 	ld	hl,#_ui_mainmenu_buttonWidths + 0
   2794 56            [ 7]  175 	ld	d, (hl)
   2795 FD 21 1C 49   [14]  176 	ld	iy,#_ui_mainmenu_entryIndex
   2799 FD 6E 00      [19]  177 	ld	l,0 (iy)
   279C 26 00         [ 7]  178 	ld	h,#0x00
   279E 29            [11]  179 	add	hl, hl
   279F 01 1B 27      [10]  180 	ld	bc,#_ui_mainmenu_entriesPosition
   27A2 09            [11]  181 	add	hl,bc
   27A3 4E            [ 7]  182 	ld	c,(hl)
   27A4 23            [ 6]  183 	inc	hl
   27A5 46            [ 7]  184 	ld	b,(hl)
   27A6 3E 10         [ 7]  185 	ld	a,#0x10
   27A8 F5            [11]  186 	push	af
   27A9 33            [ 6]  187 	inc	sp
   27AA D5            [11]  188 	push	de
   27AB C5            [11]  189 	push	bc
   27AC CD 17 47      [17]  190 	call	_cpct_drawSolidBox
   27AF F1            [10]  191 	pop	af
   27B0 F1            [10]  192 	pop	af
   27B1 33            [ 6]  193 	inc	sp
                            194 ;src/UI_MainMenu.c:69: print_transparent_text(ui_mainmenu_buttonText[ui_mainmenu_entryIndex], ui_mainmenu_entriesPosition[ui_mainmenu_entryIndex], 3);
   27B2 FD 21 1C 49   [14]  195 	ld	iy,#_ui_mainmenu_entryIndex
   27B6 FD 6E 00      [19]  196 	ld	l,0 (iy)
   27B9 26 00         [ 7]  197 	ld	h,#0x00
   27BB 29            [11]  198 	add	hl, hl
   27BC 4D            [ 4]  199 	ld	c, l
   27BD 44            [ 4]  200 	ld	b, h
   27BE 21 1B 27      [10]  201 	ld	hl,#_ui_mainmenu_entriesPosition
   27C1 09            [11]  202 	add	hl,bc
   27C2 5E            [ 7]  203 	ld	e,(hl)
   27C3 23            [ 6]  204 	inc	hl
   27C4 56            [ 7]  205 	ld	d,(hl)
   27C5 21 25 27      [10]  206 	ld	hl,#_ui_mainmenu_buttonText
   27C8 09            [11]  207 	add	hl,bc
   27C9 4E            [ 7]  208 	ld	c,(hl)
   27CA 23            [ 6]  209 	inc	hl
   27CB 46            [ 7]  210 	ld	b,(hl)
   27CC 3E 03         [ 7]  211 	ld	a,#0x03
   27CE F5            [11]  212 	push	af
   27CF 33            [ 6]  213 	inc	sp
   27D0 D5            [11]  214 	push	de
   27D1 C5            [11]  215 	push	bc
   27D2 CD AB 21      [17]  216 	call	_print_transparent_text
   27D5 F1            [10]  217 	pop	af
   27D6 F1            [10]  218 	pop	af
   27D7 33            [ 6]  219 	inc	sp
                            220 ;src/UI_MainMenu.c:71: if(ui_mainmenu_lastEntry!=ui_mainmenu_entryIndex){
   27D8 3A 1B 49      [13]  221 	ld	a,(#_ui_mainmenu_lastEntry + 0)
   27DB FD 21 1C 49   [14]  222 	ld	iy,#_ui_mainmenu_entryIndex
   27DF FD 96 00      [19]  223 	sub	a, 0 (iy)
   27E2 C8            [11]  224 	ret	Z
                            225 ;src/UI_MainMenu.c:72: color = g_colors[2];
   27E3 21 B4 0A      [10]  226 	ld	hl,#_g_colors+2
   27E6 5E            [ 7]  227 	ld	e,(hl)
                            228 ;src/UI_MainMenu.c:73: cpct_drawSolidBox(ui_mainmenu_entriesPosition[ui_mainmenu_lastEntry],color, ui_mainmenu_buttonWidths, UI_MAINMENU_BUTTON_HEIGHT);
   27E7 21 2F 27      [10]  229 	ld	hl,#_ui_mainmenu_buttonWidths + 0
   27EA 56            [ 7]  230 	ld	d, (hl)
   27EB FD 21 1B 49   [14]  231 	ld	iy,#_ui_mainmenu_lastEntry
   27EF FD 6E 00      [19]  232 	ld	l,0 (iy)
   27F2 26 00         [ 7]  233 	ld	h,#0x00
   27F4 29            [11]  234 	add	hl, hl
   27F5 01 1B 27      [10]  235 	ld	bc,#_ui_mainmenu_entriesPosition
   27F8 09            [11]  236 	add	hl,bc
   27F9 4E            [ 7]  237 	ld	c,(hl)
   27FA 23            [ 6]  238 	inc	hl
   27FB 46            [ 7]  239 	ld	b,(hl)
   27FC 3E 10         [ 7]  240 	ld	a,#0x10
   27FE F5            [11]  241 	push	af
   27FF 33            [ 6]  242 	inc	sp
   2800 D5            [11]  243 	push	de
   2801 C5            [11]  244 	push	bc
   2802 CD 17 47      [17]  245 	call	_cpct_drawSolidBox
   2805 F1            [10]  246 	pop	af
   2806 F1            [10]  247 	pop	af
   2807 33            [ 6]  248 	inc	sp
                            249 ;src/UI_MainMenu.c:74: print_transparent_text(ui_mainmenu_buttonText[ui_mainmenu_lastEntry], ui_mainmenu_entriesPosition[ui_mainmenu_lastEntry], 3);
   2808 FD 21 1B 49   [14]  250 	ld	iy,#_ui_mainmenu_lastEntry
   280C FD 6E 00      [19]  251 	ld	l,0 (iy)
   280F 26 00         [ 7]  252 	ld	h,#0x00
   2811 29            [11]  253 	add	hl, hl
   2812 4D            [ 4]  254 	ld	c, l
   2813 44            [ 4]  255 	ld	b, h
   2814 21 1B 27      [10]  256 	ld	hl,#_ui_mainmenu_entriesPosition
   2817 09            [11]  257 	add	hl,bc
   2818 5E            [ 7]  258 	ld	e,(hl)
   2819 23            [ 6]  259 	inc	hl
   281A 56            [ 7]  260 	ld	d,(hl)
   281B 21 25 27      [10]  261 	ld	hl,#_ui_mainmenu_buttonText
   281E 09            [11]  262 	add	hl,bc
   281F 4E            [ 7]  263 	ld	c,(hl)
   2820 23            [ 6]  264 	inc	hl
   2821 46            [ 7]  265 	ld	b,(hl)
   2822 3E 03         [ 7]  266 	ld	a,#0x03
   2824 F5            [11]  267 	push	af
   2825 33            [ 6]  268 	inc	sp
   2826 D5            [11]  269 	push	de
   2827 C5            [11]  270 	push	bc
   2828 CD AB 21      [17]  271 	call	_print_transparent_text
   282B F1            [10]  272 	pop	af
   282C F1            [10]  273 	pop	af
   282D 33            [ 6]  274 	inc	sp
                            275 ;src/UI_MainMenu.c:75: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   282E 3A 1C 49      [13]  276 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   2831 32 1B 49      [13]  277 	ld	(#_ui_mainmenu_lastEntry + 0),a
   2834 C9            [10]  278 	ret
                            279 ;src/UI_MainMenu.c:82: void ui_mainmenu_render_all(){
                            280 ;	---------------------------------
                            281 ; Function ui_mainmenu_render_all
                            282 ; ---------------------------------
   2835                     283 _ui_mainmenu_render_all::
   2835 DD E5         [15]  284 	push	ix
   2837 DD 21 00 00   [14]  285 	ld	ix,#0
   283B DD 39         [15]  286 	add	ix,sp
   283D F5            [11]  287 	push	af
   283E 3B            [ 6]  288 	dec	sp
                            289 ;src/UI_MainMenu.c:86: while(n){
   283F DD 36 FD 05   [19]  290 	ld	-3 (ix),#0x05
   2843                     291 00101$:
   2843 DD 7E FD      [19]  292 	ld	a,-3 (ix)
   2846 B7            [ 4]  293 	or	a, a
   2847 28 6E         [12]  294 	jr	Z,00103$
                            295 ;src/UI_MainMenu.c:87: --n;
   2849 DD 35 FD      [23]  296 	dec	-3 (ix)
                            297 ;src/UI_MainMenu.c:88: color = (n==ui_mainmenu_entryIndex)?((ui_mainmenu_entrySelected)? g_colors[4]: g_colors[5]): g_colors[2];
   284C 3A 1C 49      [13]  298 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   284F DD 96 FD      [19]  299 	sub	a, -3 (ix)
   2852 20 10         [12]  300 	jr	NZ,00106$
   2854 3A 1D 49      [13]  301 	ld	a,(#_ui_mainmenu_entrySelected + 0)
   2857 B7            [ 4]  302 	or	a, a
   2858 28 05         [12]  303 	jr	Z,00108$
   285A 3A B6 0A      [13]  304 	ld	a, (#_g_colors + 4)
   285D 18 08         [12]  305 	jr	00107$
   285F                     306 00108$:
   285F 3A B7 0A      [13]  307 	ld	a, (#_g_colors + 5)
   2862 18 03         [12]  308 	jr	00107$
   2864                     309 00106$:
   2864 3A B4 0A      [13]  310 	ld	a, (#_g_colors + 2)
   2867                     311 00107$:
   2867 4F            [ 4]  312 	ld	c,a
                            313 ;src/UI_MainMenu.c:89: cpct_drawSolidBox(ui_mainmenu_entriesPosition[n],color, ui_mainmenu_buttonWidths, UI_MAINMENU_BUTTON_HEIGHT);
   2868 21 2F 27      [10]  314 	ld	hl,#_ui_mainmenu_buttonWidths + 0
   286B 46            [ 7]  315 	ld	b, (hl)
   286C DD 6E FD      [19]  316 	ld	l,-3 (ix)
   286F 26 00         [ 7]  317 	ld	h,#0x00
   2871 29            [11]  318 	add	hl, hl
   2872 EB            [ 4]  319 	ex	de,hl
   2873 21 1B 27      [10]  320 	ld	hl,#_ui_mainmenu_entriesPosition
   2876 19            [11]  321 	add	hl,de
   2877 DD 75 FE      [19]  322 	ld	-2 (ix),l
   287A DD 74 FF      [19]  323 	ld	-1 (ix),h
   287D DD 6E FE      [19]  324 	ld	l,-2 (ix)
   2880 DD 66 FF      [19]  325 	ld	h,-1 (ix)
   2883 7E            [ 7]  326 	ld	a, (hl)
   2884 23            [ 6]  327 	inc	hl
   2885 66            [ 7]  328 	ld	h,(hl)
   2886 6F            [ 4]  329 	ld	l,a
   2887 E5            [11]  330 	push	hl
   2888 FD E1         [14]  331 	pop	iy
   288A D5            [11]  332 	push	de
   288B 3E 10         [ 7]  333 	ld	a,#0x10
   288D F5            [11]  334 	push	af
   288E 33            [ 6]  335 	inc	sp
   288F C5            [11]  336 	push	bc
   2890 FD E5         [15]  337 	push	iy
   2892 CD 17 47      [17]  338 	call	_cpct_drawSolidBox
   2895 F1            [10]  339 	pop	af
   2896 F1            [10]  340 	pop	af
   2897 33            [ 6]  341 	inc	sp
   2898 D1            [10]  342 	pop	de
                            343 ;src/UI_MainMenu.c:90: print_transparent_text(ui_mainmenu_buttonText[n], ui_mainmenu_entriesPosition[n], 3);
   2899 DD 6E FE      [19]  344 	ld	l,-2 (ix)
   289C DD 66 FF      [19]  345 	ld	h,-1 (ix)
   289F 4E            [ 7]  346 	ld	c,(hl)
   28A0 23            [ 6]  347 	inc	hl
   28A1 46            [ 7]  348 	ld	b,(hl)
   28A2 21 25 27      [10]  349 	ld	hl,#_ui_mainmenu_buttonText
   28A5 19            [11]  350 	add	hl,de
   28A6 5E            [ 7]  351 	ld	e,(hl)
   28A7 23            [ 6]  352 	inc	hl
   28A8 56            [ 7]  353 	ld	d,(hl)
   28A9 3E 03         [ 7]  354 	ld	a,#0x03
   28AB F5            [11]  355 	push	af
   28AC 33            [ 6]  356 	inc	sp
   28AD C5            [11]  357 	push	bc
   28AE D5            [11]  358 	push	de
   28AF CD AB 21      [17]  359 	call	_print_transparent_text
   28B2 F1            [10]  360 	pop	af
   28B3 F1            [10]  361 	pop	af
   28B4 33            [ 6]  362 	inc	sp
   28B5 18 8C         [12]  363 	jr	00101$
   28B7                     364 00103$:
                            365 ;src/UI_MainMenu.c:93: ui_mainmenu_lastEntry=ui_mainmenu_entryIndex;
   28B7 3A 1C 49      [13]  366 	ld	a,(#_ui_mainmenu_entryIndex + 0)
   28BA 32 1B 49      [13]  367 	ld	(#_ui_mainmenu_lastEntry + 0),a
   28BD DD F9         [10]  368 	ld	sp, ix
   28BF DD E1         [14]  369 	pop	ix
   28C1 C9            [10]  370 	ret
                            371 ;src/UI_MainMenu.c:96: u8 ui_mainmenu_get_entry(){
                            372 ;	---------------------------------
                            373 ; Function ui_mainmenu_get_entry
                            374 ; ---------------------------------
   28C2                     375 _ui_mainmenu_get_entry::
                            376 ;src/UI_MainMenu.c:97: return ui_mainmenu_entryIndex;
   28C2 FD 21 1C 49   [14]  377 	ld	iy,#_ui_mainmenu_entryIndex
   28C6 FD 6E 00      [19]  378 	ld	l,0 (iy)
   28C9 C9            [10]  379 	ret
                            380 ;src/UI_MainMenu.c:100: u8 ui_mainmenu_is_selected(){
                            381 ;	---------------------------------
                            382 ; Function ui_mainmenu_is_selected
                            383 ; ---------------------------------
   28CA                     384 _ui_mainmenu_is_selected::
                            385 ;src/UI_MainMenu.c:101: return ui_mainmenu_entrySelected;
   28CA FD 21 1D 49   [14]  386 	ld	iy,#_ui_mainmenu_entrySelected
   28CE FD 6E 00      [19]  387 	ld	l,0 (iy)
   28D1 C9            [10]  388 	ret
                            389 	.area _CODE
                            390 	.area _INITIALIZER
   4924                     391 __xinit__ui_mainmenu_lastEntry:
   4924 00                  392 	.db #0x00	; 0
   4925                     393 __xinit__ui_mainmenu_entryIndex:
   4925 00                  394 	.db #0x00	; 0
   4926                     395 __xinit__ui_mainmenu_entrySelected:
   4926 00                  396 	.db #0x00	; 0
                            397 	.area _CABS (ABS)
