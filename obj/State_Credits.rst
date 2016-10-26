                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module State_Credits
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _statemanager_input_accepted
                             12 	.globl _statemanager_close_state
                             13 	.globl _print_transparent_text
                             14 	.globl _cpct_drawSolidBox
                             15 	.globl _cpct_isAnyKeyPressed_f
                             16 	.globl _state_credits_enter
                             17 	.globl _state_credits_return
                             18 	.globl _state_credits_input
                             19 	.globl _state_credits_update
                             20 	.globl _state_credits_render
                             21 	.globl _state_credits_exit
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
                             53 ;src/State_Credits.c:16: void state_credits_enter(){
                             54 ;	---------------------------------
                             55 ; Function state_credits_enter
                             56 ; ---------------------------------
   2F4A                      57 _state_credits_enter::
                             58 ;src/State_Credits.c:18: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[4],52,92);
   2F4A 21 2C 1C      [10]   59 	ld	hl, #_g_colors + 4
   2F4D 46            [ 7]   60 	ld	b,(hl)
   2F4E 21 34 5C      [10]   61 	ld	hl,#0x5C34
   2F51 E5            [11]   62 	push	hl
   2F52 C5            [11]   63 	push	bc
   2F53 33            [ 6]   64 	inc	sp
   2F54 21 9E F1      [10]   65 	ld	hl,#0xF19E
   2F57 E5            [11]   66 	push	hl
   2F58 CD 2F 85      [17]   67 	call	_cpct_drawSolidBox
   2F5B F1            [10]   68 	pop	af
   2F5C F1            [10]   69 	pop	af
   2F5D 33            [ 6]   70 	inc	sp
                             71 ;src/State_Credits.c:19: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,15,50),g_colors[1],50,84);
   2F5E 21 29 1C      [10]   72 	ld	hl, #_g_colors + 1
   2F61 46            [ 7]   73 	ld	b,(hl)
   2F62 21 32 54      [10]   74 	ld	hl,#0x5432
   2F65 E5            [11]   75 	push	hl
   2F66 C5            [11]   76 	push	bc
   2F67 33            [ 6]   77 	inc	sp
   2F68 21 EF D1      [10]   78 	ld	hl,#0xD1EF
   2F6B E5            [11]   79 	push	hl
   2F6C CD 2F 85      [17]   80 	call	_cpct_drawSolidBox
   2F6F F1            [10]   81 	pop	af
   2F70 F1            [10]   82 	pop	af
   2F71 33            [ 6]   83 	inc	sp
                             84 ;src/State_Credits.c:21: print_transparent_text("CODING:", cpctm_screenPtr((u16)CPCT_VMEM_START,16,54),3);
   2F72 3E 03         [ 7]   85 	ld	a,#0x03
   2F74 F5            [11]   86 	push	af
   2F75 33            [ 6]   87 	inc	sp
   2F76 21 F0 F1      [10]   88 	ld	hl,#0xF1F0
   2F79 E5            [11]   89 	push	hl
   2F7A 21 DF 2F      [10]   90 	ld	hl,#___str_0
   2F7D E5            [11]   91 	push	hl
   2F7E CD 14 41      [17]   92 	call	_print_transparent_text
   2F81 F1            [10]   93 	pop	af
   2F82 F1            [10]   94 	pop	af
   2F83 33            [ 6]   95 	inc	sp
                             96 ;src/State_Credits.c:22: print_transparent_text("Albert Sirvent @piterayo",cpctm_screenPtr((u16)CPCT_VMEM_START,16,62),3);
   2F84 3E 03         [ 7]   97 	ld	a,#0x03
   2F86 F5            [11]   98 	push	af
   2F87 33            [ 6]   99 	inc	sp
   2F88 21 40 F2      [10]  100 	ld	hl,#0xF240
   2F8B E5            [11]  101 	push	hl
   2F8C 21 E7 2F      [10]  102 	ld	hl,#___str_1
   2F8F E5            [11]  103 	push	hl
   2F90 CD 14 41      [17]  104 	call	_print_transparent_text
   2F93 F1            [10]  105 	pop	af
   2F94 F1            [10]  106 	pop	af
   2F95 33            [ 6]  107 	inc	sp
                            108 ;src/State_Credits.c:24: print_transparent_text("ART:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,78),3);
   2F96 3E 03         [ 7]  109 	ld	a,#0x03
   2F98 F5            [11]  110 	push	af
   2F99 33            [ 6]  111 	inc	sp
   2F9A 21 E0 F2      [10]  112 	ld	hl,#0xF2E0
   2F9D E5            [11]  113 	push	hl
   2F9E 21 00 30      [10]  114 	ld	hl,#___str_2
   2FA1 E5            [11]  115 	push	hl
   2FA2 CD 14 41      [17]  116 	call	_print_transparent_text
   2FA5 F1            [10]  117 	pop	af
   2FA6 F1            [10]  118 	pop	af
   2FA7 33            [ 6]  119 	inc	sp
                            120 ;src/State_Credits.c:25: print_transparent_text("Alejandro Padilla",cpctm_screenPtr((u16)CPCT_VMEM_START,16,86),3);
   2FA8 3E 03         [ 7]  121 	ld	a,#0x03
   2FAA F5            [11]  122 	push	af
   2FAB 33            [ 6]  123 	inc	sp
   2FAC 21 30 F3      [10]  124 	ld	hl,#0xF330
   2FAF E5            [11]  125 	push	hl
   2FB0 21 05 30      [10]  126 	ld	hl,#___str_3
   2FB3 E5            [11]  127 	push	hl
   2FB4 CD 14 41      [17]  128 	call	_print_transparent_text
   2FB7 F1            [10]  129 	pop	af
   2FB8 F1            [10]  130 	pop	af
   2FB9 33            [ 6]  131 	inc	sp
                            132 ;src/State_Credits.c:27: print_transparent_text("MUSIC:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,102),3);
   2FBA 3E 03         [ 7]  133 	ld	a,#0x03
   2FBC F5            [11]  134 	push	af
   2FBD 33            [ 6]  135 	inc	sp
   2FBE 21 D0 F3      [10]  136 	ld	hl,#0xF3D0
   2FC1 E5            [11]  137 	push	hl
   2FC2 21 17 30      [10]  138 	ld	hl,#___str_4
   2FC5 E5            [11]  139 	push	hl
   2FC6 CD 14 41      [17]  140 	call	_print_transparent_text
   2FC9 F1            [10]  141 	pop	af
   2FCA F1            [10]  142 	pop	af
   2FCB 33            [ 6]  143 	inc	sp
                            144 ;src/State_Credits.c:28: print_transparent_text("Carlos Blaya",cpctm_screenPtr((u16)CPCT_VMEM_START,16,110),3);
   2FCC 3E 03         [ 7]  145 	ld	a,#0x03
   2FCE F5            [11]  146 	push	af
   2FCF 33            [ 6]  147 	inc	sp
   2FD0 21 20 F4      [10]  148 	ld	hl,#0xF420
   2FD3 E5            [11]  149 	push	hl
   2FD4 21 1E 30      [10]  150 	ld	hl,#___str_5
   2FD7 E5            [11]  151 	push	hl
   2FD8 CD 14 41      [17]  152 	call	_print_transparent_text
   2FDB F1            [10]  153 	pop	af
   2FDC F1            [10]  154 	pop	af
   2FDD 33            [ 6]  155 	inc	sp
   2FDE C9            [10]  156 	ret
   2FDF                     157 ___str_0:
   2FDF 43 4F 44 49 4E 47   158 	.ascii "CODING:"
        3A
   2FE6 00                  159 	.db 0x00
   2FE7                     160 ___str_1:
   2FE7 41 6C 62 65 72 74   161 	.ascii "Albert Sirvent @piterayo"
        20 53 69 72 76 65
        6E 74 20 40 70 69
        74 65 72 61 79 6F
   2FFF 00                  162 	.db 0x00
   3000                     163 ___str_2:
   3000 41 52 54 3A         164 	.ascii "ART:"
   3004 00                  165 	.db 0x00
   3005                     166 ___str_3:
   3005 41 6C 65 6A 61 6E   167 	.ascii "Alejandro Padilla"
        64 72 6F 20 50 61
        64 69 6C 6C 61
   3016 00                  168 	.db 0x00
   3017                     169 ___str_4:
   3017 4D 55 53 49 43 3A   170 	.ascii "MUSIC:"
   301D 00                  171 	.db 0x00
   301E                     172 ___str_5:
   301E 43 61 72 6C 6F 73   173 	.ascii "Carlos Blaya"
        20 42 6C 61 79 61
   302A 00                  174 	.db 0x00
                            175 ;src/State_Credits.c:32: void state_credits_return(){
                            176 ;	---------------------------------
                            177 ; Function state_credits_return
                            178 ; ---------------------------------
   302B                     179 _state_credits_return::
                            180 ;src/State_Credits.c:34: }
   302B C9            [10]  181 	ret
                            182 ;src/State_Credits.c:36: void state_credits_input(){
                            183 ;	---------------------------------
                            184 ; Function state_credits_input
                            185 ; ---------------------------------
   302C                     186 _state_credits_input::
                            187 ;src/State_Credits.c:37: if(cpct_isAnyKeyPressed_f ()){
   302C CD E0 84      [17]  188 	call	_cpct_isAnyKeyPressed_f
   302F 7D            [ 4]  189 	ld	a,l
   3030 B7            [ 4]  190 	or	a, a
   3031 C8            [11]  191 	ret	Z
                            192 ;src/State_Credits.c:38: statemanager_input_accepted();
   3032 C3 FB 39      [10]  193 	jp  _statemanager_input_accepted
                            194 ;src/State_Credits.c:42: void state_credits_update(){
                            195 ;	---------------------------------
                            196 ; Function state_credits_update
                            197 ; ---------------------------------
   3035                     198 _state_credits_update::
                            199 ;src/State_Credits.c:43: statemanager_close_state();
   3035 C3 A4 3A      [10]  200 	jp  _statemanager_close_state
                            201 ;src/State_Credits.c:46: void state_credits_render(){
                            202 ;	---------------------------------
                            203 ; Function state_credits_render
                            204 ; ---------------------------------
   3038                     205 _state_credits_render::
                            206 ;src/State_Credits.c:48: }
   3038 C9            [10]  207 	ret
                            208 ;src/State_Credits.c:50: void state_credits_exit(){
                            209 ;	---------------------------------
                            210 ; Function state_credits_exit
                            211 ; ---------------------------------
   3039                     212 _state_credits_exit::
                            213 ;src/State_Credits.c:51: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[1],52,92);
   3039 21 29 1C      [10]  214 	ld	hl, #(_g_colors + 0x0001) + 0
   303C 46            [ 7]  215 	ld	b,(hl)
   303D 21 34 5C      [10]  216 	ld	hl,#0x5C34
   3040 E5            [11]  217 	push	hl
   3041 C5            [11]  218 	push	bc
   3042 33            [ 6]  219 	inc	sp
   3043 21 9E F1      [10]  220 	ld	hl,#0xF19E
   3046 E5            [11]  221 	push	hl
   3047 CD 2F 85      [17]  222 	call	_cpct_drawSolidBox
   304A F1            [10]  223 	pop	af
   304B F1            [10]  224 	pop	af
   304C 33            [ 6]  225 	inc	sp
   304D C9            [10]  226 	ret
                            227 	.area _CODE
                            228 	.area _INITIALIZER
                            229 	.area _CABS (ABS)
