                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module main
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 	.globl _statemanager_main_loop
                             13 	.globl _statemanager_set_state
                             14 	.globl _game_init
                             15 ;--------------------------------------------------------
                             16 ; special function registers
                             17 ;--------------------------------------------------------
                             18 ;--------------------------------------------------------
                             19 ; ram data
                             20 ;--------------------------------------------------------
                             21 	.area _DATA
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _INITIALIZED
                             26 ;--------------------------------------------------------
                             27 ; absolute external ram data
                             28 ;--------------------------------------------------------
                             29 	.area _DABS (ABS)
                             30 ;--------------------------------------------------------
                             31 ; global & static initialisations
                             32 ;--------------------------------------------------------
                             33 	.area _HOME
                             34 	.area _GSINIT
                             35 	.area _GSFINAL
                             36 	.area _GSINIT
                             37 ;--------------------------------------------------------
                             38 ; Home
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _HOME
                             42 ;--------------------------------------------------------
                             43 ; code
                             44 ;--------------------------------------------------------
                             45 	.area _CODE
                             46 ;src/main.c:27: void main(void) {
                             47 ;	---------------------------------
                             48 ; Function main
                             49 ; ---------------------------------
   124A                      50 _main::
                             51 ;src/main.c:29: game_init();
   124A CD 1A 0D      [17]   52 	call	_game_init
                             53 ;src/main.c:31: statemanager_set_state(STATE_MAINMENU);
   124D AF            [ 4]   54 	xor	a, a
   124E F5            [11]   55 	push	af
   124F 33            [ 6]   56 	inc	sp
   1250 CD 01 3A      [17]   57 	call	_statemanager_set_state
   1253 33            [ 6]   58 	inc	sp
                             59 ;src/main.c:33: statemanager_main_loop();
   1254 C3 CC 3A      [10]   60 	jp  _statemanager_main_loop
                             61 	.area _CODE
                             62 	.area _INITIALIZER
                             63 	.area _CABS (ABS)
