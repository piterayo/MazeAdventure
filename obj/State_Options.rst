                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_Options
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_options_set_strings
                             12 	.globl _ui_options_render_all
                             13 	.globl _ui_options_render_refresh
                             14 	.globl _ui_options_unselect_entry
                             15 	.globl _ui_options_select_entry
                             16 	.globl _ui_options_previous_entry
                             17 	.globl _ui_options_next_entry
                             18 	.globl _ui_options_is_selected
                             19 	.globl _ui_options_get_entry
                             20 	.globl _ui_options_init
                             21 	.globl _statemanager_input_accepted
                             22 	.globl _statemanager_close_state
                             23 	.globl _cpct_drawSolidBox
                             24 	.globl _cpct_isKeyPressed
                             25 	.globl _state_options_enter
                             26 	.globl _state_options_return
                             27 	.globl _state_options_input
                             28 	.globl _state_options_update
                             29 	.globl _state_options_render
                             30 	.globl _state_options_exit
                             31 ;--------------------------------------------------------
                             32 ; special function registers
                             33 ;--------------------------------------------------------
                             34 ;--------------------------------------------------------
                             35 ; ram data
                             36 ;--------------------------------------------------------
                             37 	.area _DATA
                             38 ;--------------------------------------------------------
                             39 ; ram data
                             40 ;--------------------------------------------------------
                             41 	.area _INITIALIZED
                             42 ;--------------------------------------------------------
                             43 ; absolute external ram data
                             44 ;--------------------------------------------------------
                             45 	.area _DABS (ABS)
                             46 ;--------------------------------------------------------
                             47 ; global & static initialisations
                             48 ;--------------------------------------------------------
                             49 	.area _HOME
                             50 	.area _GSINIT
                             51 	.area _GSFINAL
                             52 	.area _GSINIT
                             53 ;--------------------------------------------------------
                             54 ; Home
                             55 ;--------------------------------------------------------
                             56 	.area _HOME
                             57 	.area _HOME
                             58 ;--------------------------------------------------------
                             59 ; code
                             60 ;--------------------------------------------------------
                             61 	.area _CODE
                             62 ;src/State_Options.c:13: void state_options_enter(){
                             63 ;	---------------------------------
                             64 ; Function state_options_enter
                             65 ; ---------------------------------
   399D                      66 _state_options_enter::
                             67 ;src/State_Options.c:14: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[4], 34, 80);
   399D 21 B3 1A      [10]   68 	ld	hl, #_g_colors + 4
   39A0 46            [ 7]   69 	ld	b,(hl)
   39A1 21 22 50      [10]   70 	ld	hl,#0x5022
   39A4 E5            [11]   71 	push	hl
   39A5 C5            [11]   72 	push	bc
   39A6 33            [ 6]   73 	inc	sp
   39A7 21 97 C2      [10]   74 	ld	hl,#0xC297
   39AA E5            [11]   75 	push	hl
   39AB CD B8 7B      [17]   76 	call	_cpct_drawSolidBox
   39AE F1            [10]   77 	pop	af
   39AF F1            [10]   78 	pop	af
   39B0 33            [ 6]   79 	inc	sp
                             80 ;src/State_Options.c:15: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 68), g_colors[1], 32, 72);
   39B1 21 B0 1A      [10]   81 	ld	hl, #_g_colors + 1
   39B4 46            [ 7]   82 	ld	b,(hl)
   39B5 21 20 48      [10]   83 	ld	hl,#0x4820
   39B8 E5            [11]   84 	push	hl
   39B9 C5            [11]   85 	push	bc
   39BA 33            [ 6]   86 	inc	sp
   39BB 21 98 E2      [10]   87 	ld	hl,#0xE298
   39BE E5            [11]   88 	push	hl
   39BF CD B8 7B      [17]   89 	call	_cpct_drawSolidBox
   39C2 F1            [10]   90 	pop	af
   39C3 F1            [10]   91 	pop	af
   39C4 33            [ 6]   92 	inc	sp
                             93 ;src/State_Options.c:16: ui_options_init();
   39C5 CD AA 49      [17]   94 	call	_ui_options_init
                             95 ;src/State_Options.c:17: ui_options_render_all();
   39C8 C3 79 4A      [10]   96 	jp  _ui_options_render_all
                             97 ;src/State_Options.c:20: void state_options_return(){
                             98 ;	---------------------------------
                             99 ; Function state_options_return
                            100 ; ---------------------------------
   39CB                     101 _state_options_return::
                            102 ;src/State_Options.c:22: }
   39CB C9            [10]  103 	ret
                            104 ;src/State_Options.c:24: void state_options_input(){
                            105 ;	---------------------------------
                            106 ; Function state_options_input
                            107 ; ---------------------------------
   39CC                     108 _state_options_input::
                            109 ;src/State_Options.c:25: if(cpct_isKeyPressed(Key_CursorUp)){
   39CC 21 00 01      [10]  110 	ld	hl,#0x0100
   39CF CD 65 79      [17]  111 	call	_cpct_isKeyPressed
   39D2 7D            [ 4]  112 	ld	a,l
   39D3 B7            [ 4]  113 	or	a, a
   39D4 28 06         [12]  114 	jr	Z,00107$
                            115 ;src/State_Options.c:26: ui_options_previous_entry();
   39D6 CD DA 49      [17]  116 	call	_ui_options_previous_entry
                            117 ;src/State_Options.c:27: statemanager_input_accepted();
   39D9 C3 B6 38      [10]  118 	jp  _statemanager_input_accepted
   39DC                     119 00107$:
                            120 ;src/State_Options.c:29: else if(cpct_isKeyPressed(Key_CursorDown)){
   39DC 21 00 04      [10]  121 	ld	hl,#0x0400
   39DF CD 65 79      [17]  122 	call	_cpct_isKeyPressed
   39E2 7D            [ 4]  123 	ld	a,l
   39E3 B7            [ 4]  124 	or	a, a
   39E4 28 06         [12]  125 	jr	Z,00104$
                            126 ;src/State_Options.c:30: ui_options_next_entry();
   39E6 CD CC 49      [17]  127 	call	_ui_options_next_entry
                            128 ;src/State_Options.c:31: statemanager_input_accepted();
   39E9 C3 B6 38      [10]  129 	jp  _statemanager_input_accepted
   39EC                     130 00104$:
                            131 ;src/State_Options.c:33: else if(cpct_isKeyPressed(Key_Return)){
   39EC 21 02 04      [10]  132 	ld	hl,#0x0402
   39EF CD 65 79      [17]  133 	call	_cpct_isKeyPressed
   39F2 7D            [ 4]  134 	ld	a,l
   39F3 B7            [ 4]  135 	or	a, a
   39F4 C8            [11]  136 	ret	Z
                            137 ;src/State_Options.c:34: ui_options_select_entry();
   39F5 CD EA 49      [17]  138 	call	_ui_options_select_entry
                            139 ;src/State_Options.c:35: statemanager_input_accepted();
   39F8 C3 B6 38      [10]  140 	jp  _statemanager_input_accepted
                            141 ;src/State_Options.c:39: void state_options_update(){
                            142 ;	---------------------------------
                            143 ; Function state_options_update
                            144 ; ---------------------------------
   39FB                     145 _state_options_update::
                            146 ;src/State_Options.c:40: if(ui_options_is_selected()){
   39FB CD C4 49      [17]  147 	call	_ui_options_is_selected
   39FE 7D            [ 4]  148 	ld	a,l
   39FF B7            [ 4]  149 	or	a, a
   3A00 CA F0 49      [10]  150 	jp	Z,_ui_options_unselect_entry
                            151 ;src/State_Options.c:41: ui_options_render_refresh();
   3A03 CD 60 4A      [17]  152 	call	_ui_options_render_refresh
                            153 ;src/State_Options.c:42: switch(ui_options_get_entry()){
   3A06 CD BC 49      [17]  154 	call	_ui_options_get_entry
   3A09 5D            [ 4]  155 	ld	e,l
   3A0A 3E 02         [ 7]  156 	ld	a,#0x02
   3A0C 93            [ 4]  157 	sub	a, e
   3A0D DA F0 49      [10]  158 	jp	C,_ui_options_unselect_entry
   3A10 16 00         [ 7]  159 	ld	d,#0x00
   3A12 21 18 3A      [10]  160 	ld	hl,#00117$
   3A15 19            [11]  161 	add	hl,de
   3A16 19            [11]  162 	add	hl,de
                            163 ;src/State_Options.c:43: case 0:{//Textures
   3A17 E9            [ 4]  164 	jp	(hl)
   3A18                     165 00117$:
   3A18 18 04         [12]  166 	jr	00101$
   3A1A 18 15         [12]  167 	jr	00102$
   3A1C 18 26         [12]  168 	jr	00103$
   3A1E                     169 00101$:
                            170 ;src/State_Options.c:44: textures_on=!textures_on;
   3A1E 3A 61 7D      [13]  171 	ld	a,(#_textures_on + 0)
   3A21 D6 01         [ 7]  172 	sub	a,#0x01
   3A23 3E 00         [ 7]  173 	ld	a,#0x00
   3A25 17            [ 4]  174 	rla
   3A26 4F            [ 4]  175 	ld	c,a
   3A27 21 61 7D      [10]  176 	ld	hl,#_textures_on + 0
   3A2A 71            [ 7]  177 	ld	(hl), c
                            178 ;src/State_Options.c:45: ui_options_set_strings();
   3A2B CD 5F 49      [17]  179 	call	_ui_options_set_strings
                            180 ;src/State_Options.c:46: break;
   3A2E C3 F0 49      [10]  181 	jp	_ui_options_unselect_entry
                            182 ;src/State_Options.c:48: case 1:{//Sound
   3A31                     183 00102$:
                            184 ;src/State_Options.c:49: music_on=!music_on;
   3A31 3A 60 7D      [13]  185 	ld	a,(#_music_on + 0)
   3A34 D6 01         [ 7]  186 	sub	a,#0x01
   3A36 3E 00         [ 7]  187 	ld	a,#0x00
   3A38 17            [ 4]  188 	rla
   3A39 4F            [ 4]  189 	ld	c,a
   3A3A 21 60 7D      [10]  190 	ld	hl,#_music_on + 0
   3A3D 71            [ 7]  191 	ld	(hl), c
                            192 ;src/State_Options.c:50: ui_options_set_strings();
   3A3E CD 5F 49      [17]  193 	call	_ui_options_set_strings
                            194 ;src/State_Options.c:51: break;
   3A41 C3 F0 49      [10]  195 	jp	_ui_options_unselect_entry
                            196 ;src/State_Options.c:53: case 2:{
   3A44                     197 00103$:
                            198 ;src/State_Options.c:54: statemanager_close_state();
   3A44 CD 5F 39      [17]  199 	call	_statemanager_close_state
                            200 ;src/State_Options.c:57: }
                            201 ;src/State_Options.c:59: ui_options_unselect_entry();
   3A47 C3 F0 49      [10]  202 	jp  _ui_options_unselect_entry
                            203 ;src/State_Options.c:62: void state_options_render(){
                            204 ;	---------------------------------
                            205 ; Function state_options_render
                            206 ; ---------------------------------
   3A4A                     207 _state_options_render::
                            208 ;src/State_Options.c:63: ui_options_render_refresh();
   3A4A C3 60 4A      [10]  209 	jp  _ui_options_render_refresh
                            210 ;src/State_Options.c:66: void state_options_exit(){
                            211 ;	---------------------------------
                            212 ; Function state_options_exit
                            213 ; ---------------------------------
   3A4D                     214 _state_options_exit::
                            215 ;src/State_Options.c:67: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[1], 34, 80);
   3A4D 21 B0 1A      [10]  216 	ld	hl, #(_g_colors + 0x0001) + 0
   3A50 46            [ 7]  217 	ld	b,(hl)
   3A51 21 22 50      [10]  218 	ld	hl,#0x5022
   3A54 E5            [11]  219 	push	hl
   3A55 C5            [11]  220 	push	bc
   3A56 33            [ 6]  221 	inc	sp
   3A57 21 97 C2      [10]  222 	ld	hl,#0xC297
   3A5A E5            [11]  223 	push	hl
   3A5B CD B8 7B      [17]  224 	call	_cpct_drawSolidBox
   3A5E F1            [10]  225 	pop	af
   3A5F F1            [10]  226 	pop	af
   3A60 33            [ 6]  227 	inc	sp
   3A61 C9            [10]  228 	ret
                            229 	.area _CODE
                            230 	.area _INITIALIZER
                            231 	.area _CABS (ABS)
