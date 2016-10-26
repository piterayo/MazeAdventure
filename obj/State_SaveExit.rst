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
   3C9B                      58 _state_saveexit_enter::
                             59 ;src/State_SaveExit.c:18: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 20, 80), g_colors[4], 40, 40);
   3C9B 21 2C 1C      [10]   60 	ld	hl, #_g_colors + 4
   3C9E 46            [ 7]   61 	ld	b,(hl)
   3C9F 21 28 28      [10]   62 	ld	hl,#0x2828
   3CA2 E5            [11]   63 	push	hl
   3CA3 C5            [11]   64 	push	bc
   3CA4 33            [ 6]   65 	inc	sp
   3CA5 21 34 C3      [10]   66 	ld	hl,#0xC334
   3CA8 E5            [11]   67 	push	hl
   3CA9 CD 2F 85      [17]   68 	call	_cpct_drawSolidBox
   3CAC F1            [10]   69 	pop	af
   3CAD F1            [10]   70 	pop	af
   3CAE 33            [ 6]   71 	inc	sp
                             72 ;src/State_SaveExit.c:19: cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 21, 84), g_colors[1], 38, 32);
   3CAF 21 29 1C      [10]   73 	ld	hl, #_g_colors + 1
   3CB2 46            [ 7]   74 	ld	b,(hl)
   3CB3 21 26 20      [10]   75 	ld	hl,#0x2026
   3CB6 E5            [11]   76 	push	hl
   3CB7 C5            [11]   77 	push	bc
   3CB8 33            [ 6]   78 	inc	sp
   3CB9 21 35 E3      [10]   79 	ld	hl,#0xE335
   3CBC E5            [11]   80 	push	hl
   3CBD CD 2F 85      [17]   81 	call	_cpct_drawSolidBox
   3CC0 F1            [10]   82 	pop	af
   3CC1 F1            [10]   83 	pop	af
   3CC2 33            [ 6]   84 	inc	sp
                             85 ;src/State_SaveExit.c:21: print_transparent_text(savegame_get_saveString(), cpctm_screenPtr(CPCT_VMEM_START, 22, 92), 3);
   3CC3 CD 46 2F      [17]   86 	call	_savegame_get_saveString
   3CC6 4D            [ 4]   87 	ld	c,l
   3CC7 44            [ 4]   88 	ld	b,h
   3CC8 3E 03         [ 7]   89 	ld	a,#0x03
   3CCA F5            [11]   90 	push	af
   3CCB 33            [ 6]   91 	inc	sp
   3CCC 21 86 E3      [10]   92 	ld	hl,#0xE386
   3CCF E5            [11]   93 	push	hl
   3CD0 C5            [11]   94 	push	bc
   3CD1 CD 14 41      [17]   95 	call	_print_transparent_text
   3CD4 F1            [10]   96 	pop	af
   3CD5 F1            [10]   97 	pop	af
   3CD6 33            [ 6]   98 	inc	sp
                             99 ;src/State_SaveExit.c:22: print_transparent_text("PRESS ANY KEY", cpctm_screenPtr(CPCT_VMEM_START, 27, 100), 3);
   3CD7 3E 03         [ 7]  100 	ld	a,#0x03
   3CD9 F5            [11]  101 	push	af
   3CDA 33            [ 6]  102 	inc	sp
   3CDB 21 DB E3      [10]  103 	ld	hl,#0xE3DB
   3CDE E5            [11]  104 	push	hl
   3CDF 21 EA 3C      [10]  105 	ld	hl,#___str_0
   3CE2 E5            [11]  106 	push	hl
   3CE3 CD 14 41      [17]  107 	call	_print_transparent_text
   3CE6 F1            [10]  108 	pop	af
   3CE7 F1            [10]  109 	pop	af
   3CE8 33            [ 6]  110 	inc	sp
   3CE9 C9            [10]  111 	ret
   3CEA                     112 ___str_0:
   3CEA 50 52 45 53 53 20   113 	.ascii "PRESS ANY KEY"
        41 4E 59 20 4B 45
        59
   3CF7 00                  114 	.db 0x00
                            115 ;src/State_SaveExit.c:26: void state_saveexit_return(){
                            116 ;	---------------------------------
                            117 ; Function state_saveexit_return
                            118 ; ---------------------------------
   3CF8                     119 _state_saveexit_return::
                            120 ;src/State_SaveExit.c:28: }
   3CF8 C9            [10]  121 	ret
                            122 ;src/State_SaveExit.c:30: void state_saveexit_input(){
                            123 ;	---------------------------------
                            124 ; Function state_saveexit_input
                            125 ; ---------------------------------
   3CF9                     126 _state_saveexit_input::
                            127 ;src/State_SaveExit.c:31: if(cpct_isAnyKeyPressed_f()){
   3CF9 CD E0 84      [17]  128 	call	_cpct_isAnyKeyPressed_f
   3CFC 7D            [ 4]  129 	ld	a,l
   3CFD B7            [ 4]  130 	or	a, a
   3CFE C8            [11]  131 	ret	Z
                            132 ;src/State_SaveExit.c:32: statemanager_set_state(STATE_MAINMENU);
   3CFF AF            [ 4]  133 	xor	a, a
   3D00 F5            [11]  134 	push	af
   3D01 33            [ 6]  135 	inc	sp
   3D02 CD 01 3A      [17]  136 	call	_statemanager_set_state
   3D05 33            [ 6]  137 	inc	sp
                            138 ;src/State_SaveExit.c:33: statemanager_input_accepted();
   3D06 C3 FB 39      [10]  139 	jp  _statemanager_input_accepted
                            140 ;src/State_SaveExit.c:37: void state_saveexit_update(){
                            141 ;	---------------------------------
                            142 ; Function state_saveexit_update
                            143 ; ---------------------------------
   3D09                     144 _state_saveexit_update::
                            145 ;src/State_SaveExit.c:39: }
   3D09 C9            [10]  146 	ret
                            147 ;src/State_SaveExit.c:41: void state_saveexit_render(){
                            148 ;	---------------------------------
                            149 ; Function state_saveexit_render
                            150 ; ---------------------------------
   3D0A                     151 _state_saveexit_render::
                            152 ;src/State_SaveExit.c:43: }
   3D0A C9            [10]  153 	ret
                            154 ;src/State_SaveExit.c:45: void state_saveexit_exit(){
                            155 ;	---------------------------------
                            156 ; Function state_saveexit_exit
                            157 ; ---------------------------------
   3D0B                     158 _state_saveexit_exit::
                            159 ;src/State_SaveExit.c:47: }
   3D0B C9            [10]  160 	ret
                            161 	.area _CODE
                            162 	.area _INITIALIZER
                            163 	.area _CABS (ABS)
