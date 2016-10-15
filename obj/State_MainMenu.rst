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
                             11 	.globl _level_set_level
                             12 	.globl _print_transparent_text
                             13 	.globl _statemanager_exit_game
                             14 	.globl _statemanager_input_accepted
                             15 	.globl _statemanager_set_state
                             16 	.globl _ui_mainmenu_render_refresh
                             17 	.globl _ui_mainmenu_render_all
                             18 	.globl _ui_mainmenu_unselect_entry
                             19 	.globl _ui_mainmenu_select_entry
                             20 	.globl _ui_mainmenu_previous_entry
                             21 	.globl _ui_mainmenu_next_entry
                             22 	.globl _ui_mainmenu_is_selected
                             23 	.globl _ui_mainmenu_get_entry
                             24 	.globl _ui_mainmenu_init
                             25 	.globl _cpct_isKeyPressed
                             26 	.globl _cpct_memset
                             27 	.globl _state_mainmenu_enter
                             28 	.globl _state_mainmenu_return
                             29 	.globl _state_mainmenu_input
                             30 	.globl _state_mainmenu_update
                             31 	.globl _state_mainmenu_render
                             32 	.globl _state_mainmenu_exit
                             33 ;--------------------------------------------------------
                             34 ; special function registers
                             35 ;--------------------------------------------------------
                             36 ;--------------------------------------------------------
                             37 ; ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DATA
                             40 ;--------------------------------------------------------
                             41 ; ram data
                             42 ;--------------------------------------------------------
                             43 	.area _INITIALIZED
                             44 ;--------------------------------------------------------
                             45 ; absolute external ram data
                             46 ;--------------------------------------------------------
                             47 	.area _DABS (ABS)
                             48 ;--------------------------------------------------------
                             49 ; global & static initialisations
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _GSINIT
                             53 	.area _GSFINAL
                             54 	.area _GSINIT
                             55 ;--------------------------------------------------------
                             56 ; Home
                             57 ;--------------------------------------------------------
                             58 	.area _HOME
                             59 	.area _HOME
                             60 ;--------------------------------------------------------
                             61 ; code
                             62 ;--------------------------------------------------------
                             63 	.area _CODE
                             64 ;src/State_MainMenu.c:16: void state_mainmenu_enter(){
                             65 ;	---------------------------------
                             66 ; Function state_mainmenu_enter
                             67 ; ---------------------------------
   1BEA                      68 _state_mainmenu_enter::
                             69 ;src/State_MainMenu.c:17: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1BEA 21 A4 0A      [10]   70 	ld	hl,#_g_colors+1
   1BED 46            [ 7]   71 	ld	b,(hl)
   1BEE 21 00 40      [10]   72 	ld	hl,#0x4000
   1BF1 E5            [11]   73 	push	hl
   1BF2 C5            [11]   74 	push	bc
   1BF3 33            [ 6]   75 	inc	sp
   1BF4 26 C0         [ 7]   76 	ld	h, #0xC0
   1BF6 E5            [11]   77 	push	hl
   1BF7 CD A5 48      [17]   78 	call	_cpct_memset
                             79 ;src/State_MainMenu.c:18: print_transparent_text("MAIN MENU", CPCT_VMEM_START, 3);
   1BFA 3E 03         [ 7]   80 	ld	a,#0x03
   1BFC F5            [11]   81 	push	af
   1BFD 33            [ 6]   82 	inc	sp
   1BFE 21 00 C0      [10]   83 	ld	hl,#0xC000
   1C01 E5            [11]   84 	push	hl
   1C02 21 13 1C      [10]   85 	ld	hl,#___str_0
   1C05 E5            [11]   86 	push	hl
   1C06 CD 67 22      [17]   87 	call	_print_transparent_text
   1C09 F1            [10]   88 	pop	af
   1C0A F1            [10]   89 	pop	af
   1C0B 33            [ 6]   90 	inc	sp
                             91 ;src/State_MainMenu.c:21: ui_mainmenu_init();
   1C0C CD 40 28      [17]   92 	call	_ui_mainmenu_init
                             93 ;src/State_MainMenu.c:22: ui_mainmenu_render_all();
   1C0F CD 40 29      [17]   94 	call	_ui_mainmenu_render_all
   1C12 C9            [10]   95 	ret
   1C13                      96 ___str_0:
   1C13 4D 41 49 4E 20 4D    97 	.ascii "MAIN MENU"
        45 4E 55
   1C1C 00                   98 	.db 0x00
                             99 ;src/State_MainMenu.c:26: void state_mainmenu_return(){
                            100 ;	---------------------------------
                            101 ; Function state_mainmenu_return
                            102 ; ---------------------------------
   1C1D                     103 _state_mainmenu_return::
                            104 ;src/State_MainMenu.c:27: ui_mainmenu_render_all();
   1C1D C3 40 29      [10]  105 	jp  _ui_mainmenu_render_all
                            106 ;src/State_MainMenu.c:31: void state_mainmenu_input(){
                            107 ;	---------------------------------
                            108 ; Function state_mainmenu_input
                            109 ; ---------------------------------
   1C20                     110 _state_mainmenu_input::
                            111 ;src/State_MainMenu.c:32: if(cpct_isKeyPressed(Key_CursorUp)){
   1C20 21 00 01      [10]  112 	ld	hl,#0x0100
   1C23 CD F8 46      [17]  113 	call	_cpct_isKeyPressed
   1C26 7D            [ 4]  114 	ld	a,l
   1C27 B7            [ 4]  115 	or	a, a
   1C28 28 06         [12]  116 	jr	Z,00107$
                            117 ;src/State_MainMenu.c:33: ui_mainmenu_previous_entry();
   1C2A CD A4 28      [17]  118 	call	_ui_mainmenu_previous_entry
                            119 ;src/State_MainMenu.c:34: statemanager_input_accepted();
   1C2D C3 7F 1D      [10]  120 	jp  _statemanager_input_accepted
   1C30                     121 00107$:
                            122 ;src/State_MainMenu.c:36: else if(cpct_isKeyPressed(Key_CursorDown)){
   1C30 21 00 04      [10]  123 	ld	hl,#0x0400
   1C33 CD F8 46      [17]  124 	call	_cpct_isKeyPressed
   1C36 7D            [ 4]  125 	ld	a,l
   1C37 B7            [ 4]  126 	or	a, a
   1C38 28 06         [12]  127 	jr	Z,00104$
                            128 ;src/State_MainMenu.c:37: ui_mainmenu_next_entry();
   1C3A CD 96 28      [17]  129 	call	_ui_mainmenu_next_entry
                            130 ;src/State_MainMenu.c:38: statemanager_input_accepted();
   1C3D C3 7F 1D      [10]  131 	jp  _statemanager_input_accepted
   1C40                     132 00104$:
                            133 ;src/State_MainMenu.c:40: else if(cpct_isKeyPressed(Key_Return)){
   1C40 21 02 04      [10]  134 	ld	hl,#0x0402
   1C43 CD F8 46      [17]  135 	call	_cpct_isKeyPressed
   1C46 7D            [ 4]  136 	ld	a,l
   1C47 B7            [ 4]  137 	or	a, a
   1C48 C8            [11]  138 	ret	Z
                            139 ;src/State_MainMenu.c:41: ui_mainmenu_select_entry();
   1C49 CD BA 28      [17]  140 	call	_ui_mainmenu_select_entry
                            141 ;src/State_MainMenu.c:42: statemanager_input_accepted();
   1C4C C3 7F 1D      [10]  142 	jp  _statemanager_input_accepted
                            143 ;src/State_MainMenu.c:46: void state_mainmenu_update(){
                            144 ;	---------------------------------
                            145 ; Function state_mainmenu_update
                            146 ; ---------------------------------
   1C4F                     147 _state_mainmenu_update::
                            148 ;src/State_MainMenu.c:47: if(ui_mainmenu_is_selected()){
   1C4F CD 60 29      [17]  149 	call	_ui_mainmenu_is_selected
   1C52 7D            [ 4]  150 	ld	a,l
   1C53 B7            [ 4]  151 	or	a, a
   1C54 C8            [11]  152 	ret	Z
                            153 ;src/State_MainMenu.c:48: ui_mainmenu_render_refresh();
   1C55 CD 27 29      [17]  154 	call	_ui_mainmenu_render_refresh
                            155 ;src/State_MainMenu.c:49: switch(ui_mainmenu_get_entry()){
   1C58 CD 58 29      [17]  156 	call	_ui_mainmenu_get_entry
   1C5B 5D            [ 4]  157 	ld	e,l
   1C5C 3E 04         [ 7]  158 	ld	a,#0x04
   1C5E 93            [ 4]  159 	sub	a, e
   1C5F DA B4 28      [10]  160 	jp	C,_ui_mainmenu_unselect_entry
   1C62 16 00         [ 7]  161 	ld	d,#0x00
   1C64 21 6A 1C      [10]  162 	ld	hl,#00119$
   1C67 19            [11]  163 	add	hl,de
   1C68 19            [11]  164 	add	hl,de
                            165 ;src/State_MainMenu.c:50: case 0:{
   1C69 E9            [ 4]  166 	jp	(hl)
   1C6A                     167 00119$:
   1C6A 18 08         [12]  168 	jr	00101$
   1C6C 18 24         [12]  169 	jr	00106$
   1C6E 18 22         [12]  170 	jr	00106$
   1C70 18 20         [12]  171 	jr	00106$
   1C72 18 1B         [12]  172 	jr	00105$
   1C74                     173 00101$:
                            174 ;src/State_MainMenu.c:51: level_set_level(0);
   1C74 AF            [ 4]  175 	xor	a, a
   1C75 F5            [11]  176 	push	af
   1C76 33            [ 6]  177 	inc	sp
   1C77 CD E5 00      [17]  178 	call	_level_set_level
   1C7A 33            [ 6]  179 	inc	sp
                            180 ;src/State_MainMenu.c:52: statemanager_set_state(STATE_LOADLEVEL);
   1C7B 3E 03         [ 7]  181 	ld	a,#0x03
   1C7D F5            [11]  182 	push	af
   1C7E 33            [ 6]  183 	inc	sp
   1C7F CD 85 1D      [17]  184 	call	_statemanager_set_state
   1C82 33            [ 6]  185 	inc	sp
                            186 ;src/State_MainMenu.c:53: break;
   1C83 C3 B4 28      [10]  187 	jp	_ui_mainmenu_unselect_entry
                            188 ;src/State_MainMenu.c:55: case 1:{
                            189 ;src/State_MainMenu.c:57: break;
   1C86 C3 B4 28      [10]  190 	jp	_ui_mainmenu_unselect_entry
                            191 ;src/State_MainMenu.c:59: case 2:{
                            192 ;src/State_MainMenu.c:61: break;
   1C89 C3 B4 28      [10]  193 	jp	_ui_mainmenu_unselect_entry
                            194 ;src/State_MainMenu.c:63: case 3:{
                            195 ;src/State_MainMenu.c:65: break;
   1C8C C3 B4 28      [10]  196 	jp	_ui_mainmenu_unselect_entry
                            197 ;src/State_MainMenu.c:67: case 4:{
   1C8F                     198 00105$:
                            199 ;src/State_MainMenu.c:68: statemanager_exit_game();
   1C8F CD 55 1E      [17]  200 	call	_statemanager_exit_game
                            201 ;src/State_MainMenu.c:71: }
   1C92                     202 00106$:
                            203 ;src/State_MainMenu.c:72: ui_mainmenu_unselect_entry();
   1C92 C3 B4 28      [10]  204 	jp  _ui_mainmenu_unselect_entry
                            205 ;src/State_MainMenu.c:76: void state_mainmenu_render(){
                            206 ;	---------------------------------
                            207 ; Function state_mainmenu_render
                            208 ; ---------------------------------
   1C95                     209 _state_mainmenu_render::
                            210 ;src/State_MainMenu.c:77: ui_mainmenu_render_refresh();
   1C95 C3 27 29      [10]  211 	jp  _ui_mainmenu_render_refresh
                            212 ;src/State_MainMenu.c:80: void state_mainmenu_exit(){
                            213 ;	---------------------------------
                            214 ; Function state_mainmenu_exit
                            215 ; ---------------------------------
   1C98                     216 _state_mainmenu_exit::
                            217 ;src/State_MainMenu.c:82: }
   1C98 C9            [10]  218 	ret
                            219 	.area _CODE
                            220 	.area _INITIALIZER
                            221 	.area _CABS (ABS)
