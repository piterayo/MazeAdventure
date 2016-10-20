                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_Options
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _state_options_enter
                             12 	.globl _state_options_return
                             13 	.globl _state_options_input
                             14 	.globl _state_options_update
                             15 	.globl _state_options_render
                             16 	.globl _state_options_exit
                             17 ;--------------------------------------------------------
                             18 ; special function registers
                             19 ;--------------------------------------------------------
                             20 ;--------------------------------------------------------
                             21 ; ram data
                             22 ;--------------------------------------------------------
                             23 	.area _DATA
                             24 ;--------------------------------------------------------
                             25 ; ram data
                             26 ;--------------------------------------------------------
                             27 	.area _INITIALIZED
                             28 ;--------------------------------------------------------
                             29 ; absolute external ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DABS (ABS)
                             32 ;--------------------------------------------------------
                             33 ; global & static initialisations
                             34 ;--------------------------------------------------------
                             35 	.area _HOME
                             36 	.area _GSINIT
                             37 	.area _GSFINAL
                             38 	.area _GSINIT
                             39 ;--------------------------------------------------------
                             40 ; Home
                             41 ;--------------------------------------------------------
                             42 	.area _HOME
                             43 	.area _HOME
                             44 ;--------------------------------------------------------
                             45 ; code
                             46 ;--------------------------------------------------------
                             47 	.area _CODE
                             48 ;src/State_Options.c:7: void state_options_enter(){
                             49 ;	---------------------------------
                             50 ; Function state_options_enter
                             51 ; ---------------------------------
   1E76                      52 _state_options_enter::
                             53 ;src/State_Options.c:9: }
   1E76 C9            [10]   54 	ret
                             55 ;src/State_Options.c:11: void state_options_return(){
                             56 ;	---------------------------------
                             57 ; Function state_options_return
                             58 ; ---------------------------------
   1E77                      59 _state_options_return::
                             60 ;src/State_Options.c:13: }
   1E77 C9            [10]   61 	ret
                             62 ;src/State_Options.c:15: void state_options_input(){
                             63 ;	---------------------------------
                             64 ; Function state_options_input
                             65 ; ---------------------------------
   1E78                      66 _state_options_input::
                             67 ;src/State_Options.c:17: }
   1E78 C9            [10]   68 	ret
                             69 ;src/State_Options.c:19: void state_options_update(){
                             70 ;	---------------------------------
                             71 ; Function state_options_update
                             72 ; ---------------------------------
   1E79                      73 _state_options_update::
                             74 ;src/State_Options.c:21: }
   1E79 C9            [10]   75 	ret
                             76 ;src/State_Options.c:23: void state_options_render(){
                             77 ;	---------------------------------
                             78 ; Function state_options_render
                             79 ; ---------------------------------
   1E7A                      80 _state_options_render::
                             81 ;src/State_Options.c:25: }
   1E7A C9            [10]   82 	ret
                             83 ;src/State_Options.c:27: void state_options_exit(){
                             84 ;	---------------------------------
                             85 ; Function state_options_exit
                             86 ; ---------------------------------
   1E7B                      87 _state_options_exit::
                             88 ;src/State_Options.c:29: }
   1E7B C9            [10]   89 	ret
                             90 	.area _CODE
                             91 	.area _INITIALIZER
                             92 	.area _CABS (ABS)
