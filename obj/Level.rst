                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Level
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _setLevelPalette
                             12 	.globl _uncompress_enemy_textures
                             13 	.globl _uncompress_theme_textures
                             14 	.globl _cpct_setPalette
                             15 	.globl _cpct_fw2hw
                             16 	.globl _cpct_memcpy
                             17 	.globl _level_palettes
                             18 	.globl _level_init_palettes
                             19 	.globl _level_load_level
                             20 ;--------------------------------------------------------
                             21 ; special function registers
                             22 ;--------------------------------------------------------
                             23 ;--------------------------------------------------------
                             24 ; ram data
                             25 ;--------------------------------------------------------
                             26 	.area _DATA
                             27 ;--------------------------------------------------------
                             28 ; ram data
                             29 ;--------------------------------------------------------
                             30 	.area _INITIALIZED
                             31 ;--------------------------------------------------------
                             32 ; absolute external ram data
                             33 ;--------------------------------------------------------
                             34 	.area _DABS (ABS)
                             35 ;--------------------------------------------------------
                             36 ; global & static initialisations
                             37 ;--------------------------------------------------------
                             38 	.area _HOME
                             39 	.area _GSINIT
                             40 	.area _GSFINAL
                             41 	.area _GSINIT
                             42 ;--------------------------------------------------------
                             43 ; Home
                             44 ;--------------------------------------------------------
                             45 	.area _HOME
                             46 	.area _HOME
                             47 ;--------------------------------------------------------
                             48 ; code
                             49 ;--------------------------------------------------------
                             50 	.area _CODE
                             51 ;src/Level.c:14: void level_init_palettes(){
                             52 ;	---------------------------------
                             53 ; Function level_init_palettes
                             54 ; ---------------------------------
   4045                      55 _level_init_palettes::
                             56 ;src/Level.c:15: cpct_fw2hw(level_palettes[0],9);
   4045 21 09 00      [10]   57 	ld	hl,#0x0009
   4048 E5            [11]   58 	push	hl
   4049 21 72 40      [10]   59 	ld	hl,#_level_palettes
   404C E5            [11]   60 	push	hl
   404D CD 0D 75      [17]   61 	call	_cpct_fw2hw
                             62 ;src/Level.c:16: cpct_fw2hw(level_palettes[1],9);
   4050 21 09 00      [10]   63 	ld	hl,#0x0009
   4053 E5            [11]   64 	push	hl
   4054 21 7B 40      [10]   65 	ld	hl,#(_level_palettes + 0x0009)
   4057 E5            [11]   66 	push	hl
   4058 CD 0D 75      [17]   67 	call	_cpct_fw2hw
                             68 ;src/Level.c:17: cpct_fw2hw(level_palettes[2],9);
   405B 21 09 00      [10]   69 	ld	hl,#0x0009
   405E E5            [11]   70 	push	hl
   405F 21 84 40      [10]   71 	ld	hl,#(_level_palettes + 0x0012)
   4062 E5            [11]   72 	push	hl
   4063 CD 0D 75      [17]   73 	call	_cpct_fw2hw
                             74 ;src/Level.c:18: cpct_fw2hw(level_palettes[3],9);
   4066 21 09 00      [10]   75 	ld	hl,#0x0009
   4069 E5            [11]   76 	push	hl
   406A 21 8D 40      [10]   77 	ld	hl,#(_level_palettes + 0x001b)
   406D E5            [11]   78 	push	hl
   406E CD 0D 75      [17]   79 	call	_cpct_fw2hw
   4071 C9            [10]   80 	ret
   4072                      81 _level_palettes:
   4072 05                   82 	.db #0x05	; 5
   4073 0A                   83 	.db #0x0A	; 10
   4074 11                   84 	.db #0x11	; 17
   4075 0E                   85 	.db #0x0E	; 14
   4076 0C                   86 	.db #0x0C	; 12
   4077 09                   87 	.db #0x09	; 9
   4078 0F                   88 	.db #0x0F	; 15
   4079 01                   89 	.db #0x01	; 1
   407A 02                   90 	.db #0x02	; 2
   407B 14                   91 	.db #0x14	; 20
   407C 13                   92 	.db #0x13	; 19
   407D 11                   93 	.db #0x11	; 17
   407E 0E                   94 	.db #0x0E	; 14
   407F 12                   95 	.db #0x12	; 18
   4080 09                   96 	.db #0x09	; 9
   4081 0F                   97 	.db #0x0F	; 15
   4082 03                   98 	.db #0x03	; 3
   4083 0A                   99 	.db #0x0A	; 10
   4084 00                  100 	.db #0x00	; 0
   4085 00                  101 	.db #0x00	; 0
   4086 00                  102 	.db #0x00	; 0
   4087 00                  103 	.db #0x00	; 0
   4088 00                  104 	.db #0x00	; 0
   4089 00                  105 	.db #0x00	; 0
   408A 00                  106 	.db #0x00	; 0
   408B 00                  107 	.db #0x00	; 0
   408C 00                  108 	.db #0x00	; 0
   408D 00                  109 	.db #0x00	; 0
   408E 00                  110 	.db #0x00	; 0
   408F 00                  111 	.db #0x00	; 0
   4090 00                  112 	.db #0x00	; 0
   4091 00                  113 	.db #0x00	; 0
   4092 00                  114 	.db #0x00	; 0
   4093 00                  115 	.db #0x00	; 0
   4094 00                  116 	.db #0x00	; 0
   4095 00                  117 	.db #0x00	; 0
                            118 ;src/Level.c:21: void setLevelPalette(u8 i){
                            119 ;	---------------------------------
                            120 ; Function setLevelPalette
                            121 ; ---------------------------------
   4096                     122 _setLevelPalette::
   4096 DD E5         [15]  123 	push	ix
   4098 DD 21 00 00   [14]  124 	ld	ix,#0
   409C DD 39         [15]  125 	add	ix,sp
                            126 ;src/Level.c:22: cpct_memcpy(g_palette+7, level_palettes[i],9);
   409E 01 72 40      [10]  127 	ld	bc,#_level_palettes+0
   40A1 DD 5E 04      [19]  128 	ld	e,4 (ix)
   40A4 16 00         [ 7]  129 	ld	d,#0x00
   40A6 6B            [ 4]  130 	ld	l, e
   40A7 62            [ 4]  131 	ld	h, d
   40A8 29            [11]  132 	add	hl, hl
   40A9 29            [11]  133 	add	hl, hl
   40AA 29            [11]  134 	add	hl, hl
   40AB 19            [11]  135 	add	hl, de
   40AC 09            [11]  136 	add	hl,bc
   40AD 4D            [ 4]  137 	ld	c,l
   40AE 44            [ 4]  138 	ld	b,h
   40AF 21 09 00      [10]  139 	ld	hl,#0x0009
   40B2 E5            [11]  140 	push	hl
   40B3 C5            [11]  141 	push	bc
   40B4 21 7D 4B      [10]  142 	ld	hl,#(_g_palette + 0x0007)
   40B7 E5            [11]  143 	push	hl
   40B8 CD CF 75      [17]  144 	call	_cpct_memcpy
                            145 ;src/Level.c:23: cpct_setPalette(g_palette,16);
   40BB 21 10 00      [10]  146 	ld	hl,#0x0010
   40BE E5            [11]  147 	push	hl
   40BF 21 76 4B      [10]  148 	ld	hl,#_g_palette
   40C2 E5            [11]  149 	push	hl
   40C3 CD 29 74      [17]  150 	call	_cpct_setPalette
   40C6 DD E1         [14]  151 	pop	ix
   40C8 C9            [10]  152 	ret
                            153 ;src/Level.c:26: void level_load_level(u8 l){
                            154 ;	---------------------------------
                            155 ; Function level_load_level
                            156 ; ---------------------------------
   40C9                     157 _level_load_level::
                            158 ;src/Level.c:29: index =((l<8)?0:(
   40C9 21 02 00      [10]  159 	ld	hl, #2+0
   40CC 39            [11]  160 	add	hl, sp
   40CD 7E            [ 7]  161 	ld	a, (hl)
   40CE D6 08         [ 7]  162 	sub	a, #0x08
   40D0 30 04         [12]  163 	jr	NC,00103$
   40D2 06 00         [ 7]  164 	ld	b,#0x00
   40D4 18 29         [12]  165 	jr	00104$
   40D6                     166 00103$:
                            167 ;src/Level.c:30: (l<24)?1:(
   40D6 21 02 00      [10]  168 	ld	hl, #2+0
   40D9 39            [11]  169 	add	hl, sp
   40DA 7E            [ 7]  170 	ld	a, (hl)
   40DB D6 18         [ 7]  171 	sub	a, #0x18
   40DD 30 04         [12]  172 	jr	NC,00105$
   40DF 06 01         [ 7]  173 	ld	b,#0x01
   40E1 18 1C         [12]  174 	jr	00106$
   40E3                     175 00105$:
                            176 ;src/Level.c:31: (l<56)?2:(
   40E3 21 02 00      [10]  177 	ld	hl, #2+0
   40E6 39            [11]  178 	add	hl, sp
   40E7 7E            [ 7]  179 	ld	a, (hl)
   40E8 D6 38         [ 7]  180 	sub	a, #0x38
   40EA 30 04         [12]  181 	jr	NC,00107$
   40EC 06 02         [ 7]  182 	ld	b,#0x02
   40EE 18 0F         [12]  183 	jr	00108$
   40F0                     184 00107$:
                            185 ;src/Level.c:32: (l<120)?4:0
   40F0 21 02 00      [10]  186 	ld	hl, #2+0
   40F3 39            [11]  187 	add	hl, sp
   40F4 7E            [ 7]  188 	ld	a, (hl)
   40F5 D6 78         [ 7]  189 	sub	a, #0x78
   40F7 30 04         [12]  190 	jr	NC,00109$
   40F9 06 04         [ 7]  191 	ld	b,#0x04
   40FB 18 02         [12]  192 	jr	00110$
   40FD                     193 00109$:
   40FD 06 00         [ 7]  194 	ld	b,#0x00
   40FF                     195 00110$:
   40FF                     196 00108$:
   40FF                     197 00106$:
   40FF                     198 00104$:
                            199 ;src/Level.c:35: uncompress_theme_textures(index);
   40FF C5            [11]  200 	push	bc
   4100 C5            [11]  201 	push	bc
   4101 33            [ 6]  202 	inc	sp
   4102 CD DD 5B      [17]  203 	call	_uncompress_theme_textures
   4105 33            [ 6]  204 	inc	sp
   4106 C1            [10]  205 	pop	bc
                            206 ;src/Level.c:36: uncompress_enemy_textures(index);
   4107 C5            [11]  207 	push	bc
   4108 C5            [11]  208 	push	bc
   4109 33            [ 6]  209 	inc	sp
   410A CD 67 5C      [17]  210 	call	_uncompress_enemy_textures
   410D 33            [ 6]  211 	inc	sp
   410E 33            [ 6]  212 	inc	sp
   410F CD 96 40      [17]  213 	call	_setLevelPalette
   4112 33            [ 6]  214 	inc	sp
   4113 C9            [10]  215 	ret
                            216 	.area _CODE
                            217 	.area _INITIALIZER
                            218 	.area _CABS (ABS)
