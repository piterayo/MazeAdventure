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
   7E6C                      25 _inputString::
   7E6C                      26 	.ds 19
   7E7F                      27 _currentPos::
   7E7F                      28 	.ds 1
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
   3C13                      57 _ui_stringinput_init::
                             58 ;src/StringInput.c:11: currentPos=0;
   3C13 21 7F 7E      [10]   59 	ld	hl,#_currentPos + 0
   3C16 36 00         [10]   60 	ld	(hl), #0x00
                             61 ;src/StringInput.c:12: cpct_memset(inputString, 0, MAX_INPUT_STRING+1);
   3C18 21 13 00      [10]   62 	ld	hl,#0x0013
   3C1B E5            [11]   63 	push	hl
   3C1C AF            [ 4]   64 	xor	a, a
   3C1D F5            [11]   65 	push	af
   3C1E 33            [ 6]   66 	inc	sp
   3C1F 21 6C 7E      [10]   67 	ld	hl,#_inputString
   3C22 E5            [11]   68 	push	hl
   3C23 CD 52 7C      [17]   69 	call	_cpct_memset
   3C26 C9            [10]   70 	ret
                             71 ;src/StringInput.c:15: void ui_stringinput_add_char(u8 c){
                             72 ;	---------------------------------
                             73 ; Function ui_stringinput_add_char
                             74 ; ---------------------------------
   3C27                      75 _ui_stringinput_add_char::
                             76 ;src/StringInput.c:16: if(currentPos<MAX_INPUT_STRING){
   3C27 3A 7F 7E      [13]   77 	ld	a,(#_currentPos + 0)
   3C2A D6 12         [ 7]   78 	sub	a, #0x12
   3C2C D0            [11]   79 	ret	NC
                             80 ;src/StringInput.c:17: inputString[currentPos] = c;
   3C2D 01 6C 7E      [10]   81 	ld	bc,#_inputString+0
   3C30 2A 7F 7E      [16]   82 	ld	hl,(_currentPos)
   3C33 26 00         [ 7]   83 	ld	h,#0x00
   3C35 09            [11]   84 	add	hl,bc
   3C36 FD 21 02 00   [14]   85 	ld	iy,#2
   3C3A FD 39         [15]   86 	add	iy,sp
   3C3C FD 7E 00      [19]   87 	ld	a,0 (iy)
   3C3F 77            [ 7]   88 	ld	(hl),a
                             89 ;src/StringInput.c:18: ++currentPos;
   3C40 21 7F 7E      [10]   90 	ld	hl, #_currentPos+0
   3C43 34            [11]   91 	inc	(hl)
   3C44 C9            [10]   92 	ret
                             93 ;src/StringInput.c:22: char* const ui_stringinput_get_string(){
                             94 ;	---------------------------------
                             95 ; Function ui_stringinput_get_string
                             96 ; ---------------------------------
   3C45                      97 _ui_stringinput_get_string::
                             98 ;src/StringInput.c:23: return inputString;
   3C45 21 6C 7E      [10]   99 	ld	hl,#_inputString
   3C48 C9            [10]  100 	ret
                            101 ;src/StringInput.c:26: void ui_stringinput_remove_char(){
                            102 ;	---------------------------------
                            103 ; Function ui_stringinput_remove_char
                            104 ; ---------------------------------
   3C49                     105 _ui_stringinput_remove_char::
                            106 ;src/StringInput.c:27: if(currentPos>0){
   3C49 3A 7F 7E      [13]  107 	ld	a,(#_currentPos + 0)
   3C4C B7            [ 4]  108 	or	a, a
   3C4D C8            [11]  109 	ret	Z
                            110 ;src/StringInput.c:28: --currentPos;
   3C4E 21 7F 7E      [10]  111 	ld	hl, #_currentPos+0
   3C51 35            [11]  112 	dec	(hl)
                            113 ;src/StringInput.c:29: inputString[currentPos] = 0;
   3C52 01 6C 7E      [10]  114 	ld	bc,#_inputString+0
   3C55 2A 7F 7E      [16]  115 	ld	hl,(_currentPos)
   3C58 26 00         [ 7]  116 	ld	h,#0x00
   3C5A 09            [11]  117 	add	hl,bc
   3C5B 36 00         [10]  118 	ld	(hl),#0x00
   3C5D C9            [10]  119 	ret
                            120 	.area _CODE
                            121 	.area _INITIALIZER
                            122 	.area _CABS (ABS)
