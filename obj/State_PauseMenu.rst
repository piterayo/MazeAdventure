                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_PauseMenu
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _statemanager_input_accepted
                             12 	.globl _statemanager_set_state
                             13 	.globl _statemanager_close_state
                             14 	.globl _cpct_getScreenPtr
                             15 	.globl _cpct_drawSolidBox
                             16 	.globl _cpct_isKeyPressed
                             17 	.globl _state_pausemenu_enter
                             18 	.globl _state_pausemenu_input
                             19 	.globl _state_pausemenu_update
                             20 	.globl _state_pausemenu_render
                             21 	.globl _state_pausemenu_exit
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DATA
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _INITIALIZED
                             33 ;--------------------------------------------------------
                             34 ; absolute external ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DABS (ABS)
                             37 ;--------------------------------------------------------
                             38 ; global & static initialisations
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _GSINIT
                             42 	.area _GSFINAL
                             43 	.area _GSINIT
                             44 ;--------------------------------------------------------
                             45 ; Home
                             46 ;--------------------------------------------------------
                             47 	.area _HOME
                             48 	.area _HOME
                             49 ;--------------------------------------------------------
                             50 ; code
                             51 ;--------------------------------------------------------
                             52 	.area _CODE
                             53 ;src/State_PauseMenu.c:10: void state_pausemenu_enter(){
                             54 ;	---------------------------------
                             55 ; Function state_pausemenu_enter
                             56 ; ---------------------------------
   1D80                      57 _state_pausemenu_enter::
                             58 ;src/State_PauseMenu.c:12: ptr=cpct_getScreenPtr(CPCT_VMEM_START, 20, 40 );
   1D80 21 14 28      [10]   59 	ld	hl,#0x2814
   1D83 E5            [11]   60 	push	hl
   1D84 21 00 C0      [10]   61 	ld	hl,#0xC000
   1D87 E5            [11]   62 	push	hl
   1D88 CD FD 43      [17]   63 	call	_cpct_getScreenPtr
   1D8B 4D            [ 4]   64 	ld	c,l
   1D8C 44            [ 4]   65 	ld	b,h
                             66 ;src/State_PauseMenu.c:13: cpct_drawSolidBox (ptr, 255, 40, 120);
   1D8D 21 28 78      [10]   67 	ld	hl,#0x7828
   1D90 E5            [11]   68 	push	hl
   1D91 3E FF         [ 7]   69 	ld	a,#0xFF
   1D93 F5            [11]   70 	push	af
   1D94 33            [ 6]   71 	inc	sp
   1D95 C5            [11]   72 	push	bc
   1D96 CD 44 43      [17]   73 	call	_cpct_drawSolidBox
   1D99 F1            [10]   74 	pop	af
                             75 ;src/State_PauseMenu.c:14: ptr=cpct_getScreenPtr(CPCT_VMEM_START, 20, 80 );
   1D9A 33            [ 6]   76 	inc	sp
   1D9B 21 14 50      [10]   77 	ld	hl,#0x5014
   1D9E E3            [19]   78 	ex	(sp),hl
   1D9F 21 00 C0      [10]   79 	ld	hl,#0xC000
   1DA2 E5            [11]   80 	push	hl
   1DA3 CD FD 43      [17]   81 	call	_cpct_getScreenPtr
   1DA6 C9            [10]   82 	ret
                             83 ;src/State_PauseMenu.c:17: void state_pausemenu_input(){
                             84 ;	---------------------------------
                             85 ; Function state_pausemenu_input
                             86 ; ---------------------------------
   1DA7                      87 _state_pausemenu_input::
                             88 ;src/State_PauseMenu.c:19: if(cpct_isKeyPressed(Key_P)){
   1DA7 21 03 08      [10]   89 	ld	hl,#0x0803
   1DAA CD 71 41      [17]   90 	call	_cpct_isKeyPressed
   1DAD 7D            [ 4]   91 	ld	a,l
   1DAE B7            [ 4]   92 	or	a, a
   1DAF 28 0B         [12]   93 	jr	Z,00104$
                             94 ;src/State_PauseMenu.c:20: statemanager_set_state(STATE_INGAME);
   1DB1 3E 01         [ 7]   95 	ld	a,#0x01
   1DB3 F5            [11]   96 	push	af
   1DB4 33            [ 6]   97 	inc	sp
   1DB5 CD 8F 1C      [17]   98 	call	_statemanager_set_state
   1DB8 33            [ 6]   99 	inc	sp
                            100 ;src/State_PauseMenu.c:21: statemanager_input_accepted();
   1DB9 C3 89 1C      [10]  101 	jp  _statemanager_input_accepted
   1DBC                     102 00104$:
                            103 ;src/State_PauseMenu.c:23: else if(cpct_isKeyPressed(Key_Esc)){
   1DBC 21 08 04      [10]  104 	ld	hl,#0x0408
   1DBF CD 71 41      [17]  105 	call	_cpct_isKeyPressed
   1DC2 7D            [ 4]  106 	ld	a,l
   1DC3 B7            [ 4]  107 	or	a, a
   1DC4 C8            [11]  108 	ret	Z
                            109 ;src/State_PauseMenu.c:24: statemanager_set_state(STATE_MAINMENU);
   1DC5 AF            [ 4]  110 	xor	a, a
   1DC6 F5            [11]  111 	push	af
   1DC7 33            [ 6]  112 	inc	sp
   1DC8 CD 8F 1C      [17]  113 	call	_statemanager_set_state
   1DCB 33            [ 6]  114 	inc	sp
                            115 ;src/State_PauseMenu.c:25: statemanager_close_state(STATE_INGAME);
   1DCC 3E 01         [ 7]  116 	ld	a,#0x01
   1DCE F5            [11]  117 	push	af
   1DCF 33            [ 6]  118 	inc	sp
   1DD0 CD 33 1D      [17]  119 	call	_statemanager_close_state
   1DD3 33            [ 6]  120 	inc	sp
                            121 ;src/State_PauseMenu.c:26: statemanager_input_accepted();
   1DD4 C3 89 1C      [10]  122 	jp  _statemanager_input_accepted
                            123 ;src/State_PauseMenu.c:30: void state_pausemenu_update(){
                            124 ;	---------------------------------
                            125 ; Function state_pausemenu_update
                            126 ; ---------------------------------
   1DD7                     127 _state_pausemenu_update::
                            128 ;src/State_PauseMenu.c:32: }
   1DD7 C9            [10]  129 	ret
                            130 ;src/State_PauseMenu.c:34: void state_pausemenu_render(){
                            131 ;	---------------------------------
                            132 ; Function state_pausemenu_render
                            133 ; ---------------------------------
   1DD8                     134 _state_pausemenu_render::
                            135 ;src/State_PauseMenu.c:36: }
   1DD8 C9            [10]  136 	ret
                            137 ;src/State_PauseMenu.c:38: void state_pausemenu_exit(){
                            138 ;	---------------------------------
                            139 ; Function state_pausemenu_exit
                            140 ; ---------------------------------
   1DD9                     141 _state_pausemenu_exit::
                            142 ;src/State_PauseMenu.c:40: }
   1DD9 C9            [10]  143 	ret
                            144 	.area _CODE
                            145 	.area _INITIALIZER
                            146 	.area _CABS (ABS)
