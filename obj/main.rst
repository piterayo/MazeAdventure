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
                             12 	.globl _init
                             13 	.globl _renderCompass
                             14 	.globl _uncompress_theme_textures
                             15 	.globl _draw_minimap_to_buffer
                             16 	.globl _render_draw_to_buffer
                             17 	.globl _generate_level
                             18 	.globl _init_generator
                             19 	.globl _cpct_setPALColour
                             20 	.globl _cpct_setPalette
                             21 	.globl _cpct_fw2hw
                             22 	.globl _cpct_setVideoMode
                             23 	.globl _cpct_drawSprite
                             24 	.globl _cpct_isKeyPressed
                             25 	.globl _cpct_scanKeyboard_f
                             26 	.globl _cpct_memset
                             27 	.globl _cpct_disableFirmware
                             28 ;--------------------------------------------------------
                             29 ; special function registers
                             30 ;--------------------------------------------------------
                             31 ;--------------------------------------------------------
                             32 ; ram data
                             33 ;--------------------------------------------------------
                             34 	.area _DATA
                             35 ;--------------------------------------------------------
                             36 ; ram data
                             37 ;--------------------------------------------------------
                             38 	.area _INITIALIZED
                             39 ;--------------------------------------------------------
                             40 ; absolute external ram data
                             41 ;--------------------------------------------------------
                             42 	.area _DABS (ABS)
                             43 ;--------------------------------------------------------
                             44 ; global & static initialisations
                             45 ;--------------------------------------------------------
                             46 	.area _HOME
                             47 	.area _GSINIT
                             48 	.area _GSFINAL
                             49 	.area _GSINIT
                             50 ;--------------------------------------------------------
                             51 ; Home
                             52 ;--------------------------------------------------------
                             53 	.area _HOME
                             54 	.area _HOME
                             55 ;--------------------------------------------------------
                             56 ; code
                             57 ;--------------------------------------------------------
                             58 	.area _CODE
                             59 ;src/main.c:28: void init(){
                             60 ;	---------------------------------
                             61 ; Function init
                             62 ; ---------------------------------
   4000                      63 _init::
                             64 ;src/main.c:29: cpct_disableFirmware();
   4000 CD 39 64      [17]   65 	call	_cpct_disableFirmware
                             66 ;src/main.c:30: cpct_setVideoMode(0);
   4003 2E 00         [ 7]   67 	ld	l,#0x00
   4005 CD 1D 64      [17]   68 	call	_cpct_setVideoMode
                             69 ;src/main.c:31: cpct_fw2hw(g_palette,16);
   4008 21 10 00      [10]   70 	ld	hl,#0x0010
   400B E5            [11]   71 	push	hl
   400C 21 E9 49      [10]   72 	ld	hl,#_g_palette
   400F E5            [11]   73 	push	hl
   4010 CD 77 63      [17]   74 	call	_cpct_fw2hw
                             75 ;src/main.c:32: cpct_setPalette(g_palette,16);
   4013 21 10 00      [10]   76 	ld	hl,#0x0010
   4016 E5            [11]   77 	push	hl
   4017 21 E9 49      [10]   78 	ld	hl,#_g_palette
   401A E5            [11]   79 	push	hl
   401B CD 1D 62      [17]   80 	call	_cpct_setPalette
                             81 ;src/main.c:33: cpct_setBorder(g_palette[12]);
   401E 21 F5 49      [10]   82 	ld	hl, #_g_palette + 12
   4021 46            [ 7]   83 	ld	b,(hl)
   4022 C5            [11]   84 	push	bc
   4023 33            [ 6]   85 	inc	sp
   4024 3E 10         [ 7]   86 	ld	a,#0x10
   4026 F5            [11]   87 	push	af
   4027 33            [ 6]   88 	inc	sp
   4028 CD AA 62      [17]   89 	call	_cpct_setPALColour
                             90 ;src/main.c:35: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
   402B 21 05 4A      [10]   91 	ld	hl, #(_g_colors + 0x000c) + 0
   402E 46            [ 7]   92 	ld	b,(hl)
   402F 21 00 40      [10]   93 	ld	hl,#0x4000
   4032 E5            [11]   94 	push	hl
   4033 C5            [11]   95 	push	bc
   4034 33            [ 6]   96 	inc	sp
   4035 26 C0         [ 7]   97 	ld	h, #0xC0
   4037 E5            [11]   98 	push	hl
   4038 CD 2B 64      [17]   99 	call	_cpct_memset
   403B C9            [10]  100 	ret
                            101 ;src/main.c:38: void main(void) {
                            102 ;	---------------------------------
                            103 ; Function main
                            104 ; ---------------------------------
   403C                     105 _main::
                            106 ;src/main.c:39: init();
   403C CD 00 40      [17]  107 	call	_init
                            108 ;src/main.c:40: init_generator();
   403F CD 73 41      [17]  109 	call	_init_generator
                            110 ;src/main.c:41: uncompress_theme_textures(0);
   4042 AF            [ 4]  111 	xor	a, a
   4043 F5            [11]  112 	push	af
   4044 33            [ 6]  113 	inc	sp
   4045 CD DB 52      [17]  114 	call	_uncompress_theme_textures
   4048 33            [ 6]  115 	inc	sp
                            116 ;src/main.c:42: generate_level();
   4049 CD 27 48      [17]  117 	call	_generate_level
                            118 ;src/main.c:43: render_draw_to_buffer();
   404C CD 56 4B      [17]  119 	call	_render_draw_to_buffer
                            120 ;src/main.c:44: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   404F 21 28 64      [10]  121 	ld	hl,#0x6428
   4052 E5            [11]  122 	push	hl
   4053 21 14 C0      [10]  123 	ld	hl,#0xC014
   4056 E5            [11]  124 	push	hl
   4057 21 40 2B      [10]  125 	ld	hl,#0x2B40
   405A E5            [11]  126 	push	hl
   405B CD B6 62      [17]  127 	call	_cpct_drawSprite
                            128 ;src/main.c:45: draw_minimap_to_buffer();
   405E CD 13 51      [17]  129 	call	_draw_minimap_to_buffer
                            130 ;src/main.c:46: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   4061 21 10 40      [10]  131 	ld	hl,#0x4010
   4064 E5            [11]  132 	push	hl
   4065 21 70 C5      [10]  133 	ld	hl,#0xC570
   4068 E5            [11]  134 	push	hl
   4069 21 40 1C      [10]  135 	ld	hl,#0x1C40
   406C E5            [11]  136 	push	hl
   406D CD B6 62      [17]  137 	call	_cpct_drawSprite
                            138 ;src/main.c:49: while(1) {
   4070                     139 00115$:
                            140 ;src/main.c:50: u8 movement = 0;
   4070 0E 00         [ 7]  141 	ld	c,#0x00
                            142 ;src/main.c:51: cpct_scanKeyboard_f();
   4072 C5            [11]  143 	push	bc
   4073 CD 40 62      [17]  144 	call	_cpct_scanKeyboard_f
   4076 21 01 01      [10]  145 	ld	hl,#0x0101
   4079 CD 34 62      [17]  146 	call	_cpct_isKeyPressed
   407C 5D            [ 4]  147 	ld	e,l
   407D C1            [10]  148 	pop	bc
   407E 7B            [ 4]  149 	ld	a,e
   407F B7            [ 4]  150 	or	a, a
   4080 28 33         [12]  151 	jr	Z,00110$
                            152 ;src/main.c:53: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
   4082 01 31 48      [10]  153 	ld	bc,#_PLAYER_directionIndex+0
   4085 3A 31 48      [13]  154 	ld	a,(#_PLAYER_directionIndex + 0)
   4088 C6 02         [ 7]  155 	add	a, #0x02
   408A E6 07         [ 7]  156 	and	a, #0x07
   408C 02            [ 7]  157 	ld	(bc),a
                            158 ;src/main.c:54: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   408D 01 32 48      [10]  159 	ld	bc,#_PLAYER_directionArray+0
   4090 FD 21 31 48   [14]  160 	ld	iy,#_PLAYER_directionIndex
   4094 FD 6E 00      [19]  161 	ld	l, 0 (iy)
   4097 26 00         [ 7]  162 	ld	h,#0x00
   4099 09            [11]  163 	add	hl,bc
   409A 5E            [ 7]  164 	ld	e,(hl)
   409B 21 2F 48      [10]  165 	ld	hl,#_PLAYER_direction
   409E 73            [ 7]  166 	ld	(hl),e
                            167 ;src/main.c:55: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   409F 21 31 48      [10]  168 	ld	hl,#_PLAYER_directionIndex + 0
   40A2 5E            [ 7]  169 	ld	e, (hl)
   40A3 1C            [ 4]  170 	inc	e
   40A4 6B            [ 4]  171 	ld	l,e
   40A5 26 00         [ 7]  172 	ld	h,#0x00
   40A7 09            [11]  173 	add	hl,bc
   40A8 4E            [ 7]  174 	ld	c,(hl)
   40A9 21 30 48      [10]  175 	ld	hl,#(_PLAYER_direction + 0x0001)
   40AC 71            [ 7]  176 	ld	(hl),c
                            177 ;src/main.c:56: renderCompass();
   40AD CD 65 53      [17]  178 	call	_renderCompass
                            179 ;src/main.c:57: movement =1;
   40B0 0E 01         [ 7]  180 	ld	c,#0x01
   40B2 C3 47 41      [10]  181 	jp	00111$
   40B5                     182 00110$:
                            183 ;src/main.c:59: else if(cpct_isKeyPressed(Key_CursorRight)){
   40B5 C5            [11]  184 	push	bc
   40B6 21 00 02      [10]  185 	ld	hl,#0x0200
   40B9 CD 34 62      [17]  186 	call	_cpct_isKeyPressed
   40BC C1            [10]  187 	pop	bc
   40BD 7D            [ 4]  188 	ld	a,l
   40BE B7            [ 4]  189 	or	a, a
   40BF 28 34         [12]  190 	jr	Z,00107$
                            191 ;src/main.c:60: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
   40C1 01 31 48      [10]  192 	ld	bc,#_PLAYER_directionIndex+0
   40C4 3A 31 48      [13]  193 	ld	a,(#_PLAYER_directionIndex + 0)
   40C7 C6 FE         [ 7]  194 	add	a,#0xFE
   40C9 E6 07         [ 7]  195 	and	a, #0x07
   40CB 02            [ 7]  196 	ld	(bc),a
                            197 ;src/main.c:61: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   40CC 01 2F 48      [10]  198 	ld	bc,#_PLAYER_direction+0
   40CF 11 32 48      [10]  199 	ld	de,#_PLAYER_directionArray+0
   40D2 FD 21 31 48   [14]  200 	ld	iy,#_PLAYER_directionIndex
   40D6 FD 6E 00      [19]  201 	ld	l,0 (iy)
   40D9 26 00         [ 7]  202 	ld	h,#0x00
   40DB 19            [11]  203 	add	hl,de
   40DC 7E            [ 7]  204 	ld	a,(hl)
   40DD 02            [ 7]  205 	ld	(bc),a
                            206 ;src/main.c:62: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   40DE 01 30 48      [10]  207 	ld	bc,#_PLAYER_direction+1
   40E1 FD 21 31 48   [14]  208 	ld	iy,#_PLAYER_directionIndex
   40E5 FD 6E 00      [19]  209 	ld	l,0 (iy)
   40E8 2C            [ 4]  210 	inc	l
   40E9 26 00         [ 7]  211 	ld	h,#0x00
   40EB 19            [11]  212 	add	hl,de
   40EC 7E            [ 7]  213 	ld	a,(hl)
   40ED 02            [ 7]  214 	ld	(bc),a
                            215 ;src/main.c:63: renderCompass();
   40EE CD 65 53      [17]  216 	call	_renderCompass
                            217 ;src/main.c:64: movement =1;
   40F1 0E 01         [ 7]  218 	ld	c,#0x01
   40F3 18 52         [12]  219 	jr	00111$
   40F5                     220 00107$:
                            221 ;src/main.c:66: else if(cpct_isKeyPressed(Key_CursorUp)){
   40F5 C5            [11]  222 	push	bc
   40F6 21 00 01      [10]  223 	ld	hl,#0x0100
   40F9 CD 34 62      [17]  224 	call	_cpct_isKeyPressed
   40FC C1            [10]  225 	pop	bc
   40FD 7D            [ 4]  226 	ld	a,l
   40FE B7            [ 4]  227 	or	a, a
   40FF 28 1E         [12]  228 	jr	Z,00104$
                            229 ;src/main.c:67: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
   4101 21 2D 48      [10]  230 	ld	hl,#_PLAYER_position+0
   4104 4D            [ 4]  231 	ld	c, l
   4105 44            [ 4]  232 	ld	b, h
   4106 5E            [ 7]  233 	ld	e,(hl)
   4107 21 2F 48      [10]  234 	ld	hl, #_PLAYER_direction + 0
   410A 6E            [ 7]  235 	ld	l,(hl)
   410B 7B            [ 4]  236 	ld	a,e
   410C 85            [ 4]  237 	add	a, l
   410D 02            [ 7]  238 	ld	(bc),a
                            239 ;src/main.c:68: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
   410E 21 2E 48      [10]  240 	ld	hl,#_PLAYER_position+1
   4111 4D            [ 4]  241 	ld	c, l
   4112 44            [ 4]  242 	ld	b, h
   4113 5E            [ 7]  243 	ld	e,(hl)
   4114 21 30 48      [10]  244 	ld	hl, #(_PLAYER_direction + 0x0001) + 0
   4117 6E            [ 7]  245 	ld	l,(hl)
   4118 7B            [ 4]  246 	ld	a,e
   4119 85            [ 4]  247 	add	a, l
   411A 02            [ 7]  248 	ld	(bc),a
                            249 ;src/main.c:70: movement =1;
   411B 0E 01         [ 7]  250 	ld	c,#0x01
   411D 18 28         [12]  251 	jr	00111$
   411F                     252 00104$:
                            253 ;src/main.c:72: else if(cpct_isKeyPressed(Key_CursorDown)){
   411F C5            [11]  254 	push	bc
   4120 21 00 04      [10]  255 	ld	hl,#0x0400
   4123 CD 34 62      [17]  256 	call	_cpct_isKeyPressed
   4126 C1            [10]  257 	pop	bc
   4127 7D            [ 4]  258 	ld	a,l
   4128 B7            [ 4]  259 	or	a, a
   4129 28 1C         [12]  260 	jr	Z,00111$
                            261 ;src/main.c:73: *(i8*)&(PLAYER_position.x) = PLAYER_position.x - PLAYER_direction.x;
   412B 21 2D 48      [10]  262 	ld	hl,#_PLAYER_position+0
   412E 4D            [ 4]  263 	ld	c, l
   412F 44            [ 4]  264 	ld	b, h
   4130 5E            [ 7]  265 	ld	e,(hl)
   4131 21 2F 48      [10]  266 	ld	hl, #_PLAYER_direction + 0
   4134 6E            [ 7]  267 	ld	l,(hl)
   4135 7B            [ 4]  268 	ld	a,e
   4136 95            [ 4]  269 	sub	a, l
   4137 02            [ 7]  270 	ld	(bc),a
                            271 ;src/main.c:74: *(i8*)&(PLAYER_position.y) = PLAYER_position.y - PLAYER_direction.y;
   4138 21 2E 48      [10]  272 	ld	hl,#_PLAYER_position+1
   413B 4D            [ 4]  273 	ld	c, l
   413C 44            [ 4]  274 	ld	b, h
   413D 5E            [ 7]  275 	ld	e,(hl)
   413E 21 30 48      [10]  276 	ld	hl, #(_PLAYER_direction + 0x0001) + 0
   4141 6E            [ 7]  277 	ld	l,(hl)
   4142 7B            [ 4]  278 	ld	a,e
   4143 95            [ 4]  279 	sub	a, l
   4144 02            [ 7]  280 	ld	(bc),a
                            281 ;src/main.c:76: movement =1;
   4145 0E 01         [ 7]  282 	ld	c,#0x01
   4147                     283 00111$:
                            284 ;src/main.c:78: if(movement){
   4147 79            [ 4]  285 	ld	a,c
   4148 B7            [ 4]  286 	or	a, a
   4149 CA 70 40      [10]  287 	jp	Z,00115$
                            288 ;src/main.c:79: render_draw_to_buffer();
   414C CD 56 4B      [17]  289 	call	_render_draw_to_buffer
                            290 ;src/main.c:80: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   414F 21 28 64      [10]  291 	ld	hl,#0x6428
   4152 E5            [11]  292 	push	hl
   4153 21 14 C0      [10]  293 	ld	hl,#0xC014
   4156 E5            [11]  294 	push	hl
   4157 21 40 2B      [10]  295 	ld	hl,#0x2B40
   415A E5            [11]  296 	push	hl
   415B CD B6 62      [17]  297 	call	_cpct_drawSprite
                            298 ;src/main.c:81: draw_minimap_to_buffer();
   415E CD 13 51      [17]  299 	call	_draw_minimap_to_buffer
                            300 ;src/main.c:82: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   4161 21 10 40      [10]  301 	ld	hl,#0x4010
   4164 E5            [11]  302 	push	hl
   4165 21 70 C5      [10]  303 	ld	hl,#0xC570
   4168 E5            [11]  304 	push	hl
   4169 21 40 1C      [10]  305 	ld	hl,#0x1C40
   416C E5            [11]  306 	push	hl
   416D CD B6 62      [17]  307 	call	_cpct_drawSprite
   4170 C3 70 40      [10]  308 	jp	00115$
                            309 	.area _CODE
                            310 	.area _INITIALIZER
                            311 	.area _CABS (ABS)
