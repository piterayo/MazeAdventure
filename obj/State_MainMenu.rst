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
   35B4                      73 _dec_main_bg::
   35B4 DD E5         [15]   74 	push	ix
   35B6 DD 21 00 00   [14]   75 	ld	ix,#0
   35BA DD 39         [15]   76 	add	ix,sp
   35BC 21 F7 FF      [10]   77 	ld	hl,#-9
   35BF 39            [11]   78 	add	hl,sp
   35C0 F9            [ 6]   79 	ld	sp,hl
                             80 ;src/State_MainMenu.c:29: newPos=0;
   35C1 DD 36 F7 00   [19]   81 	ld	-9 (ix),#0x00
                             82 ;src/State_MainMenu.c:30: texture_set = menu_bg;
   35C5 DD 36 FE FC   [19]   83 	ld	-2 (ix),#<(_menu_bg)
   35C9 DD 36 FF 50   [19]   84 	ld	-1 (ix),#>(_menu_bg)
                             85 ;src/State_MainMenu.c:32: position=MANUALLY_ALLOCATED_MEMORY_START;
   35CD 01 D0 88      [10]   86 	ld	bc,#0x88D0
                             87 ;src/State_MainMenu.c:33: *position=0;
   35D0 21 D0 88      [10]   88 	ld	hl,#0x88D0
   35D3 36 00         [10]   89 	ld	(hl),#0x00
                             90 ;src/State_MainMenu.c:36: while(length){
   35D5 11 F1 05      [10]   91 	ld	de,#0x05F1
   35D8                      92 00106$:
   35D8 7A            [ 4]   93 	ld	a,d
   35D9 B3            [ 4]   94 	or	a,e
   35DA CA 5A 36      [10]   95 	jp	Z,00108$
                             96 ;src/State_MainMenu.c:37: value = g_colors[(*texture_set)&0x0F];
   35DD DD 6E FE      [19]   97 	ld	l,-2 (ix)
   35E0 DD 66 FF      [19]   98 	ld	h,-1 (ix)
   35E3 7E            [ 7]   99 	ld	a,(hl)
   35E4 DD 77 FB      [19]  100 	ld	-5 (ix), a
   35E7 E6 0F         [ 7]  101 	and	a, #0x0F
   35E9 C6 AF         [ 7]  102 	add	a,#<(_g_colors)
   35EB 6F            [ 4]  103 	ld	l,a
   35EC 3E 1A         [ 7]  104 	ld	a,#>(_g_colors)
   35EE CE 00         [ 7]  105 	adc	a, #0x00
   35F0 67            [ 4]  106 	ld	h,a
   35F1 6E            [ 7]  107 	ld	l,(hl)
                            108 ;src/State_MainMenu.c:38: counter = ((*texture_set)>>4)+1;
   35F2 DD 7E FB      [19]  109 	ld	a,-5 (ix)
   35F5 07            [ 4]  110 	rlca
   35F6 07            [ 4]  111 	rlca
   35F7 07            [ 4]  112 	rlca
   35F8 07            [ 4]  113 	rlca
   35F9 E6 0F         [ 7]  114 	and	a,#0x0F
   35FB 3C            [ 4]  115 	inc	a
   35FC DD 77 FB      [19]  116 	ld	-5 (ix),a
                            117 ;src/State_MainMenu.c:39: while(counter){
   35FF 7D            [ 4]  118 	ld	a,l
   3600 E6 AA         [ 7]  119 	and	a, #0xAA
   3602 DD 77 FC      [19]  120 	ld	-4 (ix),a
   3605 7D            [ 4]  121 	ld	a,l
   3606 E6 55         [ 7]  122 	and	a, #0x55
   3608 DD 77 FD      [19]  123 	ld	-3 (ix),a
   360B DD 7E F7      [19]  124 	ld	a,-9 (ix)
   360E DD 77 FA      [19]  125 	ld	-6 (ix),a
   3611                     126 00103$:
   3611 DD 7E FB      [19]  127 	ld	a,-5 (ix)
   3614 B7            [ 4]  128 	or	a, a
   3615 28 31         [12]  129 	jr	Z,00119$
                            130 ;src/State_MainMenu.c:40: *position=(*position)|((newPos&1)?(value&0b01010101):(value&0b10101010));
   3617 C5            [11]  131 	push	bc
   3618 FD E1         [14]  132 	pop	iy
   361A 0A            [ 7]  133 	ld	a,(bc)
   361B DD 77 F8      [19]  134 	ld	-8 (ix),a
   361E DD 7E FA      [19]  135 	ld	a,-6 (ix)
   3621 E6 01         [ 7]  136 	and	a, #0x01
   3623 DD 77 F9      [19]  137 	ld	-7 (ix), a
   3626 B7            [ 4]  138 	or	a, a
   3627 28 05         [12]  139 	jr	Z,00111$
   3629 DD 7E FD      [19]  140 	ld	a,-3 (ix)
   362C 18 03         [12]  141 	jr	00112$
   362E                     142 00111$:
   362E DD 7E FC      [19]  143 	ld	a,-4 (ix)
   3631                     144 00112$:
   3631 DD B6 F8      [19]  145 	or	a, -8 (ix)
   3634 FD 77 00      [19]  146 	ld	0 (iy), a
                            147 ;src/State_MainMenu.c:41: if(newPos&1){
   3637 DD 7E F9      [19]  148 	ld	a,-7 (ix)
   363A B7            [ 4]  149 	or	a, a
   363B 28 03         [12]  150 	jr	Z,00102$
                            151 ;src/State_MainMenu.c:42: ++position;
   363D 03            [ 6]  152 	inc	bc
                            153 ;src/State_MainMenu.c:43: *position=0;
   363E AF            [ 4]  154 	xor	a, a
   363F 02            [ 7]  155 	ld	(bc),a
   3640                     156 00102$:
                            157 ;src/State_MainMenu.c:45: ++newPos;
   3640 DD 34 FA      [23]  158 	inc	-6 (ix)
                            159 ;src/State_MainMenu.c:46: --counter;
   3643 DD 35 FB      [23]  160 	dec	-5 (ix)
   3646 18 C9         [12]  161 	jr	00103$
   3648                     162 00119$:
   3648 DD 7E FA      [19]  163 	ld	a,-6 (ix)
   364B DD 77 F7      [19]  164 	ld	-9 (ix),a
                            165 ;src/State_MainMenu.c:48: ++texture_set;
   364E DD 34 FE      [23]  166 	inc	-2 (ix)
   3651 20 03         [12]  167 	jr	NZ,00139$
   3653 DD 34 FF      [23]  168 	inc	-1 (ix)
   3656                     169 00139$:
                            170 ;src/State_MainMenu.c:49: --length;
   3656 1B            [ 6]  171 	dec	de
   3657 C3 D8 35      [10]  172 	jp	00106$
   365A                     173 00108$:
                            174 ;src/State_MainMenu.c:52: cpct_memcpy((MANUALLY_ALLOCATED_MEMORY_START+(40*83)),MANUALLY_ALLOCATED_MEMORY_START,(40*83));
   365A 21 F8 0C      [10]  175 	ld	hl,#0x0CF8
   365D E5            [11]  176 	push	hl
   365E 21 D0 88      [10]  177 	ld	hl,#0x88D0
   3661 E5            [11]  178 	push	hl
   3662 21 C8 95      [10]  179 	ld	hl,#0x95C8
   3665 E5            [11]  180 	push	hl
   3666 CD 92 7B      [17]  181 	call	_cpct_memcpy
                            182 ;src/State_MainMenu.c:53: cpct_hflipSpriteM0 (40, 83, (MANUALLY_ALLOCATED_MEMORY_START+(40*83)));
   3669 21 C8 95      [10]  183 	ld	hl,#0x95C8
   366C E5            [11]  184 	push	hl
   366D 21 28 53      [10]  185 	ld	hl,#0x5328
   3670 E5            [11]  186 	push	hl
   3671 CD 1D 7B      [17]  187 	call	_cpct_hflipSpriteM0
   3674 DD F9         [10]  188 	ld	sp, ix
   3676 DD E1         [14]  189 	pop	ix
   3678 C9            [10]  190 	ret
                            191 ;src/State_MainMenu.c:56: void draw_main_bg(){
                            192 ;	---------------------------------
                            193 ; Function draw_main_bg
                            194 ; ---------------------------------
   3679                     195 _draw_main_bg::
                            196 ;src/State_MainMenu.c:57: cpct_drawSprite (MANUALLY_ALLOCATED_MEMORY_START, cpctm_screenPtr(CPCT_VMEM_START, 0, 200-83),40,83);
   3679 21 28 53      [10]  197 	ld	hl,#0x5328
   367C E5            [11]  198 	push	hl
   367D 21 60 EC      [10]  199 	ld	hl,#0xEC60
   3680 E5            [11]  200 	push	hl
   3681 21 D0 88      [10]  201 	ld	hl,#0x88D0
   3684 E5            [11]  202 	push	hl
   3685 CD 94 79      [17]  203 	call	_cpct_drawSprite
                            204 ;src/State_MainMenu.c:58: cpct_drawSprite ((MANUALLY_ALLOCATED_MEMORY_START+(40*83)), cpctm_screenPtr(CPCT_VMEM_START, 40, 200-83), 40, 83);
   3688 21 28 53      [10]  205 	ld	hl,#0x5328
   368B E5            [11]  206 	push	hl
   368C 21 88 EC      [10]  207 	ld	hl,#0xEC88
   368F E5            [11]  208 	push	hl
   3690 21 C8 95      [10]  209 	ld	hl,#0x95C8
   3693 E5            [11]  210 	push	hl
   3694 CD 94 79      [17]  211 	call	_cpct_drawSprite
   3697 C9            [10]  212 	ret
                            213 ;src/State_MainMenu.c:61: void state_mainmenu_enter(){
                            214 ;	---------------------------------
                            215 ; Function state_mainmenu_enter
                            216 ; ---------------------------------
   3698                     217 _state_mainmenu_enter::
                            218 ;src/State_MainMenu.c:63: cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
   3698 21 B6 1A      [10]  219 	ld	hl, #(_g_colors + 0x0007) + 0
   369B 46            [ 7]  220 	ld	b,(hl)
   369C 21 00 40      [10]  221 	ld	hl,#0x4000
   369F E5            [11]  222 	push	hl
   36A0 C5            [11]  223 	push	bc
   36A1 33            [ 6]  224 	inc	sp
   36A2 26 C0         [ 7]  225 	ld	h, #0xC0
   36A4 E5            [11]  226 	push	hl
   36A5 CD 9A 7B      [17]  227 	call	_cpct_memset
                            228 ;src/State_MainMenu.c:64: setMenuPalette();
   36A8 CD 66 10      [17]  229 	call	_setMenuPalette
                            230 ;src/State_MainMenu.c:65: dec_main_bg();
   36AB CD B4 35      [17]  231 	call	_dec_main_bg
                            232 ;src/State_MainMenu.c:66: draw_main_bg();
   36AE CD 79 36      [17]  233 	call	_draw_main_bg
                            234 ;src/State_MainMenu.c:67: camelot_warriors_mode=0;
   36B1 21 62 7D      [10]  235 	ld	hl,#_camelot_warriors_mode + 0
   36B4 36 00         [10]  236 	ld	(hl), #0x00
                            237 ;src/State_MainMenu.c:68: ui_mainmenu_init();
   36B6 CD 3F 48      [17]  238 	call	_ui_mainmenu_init
                            239 ;src/State_MainMenu.c:69: ui_mainmenu_render_all();
   36B9 CD 37 49      [17]  240 	call	_ui_mainmenu_render_all
   36BC C9            [10]  241 	ret
                            242 ;src/State_MainMenu.c:73: void state_mainmenu_return() {
                            243 ;	---------------------------------
                            244 ; Function state_mainmenu_return
                            245 ; ---------------------------------
   36BD                     246 _state_mainmenu_return::
                            247 ;src/State_MainMenu.c:74: cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
   36BD 21 B6 1A      [10]  248 	ld	hl, #(_g_colors + 0x0007) + 0
   36C0 46            [ 7]  249 	ld	b,(hl)
   36C1 21 00 40      [10]  250 	ld	hl,#0x4000
   36C4 E5            [11]  251 	push	hl
   36C5 C5            [11]  252 	push	bc
   36C6 33            [ 6]  253 	inc	sp
   36C7 26 C0         [ 7]  254 	ld	h, #0xC0
   36C9 E5            [11]  255 	push	hl
   36CA CD 9A 7B      [17]  256 	call	_cpct_memset
                            257 ;src/State_MainMenu.c:75: draw_main_bg();
   36CD CD 79 36      [17]  258 	call	_draw_main_bg
                            259 ;src/State_MainMenu.c:76: ui_mainmenu_render_all();
   36D0 CD 37 49      [17]  260 	call	_ui_mainmenu_render_all
   36D3 C9            [10]  261 	ret
                            262 ;src/State_MainMenu.c:79: void state_mainmenu_input(){
                            263 ;	---------------------------------
                            264 ; Function state_mainmenu_input
                            265 ; ---------------------------------
   36D4                     266 _state_mainmenu_input::
                            267 ;src/State_MainMenu.c:80: if(cpct_isKeyPressed(Key_CursorUp)){
   36D4 21 00 01      [10]  268 	ld	hl,#0x0100
   36D7 CD 65 79      [17]  269 	call	_cpct_isKeyPressed
   36DA 7D            [ 4]  270 	ld	a,l
   36DB B7            [ 4]  271 	or	a, a
   36DC 28 06         [12]  272 	jr	Z,00107$
                            273 ;src/State_MainMenu.c:81: ui_mainmenu_previous_entry();
   36DE CD 98 48      [17]  274 	call	_ui_mainmenu_previous_entry
                            275 ;src/State_MainMenu.c:82: statemanager_input_accepted();
   36E1 C3 B6 38      [10]  276 	jp  _statemanager_input_accepted
   36E4                     277 00107$:
                            278 ;src/State_MainMenu.c:84: else if(cpct_isKeyPressed(Key_CursorDown)){
   36E4 21 00 04      [10]  279 	ld	hl,#0x0400
   36E7 CD 65 79      [17]  280 	call	_cpct_isKeyPressed
   36EA 7D            [ 4]  281 	ld	a,l
   36EB B7            [ 4]  282 	or	a, a
   36EC 28 06         [12]  283 	jr	Z,00104$
                            284 ;src/State_MainMenu.c:85: ui_mainmenu_next_entry();
   36EE CD 8A 48      [17]  285 	call	_ui_mainmenu_next_entry
                            286 ;src/State_MainMenu.c:86: statemanager_input_accepted();
   36F1 C3 B6 38      [10]  287 	jp  _statemanager_input_accepted
   36F4                     288 00104$:
                            289 ;src/State_MainMenu.c:88: else if(cpct_isKeyPressed(Key_Return)){
   36F4 21 02 04      [10]  290 	ld	hl,#0x0402
   36F7 CD 65 79      [17]  291 	call	_cpct_isKeyPressed
   36FA 7D            [ 4]  292 	ld	a,l
   36FB B7            [ 4]  293 	or	a, a
   36FC C8            [11]  294 	ret	Z
                            295 ;src/State_MainMenu.c:89: ui_mainmenu_select_entry();
   36FD CD AE 48      [17]  296 	call	_ui_mainmenu_select_entry
                            297 ;src/State_MainMenu.c:90: statemanager_input_accepted();
   3700 C3 B6 38      [10]  298 	jp  _statemanager_input_accepted
                            299 ;src/State_MainMenu.c:94: void state_mainmenu_update(){
                            300 ;	---------------------------------
                            301 ; Function state_mainmenu_update
                            302 ; ---------------------------------
   3703                     303 _state_mainmenu_update::
                            304 ;src/State_MainMenu.c:95: if(ui_mainmenu_is_selected()){
   3703 CD 57 49      [17]  305 	call	_ui_mainmenu_is_selected
   3706 7D            [ 4]  306 	ld	a,l
   3707 B7            [ 4]  307 	or	a, a
   3708 C8            [11]  308 	ret	Z
                            309 ;src/State_MainMenu.c:96: ui_mainmenu_render_refresh();
   3709 CD 1E 49      [17]  310 	call	_ui_mainmenu_render_refresh
                            311 ;src/State_MainMenu.c:97: switch(ui_mainmenu_get_entry()){
   370C CD 4F 49      [17]  312 	call	_ui_mainmenu_get_entry
   370F 5D            [ 4]  313 	ld	e,l
   3710 3E 04         [ 7]  314 	ld	a,#0x04
   3712 93            [ 4]  315 	sub	a, e
   3713 DA A8 48      [10]  316 	jp	C,_ui_mainmenu_unselect_entry
   3716 16 00         [ 7]  317 	ld	d,#0x00
   3718 21 1E 37      [10]  318 	ld	hl,#00119$
   371B 19            [11]  319 	add	hl,de
   371C 19            [11]  320 	add	hl,de
                            321 ;src/State_MainMenu.c:98: case 0:{
   371D E9            [ 4]  322 	jp	(hl)
   371E                     323 00119$:
   371E 18 08         [12]  324 	jr	00101$
   3720 18 21         [12]  325 	jr	00102$
   3722 18 2A         [12]  326 	jr	00103$
   3724 18 33         [12]  327 	jr	00104$
   3726 18 3C         [12]  328 	jr	00105$
   3728                     329 00101$:
                            330 ;src/State_MainMenu.c:99: level_set_level(0);
   3728 AF            [ 4]  331 	xor	a, a
   3729 F5            [11]  332 	push	af
   372A 33            [ 6]  333 	inc	sp
   372B CD 25 10      [17]  334 	call	_level_set_level
   372E 33            [ 6]  335 	inc	sp
                            336 ;src/State_MainMenu.c:100: level_seed=0;
   372F 21 00 00      [10]  337 	ld	hl,#0x0000
   3732 22 B2 7D      [16]  338 	ld	(_level_seed),hl
                            339 ;src/State_MainMenu.c:101: player_init();
   3735 CD 51 18      [17]  340 	call	_player_init
                            341 ;src/State_MainMenu.c:102: statemanager_set_state(STATE_LOADLEVEL);
   3738 3E 03         [ 7]  342 	ld	a,#0x03
   373A F5            [11]  343 	push	af
   373B 33            [ 6]  344 	inc	sp
   373C CD BC 38      [17]  345 	call	_statemanager_set_state
   373F 33            [ 6]  346 	inc	sp
                            347 ;src/State_MainMenu.c:103: break;
   3740 C3 A8 48      [10]  348 	jp	_ui_mainmenu_unselect_entry
                            349 ;src/State_MainMenu.c:105: case 1:{
   3743                     350 00102$:
                            351 ;src/State_MainMenu.c:106: statemanager_set_state(STATE_LOADGAME);
   3743 3E 0A         [ 7]  352 	ld	a,#0x0A
   3745 F5            [11]  353 	push	af
   3746 33            [ 6]  354 	inc	sp
   3747 CD BC 38      [17]  355 	call	_statemanager_set_state
   374A 33            [ 6]  356 	inc	sp
                            357 ;src/State_MainMenu.c:107: break;
   374B C3 A8 48      [10]  358 	jp	_ui_mainmenu_unselect_entry
                            359 ;src/State_MainMenu.c:109: case 2:{
   374E                     360 00103$:
                            361 ;src/State_MainMenu.c:110: statemanager_set_state(STATE_OPTIONS);
   374E 3E 04         [ 7]  362 	ld	a,#0x04
   3750 F5            [11]  363 	push	af
   3751 33            [ 6]  364 	inc	sp
   3752 CD BC 38      [17]  365 	call	_statemanager_set_state
   3755 33            [ 6]  366 	inc	sp
                            367 ;src/State_MainMenu.c:111: break;
   3756 C3 A8 48      [10]  368 	jp	_ui_mainmenu_unselect_entry
                            369 ;src/State_MainMenu.c:113: case 3:{
   3759                     370 00104$:
                            371 ;src/State_MainMenu.c:114: statemanager_set_state(STATE_CREDITS);
   3759 3E 06         [ 7]  372 	ld	a,#0x06
   375B F5            [11]  373 	push	af
   375C 33            [ 6]  374 	inc	sp
   375D CD BC 38      [17]  375 	call	_statemanager_set_state
   3760 33            [ 6]  376 	inc	sp
                            377 ;src/State_MainMenu.c:115: break;
   3761 C3 A8 48      [10]  378 	jp	_ui_mainmenu_unselect_entry
                            379 ;src/State_MainMenu.c:117: case 4:{
   3764                     380 00105$:
                            381 ;src/State_MainMenu.c:118: statemanager_exit_game();
   3764 CD 81 39      [17]  382 	call	_statemanager_exit_game
                            383 ;src/State_MainMenu.c:121: }
                            384 ;src/State_MainMenu.c:122: ui_mainmenu_unselect_entry();
   3767 C3 A8 48      [10]  385 	jp  _ui_mainmenu_unselect_entry
                            386 ;src/State_MainMenu.c:126: void state_mainmenu_render() {
                            387 ;	---------------------------------
                            388 ; Function state_mainmenu_render
                            389 ; ---------------------------------
   376A                     390 _state_mainmenu_render::
                            391 ;src/State_MainMenu.c:127: ui_mainmenu_render_refresh();
   376A C3 1E 49      [10]  392 	jp  _ui_mainmenu_render_refresh
                            393 ;src/State_MainMenu.c:130: void state_mainmenu_exit(){
                            394 ;	---------------------------------
                            395 ; Function state_mainmenu_exit
                            396 ; ---------------------------------
   376D                     397 _state_mainmenu_exit::
                            398 ;src/State_MainMenu.c:132: }
   376D C9            [10]  399 	ret
                            400 	.area _CODE
                            401 	.area _INITIALIZER
                            402 	.area _CABS (ABS)
