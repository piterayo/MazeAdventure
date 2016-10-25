                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_GameOver
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _level_get_level
                             12 	.globl _statemanager_input_accepted
                             13 	.globl _statemanager_set_state
                             14 	.globl _integer_to_string
                             15 	.globl _print_transparent_text
                             16 	.globl _cpct_isAnyKeyPressed_f
                             17 	.globl _cpct_memset
                             18 	.globl _state_gameover_enter
                             19 	.globl _state_gameover_return
                             20 	.globl _state_gameover_input
                             21 	.globl _state_gameover_update
                             22 	.globl _state_gameover_render
                             23 	.globl _state_gameover_exit
                             24 ;--------------------------------------------------------
                             25 ; special function registers
                             26 ;--------------------------------------------------------
                             27 ;--------------------------------------------------------
                             28 ; ram data
                             29 ;--------------------------------------------------------
                             30 	.area _DATA
                             31 ;--------------------------------------------------------
                             32 ; ram data
                             33 ;--------------------------------------------------------
                             34 	.area _INITIALIZED
                             35 ;--------------------------------------------------------
                             36 ; absolute external ram data
                             37 ;--------------------------------------------------------
                             38 	.area _DABS (ABS)
                             39 ;--------------------------------------------------------
                             40 ; global & static initialisations
                             41 ;--------------------------------------------------------
                             42 	.area _HOME
                             43 	.area _GSINIT
                             44 	.area _GSFINAL
                             45 	.area _GSINIT
                             46 ;--------------------------------------------------------
                             47 ; Home
                             48 ;--------------------------------------------------------
                             49 	.area _HOME
                             50 	.area _HOME
                             51 ;--------------------------------------------------------
                             52 ; code
                             53 ;--------------------------------------------------------
                             54 	.area _CODE
                             55 ;src/State_GameOver.c:15: void state_gameover_enter(){
                             56 ;	---------------------------------
                             57 ; Function state_gameover_enter
                             58 ; ---------------------------------
   2ECE                      59 _state_gameover_enter::
                             60 ;src/State_GameOver.c:16: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   2ECE 21 67 1A      [10]   61 	ld	hl,#_g_colors+1
   2ED1 46            [ 7]   62 	ld	b,(hl)
   2ED2 21 00 40      [10]   63 	ld	hl,#0x4000
   2ED5 E5            [11]   64 	push	hl
   2ED6 C5            [11]   65 	push	bc
   2ED7 33            [ 6]   66 	inc	sp
   2ED8 26 C0         [ 7]   67 	ld	h, #0xC0
   2EDA E5            [11]   68 	push	hl
   2EDB CD 52 7C      [17]   69 	call	_cpct_memset
                             70 ;src/State_GameOver.c:17: print_transparent_text("GAME OVER", cpctm_screenPtr((u16)CPCT_VMEM_START,32,92), 3);
   2EDE 3E 03         [ 7]   71 	ld	a,#0x03
   2EE0 F5            [11]   72 	push	af
   2EE1 33            [ 6]   73 	inc	sp
   2EE2 21 90 E3      [10]   74 	ld	hl,#0xE390
   2EE5 E5            [11]   75 	push	hl
   2EE6 21 22 2F      [10]   76 	ld	hl,#___str_0
   2EE9 E5            [11]   77 	push	hl
   2EEA CD A0 3F      [17]   78 	call	_print_transparent_text
   2EED F1            [10]   79 	pop	af
   2EEE F1            [10]   80 	pop	af
   2EEF 33            [ 6]   81 	inc	sp
                             82 ;src/State_GameOver.c:18: print_transparent_text("LEVEL: ", cpctm_screenPtr((u16)CPCT_VMEM_START,30,100), 3);
   2EF0 3E 03         [ 7]   83 	ld	a,#0x03
   2EF2 F5            [11]   84 	push	af
   2EF3 33            [ 6]   85 	inc	sp
   2EF4 21 DE E3      [10]   86 	ld	hl,#0xE3DE
   2EF7 E5            [11]   87 	push	hl
   2EF8 21 2C 2F      [10]   88 	ld	hl,#___str_1
   2EFB E5            [11]   89 	push	hl
   2EFC CD A0 3F      [17]   90 	call	_print_transparent_text
   2EFF F1            [10]   91 	pop	af
   2F00 F1            [10]   92 	pop	af
   2F01 33            [ 6]   93 	inc	sp
                             94 ;src/State_GameOver.c:19: print_transparent_text(integer_to_string(level_get_level(),'d'), cpctm_screenPtr((u16)CPCT_VMEM_START,46,100), 3);
   2F02 CD A7 0F      [17]   95 	call	_level_get_level
   2F05 45            [ 4]   96 	ld	b,l
   2F06 3E 64         [ 7]   97 	ld	a,#0x64
   2F08 F5            [11]   98 	push	af
   2F09 33            [ 6]   99 	inc	sp
   2F0A C5            [11]  100 	push	bc
   2F0B 33            [ 6]  101 	inc	sp
   2F0C CD 5E 3C      [17]  102 	call	_integer_to_string
   2F0F F1            [10]  103 	pop	af
   2F10 4D            [ 4]  104 	ld	c,l
   2F11 44            [ 4]  105 	ld	b,h
   2F12 3E 03         [ 7]  106 	ld	a,#0x03
   2F14 F5            [11]  107 	push	af
   2F15 33            [ 6]  108 	inc	sp
   2F16 21 EE E3      [10]  109 	ld	hl,#0xE3EE
   2F19 E5            [11]  110 	push	hl
   2F1A C5            [11]  111 	push	bc
   2F1B CD A0 3F      [17]  112 	call	_print_transparent_text
   2F1E F1            [10]  113 	pop	af
   2F1F F1            [10]  114 	pop	af
   2F20 33            [ 6]  115 	inc	sp
   2F21 C9            [10]  116 	ret
   2F22                     117 ___str_0:
   2F22 47 41 4D 45 20 4F   118 	.ascii "GAME OVER"
        56 45 52
   2F2B 00                  119 	.db 0x00
   2F2C                     120 ___str_1:
   2F2C 4C 45 56 45 4C 3A   121 	.ascii "LEVEL: "
        20
   2F33 00                  122 	.db 0x00
                            123 ;src/State_GameOver.c:22: void state_gameover_return(){
                            124 ;	---------------------------------
                            125 ; Function state_gameover_return
                            126 ; ---------------------------------
   2F34                     127 _state_gameover_return::
                            128 ;src/State_GameOver.c:24: }
   2F34 C9            [10]  129 	ret
                            130 ;src/State_GameOver.c:26: void state_gameover_input(){
                            131 ;	---------------------------------
                            132 ; Function state_gameover_input
                            133 ; ---------------------------------
   2F35                     134 _state_gameover_input::
                            135 ;src/State_GameOver.c:27: if(cpct_isAnyKeyPressed_f ()){
   2F35 CD 21 7C      [17]  136 	call	_cpct_isAnyKeyPressed_f
   2F38 7D            [ 4]  137 	ld	a,l
   2F39 B7            [ 4]  138 	or	a, a
   2F3A C8            [11]  139 	ret	Z
                            140 ;src/State_GameOver.c:28: statemanager_input_accepted();
   2F3B C3 90 38      [10]  141 	jp  _statemanager_input_accepted
                            142 ;src/State_GameOver.c:32: void state_gameover_update(){
                            143 ;	---------------------------------
                            144 ; Function state_gameover_update
                            145 ; ---------------------------------
   2F3E                     146 _state_gameover_update::
                            147 ;src/State_GameOver.c:33: statemanager_set_state(STATE_MAINMENU);
   2F3E AF            [ 4]  148 	xor	a, a
   2F3F F5            [11]  149 	push	af
   2F40 33            [ 6]  150 	inc	sp
   2F41 CD 96 38      [17]  151 	call	_statemanager_set_state
   2F44 33            [ 6]  152 	inc	sp
   2F45 C9            [10]  153 	ret
                            154 ;src/State_GameOver.c:36: void state_gameover_render(){
                            155 ;	---------------------------------
                            156 ; Function state_gameover_render
                            157 ; ---------------------------------
   2F46                     158 _state_gameover_render::
                            159 ;src/State_GameOver.c:38: }
   2F46 C9            [10]  160 	ret
                            161 ;src/State_GameOver.c:40: void state_gameover_exit(){
                            162 ;	---------------------------------
                            163 ; Function state_gameover_exit
                            164 ; ---------------------------------
   2F47                     165 _state_gameover_exit::
                            166 ;src/State_GameOver.c:42: }
   2F47 C9            [10]  167 	ret
                            168 	.area _CODE
                            169 	.area _INITIALIZER
                            170 	.area _CABS (ABS)
