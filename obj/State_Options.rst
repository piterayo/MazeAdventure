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
                             23 	.globl _cpct_akp_stop
                             24 	.globl _cpct_drawSolidBox
                             25 	.globl _cpct_isKeyPressed
                             26 	.globl _state_options_enter
                             27 	.globl _state_options_return
                             28 	.globl _state_options_input
                             29 	.globl _state_options_update
                             30 	.globl _state_options_render
                             31 	.globl _state_options_exit
                             32 ;--------------------------------------------------------
                             33 ; special function registers
                             34 ;--------------------------------------------------------
                             35 ;--------------------------------------------------------
                             36 ; ram data
                             37 ;--------------------------------------------------------
                             38 	.area _DATA
                             39 ;--------------------------------------------------------
                             40 ; ram data
                             41 ;--------------------------------------------------------
                             42 	.area _INITIALIZED
                             43 ;--------------------------------------------------------
                             44 ; absolute external ram data
                             45 ;--------------------------------------------------------
                             46 	.area _DABS (ABS)
                             47 ;--------------------------------------------------------
                             48 ; global & static initialisations
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _GSINIT
                             52 	.area _GSFINAL
                             53 	.area _GSINIT
                             54 ;--------------------------------------------------------
                             55 ; Home
                             56 ;--------------------------------------------------------
                             57 	.area _HOME
                             58 	.area _HOME
                             59 ;--------------------------------------------------------
                             60 ; code
                             61 ;--------------------------------------------------------
                             62 	.area _CODE
                             63 ;src/State_Options.c:13: void state_options_enter(){
                             64 ;	---------------------------------
                             65 ; Function state_options_enter
                             66 ; ---------------------------------
   3AE2                      67 _state_options_enter::
                             68 ;src/State_Options.c:14: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[4], 34, 80);
   3AE2 21 2C 1C      [10]   69 	ld	hl, #_g_colors + 4
   3AE5 46            [ 7]   70 	ld	b,(hl)
   3AE6 21 22 50      [10]   71 	ld	hl,#0x5022
   3AE9 E5            [11]   72 	push	hl
   3AEA C5            [11]   73 	push	bc
   3AEB 33            [ 6]   74 	inc	sp
   3AEC 21 97 C2      [10]   75 	ld	hl,#0xC297
   3AEF E5            [11]   76 	push	hl
   3AF0 CD 2F 85      [17]   77 	call	_cpct_drawSolidBox
   3AF3 F1            [10]   78 	pop	af
   3AF4 F1            [10]   79 	pop	af
   3AF5 33            [ 6]   80 	inc	sp
                             81 ;src/State_Options.c:15: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 68), g_colors[1], 32, 72);
   3AF6 21 29 1C      [10]   82 	ld	hl, #_g_colors + 1
   3AF9 46            [ 7]   83 	ld	b,(hl)
   3AFA 21 20 48      [10]   84 	ld	hl,#0x4820
   3AFD E5            [11]   85 	push	hl
   3AFE C5            [11]   86 	push	bc
   3AFF 33            [ 6]   87 	inc	sp
   3B00 21 98 E2      [10]   88 	ld	hl,#0xE298
   3B03 E5            [11]   89 	push	hl
   3B04 CD 2F 85      [17]   90 	call	_cpct_drawSolidBox
   3B07 F1            [10]   91 	pop	af
   3B08 F1            [10]   92 	pop	af
   3B09 33            [ 6]   93 	inc	sp
                             94 ;src/State_Options.c:16: ui_options_init();
   3B0A CD F8 4A      [17]   95 	call	_ui_options_init
                             96 ;src/State_Options.c:17: ui_options_render_all();
   3B0D C3 C7 4B      [10]   97 	jp  _ui_options_render_all
                             98 ;src/State_Options.c:20: void state_options_return(){
                             99 ;	---------------------------------
                            100 ; Function state_options_return
                            101 ; ---------------------------------
   3B10                     102 _state_options_return::
                            103 ;src/State_Options.c:22: }
   3B10 C9            [10]  104 	ret
                            105 ;src/State_Options.c:24: void state_options_input(){
                            106 ;	---------------------------------
                            107 ; Function state_options_input
                            108 ; ---------------------------------
   3B11                     109 _state_options_input::
                            110 ;src/State_Options.c:25: if(cpct_isKeyPressed(Key_CursorUp)){
   3B11 21 00 01      [10]  111 	ld	hl,#0x0100
   3B14 CD B3 7A      [17]  112 	call	_cpct_isKeyPressed
   3B17 7D            [ 4]  113 	ld	a,l
   3B18 B7            [ 4]  114 	or	a, a
   3B19 28 06         [12]  115 	jr	Z,00107$
                            116 ;src/State_Options.c:26: ui_options_previous_entry();
   3B1B CD 28 4B      [17]  117 	call	_ui_options_previous_entry
                            118 ;src/State_Options.c:27: statemanager_input_accepted();
   3B1E C3 FB 39      [10]  119 	jp  _statemanager_input_accepted
   3B21                     120 00107$:
                            121 ;src/State_Options.c:29: else if(cpct_isKeyPressed(Key_CursorDown)){
   3B21 21 00 04      [10]  122 	ld	hl,#0x0400
   3B24 CD B3 7A      [17]  123 	call	_cpct_isKeyPressed
   3B27 7D            [ 4]  124 	ld	a,l
   3B28 B7            [ 4]  125 	or	a, a
   3B29 28 06         [12]  126 	jr	Z,00104$
                            127 ;src/State_Options.c:30: ui_options_next_entry();
   3B2B CD 1A 4B      [17]  128 	call	_ui_options_next_entry
                            129 ;src/State_Options.c:31: statemanager_input_accepted();
   3B2E C3 FB 39      [10]  130 	jp  _statemanager_input_accepted
   3B31                     131 00104$:
                            132 ;src/State_Options.c:33: else if(cpct_isKeyPressed(Key_Return)){
   3B31 21 02 04      [10]  133 	ld	hl,#0x0402
   3B34 CD B3 7A      [17]  134 	call	_cpct_isKeyPressed
   3B37 7D            [ 4]  135 	ld	a,l
   3B38 B7            [ 4]  136 	or	a, a
   3B39 C8            [11]  137 	ret	Z
                            138 ;src/State_Options.c:34: ui_options_select_entry();
   3B3A CD 38 4B      [17]  139 	call	_ui_options_select_entry
                            140 ;src/State_Options.c:35: statemanager_input_accepted();
   3B3D C3 FB 39      [10]  141 	jp  _statemanager_input_accepted
                            142 ;src/State_Options.c:39: void state_options_update(){
                            143 ;	---------------------------------
                            144 ; Function state_options_update
                            145 ; ---------------------------------
   3B40                     146 _state_options_update::
                            147 ;src/State_Options.c:40: if(ui_options_is_selected()){
   3B40 CD 12 4B      [17]  148 	call	_ui_options_is_selected
   3B43 7D            [ 4]  149 	ld	a,l
   3B44 B7            [ 4]  150 	or	a, a
   3B45 CA 3E 4B      [10]  151 	jp	Z,_ui_options_unselect_entry
                            152 ;src/State_Options.c:41: ui_options_render_refresh();
   3B48 CD AE 4B      [17]  153 	call	_ui_options_render_refresh
                            154 ;src/State_Options.c:42: switch(ui_options_get_entry()){
   3B4B CD 0A 4B      [17]  155 	call	_ui_options_get_entry
   3B4E 5D            [ 4]  156 	ld	e,l
   3B4F 3E 02         [ 7]  157 	ld	a,#0x02
   3B51 93            [ 4]  158 	sub	a, e
   3B52 DA 3E 4B      [10]  159 	jp	C,_ui_options_unselect_entry
   3B55 16 00         [ 7]  160 	ld	d,#0x00
   3B57 21 5D 3B      [10]  161 	ld	hl,#00123$
   3B5A 19            [11]  162 	add	hl,de
   3B5B 19            [11]  163 	add	hl,de
                            164 ;src/State_Options.c:43: case 0:{//Textures
   3B5C E9            [ 4]  165 	jp	(hl)
   3B5D                     166 00123$:
   3B5D 18 04         [12]  167 	jr	00101$
   3B5F 18 15         [12]  168 	jr	00102$
   3B61 18 2F         [12]  169 	jr	00105$
   3B63                     170 00101$:
                            171 ;src/State_Options.c:44: textures_on=!textures_on;
   3B63 3A D8 86      [13]  172 	ld	a,(#_textures_on + 0)
   3B66 D6 01         [ 7]  173 	sub	a,#0x01
   3B68 3E 00         [ 7]  174 	ld	a,#0x00
   3B6A 17            [ 4]  175 	rla
   3B6B 4F            [ 4]  176 	ld	c,a
   3B6C 21 D8 86      [10]  177 	ld	hl,#_textures_on + 0
   3B6F 71            [ 7]  178 	ld	(hl), c
                            179 ;src/State_Options.c:45: ui_options_set_strings();
   3B70 CD AD 4A      [17]  180 	call	_ui_options_set_strings
                            181 ;src/State_Options.c:46: break;
   3B73 C3 3E 4B      [10]  182 	jp	_ui_options_unselect_entry
                            183 ;src/State_Options.c:48: case 1:{//Sound
   3B76                     184 00102$:
                            185 ;src/State_Options.c:49: music_on=!music_on;
   3B76 3A D7 86      [13]  186 	ld	a,(#_music_on + 0)
   3B79 D6 01         [ 7]  187 	sub	a,#0x01
   3B7B 3E 00         [ 7]  188 	ld	a,#0x00
   3B7D 17            [ 4]  189 	rla
   3B7E 4F            [ 4]  190 	ld	c,a
   3B7F 21 D7 86      [10]  191 	ld	hl,#_music_on + 0
   3B82 71            [ 7]  192 	ld	(hl), c
                            193 ;src/State_Options.c:50: if(!music_on) cpct_akp_stop ();
   3B83 3A D7 86      [13]  194 	ld	a,(#_music_on + 0)
   3B86 B7            [ 4]  195 	or	a, a
   3B87 20 03         [12]  196 	jr	NZ,00104$
   3B89 CD 47 82      [17]  197 	call	_cpct_akp_stop
   3B8C                     198 00104$:
                            199 ;src/State_Options.c:51: ui_options_set_strings();
   3B8C CD AD 4A      [17]  200 	call	_ui_options_set_strings
                            201 ;src/State_Options.c:52: break;
   3B8F C3 3E 4B      [10]  202 	jp	_ui_options_unselect_entry
                            203 ;src/State_Options.c:54: case 2:{
   3B92                     204 00105$:
                            205 ;src/State_Options.c:55: statemanager_close_state();
   3B92 CD A4 3A      [17]  206 	call	_statemanager_close_state
                            207 ;src/State_Options.c:58: }
                            208 ;src/State_Options.c:60: ui_options_unselect_entry();
   3B95 C3 3E 4B      [10]  209 	jp  _ui_options_unselect_entry
                            210 ;src/State_Options.c:63: void state_options_render(){
                            211 ;	---------------------------------
                            212 ; Function state_options_render
                            213 ; ---------------------------------
   3B98                     214 _state_options_render::
                            215 ;src/State_Options.c:64: ui_options_render_refresh();
   3B98 C3 AE 4B      [10]  216 	jp  _ui_options_render_refresh
                            217 ;src/State_Options.c:67: void state_options_exit(){
                            218 ;	---------------------------------
                            219 ; Function state_options_exit
                            220 ; ---------------------------------
   3B9B                     221 _state_options_exit::
                            222 ;src/State_Options.c:68: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[1], 34, 80);
   3B9B 21 29 1C      [10]  223 	ld	hl, #(_g_colors + 0x0001) + 0
   3B9E 46            [ 7]  224 	ld	b,(hl)
   3B9F 21 22 50      [10]  225 	ld	hl,#0x5022
   3BA2 E5            [11]  226 	push	hl
   3BA3 C5            [11]  227 	push	bc
   3BA4 33            [ 6]  228 	inc	sp
   3BA5 21 97 C2      [10]  229 	ld	hl,#0xC297
   3BA8 E5            [11]  230 	push	hl
   3BA9 CD 2F 85      [17]  231 	call	_cpct_drawSolidBox
   3BAC F1            [10]  232 	pop	af
   3BAD F1            [10]  233 	pop	af
   3BAE 33            [ 6]  234 	inc	sp
   3BAF C9            [10]  235 	ret
                            236 	.area _CODE
                            237 	.area _INITIALIZER
                            238 	.area _CABS (ABS)
