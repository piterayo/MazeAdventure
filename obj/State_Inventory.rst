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
   7DB1                      41 _object_used::
   7DB1                      42 	.ds 1
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
   31BE                      71 _state_inventory_enter::
                             72 ;src/State_Inventory.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[4], 34, 80);
   31BE 21 B3 1A      [10]   73 	ld	hl, #_g_colors + 4
   31C1 46            [ 7]   74 	ld	b,(hl)
   31C2 21 22 50      [10]   75 	ld	hl,#0x5022
   31C5 E5            [11]   76 	push	hl
   31C6 C5            [11]   77 	push	bc
   31C7 33            [ 6]   78 	inc	sp
   31C8 21 97 C2      [10]   79 	ld	hl,#0xC297
   31CB E5            [11]   80 	push	hl
   31CC CD B8 7B      [17]   81 	call	_cpct_drawSolidBox
   31CF F1            [10]   82 	pop	af
   31D0 F1            [10]   83 	pop	af
   31D1 33            [ 6]   84 	inc	sp
                             85 ;src/State_Inventory.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 68), g_colors[1], 32, 72);
   31D2 21 B0 1A      [10]   86 	ld	hl, #_g_colors + 1
   31D5 46            [ 7]   87 	ld	b,(hl)
   31D6 21 20 48      [10]   88 	ld	hl,#0x4820
   31D9 E5            [11]   89 	push	hl
   31DA C5            [11]   90 	push	bc
   31DB 33            [ 6]   91 	inc	sp
   31DC 21 98 E2      [10]   92 	ld	hl,#0xE298
   31DF E5            [11]   93 	push	hl
   31E0 CD B8 7B      [17]   94 	call	_cpct_drawSolidBox
   31E3 F1            [10]   95 	pop	af
   31E4 F1            [10]   96 	pop	af
   31E5 33            [ 6]   97 	inc	sp
                             98 ;src/State_Inventory.c:20: ui_inventory_init();
   31E6 CD FA 44      [17]   99 	call	_ui_inventory_init
                            100 ;src/State_Inventory.c:21: ui_inventory_render_all();
   31E9 CD E2 45      [17]  101 	call	_ui_inventory_render_all
                            102 ;src/State_Inventory.c:22: object_used=0;
   31EC 21 B1 7D      [10]  103 	ld	hl,#_object_used + 0
   31EF 36 00         [10]  104 	ld	(hl), #0x00
   31F1 C9            [10]  105 	ret
                            106 ;src/State_Inventory.c:25: void state_inventory_return(){
                            107 ;	---------------------------------
                            108 ; Function state_inventory_return
                            109 ; ---------------------------------
   31F2                     110 _state_inventory_return::
                            111 ;src/State_Inventory.c:27: }
   31F2 C9            [10]  112 	ret
                            113 ;src/State_Inventory.c:29: u8 state_inventory_object_used(){
                            114 ;	---------------------------------
                            115 ; Function state_inventory_object_used
                            116 ; ---------------------------------
   31F3                     117 _state_inventory_object_used::
                            118 ;src/State_Inventory.c:30: return object_used;
   31F3 FD 21 B1 7D   [14]  119 	ld	iy,#_object_used
   31F7 FD 6E 00      [19]  120 	ld	l,0 (iy)
   31FA C9            [10]  121 	ret
                            122 ;src/State_Inventory.c:33: void state_inventory_input(){
                            123 ;	---------------------------------
                            124 ; Function state_inventory_input
                            125 ; ---------------------------------
   31FB                     126 _state_inventory_input::
                            127 ;src/State_Inventory.c:34: if(cpct_isKeyPressed(Key_CursorUp)){
   31FB 21 00 01      [10]  128 	ld	hl,#0x0100
   31FE CD 65 79      [17]  129 	call	_cpct_isKeyPressed
   3201 7D            [ 4]  130 	ld	a,l
   3202 B7            [ 4]  131 	or	a, a
   3203 28 06         [12]  132 	jr	Z,00107$
                            133 ;src/State_Inventory.c:35: ui_inventory_previous_entry();
   3205 CD 43 45      [17]  134 	call	_ui_inventory_previous_entry
                            135 ;src/State_Inventory.c:36: statemanager_input_accepted();
   3208 C3 B6 38      [10]  136 	jp  _statemanager_input_accepted
   320B                     137 00107$:
                            138 ;src/State_Inventory.c:38: else if(cpct_isKeyPressed(Key_CursorDown)){
   320B 21 00 04      [10]  139 	ld	hl,#0x0400
   320E CD 65 79      [17]  140 	call	_cpct_isKeyPressed
   3211 7D            [ 4]  141 	ld	a,l
   3212 B7            [ 4]  142 	or	a, a
   3213 28 06         [12]  143 	jr	Z,00104$
                            144 ;src/State_Inventory.c:39: ui_inventory_next_entry();
   3215 CD 35 45      [17]  145 	call	_ui_inventory_next_entry
                            146 ;src/State_Inventory.c:40: statemanager_input_accepted();
   3218 C3 B6 38      [10]  147 	jp  _statemanager_input_accepted
   321B                     148 00104$:
                            149 ;src/State_Inventory.c:42: else if(cpct_isKeyPressed(Key_Return)){
   321B 21 02 04      [10]  150 	ld	hl,#0x0402
   321E CD 65 79      [17]  151 	call	_cpct_isKeyPressed
   3221 7D            [ 4]  152 	ld	a,l
   3222 B7            [ 4]  153 	or	a, a
   3223 C8            [11]  154 	ret	Z
                            155 ;src/State_Inventory.c:43: ui_inventory_select_entry();
   3224 CD 53 45      [17]  156 	call	_ui_inventory_select_entry
                            157 ;src/State_Inventory.c:44: statemanager_input_accepted();
   3227 C3 B6 38      [10]  158 	jp  _statemanager_input_accepted
                            159 ;src/State_Inventory.c:48: void state_inventory_update(){
                            160 ;	---------------------------------
                            161 ; Function state_inventory_update
                            162 ; ---------------------------------
   322A                     163 _state_inventory_update::
                            164 ;src/State_Inventory.c:49: if(ui_inventory_is_selected()){
   322A CD 2D 45      [17]  165 	call	_ui_inventory_is_selected
   322D 7D            [ 4]  166 	ld	a,l
   322E B7            [ 4]  167 	or	a, a
   322F CA 59 45      [10]  168 	jp	Z,_ui_inventory_unselect_entry
                            169 ;src/State_Inventory.c:50: ui_inventory_render_refresh();
   3232 CD C9 45      [17]  170 	call	_ui_inventory_render_refresh
                            171 ;src/State_Inventory.c:51: switch(ui_inventory_get_entry()){
   3235 CD 25 45      [17]  172 	call	_ui_inventory_get_entry
   3238 7D            [ 4]  173 	ld	a,l
   3239 B7            [ 4]  174 	or	a, a
   323A 28 05         [12]  175 	jr	Z,00101$
   323C 2D            [ 4]  176 	dec	l
   323D 28 0E         [12]  177 	jr	Z,00102$
   323F 18 16         [12]  178 	jr	00103$
                            179 ;src/State_Inventory.c:52: case 0:{//Potion
   3241                     180 00101$:
                            181 ;src/State_Inventory.c:53: object_used=item_use_potion();
   3241 CD 81 0F      [17]  182 	call	_item_use_potion
   3244 FD 21 B1 7D   [14]  183 	ld	iy,#_object_used
   3248 FD 75 00      [19]  184 	ld	0 (iy),l
                            185 ;src/State_Inventory.c:54: break;
   324B 18 0A         [12]  186 	jr	00103$
                            187 ;src/State_Inventory.c:56: case 1:{//Scroll
   324D                     188 00102$:
                            189 ;src/State_Inventory.c:57: object_used=item_use_scroll();
   324D CD A9 0F      [17]  190 	call	_item_use_scroll
   3250 FD 21 B1 7D   [14]  191 	ld	iy,#_object_used
   3254 FD 75 00      [19]  192 	ld	0 (iy),l
                            193 ;src/State_Inventory.c:60: }
   3257                     194 00103$:
                            195 ;src/State_Inventory.c:61: statemanager_close_state();
   3257 CD 5F 39      [17]  196 	call	_statemanager_close_state
                            197 ;src/State_Inventory.c:63: ui_inventory_unselect_entry();
   325A C3 59 45      [10]  198 	jp  _ui_inventory_unselect_entry
                            199 ;src/State_Inventory.c:66: void state_inventory_render(){
                            200 ;	---------------------------------
                            201 ; Function state_inventory_render
                            202 ; ---------------------------------
   325D                     203 _state_inventory_render::
                            204 ;src/State_Inventory.c:67: ui_inventory_render_refresh();
   325D C3 C9 45      [10]  205 	jp  _ui_inventory_render_refresh
                            206 ;src/State_Inventory.c:70: void state_inventory_exit(){
                            207 ;	---------------------------------
                            208 ; Function state_inventory_exit
                            209 ; ---------------------------------
   3260                     210 _state_inventory_exit::
                            211 ;src/State_Inventory.c:71: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[1], 34, 80);
   3260 21 B0 1A      [10]  212 	ld	hl, #(_g_colors + 0x0001) + 0
   3263 46            [ 7]  213 	ld	b,(hl)
   3264 21 22 50      [10]  214 	ld	hl,#0x5022
   3267 E5            [11]  215 	push	hl
   3268 C5            [11]  216 	push	bc
   3269 33            [ 6]  217 	inc	sp
   326A 21 97 C2      [10]  218 	ld	hl,#0xC297
   326D E5            [11]  219 	push	hl
   326E CD B8 7B      [17]  220 	call	_cpct_drawSolidBox
   3271 F1            [10]  221 	pop	af
   3272 F1            [10]  222 	pop	af
   3273 33            [ 6]  223 	inc	sp
   3274 C9            [10]  224 	ret
                            225 	.area _CODE
                            226 	.area _INITIALIZER
                            227 	.area _CABS (ABS)
