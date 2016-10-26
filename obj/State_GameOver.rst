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
   304E                      59 _state_gameover_enter::
                             60 ;src/State_GameOver.c:16: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   304E 21 29 1C      [10]   61 	ld	hl,#_g_colors+1
   3051 46            [ 7]   62 	ld	b,(hl)
   3052 21 00 40      [10]   63 	ld	hl,#0x4000
   3055 E5            [11]   64 	push	hl
   3056 C5            [11]   65 	push	bc
   3057 33            [ 6]   66 	inc	sp
   3058 26 C0         [ 7]   67 	ld	h, #0xC0
   305A E5            [11]   68 	push	hl
   305B CD 11 85      [17]   69 	call	_cpct_memset
                             70 ;src/State_GameOver.c:17: print_transparent_text("GAME OVER", cpctm_screenPtr((u16)CPCT_VMEM_START,32,92), 3);
   305E 3E 03         [ 7]   71 	ld	a,#0x03
   3060 F5            [11]   72 	push	af
   3061 33            [ 6]   73 	inc	sp
   3062 21 90 E3      [10]   74 	ld	hl,#0xE390
   3065 E5            [11]   75 	push	hl
   3066 21 A2 30      [10]   76 	ld	hl,#___str_0
   3069 E5            [11]   77 	push	hl
   306A CD 14 41      [17]   78 	call	_print_transparent_text
   306D F1            [10]   79 	pop	af
   306E F1            [10]   80 	pop	af
   306F 33            [ 6]   81 	inc	sp
                             82 ;src/State_GameOver.c:18: print_transparent_text("LEVEL: ", cpctm_screenPtr((u16)CPCT_VMEM_START,30,100), 3);
   3070 3E 03         [ 7]   83 	ld	a,#0x03
   3072 F5            [11]   84 	push	af
   3073 33            [ 6]   85 	inc	sp
   3074 21 DE E3      [10]   86 	ld	hl,#0xE3DE
   3077 E5            [11]   87 	push	hl
   3078 21 AC 30      [10]   88 	ld	hl,#___str_1
   307B E5            [11]   89 	push	hl
   307C CD 14 41      [17]   90 	call	_print_transparent_text
   307F F1            [10]   91 	pop	af
   3080 F1            [10]   92 	pop	af
   3081 33            [ 6]   93 	inc	sp
                             94 ;src/State_GameOver.c:19: print_transparent_text(integer_to_string(level_get_level(),'d'), cpctm_screenPtr((u16)CPCT_VMEM_START,46,100), 3);
   3082 CD 59 11      [17]   95 	call	_level_get_level
   3085 45            [ 4]   96 	ld	b,l
   3086 3E 64         [ 7]   97 	ld	a,#0x64
   3088 F5            [11]   98 	push	af
   3089 33            [ 6]   99 	inc	sp
   308A C5            [11]  100 	push	bc
   308B 33            [ 6]  101 	inc	sp
   308C CD D2 3D      [17]  102 	call	_integer_to_string
   308F F1            [10]  103 	pop	af
   3090 4D            [ 4]  104 	ld	c,l
   3091 44            [ 4]  105 	ld	b,h
   3092 3E 03         [ 7]  106 	ld	a,#0x03
   3094 F5            [11]  107 	push	af
   3095 33            [ 6]  108 	inc	sp
   3096 21 EE E3      [10]  109 	ld	hl,#0xE3EE
   3099 E5            [11]  110 	push	hl
   309A C5            [11]  111 	push	bc
   309B CD 14 41      [17]  112 	call	_print_transparent_text
   309E F1            [10]  113 	pop	af
   309F F1            [10]  114 	pop	af
   30A0 33            [ 6]  115 	inc	sp
   30A1 C9            [10]  116 	ret
   30A2                     117 ___str_0:
   30A2 47 41 4D 45 20 4F   118 	.ascii "GAME OVER"
        56 45 52
   30AB 00                  119 	.db 0x00
   30AC                     120 ___str_1:
   30AC 4C 45 56 45 4C 3A   121 	.ascii "LEVEL: "
        20
   30B3 00                  122 	.db 0x00
                            123 ;src/State_GameOver.c:22: void state_gameover_return(){
                            124 ;	---------------------------------
                            125 ; Function state_gameover_return
                            126 ; ---------------------------------
   30B4                     127 _state_gameover_return::
                            128 ;src/State_GameOver.c:24: }
   30B4 C9            [10]  129 	ret
                            130 ;src/State_GameOver.c:26: void state_gameover_input(){
                            131 ;	---------------------------------
                            132 ; Function state_gameover_input
                            133 ; ---------------------------------
   30B5                     134 _state_gameover_input::
                            135 ;src/State_GameOver.c:27: if(cpct_isAnyKeyPressed_f ()){
   30B5 CD E0 84      [17]  136 	call	_cpct_isAnyKeyPressed_f
   30B8 7D            [ 4]  137 	ld	a,l
   30B9 B7            [ 4]  138 	or	a, a
   30BA C8            [11]  139 	ret	Z
                            140 ;src/State_GameOver.c:28: statemanager_input_accepted();
   30BB C3 FB 39      [10]  141 	jp  _statemanager_input_accepted
                            142 ;src/State_GameOver.c:32: void state_gameover_update(){
                            143 ;	---------------------------------
                            144 ; Function state_gameover_update
                            145 ; ---------------------------------
   30BE                     146 _state_gameover_update::
                            147 ;src/State_GameOver.c:33: statemanager_set_state(STATE_MAINMENU);
   30BE AF            [ 4]  148 	xor	a, a
   30BF F5            [11]  149 	push	af
   30C0 33            [ 6]  150 	inc	sp
   30C1 CD 01 3A      [17]  151 	call	_statemanager_set_state
   30C4 33            [ 6]  152 	inc	sp
   30C5 C9            [10]  153 	ret
                            154 ;src/State_GameOver.c:36: void state_gameover_render(){
                            155 ;	---------------------------------
                            156 ; Function state_gameover_render
                            157 ; ---------------------------------
   30C6                     158 _state_gameover_render::
                            159 ;src/State_GameOver.c:38: }
   30C6 C9            [10]  160 	ret
                            161 ;src/State_GameOver.c:40: void state_gameover_exit(){
                            162 ;	---------------------------------
                            163 ; Function state_gameover_exit
                            164 ; ---------------------------------
   30C7                     165 _state_gameover_exit::
                            166 ;src/State_GameOver.c:42: }
   30C7 C9            [10]  167 	ret
                            168 	.area _CODE
                            169 	.area _INITIALIZER
                            170 	.area _CABS (ABS)
