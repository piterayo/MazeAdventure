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
   2F17                      59 _state_gameover_enter::
                             60 ;src/State_GameOver.c:16: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   2F17 21 B0 1A      [10]   61 	ld	hl,#_g_colors+1
   2F1A 46            [ 7]   62 	ld	b,(hl)
   2F1B 21 00 40      [10]   63 	ld	hl,#0x4000
   2F1E E5            [11]   64 	push	hl
   2F1F C5            [11]   65 	push	bc
   2F20 33            [ 6]   66 	inc	sp
   2F21 26 C0         [ 7]   67 	ld	h, #0xC0
   2F23 E5            [11]   68 	push	hl
   2F24 CD 9A 7B      [17]   69 	call	_cpct_memset
                             70 ;src/State_GameOver.c:17: print_transparent_text("GAME OVER", cpctm_screenPtr((u16)CPCT_VMEM_START,32,92), 3);
   2F27 3E 03         [ 7]   71 	ld	a,#0x03
   2F29 F5            [11]   72 	push	af
   2F2A 33            [ 6]   73 	inc	sp
   2F2B 21 90 E3      [10]   74 	ld	hl,#0xE390
   2F2E E5            [11]   75 	push	hl
   2F2F 21 6B 2F      [10]   76 	ld	hl,#___str_0
   2F32 E5            [11]   77 	push	hl
   2F33 CD C6 3F      [17]   78 	call	_print_transparent_text
   2F36 F1            [10]   79 	pop	af
   2F37 F1            [10]   80 	pop	af
   2F38 33            [ 6]   81 	inc	sp
                             82 ;src/State_GameOver.c:18: print_transparent_text("LEVEL: ", cpctm_screenPtr((u16)CPCT_VMEM_START,30,100), 3);
   2F39 3E 03         [ 7]   83 	ld	a,#0x03
   2F3B F5            [11]   84 	push	af
   2F3C 33            [ 6]   85 	inc	sp
   2F3D 21 DE E3      [10]   86 	ld	hl,#0xE3DE
   2F40 E5            [11]   87 	push	hl
   2F41 21 75 2F      [10]   88 	ld	hl,#___str_1
   2F44 E5            [11]   89 	push	hl
   2F45 CD C6 3F      [17]   90 	call	_print_transparent_text
   2F48 F1            [10]   91 	pop	af
   2F49 F1            [10]   92 	pop	af
   2F4A 33            [ 6]   93 	inc	sp
                             94 ;src/State_GameOver.c:19: print_transparent_text(integer_to_string(level_get_level(),'d'), cpctm_screenPtr((u16)CPCT_VMEM_START,46,100), 3);
   2F4B CD F0 0F      [17]   95 	call	_level_get_level
   2F4E 45            [ 4]   96 	ld	b,l
   2F4F 3E 64         [ 7]   97 	ld	a,#0x64
   2F51 F5            [11]   98 	push	af
   2F52 33            [ 6]   99 	inc	sp
   2F53 C5            [11]  100 	push	bc
   2F54 33            [ 6]  101 	inc	sp
   2F55 CD 84 3C      [17]  102 	call	_integer_to_string
   2F58 F1            [10]  103 	pop	af
   2F59 4D            [ 4]  104 	ld	c,l
   2F5A 44            [ 4]  105 	ld	b,h
   2F5B 3E 03         [ 7]  106 	ld	a,#0x03
   2F5D F5            [11]  107 	push	af
   2F5E 33            [ 6]  108 	inc	sp
   2F5F 21 EE E3      [10]  109 	ld	hl,#0xE3EE
   2F62 E5            [11]  110 	push	hl
   2F63 C5            [11]  111 	push	bc
   2F64 CD C6 3F      [17]  112 	call	_print_transparent_text
   2F67 F1            [10]  113 	pop	af
   2F68 F1            [10]  114 	pop	af
   2F69 33            [ 6]  115 	inc	sp
   2F6A C9            [10]  116 	ret
   2F6B                     117 ___str_0:
   2F6B 47 41 4D 45 20 4F   118 	.ascii "GAME OVER"
        56 45 52
   2F74 00                  119 	.db 0x00
   2F75                     120 ___str_1:
   2F75 4C 45 56 45 4C 3A   121 	.ascii "LEVEL: "
        20
   2F7C 00                  122 	.db 0x00
                            123 ;src/State_GameOver.c:22: void state_gameover_return(){
                            124 ;	---------------------------------
                            125 ; Function state_gameover_return
                            126 ; ---------------------------------
   2F7D                     127 _state_gameover_return::
                            128 ;src/State_GameOver.c:24: }
   2F7D C9            [10]  129 	ret
                            130 ;src/State_GameOver.c:26: void state_gameover_input(){
                            131 ;	---------------------------------
                            132 ; Function state_gameover_input
                            133 ; ---------------------------------
   2F7E                     134 _state_gameover_input::
                            135 ;src/State_GameOver.c:27: if(cpct_isAnyKeyPressed_f ()){
   2F7E CD 69 7B      [17]  136 	call	_cpct_isAnyKeyPressed_f
   2F81 7D            [ 4]  137 	ld	a,l
   2F82 B7            [ 4]  138 	or	a, a
   2F83 C8            [11]  139 	ret	Z
                            140 ;src/State_GameOver.c:28: statemanager_input_accepted();
   2F84 C3 B6 38      [10]  141 	jp  _statemanager_input_accepted
                            142 ;src/State_GameOver.c:32: void state_gameover_update(){
                            143 ;	---------------------------------
                            144 ; Function state_gameover_update
                            145 ; ---------------------------------
   2F87                     146 _state_gameover_update::
                            147 ;src/State_GameOver.c:33: statemanager_set_state(STATE_MAINMENU);
   2F87 AF            [ 4]  148 	xor	a, a
   2F88 F5            [11]  149 	push	af
   2F89 33            [ 6]  150 	inc	sp
   2F8A CD BC 38      [17]  151 	call	_statemanager_set_state
   2F8D 33            [ 6]  152 	inc	sp
   2F8E C9            [10]  153 	ret
                            154 ;src/State_GameOver.c:36: void state_gameover_render(){
                            155 ;	---------------------------------
                            156 ; Function state_gameover_render
                            157 ; ---------------------------------
   2F8F                     158 _state_gameover_render::
                            159 ;src/State_GameOver.c:38: }
   2F8F C9            [10]  160 	ret
                            161 ;src/State_GameOver.c:40: void state_gameover_exit(){
                            162 ;	---------------------------------
                            163 ; Function state_gameover_exit
                            164 ; ---------------------------------
   2F90                     165 _state_gameover_exit::
                            166 ;src/State_GameOver.c:42: }
   2F90 C9            [10]  167 	ret
                            168 	.area _CODE
                            169 	.area _INITIALIZER
                            170 	.area _CABS (ABS)
