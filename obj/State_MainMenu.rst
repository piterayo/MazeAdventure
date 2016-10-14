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
                             11 	.globl _print_transparent_text
                             12 	.globl _statemanager_input_accepted
                             13 	.globl _statemanager_set_state
                             14 	.globl _cpct_isKeyPressed
                             15 	.globl _cpct_memset
                             16 	.globl _state_mainmenu_enter
                             17 	.globl _state_mainmenu_input
                             18 	.globl _state_mainmenu_update
                             19 	.globl _state_mainmenu_render
                             20 	.globl _state_mainmenu_exit
                             21 ;--------------------------------------------------------
                             22 ; special function registers
                             23 ;--------------------------------------------------------
                             24 ;--------------------------------------------------------
                             25 ; ram data
                             26 ;--------------------------------------------------------
                             27 	.area _DATA
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _INITIALIZED
                             32 ;--------------------------------------------------------
                             33 ; absolute external ram data
                             34 ;--------------------------------------------------------
                             35 	.area _DABS (ABS)
                             36 ;--------------------------------------------------------
                             37 ; global & static initialisations
                             38 ;--------------------------------------------------------
                             39 	.area _HOME
                             40 	.area _GSINIT
                             41 	.area _GSFINAL
                             42 	.area _GSINIT
                             43 ;--------------------------------------------------------
                             44 ; Home
                             45 ;--------------------------------------------------------
                             46 	.area _HOME
                             47 	.area _HOME
                             48 ;--------------------------------------------------------
                             49 ; code
                             50 ;--------------------------------------------------------
                             51 	.area _CODE
                             52 ;src/State_MainMenu.c:12: void state_mainmenu_enter(){
                             53 ;	---------------------------------
                             54 ; Function state_mainmenu_enter
                             55 ; ---------------------------------
   1BED                      56 _state_mainmenu_enter::
                             57 ;src/State_MainMenu.c:13: state_mainmenu_render();
   1BED C3 05 1C      [10]   58 	jp  _state_mainmenu_render
                             59 ;src/State_MainMenu.c:16: void state_mainmenu_input(){
                             60 ;	---------------------------------
                             61 ; Function state_mainmenu_input
                             62 ; ---------------------------------
   1BF0                      63 _state_mainmenu_input::
                             64 ;src/State_MainMenu.c:17: if(cpct_isKeyPressed(Key_Return)){
   1BF0 21 02 04      [10]   65 	ld	hl,#0x0402
   1BF3 CD 71 41      [17]   66 	call	_cpct_isKeyPressed
   1BF6 7D            [ 4]   67 	ld	a,l
   1BF7 B7            [ 4]   68 	or	a, a
   1BF8 C8            [11]   69 	ret	Z
                             70 ;src/State_MainMenu.c:18: statemanager_set_state(STATE_INGAME);
   1BF9 3E 01         [ 7]   71 	ld	a,#0x01
   1BFB F5            [11]   72 	push	af
   1BFC 33            [ 6]   73 	inc	sp
   1BFD CD 8F 1C      [17]   74 	call	_statemanager_set_state
   1C00 33            [ 6]   75 	inc	sp
                             76 ;src/State_MainMenu.c:19: statemanager_input_accepted();
   1C01 C3 89 1C      [10]   77 	jp  _statemanager_input_accepted
                             78 ;src/State_MainMenu.c:23: void state_mainmenu_update(){
                             79 ;	---------------------------------
                             80 ; Function state_mainmenu_update
                             81 ; ---------------------------------
   1C04                      82 _state_mainmenu_update::
                             83 ;src/State_MainMenu.c:25: }
   1C04 C9            [10]   84 	ret
                             85 ;src/State_MainMenu.c:27: void state_mainmenu_render(){
                             86 ;	---------------------------------
                             87 ; Function state_mainmenu_render
                             88 ; ---------------------------------
   1C05                      89 _state_mainmenu_render::
                             90 ;src/State_MainMenu.c:28: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   1C05 21 A6 0A      [10]   91 	ld	hl,#_g_colors+1
   1C08 46            [ 7]   92 	ld	b,(hl)
   1C09 21 00 40      [10]   93 	ld	hl,#0x4000
   1C0C E5            [11]   94 	push	hl
   1C0D C5            [11]   95 	push	bc
   1C0E 33            [ 6]   96 	inc	sp
   1C0F 26 C0         [ 7]   97 	ld	h, #0xC0
   1C11 E5            [11]   98 	push	hl
   1C12 CD 26 43      [17]   99 	call	_cpct_memset
                            100 ;src/State_MainMenu.c:29: print_transparent_text("MAIN MENU", CPCT_VMEM_START, 3);
   1C15 3E 03         [ 7]  101 	ld	a,#0x03
   1C17 F5            [11]  102 	push	af
   1C18 33            [ 6]  103 	inc	sp
   1C19 21 00 C0      [10]  104 	ld	hl,#0xC000
   1C1C E5            [11]  105 	push	hl
   1C1D 21 28 1C      [10]  106 	ld	hl,#___str_0
   1C20 E5            [11]  107 	push	hl
   1C21 CD AE 20      [17]  108 	call	_print_transparent_text
   1C24 F1            [10]  109 	pop	af
   1C25 F1            [10]  110 	pop	af
   1C26 33            [ 6]  111 	inc	sp
   1C27 C9            [10]  112 	ret
   1C28                     113 ___str_0:
   1C28 4D 41 49 4E 20 4D   114 	.ascii "MAIN MENU"
        45 4E 55
   1C31 00                  115 	.db 0x00
                            116 ;src/State_MainMenu.c:32: void state_mainmenu_exit(){
                            117 ;	---------------------------------
                            118 ; Function state_mainmenu_exit
                            119 ; ---------------------------------
   1C32                     120 _state_mainmenu_exit::
                            121 ;src/State_MainMenu.c:34: }
   1C32 C9            [10]  122 	ret
                            123 	.area _CODE
                            124 	.area _INITIALIZER
                            125 	.area _CABS (ABS)
