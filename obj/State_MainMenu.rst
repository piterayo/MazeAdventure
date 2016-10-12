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
                             11 	.globl _statemanager_input_accepted
                             12 	.globl _statemanager_set_state
                             13 	.globl _cpct_isKeyPressed
                             14 	.globl _cpct_memset
                             15 	.globl _state_mainmenu_enter
                             16 	.globl _state_mainmenu_input
                             17 	.globl _state_mainmenu_update
                             18 	.globl _state_mainmenu_render
                             19 	.globl _state_mainmenu_exit
                             20 ;--------------------------------------------------------
                             21 ; special function registers
                             22 ;--------------------------------------------------------
                             23 ;--------------------------------------------------------
                             24 ; ram data
                             25 ;--------------------------------------------------------
                             26 	.area _DATA
                             27 ;--------------------------------------------------------
                             28 ; ram data
                             29 ;--------------------------------------------------------
                             30 	.area _INITIALIZED
                             31 ;--------------------------------------------------------
                             32 ; absolute external ram data
                             33 ;--------------------------------------------------------
                             34 	.area _DABS (ABS)
                             35 ;--------------------------------------------------------
                             36 ; global & static initialisations
                             37 ;--------------------------------------------------------
                             38 	.area _HOME
                             39 	.area _GSINIT
                             40 	.area _GSFINAL
                             41 	.area _GSINIT
                             42 ;--------------------------------------------------------
                             43 ; Home
                             44 ;--------------------------------------------------------
                             45 	.area _HOME
                             46 	.area _HOME
                             47 ;--------------------------------------------------------
                             48 ; code
                             49 ;--------------------------------------------------------
                             50 	.area _CODE
                             51 ;src/State_MainMenu.c:10: void state_mainmenu_enter(){
                             52 ;	---------------------------------
                             53 ; Function state_mainmenu_enter
                             54 ; ---------------------------------
   1BEA                      55 _state_mainmenu_enter::
                             56 ;src/State_MainMenu.c:11: state_mainmenu_render();
   1BEA C3 02 1C      [10]   57 	jp  _state_mainmenu_render
                             58 ;src/State_MainMenu.c:14: void state_mainmenu_input(){
                             59 ;	---------------------------------
                             60 ; Function state_mainmenu_input
                             61 ; ---------------------------------
   1BED                      62 _state_mainmenu_input::
                             63 ;src/State_MainMenu.c:15: if(cpct_isKeyPressed(Key_Return)){
   1BED 21 02 04      [10]   64 	ld	hl,#0x0402
   1BF0 CD B0 3D      [17]   65 	call	_cpct_isKeyPressed
   1BF3 7D            [ 4]   66 	ld	a,l
   1BF4 B7            [ 4]   67 	or	a, a
   1BF5 C8            [11]   68 	ret	Z
                             69 ;src/State_MainMenu.c:16: statemanager_set_state(STATE_INGAME);
   1BF6 3E 01         [ 7]   70 	ld	a,#0x01
   1BF8 F5            [11]   71 	push	af
   1BF9 33            [ 6]   72 	inc	sp
   1BFA CD 70 1C      [17]   73 	call	_statemanager_set_state
   1BFD 33            [ 6]   74 	inc	sp
                             75 ;src/State_MainMenu.c:17: statemanager_input_accepted();
   1BFE C3 6A 1C      [10]   76 	jp  _statemanager_input_accepted
                             77 ;src/State_MainMenu.c:21: void state_mainmenu_update(){
                             78 ;	---------------------------------
                             79 ; Function state_mainmenu_update
                             80 ; ---------------------------------
   1C01                      81 _state_mainmenu_update::
                             82 ;src/State_MainMenu.c:23: }
   1C01 C9            [10]   83 	ret
                             84 ;src/State_MainMenu.c:25: void state_mainmenu_render(){
                             85 ;	---------------------------------
                             86 ; Function state_mainmenu_render
                             87 ; ---------------------------------
   1C02                      88 _state_mainmenu_render::
                             89 ;src/State_MainMenu.c:26: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1C02 21 A6 0A      [10]   90 	ld	hl, #(_g_colors + 0x0001) + 0
   1C05 46            [ 7]   91 	ld	b,(hl)
   1C06 21 00 40      [10]   92 	ld	hl,#0x4000
   1C09 E5            [11]   93 	push	hl
   1C0A C5            [11]   94 	push	bc
   1C0B 33            [ 6]   95 	inc	sp
   1C0C 26 C0         [ 7]   96 	ld	h, #0xC0
   1C0E E5            [11]   97 	push	hl
   1C0F CD 5D 3F      [17]   98 	call	_cpct_memset
   1C12 C9            [10]   99 	ret
                            100 ;src/State_MainMenu.c:29: void state_mainmenu_exit(){
                            101 ;	---------------------------------
                            102 ; Function state_mainmenu_exit
                            103 ; ---------------------------------
   1C13                     104 _state_mainmenu_exit::
                            105 ;src/State_MainMenu.c:31: }
   1C13 C9            [10]  106 	ret
                            107 	.area _CODE
                            108 	.area _INITIALIZER
                            109 	.area _CABS (ABS)
