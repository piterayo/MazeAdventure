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
                             15 	.globl _remove_music
                             16 	.globl _statemanager_exit_game
                             17 	.globl _statemanager_input_accepted
                             18 	.globl _statemanager_set_state
                             19 	.globl _ui_mainmenu_render_refresh
                             20 	.globl _ui_mainmenu_render_all
                             21 	.globl _ui_mainmenu_unselect_entry
                             22 	.globl _ui_mainmenu_select_entry
                             23 	.globl _ui_mainmenu_previous_entry
                             24 	.globl _ui_mainmenu_next_entry
                             25 	.globl _ui_mainmenu_is_selected
                             26 	.globl _ui_mainmenu_get_entry
                             27 	.globl _ui_mainmenu_init
                             28 	.globl _cpct_hflipSpriteM0
                             29 	.globl _cpct_drawSprite
                             30 	.globl _cpct_isKeyPressed
                             31 	.globl _cpct_memcpy
                             32 	.globl _cpct_memset
                             33 	.globl _state_mainmenu_enter
                             34 	.globl _state_mainmenu_return
                             35 	.globl _state_mainmenu_input
                             36 	.globl _state_mainmenu_update
                             37 	.globl _state_mainmenu_render
                             38 	.globl _state_mainmenu_exit
                             39 ;--------------------------------------------------------
                             40 ; special function registers
                             41 ;--------------------------------------------------------
                             42 ;--------------------------------------------------------
                             43 ; ram data
                             44 ;--------------------------------------------------------
                             45 	.area _DATA
                             46 ;--------------------------------------------------------
                             47 ; ram data
                             48 ;--------------------------------------------------------
                             49 	.area _INITIALIZED
                             50 ;--------------------------------------------------------
                             51 ; absolute external ram data
                             52 ;--------------------------------------------------------
                             53 	.area _DABS (ABS)
                             54 ;--------------------------------------------------------
                             55 ; global & static initialisations
                             56 ;--------------------------------------------------------
                             57 	.area _HOME
                             58 	.area _GSINIT
                             59 	.area _GSFINAL
                             60 	.area _GSINIT
                             61 ;--------------------------------------------------------
                             62 ; Home
                             63 ;--------------------------------------------------------
                             64 	.area _HOME
                             65 	.area _HOME
                             66 ;--------------------------------------------------------
                             67 ; code
                             68 ;--------------------------------------------------------
                             69 	.area _CODE
                             70 ;src/State_MainMenu.c:24: void dec_main_bg(){
                             71 ;	---------------------------------
                             72 ; Function dec_main_bg
                             73 ; ---------------------------------
   36F6                      74 _dec_main_bg::
   36F6 DD E5         [15]   75 	push	ix
   36F8 DD 21 00 00   [14]   76 	ld	ix,#0
   36FC DD 39         [15]   77 	add	ix,sp
   36FE 21 F7 FF      [10]   78 	ld	hl,#-9
   3701 39            [11]   79 	add	hl,sp
   3702 F9            [ 6]   80 	ld	sp,hl
                             81 ;src/State_MainMenu.c:29: newPos=0;
   3703 DD 36 F7 00   [19]   82 	ld	-9 (ix),#0x00
                             83 ;src/State_MainMenu.c:30: texture_set = menu_bg;
   3707 DD 36 FA 4A   [19]   84 	ld	-6 (ix),#<(_menu_bg)
   370B DD 36 FB 52   [19]   85 	ld	-5 (ix),#>(_menu_bg)
                             86 ;src/State_MainMenu.c:32: position=MANUALLY_ALLOCATED_MEMORY_START;
   370F 01 D0 88      [10]   87 	ld	bc,#0x88D0
                             88 ;src/State_MainMenu.c:33: *position=0;
   3712 21 D0 88      [10]   89 	ld	hl,#0x88D0
   3715 36 00         [10]   90 	ld	(hl),#0x00
                             91 ;src/State_MainMenu.c:36: while(length){
   3717 11 F1 05      [10]   92 	ld	de,#0x05F1
   371A                      93 00106$:
   371A 7A            [ 4]   94 	ld	a,d
   371B B3            [ 4]   95 	or	a,e
   371C CA 9C 37      [10]   96 	jp	Z,00108$
                             97 ;src/State_MainMenu.c:37: value = g_colors[(*texture_set)&0x0F];
   371F DD 6E FA      [19]   98 	ld	l,-6 (ix)
   3722 DD 66 FB      [19]   99 	ld	h,-5 (ix)
   3725 7E            [ 7]  100 	ld	a,(hl)
   3726 DD 77 FF      [19]  101 	ld	-1 (ix), a
   3729 E6 0F         [ 7]  102 	and	a, #0x0F
   372B C6 28         [ 7]  103 	add	a,#<(_g_colors)
   372D 6F            [ 4]  104 	ld	l,a
   372E 3E 1C         [ 7]  105 	ld	a,#>(_g_colors)
   3730 CE 00         [ 7]  106 	adc	a, #0x00
   3732 67            [ 4]  107 	ld	h,a
   3733 6E            [ 7]  108 	ld	l,(hl)
                            109 ;src/State_MainMenu.c:38: counter = ((*texture_set)>>4)+1;
   3734 DD 7E FF      [19]  110 	ld	a,-1 (ix)
   3737 07            [ 4]  111 	rlca
   3738 07            [ 4]  112 	rlca
   3739 07            [ 4]  113 	rlca
   373A 07            [ 4]  114 	rlca
   373B E6 0F         [ 7]  115 	and	a,#0x0F
   373D 3C            [ 4]  116 	inc	a
   373E DD 77 FF      [19]  117 	ld	-1 (ix),a
                            118 ;src/State_MainMenu.c:39: while(counter){
   3741 7D            [ 4]  119 	ld	a,l
   3742 E6 AA         [ 7]  120 	and	a, #0xAA
   3744 DD 77 F8      [19]  121 	ld	-8 (ix),a
   3747 7D            [ 4]  122 	ld	a,l
   3748 E6 55         [ 7]  123 	and	a, #0x55
   374A DD 77 FE      [19]  124 	ld	-2 (ix),a
   374D DD 7E F7      [19]  125 	ld	a,-9 (ix)
   3750 DD 77 FC      [19]  126 	ld	-4 (ix),a
   3753                     127 00103$:
   3753 DD 7E FF      [19]  128 	ld	a,-1 (ix)
   3756 B7            [ 4]  129 	or	a, a
   3757 28 31         [12]  130 	jr	Z,00119$
                            131 ;src/State_MainMenu.c:40: *position=(*position)|((newPos&1)?(value&0b01010101):(value&0b10101010));
   3759 C5            [11]  132 	push	bc
   375A FD E1         [14]  133 	pop	iy
   375C 0A            [ 7]  134 	ld	a,(bc)
   375D DD 77 FD      [19]  135 	ld	-3 (ix),a
   3760 DD 7E FC      [19]  136 	ld	a,-4 (ix)
   3763 E6 01         [ 7]  137 	and	a, #0x01
   3765 DD 77 F9      [19]  138 	ld	-7 (ix), a
   3768 B7            [ 4]  139 	or	a, a
   3769 28 05         [12]  140 	jr	Z,00111$
   376B DD 7E FE      [19]  141 	ld	a,-2 (ix)
   376E 18 03         [12]  142 	jr	00112$
   3770                     143 00111$:
   3770 DD 7E F8      [19]  144 	ld	a,-8 (ix)
   3773                     145 00112$:
   3773 DD B6 FD      [19]  146 	or	a, -3 (ix)
   3776 FD 77 00      [19]  147 	ld	0 (iy), a
                            148 ;src/State_MainMenu.c:41: if(newPos&1){
   3779 DD 7E F9      [19]  149 	ld	a,-7 (ix)
   377C B7            [ 4]  150 	or	a, a
   377D 28 03         [12]  151 	jr	Z,00102$
                            152 ;src/State_MainMenu.c:42: ++position;
   377F 03            [ 6]  153 	inc	bc
                            154 ;src/State_MainMenu.c:43: *position=0;
   3780 AF            [ 4]  155 	xor	a, a
   3781 02            [ 7]  156 	ld	(bc),a
   3782                     157 00102$:
                            158 ;src/State_MainMenu.c:45: ++newPos;
   3782 DD 34 FC      [23]  159 	inc	-4 (ix)
                            160 ;src/State_MainMenu.c:46: --counter;
   3785 DD 35 FF      [23]  161 	dec	-1 (ix)
   3788 18 C9         [12]  162 	jr	00103$
   378A                     163 00119$:
   378A DD 7E FC      [19]  164 	ld	a,-4 (ix)
   378D DD 77 F7      [19]  165 	ld	-9 (ix),a
                            166 ;src/State_MainMenu.c:48: ++texture_set;
   3790 DD 34 FA      [23]  167 	inc	-6 (ix)
   3793 20 03         [12]  168 	jr	NZ,00139$
   3795 DD 34 FB      [23]  169 	inc	-5 (ix)
   3798                     170 00139$:
                            171 ;src/State_MainMenu.c:49: --length;
   3798 1B            [ 6]  172 	dec	de
   3799 C3 1A 37      [10]  173 	jp	00106$
   379C                     174 00108$:
                            175 ;src/State_MainMenu.c:52: cpct_memcpy((MANUALLY_ALLOCATED_MEMORY_START+(40*83)),MANUALLY_ALLOCATED_MEMORY_START,(40*83));
   379C 21 F8 0C      [10]  176 	ld	hl,#0x0CF8
   379F E5            [11]  177 	push	hl
   37A0 21 D0 88      [10]  178 	ld	hl,#0x88D0
   37A3 E5            [11]  179 	push	hl
   37A4 21 C8 95      [10]  180 	ld	hl,#0x95C8
   37A7 E5            [11]  181 	push	hl
   37A8 CD 09 85      [17]  182 	call	_cpct_memcpy
                            183 ;src/State_MainMenu.c:53: cpct_hflipSpriteM0 (40, 83, (MANUALLY_ALLOCATED_MEMORY_START+(40*83)));
   37AB 21 C8 95      [10]  184 	ld	hl,#0x95C8
   37AE E5            [11]  185 	push	hl
   37AF 21 28 53      [10]  186 	ld	hl,#0x5328
   37B2 E5            [11]  187 	push	hl
   37B3 CD 94 84      [17]  188 	call	_cpct_hflipSpriteM0
   37B6 DD F9         [10]  189 	ld	sp, ix
   37B8 DD E1         [14]  190 	pop	ix
   37BA C9            [10]  191 	ret
                            192 ;src/State_MainMenu.c:56: void draw_main_bg(){
                            193 ;	---------------------------------
                            194 ; Function draw_main_bg
                            195 ; ---------------------------------
   37BB                     196 _draw_main_bg::
                            197 ;src/State_MainMenu.c:57: cpct_drawSprite (MANUALLY_ALLOCATED_MEMORY_START, cpctm_screenPtr(CPCT_VMEM_START, 0, 200-83),40,83);
   37BB 21 28 53      [10]  198 	ld	hl,#0x5328
   37BE E5            [11]  199 	push	hl
   37BF 21 60 EC      [10]  200 	ld	hl,#0xEC60
   37C2 E5            [11]  201 	push	hl
   37C3 21 D0 88      [10]  202 	ld	hl,#0x88D0
   37C6 E5            [11]  203 	push	hl
   37C7 CD 0B 83      [17]  204 	call	_cpct_drawSprite
                            205 ;src/State_MainMenu.c:58: cpct_drawSprite ((MANUALLY_ALLOCATED_MEMORY_START+(40*83)), cpctm_screenPtr(CPCT_VMEM_START, 40, 200-83), 40, 83);
   37CA 21 28 53      [10]  206 	ld	hl,#0x5328
   37CD E5            [11]  207 	push	hl
   37CE 21 88 EC      [10]  208 	ld	hl,#0xEC88
   37D1 E5            [11]  209 	push	hl
   37D2 21 C8 95      [10]  210 	ld	hl,#0x95C8
   37D5 E5            [11]  211 	push	hl
   37D6 CD 0B 83      [17]  212 	call	_cpct_drawSprite
   37D9 C9            [10]  213 	ret
                            214 ;src/State_MainMenu.c:61: void state_mainmenu_enter(){
                            215 ;	---------------------------------
                            216 ; Function state_mainmenu_enter
                            217 ; ---------------------------------
   37DA                     218 _state_mainmenu_enter::
                            219 ;src/State_MainMenu.c:63: remove_music();
   37DA CD 0D 0D      [17]  220 	call	_remove_music
                            221 ;src/State_MainMenu.c:64: cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
   37DD 21 2F 1C      [10]  222 	ld	hl, #(_g_colors + 0x0007) + 0
   37E0 46            [ 7]  223 	ld	b,(hl)
   37E1 21 00 40      [10]  224 	ld	hl,#0x4000
   37E4 E5            [11]  225 	push	hl
   37E5 C5            [11]  226 	push	bc
   37E6 33            [ 6]  227 	inc	sp
   37E7 26 C0         [ 7]  228 	ld	h, #0xC0
   37E9 E5            [11]  229 	push	hl
   37EA CD 11 85      [17]  230 	call	_cpct_memset
                            231 ;src/State_MainMenu.c:65: setMenuPalette();
   37ED CD CF 11      [17]  232 	call	_setMenuPalette
                            233 ;src/State_MainMenu.c:66: dec_main_bg();
   37F0 CD F6 36      [17]  234 	call	_dec_main_bg
                            235 ;src/State_MainMenu.c:67: draw_main_bg();
   37F3 CD BB 37      [17]  236 	call	_draw_main_bg
                            237 ;src/State_MainMenu.c:68: camelot_warriors_mode=0;
   37F6 21 DC 86      [10]  238 	ld	hl,#_camelot_warriors_mode + 0
   37F9 36 00         [10]  239 	ld	(hl), #0x00
                            240 ;src/State_MainMenu.c:69: ui_mainmenu_init();
   37FB CD 8D 49      [17]  241 	call	_ui_mainmenu_init
                            242 ;src/State_MainMenu.c:70: ui_mainmenu_render_all();
   37FE CD 85 4A      [17]  243 	call	_ui_mainmenu_render_all
   3801 C9            [10]  244 	ret
                            245 ;src/State_MainMenu.c:74: void state_mainmenu_return() {
                            246 ;	---------------------------------
                            247 ; Function state_mainmenu_return
                            248 ; ---------------------------------
   3802                     249 _state_mainmenu_return::
                            250 ;src/State_MainMenu.c:75: cpct_memset(CPCT_VMEM_START, g_colors[7], 0x4000);
   3802 21 2F 1C      [10]  251 	ld	hl, #(_g_colors + 0x0007) + 0
   3805 46            [ 7]  252 	ld	b,(hl)
   3806 21 00 40      [10]  253 	ld	hl,#0x4000
   3809 E5            [11]  254 	push	hl
   380A C5            [11]  255 	push	bc
   380B 33            [ 6]  256 	inc	sp
   380C 26 C0         [ 7]  257 	ld	h, #0xC0
   380E E5            [11]  258 	push	hl
   380F CD 11 85      [17]  259 	call	_cpct_memset
                            260 ;src/State_MainMenu.c:76: draw_main_bg();
   3812 CD BB 37      [17]  261 	call	_draw_main_bg
                            262 ;src/State_MainMenu.c:77: ui_mainmenu_render_all();
   3815 CD 85 4A      [17]  263 	call	_ui_mainmenu_render_all
   3818 C9            [10]  264 	ret
                            265 ;src/State_MainMenu.c:80: void state_mainmenu_input(){
                            266 ;	---------------------------------
                            267 ; Function state_mainmenu_input
                            268 ; ---------------------------------
   3819                     269 _state_mainmenu_input::
                            270 ;src/State_MainMenu.c:81: if(cpct_isKeyPressed(Key_CursorUp)){
   3819 21 00 01      [10]  271 	ld	hl,#0x0100
   381C CD B3 7A      [17]  272 	call	_cpct_isKeyPressed
   381F 7D            [ 4]  273 	ld	a,l
   3820 B7            [ 4]  274 	or	a, a
   3821 28 06         [12]  275 	jr	Z,00107$
                            276 ;src/State_MainMenu.c:82: ui_mainmenu_previous_entry();
   3823 CD E6 49      [17]  277 	call	_ui_mainmenu_previous_entry
                            278 ;src/State_MainMenu.c:83: statemanager_input_accepted();
   3826 C3 FB 39      [10]  279 	jp  _statemanager_input_accepted
   3829                     280 00107$:
                            281 ;src/State_MainMenu.c:85: else if(cpct_isKeyPressed(Key_CursorDown)){
   3829 21 00 04      [10]  282 	ld	hl,#0x0400
   382C CD B3 7A      [17]  283 	call	_cpct_isKeyPressed
   382F 7D            [ 4]  284 	ld	a,l
   3830 B7            [ 4]  285 	or	a, a
   3831 28 06         [12]  286 	jr	Z,00104$
                            287 ;src/State_MainMenu.c:86: ui_mainmenu_next_entry();
   3833 CD D8 49      [17]  288 	call	_ui_mainmenu_next_entry
                            289 ;src/State_MainMenu.c:87: statemanager_input_accepted();
   3836 C3 FB 39      [10]  290 	jp  _statemanager_input_accepted
   3839                     291 00104$:
                            292 ;src/State_MainMenu.c:89: else if(cpct_isKeyPressed(Key_Return)){
   3839 21 02 04      [10]  293 	ld	hl,#0x0402
   383C CD B3 7A      [17]  294 	call	_cpct_isKeyPressed
   383F 7D            [ 4]  295 	ld	a,l
   3840 B7            [ 4]  296 	or	a, a
   3841 C8            [11]  297 	ret	Z
                            298 ;src/State_MainMenu.c:90: ui_mainmenu_select_entry();
   3842 CD FC 49      [17]  299 	call	_ui_mainmenu_select_entry
                            300 ;src/State_MainMenu.c:91: statemanager_input_accepted();
   3845 C3 FB 39      [10]  301 	jp  _statemanager_input_accepted
                            302 ;src/State_MainMenu.c:95: void state_mainmenu_update(){
                            303 ;	---------------------------------
                            304 ; Function state_mainmenu_update
                            305 ; ---------------------------------
   3848                     306 _state_mainmenu_update::
                            307 ;src/State_MainMenu.c:96: if(ui_mainmenu_is_selected()){
   3848 CD A5 4A      [17]  308 	call	_ui_mainmenu_is_selected
   384B 7D            [ 4]  309 	ld	a,l
   384C B7            [ 4]  310 	or	a, a
   384D C8            [11]  311 	ret	Z
                            312 ;src/State_MainMenu.c:97: ui_mainmenu_render_refresh();
   384E CD 6C 4A      [17]  313 	call	_ui_mainmenu_render_refresh
                            314 ;src/State_MainMenu.c:98: switch(ui_mainmenu_get_entry()){
   3851 CD 9D 4A      [17]  315 	call	_ui_mainmenu_get_entry
   3854 5D            [ 4]  316 	ld	e,l
   3855 3E 04         [ 7]  317 	ld	a,#0x04
   3857 93            [ 4]  318 	sub	a, e
   3858 DA F6 49      [10]  319 	jp	C,_ui_mainmenu_unselect_entry
   385B 16 00         [ 7]  320 	ld	d,#0x00
   385D 21 63 38      [10]  321 	ld	hl,#00119$
   3860 19            [11]  322 	add	hl,de
   3861 19            [11]  323 	add	hl,de
                            324 ;src/State_MainMenu.c:99: case 0:{
   3862 E9            [ 4]  325 	jp	(hl)
   3863                     326 00119$:
   3863 18 08         [12]  327 	jr	00101$
   3865 18 21         [12]  328 	jr	00102$
   3867 18 2A         [12]  329 	jr	00103$
   3869 18 33         [12]  330 	jr	00104$
   386B 18 3C         [12]  331 	jr	00105$
   386D                     332 00101$:
                            333 ;src/State_MainMenu.c:100: level_set_level(0);
   386D AF            [ 4]  334 	xor	a, a
   386E F5            [11]  335 	push	af
   386F 33            [ 6]  336 	inc	sp
   3870 CD 8E 11      [17]  337 	call	_level_set_level
   3873 33            [ 6]  338 	inc	sp
                            339 ;src/State_MainMenu.c:101: level_seed=0;
   3874 21 00 00      [10]  340 	ld	hl,#0x0000
   3877 22 2C 87      [16]  341 	ld	(_level_seed),hl
                            342 ;src/State_MainMenu.c:102: player_init();
   387A CD CA 19      [17]  343 	call	_player_init
                            344 ;src/State_MainMenu.c:103: statemanager_set_state(STATE_LOADLEVEL);
   387D 3E 03         [ 7]  345 	ld	a,#0x03
   387F F5            [11]  346 	push	af
   3880 33            [ 6]  347 	inc	sp
   3881 CD 01 3A      [17]  348 	call	_statemanager_set_state
   3884 33            [ 6]  349 	inc	sp
                            350 ;src/State_MainMenu.c:104: break;
   3885 C3 F6 49      [10]  351 	jp	_ui_mainmenu_unselect_entry
                            352 ;src/State_MainMenu.c:106: case 1:{
   3888                     353 00102$:
                            354 ;src/State_MainMenu.c:107: statemanager_set_state(STATE_LOADGAME);
   3888 3E 0A         [ 7]  355 	ld	a,#0x0A
   388A F5            [11]  356 	push	af
   388B 33            [ 6]  357 	inc	sp
   388C CD 01 3A      [17]  358 	call	_statemanager_set_state
   388F 33            [ 6]  359 	inc	sp
                            360 ;src/State_MainMenu.c:108: break;
   3890 C3 F6 49      [10]  361 	jp	_ui_mainmenu_unselect_entry
                            362 ;src/State_MainMenu.c:110: case 2:{
   3893                     363 00103$:
                            364 ;src/State_MainMenu.c:111: statemanager_set_state(STATE_OPTIONS);
   3893 3E 04         [ 7]  365 	ld	a,#0x04
   3895 F5            [11]  366 	push	af
   3896 33            [ 6]  367 	inc	sp
   3897 CD 01 3A      [17]  368 	call	_statemanager_set_state
   389A 33            [ 6]  369 	inc	sp
                            370 ;src/State_MainMenu.c:112: break;
   389B C3 F6 49      [10]  371 	jp	_ui_mainmenu_unselect_entry
                            372 ;src/State_MainMenu.c:114: case 3:{
   389E                     373 00104$:
                            374 ;src/State_MainMenu.c:115: statemanager_set_state(STATE_CREDITS);
   389E 3E 06         [ 7]  375 	ld	a,#0x06
   38A0 F5            [11]  376 	push	af
   38A1 33            [ 6]  377 	inc	sp
   38A2 CD 01 3A      [17]  378 	call	_statemanager_set_state
   38A5 33            [ 6]  379 	inc	sp
                            380 ;src/State_MainMenu.c:116: break;
   38A6 C3 F6 49      [10]  381 	jp	_ui_mainmenu_unselect_entry
                            382 ;src/State_MainMenu.c:118: case 4:{
   38A9                     383 00105$:
                            384 ;src/State_MainMenu.c:119: statemanager_exit_game();
   38A9 CD C6 3A      [17]  385 	call	_statemanager_exit_game
                            386 ;src/State_MainMenu.c:122: }
                            387 ;src/State_MainMenu.c:123: ui_mainmenu_unselect_entry();
   38AC C3 F6 49      [10]  388 	jp  _ui_mainmenu_unselect_entry
                            389 ;src/State_MainMenu.c:127: void state_mainmenu_render() {
                            390 ;	---------------------------------
                            391 ; Function state_mainmenu_render
                            392 ; ---------------------------------
   38AF                     393 _state_mainmenu_render::
                            394 ;src/State_MainMenu.c:128: ui_mainmenu_render_refresh();
   38AF C3 6C 4A      [10]  395 	jp  _ui_mainmenu_render_refresh
                            396 ;src/State_MainMenu.c:131: void state_mainmenu_exit(){
                            397 ;	---------------------------------
                            398 ; Function state_mainmenu_exit
                            399 ; ---------------------------------
   38B2                     400 _state_mainmenu_exit::
                            401 ;src/State_MainMenu.c:133: }
   38B2 C9            [10]  402 	ret
                            403 	.area _CODE
                            404 	.area _INITIALIZER
                            405 	.area _CABS (ABS)
