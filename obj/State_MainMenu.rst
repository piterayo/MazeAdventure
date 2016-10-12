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
                             13 	.globl _cpct_drawStringM0
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
                             52 ;src/State_MainMenu.c:10: void state_mainmenu_enter(){
                             53 ;	---------------------------------
                             54 ; Function state_mainmenu_enter
                             55 ; ---------------------------------
   6B79                      56 _state_mainmenu_enter::
                             57 ;src/State_MainMenu.c:11: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
   6B79 21 57 5A      [10]   58 	ld	hl,#_g_colors+12
   6B7C 46            [ 7]   59 	ld	b,(hl)
   6B7D 21 00 40      [10]   60 	ld	hl,#0x4000
   6B80 E5            [11]   61 	push	hl
   6B81 C5            [11]   62 	push	bc
   6B82 33            [ 6]   63 	inc	sp
   6B83 26 C0         [ 7]   64 	ld	h, #0xC0
   6B85 E5            [11]   65 	push	hl
   6B86 CD F1 8E      [17]   66 	call	_cpct_memset
                             67 ;src/State_MainMenu.c:12: cpct_drawStringM0("MAIN MENU", CPCT_VMEM_START, 0, 1);
   6B89 21 00 01      [10]   68 	ld	hl,#0x0100
   6B8C E5            [11]   69 	push	hl
   6B8D 26 C0         [ 7]   70 	ld	h, #0xC0
   6B8F E5            [11]   71 	push	hl
   6B90 21 9D 6B      [10]   72 	ld	hl,#___str_0
   6B93 E5            [11]   73 	push	hl
   6B94 CD BA 8C      [17]   74 	call	_cpct_drawStringM0
   6B97 21 06 00      [10]   75 	ld	hl,#6
   6B9A 39            [11]   76 	add	hl,sp
   6B9B F9            [ 6]   77 	ld	sp,hl
   6B9C C9            [10]   78 	ret
   6B9D                      79 ___str_0:
   6B9D 4D 41 49 4E 20 4D    80 	.ascii "MAIN MENU"
        45 4E 55
   6BA6 00                   81 	.db 0x00
                             82 ;src/State_MainMenu.c:15: void state_mainmenu_input(){
                             83 ;	---------------------------------
                             84 ; Function state_mainmenu_input
                             85 ; ---------------------------------
   6BA7                      86 _state_mainmenu_input::
                             87 ;src/State_MainMenu.c:16: if(cpct_isKeyPressed(Key_Return)){
   6BA7 21 02 04      [10]   88 	ld	hl,#0x0402
   6BAA CD 21 8C      [17]   89 	call	_cpct_isKeyPressed
   6BAD 7D            [ 4]   90 	ld	a,l
   6BAE B7            [ 4]   91 	or	a, a
   6BAF C8            [11]   92 	ret	Z
                             93 ;src/State_MainMenu.c:17: statemanager_set_state(STATE_INGAME);
   6BB0 3E 01         [ 7]   94 	ld	a,#0x01
   6BB2 F5            [11]   95 	push	af
   6BB3 33            [ 6]   96 	inc	sp
   6BB4 CD 10 6C      [17]   97 	call	_statemanager_set_state
   6BB7 33            [ 6]   98 	inc	sp
                             99 ;src/State_MainMenu.c:18: statemanager_input_accepted();
   6BB8 C3 0A 6C      [10]  100 	jp  _statemanager_input_accepted
                            101 ;src/State_MainMenu.c:22: void state_mainmenu_update(){
                            102 ;	---------------------------------
                            103 ; Function state_mainmenu_update
                            104 ; ---------------------------------
   6BBB                     105 _state_mainmenu_update::
                            106 ;src/State_MainMenu.c:24: }
   6BBB C9            [10]  107 	ret
                            108 ;src/State_MainMenu.c:26: void state_mainmenu_render(){
                            109 ;	---------------------------------
                            110 ; Function state_mainmenu_render
                            111 ; ---------------------------------
   6BBC                     112 _state_mainmenu_render::
                            113 ;src/State_MainMenu.c:28: }
   6BBC C9            [10]  114 	ret
                            115 ;src/State_MainMenu.c:30: void state_mainmenu_exit(){
                            116 ;	---------------------------------
                            117 ; Function state_mainmenu_exit
                            118 ; ---------------------------------
   6BBD                     119 _state_mainmenu_exit::
                            120 ;src/State_MainMenu.c:32: }
   6BBD C9            [10]  121 	ret
                            122 	.area _CODE
                            123 	.area _INITIALIZER
                            124 	.area _CABS (ABS)
