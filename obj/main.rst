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
                             14 	.globl _uncompress_enemy_textures
                             15 	.globl _uncompress_theme_textures
                             16 	.globl _draw_minimap_to_buffer
                             17 	.globl _render_draw_to_buffer
                             18 	.globl _generate_level
                             19 	.globl _init_generator
                             20 	.globl _cpct_setPALColour
                             21 	.globl _cpct_setPalette
                             22 	.globl _cpct_fw2hw
                             23 	.globl _cpct_setVideoMode
                             24 	.globl _cpct_drawSprite
                             25 	.globl _cpct_isKeyPressed
                             26 	.globl _cpct_scanKeyboard_f
                             27 	.globl _cpct_memset
                             28 	.globl _cpct_disableFirmware
                             29 ;--------------------------------------------------------
                             30 ; special function registers
                             31 ;--------------------------------------------------------
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _DATA
                             36 ;--------------------------------------------------------
                             37 ; ram data
                             38 ;--------------------------------------------------------
                             39 	.area _INITIALIZED
                             40 ;--------------------------------------------------------
                             41 ; absolute external ram data
                             42 ;--------------------------------------------------------
                             43 	.area _DABS (ABS)
                             44 ;--------------------------------------------------------
                             45 ; global & static initialisations
                             46 ;--------------------------------------------------------
                             47 	.area _HOME
                             48 	.area _GSINIT
                             49 	.area _GSFINAL
                             50 	.area _GSINIT
                             51 ;--------------------------------------------------------
                             52 ; Home
                             53 ;--------------------------------------------------------
                             54 	.area _HOME
                             55 	.area _HOME
                             56 ;--------------------------------------------------------
                             57 ; code
                             58 ;--------------------------------------------------------
                             59 	.area _CODE
                             60 ;src/main.c:28: void init(){
                             61 ;	---------------------------------
                             62 ; Function init
                             63 ; ---------------------------------
   4000                      64 _init::
                             65 ;src/main.c:29: cpct_disableFirmware();
   4000 CD AB 6C      [17]   66 	call	_cpct_disableFirmware
                             67 ;src/main.c:30: cpct_setVideoMode(0);
   4003 2E 00         [ 7]   68 	ld	l,#0x00
   4005 CD 8F 6C      [17]   69 	call	_cpct_setVideoMode
                             70 ;src/main.c:31: cpct_fw2hw(g_palette,16);
   4008 21 10 00      [10]   71 	ld	hl,#0x0010
   400B E5            [11]   72 	push	hl
   400C 21 68 4A      [10]   73 	ld	hl,#_g_palette
   400F E5            [11]   74 	push	hl
   4010 CD E9 6B      [17]   75 	call	_cpct_fw2hw
                             76 ;src/main.c:32: cpct_setPalette(g_palette,16);
   4013 21 10 00      [10]   77 	ld	hl,#0x0010
   4016 E5            [11]   78 	push	hl
   4017 21 68 4A      [10]   79 	ld	hl,#_g_palette
   401A E5            [11]   80 	push	hl
   401B CD 8F 6A      [17]   81 	call	_cpct_setPalette
                             82 ;src/main.c:33: cpct_setBorder(g_palette[12]);
   401E 21 74 4A      [10]   83 	ld	hl, #_g_palette + 12
   4021 46            [ 7]   84 	ld	b,(hl)
   4022 C5            [11]   85 	push	bc
   4023 33            [ 6]   86 	inc	sp
   4024 3E 10         [ 7]   87 	ld	a,#0x10
   4026 F5            [11]   88 	push	af
   4027 33            [ 6]   89 	inc	sp
   4028 CD 1C 6B      [17]   90 	call	_cpct_setPALColour
                             91 ;src/main.c:35: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
   402B 21 84 4A      [10]   92 	ld	hl, #(_g_colors + 0x000c) + 0
   402E 46            [ 7]   93 	ld	b,(hl)
   402F 21 00 40      [10]   94 	ld	hl,#0x4000
   4032 E5            [11]   95 	push	hl
   4033 C5            [11]   96 	push	bc
   4034 33            [ 6]   97 	inc	sp
   4035 26 C0         [ 7]   98 	ld	h, #0xC0
   4037 E5            [11]   99 	push	hl
   4038 CD 9D 6C      [17]  100 	call	_cpct_memset
   403B C9            [10]  101 	ret
                            102 ;src/main.c:38: void main(void) {
                            103 ;	---------------------------------
                            104 ; Function main
                            105 ; ---------------------------------
   403C                     106 _main::
                            107 ;src/main.c:39: init();
   403C CD 00 40      [17]  108 	call	_init
                            109 ;src/main.c:40: init_generator();
   403F CD 7A 41      [17]  110 	call	_init_generator
                            111 ;src/main.c:41: uncompress_theme_textures(0);
   4042 AF            [ 4]  112 	xor	a, a
   4043 F5            [11]  113 	push	af
   4044 33            [ 6]  114 	inc	sp
   4045 CD C1 5A      [17]  115 	call	_uncompress_theme_textures
   4048 33            [ 6]  116 	inc	sp
                            117 ;src/main.c:42: uncompress_enemy_textures(0);
   4049 AF            [ 4]  118 	xor	a, a
   404A F5            [11]  119 	push	af
   404B 33            [ 6]  120 	inc	sp
   404C CD 4B 5B      [17]  121 	call	_uncompress_enemy_textures
   404F 33            [ 6]  122 	inc	sp
                            123 ;src/main.c:43: generate_level();
   4050 CD A0 48      [17]  124 	call	_generate_level
                            125 ;src/main.c:44: render_draw_to_buffer();
   4053 CD 7B 4D      [17]  126 	call	_render_draw_to_buffer
                            127 ;src/main.c:45: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   4056 21 28 64      [10]  128 	ld	hl,#0x6428
   4059 E5            [11]  129 	push	hl
   405A 21 B4 C0      [10]  130 	ld	hl,#0xC0B4
   405D E5            [11]  131 	push	hl
   405E 21 40 29      [10]  132 	ld	hl,#0x2940
   4061 E5            [11]  133 	push	hl
   4062 CD 28 6B      [17]  134 	call	_cpct_drawSprite
                            135 ;src/main.c:46: renderCompass();
   4065 CD D7 5B      [17]  136 	call	_renderCompass
                            137 ;src/main.c:47: draw_minimap_to_buffer();
   4068 CD CA 58      [17]  138 	call	_draw_minimap_to_buffer
                            139 ;src/main.c:48: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   406B 21 10 40      [10]  140 	ld	hl,#0x4010
   406E E5            [11]  141 	push	hl
   406F 21 70 C5      [10]  142 	ld	hl,#0xC570
   4072 E5            [11]  143 	push	hl
   4073 21 40 1C      [10]  144 	ld	hl,#0x1C40
   4076 E5            [11]  145 	push	hl
   4077 CD 28 6B      [17]  146 	call	_cpct_drawSprite
                            147 ;src/main.c:51: while(1) {
   407A                     148 00115$:
                            149 ;src/main.c:52: u8 movement = 0;
   407A 0E 00         [ 7]  150 	ld	c,#0x00
                            151 ;src/main.c:53: cpct_scanKeyboard_f();
   407C C5            [11]  152 	push	bc
   407D CD B2 6A      [17]  153 	call	_cpct_scanKeyboard_f
   4080 21 01 01      [10]  154 	ld	hl,#0x0101
   4083 CD A6 6A      [17]  155 	call	_cpct_isKeyPressed
   4086 5D            [ 4]  156 	ld	e,l
   4087 C1            [10]  157 	pop	bc
   4088 7B            [ 4]  158 	ld	a,e
   4089 B7            [ 4]  159 	or	a, a
   408A 28 30         [12]  160 	jr	Z,00110$
                            161 ;src/main.c:55: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
   408C 01 B0 48      [10]  162 	ld	bc,#_PLAYER_directionIndex+0
   408F 3A B0 48      [13]  163 	ld	a,(#_PLAYER_directionIndex + 0)
   4092 C6 02         [ 7]  164 	add	a, #0x02
   4094 E6 07         [ 7]  165 	and	a, #0x07
   4096 02            [ 7]  166 	ld	(bc),a
                            167 ;src/main.c:56: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   4097 01 B1 48      [10]  168 	ld	bc,#_PLAYER_directionArray+0
   409A FD 21 B0 48   [14]  169 	ld	iy,#_PLAYER_directionIndex
   409E FD 6E 00      [19]  170 	ld	l, 0 (iy)
   40A1 26 00         [ 7]  171 	ld	h,#0x00
   40A3 09            [11]  172 	add	hl,bc
   40A4 5E            [ 7]  173 	ld	e,(hl)
   40A5 21 AE 48      [10]  174 	ld	hl,#_PLAYER_direction
   40A8 73            [ 7]  175 	ld	(hl),e
                            176 ;src/main.c:57: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   40A9 21 B0 48      [10]  177 	ld	hl,#_PLAYER_directionIndex + 0
   40AC 5E            [ 7]  178 	ld	e, (hl)
   40AD 1C            [ 4]  179 	inc	e
   40AE 6B            [ 4]  180 	ld	l,e
   40AF 26 00         [ 7]  181 	ld	h,#0x00
   40B1 09            [11]  182 	add	hl,bc
   40B2 4E            [ 7]  183 	ld	c,(hl)
   40B3 21 AF 48      [10]  184 	ld	hl,#(_PLAYER_direction + 0x0001)
   40B6 71            [ 7]  185 	ld	(hl),c
                            186 ;src/main.c:58: movement =1;
   40B7 0E 01         [ 7]  187 	ld	c,#0x01
   40B9 C3 4B 41      [10]  188 	jp	00111$
   40BC                     189 00110$:
                            190 ;src/main.c:60: else if(cpct_isKeyPressed(Key_CursorRight)){
   40BC C5            [11]  191 	push	bc
   40BD 21 00 02      [10]  192 	ld	hl,#0x0200
   40C0 CD A6 6A      [17]  193 	call	_cpct_isKeyPressed
   40C3 C1            [10]  194 	pop	bc
   40C4 7D            [ 4]  195 	ld	a,l
   40C5 B7            [ 4]  196 	or	a, a
   40C6 28 31         [12]  197 	jr	Z,00107$
                            198 ;src/main.c:61: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
   40C8 01 B0 48      [10]  199 	ld	bc,#_PLAYER_directionIndex+0
   40CB 3A B0 48      [13]  200 	ld	a,(#_PLAYER_directionIndex + 0)
   40CE C6 FE         [ 7]  201 	add	a,#0xFE
   40D0 E6 07         [ 7]  202 	and	a, #0x07
   40D2 02            [ 7]  203 	ld	(bc),a
                            204 ;src/main.c:62: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   40D3 01 AE 48      [10]  205 	ld	bc,#_PLAYER_direction+0
   40D6 11 B1 48      [10]  206 	ld	de,#_PLAYER_directionArray+0
   40D9 FD 21 B0 48   [14]  207 	ld	iy,#_PLAYER_directionIndex
   40DD FD 6E 00      [19]  208 	ld	l,0 (iy)
   40E0 26 00         [ 7]  209 	ld	h,#0x00
   40E2 19            [11]  210 	add	hl,de
   40E3 7E            [ 7]  211 	ld	a,(hl)
   40E4 02            [ 7]  212 	ld	(bc),a
                            213 ;src/main.c:63: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   40E5 01 AF 48      [10]  214 	ld	bc,#_PLAYER_direction+1
   40E8 FD 21 B0 48   [14]  215 	ld	iy,#_PLAYER_directionIndex
   40EC FD 6E 00      [19]  216 	ld	l,0 (iy)
   40EF 2C            [ 4]  217 	inc	l
   40F0 26 00         [ 7]  218 	ld	h,#0x00
   40F2 19            [11]  219 	add	hl,de
   40F3 7E            [ 7]  220 	ld	a,(hl)
   40F4 02            [ 7]  221 	ld	(bc),a
                            222 ;src/main.c:64: movement =1;
   40F5 0E 01         [ 7]  223 	ld	c,#0x01
   40F7 18 52         [12]  224 	jr	00111$
   40F9                     225 00107$:
                            226 ;src/main.c:66: else if(cpct_isKeyPressed(Key_CursorUp)){
   40F9 C5            [11]  227 	push	bc
   40FA 21 00 01      [10]  228 	ld	hl,#0x0100
   40FD CD A6 6A      [17]  229 	call	_cpct_isKeyPressed
   4100 C1            [10]  230 	pop	bc
   4101 7D            [ 4]  231 	ld	a,l
   4102 B7            [ 4]  232 	or	a, a
   4103 28 1E         [12]  233 	jr	Z,00104$
                            234 ;src/main.c:67: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
   4105 21 AC 48      [10]  235 	ld	hl,#_PLAYER_position+0
   4108 4D            [ 4]  236 	ld	c, l
   4109 44            [ 4]  237 	ld	b, h
   410A 5E            [ 7]  238 	ld	e,(hl)
   410B 21 AE 48      [10]  239 	ld	hl, #_PLAYER_direction + 0
   410E 6E            [ 7]  240 	ld	l,(hl)
   410F 7B            [ 4]  241 	ld	a,e
   4110 85            [ 4]  242 	add	a, l
   4111 02            [ 7]  243 	ld	(bc),a
                            244 ;src/main.c:68: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
   4112 21 AD 48      [10]  245 	ld	hl,#_PLAYER_position+1
   4115 4D            [ 4]  246 	ld	c, l
   4116 44            [ 4]  247 	ld	b, h
   4117 5E            [ 7]  248 	ld	e,(hl)
   4118 21 AF 48      [10]  249 	ld	hl, #(_PLAYER_direction + 0x0001) + 0
   411B 6E            [ 7]  250 	ld	l,(hl)
   411C 7B            [ 4]  251 	ld	a,e
   411D 85            [ 4]  252 	add	a, l
   411E 02            [ 7]  253 	ld	(bc),a
                            254 ;src/main.c:70: movement =1;
   411F 0E 01         [ 7]  255 	ld	c,#0x01
   4121 18 28         [12]  256 	jr	00111$
   4123                     257 00104$:
                            258 ;src/main.c:72: else if(cpct_isKeyPressed(Key_CursorDown)){
   4123 C5            [11]  259 	push	bc
   4124 21 00 04      [10]  260 	ld	hl,#0x0400
   4127 CD A6 6A      [17]  261 	call	_cpct_isKeyPressed
   412A C1            [10]  262 	pop	bc
   412B 7D            [ 4]  263 	ld	a,l
   412C B7            [ 4]  264 	or	a, a
   412D 28 1C         [12]  265 	jr	Z,00111$
                            266 ;src/main.c:73: *(i8*)&(PLAYER_position.x) = PLAYER_position.x - PLAYER_direction.x;
   412F 21 AC 48      [10]  267 	ld	hl,#_PLAYER_position+0
   4132 4D            [ 4]  268 	ld	c, l
   4133 44            [ 4]  269 	ld	b, h
   4134 5E            [ 7]  270 	ld	e,(hl)
   4135 21 AE 48      [10]  271 	ld	hl, #_PLAYER_direction + 0
   4138 6E            [ 7]  272 	ld	l,(hl)
   4139 7B            [ 4]  273 	ld	a,e
   413A 95            [ 4]  274 	sub	a, l
   413B 02            [ 7]  275 	ld	(bc),a
                            276 ;src/main.c:74: *(i8*)&(PLAYER_position.y) = PLAYER_position.y - PLAYER_direction.y;
   413C 21 AD 48      [10]  277 	ld	hl,#_PLAYER_position+1
   413F 4D            [ 4]  278 	ld	c, l
   4140 44            [ 4]  279 	ld	b, h
   4141 5E            [ 7]  280 	ld	e,(hl)
   4142 21 AF 48      [10]  281 	ld	hl, #(_PLAYER_direction + 0x0001) + 0
   4145 6E            [ 7]  282 	ld	l,(hl)
   4146 7B            [ 4]  283 	ld	a,e
   4147 95            [ 4]  284 	sub	a, l
   4148 02            [ 7]  285 	ld	(bc),a
                            286 ;src/main.c:76: movement =1;
   4149 0E 01         [ 7]  287 	ld	c,#0x01
   414B                     288 00111$:
                            289 ;src/main.c:78: if(movement){
   414B 79            [ 4]  290 	ld	a,c
   414C B7            [ 4]  291 	or	a, a
   414D CA 7A 40      [10]  292 	jp	Z,00115$
                            293 ;src/main.c:79: render_draw_to_buffer();
   4150 CD 7B 4D      [17]  294 	call	_render_draw_to_buffer
                            295 ;src/main.c:80: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   4153 21 28 64      [10]  296 	ld	hl,#0x6428
   4156 E5            [11]  297 	push	hl
   4157 21 B4 C0      [10]  298 	ld	hl,#0xC0B4
   415A E5            [11]  299 	push	hl
   415B 21 40 29      [10]  300 	ld	hl,#0x2940
   415E E5            [11]  301 	push	hl
   415F CD 28 6B      [17]  302 	call	_cpct_drawSprite
                            303 ;src/main.c:81: renderCompass();
   4162 CD D7 5B      [17]  304 	call	_renderCompass
                            305 ;src/main.c:82: draw_minimap_to_buffer();
   4165 CD CA 58      [17]  306 	call	_draw_minimap_to_buffer
                            307 ;src/main.c:83: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   4168 21 10 40      [10]  308 	ld	hl,#0x4010
   416B E5            [11]  309 	push	hl
   416C 21 70 C5      [10]  310 	ld	hl,#0xC570
   416F E5            [11]  311 	push	hl
   4170 21 40 1C      [10]  312 	ld	hl,#0x1C40
   4173 E5            [11]  313 	push	hl
   4174 CD 28 6B      [17]  314 	call	_cpct_drawSprite
   4177 C3 7A 40      [10]  315 	jp	00115$
                            316 	.area _CODE
                            317 	.area _INITIALIZER
                            318 	.area _CABS (ABS)
