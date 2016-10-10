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
                             14 	.globl _level_init_palettes
                             15 	.globl _level_load_level
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
   4114                      64 _init::
                             65 ;src/main.c:29: cpct_disableFirmware();
   4114 CD D7 75      [17]   66 	call	_cpct_disableFirmware
                             67 ;src/main.c:30: cpct_setVideoMode(0);
   4117 2E 00         [ 7]   68 	ld	l,#0x00
   4119 CD B3 75      [17]   69 	call	_cpct_setVideoMode
                             70 ;src/main.c:31: cpct_fw2hw(g_palette,16);
   411C 21 10 00      [10]   71 	ld	hl,#0x0010
   411F E5            [11]   72 	push	hl
   4120 21 76 4B      [10]   73 	ld	hl,#_g_palette
   4123 E5            [11]   74 	push	hl
   4124 CD 0D 75      [17]   75 	call	_cpct_fw2hw
                             76 ;src/main.c:32: level_init_palettes();
   4127 CD 45 40      [17]   77 	call	_level_init_palettes
                             78 ;src/main.c:33: cpct_setPalette(g_palette,16);
   412A 21 10 00      [10]   79 	ld	hl,#0x0010
   412D E5            [11]   80 	push	hl
   412E 21 76 4B      [10]   81 	ld	hl,#_g_palette
   4131 E5            [11]   82 	push	hl
   4132 CD 29 74      [17]   83 	call	_cpct_setPalette
                             84 ;src/main.c:34: cpct_setBorder(g_palette[12]);
   4135 21 82 4B      [10]   85 	ld	hl, #_g_palette + 12
   4138 46            [ 7]   86 	ld	b,(hl)
   4139 C5            [11]   87 	push	bc
   413A 33            [ 6]   88 	inc	sp
   413B 3E 10         [ 7]   89 	ld	a,#0x10
   413D F5            [11]   90 	push	af
   413E 33            [ 6]   91 	inc	sp
   413F CD 40 74      [17]   92 	call	_cpct_setPALColour
                             93 ;src/main.c:36: cpct_memset(CPCT_VMEM_START, g_colors[12], 0x4000);
   4142 21 92 4B      [10]   94 	ld	hl, #(_g_colors + 0x000c) + 0
   4145 46            [ 7]   95 	ld	b,(hl)
   4146 21 00 40      [10]   96 	ld	hl,#0x4000
   4149 E5            [11]   97 	push	hl
   414A C5            [11]   98 	push	bc
   414B 33            [ 6]   99 	inc	sp
   414C 26 C0         [ 7]  100 	ld	h, #0xC0
   414E E5            [11]  101 	push	hl
   414F CD C1 75      [17]  102 	call	_cpct_memset
   4152 C9            [10]  103 	ret
                            104 ;src/main.c:39: void main(void) {
                            105 ;	---------------------------------
                            106 ; Function main
                            107 ; ---------------------------------
   4153                     108 _main::
   4153 DD E5         [15]  109 	push	ix
   4155 DD 21 00 00   [14]  110 	ld	ix,#0
   4159 DD 39         [15]  111 	add	ix,sp
   415B 3B            [ 6]  112 	dec	sp
                            113 ;src/main.c:40: init();
   415C CD 14 41      [17]  114 	call	_init
                            115 ;src/main.c:41: init_generator();
   415F CD C2 42      [17]  116 	call	_init_generator
                            117 ;src/main.c:42: level_load_level(0);
   4162 AF            [ 4]  118 	xor	a, a
   4163 F5            [11]  119 	push	af
   4164 33            [ 6]  120 	inc	sp
   4165 CD C9 40      [17]  121 	call	_level_load_level
   4168 33            [ 6]  122 	inc	sp
                            123 ;src/main.c:43: generate_level();
   4169 CD AE 49      [17]  124 	call	_generate_level
                            125 ;src/main.c:44: render_draw_to_buffer();
   416C CD 8F 4E      [17]  126 	call	_render_draw_to_buffer
                            127 ;src/main.c:45: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   416F 21 28 64      [10]  128 	ld	hl,#0x6428
   4172 E5            [11]  129 	push	hl
   4173 21 B4 C0      [10]  130 	ld	hl,#0xC0B4
   4176 E5            [11]  131 	push	hl
   4177 21 40 29      [10]  132 	ld	hl,#0x2940
   417A E5            [11]  133 	push	hl
   417B CD 4C 74      [17]  134 	call	_cpct_drawSprite
                            135 ;src/main.c:46: renderCompass();
   417E CD F3 5C      [17]  136 	call	_renderCompass
                            137 ;src/main.c:47: draw_minimap_to_buffer();
   4181 CD E9 59      [17]  138 	call	_draw_minimap_to_buffer
                            139 ;src/main.c:48: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   4184 21 10 40      [10]  140 	ld	hl,#0x4010
   4187 E5            [11]  141 	push	hl
   4188 21 70 C5      [10]  142 	ld	hl,#0xC570
   418B E5            [11]  143 	push	hl
   418C 21 40 1C      [10]  144 	ld	hl,#0x1C40
   418F E5            [11]  145 	push	hl
   4190 CD 4C 74      [17]  146 	call	_cpct_drawSprite
                            147 ;src/main.c:51: while(1) {
   4193                     148 00121$:
                            149 ;src/main.c:52: u8 movement = 0;
   4193 DD 36 FF 00   [19]  150 	ld	-1 (ix),#0x00
                            151 ;src/main.c:53: cpct_scanKeyboard_f();
   4197 CD BF 73      [17]  152 	call	_cpct_scanKeyboard_f
                            153 ;src/main.c:54: if(cpct_isKeyPressed(Key_CursorLeft)){
   419A 21 01 01      [10]  154 	ld	hl,#0x0101
   419D CD B3 73      [17]  155 	call	_cpct_isKeyPressed
   41A0 7D            [ 4]  156 	ld	a, l
   41A1 B7            [ 4]  157 	or	a, a
   41A2 28 32         [12]  158 	jr	Z,00116$
                            159 ;src/main.c:55: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex+2)&7;
   41A4 01 BE 49      [10]  160 	ld	bc,#_PLAYER_directionIndex+0
   41A7 3A BE 49      [13]  161 	ld	a,(#_PLAYER_directionIndex + 0)
   41AA C6 02         [ 7]  162 	add	a, #0x02
   41AC E6 07         [ 7]  163 	and	a, #0x07
   41AE 02            [ 7]  164 	ld	(bc),a
                            165 ;src/main.c:56: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   41AF 01 BF 49      [10]  166 	ld	bc,#_PLAYER_directionArray+0
   41B2 FD 21 BE 49   [14]  167 	ld	iy,#_PLAYER_directionIndex
   41B6 FD 6E 00      [19]  168 	ld	l, 0 (iy)
   41B9 26 00         [ 7]  169 	ld	h,#0x00
   41BB 09            [11]  170 	add	hl,bc
   41BC 5E            [ 7]  171 	ld	e,(hl)
   41BD 21 BC 49      [10]  172 	ld	hl,#_PLAYER_direction
   41C0 73            [ 7]  173 	ld	(hl),e
                            174 ;src/main.c:57: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   41C1 21 BE 49      [10]  175 	ld	hl,#_PLAYER_directionIndex + 0
   41C4 5E            [ 7]  176 	ld	e, (hl)
   41C5 1C            [ 4]  177 	inc	e
   41C6 6B            [ 4]  178 	ld	l,e
   41C7 26 00         [ 7]  179 	ld	h,#0x00
   41C9 09            [11]  180 	add	hl,bc
   41CA 4E            [ 7]  181 	ld	c,(hl)
   41CB 21 BD 49      [10]  182 	ld	hl,#(_PLAYER_direction + 0x0001)
   41CE 71            [ 7]  183 	ld	(hl),c
                            184 ;src/main.c:58: movement =1;
   41CF DD 36 FF 01   [19]  185 	ld	-1 (ix),#0x01
   41D3 C3 8D 42      [10]  186 	jp	00117$
   41D6                     187 00116$:
                            188 ;src/main.c:60: else if(cpct_isKeyPressed(Key_CursorRight)){
   41D6 21 00 02      [10]  189 	ld	hl,#0x0200
   41D9 CD B3 73      [17]  190 	call	_cpct_isKeyPressed
   41DC 7D            [ 4]  191 	ld	a,l
   41DD B7            [ 4]  192 	or	a, a
   41DE 28 34         [12]  193 	jr	Z,00113$
                            194 ;src/main.c:61: *(u8*)&(PLAYER_directionIndex)=(PLAYER_directionIndex-2)&7;
   41E0 01 BE 49      [10]  195 	ld	bc,#_PLAYER_directionIndex+0
   41E3 3A BE 49      [13]  196 	ld	a,(#_PLAYER_directionIndex + 0)
   41E6 C6 FE         [ 7]  197 	add	a,#0xFE
   41E8 E6 07         [ 7]  198 	and	a, #0x07
   41EA 02            [ 7]  199 	ld	(bc),a
                            200 ;src/main.c:62: *(i8*)&(PLAYER_direction.x) = PLAYER_directionArray[(PLAYER_directionIndex)];
   41EB 01 BC 49      [10]  201 	ld	bc,#_PLAYER_direction+0
   41EE 11 BF 49      [10]  202 	ld	de,#_PLAYER_directionArray+0
   41F1 FD 21 BE 49   [14]  203 	ld	iy,#_PLAYER_directionIndex
   41F5 FD 6E 00      [19]  204 	ld	l,0 (iy)
   41F8 26 00         [ 7]  205 	ld	h,#0x00
   41FA 19            [11]  206 	add	hl,de
   41FB 7E            [ 7]  207 	ld	a,(hl)
   41FC 02            [ 7]  208 	ld	(bc),a
                            209 ;src/main.c:63: *(i8*)&(PLAYER_direction.y) = PLAYER_directionArray[((PLAYER_directionIndex)+1)];
   41FD 01 BD 49      [10]  210 	ld	bc,#_PLAYER_direction+1
   4200 FD 21 BE 49   [14]  211 	ld	iy,#_PLAYER_directionIndex
   4204 FD 6E 00      [19]  212 	ld	l,0 (iy)
   4207 2C            [ 4]  213 	inc	l
   4208 26 00         [ 7]  214 	ld	h,#0x00
   420A 19            [11]  215 	add	hl,de
   420B 7E            [ 7]  216 	ld	a,(hl)
   420C 02            [ 7]  217 	ld	(bc),a
                            218 ;src/main.c:64: movement =1;
   420D DD 36 FF 01   [19]  219 	ld	-1 (ix),#0x01
   4211 C3 8D 42      [10]  220 	jp	00117$
   4214                     221 00113$:
                            222 ;src/main.c:66: else if(cpct_isKeyPressed(Key_CursorUp)){
   4214 21 00 01      [10]  223 	ld	hl,#0x0100
   4217 CD B3 73      [17]  224 	call	_cpct_isKeyPressed
   421A 7D            [ 4]  225 	ld	a,l
   421B B7            [ 4]  226 	or	a, a
   421C 28 20         [12]  227 	jr	Z,00110$
                            228 ;src/main.c:67: *(i8*)&(PLAYER_position.x) = PLAYER_position.x + PLAYER_direction.x;
   421E 21 BA 49      [10]  229 	ld	hl,#_PLAYER_position+0
   4221 4D            [ 4]  230 	ld	c, l
   4222 44            [ 4]  231 	ld	b, h
   4223 5E            [ 7]  232 	ld	e,(hl)
   4224 21 BC 49      [10]  233 	ld	hl, #_PLAYER_direction + 0
   4227 6E            [ 7]  234 	ld	l,(hl)
   4228 7B            [ 4]  235 	ld	a,e
   4229 85            [ 4]  236 	add	a, l
   422A 02            [ 7]  237 	ld	(bc),a
                            238 ;src/main.c:68: *(i8*)&(PLAYER_position.y) = PLAYER_position.y + PLAYER_direction.y;
   422B 21 BB 49      [10]  239 	ld	hl,#_PLAYER_position+1
   422E 4D            [ 4]  240 	ld	c, l
   422F 44            [ 4]  241 	ld	b, h
   4230 5E            [ 7]  242 	ld	e,(hl)
   4231 21 BD 49      [10]  243 	ld	hl, #(_PLAYER_direction + 0x0001) + 0
   4234 6E            [ 7]  244 	ld	l,(hl)
   4235 7B            [ 4]  245 	ld	a,e
   4236 85            [ 4]  246 	add	a, l
   4237 02            [ 7]  247 	ld	(bc),a
                            248 ;src/main.c:70: movement =1;
   4238 DD 36 FF 01   [19]  249 	ld	-1 (ix),#0x01
   423C 18 4F         [12]  250 	jr	00117$
   423E                     251 00110$:
                            252 ;src/main.c:72: else if(cpct_isKeyPressed(Key_CursorDown)){
   423E 21 00 04      [10]  253 	ld	hl,#0x0400
   4241 CD B3 73      [17]  254 	call	_cpct_isKeyPressed
   4244 7D            [ 4]  255 	ld	a,l
   4245 B7            [ 4]  256 	or	a, a
   4246 28 20         [12]  257 	jr	Z,00107$
                            258 ;src/main.c:73: *(i8*)&(PLAYER_position.x) = PLAYER_position.x - PLAYER_direction.x;
   4248 21 BA 49      [10]  259 	ld	hl,#_PLAYER_position+0
   424B 4D            [ 4]  260 	ld	c, l
   424C 44            [ 4]  261 	ld	b, h
   424D 5E            [ 7]  262 	ld	e,(hl)
   424E 21 BC 49      [10]  263 	ld	hl, #_PLAYER_direction + 0
   4251 6E            [ 7]  264 	ld	l,(hl)
   4252 7B            [ 4]  265 	ld	a,e
   4253 95            [ 4]  266 	sub	a, l
   4254 02            [ 7]  267 	ld	(bc),a
                            268 ;src/main.c:74: *(i8*)&(PLAYER_position.y) = PLAYER_position.y - PLAYER_direction.y;
   4255 21 BB 49      [10]  269 	ld	hl,#_PLAYER_position+1
   4258 4D            [ 4]  270 	ld	c, l
   4259 44            [ 4]  271 	ld	b, h
   425A 5E            [ 7]  272 	ld	e,(hl)
   425B 21 BD 49      [10]  273 	ld	hl, #(_PLAYER_direction + 0x0001) + 0
   425E 6E            [ 7]  274 	ld	l,(hl)
   425F 7B            [ 4]  275 	ld	a,e
   4260 95            [ 4]  276 	sub	a, l
   4261 02            [ 7]  277 	ld	(bc),a
                            278 ;src/main.c:76: movement =1;
   4262 DD 36 FF 01   [19]  279 	ld	-1 (ix),#0x01
   4266 18 25         [12]  280 	jr	00117$
   4268                     281 00107$:
                            282 ;src/main.c:78: else if(cpct_isKeyPressed(Key_0)){
   4268 21 04 01      [10]  283 	ld	hl,#0x0104
   426B CD B3 73      [17]  284 	call	_cpct_isKeyPressed
   426E 7D            [ 4]  285 	ld	a,l
   426F B7            [ 4]  286 	or	a, a
   4270 28 09         [12]  287 	jr	Z,00104$
                            288 ;src/main.c:79: level_load_level(0);
   4272 AF            [ 4]  289 	xor	a, a
   4273 F5            [11]  290 	push	af
   4274 33            [ 6]  291 	inc	sp
   4275 CD C9 40      [17]  292 	call	_level_load_level
   4278 33            [ 6]  293 	inc	sp
   4279 18 12         [12]  294 	jr	00117$
   427B                     295 00104$:
                            296 ;src/main.c:81: else if(cpct_isKeyPressed(Key_1)){ 
   427B 21 08 01      [10]  297 	ld	hl,#0x0108
   427E CD B3 73      [17]  298 	call	_cpct_isKeyPressed
   4281 7D            [ 4]  299 	ld	a,l
   4282 B7            [ 4]  300 	or	a, a
   4283 28 08         [12]  301 	jr	Z,00117$
                            302 ;src/main.c:82: level_load_level(9);
   4285 3E 09         [ 7]  303 	ld	a,#0x09
   4287 F5            [11]  304 	push	af
   4288 33            [ 6]  305 	inc	sp
   4289 CD C9 40      [17]  306 	call	_level_load_level
   428C 33            [ 6]  307 	inc	sp
   428D                     308 00117$:
                            309 ;src/main.c:84: if(movement){
   428D DD 7E FF      [19]  310 	ld	a,-1 (ix)
   4290 B7            [ 4]  311 	or	a, a
   4291 CA 93 41      [10]  312 	jp	Z,00121$
                            313 ;src/main.c:85: render_draw_to_buffer();
   4294 CD 8F 4E      [17]  314 	call	_render_draw_to_buffer
                            315 ;src/main.c:86: cpct_drawSprite(SCREEN_TEXTURE_BUFFER,SCREEN_TEXTURE_POSITION,SCREEN_TEXTURE_WIDTH_BYTES,SCREEN_TEXTURE_HEIGHT);
   4297 21 28 64      [10]  316 	ld	hl,#0x6428
   429A E5            [11]  317 	push	hl
   429B 21 B4 C0      [10]  318 	ld	hl,#0xC0B4
   429E E5            [11]  319 	push	hl
   429F 21 40 29      [10]  320 	ld	hl,#0x2940
   42A2 E5            [11]  321 	push	hl
   42A3 CD 4C 74      [17]  322 	call	_cpct_drawSprite
                            323 ;src/main.c:87: renderCompass();
   42A6 CD F3 5C      [17]  324 	call	_renderCompass
                            325 ;src/main.c:88: draw_minimap_to_buffer();
   42A9 CD E9 59      [17]  326 	call	_draw_minimap_to_buffer
                            327 ;src/main.c:89: cpct_drawSprite(MINIMAP_BUFFER,MINIMAP_POSITION,MINIMAP_WIDTH_BYTES,MINIMAP_HEIGHT_BYTES);
   42AC 21 10 40      [10]  328 	ld	hl,#0x4010
   42AF E5            [11]  329 	push	hl
   42B0 21 70 C5      [10]  330 	ld	hl,#0xC570
   42B3 E5            [11]  331 	push	hl
   42B4 21 40 1C      [10]  332 	ld	hl,#0x1C40
   42B7 E5            [11]  333 	push	hl
   42B8 CD 4C 74      [17]  334 	call	_cpct_drawSprite
   42BB C3 93 41      [10]  335 	jp	00121$
   42BE 33            [ 6]  336 	inc	sp
   42BF DD E1         [14]  337 	pop	ix
   42C1 C9            [10]  338 	ret
                            339 	.area _CODE
                            340 	.area _INITIALIZER
                            341 	.area _CABS (ABS)
