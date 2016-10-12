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
                             15 	.globl _cpct_drawStringM0
                             16 	.globl _cpct_drawSolidBox
                             17 	.globl _cpct_isKeyPressed
                             18 	.globl _state_pausemenu_enter
                             19 	.globl _state_pausemenu_input
                             20 	.globl _state_pausemenu_update
                             21 	.globl _state_pausemenu_render
                             22 	.globl _state_pausemenu_exit
                             23 ;--------------------------------------------------------
                             24 ; special function registers
                             25 ;--------------------------------------------------------
                             26 ;--------------------------------------------------------
                             27 ; ram data
                             28 ;--------------------------------------------------------
                             29 	.area _DATA
                             30 ;--------------------------------------------------------
                             31 ; ram data
                             32 ;--------------------------------------------------------
                             33 	.area _INITIALIZED
                             34 ;--------------------------------------------------------
                             35 ; absolute external ram data
                             36 ;--------------------------------------------------------
                             37 	.area _DABS (ABS)
                             38 ;--------------------------------------------------------
                             39 ; global & static initialisations
                             40 ;--------------------------------------------------------
                             41 	.area _HOME
                             42 	.area _GSINIT
                             43 	.area _GSFINAL
                             44 	.area _GSINIT
                             45 ;--------------------------------------------------------
                             46 ; Home
                             47 ;--------------------------------------------------------
                             48 	.area _HOME
                             49 	.area _HOME
                             50 ;--------------------------------------------------------
                             51 ; code
                             52 ;--------------------------------------------------------
                             53 	.area _CODE
                             54 ;src/State_PauseMenu.c:10: void state_pausemenu_enter(){
                             55 ;	---------------------------------
                             56 ; Function state_pausemenu_enter
                             57 ; ---------------------------------
   6CFE                      58 _state_pausemenu_enter::
                             59 ;src/State_PauseMenu.c:12: ptr=cpct_getScreenPtr(CPCT_VMEM_START, 20, 40 );
   6CFE 21 14 28      [10]   60 	ld	hl,#0x2814
   6D01 E5            [11]   61 	push	hl
   6D02 21 00 C0      [10]   62 	ld	hl,#0xC000
   6D05 E5            [11]   63 	push	hl
   6D06 CD D0 8F      [17]   64 	call	_cpct_getScreenPtr
   6D09 4D            [ 4]   65 	ld	c,l
   6D0A 44            [ 4]   66 	ld	b,h
                             67 ;src/State_PauseMenu.c:13: cpct_drawSolidBox (ptr, 255, 40, 120);
   6D0B 21 28 78      [10]   68 	ld	hl,#0x7828
   6D0E E5            [11]   69 	push	hl
   6D0F 3E FF         [ 7]   70 	ld	a,#0xFF
   6D11 F5            [11]   71 	push	af
   6D12 33            [ 6]   72 	inc	sp
   6D13 C5            [11]   73 	push	bc
   6D14 CD 17 8F      [17]   74 	call	_cpct_drawSolidBox
   6D17 F1            [10]   75 	pop	af
                             76 ;src/State_PauseMenu.c:14: ptr=cpct_getScreenPtr(CPCT_VMEM_START, 20, 80 );
   6D18 33            [ 6]   77 	inc	sp
   6D19 21 14 50      [10]   78 	ld	hl,#0x5014
   6D1C E3            [19]   79 	ex	(sp),hl
   6D1D 21 00 C0      [10]   80 	ld	hl,#0xC000
   6D20 E5            [11]   81 	push	hl
   6D21 CD D0 8F      [17]   82 	call	_cpct_getScreenPtr
   6D24 4D            [ 4]   83 	ld	c,l
   6D25 44            [ 4]   84 	ld	b,h
                             85 ;src/State_PauseMenu.c:15: cpct_drawStringM0("PAUSE",ptr,0,1);
   6D26 21 00 01      [10]   86 	ld	hl,#0x0100
   6D29 E5            [11]   87 	push	hl
   6D2A C5            [11]   88 	push	bc
   6D2B 21 38 6D      [10]   89 	ld	hl,#___str_0
   6D2E E5            [11]   90 	push	hl
   6D2F CD BA 8C      [17]   91 	call	_cpct_drawStringM0
   6D32 21 06 00      [10]   92 	ld	hl,#6
   6D35 39            [11]   93 	add	hl,sp
   6D36 F9            [ 6]   94 	ld	sp,hl
   6D37 C9            [10]   95 	ret
   6D38                      96 ___str_0:
   6D38 50 41 55 53 45       97 	.ascii "PAUSE"
   6D3D 00                   98 	.db 0x00
                             99 ;src/State_PauseMenu.c:18: void state_pausemenu_input(){
                            100 ;	---------------------------------
                            101 ; Function state_pausemenu_input
                            102 ; ---------------------------------
   6D3E                     103 _state_pausemenu_input::
                            104 ;src/State_PauseMenu.c:20: if(cpct_isKeyPressed(Key_P)){
   6D3E 21 03 08      [10]  105 	ld	hl,#0x0803
   6D41 CD 21 8C      [17]  106 	call	_cpct_isKeyPressed
   6D44 7D            [ 4]  107 	ld	a,l
   6D45 B7            [ 4]  108 	or	a, a
   6D46 28 0B         [12]  109 	jr	Z,00104$
                            110 ;src/State_PauseMenu.c:21: statemanager_set_state(STATE_INGAME);
   6D48 3E 01         [ 7]  111 	ld	a,#0x01
   6D4A F5            [11]  112 	push	af
   6D4B 33            [ 6]  113 	inc	sp
   6D4C CD 10 6C      [17]  114 	call	_statemanager_set_state
   6D4F 33            [ 6]  115 	inc	sp
                            116 ;src/State_PauseMenu.c:22: statemanager_input_accepted();
   6D50 C3 0A 6C      [10]  117 	jp  _statemanager_input_accepted
   6D53                     118 00104$:
                            119 ;src/State_PauseMenu.c:24: else if(cpct_isKeyPressed(Key_Esc)){
   6D53 21 08 04      [10]  120 	ld	hl,#0x0408
   6D56 CD 21 8C      [17]  121 	call	_cpct_isKeyPressed
   6D59 7D            [ 4]  122 	ld	a,l
   6D5A B7            [ 4]  123 	or	a, a
   6D5B C8            [11]  124 	ret	Z
                            125 ;src/State_PauseMenu.c:25: statemanager_set_state(STATE_MAINMENU);
   6D5C AF            [ 4]  126 	xor	a, a
   6D5D F5            [11]  127 	push	af
   6D5E 33            [ 6]  128 	inc	sp
   6D5F CD 10 6C      [17]  129 	call	_statemanager_set_state
   6D62 33            [ 6]  130 	inc	sp
                            131 ;src/State_PauseMenu.c:26: statemanager_close_state(STATE_INGAME);
   6D63 3E 01         [ 7]  132 	ld	a,#0x01
   6D65 F5            [11]  133 	push	af
   6D66 33            [ 6]  134 	inc	sp
   6D67 CD B1 6C      [17]  135 	call	_statemanager_close_state
   6D6A 33            [ 6]  136 	inc	sp
                            137 ;src/State_PauseMenu.c:27: statemanager_input_accepted();
   6D6B C3 0A 6C      [10]  138 	jp  _statemanager_input_accepted
                            139 ;src/State_PauseMenu.c:31: void state_pausemenu_update(){
                            140 ;	---------------------------------
                            141 ; Function state_pausemenu_update
                            142 ; ---------------------------------
   6D6E                     143 _state_pausemenu_update::
                            144 ;src/State_PauseMenu.c:33: }
   6D6E C9            [10]  145 	ret
                            146 ;src/State_PauseMenu.c:35: void state_pausemenu_render(){
                            147 ;	---------------------------------
                            148 ; Function state_pausemenu_render
                            149 ; ---------------------------------
   6D6F                     150 _state_pausemenu_render::
                            151 ;src/State_PauseMenu.c:37: }
   6D6F C9            [10]  152 	ret
                            153 ;src/State_PauseMenu.c:39: void state_pausemenu_exit(){
                            154 ;	---------------------------------
                            155 ; Function state_pausemenu_exit
                            156 ; ---------------------------------
   6D70                     157 _state_pausemenu_exit::
                            158 ;src/State_PauseMenu.c:41: }
   6D70 C9            [10]  159 	ret
                            160 	.area _CODE
                            161 	.area _INITIALIZER
                            162 	.area _CABS (ABS)
