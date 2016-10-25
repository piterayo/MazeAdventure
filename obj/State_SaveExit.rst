                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_SaveExit
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _savegame_get_saveString
                             12 	.globl _print_transparent_text
                             13 	.globl _statemanager_input_accepted
                             14 	.globl _statemanager_set_state
                             15 	.globl _cpct_drawSolidBox
                             16 	.globl _cpct_isAnyKeyPressed_f
                             17 	.globl _state_saveexit_enter
                             18 	.globl _state_saveexit_return
                             19 	.globl _state_saveexit_input
                             20 	.globl _state_saveexit_update
                             21 	.globl _state_saveexit_render
                             22 	.globl _state_saveexit_exit
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
                             54 ;src/State_SaveExit.c:17: void state_saveexit_enter(){
                             55 ;	---------------------------------
                             56 ; Function state_saveexit_enter
                             57 ; ---------------------------------
   3B27                      58 _state_saveexit_enter::
                             59 ;src/State_SaveExit.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 20, 80), g_colors[4], 40, 40);
   3B27 21 6A 1A      [10]   60 	ld	hl, #_g_colors + 4
   3B2A 46            [ 7]   61 	ld	b,(hl)
   3B2B 21 28 28      [10]   62 	ld	hl,#0x2828
   3B2E E5            [11]   63 	push	hl
   3B2F C5            [11]   64 	push	bc
   3B30 33            [ 6]   65 	inc	sp
   3B31 21 34 C3      [10]   66 	ld	hl,#0xC334
   3B34 E5            [11]   67 	push	hl
   3B35 CD 92 7B      [17]   68 	call	_cpct_drawSolidBox
   3B38 F1            [10]   69 	pop	af
   3B39 F1            [10]   70 	pop	af
   3B3A 33            [ 6]   71 	inc	sp
                             72 ;src/State_SaveExit.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 21, 84), g_colors[1], 38, 32);
   3B3B 21 67 1A      [10]   73 	ld	hl, #_g_colors + 1
   3B3E 46            [ 7]   74 	ld	b,(hl)
   3B3F 21 26 20      [10]   75 	ld	hl,#0x2026
   3B42 E5            [11]   76 	push	hl
   3B43 C5            [11]   77 	push	bc
   3B44 33            [ 6]   78 	inc	sp
   3B45 21 35 E3      [10]   79 	ld	hl,#0xE335
   3B48 E5            [11]   80 	push	hl
   3B49 CD 92 7B      [17]   81 	call	_cpct_drawSolidBox
   3B4C F1            [10]   82 	pop	af
   3B4D F1            [10]   83 	pop	af
   3B4E 33            [ 6]   84 	inc	sp
                             85 ;src/State_SaveExit.c:21: print_transparent_text(savegame_get_saveString(), cpctm_screenPtr(CPCT_VMEM_START, 22, 92), 3);
   3B4F CD 84 2D      [17]   86 	call	_savegame_get_saveString
   3B52 4D            [ 4]   87 	ld	c,l
   3B53 44            [ 4]   88 	ld	b,h
   3B54 3E 03         [ 7]   89 	ld	a,#0x03
   3B56 F5            [11]   90 	push	af
   3B57 33            [ 6]   91 	inc	sp
   3B58 21 86 E3      [10]   92 	ld	hl,#0xE386
   3B5B E5            [11]   93 	push	hl
   3B5C C5            [11]   94 	push	bc
   3B5D CD A0 3F      [17]   95 	call	_print_transparent_text
   3B60 F1            [10]   96 	pop	af
   3B61 F1            [10]   97 	pop	af
   3B62 33            [ 6]   98 	inc	sp
                             99 ;src/State_SaveExit.c:22: print_transparent_text("PRESS ANY KEY", cpctm_screenPtr(CPCT_VMEM_START, 27, 100), 3);
   3B63 3E 03         [ 7]  100 	ld	a,#0x03
   3B65 F5            [11]  101 	push	af
   3B66 33            [ 6]  102 	inc	sp
   3B67 21 DB E3      [10]  103 	ld	hl,#0xE3DB
   3B6A E5            [11]  104 	push	hl
   3B6B 21 76 3B      [10]  105 	ld	hl,#___str_0
   3B6E E5            [11]  106 	push	hl
   3B6F CD A0 3F      [17]  107 	call	_print_transparent_text
   3B72 F1            [10]  108 	pop	af
   3B73 F1            [10]  109 	pop	af
   3B74 33            [ 6]  110 	inc	sp
   3B75 C9            [10]  111 	ret
   3B76                     112 ___str_0:
   3B76 50 52 45 53 53 20   113 	.ascii "PRESS ANY KEY"
        41 4E 59 20 4B 45
        59
   3B83 00                  114 	.db 0x00
                            115 ;src/State_SaveExit.c:26: void state_saveexit_return(){
                            116 ;	---------------------------------
                            117 ; Function state_saveexit_return
                            118 ; ---------------------------------
   3B84                     119 _state_saveexit_return::
                            120 ;src/State_SaveExit.c:28: }
   3B84 C9            [10]  121 	ret
                            122 ;src/State_SaveExit.c:30: void state_saveexit_input(){
                            123 ;	---------------------------------
                            124 ; Function state_saveexit_input
                            125 ; ---------------------------------
   3B85                     126 _state_saveexit_input::
                            127 ;src/State_SaveExit.c:31: if(cpct_isAnyKeyPressed_f()){
   3B85 CD 43 7B      [17]  128 	call	_cpct_isAnyKeyPressed_f
   3B88 7D            [ 4]  129 	ld	a,l
   3B89 B7            [ 4]  130 	or	a, a
   3B8A C8            [11]  131 	ret	Z
                            132 ;src/State_SaveExit.c:32: statemanager_set_state(STATE_MAINMENU);
   3B8B AF            [ 4]  133 	xor	a, a
   3B8C F5            [11]  134 	push	af
   3B8D 33            [ 6]  135 	inc	sp
   3B8E CD 96 38      [17]  136 	call	_statemanager_set_state
   3B91 33            [ 6]  137 	inc	sp
                            138 ;src/State_SaveExit.c:33: statemanager_input_accepted();
   3B92 C3 90 38      [10]  139 	jp  _statemanager_input_accepted
                            140 ;src/State_SaveExit.c:37: void state_saveexit_update(){
                            141 ;	---------------------------------
                            142 ; Function state_saveexit_update
                            143 ; ---------------------------------
   3B95                     144 _state_saveexit_update::
                            145 ;src/State_SaveExit.c:39: }
   3B95 C9            [10]  146 	ret
                            147 ;src/State_SaveExit.c:41: void state_saveexit_render(){
                            148 ;	---------------------------------
                            149 ; Function state_saveexit_render
                            150 ; ---------------------------------
   3B96                     151 _state_saveexit_render::
                            152 ;src/State_SaveExit.c:43: }
   3B96 C9            [10]  153 	ret
                            154 ;src/State_SaveExit.c:45: void state_saveexit_exit(){
                            155 ;	---------------------------------
                            156 ; Function state_saveexit_exit
                            157 ; ---------------------------------
   3B97                     158 _state_saveexit_exit::
                            159 ;src/State_SaveExit.c:47: }
   3B97 C9            [10]  160 	ret
                            161 	.area _CODE
                            162 	.area _INITIALIZER
                            163 	.area _CABS (ABS)
