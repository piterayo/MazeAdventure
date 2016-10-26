                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module StringInput
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _cpct_memset
                             12 	.globl _currentPos
                             13 	.globl _inputString
                             14 	.globl _ui_stringinput_init
                             15 	.globl _ui_stringinput_add_char
                             16 	.globl _ui_stringinput_get_string
                             17 	.globl _ui_stringinput_remove_char
                             18 ;--------------------------------------------------------
                             19 ; special function registers
                             20 ;--------------------------------------------------------
                             21 ;--------------------------------------------------------
                             22 ; ram data
                             23 ;--------------------------------------------------------
                             24 	.area _DATA
   872E                      25 _inputString::
   872E                      26 	.ds 19
   8741                      27 _currentPos::
   8741                      28 	.ds 1
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
                             53 ;src/StringInput.c:10: void ui_stringinput_init(){
                             54 ;	---------------------------------
                             55 ; Function ui_stringinput_init
                             56 ; ---------------------------------
   3D87                      57 _ui_stringinput_init::
                             58 ;src/StringInput.c:11: currentPos=0;
   3D87 21 41 87      [10]   59 	ld	hl,#_currentPos + 0
   3D8A 36 00         [10]   60 	ld	(hl), #0x00
                             61 ;src/StringInput.c:12: cpct_memset(inputString, 0, MAX_INPUT_STRING+1);
   3D8C 21 13 00      [10]   62 	ld	hl,#0x0013
   3D8F E5            [11]   63 	push	hl
   3D90 AF            [ 4]   64 	xor	a, a
   3D91 F5            [11]   65 	push	af
   3D92 33            [ 6]   66 	inc	sp
   3D93 21 2E 87      [10]   67 	ld	hl,#_inputString
   3D96 E5            [11]   68 	push	hl
   3D97 CD 11 85      [17]   69 	call	_cpct_memset
   3D9A C9            [10]   70 	ret
                             71 ;src/StringInput.c:15: void ui_stringinput_add_char(u8 c){
                             72 ;	---------------------------------
                             73 ; Function ui_stringinput_add_char
                             74 ; ---------------------------------
   3D9B                      75 _ui_stringinput_add_char::
                             76 ;src/StringInput.c:16: if(currentPos<MAX_INPUT_STRING){
   3D9B 3A 41 87      [13]   77 	ld	a,(#_currentPos + 0)
   3D9E D6 12         [ 7]   78 	sub	a, #0x12
   3DA0 D0            [11]   79 	ret	NC
                             80 ;src/StringInput.c:17: inputString[currentPos] = c;
   3DA1 01 2E 87      [10]   81 	ld	bc,#_inputString+0
   3DA4 2A 41 87      [16]   82 	ld	hl,(_currentPos)
   3DA7 26 00         [ 7]   83 	ld	h,#0x00
   3DA9 09            [11]   84 	add	hl,bc
   3DAA FD 21 02 00   [14]   85 	ld	iy,#2
   3DAE FD 39         [15]   86 	add	iy,sp
   3DB0 FD 7E 00      [19]   87 	ld	a,0 (iy)
   3DB3 77            [ 7]   88 	ld	(hl),a
                             89 ;src/StringInput.c:18: ++currentPos;
   3DB4 21 41 87      [10]   90 	ld	hl, #_currentPos+0
   3DB7 34            [11]   91 	inc	(hl)
   3DB8 C9            [10]   92 	ret
                             93 ;src/StringInput.c:22: char* const ui_stringinput_get_string(){
                             94 ;	---------------------------------
                             95 ; Function ui_stringinput_get_string
                             96 ; ---------------------------------
   3DB9                      97 _ui_stringinput_get_string::
                             98 ;src/StringInput.c:23: return inputString;
   3DB9 21 2E 87      [10]   99 	ld	hl,#_inputString
   3DBC C9            [10]  100 	ret
                            101 ;src/StringInput.c:26: void ui_stringinput_remove_char(){
                            102 ;	---------------------------------
                            103 ; Function ui_stringinput_remove_char
                            104 ; ---------------------------------
   3DBD                     105 _ui_stringinput_remove_char::
                            106 ;src/StringInput.c:27: if(currentPos>0){
   3DBD 3A 41 87      [13]  107 	ld	a,(#_currentPos + 0)
   3DC0 B7            [ 4]  108 	or	a, a
   3DC1 C8            [11]  109 	ret	Z
                            110 ;src/StringInput.c:28: --currentPos;
   3DC2 21 41 87      [10]  111 	ld	hl, #_currentPos+0
   3DC5 35            [11]  112 	dec	(hl)
                            113 ;src/StringInput.c:29: inputString[currentPos] = 0;
   3DC6 01 2E 87      [10]  114 	ld	bc,#_inputString+0
   3DC9 2A 41 87      [16]  115 	ld	hl,(_currentPos)
   3DCC 26 00         [ 7]  116 	ld	h,#0x00
   3DCE 09            [11]  117 	add	hl,bc
   3DCF 36 00         [10]  118 	ld	(hl),#0x00
   3DD1 C9            [10]  119 	ret
                            120 	.area _CODE
                            121 	.area _INITIALIZER
                            122 	.area _CABS (ABS)
