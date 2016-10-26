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
   3D0C                      57 _state_victory_enter::
                             58 ;src/State_Victory.c:16: cpct_memset(CPCT_VMEM_START, g_colors[1], 0x4000);
   3D0C 21 29 1C      [10]   59 	ld	hl,#_g_colors+1
   3D0F 46            [ 7]   60 	ld	b,(hl)
   3D10 21 00 40      [10]   61 	ld	hl,#0x4000
   3D13 E5            [11]   62 	push	hl
   3D14 C5            [11]   63 	push	bc
   3D15 33            [ 6]   64 	inc	sp
   3D16 26 C0         [ 7]   65 	ld	h, #0xC0
   3D18 E5            [11]   66 	push	hl
   3D19 CD 11 85      [17]   67 	call	_cpct_memset
                             68 ;src/State_Victory.c:17: print_transparent_text("CONGRATULATIONS!", cpctm_screenPtr((u16)CPCT_VMEM_START,24,92), 3);
   3D1C 3E 03         [ 7]   69 	ld	a,#0x03
   3D1E F5            [11]   70 	push	af
   3D1F 33            [ 6]   71 	inc	sp
   3D20 21 88 E3      [10]   72 	ld	hl,#0xE388
   3D23 E5            [11]   73 	push	hl
   3D24 21 41 3D      [10]   74 	ld	hl,#___str_0
   3D27 E5            [11]   75 	push	hl
   3D28 CD 14 41      [17]   76 	call	_print_transparent_text
   3D2B F1            [10]   77 	pop	af
   3D2C F1            [10]   78 	pop	af
   3D2D 33            [ 6]   79 	inc	sp
                             80 ;src/State_Victory.c:18: print_transparent_text("YOU HAVE DEFEATED THE EVIL KING!", cpctm_screenPtr((u16)CPCT_VMEM_START,8,100), 3);
   3D2E 3E 03         [ 7]   81 	ld	a,#0x03
   3D30 F5            [11]   82 	push	af
   3D31 33            [ 6]   83 	inc	sp
   3D32 21 C8 E3      [10]   84 	ld	hl,#0xE3C8
   3D35 E5            [11]   85 	push	hl
   3D36 21 52 3D      [10]   86 	ld	hl,#___str_1
   3D39 E5            [11]   87 	push	hl
   3D3A CD 14 41      [17]   88 	call	_print_transparent_text
   3D3D F1            [10]   89 	pop	af
   3D3E F1            [10]   90 	pop	af
   3D3F 33            [ 6]   91 	inc	sp
   3D40 C9            [10]   92 	ret
   3D41                      93 ___str_0:
   3D41 43 4F 4E 47 52 41    94 	.ascii "CONGRATULATIONS!"
        54 55 4C 41 54 49
        4F 4E 53 21
   3D51 00                   95 	.db 0x00
   3D52                      96 ___str_1:
   3D52 59 4F 55 20 48 41    97 	.ascii "YOU HAVE DEFEATED THE EVIL KING!"
        56 45 20 44 45 46
        45 41 54 45 44 20
        54 48 45 20 45 56
        49 4C 20 4B 49 4E
        47 21
   3D72 00                   98 	.db 0x00
                             99 ;src/State_Victory.c:21: void state_victory_return(){
                            100 ;	---------------------------------
                            101 ; Function state_victory_return
                            102 ; ---------------------------------
   3D73                     103 _state_victory_return::
                            104 ;src/State_Victory.c:23: }
   3D73 C9            [10]  105 	ret
                            106 ;src/State_Victory.c:25: void state_victory_input(){
                            107 ;	---------------------------------
                            108 ; Function state_victory_input
                            109 ; ---------------------------------
   3D74                     110 _state_victory_input::
                            111 ;src/State_Victory.c:26: if(cpct_isAnyKeyPressed_f ()){
   3D74 CD E0 84      [17]  112 	call	_cpct_isAnyKeyPressed_f
   3D77 7D            [ 4]  113 	ld	a,l
   3D78 B7            [ 4]  114 	or	a, a
   3D79 C8            [11]  115 	ret	Z
                            116 ;src/State_Victory.c:27: statemanager_input_accepted();
   3D7A C3 FB 39      [10]  117 	jp  _statemanager_input_accepted
                            118 ;src/State_Victory.c:31: void state_victory_update(){
                            119 ;	---------------------------------
                            120 ; Function state_victory_update
                            121 ; ---------------------------------
   3D7D                     122 _state_victory_update::
                            123 ;src/State_Victory.c:32: statemanager_set_state(STATE_MAINMENU);
   3D7D AF            [ 4]  124 	xor	a, a
   3D7E F5            [11]  125 	push	af
   3D7F 33            [ 6]  126 	inc	sp
   3D80 CD 01 3A      [17]  127 	call	_statemanager_set_state
   3D83 33            [ 6]  128 	inc	sp
   3D84 C9            [10]  129 	ret
                            130 ;src/State_Victory.c:35: void state_victory_render(){
                            131 ;	---------------------------------
                            132 ; Function state_victory_render
                            133 ; ---------------------------------
   3D85                     134 _state_victory_render::
                            135 ;src/State_Victory.c:37: }
   3D85 C9            [10]  136 	ret
                            137 ;src/State_Victory.c:39: void state_victory_exit(){
                            138 ;	---------------------------------
                            139 ; Function state_victory_exit
                            140 ; ---------------------------------
   3D86                     141 _state_victory_exit::
                            142 ;src/State_Victory.c:41: }
   3D86 C9            [10]  143 	ret
                            144 	.area _CODE
                            145 	.area _INITIALIZER
                            146 	.area _CABS (ABS)
