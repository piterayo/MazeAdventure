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
                             28 	.globl _state_mainmenu_input
                             29 	.globl _state_mainmenu_update
                             30 	.globl _state_mainmenu_render
                             31 	.globl _state_mainmenu_exit
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
                             63 ;src/State_MainMenu.c:16: void state_mainmenu_enter(){
                             64 ;	---------------------------------
                             65 ; Function state_mainmenu_enter
                             66 ; ---------------------------------
   1BAD                      67 _state_mainmenu_enter::
                             68 ;src/State_MainMenu.c:17: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1BAD 21 B3 0A      [10]   69 	ld	hl,#_g_colors+1
   1BB0 46            [ 7]   70 	ld	b,(hl)
   1BB1 21 00 40      [10]   71 	ld	hl,#0x4000
   1BB4 E5            [11]   72 	push	hl
   1BB5 C5            [11]   73 	push	bc
   1BB6 33            [ 6]   74 	inc	sp
   1BB7 26 C0         [ 7]   75 	ld	h, #0xC0
   1BB9 E5            [11]   76 	push	hl
   1BBA CD F1 46      [17]   77 	call	_cpct_memset
                             78 ;src/State_MainMenu.c:18: print_transparent_text("MAIN MENU", CPCT_VMEM_START, 3);
   1BBD 3E 03         [ 7]   79 	ld	a,#0x03
   1BBF F5            [11]   80 	push	af
   1BC0 33            [ 6]   81 	inc	sp
   1BC1 21 00 C0      [10]   82 	ld	hl,#0xC000
   1BC4 E5            [11]   83 	push	hl
   1BC5 21 D9 1B      [10]   84 	ld	hl,#___str_0
   1BC8 E5            [11]   85 	push	hl
   1BC9 CD AB 21      [17]   86 	call	_print_transparent_text
   1BCC F1            [10]   87 	pop	af
   1BCD F1            [10]   88 	pop	af
   1BCE 33            [ 6]   89 	inc	sp
                             90 ;src/State_MainMenu.c:19: ui_mainmenu_init();
   1BCF CD 0B 27      [17]   91 	call	_ui_mainmenu_init
                             92 ;src/State_MainMenu.c:20: ui_mainmenu_render_all();
   1BD2 CD 35 28      [17]   93 	call	_ui_mainmenu_render_all
                             94 ;src/State_MainMenu.c:21: state_mainmenu_render();
   1BD5 CD 58 1C      [17]   95 	call	_state_mainmenu_render
   1BD8 C9            [10]   96 	ret
   1BD9                      97 ___str_0:
   1BD9 4D 41 49 4E 20 4D    98 	.ascii "MAIN MENU"
        45 4E 55
   1BE2 00                   99 	.db 0x00
                            100 ;src/State_MainMenu.c:24: void state_mainmenu_input(){
                            101 ;	---------------------------------
                            102 ; Function state_mainmenu_input
                            103 ; ---------------------------------
   1BE3                     104 _state_mainmenu_input::
                            105 ;src/State_MainMenu.c:25: if(cpct_isKeyPressed(Key_CursorUp)){
   1BE3 21 00 01      [10]  106 	ld	hl,#0x0100
   1BE6 CD 44 45      [17]  107 	call	_cpct_isKeyPressed
   1BE9 7D            [ 4]  108 	ld	a,l
   1BEA B7            [ 4]  109 	or	a, a
   1BEB 28 06         [12]  110 	jr	Z,00107$
                            111 ;src/State_MainMenu.c:26: ui_mainmenu_previous_entry();
   1BED CD 66 27      [17]  112 	call	_ui_mainmenu_previous_entry
                            113 ;src/State_MainMenu.c:27: statemanager_input_accepted();
   1BF0 C3 1D 1D      [10]  114 	jp  _statemanager_input_accepted
   1BF3                     115 00107$:
                            116 ;src/State_MainMenu.c:29: else if(cpct_isKeyPressed(Key_CursorDown)){
   1BF3 21 00 04      [10]  117 	ld	hl,#0x0400
   1BF6 CD 44 45      [17]  118 	call	_cpct_isKeyPressed
   1BF9 7D            [ 4]  119 	ld	a,l
   1BFA B7            [ 4]  120 	or	a, a
   1BFB 28 06         [12]  121 	jr	Z,00104$
                            122 ;src/State_MainMenu.c:30: ui_mainmenu_next_entry();
   1BFD CD 58 27      [17]  123 	call	_ui_mainmenu_next_entry
                            124 ;src/State_MainMenu.c:31: statemanager_input_accepted();
   1C00 C3 1D 1D      [10]  125 	jp  _statemanager_input_accepted
   1C03                     126 00104$:
                            127 ;src/State_MainMenu.c:33: else if(cpct_isKeyPressed(Key_Return)){
   1C03 21 02 04      [10]  128 	ld	hl,#0x0402
   1C06 CD 44 45      [17]  129 	call	_cpct_isKeyPressed
   1C09 7D            [ 4]  130 	ld	a,l
   1C0A B7            [ 4]  131 	or	a, a
   1C0B C8            [11]  132 	ret	Z
                            133 ;src/State_MainMenu.c:34: ui_mainmenu_select_entry();
   1C0C CD 7C 27      [17]  134 	call	_ui_mainmenu_select_entry
                            135 ;src/State_MainMenu.c:35: statemanager_input_accepted();
   1C0F C3 1D 1D      [10]  136 	jp  _statemanager_input_accepted
                            137 ;src/State_MainMenu.c:39: void state_mainmenu_update(){
                            138 ;	---------------------------------
                            139 ; Function state_mainmenu_update
                            140 ; ---------------------------------
   1C12                     141 _state_mainmenu_update::
                            142 ;src/State_MainMenu.c:40: if(ui_mainmenu_is_selected()){
   1C12 CD CA 28      [17]  143 	call	_ui_mainmenu_is_selected
   1C15 7D            [ 4]  144 	ld	a,l
   1C16 B7            [ 4]  145 	or	a, a
   1C17 C8            [11]  146 	ret	Z
                            147 ;src/State_MainMenu.c:41: ui_mainmenu_render_refresh();
   1C18 CD 82 27      [17]  148 	call	_ui_mainmenu_render_refresh
                            149 ;src/State_MainMenu.c:42: switch(ui_mainmenu_get_entry()){
   1C1B CD C2 28      [17]  150 	call	_ui_mainmenu_get_entry
   1C1E 5D            [ 4]  151 	ld	e,l
   1C1F 3E 04         [ 7]  152 	ld	a,#0x04
   1C21 93            [ 4]  153 	sub	a, e
   1C22 DA 76 27      [10]  154 	jp	C,_ui_mainmenu_unselect_entry
   1C25 16 00         [ 7]  155 	ld	d,#0x00
   1C27 21 2D 1C      [10]  156 	ld	hl,#00119$
   1C2A 19            [11]  157 	add	hl,de
   1C2B 19            [11]  158 	add	hl,de
                            159 ;src/State_MainMenu.c:43: case 0:{
   1C2C E9            [ 4]  160 	jp	(hl)
   1C2D                     161 00119$:
   1C2D 18 08         [12]  162 	jr	00101$
   1C2F 18 24         [12]  163 	jr	00106$
   1C31 18 22         [12]  164 	jr	00106$
   1C33 18 20         [12]  165 	jr	00106$
   1C35 18 1B         [12]  166 	jr	00105$
   1C37                     167 00101$:
                            168 ;src/State_MainMenu.c:44: level_set_level(0);
   1C37 AF            [ 4]  169 	xor	a, a
   1C38 F5            [11]  170 	push	af
   1C39 33            [ 6]  171 	inc	sp
   1C3A CD F4 00      [17]  172 	call	_level_set_level
   1C3D 33            [ 6]  173 	inc	sp
                            174 ;src/State_MainMenu.c:45: statemanager_set_state(STATE_LOADLEVEL);
   1C3E 3E 03         [ 7]  175 	ld	a,#0x03
   1C40 F5            [11]  176 	push	af
   1C41 33            [ 6]  177 	inc	sp
   1C42 CD 23 1D      [17]  178 	call	_statemanager_set_state
   1C45 33            [ 6]  179 	inc	sp
                            180 ;src/State_MainMenu.c:46: break;
   1C46 C3 76 27      [10]  181 	jp	_ui_mainmenu_unselect_entry
                            182 ;src/State_MainMenu.c:48: case 1:{
                            183 ;src/State_MainMenu.c:50: break;
   1C49 C3 76 27      [10]  184 	jp	_ui_mainmenu_unselect_entry
                            185 ;src/State_MainMenu.c:52: case 2:{
                            186 ;src/State_MainMenu.c:54: break;
   1C4C C3 76 27      [10]  187 	jp	_ui_mainmenu_unselect_entry
                            188 ;src/State_MainMenu.c:56: case 3:{
                            189 ;src/State_MainMenu.c:58: break;
   1C4F C3 76 27      [10]  190 	jp	_ui_mainmenu_unselect_entry
                            191 ;src/State_MainMenu.c:60: case 4:{
   1C52                     192 00105$:
                            193 ;src/State_MainMenu.c:61: statemanager_exit_game();
   1C52 CD EA 1D      [17]  194 	call	_statemanager_exit_game
                            195 ;src/State_MainMenu.c:64: }
   1C55                     196 00106$:
                            197 ;src/State_MainMenu.c:65: ui_mainmenu_unselect_entry();
   1C55 C3 76 27      [10]  198 	jp  _ui_mainmenu_unselect_entry
                            199 ;src/State_MainMenu.c:69: void state_mainmenu_render(){
                            200 ;	---------------------------------
                            201 ; Function state_mainmenu_render
                            202 ; ---------------------------------
   1C58                     203 _state_mainmenu_render::
                            204 ;src/State_MainMenu.c:70: ui_mainmenu_render_refresh();
   1C58 C3 82 27      [10]  205 	jp  _ui_mainmenu_render_refresh
                            206 ;src/State_MainMenu.c:73: void state_mainmenu_exit(){
                            207 ;	---------------------------------
                            208 ; Function state_mainmenu_exit
                            209 ; ---------------------------------
   1C5B                     210 _state_mainmenu_exit::
                            211 ;src/State_MainMenu.c:75: }
   1C5B C9            [10]  212 	ret
                            213 	.area _CODE
                            214 	.area _INITIALIZER
                            215 	.area _CABS (ABS)
