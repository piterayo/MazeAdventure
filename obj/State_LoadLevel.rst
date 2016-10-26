                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_LoadLevel
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _savegame_Save
                             12 	.globl _item_init_items
                             13 	.globl _enemy_init_enemies
                             14 	.globl _level_load_level
                             15 	.globl _level_get_level
                             16 	.globl _generate_level
                             17 	.globl _generate_level_with_seed
                             18 	.globl _print_transparent_text
                             19 	.globl _set_music
                             20 	.globl _remove_music
                             21 	.globl _draw_minimap_to_buffer
                             22 	.globl _render_draw_to_buffer
                             23 	.globl _statemanager_input_accepted
                             24 	.globl _statemanager_set_state
                             25 	.globl _cpct_memset
                             26 	.globl _level_seed
                             27 	.globl _state_loadlevel_enter
                             28 	.globl _state_loadlevel_return
                             29 	.globl _state_loadlevel_input
                             30 	.globl _state_loadlevel_update
                             31 	.globl _state_loadlevel_render
                             32 	.globl _state_loadlevel_exit
                             33 ;--------------------------------------------------------
                             34 ; special function registers
                             35 ;--------------------------------------------------------
                             36 ;--------------------------------------------------------
                             37 ; ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DATA
   872C                      40 _level_seed::
   872C                      41 	.ds 2
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
                             66 ;src/State_LoadLevel.c:20: void state_loadlevel_enter(){
                             67 ;	---------------------------------
                             68 ; Function state_loadlevel_enter
                             69 ; ---------------------------------
   366B                      70 _state_loadlevel_enter::
                             71 ;src/State_LoadLevel.c:22: if(level_get_level()<=(KING_LEVEL)){
   366B CD 59 11      [17]   72 	call	_level_get_level
   366E 3E 20         [ 7]   73 	ld	a,#0x20
   3670 95            [ 4]   74 	sub	a, l
   3671 D8            [11]   75 	ret	C
                             76 ;src/State_LoadLevel.c:23: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   3672 21 29 1C      [10]   77 	ld	hl,#_g_colors+1
   3675 46            [ 7]   78 	ld	b,(hl)
   3676 21 00 40      [10]   79 	ld	hl,#0x4000
   3679 E5            [11]   80 	push	hl
   367A C5            [11]   81 	push	bc
   367B 33            [ 6]   82 	inc	sp
   367C 26 C0         [ 7]   83 	ld	h, #0xC0
   367E E5            [11]   84 	push	hl
   367F CD 11 85      [17]   85 	call	_cpct_memset
                             86 ;src/State_LoadLevel.c:25: print_transparent_text("LOADING", 0xe391, 3);
   3682 3E 03         [ 7]   87 	ld	a,#0x03
   3684 F5            [11]   88 	push	af
   3685 33            [ 6]   89 	inc	sp
   3686 21 91 E3      [10]   90 	ld	hl,#0xE391
   3689 E5            [11]   91 	push	hl
   368A 21 CB 36      [10]   92 	ld	hl,#___str_0
   368D E5            [11]   93 	push	hl
   368E CD 14 41      [17]   94 	call	_print_transparent_text
   3691 F1            [10]   95 	pop	af
   3692 F1            [10]   96 	pop	af
   3693 33            [ 6]   97 	inc	sp
                             98 ;src/State_LoadLevel.c:27: if(level_seed) generate_level_with_seed(level_seed);
   3694 3A 2D 87      [13]   99 	ld	a,(#_level_seed + 1)
   3697 21 2C 87      [10]  100 	ld	hl,#_level_seed + 0
   369A B6            [ 7]  101 	or	a,(hl)
   369B 28 0A         [12]  102 	jr	Z,00102$
   369D 2A 2C 87      [16]  103 	ld	hl,(_level_seed)
   36A0 E5            [11]  104 	push	hl
   36A1 CD 8E 19      [17]  105 	call	_generate_level_with_seed
   36A4 F1            [10]  106 	pop	af
   36A5 18 03         [12]  107 	jr	00103$
   36A7                     108 00102$:
                            109 ;src/State_LoadLevel.c:28: else generate_level();
   36A7 CD 85 19      [17]  110 	call	_generate_level
   36AA                     111 00103$:
                            112 ;src/State_LoadLevel.c:29: level_load_level();
   36AA CD 1D 12      [17]  113 	call	_level_load_level
                            114 ;src/State_LoadLevel.c:31: enemy_init_enemies();
   36AD CD 57 01      [17]  115 	call	_enemy_init_enemies
                            116 ;src/State_LoadLevel.c:32: item_init_items();
   36B0 CD 82 0D      [17]  117 	call	_item_init_items
                            118 ;src/State_LoadLevel.c:34: savegame_Save();
   36B3 CD 2E 2E      [17]  119 	call	_savegame_Save
                            120 ;src/State_LoadLevel.c:36: render_draw_to_buffer();
   36B6 CD 2B 20      [17]  121 	call	_render_draw_to_buffer
                            122 ;src/State_LoadLevel.c:37: draw_minimap_to_buffer();
   36B9 CD F1 2B      [17]  123 	call	_draw_minimap_to_buffer
                            124 ;src/State_LoadLevel.c:39: set_music(GameMusic);
   36BC 21 40 00      [10]  125 	ld	hl,#_GameMusic
   36BF E5            [11]  126 	push	hl
   36C0 CD EC 0C      [17]  127 	call	_set_music
   36C3 F1            [10]  128 	pop	af
                            129 ;src/State_LoadLevel.c:41: level_seed=0;
   36C4 21 00 00      [10]  130 	ld	hl,#0x0000
   36C7 22 2C 87      [16]  131 	ld	(_level_seed),hl
   36CA C9            [10]  132 	ret
   36CB                     133 ___str_0:
   36CB 4C 4F 41 44 49 4E   134 	.ascii "LOADING"
        47
   36D2 00                  135 	.db 0x00
                            136 ;src/State_LoadLevel.c:46: void state_loadlevel_return(){
                            137 ;	---------------------------------
                            138 ; Function state_loadlevel_return
                            139 ; ---------------------------------
   36D3                     140 _state_loadlevel_return::
                            141 ;src/State_LoadLevel.c:48: }
   36D3 C9            [10]  142 	ret
                            143 ;src/State_LoadLevel.c:51: void state_loadlevel_input() {
                            144 ;	---------------------------------
                            145 ; Function state_loadlevel_input
                            146 ; ---------------------------------
   36D4                     147 _state_loadlevel_input::
                            148 ;src/State_LoadLevel.c:52: statemanager_input_accepted();
   36D4 C3 FB 39      [10]  149 	jp  _statemanager_input_accepted
                            150 ;src/State_LoadLevel.c:55: void state_loadlevel_update(){
                            151 ;	---------------------------------
                            152 ; Function state_loadlevel_update
                            153 ; ---------------------------------
   36D7                     154 _state_loadlevel_update::
                            155 ;src/State_LoadLevel.c:56: if(level_get_level()<=(KING_LEVEL)){
   36D7 CD 59 11      [17]  156 	call	_level_get_level
   36DA 3E 20         [ 7]  157 	ld	a,#0x20
   36DC 95            [ 4]  158 	sub	a, l
   36DD 38 09         [12]  159 	jr	C,00102$
                            160 ;src/State_LoadLevel.c:57: statemanager_set_state(STATE_INGAME);
   36DF 3E 01         [ 7]  161 	ld	a,#0x01
   36E1 F5            [11]  162 	push	af
   36E2 33            [ 6]  163 	inc	sp
   36E3 CD 01 3A      [17]  164 	call	_statemanager_set_state
   36E6 33            [ 6]  165 	inc	sp
   36E7 C9            [10]  166 	ret
   36E8                     167 00102$:
                            168 ;src/State_LoadLevel.c:60: remove_music();
   36E8 CD 0D 0D      [17]  169 	call	_remove_music
                            170 ;src/State_LoadLevel.c:61: statemanager_set_state(STATE_VICTORY);
   36EB 3E 07         [ 7]  171 	ld	a,#0x07
   36ED F5            [11]  172 	push	af
   36EE 33            [ 6]  173 	inc	sp
   36EF CD 01 3A      [17]  174 	call	_statemanager_set_state
   36F2 33            [ 6]  175 	inc	sp
   36F3 C9            [10]  176 	ret
                            177 ;src/State_LoadLevel.c:65: void state_loadlevel_render(){
                            178 ;	---------------------------------
                            179 ; Function state_loadlevel_render
                            180 ; ---------------------------------
   36F4                     181 _state_loadlevel_render::
                            182 ;src/State_LoadLevel.c:67: }
   36F4 C9            [10]  183 	ret
                            184 ;src/State_LoadLevel.c:69: void state_loadlevel_exit(){
                            185 ;	---------------------------------
                            186 ; Function state_loadlevel_exit
                            187 ; ---------------------------------
   36F5                     188 _state_loadlevel_exit::
                            189 ;src/State_LoadLevel.c:71: }
   36F5 C9            [10]  190 	ret
                            191 	.area _CODE
                            192 	.area _INITIALIZER
                            193 	.area _CABS (ABS)
