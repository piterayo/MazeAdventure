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
   2DD1                      57 _state_credits_enter::
                             58 ;src/State_Credits.c:18: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[4],52,108);
   2DD1 21 B3 1A      [10]   59 	ld	hl, #_g_colors + 4
   2DD4 46            [ 7]   60 	ld	b,(hl)
   2DD5 21 34 6C      [10]   61 	ld	hl,#0x6C34
   2DD8 E5            [11]   62 	push	hl
   2DD9 C5            [11]   63 	push	bc
   2DDA 33            [ 6]   64 	inc	sp
   2DDB 21 9E F1      [10]   65 	ld	hl,#0xF19E
   2DDE E5            [11]   66 	push	hl
   2DDF CD B8 7B      [17]   67 	call	_cpct_drawSolidBox
   2DE2 F1            [10]   68 	pop	af
   2DE3 F1            [10]   69 	pop	af
   2DE4 33            [ 6]   70 	inc	sp
                             71 ;src/State_Credits.c:19: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,15,50),g_colors[1],50,100);
   2DE5 21 B0 1A      [10]   72 	ld	hl, #_g_colors + 1
   2DE8 46            [ 7]   73 	ld	b,(hl)
   2DE9 21 32 64      [10]   74 	ld	hl,#0x6432
   2DEC E5            [11]   75 	push	hl
   2DED C5            [11]   76 	push	bc
   2DEE 33            [ 6]   77 	inc	sp
   2DEF 21 EF D1      [10]   78 	ld	hl,#0xD1EF
   2DF2 E5            [11]   79 	push	hl
   2DF3 CD B8 7B      [17]   80 	call	_cpct_drawSolidBox
   2DF6 F1            [10]   81 	pop	af
   2DF7 F1            [10]   82 	pop	af
   2DF8 33            [ 6]   83 	inc	sp
                             84 ;src/State_Credits.c:21: print_transparent_text("CODING:", cpctm_screenPtr((u16)CPCT_VMEM_START,16,54),3);
   2DF9 3E 03         [ 7]   85 	ld	a,#0x03
   2DFB F5            [11]   86 	push	af
   2DFC 33            [ 6]   87 	inc	sp
   2DFD 21 F0 F1      [10]   88 	ld	hl,#0xF1F0
   2E00 E5            [11]   89 	push	hl
   2E01 21 8A 2E      [10]   90 	ld	hl,#___str_0
   2E04 E5            [11]   91 	push	hl
   2E05 CD C6 3F      [17]   92 	call	_print_transparent_text
   2E08 F1            [10]   93 	pop	af
   2E09 F1            [10]   94 	pop	af
   2E0A 33            [ 6]   95 	inc	sp
                             96 ;src/State_Credits.c:22: print_transparent_text("Albert Sirvent @piterayo",cpctm_screenPtr((u16)CPCT_VMEM_START,16,62),3);
   2E0B 3E 03         [ 7]   97 	ld	a,#0x03
   2E0D F5            [11]   98 	push	af
   2E0E 33            [ 6]   99 	inc	sp
   2E0F 21 40 F2      [10]  100 	ld	hl,#0xF240
   2E12 E5            [11]  101 	push	hl
   2E13 21 92 2E      [10]  102 	ld	hl,#___str_1
   2E16 E5            [11]  103 	push	hl
   2E17 CD C6 3F      [17]  104 	call	_print_transparent_text
   2E1A F1            [10]  105 	pop	af
   2E1B F1            [10]  106 	pop	af
   2E1C 33            [ 6]  107 	inc	sp
                            108 ;src/State_Credits.c:24: print_transparent_text("ART:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,78),3);
   2E1D 3E 03         [ 7]  109 	ld	a,#0x03
   2E1F F5            [11]  110 	push	af
   2E20 33            [ 6]  111 	inc	sp
   2E21 21 E0 F2      [10]  112 	ld	hl,#0xF2E0
   2E24 E5            [11]  113 	push	hl
   2E25 21 AB 2E      [10]  114 	ld	hl,#___str_2
   2E28 E5            [11]  115 	push	hl
   2E29 CD C6 3F      [17]  116 	call	_print_transparent_text
   2E2C F1            [10]  117 	pop	af
   2E2D F1            [10]  118 	pop	af
   2E2E 33            [ 6]  119 	inc	sp
                            120 ;src/State_Credits.c:25: print_transparent_text("Alejandro Padilla",cpctm_screenPtr((u16)CPCT_VMEM_START,16,86),3);
   2E2F 3E 03         [ 7]  121 	ld	a,#0x03
   2E31 F5            [11]  122 	push	af
   2E32 33            [ 6]  123 	inc	sp
   2E33 21 30 F3      [10]  124 	ld	hl,#0xF330
   2E36 E5            [11]  125 	push	hl
   2E37 21 B0 2E      [10]  126 	ld	hl,#___str_3
   2E3A E5            [11]  127 	push	hl
   2E3B CD C6 3F      [17]  128 	call	_print_transparent_text
   2E3E F1            [10]  129 	pop	af
   2E3F F1            [10]  130 	pop	af
   2E40 33            [ 6]  131 	inc	sp
                            132 ;src/State_Credits.c:27: print_transparent_text("MUSIC:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,102),3);
   2E41 3E 03         [ 7]  133 	ld	a,#0x03
   2E43 F5            [11]  134 	push	af
   2E44 33            [ 6]  135 	inc	sp
   2E45 21 D0 F3      [10]  136 	ld	hl,#0xF3D0
   2E48 E5            [11]  137 	push	hl
   2E49 21 C2 2E      [10]  138 	ld	hl,#___str_4
   2E4C E5            [11]  139 	push	hl
   2E4D CD C6 3F      [17]  140 	call	_print_transparent_text
   2E50 F1            [10]  141 	pop	af
   2E51 F1            [10]  142 	pop	af
   2E52 33            [ 6]  143 	inc	sp
                            144 ;src/State_Credits.c:28: print_transparent_text("Carlos Blaya",cpctm_screenPtr((u16)CPCT_VMEM_START,16,110),3);
   2E53 3E 03         [ 7]  145 	ld	a,#0x03
   2E55 F5            [11]  146 	push	af
   2E56 33            [ 6]  147 	inc	sp
   2E57 21 20 F4      [10]  148 	ld	hl,#0xF420
   2E5A E5            [11]  149 	push	hl
   2E5B 21 C9 2E      [10]  150 	ld	hl,#___str_5
   2E5E E5            [11]  151 	push	hl
   2E5F CD C6 3F      [17]  152 	call	_print_transparent_text
   2E62 F1            [10]  153 	pop	af
   2E63 F1            [10]  154 	pop	af
   2E64 33            [ 6]  155 	inc	sp
                            156 ;src/State_Credits.c:30: print_transparent_text("SFX:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,126),3);
   2E65 3E 03         [ 7]  157 	ld	a,#0x03
   2E67 F5            [11]  158 	push	af
   2E68 33            [ 6]  159 	inc	sp
   2E69 21 C0 F4      [10]  160 	ld	hl,#0xF4C0
   2E6C E5            [11]  161 	push	hl
   2E6D 21 D6 2E      [10]  162 	ld	hl,#___str_6
   2E70 E5            [11]  163 	push	hl
   2E71 CD C6 3F      [17]  164 	call	_print_transparent_text
   2E74 F1            [10]  165 	pop	af
   2E75 F1            [10]  166 	pop	af
   2E76 33            [ 6]  167 	inc	sp
                            168 ;src/State_Credits.c:31: print_transparent_text("Alberto Salieto @Venisir",cpctm_screenPtr((u16)CPCT_VMEM_START,16,134),3);
   2E77 3E 03         [ 7]  169 	ld	a,#0x03
   2E79 F5            [11]  170 	push	af
   2E7A 33            [ 6]  171 	inc	sp
   2E7B 21 10 F5      [10]  172 	ld	hl,#0xF510
   2E7E E5            [11]  173 	push	hl
   2E7F 21 DB 2E      [10]  174 	ld	hl,#___str_7
   2E82 E5            [11]  175 	push	hl
   2E83 CD C6 3F      [17]  176 	call	_print_transparent_text
   2E86 F1            [10]  177 	pop	af
   2E87 F1            [10]  178 	pop	af
   2E88 33            [ 6]  179 	inc	sp
   2E89 C9            [10]  180 	ret
   2E8A                     181 ___str_0:
   2E8A 43 4F 44 49 4E 47   182 	.ascii "CODING:"
        3A
   2E91 00                  183 	.db 0x00
   2E92                     184 ___str_1:
   2E92 41 6C 62 65 72 74   185 	.ascii "Albert Sirvent @piterayo"
        20 53 69 72 76 65
        6E 74 20 40 70 69
        74 65 72 61 79 6F
   2EAA 00                  186 	.db 0x00
   2EAB                     187 ___str_2:
   2EAB 41 52 54 3A         188 	.ascii "ART:"
   2EAF 00                  189 	.db 0x00
   2EB0                     190 ___str_3:
   2EB0 41 6C 65 6A 61 6E   191 	.ascii "Alejandro Padilla"
        64 72 6F 20 50 61
        64 69 6C 6C 61
   2EC1 00                  192 	.db 0x00
   2EC2                     193 ___str_4:
   2EC2 4D 55 53 49 43 3A   194 	.ascii "MUSIC:"
   2EC8 00                  195 	.db 0x00
   2EC9                     196 ___str_5:
   2EC9 43 61 72 6C 6F 73   197 	.ascii "Carlos Blaya"
        20 42 6C 61 79 61
   2ED5 00                  198 	.db 0x00
   2ED6                     199 ___str_6:
   2ED6 53 46 58 3A         200 	.ascii "SFX:"
   2EDA 00                  201 	.db 0x00
   2EDB                     202 ___str_7:
   2EDB 41 6C 62 65 72 74   203 	.ascii "Alberto Salieto @Venisir"
        6F 20 53 61 6C 69
        65 74 6F 20 40 56
        65 6E 69 73 69 72
   2EF3 00                  204 	.db 0x00
                            205 ;src/State_Credits.c:35: void state_credits_return(){
                            206 ;	---------------------------------
                            207 ; Function state_credits_return
                            208 ; ---------------------------------
   2EF4                     209 _state_credits_return::
                            210 ;src/State_Credits.c:37: }
   2EF4 C9            [10]  211 	ret
                            212 ;src/State_Credits.c:39: void state_credits_input(){
                            213 ;	---------------------------------
                            214 ; Function state_credits_input
                            215 ; ---------------------------------
   2EF5                     216 _state_credits_input::
                            217 ;src/State_Credits.c:40: if(cpct_isAnyKeyPressed_f ()){
   2EF5 CD 69 7B      [17]  218 	call	_cpct_isAnyKeyPressed_f
   2EF8 7D            [ 4]  219 	ld	a,l
   2EF9 B7            [ 4]  220 	or	a, a
   2EFA C8            [11]  221 	ret	Z
                            222 ;src/State_Credits.c:41: statemanager_input_accepted();
   2EFB C3 B6 38      [10]  223 	jp  _statemanager_input_accepted
                            224 ;src/State_Credits.c:45: void state_credits_update(){
                            225 ;	---------------------------------
                            226 ; Function state_credits_update
                            227 ; ---------------------------------
   2EFE                     228 _state_credits_update::
                            229 ;src/State_Credits.c:46: statemanager_close_state();
   2EFE C3 5F 39      [10]  230 	jp  _statemanager_close_state
                            231 ;src/State_Credits.c:49: void state_credits_render(){
                            232 ;	---------------------------------
                            233 ; Function state_credits_render
                            234 ; ---------------------------------
   2F01                     235 _state_credits_render::
                            236 ;src/State_Credits.c:51: }
   2F01 C9            [10]  237 	ret
                            238 ;src/State_Credits.c:53: void state_credits_exit(){
                            239 ;	---------------------------------
                            240 ; Function state_credits_exit
                            241 ; ---------------------------------
   2F02                     242 _state_credits_exit::
                            243 ;src/State_Credits.c:54: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[1],52,108);
   2F02 21 B0 1A      [10]  244 	ld	hl, #(_g_colors + 0x0001) + 0
   2F05 46            [ 7]  245 	ld	b,(hl)
   2F06 21 34 6C      [10]  246 	ld	hl,#0x6C34
   2F09 E5            [11]  247 	push	hl
   2F0A C5            [11]  248 	push	bc
   2F0B 33            [ 6]  249 	inc	sp
   2F0C 21 9E F1      [10]  250 	ld	hl,#0xF19E
   2F0F E5            [11]  251 	push	hl
   2F10 CD B8 7B      [17]  252 	call	_cpct_drawSolidBox
   2F13 F1            [10]  253 	pop	af
   2F14 F1            [10]  254 	pop	af
   2F15 33            [ 6]  255 	inc	sp
   2F16 C9            [10]  256 	ret
                            257 	.area _CODE
                            258 	.area _INITIALIZER
                            259 	.area _CABS (ABS)
