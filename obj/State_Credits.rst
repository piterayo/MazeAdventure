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
   2D88                      57 _state_credits_enter::
                             58 ;src/State_Credits.c:18: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[4],52,108);
   2D88 21 6A 1A      [10]   59 	ld	hl, #_g_colors + 4
   2D8B 46            [ 7]   60 	ld	b,(hl)
   2D8C 21 34 6C      [10]   61 	ld	hl,#0x6C34
   2D8F E5            [11]   62 	push	hl
   2D90 C5            [11]   63 	push	bc
   2D91 33            [ 6]   64 	inc	sp
   2D92 21 9E F1      [10]   65 	ld	hl,#0xF19E
   2D95 E5            [11]   66 	push	hl
   2D96 CD 70 7C      [17]   67 	call	_cpct_drawSolidBox
   2D99 F1            [10]   68 	pop	af
   2D9A F1            [10]   69 	pop	af
   2D9B 33            [ 6]   70 	inc	sp
                             71 ;src/State_Credits.c:19: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,15,50),g_colors[1],50,100);
   2D9C 21 67 1A      [10]   72 	ld	hl, #_g_colors + 1
   2D9F 46            [ 7]   73 	ld	b,(hl)
   2DA0 21 32 64      [10]   74 	ld	hl,#0x6432
   2DA3 E5            [11]   75 	push	hl
   2DA4 C5            [11]   76 	push	bc
   2DA5 33            [ 6]   77 	inc	sp
   2DA6 21 EF D1      [10]   78 	ld	hl,#0xD1EF
   2DA9 E5            [11]   79 	push	hl
   2DAA CD 70 7C      [17]   80 	call	_cpct_drawSolidBox
   2DAD F1            [10]   81 	pop	af
   2DAE F1            [10]   82 	pop	af
   2DAF 33            [ 6]   83 	inc	sp
                             84 ;src/State_Credits.c:21: print_transparent_text("CODING:", cpctm_screenPtr((u16)CPCT_VMEM_START,16,54),3);
   2DB0 3E 03         [ 7]   85 	ld	a,#0x03
   2DB2 F5            [11]   86 	push	af
   2DB3 33            [ 6]   87 	inc	sp
   2DB4 21 F0 F1      [10]   88 	ld	hl,#0xF1F0
   2DB7 E5            [11]   89 	push	hl
   2DB8 21 41 2E      [10]   90 	ld	hl,#___str_0
   2DBB E5            [11]   91 	push	hl
   2DBC CD A0 3F      [17]   92 	call	_print_transparent_text
   2DBF F1            [10]   93 	pop	af
   2DC0 F1            [10]   94 	pop	af
   2DC1 33            [ 6]   95 	inc	sp
                             96 ;src/State_Credits.c:22: print_transparent_text("Albert Sirvent @piterayo",cpctm_screenPtr((u16)CPCT_VMEM_START,16,62),3);
   2DC2 3E 03         [ 7]   97 	ld	a,#0x03
   2DC4 F5            [11]   98 	push	af
   2DC5 33            [ 6]   99 	inc	sp
   2DC6 21 40 F2      [10]  100 	ld	hl,#0xF240
   2DC9 E5            [11]  101 	push	hl
   2DCA 21 49 2E      [10]  102 	ld	hl,#___str_1
   2DCD E5            [11]  103 	push	hl
   2DCE CD A0 3F      [17]  104 	call	_print_transparent_text
   2DD1 F1            [10]  105 	pop	af
   2DD2 F1            [10]  106 	pop	af
   2DD3 33            [ 6]  107 	inc	sp
                            108 ;src/State_Credits.c:24: print_transparent_text("ART:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,78),3);
   2DD4 3E 03         [ 7]  109 	ld	a,#0x03
   2DD6 F5            [11]  110 	push	af
   2DD7 33            [ 6]  111 	inc	sp
   2DD8 21 E0 F2      [10]  112 	ld	hl,#0xF2E0
   2DDB E5            [11]  113 	push	hl
   2DDC 21 62 2E      [10]  114 	ld	hl,#___str_2
   2DDF E5            [11]  115 	push	hl
   2DE0 CD A0 3F      [17]  116 	call	_print_transparent_text
   2DE3 F1            [10]  117 	pop	af
   2DE4 F1            [10]  118 	pop	af
   2DE5 33            [ 6]  119 	inc	sp
                            120 ;src/State_Credits.c:25: print_transparent_text("Alejandro Padilla",cpctm_screenPtr((u16)CPCT_VMEM_START,16,86),3);
   2DE6 3E 03         [ 7]  121 	ld	a,#0x03
   2DE8 F5            [11]  122 	push	af
   2DE9 33            [ 6]  123 	inc	sp
   2DEA 21 30 F3      [10]  124 	ld	hl,#0xF330
   2DED E5            [11]  125 	push	hl
   2DEE 21 67 2E      [10]  126 	ld	hl,#___str_3
   2DF1 E5            [11]  127 	push	hl
   2DF2 CD A0 3F      [17]  128 	call	_print_transparent_text
   2DF5 F1            [10]  129 	pop	af
   2DF6 F1            [10]  130 	pop	af
   2DF7 33            [ 6]  131 	inc	sp
                            132 ;src/State_Credits.c:27: print_transparent_text("MUSIC:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,102),3);
   2DF8 3E 03         [ 7]  133 	ld	a,#0x03
   2DFA F5            [11]  134 	push	af
   2DFB 33            [ 6]  135 	inc	sp
   2DFC 21 D0 F3      [10]  136 	ld	hl,#0xF3D0
   2DFF E5            [11]  137 	push	hl
   2E00 21 79 2E      [10]  138 	ld	hl,#___str_4
   2E03 E5            [11]  139 	push	hl
   2E04 CD A0 3F      [17]  140 	call	_print_transparent_text
   2E07 F1            [10]  141 	pop	af
   2E08 F1            [10]  142 	pop	af
   2E09 33            [ 6]  143 	inc	sp
                            144 ;src/State_Credits.c:28: print_transparent_text("Carlos Blaya",cpctm_screenPtr((u16)CPCT_VMEM_START,16,110),3);
   2E0A 3E 03         [ 7]  145 	ld	a,#0x03
   2E0C F5            [11]  146 	push	af
   2E0D 33            [ 6]  147 	inc	sp
   2E0E 21 20 F4      [10]  148 	ld	hl,#0xF420
   2E11 E5            [11]  149 	push	hl
   2E12 21 80 2E      [10]  150 	ld	hl,#___str_5
   2E15 E5            [11]  151 	push	hl
   2E16 CD A0 3F      [17]  152 	call	_print_transparent_text
   2E19 F1            [10]  153 	pop	af
   2E1A F1            [10]  154 	pop	af
   2E1B 33            [ 6]  155 	inc	sp
                            156 ;src/State_Credits.c:30: print_transparent_text("SFX:",cpctm_screenPtr((u16)CPCT_VMEM_START,16,126),3);
   2E1C 3E 03         [ 7]  157 	ld	a,#0x03
   2E1E F5            [11]  158 	push	af
   2E1F 33            [ 6]  159 	inc	sp
   2E20 21 C0 F4      [10]  160 	ld	hl,#0xF4C0
   2E23 E5            [11]  161 	push	hl
   2E24 21 8D 2E      [10]  162 	ld	hl,#___str_6
   2E27 E5            [11]  163 	push	hl
   2E28 CD A0 3F      [17]  164 	call	_print_transparent_text
   2E2B F1            [10]  165 	pop	af
   2E2C F1            [10]  166 	pop	af
   2E2D 33            [ 6]  167 	inc	sp
                            168 ;src/State_Credits.c:31: print_transparent_text("Alberto Salieto @Venisir",cpctm_screenPtr((u16)CPCT_VMEM_START,16,134),3);
   2E2E 3E 03         [ 7]  169 	ld	a,#0x03
   2E30 F5            [11]  170 	push	af
   2E31 33            [ 6]  171 	inc	sp
   2E32 21 10 F5      [10]  172 	ld	hl,#0xF510
   2E35 E5            [11]  173 	push	hl
   2E36 21 92 2E      [10]  174 	ld	hl,#___str_7
   2E39 E5            [11]  175 	push	hl
   2E3A CD A0 3F      [17]  176 	call	_print_transparent_text
   2E3D F1            [10]  177 	pop	af
   2E3E F1            [10]  178 	pop	af
   2E3F 33            [ 6]  179 	inc	sp
   2E40 C9            [10]  180 	ret
   2E41                     181 ___str_0:
   2E41 43 4F 44 49 4E 47   182 	.ascii "CODING:"
        3A
   2E48 00                  183 	.db 0x00
   2E49                     184 ___str_1:
   2E49 41 6C 62 65 72 74   185 	.ascii "Albert Sirvent @piterayo"
        20 53 69 72 76 65
        6E 74 20 40 70 69
        74 65 72 61 79 6F
   2E61 00                  186 	.db 0x00
   2E62                     187 ___str_2:
   2E62 41 52 54 3A         188 	.ascii "ART:"
   2E66 00                  189 	.db 0x00
   2E67                     190 ___str_3:
   2E67 41 6C 65 6A 61 6E   191 	.ascii "Alejandro Padilla"
        64 72 6F 20 50 61
        64 69 6C 6C 61
   2E78 00                  192 	.db 0x00
   2E79                     193 ___str_4:
   2E79 4D 55 53 49 43 3A   194 	.ascii "MUSIC:"
   2E7F 00                  195 	.db 0x00
   2E80                     196 ___str_5:
   2E80 43 61 72 6C 6F 73   197 	.ascii "Carlos Blaya"
        20 42 6C 61 79 61
   2E8C 00                  198 	.db 0x00
   2E8D                     199 ___str_6:
   2E8D 53 46 58 3A         200 	.ascii "SFX:"
   2E91 00                  201 	.db 0x00
   2E92                     202 ___str_7:
   2E92 41 6C 62 65 72 74   203 	.ascii "Alberto Salieto @Venisir"
        6F 20 53 61 6C 69
        65 74 6F 20 40 56
        65 6E 69 73 69 72
   2EAA 00                  204 	.db 0x00
                            205 ;src/State_Credits.c:35: void state_credits_return(){
                            206 ;	---------------------------------
                            207 ; Function state_credits_return
                            208 ; ---------------------------------
   2EAB                     209 _state_credits_return::
                            210 ;src/State_Credits.c:37: }
   2EAB C9            [10]  211 	ret
                            212 ;src/State_Credits.c:39: void state_credits_input(){
                            213 ;	---------------------------------
                            214 ; Function state_credits_input
                            215 ; ---------------------------------
   2EAC                     216 _state_credits_input::
                            217 ;src/State_Credits.c:40: if(cpct_isAnyKeyPressed_f ()){
   2EAC CD 21 7C      [17]  218 	call	_cpct_isAnyKeyPressed_f
   2EAF 7D            [ 4]  219 	ld	a,l
   2EB0 B7            [ 4]  220 	or	a, a
   2EB1 C8            [11]  221 	ret	Z
                            222 ;src/State_Credits.c:41: statemanager_input_accepted();
   2EB2 C3 90 38      [10]  223 	jp  _statemanager_input_accepted
                            224 ;src/State_Credits.c:45: void state_credits_update(){
                            225 ;	---------------------------------
                            226 ; Function state_credits_update
                            227 ; ---------------------------------
   2EB5                     228 _state_credits_update::
                            229 ;src/State_Credits.c:46: statemanager_close_state();
   2EB5 C3 39 39      [10]  230 	jp  _statemanager_close_state
                            231 ;src/State_Credits.c:49: void state_credits_render(){
                            232 ;	---------------------------------
                            233 ; Function state_credits_render
                            234 ; ---------------------------------
   2EB8                     235 _state_credits_render::
                            236 ;src/State_Credits.c:51: }
   2EB8 C9            [10]  237 	ret
                            238 ;src/State_Credits.c:53: void state_credits_exit(){
                            239 ;	---------------------------------
                            240 ; Function state_credits_exit
                            241 ; ---------------------------------
   2EB9                     242 _state_credits_exit::
                            243 ;src/State_Credits.c:54: cpct_drawSolidBox(cpctm_screenPtr((u16)CPCT_VMEM_START,14,46),g_colors[1],52,108);
   2EB9 21 67 1A      [10]  244 	ld	hl, #(_g_colors + 0x0001) + 0
   2EBC 46            [ 7]  245 	ld	b,(hl)
   2EBD 21 34 6C      [10]  246 	ld	hl,#0x6C34
   2EC0 E5            [11]  247 	push	hl
   2EC1 C5            [11]  248 	push	bc
   2EC2 33            [ 6]  249 	inc	sp
   2EC3 21 9E F1      [10]  250 	ld	hl,#0xF19E
   2EC6 E5            [11]  251 	push	hl
   2EC7 CD 70 7C      [17]  252 	call	_cpct_drawSolidBox
   2ECA F1            [10]  253 	pop	af
   2ECB F1            [10]  254 	pop	af
   2ECC 33            [ 6]  255 	inc	sp
   2ECD C9            [10]  256 	ret
                            257 	.area _CODE
                            258 	.area _INITIALIZER
                            259 	.area _CABS (ABS)
