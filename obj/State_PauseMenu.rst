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
                             53 ;src/State_PauseMenu.c:12: void state_pausemenu_enter(){
                             54 ;	---------------------------------
                             55 ; Function state_pausemenu_enter
                             56 ; ---------------------------------
   1E06                      57 _state_pausemenu_enter::
                             58 ;src/State_PauseMenu.c:14: ptr=cpct_getScreenPtr(CPCT_VMEM_START, 30, 40 );
   1E06 21 1E 28      [10]   59 	ld	hl,#0x281E
   1E09 E5            [11]   60 	push	hl
   1E0A 21 00 C0      [10]   61 	ld	hl,#0xC000
   1E0D E5            [11]   62 	push	hl
   1E0E CD D0 47      [17]   63 	call	_cpct_getScreenPtr
   1E11 4D            [ 4]   64 	ld	c,l
   1E12 44            [ 4]   65 	ld	b,h
                             66 ;src/State_PauseMenu.c:15: cpct_drawSolidBox (ptr, 255, 20, 120);
   1E13 21 14 78      [10]   67 	ld	hl,#0x7814
   1E16 E5            [11]   68 	push	hl
   1E17 3E FF         [ 7]   69 	ld	a,#0xFF
   1E19 F5            [11]   70 	push	af
   1E1A 33            [ 6]   71 	inc	sp
   1E1B C5            [11]   72 	push	bc
   1E1C CD 17 47      [17]   73 	call	_cpct_drawSolidBox
   1E1F F1            [10]   74 	pop	af
   1E20 F1            [10]   75 	pop	af
   1E21 33            [ 6]   76 	inc	sp
   1E22 C9            [10]   77 	ret
                             78 ;src/State_PauseMenu.c:18: void state_pausemenu_input(){
                             79 ;	---------------------------------
                             80 ; Function state_pausemenu_input
                             81 ; ---------------------------------
   1E23                      82 _state_pausemenu_input::
                             83 ;src/State_PauseMenu.c:20: if(cpct_isKeyPressed(Key_P)){
   1E23 21 03 08      [10]   84 	ld	hl,#0x0803
   1E26 CD 44 45      [17]   85 	call	_cpct_isKeyPressed
   1E29 7D            [ 4]   86 	ld	a,l
   1E2A B7            [ 4]   87 	or	a, a
   1E2B 28 06         [12]   88 	jr	Z,00104$
                             89 ;src/State_PauseMenu.c:21: statemanager_close_state();
   1E2D CD C9 1D      [17]   90 	call	_statemanager_close_state
                             91 ;src/State_PauseMenu.c:22: statemanager_input_accepted();
   1E30 C3 1D 1D      [10]   92 	jp  _statemanager_input_accepted
   1E33                      93 00104$:
                             94 ;src/State_PauseMenu.c:24: else if(cpct_isKeyPressed(Key_Esc)){
   1E33 21 08 04      [10]   95 	ld	hl,#0x0408
   1E36 CD 44 45      [17]   96 	call	_cpct_isKeyPressed
   1E39 7D            [ 4]   97 	ld	a,l
   1E3A B7            [ 4]   98 	or	a, a
   1E3B C8            [11]   99 	ret	Z
                            100 ;src/State_PauseMenu.c:25: statemanager_close_state();
   1E3C CD C9 1D      [17]  101 	call	_statemanager_close_state
                            102 ;src/State_PauseMenu.c:26: statemanager_close_state();
   1E3F CD C9 1D      [17]  103 	call	_statemanager_close_state
                            104 ;src/State_PauseMenu.c:27: statemanager_set_state(STATE_MAINMENU);
   1E42 AF            [ 4]  105 	xor	a, a
   1E43 F5            [11]  106 	push	af
   1E44 33            [ 6]  107 	inc	sp
   1E45 CD 23 1D      [17]  108 	call	_statemanager_set_state
   1E48 33            [ 6]  109 	inc	sp
                            110 ;src/State_PauseMenu.c:28: statemanager_input_accepted();
   1E49 C3 1D 1D      [10]  111 	jp  _statemanager_input_accepted
                            112 ;src/State_PauseMenu.c:32: void state_pausemenu_update(){
                            113 ;	---------------------------------
                            114 ; Function state_pausemenu_update
                            115 ; ---------------------------------
   1E4C                     116 _state_pausemenu_update::
                            117 ;src/State_PauseMenu.c:34: }
   1E4C C9            [10]  118 	ret
                            119 ;src/State_PauseMenu.c:36: void state_pausemenu_render(){
                            120 ;	---------------------------------
                            121 ; Function state_pausemenu_render
                            122 ; ---------------------------------
   1E4D                     123 _state_pausemenu_render::
                            124 ;src/State_PauseMenu.c:38: }
   1E4D C9            [10]  125 	ret
                            126 ;src/State_PauseMenu.c:40: void state_pausemenu_exit(){
                            127 ;	---------------------------------
                            128 ; Function state_pausemenu_exit
                            129 ; ---------------------------------
   1E4E                     130 _state_pausemenu_exit::
                            131 ;src/State_PauseMenu.c:42: ptr=cpct_getScreenPtr(CPCT_VMEM_START, 30, 40 );
   1E4E 21 1E 28      [10]  132 	ld	hl,#0x281E
   1E51 E5            [11]  133 	push	hl
   1E52 21 00 C0      [10]  134 	ld	hl,#0xC000
   1E55 E5            [11]  135 	push	hl
   1E56 CD D0 47      [17]  136 	call	_cpct_getScreenPtr
   1E59 4D            [ 4]  137 	ld	c,l
   1E5A 44            [ 4]  138 	ld	b,h
                            139 ;src/State_PauseMenu.c:43: cpct_drawSolidBox (ptr, g_colors[1], 20, 120);
   1E5B 21 B3 0A      [10]  140 	ld	hl,#_g_colors+1
   1E5E 56            [ 7]  141 	ld	d,(hl)
   1E5F 21 14 78      [10]  142 	ld	hl,#0x7814
   1E62 E5            [11]  143 	push	hl
   1E63 D5            [11]  144 	push	de
   1E64 33            [ 6]  145 	inc	sp
   1E65 C5            [11]  146 	push	bc
   1E66 CD 17 47      [17]  147 	call	_cpct_drawSolidBox
   1E69 F1            [10]  148 	pop	af
   1E6A F1            [10]  149 	pop	af
   1E6B 33            [ 6]  150 	inc	sp
   1E6C C9            [10]  151 	ret
                            152 	.area _CODE
                            153 	.area _INITIALIZER
                            154 	.area _CABS (ABS)
