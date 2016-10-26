                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_Victory
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _statemanager_input_accepted
                             12 	.globl _statemanager_set_state
                             13 	.globl _print_transparent_text
                             14 	.globl _cpct_isAnyKeyPressed_f
                             15 	.globl _cpct_memset
                             16 	.globl _state_victory_enter
                             17 	.globl _state_victory_return
                             18 	.globl _state_victory_input
                             19 	.globl _state_victory_update
                             20 	.globl _state_victory_render
                             21 	.globl _state_victory_exit
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
                             53 ;src/State_Victory.c:15: void state_victory_enter(){
                             54 ;	---------------------------------
                             55 ; Function state_victory_enter
                             56 ; ---------------------------------
   3BBE                      57 _state_victory_enter::
                             58 ;src/State_Victory.c:16: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   3BBE 21 B0 1A      [10]   59 	ld	hl,#_g_colors+1
   3BC1 46            [ 7]   60 	ld	b,(hl)
   3BC2 21 00 40      [10]   61 	ld	hl,#0x4000
   3BC5 E5            [11]   62 	push	hl
   3BC6 C5            [11]   63 	push	bc
   3BC7 33            [ 6]   64 	inc	sp
   3BC8 26 C0         [ 7]   65 	ld	h, #0xC0
   3BCA E5            [11]   66 	push	hl
   3BCB CD 9A 7B      [17]   67 	call	_cpct_memset
                             68 ;src/State_Victory.c:17: print_transparent_text("CONGRATULATIONS!", cpctm_screenPtr((u16)CPCT_VMEM_START,24,92), 3);
   3BCE 3E 03         [ 7]   69 	ld	a,#0x03
   3BD0 F5            [11]   70 	push	af
   3BD1 33            [ 6]   71 	inc	sp
   3BD2 21 88 E3      [10]   72 	ld	hl,#0xE388
   3BD5 E5            [11]   73 	push	hl
   3BD6 21 F3 3B      [10]   74 	ld	hl,#___str_0
   3BD9 E5            [11]   75 	push	hl
   3BDA CD C6 3F      [17]   76 	call	_print_transparent_text
   3BDD F1            [10]   77 	pop	af
   3BDE F1            [10]   78 	pop	af
   3BDF 33            [ 6]   79 	inc	sp
                             80 ;src/State_Victory.c:18: print_transparent_text("YOU HAVE DEFEATED THE EVIL KING!", cpctm_screenPtr((u16)CPCT_VMEM_START,8,100), 3);
   3BE0 3E 03         [ 7]   81 	ld	a,#0x03
   3BE2 F5            [11]   82 	push	af
   3BE3 33            [ 6]   83 	inc	sp
   3BE4 21 C8 E3      [10]   84 	ld	hl,#0xE3C8
   3BE7 E5            [11]   85 	push	hl
   3BE8 21 04 3C      [10]   86 	ld	hl,#___str_1
   3BEB E5            [11]   87 	push	hl
   3BEC CD C6 3F      [17]   88 	call	_print_transparent_text
   3BEF F1            [10]   89 	pop	af
   3BF0 F1            [10]   90 	pop	af
   3BF1 33            [ 6]   91 	inc	sp
   3BF2 C9            [10]   92 	ret
   3BF3                      93 ___str_0:
   3BF3 43 4F 4E 47 52 41    94 	.ascii "CONGRATULATIONS!"
        54 55 4C 41 54 49
        4F 4E 53 21
   3C03 00                   95 	.db 0x00
   3C04                      96 ___str_1:
   3C04 59 4F 55 20 48 41    97 	.ascii "YOU HAVE DEFEATED THE EVIL KING!"
        56 45 20 44 45 46
        45 41 54 45 44 20
        54 48 45 20 45 56
        49 4C 20 4B 49 4E
        47 21
   3C24 00                   98 	.db 0x00
                             99 ;src/State_Victory.c:21: void state_victory_return(){
                            100 ;	---------------------------------
                            101 ; Function state_victory_return
                            102 ; ---------------------------------
   3C25                     103 _state_victory_return::
                            104 ;src/State_Victory.c:23: }
   3C25 C9            [10]  105 	ret
                            106 ;src/State_Victory.c:25: void state_victory_input(){
                            107 ;	---------------------------------
                            108 ; Function state_victory_input
                            109 ; ---------------------------------
   3C26                     110 _state_victory_input::
                            111 ;src/State_Victory.c:26: if(cpct_isAnyKeyPressed_f ()){
   3C26 CD 69 7B      [17]  112 	call	_cpct_isAnyKeyPressed_f
   3C29 7D            [ 4]  113 	ld	a,l
   3C2A B7            [ 4]  114 	or	a, a
   3C2B C8            [11]  115 	ret	Z
                            116 ;src/State_Victory.c:27: statemanager_input_accepted();
   3C2C C3 B6 38      [10]  117 	jp  _statemanager_input_accepted
                            118 ;src/State_Victory.c:31: void state_victory_update(){
                            119 ;	---------------------------------
                            120 ; Function state_victory_update
                            121 ; ---------------------------------
   3C2F                     122 _state_victory_update::
                            123 ;src/State_Victory.c:32: statemanager_set_state(STATE_MAINMENU);
   3C2F AF            [ 4]  124 	xor	a, a
   3C30 F5            [11]  125 	push	af
   3C31 33            [ 6]  126 	inc	sp
   3C32 CD BC 38      [17]  127 	call	_statemanager_set_state
   3C35 33            [ 6]  128 	inc	sp
   3C36 C9            [10]  129 	ret
                            130 ;src/State_Victory.c:35: void state_victory_render(){
                            131 ;	---------------------------------
                            132 ; Function state_victory_render
                            133 ; ---------------------------------
   3C37                     134 _state_victory_render::
                            135 ;src/State_Victory.c:37: }
   3C37 C9            [10]  136 	ret
                            137 ;src/State_Victory.c:39: void state_victory_exit(){
                            138 ;	---------------------------------
                            139 ; Function state_victory_exit
                            140 ; ---------------------------------
   3C38                     141 _state_victory_exit::
                            142 ;src/State_Victory.c:41: }
   3C38 C9            [10]  143 	ret
                            144 	.area _CODE
                            145 	.area _INITIALIZER
                            146 	.area _CABS (ABS)
