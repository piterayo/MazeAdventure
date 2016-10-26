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
                             12 	.globl _integer_to_string
                             13 	.globl _print_transparent_text
                             14 	.globl _cpct_drawSolidBox
                             15 	.globl _ui_gamemenu_action
                             16 	.globl _ui_gamemenu_can_move
                             17 	.globl _ui_gamemenu_entrySelected
                             18 	.globl _ui_gamemenu_entryIndex
                             19 	.globl _ui_gamemenu_lastEntry
                             20 	.globl _ui_gamemenu_buttonWidths
                             21 	.globl _ui_gamemenu_buttonText
                             22 	.globl _ui_gamemenu_action_buttonText
                             23 	.globl _ui_gamemenu_entriesTextPosition
                             24 	.globl _ui_gamemenu_entriesPosition
                             25 	.globl _ui_gamemenu_init
                             26 	.globl _ui_gamemenu_above_entry
                             27 	.globl _ui_gamemenu_below_entry
                             28 	.globl _ui_gamemenu_next_entry
                             29 	.globl _ui_gamemenu_previous_entry
                             30 	.globl _ui_gamemenu_unselect_entry
                             31 	.globl _ui_gamemenu_select_entry
                             32 	.globl _ui_gamemenu_render_refresh
                             33 	.globl _ui_gamemenu_render_all
                             34 	.globl _ui_gamemenu_get_entry
                             35 	.globl _ui_gamemenu_is_selected
                             36 	.globl _ui_gamemenu_update_action
                             37 	.globl _ui_gamemenu_get_movement
                             38 	.globl _ui_gamemenu_get_action
                             39 ;--------------------------------------------------------
                             40 ; special function registers
                             41 ;--------------------------------------------------------
                             42 ;--------------------------------------------------------
                             43 ; ram data
                             44 ;--------------------------------------------------------
                             45 	.area _DATA
   7DC8                      46 _ui_gamemenu_lastEntry::
   7DC8                      47 	.ds 1
   7DC9                      48 _ui_gamemenu_entryIndex::
   7DC9                      49 	.ds 1
   7DCA                      50 _ui_gamemenu_entrySelected::
   7DCA                      51 	.ds 1
   7DCB                      52 _ui_gamemenu_can_move::
   7DCB                      53 	.ds 1
   7DCC                      54 _ui_gamemenu_action::
   7DCC                      55 	.ds 1
                             56 ;--------------------------------------------------------
                             57 ; ram data
                             58 ;--------------------------------------------------------
                             59 	.area _INITIALIZED
                             60 ;--------------------------------------------------------
                             61 ; absolute external ram data
                             62 ;--------------------------------------------------------
                             63 	.area _DABS (ABS)
                             64 ;--------------------------------------------------------
                             65 ; global & static initialisations
                             66 ;--------------------------------------------------------
                             67 	.area _HOME
                             68 	.area _GSINIT
                             69 	.area _GSFINAL
                             70 	.area _GSINIT
                             71 ;--------------------------------------------------------
                             72 ; Home
                             73 ;--------------------------------------------------------
                             74 	.area _HOME
                             75 	.area _HOME
                             76 ;--------------------------------------------------------
                             77 ; code
                             78 ;--------------------------------------------------------
                             79 	.area _CODE
                             80 ;src/UI_GameMenu.c:77: void ui_gamemenu_init(){
                             81 ;	---------------------------------
                             82 ; Function ui_gamemenu_init
                             83 ; ---------------------------------
   4278                      84 _ui_gamemenu_init::
                             85 ;src/UI_GameMenu.c:78: ui_gamemenu_lastEntry=0;
   4278 21 C8 7D      [10]   86 	ld	hl,#_ui_gamemenu_lastEntry + 0
   427B 36 00         [10]   87 	ld	(hl), #0x00
                             88 ;src/UI_GameMenu.c:79: ui_gamemenu_entryIndex=0;
   427D 21 C9 7D      [10]   89 	ld	hl,#_ui_gamemenu_entryIndex + 0
   4280 36 00         [10]   90 	ld	(hl), #0x00
                             91 ;src/UI_GameMenu.c:80: ui_gamemenu_entrySelected=0;
   4282 21 CA 7D      [10]   92 	ld	hl,#_ui_gamemenu_entrySelected + 0
   4285 36 00         [10]   93 	ld	(hl), #0x00
                             94 ;src/UI_GameMenu.c:81: ui_gamemenu_update_action();
   4287 C3 59 44      [10]   95 	jp  _ui_gamemenu_update_action
   428A                      96 _ui_gamemenu_entriesPosition:
   428A 50 C5                97 	.dw #0xC550
   428C 84 C5                98 	.dw #0xC584
   428E E0 C6                99 	.dw #0xC6E0
   4290 E7 C6               100 	.dw #0xC6E7
   4292 F6 C6               101 	.dw #0xC6F6
   4294 14 C7               102 	.dw #0xC714
   4296 23 C7               103 	.dw #0xC723
   4298                     104 _ui_gamemenu_entriesTextPosition:
   4298 A4 CD               105 	.dw #0xCDA4
   429A D9 CD               106 	.dw #0xCDD9
   429C 32 CF               107 	.dw #0xCF32
   429E 3A CF               108 	.dw #0xCF3A
   42A0 48 CF               109 	.dw #0xCF48
   42A2 67 CF               110 	.dw #0xCF67
   42A4 75 CF               111 	.dw #0xCF75
   42A6                     112 _ui_gamemenu_action_buttonText:
   42A6 C1 42               113 	.dw __str_0
   42A8 CC 42               114 	.dw __str_1
   42AA D5 42               115 	.dw __str_2
   42AC                     116 _ui_gamemenu_buttonText:
   42AC DF 42               117 	.dw __str_3
   42AE E0 42               118 	.dw __str_4
   42B0 EA 42               119 	.dw __str_5
   42B2 DF 42               120 	.dw __str_3
   42B4 EC 42               121 	.dw __str_6
   42B6 EE 42               122 	.dw __str_7
   42B8 F3 42               123 	.dw __str_8
   42BA                     124 _ui_gamemenu_buttonWidths:
   42BA 1C                  125 	.db #0x1C	; 28
   42BB 1C                  126 	.db #0x1C	; 28
   42BC 06                  127 	.db #0x06	; 6
   42BD 0E                  128 	.db #0x0E	; 14
   42BE 06                  129 	.db #0x06	; 6
   42BF 0D                  130 	.db #0x0D	; 13
   42C0 0D                  131 	.db #0x0D	; 13
   42C1                     132 __str_0:
   42C1 4E 45 58 54 20 4C   133 	.ascii "NEXT LEVEL"
        45 56 45 4C
   42CB 00                  134 	.db 0x00
   42CC                     135 __str_1:
   42CC 20 20 41 54 54 41   136 	.ascii "  ATTACK"
        43 4B
   42D4 00                  137 	.db 0x00
   42D5                     138 __str_2:
   42D5 20 20 50 49 43 4B   139 	.ascii "  PICK UP"
        20 55 50
   42DE 00                  140 	.db 0x00
   42DF                     141 __str_3:
   42DF 00                  142 	.db 0x00
   42E0                     143 __str_4:
   42E0 49 4E 56 45 4E 54   144 	.ascii "INVENTORY"
        4F 52 59
   42E9 00                  145 	.db 0x00
   42EA                     146 __str_5:
   42EA 3C                  147 	.ascii "<"
   42EB 00                  148 	.db 0x00
   42EC                     149 __str_6:
   42EC 3E                  150 	.ascii ">"
   42ED 00                  151 	.db 0x00
   42EE                     152 __str_7:
   42EE 57 41 49 54         153 	.ascii "WAIT"
   42F2 00                  154 	.db 0x00
   42F3                     155 __str_8:
   42F3 50 41 55 53 45      156 	.ascii "PAUSE"
   42F8 00                  157 	.db 0x00
                            158 ;src/UI_GameMenu.c:84: void ui_gamemenu_above_entry(){
                            159 ;	---------------------------------
                            160 ; Function ui_gamemenu_above_entry
                            161 ; ---------------------------------
   42F9                     162 _ui_gamemenu_above_entry::
                            163 ;src/UI_GameMenu.c:85: if(ui_gamemenu_entryIndex>=2 && ui_gamemenu_entryIndex<5){
   42F9 3A C9 7D      [13]  164 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   42FC FE 02         [ 7]  165 	cp	a,#0x02
   42FE 38 0A         [12]  166 	jr	C,00105$
   4300 D6 05         [ 7]  167 	sub	a, #0x05
   4302 30 06         [12]  168 	jr	NC,00105$
                            169 ;src/UI_GameMenu.c:86: ui_gamemenu_entryIndex=0;
   4304 21 C9 7D      [10]  170 	ld	hl,#_ui_gamemenu_entryIndex + 0
   4307 36 00         [10]  171 	ld	(hl), #0x00
   4309 C9            [10]  172 	ret
   430A                     173 00105$:
                            174 ;src/UI_GameMenu.c:88: else if(ui_gamemenu_entryIndex==5 || ui_gamemenu_entryIndex == 6){
   430A 3A C9 7D      [13]  175 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   430D FE 05         [ 7]  176 	cp	a,#0x05
   430F 28 03         [12]  177 	jr	Z,00101$
   4311 D6 06         [ 7]  178 	sub	a, #0x06
   4313 C0            [11]  179 	ret	NZ
   4314                     180 00101$:
                            181 ;src/UI_GameMenu.c:89: ui_gamemenu_entryIndex=1;
   4314 21 C9 7D      [10]  182 	ld	hl,#_ui_gamemenu_entryIndex + 0
   4317 36 01         [10]  183 	ld	(hl), #0x01
   4319 C9            [10]  184 	ret
                            185 ;src/UI_GameMenu.c:93: void ui_gamemenu_below_entry(){
                            186 ;	---------------------------------
                            187 ; Function ui_gamemenu_below_entry
                            188 ; ---------------------------------
   431A                     189 _ui_gamemenu_below_entry::
                            190 ;src/UI_GameMenu.c:94: if(ui_gamemenu_entryIndex==0){
   431A 3A C9 7D      [13]  191 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   431D B7            [ 4]  192 	or	a, a
   431E 20 06         [12]  193 	jr	NZ,00104$
                            194 ;src/UI_GameMenu.c:95: ui_gamemenu_entryIndex=3;
   4320 21 C9 7D      [10]  195 	ld	hl,#_ui_gamemenu_entryIndex + 0
   4323 36 03         [10]  196 	ld	(hl), #0x03
   4325 C9            [10]  197 	ret
   4326                     198 00104$:
                            199 ;src/UI_GameMenu.c:97: else if(ui_gamemenu_entryIndex==1){
   4326 3A C9 7D      [13]  200 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4329 3D            [ 4]  201 	dec	a
   432A C0            [11]  202 	ret	NZ
                            203 ;src/UI_GameMenu.c:98: ui_gamemenu_entryIndex=5;
   432B 21 C9 7D      [10]  204 	ld	hl,#_ui_gamemenu_entryIndex + 0
   432E 36 05         [10]  205 	ld	(hl), #0x05
   4330 C9            [10]  206 	ret
                            207 ;src/UI_GameMenu.c:102: void ui_gamemenu_next_entry(){
                            208 ;	---------------------------------
                            209 ; Function ui_gamemenu_next_entry
                            210 ; ---------------------------------
   4331                     211 _ui_gamemenu_next_entry::
                            212 ;src/UI_GameMenu.c:103: if(ui_gamemenu_entryIndex<(UI_GAMEMENU_ENTRIES-1) && ui_gamemenu_entryIndex!=1){
   4331 3A C9 7D      [13]  213 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4334 FE 06         [ 7]  214 	cp	a,#0x06
   4336 D0            [11]  215 	ret	NC
   4337 3D            [ 4]  216 	dec	a
   4338 C8            [11]  217 	ret	Z
                            218 ;src/UI_GameMenu.c:104: ++ui_gamemenu_entryIndex;
   4339 21 C9 7D      [10]  219 	ld	hl, #_ui_gamemenu_entryIndex+0
   433C 34            [11]  220 	inc	(hl)
   433D C9            [10]  221 	ret
                            222 ;src/UI_GameMenu.c:108: void ui_gamemenu_previous_entry(){
                            223 ;	---------------------------------
                            224 ; Function ui_gamemenu_previous_entry
                            225 ; ---------------------------------
   433E                     226 _ui_gamemenu_previous_entry::
                            227 ;src/UI_GameMenu.c:109: if(ui_gamemenu_entryIndex>0 && ui_gamemenu_entryIndex!=2){
   433E 3A C9 7D      [13]  228 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4341 B7            [ 4]  229 	or	a, a
   4342 C8            [11]  230 	ret	Z
   4343 3A C9 7D      [13]  231 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   4346 D6 02         [ 7]  232 	sub	a, #0x02
   4348 C8            [11]  233 	ret	Z
                            234 ;src/UI_GameMenu.c:110: --ui_gamemenu_entryIndex;
   4349 21 C9 7D      [10]  235 	ld	hl, #_ui_gamemenu_entryIndex+0
   434C 35            [11]  236 	dec	(hl)
   434D C9            [10]  237 	ret
                            238 ;src/UI_GameMenu.c:114: void ui_gamemenu_unselect_entry(){
                            239 ;	---------------------------------
                            240 ; Function ui_gamemenu_unselect_entry
                            241 ; ---------------------------------
   434E                     242 _ui_gamemenu_unselect_entry::
                            243 ;src/UI_GameMenu.c:115: ui_gamemenu_entrySelected=0;
   434E 21 CA 7D      [10]  244 	ld	hl,#_ui_gamemenu_entrySelected + 0
   4351 36 00         [10]  245 	ld	(hl), #0x00
   4353 C9            [10]  246 	ret
                            247 ;src/UI_GameMenu.c:118: void ui_gamemenu_select_entry(){
                            248 ;	---------------------------------
                            249 ; Function ui_gamemenu_select_entry
                            250 ; ---------------------------------
   4354                     251 _ui_gamemenu_select_entry::
                            252 ;src/UI_GameMenu.c:119: ui_gamemenu_entrySelected=1;
   4354 21 CA 7D      [10]  253 	ld	hl,#_ui_gamemenu_entrySelected + 0
   4357 36 01         [10]  254 	ld	(hl), #0x01
   4359 C9            [10]  255 	ret
                            256 ;src/UI_GameMenu.c:122: void ui_gamemenu_render_button(u8 n){
                            257 ;	---------------------------------
                            258 ; Function ui_gamemenu_render_button
                            259 ; ---------------------------------
   435A                     260 _ui_gamemenu_render_button::
   435A DD E5         [15]  261 	push	ix
   435C DD 21 00 00   [14]  262 	ld	ix,#0
   4360 DD 39         [15]  263 	add	ix,sp
   4362 F5            [11]  264 	push	af
                            265 ;src/UI_GameMenu.c:124: color = (n==ui_gamemenu_entryIndex)?((ui_gamemenu_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
   4363 DD 7E 04      [19]  266 	ld	a,4 (ix)
   4366 FD 21 C9 7D   [14]  267 	ld	iy,#_ui_gamemenu_entryIndex
   436A FD 96 00      [19]  268 	sub	a, 0 (iy)
   436D 20 10         [12]  269 	jr	NZ,00103$
   436F 3A CA 7D      [13]  270 	ld	a,(#_ui_gamemenu_entrySelected + 0)
   4372 B7            [ 4]  271 	or	a, a
   4373 28 05         [12]  272 	jr	Z,00105$
   4375 3A B3 1A      [13]  273 	ld	a, (#(_g_colors + 0x0004) + 0)
   4378 18 08         [12]  274 	jr	00104$
   437A                     275 00105$:
   437A 3A B5 1A      [13]  276 	ld	a, (#(_g_colors + 0x0006) + 0)
   437D 18 03         [12]  277 	jr	00104$
   437F                     278 00103$:
   437F 3A B1 1A      [13]  279 	ld	a, (#(_g_colors + 0x0002) + 0)
   4382                     280 00104$:
   4382 4F            [ 4]  281 	ld	c,a
                            282 ;src/UI_GameMenu.c:125: cpct_drawSolidBox(ui_gamemenu_entriesPosition[n],color, ui_gamemenu_buttonWidths[n], UI_GAMEMENU_BUTTON_HEIGHT);
   4383 11 BA 42      [10]  283 	ld	de,#_ui_gamemenu_buttonWidths+0
   4386 DD 6E 04      [19]  284 	ld	l,4 (ix)
   4389 26 00         [ 7]  285 	ld	h,#0x00
   438B 19            [11]  286 	add	hl,de
   438C 46            [ 7]  287 	ld	b,(hl)
   438D DD 6E 04      [19]  288 	ld	l,4 (ix)
   4390 26 00         [ 7]  289 	ld	h,#0x00
   4392 29            [11]  290 	add	hl, hl
   4393 EB            [ 4]  291 	ex	de,hl
   4394 21 8A 42      [10]  292 	ld	hl,#_ui_gamemenu_entriesPosition
   4397 19            [11]  293 	add	hl,de
   4398 7E            [ 7]  294 	ld	a,(hl)
   4399 DD 77 FE      [19]  295 	ld	-2 (ix),a
   439C 23            [ 6]  296 	inc	hl
   439D 7E            [ 7]  297 	ld	a,(hl)
   439E DD 77 FF      [19]  298 	ld	-1 (ix),a
   43A1 D5            [11]  299 	push	de
   43A2 3E 18         [ 7]  300 	ld	a,#0x18
   43A4 F5            [11]  301 	push	af
   43A5 33            [ 6]  302 	inc	sp
   43A6 C5            [11]  303 	push	bc
   43A7 DD 6E FE      [19]  304 	ld	l,-2 (ix)
   43AA DD 66 FF      [19]  305 	ld	h,-1 (ix)
   43AD E5            [11]  306 	push	hl
   43AE CD B8 7B      [17]  307 	call	_cpct_drawSolidBox
   43B1 F1            [10]  308 	pop	af
   43B2 F1            [10]  309 	pop	af
   43B3 33            [ 6]  310 	inc	sp
   43B4 D1            [10]  311 	pop	de
                            312 ;src/UI_GameMenu.c:126: print_transparent_text(ui_gamemenu_buttonText[n], ui_gamemenu_entriesTextPosition[n], 3);
   43B5 21 98 42      [10]  313 	ld	hl,#_ui_gamemenu_entriesTextPosition
   43B8 19            [11]  314 	add	hl,de
   43B9 4E            [ 7]  315 	ld	c,(hl)
   43BA 23            [ 6]  316 	inc	hl
   43BB 46            [ 7]  317 	ld	b,(hl)
   43BC 21 AC 42      [10]  318 	ld	hl,#_ui_gamemenu_buttonText
   43BF 19            [11]  319 	add	hl,de
   43C0 5E            [ 7]  320 	ld	e,(hl)
   43C1 23            [ 6]  321 	inc	hl
   43C2 56            [ 7]  322 	ld	d,(hl)
   43C3 3E 03         [ 7]  323 	ld	a,#0x03
   43C5 F5            [11]  324 	push	af
   43C6 33            [ 6]  325 	inc	sp
   43C7 C5            [11]  326 	push	bc
   43C8 D5            [11]  327 	push	de
   43C9 CD C6 3F      [17]  328 	call	_print_transparent_text
   43CC DD F9         [10]  329 	ld	sp,ix
   43CE DD E1         [14]  330 	pop	ix
   43D0 C9            [10]  331 	ret
                            332 ;src/UI_GameMenu.c:138: void ui_gamemenu_render_refresh(){
                            333 ;	---------------------------------
                            334 ; Function ui_gamemenu_render_refresh
                            335 ; ---------------------------------
   43D1                     336 _ui_gamemenu_render_refresh::
                            337 ;src/UI_GameMenu.c:140: ui_gamemenu_render_button(ui_gamemenu_entryIndex);
   43D1 3A C9 7D      [13]  338 	ld	a,(_ui_gamemenu_entryIndex)
   43D4 F5            [11]  339 	push	af
   43D5 33            [ 6]  340 	inc	sp
   43D6 CD 5A 43      [17]  341 	call	_ui_gamemenu_render_button
   43D9 33            [ 6]  342 	inc	sp
                            343 ;src/UI_GameMenu.c:141: ui_gamemenu_render_button(ui_gamemenu_lastEntry);
   43DA 3A C8 7D      [13]  344 	ld	a,(_ui_gamemenu_lastEntry)
   43DD F5            [11]  345 	push	af
   43DE 33            [ 6]  346 	inc	sp
   43DF CD 5A 43      [17]  347 	call	_ui_gamemenu_render_button
   43E2 33            [ 6]  348 	inc	sp
                            349 ;src/UI_GameMenu.c:143: ui_gamemenu_render_button(0);
   43E3 AF            [ 4]  350 	xor	a, a
   43E4 F5            [11]  351 	push	af
   43E5 33            [ 6]  352 	inc	sp
   43E6 CD 5A 43      [17]  353 	call	_ui_gamemenu_render_button
   43E9 33            [ 6]  354 	inc	sp
                            355 ;src/UI_GameMenu.c:144: ui_gamemenu_render_button(3);
   43EA 3E 03         [ 7]  356 	ld	a,#0x03
   43EC F5            [11]  357 	push	af
   43ED 33            [ 6]  358 	inc	sp
   43EE CD 5A 43      [17]  359 	call	_ui_gamemenu_render_button
   43F1 33            [ 6]  360 	inc	sp
                            361 ;src/UI_GameMenu.c:147: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   43F2 3A C9 7D      [13]  362 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   43F5 32 C8 7D      [13]  363 	ld	(#_ui_gamemenu_lastEntry + 0),a
   43F8 C9            [10]  364 	ret
                            365 ;src/UI_GameMenu.c:151: void ui_gamemenu_render_all(){
                            366 ;	---------------------------------
                            367 ; Function ui_gamemenu_render_all
                            368 ; ---------------------------------
   43F9                     369 _ui_gamemenu_render_all::
                            370 ;src/UI_GameMenu.c:154: print_transparent_text("LEVEL ",UI_GAMEMENU_LEVEL_TEXT_POSITION, 3);
   43F9 3E 03         [ 7]  371 	ld	a,#0x03
   43FB F5            [11]  372 	push	af
   43FC 33            [ 6]  373 	inc	sp
   43FD 21 00 C0      [10]  374 	ld	hl,#0xC000
   4400 E5            [11]  375 	push	hl
   4401 21 42 44      [10]  376 	ld	hl,#___str_9
   4404 E5            [11]  377 	push	hl
   4405 CD C6 3F      [17]  378 	call	_print_transparent_text
   4408 F1            [10]  379 	pop	af
   4409 F1            [10]  380 	pop	af
   440A 33            [ 6]  381 	inc	sp
                            382 ;src/UI_GameMenu.c:155: print_transparent_text(integer_to_string(level_get_level(),'d'),UI_GAMEMENU_LEVEL_NUMBER_POSITION, 3);
   440B CD F0 0F      [17]  383 	call	_level_get_level
   440E 45            [ 4]  384 	ld	b,l
   440F 3E 64         [ 7]  385 	ld	a,#0x64
   4411 F5            [11]  386 	push	af
   4412 33            [ 6]  387 	inc	sp
   4413 C5            [11]  388 	push	bc
   4414 33            [ 6]  389 	inc	sp
   4415 CD 84 3C      [17]  390 	call	_integer_to_string
   4418 F1            [10]  391 	pop	af
   4419 4D            [ 4]  392 	ld	c,l
   441A 44            [ 4]  393 	ld	b,h
   441B 3E 03         [ 7]  394 	ld	a,#0x03
   441D F5            [11]  395 	push	af
   441E 33            [ 6]  396 	inc	sp
   441F 21 0C C0      [10]  397 	ld	hl,#0xC00C
   4422 E5            [11]  398 	push	hl
   4423 C5            [11]  399 	push	bc
   4424 CD C6 3F      [17]  400 	call	_print_transparent_text
   4427 F1            [10]  401 	pop	af
   4428 F1            [10]  402 	pop	af
   4429 33            [ 6]  403 	inc	sp
                            404 ;src/UI_GameMenu.c:157: while(n){
   442A 06 07         [ 7]  405 	ld	b,#0x07
   442C                     406 00101$:
   442C 78            [ 4]  407 	ld	a,b
   442D B7            [ 4]  408 	or	a, a
   442E 28 0B         [12]  409 	jr	Z,00103$
                            410 ;src/UI_GameMenu.c:158: --n;
   4430 05            [ 4]  411 	dec	b
                            412 ;src/UI_GameMenu.c:159: ui_gamemenu_render_button(n);
   4431 C5            [11]  413 	push	bc
   4432 C5            [11]  414 	push	bc
   4433 33            [ 6]  415 	inc	sp
   4434 CD 5A 43      [17]  416 	call	_ui_gamemenu_render_button
   4437 33            [ 6]  417 	inc	sp
   4438 C1            [10]  418 	pop	bc
   4439 18 F1         [12]  419 	jr	00101$
   443B                     420 00103$:
                            421 ;src/UI_GameMenu.c:162: ui_gamemenu_lastEntry=ui_gamemenu_entryIndex;
   443B 3A C9 7D      [13]  422 	ld	a,(#_ui_gamemenu_entryIndex + 0)
   443E 32 C8 7D      [13]  423 	ld	(#_ui_gamemenu_lastEntry + 0),a
   4441 C9            [10]  424 	ret
   4442                     425 ___str_9:
   4442 4C 45 56 45 4C 20   426 	.ascii "LEVEL "
   4448 00                  427 	.db 0x00
                            428 ;src/UI_GameMenu.c:165: u8 ui_gamemenu_get_entry(){
                            429 ;	---------------------------------
                            430 ; Function ui_gamemenu_get_entry
                            431 ; ---------------------------------
   4449                     432 _ui_gamemenu_get_entry::
                            433 ;src/UI_GameMenu.c:166: return ui_gamemenu_entryIndex;
   4449 FD 21 C9 7D   [14]  434 	ld	iy,#_ui_gamemenu_entryIndex
   444D FD 6E 00      [19]  435 	ld	l,0 (iy)
   4450 C9            [10]  436 	ret
                            437 ;src/UI_GameMenu.c:169: u8 ui_gamemenu_is_selected(){
                            438 ;	---------------------------------
                            439 ; Function ui_gamemenu_is_selected
                            440 ; ---------------------------------
   4451                     441 _ui_gamemenu_is_selected::
                            442 ;src/UI_GameMenu.c:170: return ui_gamemenu_entrySelected;
   4451 FD 21 CA 7D   [14]  443 	ld	iy,#_ui_gamemenu_entrySelected
   4455 FD 6E 00      [19]  444 	ld	l,0 (iy)
   4458 C9            [10]  445 	ret
                            446 ;src/UI_GameMenu.c:173: void ui_gamemenu_update_action(){
                            447 ;	---------------------------------
                            448 ; Function ui_gamemenu_update_action
                            449 ; ---------------------------------
   4459                     450 _ui_gamemenu_update_action::
                            451 ;src/UI_GameMenu.c:174: u8 forward = *(u8*)(MAP_MEM + (player_position.x+player_direction.x) + (player_position.y+player_direction.y) * MAP_WIDTH);
   4459 21 75 18      [10]  452 	ld	hl,#_player_position+0
   445C 4E            [ 7]  453 	ld	c,(hl)
   445D 06 00         [ 7]  454 	ld	b,#0x00
   445F 3A 77 18      [13]  455 	ld	a, (#_player_direction + 0)
   4462 6F            [ 4]  456 	ld	l,a
   4463 17            [ 4]  457 	rla
   4464 9F            [ 4]  458 	sbc	a, a
   4465 67            [ 4]  459 	ld	h,a
   4466 09            [11]  460 	add	hl,bc
   4467 01 D0 88      [10]  461 	ld	bc,#0x88D0
   446A 09            [11]  462 	add	hl,bc
   446B 4D            [ 4]  463 	ld	c,l
   446C 44            [ 4]  464 	ld	b,h
   446D 21 76 18      [10]  465 	ld	hl,#_player_position+1
   4470 5E            [ 7]  466 	ld	e,(hl)
   4471 16 00         [ 7]  467 	ld	d,#0x00
   4473 3A 78 18      [13]  468 	ld	a, (#(_player_direction + 0x0001) + 0)
   4476 6F            [ 4]  469 	ld	l,a
   4477 17            [ 4]  470 	rla
   4478 9F            [ 4]  471 	sbc	a, a
   4479 67            [ 4]  472 	ld	h,a
   447A 19            [11]  473 	add	hl,de
   447B 29            [11]  474 	add	hl, hl
   447C 29            [11]  475 	add	hl, hl
   447D 29            [11]  476 	add	hl, hl
   447E 29            [11]  477 	add	hl, hl
   447F 29            [11]  478 	add	hl, hl
   4480 09            [11]  479 	add	hl,bc
   4481 4E            [ 7]  480 	ld	c,(hl)
                            481 ;src/UI_GameMenu.c:177: ui_gamemenu_can_move=0;
   4482 21 CB 7D      [10]  482 	ld	hl,#_ui_gamemenu_can_move + 0
   4485 36 00         [10]  483 	ld	(hl), #0x00
                            484 ;src/UI_GameMenu.c:178: *((char**)(ui_gamemenu_buttonText)+3)="";
   4487 21 E4 44      [10]  485 	ld	hl,#___str_10
   448A 22 B2 42      [16]  486 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
                            487 ;src/UI_GameMenu.c:180: ui_gamemenu_action=0;
   448D FD 21 CC 7D   [14]  488 	ld	iy,#_ui_gamemenu_action
   4491 FD 36 00 00   [19]  489 	ld	0 (iy),#0x00
                            490 ;src/UI_GameMenu.c:181: *((char**)ui_gamemenu_buttonText)="";
   4495 22 AC 42      [16]  491 	ld	(_ui_gamemenu_buttonText), hl
                            492 ;src/UI_GameMenu.c:183: if(forward&CELL_ITEM_MASK){
   4498 79            [ 4]  493 	ld	a,c
   4499 E6 70         [ 7]  494 	and	a, #0x70
   449B 28 0D         [12]  495 	jr	Z,00102$
                            496 ;src/UI_GameMenu.c:184: ui_gamemenu_action=3;
   449D 21 CC 7D      [10]  497 	ld	hl,#_ui_gamemenu_action + 0
   44A0 36 03         [10]  498 	ld	(hl), #0x03
                            499 ;src/UI_GameMenu.c:185: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[2];
   44A2 ED 5B AA 42   [20]  500 	ld	de, (#(_ui_gamemenu_action_buttonText + 0x0004) + 0)
   44A6 ED 53 AC 42   [20]  501 	ld	(_ui_gamemenu_buttonText), de
   44AA                     502 00102$:
                            503 ;src/UI_GameMenu.c:187: if(forward&CELL_WALL_MASK){
   44AA CB 79         [ 8]  504 	bit	7, c
   44AC 28 17         [12]  505 	jr	Z,00111$
                            506 ;src/UI_GameMenu.c:188: if(forward==CELLTYPE_DOOR){
   44AE 79            [ 4]  507 	ld	a,c
   44AF D6 80         [ 7]  508 	sub	a, #0x80
   44B1 C0            [11]  509 	ret	NZ
                            510 ;src/UI_GameMenu.c:189: if(player_has_key){
   44B2 3A 8F 7D      [13]  511 	ld	a,(#_player_has_key + 0)
   44B5 B7            [ 4]  512 	or	a, a
   44B6 C8            [11]  513 	ret	Z
                            514 ;src/UI_GameMenu.c:190: ui_gamemenu_action=1;
   44B7 21 CC 7D      [10]  515 	ld	hl,#_ui_gamemenu_action + 0
   44BA 36 01         [10]  516 	ld	(hl), #0x01
                            517 ;src/UI_GameMenu.c:191: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[0];
   44BC ED 4B A6 42   [20]  518 	ld	bc, (#_ui_gamemenu_action_buttonText + 0)
   44C0 ED 43 AC 42   [20]  519 	ld	(_ui_gamemenu_buttonText), bc
   44C4 C9            [10]  520 	ret
   44C5                     521 00111$:
                            522 ;src/UI_GameMenu.c:195: else if(forward&CELL_ENEMY_MASK){
   44C5 79            [ 4]  523 	ld	a,c
   44C6 E6 0F         [ 7]  524 	and	a, #0x0F
   44C8 28 0E         [12]  525 	jr	Z,00108$
                            526 ;src/UI_GameMenu.c:196: ui_gamemenu_action=2;
   44CA 21 CC 7D      [10]  527 	ld	hl,#_ui_gamemenu_action + 0
   44CD 36 02         [10]  528 	ld	(hl), #0x02
                            529 ;src/UI_GameMenu.c:197: *((char**)ui_gamemenu_buttonText)=ui_gamemenu_action_buttonText[1];
   44CF ED 4B A8 42   [20]  530 	ld	bc, (#(_ui_gamemenu_action_buttonText + 0x0002) + 0)
   44D3 ED 43 AC 42   [20]  531 	ld	(_ui_gamemenu_buttonText), bc
   44D7 C9            [10]  532 	ret
   44D8                     533 00108$:
                            534 ;src/UI_GameMenu.c:200: ui_gamemenu_can_move=1;
   44D8 21 CB 7D      [10]  535 	ld	hl,#_ui_gamemenu_can_move + 0
   44DB 36 01         [10]  536 	ld	(hl), #0x01
                            537 ;src/UI_GameMenu.c:201: *(char**)(ui_gamemenu_buttonText+3)="MOVE";
   44DD 21 E5 44      [10]  538 	ld	hl,#___str_11
   44E0 22 B2 42      [16]  539 	ld	((_ui_gamemenu_buttonText + 0x0006)), hl
   44E3 C9            [10]  540 	ret
   44E4                     541 ___str_10:
   44E4 00                  542 	.db 0x00
   44E5                     543 ___str_11:
   44E5 4D 4F 56 45         544 	.ascii "MOVE"
   44E9 00                  545 	.db 0x00
                            546 ;src/UI_GameMenu.c:205: u8 ui_gamemenu_get_movement(){
                            547 ;	---------------------------------
                            548 ; Function ui_gamemenu_get_movement
                            549 ; ---------------------------------
   44EA                     550 _ui_gamemenu_get_movement::
                            551 ;src/UI_GameMenu.c:206: return ui_gamemenu_can_move;
   44EA FD 21 CB 7D   [14]  552 	ld	iy,#_ui_gamemenu_can_move
   44EE FD 6E 00      [19]  553 	ld	l,0 (iy)
   44F1 C9            [10]  554 	ret
                            555 ;src/UI_GameMenu.c:209: u8 ui_gamemenu_get_action(){
                            556 ;	---------------------------------
                            557 ; Function ui_gamemenu_get_action
                            558 ; ---------------------------------
   44F2                     559 _ui_gamemenu_get_action::
                            560 ;src/UI_GameMenu.c:210: return ui_gamemenu_action;
   44F2 FD 21 CC 7D   [14]  561 	ld	iy,#_ui_gamemenu_action
   44F6 FD 6E 00      [19]  562 	ld	l,0 (iy)
   44F9 C9            [10]  563 	ret
                            564 	.area _CODE
                            565 	.area _INITIALIZER
                            566 	.area _CABS (ABS)
