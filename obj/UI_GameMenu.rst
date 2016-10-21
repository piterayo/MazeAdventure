                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_GameMenu
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_gamemenu_render_button
                             12 	.globl _print_transparent_text
                             13 	.globl _cpct_drawSolidBox
                             14 	.globl _ui_gamemenu_action
                             15 	.globl _ui_gamemenu_can_move
                             16 	.globl _ui_gamemenu_entrySelected
                             17 	.globl _ui_gamemenu_entryIndex
                             18 	.globl _ui_gamemenu_lastEntry
                             19 	.globl _ui_gamemenu_buttonWidths
                             20 	.globl _ui_gamemenu_buttonText
                             21 	.globl _ui_gamemenu_action_buttonText
                             22 	.globl _ui_gamemenu_entriesTextPosition
                             23 	.globl _ui_gamemenu_entriesPosition
                             24 	.globl _ui_gamemenu_init
                             25 	.globl _ui_gamemenu_above_entry
                             26 	.globl _ui_gamemenu_below_entry
                             27 	.globl _ui_gamemenu_next_entry
                             28 	.globl _ui_gamemenu_previous_entry
                             29 	.globl _ui_gamemenu_unselect_entry
                             30 	.globl _ui_gamemenu_select_entry
                             31 	.globl _ui_gamemenu_render_refresh
                             32 	.globl _ui_gamemenu_render_all
                             33 	.globl _ui_gamemenu_get_entry
                             34 	.globl _ui_gamemenu_is_selected
                             35 	.globl _ui_gamemenu_update_action
                             36 	.globl _ui_gamemenu_get_movement
                             37 	.globl _ui_gamemenu_get_action
                             38 ;--------------------------------------------------------
                             39 ; special function registers
                             40 ;--------------------------------------------------------
                             41 ;--------------------------------------------------------
                             42 ; ram data
                             43 ;--------------------------------------------------------
                             44 	.area _DATA
   5B2D                      45 _ui_gamemenu_lastEntry::
   5B2D                      46 	.ds 1
   5B2E                      47 _ui_gamemenu_entryIndex::
   5B2E                      48 	.ds 1
   5B2F                      49 _ui_gamemenu_entrySelected::
   5B2F                      50 	.ds 1
   5B30                      51 _ui_gamemenu_can_move::
   5B30                      52 	.ds 1
   5B31                      53 _ui_gamemenu_action::
   5B31                      54 	.ds 1
                             55 ;--------------------------------------------------------
                             56 ; ram data
                             57 ;--------------------------------------------------------
                             58 	.area _INITIALIZED
                             59 ;--------------------------------------------------------
                             60 ; absolute external ram data
                             61 ;--------------------------------------------------------
                             62 	.area _DABS (ABS)
                             63 ;--------------------------------------------------------
                             64 ; global & static initialisations
                             65 ;--------------------------------------------------------
                             66 	.area _HOME
                             67 	.area _GSINIT
                             68 	.area _GSFINAL
                             69 	.area _GSINIT
                             70 ;--------------------------------------------------------
                             71 ; Home
                             72 ;--------------------------------------------------------
                             73 	.area _HOME
                             74 	.area _HOME
                             75 ;--------------------------------------------------------
                             76 ; code
                             77 ;--------------------------------------------------------
                             78 	.area _CODE
                             79 ;src/UI_GameMenu.c:74: void ui_gamemenu_init(){
                             80 ;	---------------------------------
                             81 ; Function ui_gamemenu_init
                             82 ; ---------------------------------
   2A97                      83 _ui_gamemenu_init::
                             84 ;src/UI_GameMenu.c:75: ui_gamemenu_lastEntry=0;
   2A97 21 2D 5B      [10]   85 	ld	hl,#_ui_gamemenu_lastEntry + 0
   2A9A 36 00         [10]   86 	ld	(hl), #0x00
                             87 ;src/UI_GameMenu.c:76: ui_gamemenu_entryIndex=0;
   2A9C 21 2E 5B      [10]   88 	ld	hl,#_ui_gamemenu_entryIndex + 0
   2A9F 36 00         [10]   89 	ld	(hl), #0x00
                             90 ;src/UI_GameMenu.c:77: ui_gamemenu_entrySelected=0;
   2AA1 21 2F 5B      [10]   91 	ld	hl,#_ui_gamemenu_entrySelected + 0
   2AA4 36 00         [10]   92 	ld	(hl), #0x00
                             93 ;src/UI_GameMenu.c:78: ui_gamemenu_update_action();
   2AA6 C3 32 2C      [10]   94 	jp  _ui_gamemenu_update_action
   2AA9                      95 _ui_gamemenu_entriesPosition:
   2AA9 50 C5                96 	.dw #0xC550
   2AAB 84 C5                97 	.dw #0xC584
   2AAD E0 C6                98 	.dw #0xC6E0
   2AAF E7 C6                99 	.dw #0xC6E7
   2AB1 F6 C6               100 	.dw #0xC6F6
   2AB3 14 C7               101 	.dw #0xC714
   2AB5 23 C7               102 	.dw #0xC723
   2AB7                     103 _ui_gamemenu_entriesTextPosition:
   2AB7 A4 CD               104 	.dw #0xCDA4
   2AB9 D9 CD               105 	.dw #0xCDD9
   2ABB 32 CF               106 	.dw #0xCF32
   2ABD 3A CF               107 	.dw #0xCF3A
   2ABF 48 CF               108 	.dw #0xCF48
   2AC1 67 CF               109 	.dw #0xCF67
   2AC3 75 CF               110 	.dw #0xCF75
   2AC5                     111 _ui_gamemenu_action_buttonText:
   2AC5 E0 2A               112 	.dw __str_0
   2AC7 EB 2A               113 	.dw __str_1
   2AC9 F4 2A               114 	.dw __str_2
   2ACB                     115 _ui_gamemenu_buttonText:
   2ACB FF 2A               116 	.dw __str_3
   2ACD 00 2B               117 	.dw __str_4
   2ACF 0A 2B               118 	.dw __str_5
   2AD1 FF 2A               119 	.dw __str_3
   2AD3 0C 2B               120 	.dw __str_6
   2AD5 0E 2B               121 	.dw __str_7
   2AD7 13 2B               122 	.dw __str_8
   2AD9                     123 _ui_gamemenu_buttonWidths:
   2AD9 1C                  124 	.db #0x1C	; 28
   2ADA 1C                  125 	.db #0x1C	; 28
   2ADB 06                  126 	.db #0x06	; 6
   2ADC 0E                  127 	.db #0x0E	; 14
   2ADD 06                  128 	.db #0x06	; 6
   2ADE 0D                  129 	.db #0x0D	; 13
   2ADF 0D                  130 	.db #0x0D	; 13
   2AE0                     131 __str_0:
   2AE0 4E 45 58 54 20 4C   132 	.ascii "NEXT LEVEL"
        45 56 45 4C
   2AEA 00                  133 	.db 0x00
   2AEB                     134 __str_1:
   2AEB 20 20 41 54 54 41   135 	.ascii "  ATTACK"
        43 4B
   2AF3 00                  136 	.db 0x00
   2AF4                     137 __str_2:
   2AF4 20 20 20 50 49 43   138 	.ascii "   PICK UP"
        4B 20 55 50
   2AFE 00                  139 	.db 0x00
   2AFF                     140 __str_3:
   2AFF 00                  141 	.db 0x00
   2B00                     142 __str_4:
   2B00 49 4E 56 45 4E 54   143 	.ascii "INVENTORY"
        4F 52 59
   2B09 00                  144 	.db 0x00
   2B0A                     145 __str_5:
   2B0A 3C                  146 	.ascii "<"
   2B0B 00                  147 	.db 0x00
   2B0C                     148 __str_6:
   2B0C 3E                  149 	.ascii ">"
   2B0D 00                  150 	.db 0x00
   2B0E                     151 __str_7:
   2B0E 57 41 49 54         152 	.ascii "WAIT"
   2B12 00                  153 	.db 0x00
   2B13                     154 __str_8:
   2B13 50 41 55 53 45      155 	.ascii "PAUSE"
   2B18 00                  156 	.db 0x00
                            157 ;src/UI_GameMenu.c:81: void ui_gamemenu_above_entry(){
                            158 ;	---------------------------------
                            159 ; Function ui_gamemenu_above_entry
                            160 ; ---------------------------------
   2B19                     161 _ui_gamemenu_above_entry::
                            162 ;src/UI_GameMenu.c:82: if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
   2B19 3A 2E 5B      [13]  163 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2B1C FE 02         [ 7]  164 	cp	a,#0x02
   2B1E 38 0A         [12]  165 	jr	C,00105$
   2B20 D6 05         [ 7]  166 	sub	a, #0x05
   2B22 30 06         [12]  167 	jr	NC,00105$
                            168 ;src/UI_GameMenu.c:83: ui_gamemenu_entryIndex=0;
   2B24 21 2E 5B      [10]  169 	ld	hl,#_ui_gamemenu_entryIndex + 0
   2B27 36 00         [10]  170 	ld	(hl), #0x00
   2B29 C9            [10]  171 	ret
   2B2A                     172 00105$:
                            173 ;src/UI_GameMenu.c:85: else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
   2B2A 3A 2E 5B      [13]  174 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2B2D FE 05         [ 7]  175 	cp	a,#0x05
   2B2F 28 03         [12]  176 	jr	Z,00101$
   2B31 D6 06         [ 7]  177 	sub	a, #0x06
   2B33 C0            [11]  178 	ret	NZ
   2B34                     179 00101$:
                            180 ;src/UI_GameMenu.c:86: ui_gamemenu_entryIndex=1;
   2B34 21 2E 5B      [10]  181 	ld	hl,#_ui_gamemenu_entryIndex + 0
   2B37 36 01         [10]  182 	ld	(hl), #0x01
   2B39 C9            [10]  183 	ret
                            184 ;src/UI_GameMenu.c:90: void ui_gamemenu_below_entry(){
                            185 ;	---------------------------------
                            186 ; Function ui_gamemenu_below_entry
                            187 ; ---------------------------------
   2B3A                     188 _ui_gamemenu_below_entry::
                            189 ;src/UI_GameMenu.c:91: if(ui_gamemenu_entryIndex==0){
   2B3A 3A 2E 5B      [13]  190 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2B3D B7            [ 4]  191 	or	a, a
   2B3E 20 06         [12]  192 	jr	NZ,00104$
                            193 ;src/UI_GameMenu.c:92: ui_gamemenu_entryIndex=3;
   2B40 21 2E 5B      [10]  194 	ld	hl,#_ui_gamemenu_entryIndex + 0
   2B43 36 03         [10]  195 	ld	(hl), #0x03
   2B45 C9            [10]  196 	ret
   2B46                     197 00104$:
                            198 ;src/UI_GameMenu.c:94: else if(ui_gamemenu_entryIndex==1){
   2B46 3A 2E 5B      [13]  199 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2B49 3D            [ 4]  200 	dec	a
   2B4A C0            [11]  201 	ret	NZ
                            202 ;src/UI_GameMenu.c:95: ui_gamemenu_entryIndex=5;
   2B4B 21 2E 5B      [10]  203 	ld	hl,#_ui_gamemenu_entryIndex + 0
   2B4E 36 05         [10]  204 	ld	(hl), #0x05
   2B50 C9            [10]  205 	ret
                            206 ;src/UI_GameMenu.c:99: void ui_gamemenu_next_entry(){
                            207 ;	---------------------------------
                            208 ; Function ui_gamemenu_next_entry
                            209 ; ---------------------------------
   2B51                     210 _ui_gamemenu_next_entry::
                            211 ;src/UI_GameMenu.c:100: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
   2B51 3A 2E 5B      [13]  212 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2B54 FE 06         [ 7]  213 	cp	a,#0x06
   2B56 D0            [11]  214 	ret	NC
   2B57 3D            [ 4]  215 	dec	a
   2B58 C8            [11]  216 	ret	Z
                            217 ;src/UI_GameMenu.c:101: ++ui_gamemenu_entryIndex;
   2B59 21 2E 5B      [10]  218 	ld	hl, #_ui_gamemenu_entryIndex+0
   2B5C 34            [11]  219 	inc	(hl)
   2B5D C9            [10]  220 	ret
                            221 ;src/UI_GameMenu.c:105: void ui_gamemenu_previous_entry(){
                            222 ;	---------------------------------
                            223 ; Function ui_gamemenu_previous_entry
                            224 ; ---------------------------------
   2B5E                     225 _ui_gamemenu_previous_entry::
                            226 ;src/UI_GameMenu.c:106: if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
   2B5E 3A 2E 5B      [13]  227 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2B61 B7            [ 4]  228 	or	a, a
   2B62 C8            [11]  229 	ret	Z
   2B63 3A 2E 5B      [13]  230 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2B66 D6 02         [ 7]  231 	sub	a, #0x02
   2B68 C8            [11]  232 	ret	Z
                            233 ;src/UI_GameMenu.c:107: --ui_gamemenu_entryIndex;
   2B69 21 2E 5B      [10]  234 	ld	hl, #_ui_gamemenu_entryIndex+0
   2B6C 35            [11]  235 	dec	(hl)
   2B6D C9            [10]  236 	ret
                            237 ;src/UI_GameMenu.c:111: void ui_gamemenu_unselect_entry(){
                            238 ;	---------------------------------
                            239 ; Function ui_gamemenu_unselect_entry
                            240 ; ---------------------------------
   2B6E                     241 _ui_gamemenu_unselect_entry::
                            242 ;src/UI_GameMenu.c:112: ui_gamemenu_entrySelected=0;
   2B6E 21 2F 5B      [10]  243 	ld	hl,#_ui_gamemenu_entrySelected + 0
   2B71 36 00         [10]  244 	ld	(hl), #0x00
   2B73 C9            [10]  245 	ret
                            246 ;src/UI_GameMenu.c:115: void ui_gamemenu_select_entry(){
                            247 ;	---------------------------------
                            248 ; Function ui_gamemenu_select_entry
                            249 ; ---------------------------------
   2B74                     250 _ui_gamemenu_select_entry::
                            251 ;src/UI_GameMenu.c:116: ui_gamemenu_entrySelected=1;
   2B74 21 2F 5B      [10]  252 	ld	hl,#_ui_gamemenu_entrySelected + 0
   2B77 36 01         [10]  253 	ld	(hl), #0x01
   2B79 C9            [10]  254 	ret
                            255 ;src/UI_GameMenu.c:119: void ui_gamemenu_render_button(u8 n){
                            256 ;	---------------------------------
                            257 ; Function ui_gamemenu_render_button
                            258 ; ---------------------------------
   2B7A                     259 _ui_gamemenu_render_button::
   2B7A DD E5         [15]  260 	push	ix
   2B7C DD 21 00 00   [14]  261 	ld	ix,#0
   2B80 DD 39         [15]  262 	add	ix,sp
   2B82 F5            [11]  263 	push	af
                            264 ;src/UI_GameMenu.c:121: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   2B83 DD 7E 04      [19]  265 	ld	a,4 (ix)
   2B86 FD 21 2E 5B   [14]  266 	ld	iy,#_ui_gamemenu_entryIndex
   2B8A FD 96 00      [19]  267 	sub	a, 0 (iy)
   2B8D 20 10         [12]  268 	jr	NZ,00103$
   2B8F 3A 2F 5B      [13]  269 	ld	a,(#_ui_gamemenu_entrySelected + 0)
   2B92 B7            [ 4]  270 	or	a, a
   2B93 28 05         [12]  271 	jr	Z,00105$
   2B95 3A 6A 10      [13]  272 	ld	a, (#(_g_colors + 0x0004) + 0)
   2B98 18 08         [12]  273 	jr	00104$
   2B9A                     274 00105$:
   2B9A 3A 6C 10      [13]  275 	ld	a, (#(_g_colors + 0x0006) + 0)
   2B9D 18 03         [12]  276 	jr	00104$
   2B9F                     277 00103$:
   2B9F 3A 68 10      [13]  278 	ld	a, (#(_g_colors + 0x0002) + 0)
   2BA2                     279 00104$:
   2BA2 4F            [ 4]  280 	ld	c,a
                            281 ;src/UI_GameMenu.c:122: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
   2BA3 11 D9 2A      [10]  282 	ld	de,#_ui_gamemenu_buttonWidths+0
   2BA6 DD 6E 04      [19]  283 	ld	l,4 (ix)
   2BA9 26 00         [ 7]  284 	ld	h,#0x00
   2BAB 19            [11]  285 	add	hl,de
   2BAC 46            [ 7]  286 	ld	b,(hl)
   2BAD DD 6E 04      [19]  287 	ld	l,4 (ix)
   2BB0 26 00         [ 7]  288 	ld	h,#0x00
   2BB2 29            [11]  289 	add	hl, hl
   2BB3 EB            [ 4]  290 	ex	de,hl
   2BB4 21 A9 2A      [10]  291 	ld	hl,#_ui_gamemenu_entriesPosition
   2BB7 19            [11]  292 	add	hl,de
   2BB8 7E            [ 7]  293 	ld	a,(hl)
   2BB9 DD 77 FE      [19]  294 	ld	-2 (ix),a
   2BBC 23            [ 6]  295 	inc	hl
   2BBD 7E            [ 7]  296 	ld	a,(hl)
   2BBE DD 77 FF      [19]  297 	ld	-1 (ix),a
   2BC1 D5            [11]  298 	push	de
   2BC2 3E 18         [ 7]  299 	ld	a,#0x18
   2BC4 F5            [11]  300 	push	af
   2BC5 33            [ 6]  301 	inc	sp
   2BC6 C5            [11]  302 	push	bc
   2BC7 DD 6E FE      [19]  303 	ld	l,-2 (ix)
   2BCA DD 66 FF      [19]  304 	ld	h,-1 (ix)
   2BCD E5            [11]  305 	push	hl
   2BCE CD 62 59      [17]  306 	call	_cpct_drawSolidBox
   2BD1 F1            [10]  307 	pop	af
   2BD2 F1            [10]  308 	pop	af
   2BD3 33            [ 6]  309 	inc	sp
   2BD4 D1            [10]  310 	pop	de
                            311 ;src/UI_GameMenu.c:123: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
   2BD5 21 B7 2A      [10]  312 	ld	hl,#_ui_gamemenu_entriesTextPosition
   2BD8 19            [11]  313 	add	hl,de
   2BD9 4E            [ 7]  314 	ld	c,(hl)
   2BDA 23            [ 6]  315 	inc	hl
   2BDB 46            [ 7]  316 	ld	b,(hl)
   2BDC 21 CB 2A      [10]  317 	ld	hl,#_ui_gamemenu_buttonText
   2BDF 19            [11]  318 	add	hl,de
   2BE0 5E            [ 7]  319 	ld	e,(hl)
   2BE1 23            [ 6]  320 	inc	hl
   2BE2 56            [ 7]  321 	ld	d,(hl)
   2BE3 3E 03         [ 7]  322 	ld	a,#0x03
   2BE5 F5            [11]  323 	push	af
   2BE6 33            [ 6]  324 	inc	sp
   2BE7 C5            [11]  325 	push	bc
   2BE8 D5            [11]  326 	push	de
   2BE9 CD 59 28      [17]  327 	call	_print_transparent_text
   2BEC DD F9         [10]  328 	ld	sp,ix
   2BEE DD E1         [14]  329 	pop	ix
   2BF0 C9            [10]  330 	ret
                            331 ;src/UI_GameMenu.c:135: void ui_gamemenu_render_refresh(){
                            332 ;	---------------------------------
                            333 ; Function ui_gamemenu_render_refresh
                            334 ; ---------------------------------
   2BF1                     335 _ui_gamemenu_render_refresh::
                            336 ;src/UI_GameMenu.c:137: ui_gamemenu_render_button(ui_gamemenu_entryIndex);
   2BF1 3A 2E 5B      [13]  337 	ld	a,(_ui_gamemenu_entryIndex)
   2BF4 F5            [11]  338 	push	af
   2BF5 33            [ 6]  339 	inc	sp
   2BF6 CD 7A 2B      [17]  340 	call	_ui_gamemenu_render_button
   2BF9 33            [ 6]  341 	inc	sp
                            342 ;src/UI_GameMenu.c:138: ui_gamemenu_render_button(ui_gamemenu_lastEntry);
   2BFA 3A 2D 5B      [13]  343 	ld	a,(_ui_gamemenu_lastEntry)
   2BFD F5            [11]  344 	push	af
   2BFE 33            [ 6]  345 	inc	sp
   2BFF CD 7A 2B      [17]  346 	call	_ui_gamemenu_render_button
   2C02 33            [ 6]  347 	inc	sp
                            348 ;src/UI_GameMenu.c:141: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   2C03 3A 2E 5B      [13]  349 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2C06 32 2D 5B      [13]  350 	ld	(#_ui_gamemenu_lastEntry + 0),a
   2C09 C9            [10]  351 	ret
                            352 ;src/UI_GameMenu.c:145: void ui_gamemenu_render_all(){
                            353 ;	---------------------------------
                            354 ; Function ui_gamemenu_render_all
                            355 ; ---------------------------------
   2C0A                     356 _ui_gamemenu_render_all::
                            357 ;src/UI_GameMenu.c:149: while(n){
   2C0A 06 07         [ 7]  358 	ld	b,#0x07
   2C0C                     359 00101$:
   2C0C 78            [ 4]  360 	ld	a,b
   2C0D B7            [ 4]  361 	or	a, a
   2C0E 28 0B         [12]  362 	jr	Z,00103$
                            363 ;src/UI_GameMenu.c:150: --n;
   2C10 05            [ 4]  364 	dec	b
                            365 ;src/UI_GameMenu.c:151: ui_gamemenu_render_button(n);
   2C11 C5            [11]  366 	push	bc
   2C12 C5            [11]  367 	push	bc
   2C13 33            [ 6]  368 	inc	sp
   2C14 CD 7A 2B      [17]  369 	call	_ui_gamemenu_render_button
   2C17 33            [ 6]  370 	inc	sp
   2C18 C1            [10]  371 	pop	bc
   2C19 18 F1         [12]  372 	jr	00101$
   2C1B                     373 00103$:
                            374 ;src/UI_GameMenu.c:154: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   2C1B 3A 2E 5B      [13]  375 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   2C1E 32 2D 5B      [13]  376 	ld	(#_ui_gamemenu_lastEntry + 0),a
   2C21 C9            [10]  377 	ret
                            378 ;src/UI_GameMenu.c:157: u8 ui_gamemenu_get_entry(){
                            379 ;	---------------------------------
                            380 ; Function ui_gamemenu_get_entry
                            381 ; ---------------------------------
   2C22                     382 _ui_gamemenu_get_entry::
                            383 ;src/UI_GameMenu.c:158: return ui_gamemenu_entryIndex;
   2C22 FD 21 2E 5B   [14]  384 	ld	iy,#_ui_gamemenu_entryIndex
   2C26 FD 6E 00      [19]  385 	ld	l,0 (iy)
   2C29 C9            [10]  386 	ret
                            387 ;src/UI_GameMenu.c:161: u8 ui_gamemenu_is_selected(){
                            388 ;	---------------------------------
                            389 ; Function ui_gamemenu_is_selected
                            390 ; ---------------------------------
   2C2A                     391 _ui_gamemenu_is_selected::
                            392 ;src/UI_GameMenu.c:162: return ui_gamemenu_entrySelected;
   2C2A FD 21 2F 5B   [14]  393 	ld	iy,#_ui_gamemenu_entrySelected
   2C2E FD 6E 00      [19]  394 	ld	l,0 (iy)
   2C31 C9            [10]  395 	ret
                            396 ;src/UI_GameMenu.c:165: void ui_gamemenu_update_action(){
                            397 ;	---------------------------------
                            398 ; Function ui_gamemenu_update_action
                            399 ; ---------------------------------
   2C32                     400 _ui_gamemenu_update_action::
                            401 ;src/UI_GameMenu.c:166: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
   2C32 21 5A 0E      [10]  402 	ld	hl,#_player_position+0
   2C35 4E            [ 7]  403 	ld	c,(hl)
   2C36 06 00         [ 7]  404 	ld	b,#0x00
   2C38 3A 5C 0E      [13]  405 	ld	a, (#_player_direction + 0)
   2C3B 6F            [ 4]  406 	ld	l,a
   2C3C 17            [ 4]  407 	rla
   2C3D 9F            [ 4]  408 	sbc	a, a
   2C3E 67            [ 4]  409 	ld	h,a
   2C3F 09            [11]  410 	add	hl,bc
   2C40 01 00 70      [10]  411 	ld	bc,#0x7000
   2C43 09            [11]  412 	add	hl,bc
   2C44 4D            [ 4]  413 	ld	c,l
   2C45 44            [ 4]  414 	ld	b,h
   2C46 21 5B 0E      [10]  415 	ld	hl,#_player_position+1
   2C49 5E            [ 7]  416 	ld	e,(hl)
   2C4A 16 00         [ 7]  417 	ld	d,#0x00
   2C4C 3A 5D 0E      [13]  418 	ld	a, (#(_player_direction + 0x0001) + 0)
   2C4F 6F            [ 4]  419 	ld	l,a
   2C50 17            [ 4]  420 	rla
   2C51 9F            [ 4]  421 	sbc	a, a
   2C52 67            [ 4]  422 	ld	h,a
   2C53 19            [11]  423 	add	hl,de
   2C54 29            [11]  424 	add	hl, hl
   2C55 29            [11]  425 	add	hl, hl
   2C56 29            [11]  426 	add	hl, hl
   2C57 29            [11]  427 	add	hl, hl
   2C58 29            [11]  428 	add	hl, hl
   2C59 09            [11]  429 	add	hl,bc
   2C5A 4E            [ 7]  430 	ld	c,(hl)
                            431 ;src/UI_GameMenu.c:169: ui_gamemenu_can_move=0;
   2C5B 21 30 5B      [10]  432 	ld	hl,#_ui_gamemenu_can_move + 0
   2C5E 36 00         [10]  433 	ld	(hl), #0x00
                            434 ;src/UI_GameMenu.c:170: *((char**)(ui_gamemenu_buttonText)+3)="";
   2C60 21 CC 2C      [10]  435 	ld	hl,#___str_9
   2C63 22 D1 2A      [16]  436 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
                            437 ;src/UI_GameMenu.c:172: ui_gamemenu_action=0;
   2C66 FD 21 31 5B   [14]  438 	ld	iy,#_ui_gamemenu_action
   2C6A FD 36 00 00   [19]  439 	ld	0 (iy),#0x00
                            440 ;src/UI_GameMenu.c:173: *((char**)ui_gamemenu_buttonText)="";
   2C6E 22 CB 2A      [16]  441 	ld	(_ui_gamemenu_buttonText), hl
                            442 ;src/UI_GameMenu.c:175: if(forward&CELL_WALL_MASK){
   2C71 CB 79         [ 8]  443 	bit	7, c
   2C73 28 14         [12]  444 	jr	Z,00110$
                            445 ;src/UI_GameMenu.c:176: if(forward==CELLTYPE_DOOR){
   2C75 79            [ 4]  446 	ld	a,c
   2C76 D6 80         [ 7]  447 	sub	a, #0x80
   2C78 20 42         [12]  448 	jr	NZ,00111$
                            449 ;src/UI_GameMenu.c:177: ui_gamemenu_action=1;
   2C7A 21 31 5B      [10]  450 	ld	hl,#_ui_gamemenu_action + 0
   2C7D 36 01         [10]  451 	ld	(hl), #0x01
                            452 ;src/UI_GameMenu.c:178: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[0];
   2C7F ED 4B C5 2A   [20]  453 	ld	bc, (#_ui_gamemenu_action_buttonText + 0)
   2C83 ED 43 CB 2A   [20]  454 	ld	(_ui_gamemenu_buttonText), bc
   2C87 18 33         [12]  455 	jr	00111$
   2C89                     456 00110$:
                            457 ;src/UI_GameMenu.c:181: else if(forward&CELL_ENEMY_MASK){
   2C89 79            [ 4]  458 	ld	a,c
   2C8A E6 0F         [ 7]  459 	and	a, #0x0F
   2C8C 28 0F         [12]  460 	jr	Z,00107$
                            461 ;src/UI_GameMenu.c:182: ui_gamemenu_action=2;
   2C8E 21 31 5B      [10]  462 	ld	hl,#_ui_gamemenu_action + 0
   2C91 36 02         [10]  463 	ld	(hl), #0x02
                            464 ;src/UI_GameMenu.c:183: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[1];
   2C93 ED 4B C7 2A   [20]  465 	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0002) + 0)
   2C97 ED 43 CB 2A   [20]  466 	ld	(_ui_gamemenu_buttonText), bc
   2C9B 18 1F         [12]  467 	jr	00111$
   2C9D                     468 00107$:
                            469 ;src/UI_GameMenu.c:185: else if(forward&CELL_ITEM_MASK){
   2C9D 79            [ 4]  470 	ld	a,c
   2C9E E6 70         [ 7]  471 	and	a, #0x70
   2CA0 28 0F         [12]  472 	jr	Z,00104$
                            473 ;src/UI_GameMenu.c:186: ui_gamemenu_action=3;
   2CA2 21 31 5B      [10]  474 	ld	hl,#_ui_gamemenu_action + 0
   2CA5 36 03         [10]  475 	ld	(hl), #0x03
                            476 ;src/UI_GameMenu.c:187: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[2];
   2CA7 ED 4B C9 2A   [20]  477 	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0004) + 0)
   2CAB ED 43 CB 2A   [20]  478 	ld	(_ui_gamemenu_buttonText), bc
   2CAF 18 0B         [12]  479 	jr	00111$
   2CB1                     480 00104$:
                            481 ;src/UI_GameMenu.c:190: ui_gamemenu_can_move=1;
   2CB1 21 30 5B      [10]  482 	ld	hl,#_ui_gamemenu_can_move + 0
   2CB4 36 01         [10]  483 	ld	(hl), #0x01
                            484 ;src/UI_GameMenu.c:191: *(char**)(ui_gamemenu_buttonText+3)="MOVE";
   2CB6 21 CD 2C      [10]  485 	ld	hl,#___str_10
   2CB9 22 D1 2A      [16]  486 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
   2CBC                     487 00111$:
                            488 ;src/UI_GameMenu.c:193: ui_gamemenu_render_button(0);
   2CBC AF            [ 4]  489 	xor	a, a
   2CBD F5            [11]  490 	push	af
   2CBE 33            [ 6]  491 	inc	sp
   2CBF CD 7A 2B      [17]  492 	call	_ui_gamemenu_render_button
   2CC2 33            [ 6]  493 	inc	sp
                            494 ;src/UI_GameMenu.c:194: ui_gamemenu_render_button(3);
   2CC3 3E 03         [ 7]  495 	ld	a,#0x03
   2CC5 F5            [11]  496 	push	af
   2CC6 33            [ 6]  497 	inc	sp
   2CC7 CD 7A 2B      [17]  498 	call	_ui_gamemenu_render_button
   2CCA 33            [ 6]  499 	inc	sp
   2CCB C9            [10]  500 	ret
   2CCC                     501 ___str_9:
   2CCC 00                  502 	.db 0x00
   2CCD                     503 ___str_10:
   2CCD 4D 4F 56 45         504 	.ascii "MOVE"
   2CD1 00                  505 	.db 0x00
                            506 ;src/UI_GameMenu.c:197: u8 ui_gamemenu_get_movement(){
                            507 ;	---------------------------------
                            508 ; Function ui_gamemenu_get_movement
                            509 ; ---------------------------------
   2CD2                     510 _ui_gamemenu_get_movement::
                            511 ;src/UI_GameMenu.c:198: return ui_gamemenu_can_move;
   2CD2 FD 21 30 5B   [14]  512 	ld	iy,#_ui_gamemenu_can_move
   2CD6 FD 6E 00      [19]  513 	ld	l,0 (iy)
   2CD9 C9            [10]  514 	ret
                            515 ;src/UI_GameMenu.c:201: u8 ui_gamemenu_get_action(){
                            516 ;	---------------------------------
                            517 ; Function ui_gamemenu_get_action
                            518 ; ---------------------------------
   2CDA                     519 _ui_gamemenu_get_action::
                            520 ;src/UI_GameMenu.c:202: return ui_gamemenu_action;
   2CDA FD 21 31 5B   [14]  521 	ld	iy,#_ui_gamemenu_action
   2CDE FD 6E 00      [19]  522 	ld	l,0 (iy)
   2CE1 C9            [10]  523 	ret
                            524 	.area _CODE
                            525 	.area _INITIALIZER
                            526 	.area _CABS (ABS)
