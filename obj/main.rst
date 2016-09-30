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
                             17 	.globl _generate_map
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
   4000 CD 3D 5E      [17]   65 	call	_cpct_disableFirmware
                             66 ;src/main.c:30: cpct_setVideoMode(0);
   4003 2E 00         [ 7]   67 	ld	l,#0x00
   4005 CD 21 5E      [17]   68 	call	_cpct_setVideoMode
                             69 ;src/main.c:31: cpct_fw2hw(g_palette,16);
   4008 21 10 00      [10]   70 	ld	hl,#0x0010
   400B E5            [11]   71 	push	hl
   400C 21 AA 48      [10]   72 	ld	hl,#_g_palette
   400F E5            [11]   73 	push	hl
   4010 CD 7B 5D      [17]   74 	call	_cpct_fw2hw
                             75 ;src/main.c:32: cpct_setPalette(g_palette,16);
   4013 21 10 00      [10]   76 	ld	hl,#0x0010
   4016 E5            [11]   77 	push	hl
   4017 21 AA 48      [10]   78 	ld	hl,#_g_palette
   401A E5            [11]   79 	push	hl
   401B CD 21 5C      [17]   80 	call	_cpct_setPalette
                             81 ;src/main.c:33: cpct_setBorder(g_palette[0]);
   401E 21 AA 48      [10]   82 	ld	hl, #_g_palette + 0
   4021 46            [ 7]   83 	ld	b,(hl)
   4022 C5            [11]   84 	push	bc
   4023 33            [ 6]   85 	inc	sp
   4024 3E 10         [ 7]   86 	ld	a,#0x10
   4026 F5            [11]   87 	push	af
   4027 33            [ 6]   88 	inc	sp
   4028 CD AE 5C      [17]   89 	call	_cpct_setPALColour
                             90 ;src/main.c:35: cpct_memset(CPCT_VMEM_START, g_colors[15], 0x4000);
   402B 21 C9 48      [10]   91 	ld	hl, #(_g_colors + 0x000f) + 0
   402E 46            [ 7]   92 	ld	b,(hl)
   402F 21 00 40      [10]   93 	ld	hl,#0x4000
   4032 E5            [11]   94 	push	hl
   4033 C5            [11]   95 	push	bc
   4034 33            [ 6]   96 	inc	sp
   4035 26 C0         [ 7]   97 	ld	h, #0xC0
   4037 E5            [11]   98 	push	hl
   4038 CD 2F 5E      [17]   99 	call	_cpct_memset
   403B C9            [10]  100 	ret
                            101 ;src/main.c:38: void main(void) {
                            102 ;	---------------------------------
                            103 ; Function main
                            104 ; ---------------------------------
   403C                     105 _main::
                            106 ;src/main.c:39: init();
   403C CD 00 40      [17]  107 	call	_init
                            108 ;src/main.c:40: init_generator();
   403F CD 8D 41      [17]  109 	call	_init_generator
                            110 ;src/main.c:41: uncompress_theme_textures(0);
   4042 AF            [ 4]  111 	xor	a, a
   4043 F5            [11]  112 	push	af
   4044 33            [ 6]  113 	inc	sp
   4045 CD 82 51      [17]  114 	call	_uncompress_theme_textures
   4048 33            [ 6]  115 	inc	sp
                            116 ;src/main.c:42: cpct_setBorder(g_palette[1]);
   4049 21 AB 48      [10]  117 	ld	hl, #_g_palette + 1
   404C 46            [ 7]  118 	ld	b,(hl)
   404D C5            [11]  119 	push	bc
   404E 33            [ 6]  120 	inc	sp
   404F 3E 10         [ 7]  121 	ld	a,#0x10
   4051 F5            [11]  122 	push	af
   4052 33            [ 6]  123 	inc	sp
   4053 CD AE 5C      [17]  124 	call	_cpct_setPALColour
                            125 ;src/main.c:43: generate_map();
   4056 CD 98 41      [17]  126 	call	_generate_map
                            127 ;src/main.c:44: cpct_setBorder(g_palette[15]);
   4059 21 B9 48      [10]  128 	ld	hl, #_g_palette + 15
   405C 46            [ 7]  129 	ld	b,(hl)
   405D C5            [11]  130 	push	bc
   405E 33            [ 6]  131 	inc	sp
   405F 3E 10         [ 7]  132 	ld	a,#0x10
   4061 F5            [11]  133 	push	af
   4062 33            [ 6]  134 	inc	sp
   4063 CD AE 5C      [17]  135 	call	_cpct_setPALColour
                            136 ;src/main.c:45: render_draw_to_buffer();
   4066 CD 10 4A      [17]  137 	call	_render_draw_to_buffer
                            138 ;src/main.c:46: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   4069 21 28 64      [10]  139 	ld	hl,#0x6428
   406C E5            [11]  140 	push	hl
   406D 21 14 C0      [10]  141 	ld	hl,#0xC014
   4070 E5            [11]  142 	push	hl
   4071 21 40 1C      [10]  143 	ld	hl,#0x1C40
   4074 E5            [11]  144 	push	hl
   4075 CD BA 5C      [17]  145 	call	_cpct_drawSprite
                            146 ;src/main.c:47: draw_minimap_to_buffer();
   4078 CD CD 4F      [17]  147 	call	_draw_minimap_to_buffer
                            148 ;src/main.c:48: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   407B 21 10 40      [10]  149 	ld	hl,#0x4010
   407E E5            [11]  150 	push	hl
   407F 21 70 C5      [10]  151 	ld	hl,#0xC570
   4082 E5            [11]  152 	push	hl
   4083 21 40 1C      [10]  153 	ld	hl,#0x1C40
   4086 E5            [11]  154 	push	hl
   4087 CD BA 5C      [17]  155 	call	_cpct_drawSprite
                            156 ;src/main.c:51: while(1) {
   408A                     157 00115$:
                            158 ;src/main.c:52: u8 movement = 0;
   408A 0E 00         [ 7]  159 	ld	c,#0x00
                            160 ;src/main.c:53: cpct_scanKeyboard_f();
   408C C5            [11]  161 	push	bc
   408D CD 44 5C      [17]  162 	call	_cpct_scanKeyboard_f
   4090 21 01 01      [10]  163 	ld	hl,#0x0101
   4093 CD 38 5C      [17]  164 	call	_cpct_isKeyPressed
   4096 5D            [ 4]  165 	ld	e,l
   4097 C1            [10]  166 	pop	bc
   4098 7B            [ 4]  167 	ld	a,e
   4099 B7            [ 4]  168 	or	a, a
   409A 28 33         [12]  169 	jr	Z,00110$
                            170 ;src/main.c:55: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
   409C 01 F2 46      [10]  171 	ld	bc,#_PLAYER_directionIndex+0
   409F 3A F2 46      [13]  172 	ld	a,(#_PLAYER_directionIndex + 0)
   40A2 C6 02         [ 7]  173 	add	a, #0x02
   40A4 E6 07         [ 7]  174 	and	a, #0x07
   40A6 02            [ 7]  175 	ld	(bc),a
                            176 ;src/main.c:56: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   40A7 01 F3 46      [10]  177 	ld	bc,#_PLAYER_directionArray+0
   40AA FD 21 F2 46   [14]  178 	ld	iy,#_PLAYER_directionIndex
   40AE FD 6E 00      [19]  179 	ld	l, 0 (iy)
   40B1 26 00         [ 7]  180 	ld	h,#0x00
   40B3 09            [11]  181 	add	hl,bc
   40B4 5E            [ 7]  182 	ld	e,(hl)
   40B5 21 F0 46      [10]  183 	ld	hl,#_PLAYER_direction
   40B8 73            [ 7]  184 	ld	(hl),e
                            185 ;src/main.c:57: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   40B9 21 F2 46      [10]  186 	ld	hl,#_PLAYER_directionIndex + 0
   40BC 5E            [ 7]  187 	ld	e, (hl)
   40BD 1C            [ 4]  188 	inc	e
   40BE 6B            [ 4]  189 	ld	l,e
   40BF 26 00         [ 7]  190 	ld	h,#0x00
   40C1 09            [11]  191 	add	hl,bc
   40C2 4E            [ 7]  192 	ld	c,(hl)
   40C3 21 F1 46      [10]  193 	ld	hl,#(_PLAYER_direction + 0x0001)
   40C6 71            [ 7]  194 	ld	(hl),c
                            195 ;src/main.c:58: renderCompass();
   40C7 CD F1 51      [17]  196 	call	_renderCompass
                            197 ;src/main.c:59: movement =1;
   40CA 0E 01         [ 7]  198 	ld	c,#0x01
   40CC C3 61 41      [10]  199 	jp	00111$
   40CF                     200 00110$:
                            201 ;src/main.c:61: else if(cpct_isKeyPressed(Key_CursorRight)){
   40CF C5            [11]  202 	push	bc
   40D0 21 00 02      [10]  203 	ld	hl,#0x0200
   40D3 CD 38 5C      [17]  204 	call	_cpct_isKeyPressed
   40D6 C1            [10]  205 	pop	bc
   40D7 7D            [ 4]  206 	ld	a,l
   40D8 B7            [ 4]  207 	or	a, a
   40D9 28 34         [12]  208 	jr	Z,00107$
                            209 ;src/main.c:62: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
   40DB 01 F2 46      [10]  210 	ld	bc,#_PLAYER_directionIndex+0
   40DE 3A F2 46      [13]  211 	ld	a,(#_PLAYER_directionIndex + 0)
   40E1 C6 FE         [ 7]  212 	add	a,#0xFE
   40E3 E6 07         [ 7]  213 	and	a, #0x07
   40E5 02            [ 7]  214 	ld	(bc),a
                            215 ;src/main.c:63: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   40E6 01 F0 46      [10]  216 	ld	bc,#_PLAYER_direction+0
   40E9 11 F3 46      [10]  217 	ld	de,#_PLAYER_directionArray+0
   40EC FD 21 F2 46   [14]  218 	ld	iy,#_PLAYER_directionIndex
   40F0 FD 6E 00      [19]  219 	ld	l,0 (iy)
   40F3 26 00         [ 7]  220 	ld	h,#0x00
   40F5 19            [11]  221 	add	hl,de
   40F6 7E            [ 7]  222 	ld	a,(hl)
   40F7 02            [ 7]  223 	ld	(bc),a
                            224 ;src/main.c:64: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   40F8 01 F1 46      [10]  225 	ld	bc,#_PLAYER_direction+1
   40FB FD 21 F2 46   [14]  226 	ld	iy,#_PLAYER_directionIndex
   40FF FD 6E 00      [19]  227 	ld	l,0 (iy)
   4102 2C            [ 4]  228 	inc	l
   4103 26 00         [ 7]  229 	ld	h,#0x00
   4105 19            [11]  230 	add	hl,de
   4106 7E            [ 7]  231 	ld	a,(hl)
   4107 02            [ 7]  232 	ld	(bc),a
                            233 ;src/main.c:65: renderCompass();
   4108 CD F1 51      [17]  234 	call	_renderCompass
                            235 ;src/main.c:66: movement =1;
   410B 0E 01         [ 7]  236 	ld	c,#0x01
   410D 18 52         [12]  237 	jr	00111$
   410F                     238 00107$:
                            239 ;src/main.c:68: else if(cpct_isKeyPressed(Key_CursorUp)){
   410F C5            [11]  240 	push	bc
   4110 21 00 01      [10]  241 	ld	hl,#0x0100
   4113 CD 38 5C      [17]  242 	call	_cpct_isKeyPressed
   4116 C1            [10]  243 	pop	bc
   4117 7D            [ 4]  244 	ld	a,l
   4118 B7            [ 4]  245 	or	a, a
   4119 28 1E         [12]  246 	jr	Z,00104$
                            247 ;src/main.c:69: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
   411B 21 EE 46      [10]  248 	ld	hl,#_PLAYER_position+0
   411E 4D            [ 4]  249 	ld	c, l
   411F 44            [ 4]  250 	ld	b, h
   4120 5E            [ 7]  251 	ld	e,(hl)
   4121 21 F0 46      [10]  252 	ld	hl, #_PLAYER_direction + 0
   4124 6E            [ 7]  253 	ld	l,(hl)
   4125 7B            [ 4]  254 	ld	a,e
   4126 85            [ 4]  255 	add	a, l
   4127 02            [ 7]  256 	ld	(bc),a
                            257 ;src/main.c:70: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
   4128 21 EF 46      [10]  258 	ld	hl,#_PLAYER_position+1
   412B 4D            [ 4]  259 	ld	c, l
   412C 44            [ 4]  260 	ld	b, h
   412D 5E            [ 7]  261 	ld	e,(hl)
   412E 21 F1 46      [10]  262 	ld	hl, #(_PLAYER_direction + 0x0001) + 0
   4131 6E            [ 7]  263 	ld	l,(hl)
   4132 7B            [ 4]  264 	ld	a,e
   4133 85            [ 4]  265 	add	a, l
   4134 02            [ 7]  266 	ld	(bc),a
                            267 ;src/main.c:72: movement =1;
   4135 0E 01         [ 7]  268 	ld	c,#0x01
   4137 18 28         [12]  269 	jr	00111$
   4139                     270 00104$:
                            271 ;src/main.c:74: else if(cpct_isKeyPressed(Key_CursorDown)){
   4139 C5            [11]  272 	push	bc
   413A 21 00 04      [10]  273 	ld	hl,#0x0400
   413D CD 38 5C      [17]  274 	call	_cpct_isKeyPressed
   4140 C1            [10]  275 	pop	bc
   4141 7D            [ 4]  276 	ld	a,l
   4142 B7            [ 4]  277 	or	a, a
   4143 28 1C         [12]  278 	jr	Z,00111$
                            279 ;src/main.c:75: *(i8*)&(PLAYER_position.x) = PLAYER_position.x - PLAYER_direction.x;
   4145 21 EE 46      [10]  280 	ld	hl,#_PLAYER_position+0
   4148 4D            [ 4]  281 	ld	c, l
   4149 44            [ 4]  282 	ld	b, h
   414A 5E            [ 7]  283 	ld	e,(hl)
   414B 21 F0 46      [10]  284 	ld	hl, #_PLAYER_direction + 0
   414E 6E            [ 7]  285 	ld	l,(hl)
   414F 7B            [ 4]  286 	ld	a,e
   4150 95            [ 4]  287 	sub	a, l
   4151 02            [ 7]  288 	ld	(bc),a
                            289 ;src/main.c:76: *(i8*)&(PLAYER_position.y) = PLAYER_position.y - PLAYER_direction.y;
   4152 21 EF 46      [10]  290 	ld	hl,#_PLAYER_position+1
   4155 4D            [ 4]  291 	ld	c, l
   4156 44            [ 4]  292 	ld	b, h
   4157 5E            [ 7]  293 	ld	e,(hl)
   4158 21 F1 46      [10]  294 	ld	hl, #(_PLAYER_direction + 0x0001) + 0
   415B 6E            [ 7]  295 	ld	l,(hl)
   415C 7B            [ 4]  296 	ld	a,e
   415D 95            [ 4]  297 	sub	a, l
   415E 02            [ 7]  298 	ld	(bc),a
                            299 ;src/main.c:78: movement =1;
   415F 0E 01         [ 7]  300 	ld	c,#0x01
   4161                     301 00111$:
                            302 ;src/main.c:80: if(movement){
   4161 79            [ 4]  303 	ld	a,c
   4162 B7            [ 4]  304 	or	a, a
   4163 CA 8A 40      [10]  305 	jp	Z,00115$
                            306 ;src/main.c:81: render_draw_to_buffer();
   4166 CD 10 4A      [17]  307 	call	_render_draw_to_buffer
                            308 ;src/main.c:82: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   4169 21 28 64      [10]  309 	ld	hl,#0x6428
   416C E5            [11]  310 	push	hl
   416D 21 14 C0      [10]  311 	ld	hl,#0xC014
   4170 E5            [11]  312 	push	hl
   4171 21 40 1C      [10]  313 	ld	hl,#0x1C40
   4174 E5            [11]  314 	push	hl
   4175 CD BA 5C      [17]  315 	call	_cpct_drawSprite
                            316 ;src/main.c:83: draw_minimap_to_buffer();
   4178 CD CD 4F      [17]  317 	call	_draw_minimap_to_buffer
                            318 ;src/main.c:84: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   417B 21 10 40      [10]  319 	ld	hl,#0x4010
   417E E5            [11]  320 	push	hl
   417F 21 70 C5      [10]  321 	ld	hl,#0xC570
   4182 E5            [11]  322 	push	hl
   4183 21 40 1C      [10]  323 	ld	hl,#0x1C40
   4186 E5            [11]  324 	push	hl
   4187 CD BA 5C      [17]  325 	call	_cpct_drawSprite
   418A C3 8A 40      [10]  326 	jp	00115$
                            327 	.area _CODE
                            328 	.area _INITIALIZER
                            329 	.area _CABS (ABS)
