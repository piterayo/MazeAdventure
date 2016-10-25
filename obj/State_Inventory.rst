                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_Inventory
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _ui_inventory_render_all
                             12 	.globl _ui_inventory_render_refresh
                             13 	.globl _ui_inventory_unselect_entry
                             14 	.globl _ui_inventory_select_entry
                             15 	.globl _ui_inventory_previous_entry
                             16 	.globl _ui_inventory_next_entry
                             17 	.globl _ui_inventory_is_selected
                             18 	.globl _ui_inventory_get_entry
                             19 	.globl _ui_inventory_init
                             20 	.globl _item_use_scroll
                             21 	.globl _item_use_potion
                             22 	.globl _statemanager_input_accepted
                             23 	.globl _statemanager_close_state
                             24 	.globl _cpct_drawSolidBox
                             25 	.globl _cpct_isKeyPressed
                             26 	.globl _object_used
                             27 	.globl _state_inventory_enter
                             28 	.globl _state_inventory_return
                             29 	.globl _state_inventory_object_used
                             30 	.globl _state_inventory_input
                             31 	.globl _state_inventory_update
                             32 	.globl _state_inventory_render
                             33 	.globl _state_inventory_exit
                             34 ;--------------------------------------------------------
                             35 ; special function registers
                             36 ;--------------------------------------------------------
                             37 ;--------------------------------------------------------
                             38 ; ram data
                             39 ;--------------------------------------------------------
                             40 	.area _DATA
   7E69                      41 _object_used::
   7E69                      42 	.ds 1
                             43 ;--------------------------------------------------------
                             44 ; ram data
                             45 ;--------------------------------------------------------
                             46 	.area _INITIALIZED
                             47 ;--------------------------------------------------------
                             48 ; absolute external ram data
                             49 ;--------------------------------------------------------
                             50 	.area _DABS (ABS)
                             51 ;--------------------------------------------------------
                             52 ; global & static initialisations
                             53 ;--------------------------------------------------------
                             54 	.area _HOME
                             55 	.area _GSINIT
                             56 	.area _GSFINAL
                             57 	.area _GSINIT
                             58 ;--------------------------------------------------------
                             59 ; Home
                             60 ;--------------------------------------------------------
                             61 	.area _HOME
                             62 	.area _HOME
                             63 ;--------------------------------------------------------
                             64 ; code
                             65 ;--------------------------------------------------------
                             66 	.area _CODE
                             67 ;src/State_Inventory.c:17: void state_inventory_enter(){
                             68 ;	---------------------------------
                             69 ; Function state_inventory_enter
                             70 ; ---------------------------------
   3198                      71 _state_inventory_enter::
                             72 ;src/State_Inventory.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[4], 34, 80);
   3198 21 6A 1A      [10]   73 	ld	hl, #_g_colors + 4
   319B 46            [ 7]   74 	ld	b,(hl)
   319C 21 22 50      [10]   75 	ld	hl,#0x5022
   319F E5            [11]   76 	push	hl
   31A0 C5            [11]   77 	push	bc
   31A1 33            [ 6]   78 	inc	sp
   31A2 21 97 C2      [10]   79 	ld	hl,#0xC297
   31A5 E5            [11]   80 	push	hl
   31A6 CD 70 7C      [17]   81 	call	_cpct_drawSolidBox
   31A9 F1            [10]   82 	pop	af
   31AA F1            [10]   83 	pop	af
   31AB 33            [ 6]   84 	inc	sp
                             85 ;src/State_Inventory.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 68), g_colors[1], 32, 72);
   31AC 21 67 1A      [10]   86 	ld	hl, #_g_colors + 1
   31AF 46            [ 7]   87 	ld	b,(hl)
   31B0 21 20 48      [10]   88 	ld	hl,#0x4820
   31B3 E5            [11]   89 	push	hl
   31B4 C5            [11]   90 	push	bc
   31B5 33            [ 6]   91 	inc	sp
   31B6 21 98 E2      [10]   92 	ld	hl,#0xE298
   31B9 E5            [11]   93 	push	hl
   31BA CD 70 7C      [17]   94 	call	_cpct_drawSolidBox
   31BD F1            [10]   95 	pop	af
   31BE F1            [10]   96 	pop	af
   31BF 33            [ 6]   97 	inc	sp
                             98 ;src/State_Inventory.c:20: ui_inventory_init();
   31C0 CD D4 44      [17]   99 	call	_ui_inventory_init
                            100 ;src/State_Inventory.c:21: ui_inventory_render_all();
   31C3 CD BC 45      [17]  101 	call	_ui_inventory_render_all
                            102 ;src/State_Inventory.c:22: object_used=0;
   31C6 21 69 7E      [10]  103 	ld	hl,#_object_used + 0
   31C9 36 00         [10]  104 	ld	(hl), #0x00
   31CB C9            [10]  105 	ret
                            106 ;src/State_Inventory.c:25: void state_inventory_return(){
                            107 ;	---------------------------------
                            108 ; Function state_inventory_return
                            109 ; ---------------------------------
   31CC                     110 _state_inventory_return::
                            111 ;src/State_Inventory.c:27: }
   31CC C9            [10]  112 	ret
                            113 ;src/State_Inventory.c:29: u8 state_inventory_object_used(){
                            114 ;	---------------------------------
                            115 ; Function state_inventory_object_used
                            116 ; ---------------------------------
   31CD                     117 _state_inventory_object_used::
                            118 ;src/State_Inventory.c:30: return object_used;
   31CD FD 21 69 7E   [14]  119 	ld	iy,#_object_used
   31D1 FD 6E 00      [19]  120 	ld	l,0 (iy)
   31D4 C9            [10]  121 	ret
                            122 ;src/State_Inventory.c:33: void state_inventory_input(){
                            123 ;	---------------------------------
                            124 ; Function state_inventory_input
                            125 ; ---------------------------------
   31D5                     126 _state_inventory_input::
                            127 ;src/State_Inventory.c:34: if(cpct_isKeyPressed(Key_CursorUp)){
   31D5 21 00 01      [10]  128 	ld	hl,#0x0100
   31D8 CD 1D 7A      [17]  129 	call	_cpct_isKeyPressed
   31DB 7D            [ 4]  130 	ld	a,l
   31DC B7            [ 4]  131 	or	a, a
   31DD 28 06         [12]  132 	jr	Z,00107$
                            133 ;src/State_Inventory.c:35: ui_inventory_previous_entry();
   31DF CD 1D 45      [17]  134 	call	_ui_inventory_previous_entry
                            135 ;src/State_Inventory.c:36: statemanager_input_accepted();
   31E2 C3 90 38      [10]  136 	jp  _statemanager_input_accepted
   31E5                     137 00107$:
                            138 ;src/State_Inventory.c:38: else if(cpct_isKeyPressed(Key_CursorDown)){
   31E5 21 00 04      [10]  139 	ld	hl,#0x0400
   31E8 CD 1D 7A      [17]  140 	call	_cpct_isKeyPressed
   31EB 7D            [ 4]  141 	ld	a,l
   31EC B7            [ 4]  142 	or	a, a
   31ED 28 06         [12]  143 	jr	Z,00104$
                            144 ;src/State_Inventory.c:39: ui_inventory_next_entry();
   31EF CD 0F 45      [17]  145 	call	_ui_inventory_next_entry
                            146 ;src/State_Inventory.c:40: statemanager_input_accepted();
   31F2 C3 90 38      [10]  147 	jp  _statemanager_input_accepted
   31F5                     148 00104$:
                            149 ;src/State_Inventory.c:42: else if(cpct_isKeyPressed(Key_Return)){
   31F5 21 02 04      [10]  150 	ld	hl,#0x0402
   31F8 CD 1D 7A      [17]  151 	call	_cpct_isKeyPressed
   31FB 7D            [ 4]  152 	ld	a,l
   31FC B7            [ 4]  153 	or	a, a
   31FD C8            [11]  154 	ret	Z
                            155 ;src/State_Inventory.c:43: ui_inventory_select_entry();
   31FE CD 2D 45      [17]  156 	call	_ui_inventory_select_entry
                            157 ;src/State_Inventory.c:44: statemanager_input_accepted();
   3201 C3 90 38      [10]  158 	jp  _statemanager_input_accepted
                            159 ;src/State_Inventory.c:48: void state_inventory_update(){
                            160 ;	---------------------------------
                            161 ; Function state_inventory_update
                            162 ; ---------------------------------
   3204                     163 _state_inventory_update::
                            164 ;src/State_Inventory.c:49: if(ui_inventory_is_selected()){
   3204 CD 07 45      [17]  165 	call	_ui_inventory_is_selected
   3207 7D            [ 4]  166 	ld	a,l
   3208 B7            [ 4]  167 	or	a, a
   3209 CA 33 45      [10]  168 	jp	Z,_ui_inventory_unselect_entry
                            169 ;src/State_Inventory.c:50: ui_inventory_render_refresh();
   320C CD A3 45      [17]  170 	call	_ui_inventory_render_refresh
                            171 ;src/State_Inventory.c:51: switch(ui_inventory_get_entry()){
   320F CD FF 44      [17]  172 	call	_ui_inventory_get_entry
   3212 7D            [ 4]  173 	ld	a,l
   3213 B7            [ 4]  174 	or	a, a
   3214 28 05         [12]  175 	jr	Z,00101$
   3216 2D            [ 4]  176 	dec	l
   3217 28 0E         [12]  177 	jr	Z,00102$
   3219 18 16         [12]  178 	jr	00103$
                            179 ;src/State_Inventory.c:52: case 0:{//Potion
   321B                     180 00101$:
                            181 ;src/State_Inventory.c:53: object_used=item_use_potion();
   321B CD 38 0F      [17]  182 	call	_item_use_potion
   321E FD 21 69 7E   [14]  183 	ld	iy,#_object_used
   3222 FD 75 00      [19]  184 	ld	0 (iy),l
                            185 ;src/State_Inventory.c:54: break;
   3225 18 0A         [12]  186 	jr	00103$
                            187 ;src/State_Inventory.c:56: case 1:{//Scroll
   3227                     188 00102$:
                            189 ;src/State_Inventory.c:57: object_used=item_use_scroll();
   3227 CD 60 0F      [17]  190 	call	_item_use_scroll
   322A FD 21 69 7E   [14]  191 	ld	iy,#_object_used
   322E FD 75 00      [19]  192 	ld	0 (iy),l
                            193 ;src/State_Inventory.c:60: }
   3231                     194 00103$:
                            195 ;src/State_Inventory.c:61: statemanager_close_state();
   3231 CD 39 39      [17]  196 	call	_statemanager_close_state
                            197 ;src/State_Inventory.c:63: ui_inventory_unselect_entry();
   3234 C3 33 45      [10]  198 	jp  _ui_inventory_unselect_entry
                            199 ;src/State_Inventory.c:66: void state_inventory_render(){
                            200 ;	---------------------------------
                            201 ; Function state_inventory_render
                            202 ; ---------------------------------
   3237                     203 _state_inventory_render::
                            204 ;src/State_Inventory.c:67: ui_inventory_render_refresh();
   3237 C3 A3 45      [10]  205 	jp  _ui_inventory_render_refresh
                            206 ;src/State_Inventory.c:70: void state_inventory_exit(){
                            207 ;	---------------------------------
                            208 ; Function state_inventory_exit
                            209 ; ---------------------------------
   323A                     210 _state_inventory_exit::
                            211 ;src/State_Inventory.c:71: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[1], 34, 80);
   323A 21 67 1A      [10]  212 	ld	hl, #(_g_colors + 0x0001) + 0
   323D 46            [ 7]  213 	ld	b,(hl)
   323E 21 22 50      [10]  214 	ld	hl,#0x5022
   3241 E5            [11]  215 	push	hl
   3242 C5            [11]  216 	push	bc
   3243 33            [ 6]  217 	inc	sp
   3244 21 97 C2      [10]  218 	ld	hl,#0xC297
   3247 E5            [11]  219 	push	hl
   3248 CD 70 7C      [17]  220 	call	_cpct_drawSolidBox
   324B F1            [10]  221 	pop	af
   324C F1            [10]  222 	pop	af
   324D 33            [ 6]  223 	inc	sp
   324E C9            [10]  224 	ret
                            225 	.area _CODE
                            226 	.area _INITIALIZER
                            227 	.area _CABS (ABS)
