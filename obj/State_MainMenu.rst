                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_MainMenu
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _draw_main_bg
                             12 	.globl _dec_main_bg
                             13 	.globl _level_set_level
                             14 	.globl _player_init
                             15 	.globl _statemanager_exit_game
                             16 	.globl _statemanager_input_accepted
                             17 	.globl _statemanager_set_state
                             18 	.globl _ui_mainmenu_render_refresh
                             19 	.globl _ui_mainmenu_render_all
                             20 	.globl _ui_mainmenu_unselect_entry
                             21 	.globl _ui_mainmenu_select_entry
                             22 	.globl _ui_mainmenu_previous_entry
                             23 	.globl _ui_mainmenu_next_entry
                             24 	.globl _ui_mainmenu_is_selected
                             25 	.globl _ui_mainmenu_get_entry
                             26 	.globl _ui_mainmenu_init
                             27 	.globl _cpct_hflipSpriteM0
                             28 	.globl _cpct_drawSprite
                             29 	.globl _cpct_isKeyPressed
                             30 	.globl _cpct_memcpy
                             31 	.globl _cpct_memset
                             32 	.globl _state_mainmenu_enter
                             33 	.globl _state_mainmenu_return
                             34 	.globl _state_mainmenu_input
                             35 	.globl _state_mainmenu_update
                             36 	.globl _state_mainmenu_render
                             37 	.globl _state_mainmenu_exit
                             38 ;--------------------------------------------------------
                             39 ; special function registers
                             40 ;--------------------------------------------------------
                             41 ;--------------------------------------------------------
                             42 ; ram data
                             43 ;--------------------------------------------------------
                             44 	.area _DATA
                             45 ;--------------------------------------------------------
                             46 ; ram data
                             47 ;--------------------------------------------------------
                             48 	.area _INITIALIZED
                             49 ;--------------------------------------------------------
                             50 ; absolute external ram data
                             51 ;--------------------------------------------------------
                             52 	.area _DABS (ABS)
                             53 ;--------------------------------------------------------
                             54 ; global & static initialisations
                             55 ;--------------------------------------------------------
                             56 	.area _HOME
                             57 	.area _GSINIT
                             58 	.area _GSFINAL
                             59 	.area _GSINIT
                             60 ;--------------------------------------------------------
                             61 ; Home
                             62 ;--------------------------------------------------------
                             63 	.area _HOME
                             64 	.area _HOME
                             65 ;--------------------------------------------------------
                             66 ; code
                             67 ;--------------------------------------------------------
                             68 	.area _CODE
                             69 ;src/State_MainMenu.c:24: void dec_main_bg(){
                             70 ;	---------------------------------
                             71 ; Function dec_main_bg
                             72 ; ---------------------------------
   358E                      73 _dec_main_bg::
   358E DD E5         [15]   74 	push	ix
   3590 DD 21 00 00   [14]   75 	ld	ix,#0
   3594 DD 39         [15]   76 	add	ix,sp
   3596 21 F7 FF      [10]   77 	ld	hl,#-9
   3599 39            [11]   78 	add	hl,sp
   359A F9            [ 6]   79 	ld	sp,hl
                             80 ;src/State_MainMenu.c:29: newPos=0;
   359B DD 36 F7 00   [19]   81 	ld	-9 (ix),#0x00
                             82 ;src/State_MainMenu.c:30: texture_set = menu_bg;
   359F DD 36 F8 D6   [19]   83 	ld	-8 (ix),#<(_menu_bg)
   35A3 DD 36 F9 50   [19]   84 	ld	-7 (ix),#>(_menu_bg)
                             85 ;src/State_MainMenu.c:32: position=MANUALLY_ALLOCATED_MEMORY_START;
   35A7 01 D0 88      [10]   86 	ld	bc,#0x88D0
                             87 ;src/State_MainMenu.c:33: *position=0;
   35AA 21 D0 88      [10]   88 	ld	hl,#0x88D0
   35AD 36 00         [10]   89 	ld	(hl),#0x00
                             90 ;src/State_MainMenu.c:36: while(length){
   35AF 11 CF 06      [10]   91 	ld	de,#0x06CF
   35B2                      92 00106$:
   35B2 7A            [ 4]   93 	ld	a,d
   35B3 B3            [ 4]   94 	or	a,e
   35B4 CA 34 36      [10]   95 	jp	Z,00108$
                             96 ;src/State_MainMenu.c:37: value = g_colors[(*texture_set)&0x0F];
   35B7 DD 6E F8      [19]   97 	ld	l,-8 (ix)
   35BA DD 66 F9      [19]   98 	ld	h,-7 (ix)
   35BD 7E            [ 7]   99 	ld	a,(hl)
   35BE DD 77 FB      [19]  100 	ld	-5 (ix), a
   35C1 E6 0F         [ 7]  101 	and	a, #0x0F
   35C3 C6 66         [ 7]  102 	add	a,#<(_g_colors)
   35C5 6F            [ 4]  103 	ld	l,a
   35C6 3E 1A         [ 7]  104 	ld	a,#>(_g_colors)
   35C8 CE 00         [ 7]  105 	adc	a, #0x00
   35CA 67            [ 4]  106 	ld	h,a
   35CB 6E            [ 7]  107 	ld	l,(hl)
                            108 ;src/State_MainMenu.c:38: counter = ((*texture_set)>>4)+1;
   35CC DD 7E FB      [19]  109 	ld	a,-5 (ix)
   35CF 07            [ 4]  110 	rlca
   35D0 07            [ 4]  111 	rlca
   35D1 07            [ 4]  112 	rlca
   35D2 07            [ 4]  113 	rlca
   35D3 E6 0F         [ 7]  114 	and	a,#0x0F
   35D5 3C            [ 4]  115 	inc	a
   35D6 DD 77 FB      [19]  116 	ld	-5 (ix),a
                            117 ;src/State_MainMenu.c:39: while(counter){
   35D9 7D            [ 4]  118 	ld	a,l
   35DA E6 AA         [ 7]  119 	and	a, #0xAA
   35DC DD 77 FC      [19]  120 	ld	-4 (ix),a
   35DF 7D            [ 4]  121 	ld	a,l
   35E0 E6 55         [ 7]  122 	and	a, #0x55
   35E2 DD 77 FE      [19]  123 	ld	-2 (ix),a
   35E5 DD 7E F7      [19]  124 	ld	a,-9 (ix)
   35E8 DD 77 FA      [19]  125 	ld	-6 (ix),a
   35EB                     126 00103$:
   35EB DD 7E FB      [19]  127 	ld	a,-5 (ix)
   35EE B7            [ 4]  128 	or	a, a
   35EF 28 31         [12]  129 	jr	Z,00119$
                            130 ;src/State_MainMenu.c:40: *position=(*position)|((newPos&1)?(value&0b01010101):(value&0b10101010));
   35F1 C5            [11]  131 	push	bc
   35F2 FD E1         [14]  132 	pop	iy
   35F4 0A            [ 7]  133 	ld	a,(bc)
   35F5 DD 77 FD      [19]  134 	ld	-3 (ix),a
   35F8 DD 7E FA      [19]  135 	ld	a,-6 (ix)
   35FB E6 01         [ 7]  136 	and	a, #0x01
   35FD DD 77 FF      [19]  137 	ld	-1 (ix), a
   3600 B7            [ 4]  138 	or	a, a
   3601 28 05         [12]  139 	jr	Z,00111$
   3603 DD 7E FE      [19]  140 	ld	a,-2 (ix)
   3606 18 03         [12]  141 	jr	00112$
   3608                     142 00111$:
   3608 DD 7E FC      [19]  143 	ld	a,-4 (ix)
   360B                     144 00112$:
   360B DD B6 FD      [19]  145 	or	a, -3 (ix)
   360E FD 77 00      [19]  146 	ld	0 (iy), a
                            147 ;src/State_MainMenu.c:41: if(newPos&1){
   3611 DD 7E FF      [19]  148 	ld	a,-1 (ix)
   3614 B7            [ 4]  149 	or	a, a
   3615 28 03         [12]  150 	jr	Z,00102$
                            151 ;src/State_MainMenu.c:42: ++position;
   3617 03            [ 6]  152 	inc	bc
                            153 ;src/State_MainMenu.c:43: *position=0;
   3618 AF            [ 4]  154 	xor	a, a
   3619 02            [ 7]  155 	ld	(bc),a
   361A                     156 00102$:
                            157 ;src/State_MainMenu.c:45: ++newPos;
   361A DD 34 FA      [23]  158 	inc	-6 (ix)
                            159 ;src/State_MainMenu.c:46: --counter;
   361D DD 35 FB      [23]  160 	dec	-5 (ix)
   3620 18 C9         [12]  161 	jr	00103$
   3622                     162 00119$:
   3622 DD 7E FA      [19]  163 	ld	a,-6 (ix)
   3625 DD 77 F7      [19]  164 	ld	-9 (ix),a
                            165 ;src/State_MainMenu.c:48: ++texture_set;
   3628 DD 34 F8      [23]  166 	inc	-8 (ix)
   362B 20 03         [12]  167 	jr	NZ,00139$
   362D DD 34 F9      [23]  168 	inc	-7 (ix)
   3630                     169 00139$:
                            170 ;src/State_MainMenu.c:49: --length;
   3630 1B            [ 6]  171 	dec	de
   3631 C3 B2 35      [10]  172 	jp	00106$
   3634                     173 00108$:
                            174 ;src/State_MainMenu.c:52: cpct_memcpy((MANUALLY_ALLOCATED_MEMORY_START+4000),MANUALLY_ALLOCATED_MEMORY_START,4000);
   3634 21 A0 0F      [10]  175 	ld	hl,#0x0FA0
   3637 E5            [11]  176 	push	hl
   3638 21 D0 88      [10]  177 	ld	hl,#0x88D0
   363B E5            [11]  178 	push	hl
   363C 21 70 98      [10]  179 	ld	hl,#0x9870
   363F E5            [11]  180 	push	hl
   3640 CD 4A 7C      [17]  181 	call	_cpct_memcpy
                            182 ;src/State_MainMenu.c:53: cpct_hflipSpriteM0 (40, 100, (MANUALLY_ALLOCATED_MEMORY_START+4000));
   3643 21 70 98      [10]  183 	ld	hl,#0x9870
   3646 E5            [11]  184 	push	hl
   3647 21 28 64      [10]  185 	ld	hl,#0x6428
   364A E5            [11]  186 	push	hl
   364B CD D5 7B      [17]  187 	call	_cpct_hflipSpriteM0
   364E DD F9         [10]  188 	ld	sp, ix
   3650 DD E1         [14]  189 	pop	ix
   3652 C9            [10]  190 	ret
                            191 ;src/State_MainMenu.c:56: void draw_main_bg(){
                            192 ;	---------------------------------
                            193 ; Function draw_main_bg
                            194 ; ---------------------------------
   3653                     195 _draw_main_bg::
                            196 ;src/State_MainMenu.c:57: cpct_drawSprite (MANUALLY_ALLOCATED_MEMORY_START, cpctm_screenPtr(CPCT_VMEM_START, 0, 100),40,100);
   3653 21 28 64      [10]  197 	ld	hl,#0x6428
   3656 E5            [11]  198 	push	hl
   3657 21 C0 E3      [10]  199 	ld	hl,#0xE3C0
   365A E5            [11]  200 	push	hl
   365B 21 D0 88      [10]  201 	ld	hl,#0x88D0
   365E E5            [11]  202 	push	hl
   365F CD 4C 7A      [17]  203 	call	_cpct_drawSprite
                            204 ;src/State_MainMenu.c:58: cpct_drawSprite ((MANUALLY_ALLOCATED_MEMORY_START+4000), cpctm_screenPtr(CPCT_VMEM_START, 40, 100), 40, 100);
   3662 21 28 64      [10]  205 	ld	hl,#0x6428
   3665 E5            [11]  206 	push	hl
   3666 21 E8 E3      [10]  207 	ld	hl,#0xE3E8
   3669 E5            [11]  208 	push	hl
   366A 21 70 98      [10]  209 	ld	hl,#0x9870
   366D E5            [11]  210 	push	hl
   366E CD 4C 7A      [17]  211 	call	_cpct_drawSprite
   3671 C9            [10]  212 	ret
                            213 ;src/State_MainMenu.c:61: void state_mainmenu_enter(){
                            214 ;	---------------------------------
                            215 ; Function state_mainmenu_enter
                            216 ; ---------------------------------
   3672                     217 _state_mainmenu_enter::
                            218 ;src/State_MainMenu.c:63: cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
   3672 21 6D 1A      [10]  219 	ld	hl, #(_g_colors + 0x0007) + 0
   3675 46            [ 7]  220 	ld	b,(hl)
   3676 21 00 40      [10]  221 	ld	hl,#0x4000
   3679 E5            [11]  222 	push	hl
   367A C5            [11]  223 	push	bc
   367B 33            [ 6]  224 	inc	sp
   367C 26 C0         [ 7]  225 	ld	h, #0xC0
   367E E5            [11]  226 	push	hl
   367F CD 52 7C      [17]  227 	call	_cpct_memset
                            228 ;src/State_MainMenu.c:64: setMenuPalette();
   3682 CD 1D 10      [17]  229 	call	_setMenuPalette
                            230 ;src/State_MainMenu.c:65: dec_main_bg();
   3685 CD 8E 35      [17]  231 	call	_dec_main_bg
                            232 ;src/State_MainMenu.c:66: draw_main_bg();
   3688 CD 53 36      [17]  233 	call	_draw_main_bg
                            234 ;src/State_MainMenu.c:67: camelot_warriors_mode=0;
   368B 21 1A 7E      [10]  235 	ld	hl,#_camelot_warriors_mode + 0
   368E 36 00         [10]  236 	ld	(hl), #0x00
                            237 ;src/State_MainMenu.c:68: ui_mainmenu_init();
   3690 CD 19 48      [17]  238 	call	_ui_mainmenu_init
                            239 ;src/State_MainMenu.c:69: ui_mainmenu_render_all();
   3693 CD 11 49      [17]  240 	call	_ui_mainmenu_render_all
   3696 C9            [10]  241 	ret
                            242 ;src/State_MainMenu.c:73: void state_mainmenu_return() {
                            243 ;	---------------------------------
                            244 ; Function state_mainmenu_return
                            245 ; ---------------------------------
   3697                     246 _state_mainmenu_return::
                            247 ;src/State_MainMenu.c:74: cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
   3697 21 6D 1A      [10]  248 	ld	hl, #(_g_colors + 0x0007) + 0
   369A 46            [ 7]  249 	ld	b,(hl)
   369B 21 00 40      [10]  250 	ld	hl,#0x4000
   369E E5            [11]  251 	push	hl
   369F C5            [11]  252 	push	bc
   36A0 33            [ 6]  253 	inc	sp
   36A1 26 C0         [ 7]  254 	ld	h, #0xC0
   36A3 E5            [11]  255 	push	hl
   36A4 CD 52 7C      [17]  256 	call	_cpct_memset
                            257 ;src/State_MainMenu.c:75: draw_main_bg();
   36A7 CD 53 36      [17]  258 	call	_draw_main_bg
                            259 ;src/State_MainMenu.c:76: ui_mainmenu_render_all();
   36AA CD 11 49      [17]  260 	call	_ui_mainmenu_render_all
   36AD C9            [10]  261 	ret
                            262 ;src/State_MainMenu.c:79: void state_mainmenu_input(){
                            263 ;	---------------------------------
                            264 ; Function state_mainmenu_input
                            265 ; ---------------------------------
   36AE                     266 _state_mainmenu_input::
                            267 ;src/State_MainMenu.c:80: if(cpct_isKeyPressed(Key_CursorUp)){
   36AE 21 00 01      [10]  268 	ld	hl,#0x0100
   36B1 CD 1D 7A      [17]  269 	call	_cpct_isKeyPressed
   36B4 7D            [ 4]  270 	ld	a,l
   36B5 B7            [ 4]  271 	or	a, a
   36B6 28 06         [12]  272 	jr	Z,00107$
                            273 ;src/State_MainMenu.c:81: ui_mainmenu_previous_entry();
   36B8 CD 72 48      [17]  274 	call	_ui_mainmenu_previous_entry
                            275 ;src/State_MainMenu.c:82: statemanager_input_accepted();
   36BB C3 90 38      [10]  276 	jp  _statemanager_input_accepted
   36BE                     277 00107$:
                            278 ;src/State_MainMenu.c:84: else if(cpct_isKeyPressed(Key_CursorDown)){
   36BE 21 00 04      [10]  279 	ld	hl,#0x0400
   36C1 CD 1D 7A      [17]  280 	call	_cpct_isKeyPressed
   36C4 7D            [ 4]  281 	ld	a,l
   36C5 B7            [ 4]  282 	or	a, a
   36C6 28 06         [12]  283 	jr	Z,00104$
                            284 ;src/State_MainMenu.c:85: ui_mainmenu_next_entry();
   36C8 CD 64 48      [17]  285 	call	_ui_mainmenu_next_entry
                            286 ;src/State_MainMenu.c:86: statemanager_input_accepted();
   36CB C3 90 38      [10]  287 	jp  _statemanager_input_accepted
   36CE                     288 00104$:
                            289 ;src/State_MainMenu.c:88: else if(cpct_isKeyPressed(Key_Return)){
   36CE 21 02 04      [10]  290 	ld	hl,#0x0402
   36D1 CD 1D 7A      [17]  291 	call	_cpct_isKeyPressed
   36D4 7D            [ 4]  292 	ld	a,l
   36D5 B7            [ 4]  293 	or	a, a
   36D6 C8            [11]  294 	ret	Z
                            295 ;src/State_MainMenu.c:89: ui_mainmenu_select_entry();
   36D7 CD 88 48      [17]  296 	call	_ui_mainmenu_select_entry
                            297 ;src/State_MainMenu.c:90: statemanager_input_accepted();
   36DA C3 90 38      [10]  298 	jp  _statemanager_input_accepted
                            299 ;src/State_MainMenu.c:94: void state_mainmenu_update(){
                            300 ;	---------------------------------
                            301 ; Function state_mainmenu_update
                            302 ; ---------------------------------
   36DD                     303 _state_mainmenu_update::
                            304 ;src/State_MainMenu.c:95: if(ui_mainmenu_is_selected()){
   36DD CD 31 49      [17]  305 	call	_ui_mainmenu_is_selected
   36E0 7D            [ 4]  306 	ld	a,l
   36E1 B7            [ 4]  307 	or	a, a
   36E2 C8            [11]  308 	ret	Z
                            309 ;src/State_MainMenu.c:96: ui_mainmenu_render_refresh();
   36E3 CD F8 48      [17]  310 	call	_ui_mainmenu_render_refresh
                            311 ;src/State_MainMenu.c:97: switch(ui_mainmenu_get_entry()){
   36E6 CD 29 49      [17]  312 	call	_ui_mainmenu_get_entry
   36E9 5D            [ 4]  313 	ld	e,l
   36EA 3E 04         [ 7]  314 	ld	a,#0x04
   36EC 93            [ 4]  315 	sub	a, e
   36ED DA 82 48      [10]  316 	jp	C,_ui_mainmenu_unselect_entry
   36F0 16 00         [ 7]  317 	ld	d,#0x00
   36F2 21 F8 36      [10]  318 	ld	hl,#00119$
   36F5 19            [11]  319 	add	hl,de
   36F6 19            [11]  320 	add	hl,de
                            321 ;src/State_MainMenu.c:98: case 0:{
   36F7 E9            [ 4]  322 	jp	(hl)
   36F8                     323 00119$:
   36F8 18 08         [12]  324 	jr	00101$
   36FA 18 21         [12]  325 	jr	00102$
   36FC 18 2A         [12]  326 	jr	00103$
   36FE 18 33         [12]  327 	jr	00104$
   3700 18 3C         [12]  328 	jr	00105$
   3702                     329 00101$:
                            330 ;src/State_MainMenu.c:99: level_set_level(0);
   3702 AF            [ 4]  331 	xor	a, a
   3703 F5            [11]  332 	push	af
   3704 33            [ 6]  333 	inc	sp
   3705 CD DC 0F      [17]  334 	call	_level_set_level
   3708 33            [ 6]  335 	inc	sp
                            336 ;src/State_MainMenu.c:100: level_seed=0;
   3709 21 00 00      [10]  337 	ld	hl,#0x0000
   370C 22 6A 7E      [16]  338 	ld	(_level_seed),hl
                            339 ;src/State_MainMenu.c:101: player_init();
   370F CD 08 18      [17]  340 	call	_player_init
                            341 ;src/State_MainMenu.c:102: statemanager_set_state(STATE_LOADLEVEL);
   3712 3E 03         [ 7]  342 	ld	a,#0x03
   3714 F5            [11]  343 	push	af
   3715 33            [ 6]  344 	inc	sp
   3716 CD 96 38      [17]  345 	call	_statemanager_set_state
   3719 33            [ 6]  346 	inc	sp
                            347 ;src/State_MainMenu.c:103: break;
   371A C3 82 48      [10]  348 	jp	_ui_mainmenu_unselect_entry
                            349 ;src/State_MainMenu.c:105: case 1:{
   371D                     350 00102$:
                            351 ;src/State_MainMenu.c:106: statemanager_set_state(STATE_LOADGAME);
   371D 3E 0A         [ 7]  352 	ld	a,#0x0A
   371F F5            [11]  353 	push	af
   3720 33            [ 6]  354 	inc	sp
   3721 CD 96 38      [17]  355 	call	_statemanager_set_state
   3724 33            [ 6]  356 	inc	sp
                            357 ;src/State_MainMenu.c:107: break;
   3725 C3 82 48      [10]  358 	jp	_ui_mainmenu_unselect_entry
                            359 ;src/State_MainMenu.c:109: case 2:{
   3728                     360 00103$:
                            361 ;src/State_MainMenu.c:110: statemanager_set_state(STATE_OPTIONS);
   3728 3E 04         [ 7]  362 	ld	a,#0x04
   372A F5            [11]  363 	push	af
   372B 33            [ 6]  364 	inc	sp
   372C CD 96 38      [17]  365 	call	_statemanager_set_state
   372F 33            [ 6]  366 	inc	sp
                            367 ;src/State_MainMenu.c:111: break;
   3730 C3 82 48      [10]  368 	jp	_ui_mainmenu_unselect_entry
                            369 ;src/State_MainMenu.c:113: case 3:{
   3733                     370 00104$:
                            371 ;src/State_MainMenu.c:114: statemanager_set_state(STATE_CREDITS);
   3733 3E 06         [ 7]  372 	ld	a,#0x06
   3735 F5            [11]  373 	push	af
   3736 33            [ 6]  374 	inc	sp
   3737 CD 96 38      [17]  375 	call	_statemanager_set_state
   373A 33            [ 6]  376 	inc	sp
                            377 ;src/State_MainMenu.c:115: break;
   373B C3 82 48      [10]  378 	jp	_ui_mainmenu_unselect_entry
                            379 ;src/State_MainMenu.c:117: case 4:{
   373E                     380 00105$:
                            381 ;src/State_MainMenu.c:118: statemanager_exit_game();
   373E CD 5B 39      [17]  382 	call	_statemanager_exit_game
                            383 ;src/State_MainMenu.c:121: }
                            384 ;src/State_MainMenu.c:122: ui_mainmenu_unselect_entry();
   3741 C3 82 48      [10]  385 	jp  _ui_mainmenu_unselect_entry
                            386 ;src/State_MainMenu.c:126: void state_mainmenu_render() {
                            387 ;	---------------------------------
                            388 ; Function state_mainmenu_render
                            389 ; ---------------------------------
   3744                     390 _state_mainmenu_render::
                            391 ;src/State_MainMenu.c:127: ui_mainmenu_render_refresh();
   3744 C3 F8 48      [10]  392 	jp  _ui_mainmenu_render_refresh
                            393 ;src/State_MainMenu.c:130: void state_mainmenu_exit(){
                            394 ;	---------------------------------
                            395 ; Function state_mainmenu_exit
                            396 ; ---------------------------------
   3747                     397 _state_mainmenu_exit::
                            398 ;src/State_MainMenu.c:132: }
   3747 C9            [10]  399 	ret
                            400 	.area _CODE
                            401 	.area _INITIALIZER
                            402 	.area _CABS (ABS)
