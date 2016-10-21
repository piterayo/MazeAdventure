                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Renderer
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _draw_column_to_buffer
                             12 	.globl _draw_column_to_buffer_enemy
                             13 	.globl _draw_column_to_buffer_object
                             14 	.globl _draw_column_to_buffer_untextured
                             15 	.globl _calculate_cells_in_view
                             16 	.globl _enemy_get_at
                             17 	.globl _cpct_memset
                             18 	.globl _offsets_cells_in_view
                             19 	.globl _cells_in_view_array
                             20 	.globl _g_texturedWalls
                             21 	.globl _g_pixelMask
                             22 	.globl _g_colors
                             23 	.globl _g_palette
                             24 	.globl _render_draw_to_buffer
                             25 	.globl _draw_minimap_to_buffer
                             26 ;--------------------------------------------------------
                             27 ; special function registers
                             28 ;--------------------------------------------------------
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _DATA
                             33 ;--------------------------------------------------------
                             34 ; ram data
                             35 ;--------------------------------------------------------
                             36 	.area _INITIALIZED
                             37 ;--------------------------------------------------------
                             38 ; absolute external ram data
                             39 ;--------------------------------------------------------
                             40 	.area _DABS (ABS)
                             41 ;--------------------------------------------------------
                             42 ; global & static initialisations
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _GSINIT
                             46 	.area _GSFINAL
                             47 	.area _GSINIT
                             48 ;--------------------------------------------------------
                             49 ; Home
                             50 ;--------------------------------------------------------
                             51 	.area _HOME
                             52 	.area _HOME
                             53 ;--------------------------------------------------------
                             54 ; code
                             55 ;--------------------------------------------------------
                             56 	.area _CODE
                             57 ;src/Renderer.c:51: void calculate_cells_in_view(){
                             58 ;	---------------------------------
                             59 ; Function calculate_cells_in_view
                             60 ; ---------------------------------
   0EAA                      61 _calculate_cells_in_view::
   0EAA DD E5         [15]   62 	push	ix
   0EAC DD 21 00 00   [14]   63 	ld	ix,#0
   0EB0 DD 39         [15]   64 	add	ix,sp
   0EB2 21 F2 FF      [10]   65 	ld	hl,#-14
   0EB5 39            [11]   66 	add	hl,sp
   0EB6 F9            [ 6]   67 	ld	sp,hl
                             68 ;src/Renderer.c:53: u8 offset=0, n=0, j, i;
   0EB7 DD 36 FA 00   [19]   69 	ld	-6 (ix),#0x00
   0EBB DD 36 F9 00   [19]   70 	ld	-7 (ix),#0x00
                             71 ;src/Renderer.c:56: if(player_direction.y!=0){
   0EBF 21 5D 0E      [10]   72 	ld	hl, #_player_direction + 1
   0EC2 7E            [ 7]   73 	ld	a,(hl)
   0EC3 DD 77 FC      [19]   74 	ld	-4 (ix), a
   0EC6 B7            [ 4]   75 	or	a, a
   0EC7 28 32         [12]   76 	jr	Z,00102$
                             77 ;src/Renderer.c:57: vert=1;
   0EC9 DD 36 F2 01   [19]   78 	ld	-14 (ix),#0x01
                             79 ;src/Renderer.c:58: dy=player_direction.y;
   0ECD DD 4E FC      [19]   80 	ld	c,-4 (ix)
   0ED0 DD 71 F4      [19]   81 	ld	-12 (ix),c
                             82 ;src/Renderer.c:59: dx=-player_direction.y;
   0ED3 AF            [ 4]   83 	xor	a, a
   0ED4 DD 96 FC      [19]   84 	sub	a, -4 (ix)
   0ED7 DD 77 F5      [19]   85 	ld	-11 (ix), a
                             86 ;src/Renderer.c:61: x0 = player_position.x-(17*dx);
   0EDA 21 5A 0E      [10]   87 	ld	hl,#_player_position+0
   0EDD 4E            [ 7]   88 	ld	c,(hl)
   0EDE DD 6E F5      [19]   89 	ld	l,-11 (ix)
   0EE1 5D            [ 4]   90 	ld	e,l
   0EE2 29            [11]   91 	add	hl, hl
   0EE3 29            [11]   92 	add	hl, hl
   0EE4 29            [11]   93 	add	hl, hl
   0EE5 29            [11]   94 	add	hl, hl
   0EE6 19            [11]   95 	add	hl, de
   0EE7 79            [ 4]   96 	ld	a,c
   0EE8 95            [ 4]   97 	sub	a, l
   0EE9 DD 77 F6      [19]   98 	ld	-10 (ix),a
                             99 ;src/Renderer.c:62: y0 = player_position.y+(6*dy);
   0EEC 21 5B 0E      [10]  100 	ld	hl,#_player_position+1
   0EEF 4E            [ 7]  101 	ld	c,(hl)
   0EF0 DD 6E F4      [19]  102 	ld	l,-12 (ix)
   0EF3 5D            [ 4]  103 	ld	e,l
   0EF4 29            [11]  104 	add	hl, hl
   0EF5 19            [11]  105 	add	hl, de
   0EF6 29            [11]  106 	add	hl, hl
   0EF7 09            [11]  107 	add	hl, bc
   0EF8 4D            [ 4]  108 	ld	c,l
   0EF9 18 35         [12]  109 	jr	00103$
   0EFB                     110 00102$:
                            111 ;src/Renderer.c:65: vert=0;
   0EFB DD 36 F2 00   [19]  112 	ld	-14 (ix),#0x00
                            113 ;src/Renderer.c:66: dy=player_direction.x;
   0EFF 21 5C 0E      [10]  114 	ld	hl, #_player_direction + 0
   0F02 7E            [ 7]  115 	ld	a,(hl)
   0F03 DD 77 FC      [19]  116 	ld	-4 (ix), a
   0F06 DD 77 F4      [19]  117 	ld	-12 (ix),a
                            118 ;src/Renderer.c:67: dx=player_direction.x;
   0F09 DD 7E FC      [19]  119 	ld	a,-4 (ix)
   0F0C DD 77 F5      [19]  120 	ld	-11 (ix),a
                            121 ;src/Renderer.c:69: y0 = player_position.y-(17*dy);
   0F0F 21 5B 0E      [10]  122 	ld	hl, #_player_position + 1
   0F12 4E            [ 7]  123 	ld	c,(hl)
   0F13 DD 6E F4      [19]  124 	ld	l,-12 (ix)
   0F16 5D            [ 4]  125 	ld	e,l
   0F17 29            [11]  126 	add	hl, hl
   0F18 29            [11]  127 	add	hl, hl
   0F19 29            [11]  128 	add	hl, hl
   0F1A 29            [11]  129 	add	hl, hl
   0F1B 19            [11]  130 	add	hl, de
   0F1C 79            [ 4]  131 	ld	a,c
   0F1D 95            [ 4]  132 	sub	a, l
   0F1E 4F            [ 4]  133 	ld	c,a
                            134 ;src/Renderer.c:70: x0 = player_position.x+(6*dx);
   0F1F 21 5A 0E      [10]  135 	ld	hl, #_player_position + 0
   0F22 46            [ 7]  136 	ld	b,(hl)
   0F23 DD 7E FC      [19]  137 	ld	a,-4 (ix)
   0F26 5F            [ 4]  138 	ld	e,a
   0F27 87            [ 4]  139 	add	a, a
   0F28 83            [ 4]  140 	add	a, e
   0F29 87            [ 4]  141 	add	a, a
   0F2A 5F            [ 4]  142 	ld	e,a
   0F2B 68            [ 4]  143 	ld	l,b
   0F2C 19            [11]  144 	add	hl, de
   0F2D DD 75 F6      [19]  145 	ld	-10 (ix),l
   0F30                     146 00103$:
                            147 ;src/Renderer.c:74: x=x0;
   0F30 DD 5E F6      [19]  148 	ld	e,-10 (ix)
                            149 ;src/Renderer.c:75: y=y0;
   0F33 DD 71 F3      [19]  150 	ld	-13 (ix),c
                            151 ;src/Renderer.c:77: for(j=0;j<6;++j){
   0F36 DD 7E F5      [19]  152 	ld	a,-11 (ix)
   0F39 07            [ 4]  153 	rlca
   0F3A E6 01         [ 7]  154 	and	a,#0x01
   0F3C DD 77 FC      [19]  155 	ld	-4 (ix),a
   0F3F DD 7E F4      [19]  156 	ld	a,-12 (ix)
   0F42 07            [ 4]  157 	rlca
   0F43 E6 01         [ 7]  158 	and	a,#0x01
   0F45 DD 77 FF      [19]  159 	ld	-1 (ix),a
   0F48 DD 36 F8 00   [19]  160 	ld	-8 (ix),#0x00
                            161 ;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
   0F4C                     162 00138$:
   0F4C DD 7E F9      [19]  163 	ld	a,-7 (ix)
   0F4F DD 77 FB      [19]  164 	ld	-5 (ix),a
   0F52 DD 7E FA      [19]  165 	ld	a,-6 (ix)
   0F55 DD 77 F7      [19]  166 	ld	-9 (ix),a
   0F58                     167 00125$:
   0F58 DD 6E FA      [19]  168 	ld	l,-6 (ix)
   0F5B 26 00         [ 7]  169 	ld	h,#0x00
   0F5D 3E 23         [ 7]  170 	ld	a,#0x23
   0F5F 95            [ 4]  171 	sub	a, l
   0F60 6F            [ 4]  172 	ld	l,a
   0F61 3E 00         [ 7]  173 	ld	a,#0x00
   0F63 9C            [ 4]  174 	sbc	a, h
   0F64 67            [ 4]  175 	ld	h,a
   0F65 DD 7E F7      [19]  176 	ld	a, -9 (ix)
   0F68 16 00         [ 7]  177 	ld	d, #0x00
   0F6A 95            [ 4]  178 	sub	a, l
   0F6B 7A            [ 4]  179 	ld	a,d
   0F6C 9C            [ 4]  180 	sbc	a, h
   0F6D E2 72 0F      [10]  181 	jp	PO, 00181$
   0F70 EE 80         [ 7]  182 	xor	a, #0x80
   0F72                     183 00181$:
   0F72 F2 EC 0F      [10]  184 	jp	P,00143$
                            185 ;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   0F75 2A 79 10      [16]  186 	ld	hl,(_cells_in_view_array)
   0F78 7D            [ 4]  187 	ld	a,l
   0F79 DD 86 FB      [19]  188 	add	a, -5 (ix)
   0F7C DD 77 FD      [19]  189 	ld	-3 (ix),a
   0F7F 7C            [ 4]  190 	ld	a,h
   0F80 CE 00         [ 7]  191 	adc	a, #0x00
   0F82 DD 77 FE      [19]  192 	ld	-2 (ix),a
                            193 ;src/Renderer.c:81: if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
   0F85 CB 7B         [ 8]  194 	bit	7, e
   0F87 20 3C         [12]  195 	jr	NZ,00105$
   0F89 7B            [ 4]  196 	ld	a,e
   0F8A EE 80         [ 7]  197 	xor	a, #0x80
   0F8C D6 A0         [ 7]  198 	sub	a, #0xA0
   0F8E 30 35         [12]  199 	jr	NC,00105$
   0F90 DD CB F3 7E   [20]  200 	bit	7, -13 (ix)
   0F94 20 2F         [12]  201 	jr	NZ,00105$
   0F96 DD 7E F3      [19]  202 	ld	a,-13 (ix)
   0F99 EE 80         [ 7]  203 	xor	a, #0x80
   0F9B D6 A0         [ 7]  204 	sub	a, #0xA0
   0F9D 30 26         [12]  205 	jr	NC,00105$
                            206 ;src/Renderer.c:82: cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
   0F9F 7B            [ 4]  207 	ld	a,e
   0FA0 57            [ 4]  208 	ld	d,a
   0FA1 17            [ 4]  209 	rla
   0FA2 9F            [ 4]  210 	sbc	a, a
   0FA3 42            [ 4]  211 	ld	b, d
   0FA4 C6 70         [ 7]  212 	add	a,#0x70
   0FA6 57            [ 4]  213 	ld	d,a
   0FA7 DD 6E F3      [19]  214 	ld	l,-13 (ix)
   0FAA DD 7E F3      [19]  215 	ld	a,-13 (ix)
   0FAD 17            [ 4]  216 	rla
   0FAE 9F            [ 4]  217 	sbc	a, a
   0FAF 67            [ 4]  218 	ld	h,a
   0FB0 29            [11]  219 	add	hl, hl
   0FB1 29            [11]  220 	add	hl, hl
   0FB2 29            [11]  221 	add	hl, hl
   0FB3 29            [11]  222 	add	hl, hl
   0FB4 29            [11]  223 	add	hl, hl
   0FB5 78            [ 4]  224 	ld	a,b
   0FB6 85            [ 4]  225 	add	a, l
   0FB7 6F            [ 4]  226 	ld	l,a
   0FB8 7A            [ 4]  227 	ld	a,d
   0FB9 8C            [ 4]  228 	adc	a, h
   0FBA 67            [ 4]  229 	ld	h,a
   0FBB 46            [ 7]  230 	ld	b,(hl)
   0FBC DD 6E FD      [19]  231 	ld	l,-3 (ix)
   0FBF DD 66 FE      [19]  232 	ld	h,-2 (ix)
   0FC2 70            [ 7]  233 	ld	(hl),b
   0FC3 18 08         [12]  234 	jr	00106$
   0FC5                     235 00105$:
                            236 ;src/Renderer.c:85: cells_in_view_array[n]=CELLTYPE_WALL1;
   0FC5 DD 6E FD      [19]  237 	ld	l,-3 (ix)
   0FC8 DD 66 FE      [19]  238 	ld	h,-2 (ix)
   0FCB 36 81         [10]  239 	ld	(hl),#0x81
   0FCD                     240 00106$:
                            241 ;src/Renderer.c:89: if(vert){
   0FCD DD 7E F2      [19]  242 	ld	a,-14 (ix)
   0FD0 B7            [ 4]  243 	or	a, a
   0FD1 28 07         [12]  244 	jr	Z,00111$
                            245 ;src/Renderer.c:90: x+=dx;
   0FD3 7B            [ 4]  246 	ld	a,e
   0FD4 DD 86 F5      [19]  247 	add	a, -11 (ix)
   0FD7 5F            [ 4]  248 	ld	e,a
   0FD8 18 09         [12]  249 	jr	00112$
   0FDA                     250 00111$:
                            251 ;src/Renderer.c:93: y+=dy;
   0FDA DD 7E F3      [19]  252 	ld	a,-13 (ix)
   0FDD DD 86 F4      [19]  253 	add	a, -12 (ix)
   0FE0 DD 77 F3      [19]  254 	ld	-13 (ix),a
   0FE3                     255 00112$:
                            256 ;src/Renderer.c:95: ++n;
   0FE3 DD 34 FB      [23]  257 	inc	-5 (ix)
                            258 ;src/Renderer.c:79: for(i=offset;i<35-offset;++i){
   0FE6 DD 34 F7      [23]  259 	inc	-9 (ix)
   0FE9 C3 58 0F      [10]  260 	jp	00125$
   0FEC                     261 00143$:
   0FEC DD 7E FB      [19]  262 	ld	a,-5 (ix)
   0FEF DD 77 F9      [19]  263 	ld	-7 (ix),a
                            264 ;src/Renderer.c:97: offset=offsets_cells_in_view[j];
   0FF2 3E 7B         [ 7]  265 	ld	a,#<(_offsets_cells_in_view)
   0FF4 DD 86 F8      [19]  266 	add	a, -8 (ix)
   0FF7 6F            [ 4]  267 	ld	l,a
   0FF8 3E 10         [ 7]  268 	ld	a,#>(_offsets_cells_in_view)
   0FFA CE 00         [ 7]  269 	adc	a, #0x00
   0FFC 67            [ 4]  270 	ld	h,a
   0FFD 7E            [ 7]  271 	ld	a,(hl)
                            272 ;src/Renderer.c:101: if(dx<0) x=x0-offset;
   0FFE DD 77 FA      [19]  273 	ld	-6 (ix), a
   1001 DD 77 FD      [19]  274 	ld	-3 (ix),a
                            275 ;src/Renderer.c:99: if(vert){
   1004 DD 7E F2      [19]  276 	ld	a,-14 (ix)
   1007 B7            [ 4]  277 	or	a, a
   1008 28 21         [12]  278 	jr	Z,00121$
                            279 ;src/Renderer.c:100: y-=dy;
   100A DD 7E F3      [19]  280 	ld	a,-13 (ix)
   100D DD 96 F4      [19]  281 	sub	a, -12 (ix)
   1010 DD 77 F3      [19]  282 	ld	-13 (ix),a
                            283 ;src/Renderer.c:101: if(dx<0) x=x0-offset;
   1013 DD 7E FC      [19]  284 	ld	a,-4 (ix)
   1016 B7            [ 4]  285 	or	a, a
   1017 28 09         [12]  286 	jr	Z,00115$
   1019 DD 7E F6      [19]  287 	ld	a,-10 (ix)
   101C DD 96 FD      [19]  288 	sub	a, -3 (ix)
   101F 5F            [ 4]  289 	ld	e,a
   1020 18 24         [12]  290 	jr	00128$
   1022                     291 00115$:
                            292 ;src/Renderer.c:102: else x=x0+offset;
   1022 DD 7E F6      [19]  293 	ld	a,-10 (ix)
   1025 DD 86 FD      [19]  294 	add	a, -3 (ix)
   1028 5F            [ 4]  295 	ld	e,a
   1029 18 1B         [12]  296 	jr	00128$
   102B                     297 00121$:
                            298 ;src/Renderer.c:106: x-=dx;
   102B 7B            [ 4]  299 	ld	a,e
   102C DD 96 F5      [19]  300 	sub	a, -11 (ix)
   102F 5F            [ 4]  301 	ld	e,a
                            302 ;src/Renderer.c:107: if(dy<0) y=y0-offset;
   1030 DD 7E FF      [19]  303 	ld	a,-1 (ix)
   1033 B7            [ 4]  304 	or	a, a
   1034 28 09         [12]  305 	jr	Z,00118$
   1036 79            [ 4]  306 	ld	a,c
   1037 DD 96 FD      [19]  307 	sub	a, -3 (ix)
   103A DD 77 F3      [19]  308 	ld	-13 (ix),a
   103D 18 07         [12]  309 	jr	00128$
   103F                     310 00118$:
                            311 ;src/Renderer.c:108: else y=y0+offset;
   103F 79            [ 4]  312 	ld	a,c
   1040 DD 86 FD      [19]  313 	add	a, -3 (ix)
   1043 DD 77 F3      [19]  314 	ld	-13 (ix),a
   1046                     315 00128$:
                            316 ;src/Renderer.c:77: for(j=0;j<6;++j){
   1046 DD 34 F8      [23]  317 	inc	-8 (ix)
   1049 DD 7E F8      [19]  318 	ld	a,-8 (ix)
   104C D6 06         [ 7]  319 	sub	a, #0x06
   104E DA 4C 0F      [10]  320 	jp	C,00138$
   1051 DD F9         [10]  321 	ld	sp, ix
   1053 DD E1         [14]  322 	pop	ix
   1055 C9            [10]  323 	ret
   1056                     324 _g_palette:
   1056 08                  325 	.db #0x08	; 8
   1057 00                  326 	.db #0x00	; 0
   1058 0D                  327 	.db #0x0D	; 13
   1059 1A                  328 	.db #0x1A	; 26
   105A 06                  329 	.db #0x06	; 6
   105B 09                  330 	.db #0x09	; 9
   105C 0F                  331 	.db #0x0F	; 15
   105D 00                  332 	.db #0x00	; 0
   105E 00                  333 	.db #0x00	; 0
   105F 00                  334 	.db #0x00	; 0
   1060 00                  335 	.db #0x00	; 0
   1061 00                  336 	.db #0x00	; 0
   1062 00                  337 	.db #0x00	; 0
   1063 00                  338 	.db #0x00	; 0
   1064 00                  339 	.db #0x00	; 0
   1065 00                  340 	.db #0x00	; 0
   1066                     341 _g_colors:
   1066 00                  342 	.db #0x00	; 0
   1067 C0                  343 	.db #0xC0	; 192
   1068 0C                  344 	.db #0x0C	; 12
   1069 CC                  345 	.db #0xCC	; 204
   106A 30                  346 	.db #0x30	; 48	'0'
   106B F0                  347 	.db #0xF0	; 240
   106C 3C                  348 	.db #0x3C	; 60
   106D FC                  349 	.db #0xFC	; 252
   106E 03                  350 	.db #0x03	; 3
   106F C3                  351 	.db #0xC3	; 195
   1070 0F                  352 	.db #0x0F	; 15
   1071 CF                  353 	.db #0xCF	; 207
   1072 33                  354 	.db #0x33	; 51	'3'
   1073 F3                  355 	.db #0xF3	; 243
   1074 3F                  356 	.db #0x3F	; 63
   1075 FF                  357 	.db #0xFF	; 255
   1076                     358 _g_pixelMask:
   1076 AA                  359 	.db #0xAA	; 170
   1077 55                  360 	.db #0x55	; 85	'U'
   1078                     361 _g_texturedWalls:
   1078 01                  362 	.db #0x01	; 1
   1079                     363 _cells_in_view_array:
   1079 A0 AE               364 	.dw #0xAEA0
   107B                     365 _offsets_cells_in_view:
   107B 08                  366 	.db #0x08	; 8
   107C 0C                  367 	.db #0x0C	; 12
   107D 0E                  368 	.db #0x0E	; 14
   107E 0F                  369 	.db #0x0F	; 15
   107F 10                  370 	.db #0x10	; 16
                            371 ;src/Renderer.c:116: void draw_column_to_buffer_untextured(const u8 column, u8 lineHeight, u8 wall_color){
                            372 ;	---------------------------------
                            373 ; Function draw_column_to_buffer_untextured
                            374 ; ---------------------------------
   1080                     375 _draw_column_to_buffer_untextured::
   1080 DD E5         [15]  376 	push	ix
   1082 DD 21 00 00   [14]  377 	ld	ix,#0
   1086 DD 39         [15]  378 	add	ix,sp
   1088 F5            [11]  379 	push	af
                            380 ;src/Renderer.c:117: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1089 DD 7E 04      [19]  381 	ld	a, 4 (ix)
   108C CB 3F         [ 8]  382 	srl	a
   108E 4F            [ 4]  383 	ld	c,a
   108F 3E 00         [ 7]  384 	ld	a,#0x00
   1091 C6 9B         [ 7]  385 	add	a,#0x9B
   1093 47            [ 4]  386 	ld	b,a
                            387 ;src/Renderer.c:119: u8 w_color = g_colors[wall_color];//, start=0,end=SCREEN_TEXTURE_HEIGHT;
   1094 11 66 10      [10]  388 	ld	de,#_g_colors+0
   1097 DD 6E 06      [19]  389 	ld	l,6 (ix)
   109A 26 00         [ 7]  390 	ld	h,#0x00
   109C 19            [11]  391 	add	hl,de
   109D 7E            [ 7]  392 	ld	a,(hl)
   109E DD 77 FE      [19]  393 	ld	-2 (ix),a
                            394 ;src/Renderer.c:120: u8 pixMask = g_pixelMask[column&1];
   10A1 11 76 10      [10]  395 	ld	de,#_g_pixelMask+0
   10A4 DD 7E 04      [19]  396 	ld	a,4 (ix)
   10A7 E6 01         [ 7]  397 	and	a, #0x01
   10A9 6F            [ 4]  398 	ld	l,a
   10AA 26 00         [ 7]  399 	ld	h,#0x00
   10AC 19            [11]  400 	add	hl,de
   10AD 5E            [ 7]  401 	ld	e,(hl)
                            402 ;src/Renderer.c:129: if(lineHeight>SCREEN_TEXTURE_HEIGHT) lineHeight = SCREEN_TEXTURE_HEIGHT;
   10AE 3E 64         [ 7]  403 	ld	a,#0x64
   10B0 DD 96 05      [19]  404 	sub	a, 5 (ix)
   10B3 30 04         [12]  405 	jr	NC,00102$
   10B5 DD 36 05 64   [19]  406 	ld	5 (ix),#0x64
   10B9                     407 00102$:
                            408 ;src/Renderer.c:131: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   10B9 DD 6E 05      [19]  409 	ld	l,5 (ix)
   10BC CB 3D         [ 8]  410 	srl	l
   10BE 3E 32         [ 7]  411 	ld	a,#0x32
   10C0 95            [ 4]  412 	sub	a, l
                            413 ;src/Renderer.c:134: pvmem += SCREEN_TEXTURE_WIDTH_BYTES*ceiling_height;
   10C1 D5            [11]  414 	push	de
   10C2 5F            [ 4]  415 	ld	e,a
   10C3 16 00         [ 7]  416 	ld	d,#0x00
   10C5 6B            [ 4]  417 	ld	l, e
   10C6 62            [ 4]  418 	ld	h, d
   10C7 29            [11]  419 	add	hl, hl
   10C8 29            [11]  420 	add	hl, hl
   10C9 19            [11]  421 	add	hl, de
   10CA 29            [11]  422 	add	hl, hl
   10CB 29            [11]  423 	add	hl, hl
   10CC 29            [11]  424 	add	hl, hl
   10CD D1            [10]  425 	pop	de
   10CE 09            [11]  426 	add	hl,bc
   10CF 4D            [ 4]  427 	ld	c,l
   10D0 44            [ 4]  428 	ld	b,h
                            429 ;src/Renderer.c:136: j=lineHeight;
   10D1 DD 56 05      [19]  430 	ld	d,5 (ix)
                            431 ;src/Renderer.c:138: for(j;j;--j){
   10D4 7B            [ 4]  432 	ld	a,e
   10D5 2F            [ 4]  433 	cpl
   10D6 DD 77 FF      [19]  434 	ld	-1 (ix),a
   10D9 7B            [ 4]  435 	ld	a,e
   10DA DD A6 FE      [19]  436 	and	a, -2 (ix)
   10DD 5F            [ 4]  437 	ld	e,a
   10DE                     438 00105$:
   10DE 7A            [ 4]  439 	ld	a,d
   10DF B7            [ 4]  440 	or	a, a
   10E0 28 0F         [12]  441 	jr	Z,00107$
                            442 ;src/Renderer.c:139: val =  ((*pvmem)&(~pixMask));
   10E2 0A            [ 7]  443 	ld	a,(bc)
   10E3 DD A6 FF      [19]  444 	and	a, -1 (ix)
                            445 ;src/Renderer.c:141: *pvmem = val|(w_color&pixMask);
   10E6 B3            [ 4]  446 	or	a, e
   10E7 02            [ 7]  447 	ld	(bc),a
                            448 ;src/Renderer.c:143: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   10E8 21 28 00      [10]  449 	ld	hl,#0x0028
   10EB 09            [11]  450 	add	hl,bc
   10EC 4D            [ 4]  451 	ld	c,l
   10ED 44            [ 4]  452 	ld	b,h
                            453 ;src/Renderer.c:138: for(j;j;--j){
   10EE 15            [ 4]  454 	dec	d
   10EF 18 ED         [12]  455 	jr	00105$
   10F1                     456 00107$:
   10F1 DD F9         [10]  457 	ld	sp, ix
   10F3 DD E1         [14]  458 	pop	ix
   10F5 C9            [10]  459 	ret
                            460 ;src/Renderer.c:147: void draw_column_to_buffer_object(u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            461 ;	---------------------------------
                            462 ; Function draw_column_to_buffer_object
                            463 ; ---------------------------------
   10F6                     464 _draw_column_to_buffer_object::
                            465 ;src/Renderer.c:149: }
   10F6 C9            [10]  466 	ret
                            467 ;src/Renderer.c:152: void draw_column_to_buffer_enemy(const u8 column, u8 lineHeight, u8 index, u8 texture_column){
                            468 ;	---------------------------------
                            469 ; Function draw_column_to_buffer_enemy
                            470 ; ---------------------------------
   10F7                     471 _draw_column_to_buffer_enemy::
   10F7 DD E5         [15]  472 	push	ix
   10F9 DD 21 00 00   [14]  473 	ld	ix,#0
   10FD DD 39         [15]  474 	add	ix,sp
   10FF 21 F2 FF      [10]  475 	ld	hl,#-14
   1102 39            [11]  476 	add	hl,sp
   1103 F9            [ 6]  477 	ld	sp,hl
                            478 ;src/Renderer.c:169: u16 texture_line=0;
   1104 DD 36 F5 00   [19]  479 	ld	-11 (ix),#0x00
   1108 DD 36 F6 00   [19]  480 	ld	-10 (ix),#0x00
                            481 ;src/Renderer.c:171: if(texture_column>=4 && texture_column<28){
   110C DD 7E 07      [19]  482 	ld	a,7 (ix)
   110F D6 04         [ 7]  483 	sub	a, #0x04
   1111 DA 35 12      [10]  484 	jp	C,00112$
   1114 DD 7E 07      [19]  485 	ld	a,7 (ix)
   1117 D6 1C         [ 7]  486 	sub	a, #0x1C
   1119 D2 35 12      [10]  487 	jp	NC,00112$
                            488 ;src/Renderer.c:174: texture = (u8*)(UNCOMPRESSED_ENEMY_TEXTURES + (576*(enemy_get_at(index-1)->type)) + ((texture_column-4)*ENEMY_SPRITE_WIDTH));
   111C DD 6E 06      [19]  489 	ld	l,6 (ix)
   111F 2D            [ 4]  490 	dec	l
   1120 CD 40 00      [17]  491 	call	_enemy_get_at
   1123 23            [ 6]  492 	inc	hl
   1124 4E            [ 7]  493 	ld	c,(hl)
   1125 06 00         [ 7]  494 	ld	b,#0x00
   1127 69            [ 4]  495 	ld	l, c
   1128 60            [ 4]  496 	ld	h, b
   1129 29            [11]  497 	add	hl, hl
   112A 29            [11]  498 	add	hl, hl
   112B 29            [11]  499 	add	hl, hl
   112C 09            [11]  500 	add	hl, bc
   112D 29            [11]  501 	add	hl, hl
   112E 29            [11]  502 	add	hl, hl
   112F 29            [11]  503 	add	hl, hl
   1130 29            [11]  504 	add	hl, hl
   1131 29            [11]  505 	add	hl, hl
   1132 29            [11]  506 	add	hl, hl
   1133 01 00 88      [10]  507 	ld	bc,#0x8800
   1136 09            [11]  508 	add	hl,bc
   1137 4D            [ 4]  509 	ld	c,l
   1138 44            [ 4]  510 	ld	b,h
   1139 DD 7E 07      [19]  511 	ld	a, 7 (ix)
   113C 16 00         [ 7]  512 	ld	d, #0x00
   113E C6 FC         [ 7]  513 	add	a,#0xFC
   1140 5F            [ 4]  514 	ld	e,a
   1141 7A            [ 4]  515 	ld	a,d
   1142 CE FF         [ 7]  516 	adc	a,#0xFF
   1144 57            [ 4]  517 	ld	d,a
   1145 6B            [ 4]  518 	ld	l, e
   1146 62            [ 4]  519 	ld	h, d
   1147 29            [11]  520 	add	hl, hl
   1148 19            [11]  521 	add	hl, de
   1149 29            [11]  522 	add	hl, hl
   114A 29            [11]  523 	add	hl, hl
   114B 29            [11]  524 	add	hl, hl
   114C 09            [11]  525 	add	hl,bc
   114D 33            [ 6]  526 	inc	sp
   114E 33            [ 6]  527 	inc	sp
   114F E5            [11]  528 	push	hl
                            529 ;src/Renderer.c:176: pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1150 DD 7E 04      [19]  530 	ld	a,4 (ix)
   1153 CB 3F         [ 8]  531 	srl	a
   1155 C6 00         [ 7]  532 	add	a, #0x00
   1157 DD 77 FA      [19]  533 	ld	-6 (ix),a
   115A 3E 00         [ 7]  534 	ld	a,#0x00
   115C CE 9B         [ 7]  535 	adc	a, #0x9B
   115E DD 77 FB      [19]  536 	ld	-5 (ix),a
                            537 ;src/Renderer.c:178: pixMask = g_pixelMask[column&1];
   1161 01 76 10      [10]  538 	ld	bc,#_g_pixelMask+0
   1164 DD 7E 04      [19]  539 	ld	a,4 (ix)
   1167 E6 01         [ 7]  540 	and	a, #0x01
   1169 6F            [ 4]  541 	ld	l, a
   116A 26 00         [ 7]  542 	ld	h,#0x00
   116C 09            [11]  543 	add	hl,bc
   116D 7E            [ 7]  544 	ld	a,(hl)
   116E DD 77 F4      [19]  545 	ld	-12 (ix),a
                            546 ;src/Renderer.c:180: ground_height  = (SCREEN_TEXTURE_HEIGHT>>1) + (lineHeight>>1);
   1171 DD 7E 05      [19]  547 	ld	a,5 (ix)
   1174 CB 3F         [ 8]  548 	srl	a
   1176 C6 32         [ 7]  549 	add	a, #0x32
   1178 DD 77 F9      [19]  550 	ld	-7 (ix),a
                            551 ;src/Renderer.c:181: lineHeight = (lineHeight*3)/4;
   117B DD 4E 05      [19]  552 	ld	c,5 (ix)
   117E 06 00         [ 7]  553 	ld	b,#0x00
   1180 69            [ 4]  554 	ld	l, c
   1181 60            [ 4]  555 	ld	h, b
   1182 29            [11]  556 	add	hl, hl
   1183 09            [11]  557 	add	hl, bc
   1184 DD 75 FE      [19]  558 	ld	-2 (ix),l
   1187 DD 74 FF      [19]  559 	ld	-1 (ix),h
   118A DD 7E FE      [19]  560 	ld	a,-2 (ix)
   118D DD 77 FC      [19]  561 	ld	-4 (ix),a
   1190 DD 7E FF      [19]  562 	ld	a,-1 (ix)
   1193 DD 77 FD      [19]  563 	ld	-3 (ix),a
   1196 DD CB FF 7E   [20]  564 	bit	7, -1 (ix)
   119A 28 10         [12]  565 	jr	Z,00114$
   119C DD 7E FE      [19]  566 	ld	a,-2 (ix)
   119F C6 03         [ 7]  567 	add	a, #0x03
   11A1 DD 77 FC      [19]  568 	ld	-4 (ix),a
   11A4 DD 7E FF      [19]  569 	ld	a,-1 (ix)
   11A7 CE 00         [ 7]  570 	adc	a, #0x00
   11A9 DD 77 FD      [19]  571 	ld	-3 (ix),a
   11AC                     572 00114$:
   11AC DD 46 FC      [19]  573 	ld	b,-4 (ix)
   11AF DD 4E FD      [19]  574 	ld	c,-3 (ix)
   11B2 CB 29         [ 8]  575 	sra	c
   11B4 CB 18         [ 8]  576 	rr	b
   11B6 CB 29         [ 8]  577 	sra	c
   11B8 CB 18         [ 8]  578 	rr	b
                            579 ;src/Renderer.c:182: enemy_top_height = ground_height - lineHeight;
   11BA DD 7E F9      [19]  580 	ld	a,-7 (ix)
   11BD 90            [ 4]  581 	sub	a, b
   11BE 4F            [ 4]  582 	ld	c,a
                            583 ;src/Renderer.c:184: texture_line_add = (256*ENEMY_SPRITE_HEIGHT)/lineHeight;
   11BF 58            [ 4]  584 	ld	e,b
   11C0 16 00         [ 7]  585 	ld	d,#0x00
   11C2 C5            [11]  586 	push	bc
   11C3 D5            [11]  587 	push	de
   11C4 21 00 18      [10]  588 	ld	hl,#0x1800
   11C7 E5            [11]  589 	push	hl
   11C8 CD 1B 5A      [17]  590 	call	__divsint
   11CB F1            [10]  591 	pop	af
   11CC F1            [10]  592 	pop	af
   11CD C1            [10]  593 	pop	bc
   11CE DD 75 F7      [19]  594 	ld	-9 (ix),l
   11D1 DD 74 F8      [19]  595 	ld	-8 (ix),h
                            596 ;src/Renderer.c:185: j=lineHeight;
   11D4 50            [ 4]  597 	ld	d,b
                            598 ;src/Renderer.c:187: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   11D5 3E 64         [ 7]  599 	ld	a,#0x64
   11D7 90            [ 4]  600 	sub	a, b
   11D8 30 02         [12]  601 	jr	NC,00102$
                            602 ;src/Renderer.c:188: j=90;
   11DA 16 5A         [ 7]  603 	ld	d,#0x5A
   11DC                     604 00102$:
                            605 ;src/Renderer.c:191: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * enemy_top_height;
   11DC 06 00         [ 7]  606 	ld	b,#0x00
   11DE 69            [ 4]  607 	ld	l, c
   11DF 60            [ 4]  608 	ld	h, b
   11E0 29            [11]  609 	add	hl, hl
   11E1 29            [11]  610 	add	hl, hl
   11E2 09            [11]  611 	add	hl, bc
   11E3 29            [11]  612 	add	hl, hl
   11E4 29            [11]  613 	add	hl, hl
   11E5 29            [11]  614 	add	hl, hl
   11E6 DD 7E FA      [19]  615 	ld	a,-6 (ix)
   11E9 85            [ 4]  616 	add	a, l
   11EA 4F            [ 4]  617 	ld	c,a
   11EB DD 7E FB      [19]  618 	ld	a,-5 (ix)
   11EE 8C            [ 4]  619 	adc	a, h
   11EF 47            [ 4]  620 	ld	b,a
                            621 ;src/Renderer.c:193: for(j;j;--j){
   11F0 DD 7E F4      [19]  622 	ld	a,-12 (ix)
   11F3 2F            [ 4]  623 	cpl
   11F4 5F            [ 4]  624 	ld	e,a
   11F5                     625 00110$:
   11F5 7A            [ 4]  626 	ld	a,d
   11F6 B7            [ 4]  627 	or	a, a
   11F7 28 3C         [12]  628 	jr	Z,00112$
                            629 ;src/Renderer.c:195: color= *(texture+(texture_line/256));
   11F9 DD 6E F6      [19]  630 	ld	l,-10 (ix)
   11FC 26 00         [ 7]  631 	ld	h,#0x00
   11FE DD 7E F2      [19]  632 	ld	a,-14 (ix)
   1201 85            [ 4]  633 	add	a, l
   1202 6F            [ 4]  634 	ld	l,a
   1203 DD 7E F3      [19]  635 	ld	a,-13 (ix)
   1206 8C            [ 4]  636 	adc	a, h
   1207 67            [ 4]  637 	ld	h,a
   1208 7E            [ 7]  638 	ld	a,(hl)
                            639 ;src/Renderer.c:197: if(color){
   1209 DD 77 FC      [19]  640 	ld	-4 (ix), a
   120C B7            [ 4]  641 	or	a, a
   120D 28 0B         [12]  642 	jr	Z,00104$
                            643 ;src/Renderer.c:198: val =  ((*pvmem)&(~pixMask));
   120F 0A            [ 7]  644 	ld	a,(bc)
   1210 A3            [ 4]  645 	and	a, e
   1211 6F            [ 4]  646 	ld	l,a
                            647 ;src/Renderer.c:200: color = (color&pixMask);
   1212 DD 7E FC      [19]  648 	ld	a,-4 (ix)
   1215 DD A6 F4      [19]  649 	and	a, -12 (ix)
                            650 ;src/Renderer.c:202: *pvmem = val|color;
   1218 B5            [ 4]  651 	or	a, l
   1219 02            [ 7]  652 	ld	(bc),a
   121A                     653 00104$:
                            654 ;src/Renderer.c:205: texture_line += texture_line_add;
   121A DD 7E F5      [19]  655 	ld	a,-11 (ix)
   121D DD 86 F7      [19]  656 	add	a, -9 (ix)
   1220 DD 77 F5      [19]  657 	ld	-11 (ix),a
   1223 DD 7E F6      [19]  658 	ld	a,-10 (ix)
   1226 DD 8E F8      [19]  659 	adc	a, -8 (ix)
   1229 DD 77 F6      [19]  660 	ld	-10 (ix),a
                            661 ;src/Renderer.c:207: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   122C 21 28 00      [10]  662 	ld	hl,#0x0028
   122F 09            [11]  663 	add	hl,bc
   1230 4D            [ 4]  664 	ld	c,l
   1231 44            [ 4]  665 	ld	b,h
                            666 ;src/Renderer.c:193: for(j;j;--j){
   1232 15            [ 4]  667 	dec	d
   1233 18 C0         [12]  668 	jr	00110$
   1235                     669 00112$:
   1235 DD F9         [10]  670 	ld	sp, ix
   1237 DD E1         [14]  671 	pop	ix
   1239 C9            [10]  672 	ret
                            673 ;src/Renderer.c:299: void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
                            674 ;	---------------------------------
                            675 ; Function draw_column_to_buffer
                            676 ; ---------------------------------
   123A                     677 _draw_column_to_buffer::
   123A DD E5         [15]  678 	push	ix
   123C DD 21 00 00   [14]  679 	ld	ix,#0
   1240 DD 39         [15]  680 	add	ix,sp
   1242 21 F1 FF      [10]  681 	ld	hl,#-15
   1245 39            [11]  682 	add	hl,sp
   1246 F9            [ 6]  683 	ld	sp,hl
                            684 ;src/Renderer.c:300: u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
   1247 DD 7E 04      [19]  685 	ld	a,4 (ix)
   124A CB 3F         [ 8]  686 	srl	a
   124C C6 00         [ 7]  687 	add	a, #0x00
   124E DD 77 FE      [19]  688 	ld	-2 (ix),a
   1251 3E 00         [ 7]  689 	ld	a,#0x00
   1253 CE 9B         [ 7]  690 	adc	a, #0x9B
   1255 DD 77 FF      [19]  691 	ld	-1 (ix),a
                            692 ;src/Renderer.c:303: u8 pixMask = g_pixelMask[column&1];
   1258 01 76 10      [10]  693 	ld	bc,#_g_pixelMask+0
   125B DD 7E 04      [19]  694 	ld	a,4 (ix)
   125E E6 01         [ 7]  695 	and	a, #0x01
   1260 6F            [ 4]  696 	ld	l, a
   1261 26 00         [ 7]  697 	ld	h,#0x00
   1263 09            [11]  698 	add	hl,bc
   1264 7E            [ 7]  699 	ld	a,(hl)
   1265 DD 77 F8      [19]  700 	ld	-8 (ix),a
                            701 ;src/Renderer.c:308: u8* texture = (u8*)(UNCOMPRESSED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
   1268 DD 7E 06      [19]  702 	ld	a, 6 (ix)
   126B 87            [ 4]  703 	add	a, a
   126C 87            [ 4]  704 	add	a, a
   126D 47            [ 4]  705 	ld	b,a
   126E 0E 00         [ 7]  706 	ld	c,#0x00
   1270 21 00 74      [10]  707 	ld	hl,#0x7400
   1273 09            [11]  708 	add	hl,bc
   1274 4D            [ 4]  709 	ld	c,l
   1275 44            [ 4]  710 	ld	b,h
   1276 DD 6E 07      [19]  711 	ld	l,7 (ix)
   1279 26 00         [ 7]  712 	ld	h,#0x00
   127B 29            [11]  713 	add	hl, hl
   127C 29            [11]  714 	add	hl, hl
   127D 29            [11]  715 	add	hl, hl
   127E 29            [11]  716 	add	hl, hl
   127F 29            [11]  717 	add	hl, hl
   1280 09            [11]  718 	add	hl,bc
   1281 DD 75 F4      [19]  719 	ld	-12 (ix),l
   1284 DD 74 F5      [19]  720 	ld	-11 (ix),h
                            721 ;src/Renderer.c:310: u8 j=lineHeight;
   1287 DD 7E 05      [19]  722 	ld	a,5 (ix)
                            723 ;src/Renderer.c:316: u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
   128A DD 77 F9      [19]  724 	ld	-7 (ix), a
   128D DD 77 FA      [19]  725 	ld	-6 (ix),a
   1290 DD 36 FB 00   [19]  726 	ld	-5 (ix),#0x00
   1294 DD 6E FA      [19]  727 	ld	l,-6 (ix)
   1297 DD 66 FB      [19]  728 	ld	h,-5 (ix)
   129A E5            [11]  729 	push	hl
   129B 21 00 20      [10]  730 	ld	hl,#0x2000
   129E E5            [11]  731 	push	hl
   129F CD 1B 5A      [17]  732 	call	__divsint
   12A2 F1            [10]  733 	pop	af
   12A3 F1            [10]  734 	pop	af
   12A4 DD 75 F2      [19]  735 	ld	-14 (ix),l
   12A7 DD 74 F3      [19]  736 	ld	-13 (ix),h
                            737 ;src/Renderer.c:317: u16 wall_texture_line=0;
   12AA DD 36 F6 00   [19]  738 	ld	-10 (ix),#0x00
   12AE DD 36 F7 00   [19]  739 	ld	-9 (ix),#0x00
                            740 ;src/Renderer.c:319: ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
   12B2 DD 4E F9      [19]  741 	ld	c,-7 (ix)
   12B5 CB 39         [ 8]  742 	srl	c
   12B7 3E 32         [ 7]  743 	ld	a,#0x32
   12B9 91            [ 4]  744 	sub	a, c
   12BA DD 77 F1      [19]  745 	ld	-15 (ix),a
                            746 ;src/Renderer.c:323: if(lineHeight>SCREEN_TEXTURE_HEIGHT){
   12BD 3E 64         [ 7]  747 	ld	a,#0x64
   12BF DD 96 F9      [19]  748 	sub	a, -7 (ix)
   12C2 30 4B         [12]  749 	jr	NC,00102$
                            750 ;src/Renderer.c:324: ceiling_height=0;
   12C4 DD 36 F1 00   [19]  751 	ld	-15 (ix),#0x00
                            752 ;src/Renderer.c:325: wall_texture_line = ((lineHeight-SCREEN_TEXTURE_HEIGHT)/2) * wall_texture_line_add;
   12C8 DD 7E FA      [19]  753 	ld	a,-6 (ix)
   12CB C6 9C         [ 7]  754 	add	a,#0x9C
   12CD 4F            [ 4]  755 	ld	c,a
   12CE DD 7E FB      [19]  756 	ld	a,-5 (ix)
   12D1 CE FF         [ 7]  757 	adc	a,#0xFF
   12D3 47            [ 4]  758 	ld	b,a
   12D4 DD 71 FC      [19]  759 	ld	-4 (ix),c
   12D7 DD 70 FD      [19]  760 	ld	-3 (ix),b
   12DA CB 78         [ 8]  761 	bit	7, b
   12DC 28 10         [12]  762 	jr	Z,00111$
   12DE DD 7E FA      [19]  763 	ld	a,-6 (ix)
   12E1 C6 9D         [ 7]  764 	add	a, #0x9D
   12E3 DD 77 FC      [19]  765 	ld	-4 (ix),a
   12E6 DD 7E FB      [19]  766 	ld	a,-5 (ix)
   12E9 CE FF         [ 7]  767 	adc	a, #0xFF
   12EB DD 77 FD      [19]  768 	ld	-3 (ix),a
   12EE                     769 00111$:
   12EE DD 4E FC      [19]  770 	ld	c,-4 (ix)
   12F1 DD 46 FD      [19]  771 	ld	b,-3 (ix)
   12F4 CB 28         [ 8]  772 	sra	b
   12F6 CB 19         [ 8]  773 	rr	c
   12F8 DD 6E F2      [19]  774 	ld	l,-14 (ix)
   12FB DD 66 F3      [19]  775 	ld	h,-13 (ix)
   12FE E5            [11]  776 	push	hl
   12FF C5            [11]  777 	push	bc
   1300 CD 98 58      [17]  778 	call	__mulint
   1303 F1            [10]  779 	pop	af
   1304 F1            [10]  780 	pop	af
   1305 DD 75 F6      [19]  781 	ld	-10 (ix),l
   1308 DD 74 F7      [19]  782 	ld	-9 (ix),h
                            783 ;src/Renderer.c:326: j=SCREEN_TEXTURE_HEIGHT;
   130B DD 36 F9 64   [19]  784 	ld	-7 (ix),#0x64
   130F                     785 00102$:
                            786 ;src/Renderer.c:329: pvmem += SCREEN_TEXTURE_WIDTH_BYTES * ceiling_height;
   130F DD 4E F1      [19]  787 	ld	c,-15 (ix)
   1312 06 00         [ 7]  788 	ld	b,#0x00
   1314 69            [ 4]  789 	ld	l, c
   1315 60            [ 4]  790 	ld	h, b
   1316 29            [11]  791 	add	hl, hl
   1317 29            [11]  792 	add	hl, hl
   1318 09            [11]  793 	add	hl, bc
   1319 29            [11]  794 	add	hl, hl
   131A 29            [11]  795 	add	hl, hl
   131B 29            [11]  796 	add	hl, hl
   131C DD 7E FE      [19]  797 	ld	a,-2 (ix)
   131F 85            [ 4]  798 	add	a, l
   1320 4F            [ 4]  799 	ld	c,a
   1321 DD 7E FF      [19]  800 	ld	a,-1 (ix)
   1324 8C            [ 4]  801 	adc	a, h
   1325 47            [ 4]  802 	ld	b,a
                            803 ;src/Renderer.c:331: for(j;j;--j){
   1326 DD 7E F8      [19]  804 	ld	a,-8 (ix)
   1329 2F            [ 4]  805 	cpl
   132A DD 77 FC      [19]  806 	ld	-4 (ix),a
   132D DD 56 F9      [19]  807 	ld	d,-7 (ix)
   1330                     808 00107$:
   1330 7A            [ 4]  809 	ld	a,d
   1331 B7            [ 4]  810 	or	a, a
   1332 28 39         [12]  811 	jr	Z,00109$
                            812 ;src/Renderer.c:333: w_color = *(texture+(wall_texture_line/256));
   1334 DD 7E F7      [19]  813 	ld	a, -9 (ix)
   1337 26 00         [ 7]  814 	ld	h, #0x00
   1339 DD 86 F4      [19]  815 	add	a, -12 (ix)
   133C 6F            [ 4]  816 	ld	l,a
   133D 7C            [ 4]  817 	ld	a,h
   133E DD 8E F5      [19]  818 	adc	a, -11 (ix)
   1341 67            [ 4]  819 	ld	h,a
   1342 5E            [ 7]  820 	ld	e,(hl)
                            821 ;src/Renderer.c:335: if(w_color){
   1343 7B            [ 4]  822 	ld	a,e
   1344 B7            [ 4]  823 	or	a, a
   1345 28 0B         [12]  824 	jr	Z,00104$
                            825 ;src/Renderer.c:337: val =  ((*pvmem)&(~pixMask));
   1347 0A            [ 7]  826 	ld	a,(bc)
   1348 DD A6 FC      [19]  827 	and	a, -4 (ix)
   134B 6F            [ 4]  828 	ld	l,a
                            829 ;src/Renderer.c:339: w_color = (w_color&pixMask);
   134C 7B            [ 4]  830 	ld	a,e
   134D DD A6 F8      [19]  831 	and	a, -8 (ix)
                            832 ;src/Renderer.c:341: *pvmem = val|w_color;
   1350 B5            [ 4]  833 	or	a, l
   1351 02            [ 7]  834 	ld	(bc),a
   1352                     835 00104$:
                            836 ;src/Renderer.c:345: wall_texture_line += wall_texture_line_add;
   1352 DD 7E F6      [19]  837 	ld	a,-10 (ix)
   1355 DD 86 F2      [19]  838 	add	a, -14 (ix)
   1358 DD 77 F6      [19]  839 	ld	-10 (ix),a
   135B DD 7E F7      [19]  840 	ld	a,-9 (ix)
   135E DD 8E F3      [19]  841 	adc	a, -13 (ix)
   1361 DD 77 F7      [19]  842 	ld	-9 (ix),a
                            843 ;src/Renderer.c:347: pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
   1364 21 28 00      [10]  844 	ld	hl,#0x0028
   1367 09            [11]  845 	add	hl,bc
   1368 4D            [ 4]  846 	ld	c,l
   1369 44            [ 4]  847 	ld	b,h
                            848 ;src/Renderer.c:331: for(j;j;--j){
   136A 15            [ 4]  849 	dec	d
   136B 18 C3         [12]  850 	jr	00107$
   136D                     851 00109$:
   136D DD F9         [10]  852 	ld	sp, ix
   136F DD E1         [14]  853 	pop	ix
   1371 C9            [10]  854 	ret
                            855 ;src/Renderer.c:351: void render_draw_to_buffer(){//TODO Optimize
                            856 ;	---------------------------------
                            857 ; Function render_draw_to_buffer
                            858 ; ---------------------------------
   1372                     859 _render_draw_to_buffer::
   1372 DD E5         [15]  860 	push	ix
   1374 DD 21 00 00   [14]  861 	ld	ix,#0
   1378 DD 39         [15]  862 	add	ix,sp
   137A 21 C6 FF      [10]  863 	ld	hl,#-58
   137D 39            [11]  864 	add	hl,sp
   137E F9            [ 6]  865 	ld	sp,hl
                            866 ;src/Renderer.c:363: u8 zHeight = 5;
   137F DD 36 C7 05   [19]  867 	ld	-57 (ix),#0x05
                            868 ;src/Renderer.c:373: u8 offsetDiff = 16;
   1383 DD 36 CE 10   [19]  869 	ld	-50 (ix),#0x10
                            870 ;src/Renderer.c:378: u8 lineStart = 0;
   1387 DD 36 D5 00   [19]  871 	ld	-43 (ix),#0x00
                            872 ;src/Renderer.c:380: u8 lateralWallWidth=0;
   138B DD 36 D3 00   [19]  873 	ld	-45 (ix),#0x00
                            874 ;src/Renderer.c:392: cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   138F 21 6D 10      [10]  875 	ld	hl, #_g_colors + 7
   1392 46            [ 7]  876 	ld	b,(hl)
   1393 21 A8 07      [10]  877 	ld	hl,#0x07A8
   1396 E5            [11]  878 	push	hl
   1397 C5            [11]  879 	push	bc
   1398 33            [ 6]  880 	inc	sp
   1399 21 00 9B      [10]  881 	ld	hl,#0x9B00
   139C E5            [11]  882 	push	hl
   139D CD 44 59      [17]  883 	call	_cpct_memset
                            884 ;src/Renderer.c:393: cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
   13A0 21 67 10      [10]  885 	ld	hl, #_g_colors + 1
   13A3 46            [ 7]  886 	ld	b,(hl)
   13A4 21 50 00      [10]  887 	ld	hl,#0x0050
   13A7 E5            [11]  888 	push	hl
   13A8 C5            [11]  889 	push	bc
   13A9 33            [ 6]  890 	inc	sp
   13AA 21 A8 A2      [10]  891 	ld	hl,#0xA2A8
   13AD E5            [11]  892 	push	hl
   13AE CD 44 59      [17]  893 	call	_cpct_memset
                            894 ;src/Renderer.c:394: cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
   13B1 21 6E 10      [10]  895 	ld	hl, #_g_colors + 8
   13B4 46            [ 7]  896 	ld	b,(hl)
   13B5 21 A8 07      [10]  897 	ld	hl,#0x07A8
   13B8 E5            [11]  898 	push	hl
   13B9 C5            [11]  899 	push	bc
   13BA 33            [ 6]  900 	inc	sp
   13BB 21 F8 A2      [10]  901 	ld	hl,#0xA2F8
   13BE E5            [11]  902 	push	hl
   13BF CD 44 59      [17]  903 	call	_cpct_memset
                            904 ;src/Renderer.c:396: calculate_cells_in_view();
   13C2 CD AA 0E      [17]  905 	call	_calculate_cells_in_view
                            906 ;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
   13C5 2A 79 10      [16]  907 	ld	hl,(_cells_in_view_array)
   13C8 DD 75 DC      [19]  908 	ld	-36 (ix),l
   13CB DD 74 DD      [19]  909 	ld	-35 (ix),h
                            910 ;src/Renderer.c:398: if(g_texturedWalls){
   13CE 3A 78 10      [13]  911 	ld	a,(#_g_texturedWalls + 0)
   13D1 B7            [ 4]  912 	or	a, a
   13D2 CA 1A 19      [10]  913 	jp	Z,00358$
                            914 ;src/Renderer.c:400: do{
   13D5 DD 36 CB 06   [19]  915 	ld	-53 (ix),#0x06
   13D9                     916 00175$:
                            917 ;src/Renderer.c:402: --z;
   13D9 DD 35 CB      [23]  918 	dec	-53 (ix)
                            919 ;src/Renderer.c:406: xCellCount = (z) ? (zHeight >> 1) : 0;
   13DC DD 7E C7      [19]  920 	ld	a,-57 (ix)
   13DF CB 3F         [ 8]  921 	srl	a
   13E1 DD 77 EE      [19]  922 	ld	-18 (ix),a
   13E4 DD 7E CB      [19]  923 	ld	a,-53 (ix)
   13E7 B7            [ 4]  924 	or	a, a
   13E8 28 05         [12]  925 	jr	Z,00262$
   13EA DD 4E EE      [19]  926 	ld	c,-18 (ix)
   13ED 18 02         [12]  927 	jr	00263$
   13EF                     928 00262$:
   13EF 0E 00         [ 7]  929 	ld	c,#0x00
   13F1                     930 00263$:
   13F1 DD 71 F3      [19]  931 	ld	-13 (ix),c
                            932 ;src/Renderer.c:407: lateralWallSlope=0;
   13F4 DD 36 F6 00   [19]  933 	ld	-10 (ix),#0x00
                            934 ;src/Renderer.c:408: lateralWallSlopeCounter=0;
   13F8 DD 36 F8 00   [19]  935 	ld	-8 (ix),#0x00
                            936 ;src/Renderer.c:409: xHeight=0;
   13FC DD 36 FD 00   [19]  937 	ld	-3 (ix),#0x00
                            938 ;src/Renderer.c:412: lateralWallCounter = 0;
   1400 DD 36 DA 00   [19]  939 	ld	-38 (ix),#0x00
                            940 ;src/Renderer.c:414: newCell=1;
   1404 DD 36 E5 01   [19]  941 	ld	-27 (ix),#0x01
                            942 ;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
   1408 DD 7E D5      [19]  943 	ld	a,-43 (ix)
   140B DD 77 E9      [19]  944 	ld	-23 (ix),a
   140E DD 36 EA 00   [19]  945 	ld	-22 (ix),#0x00
   1412 DD 4E E9      [19]  946 	ld	c,-23 (ix)
   1415 DD 46 EA      [19]  947 	ld	b,-22 (ix)
   1418 03            [ 6]  948 	inc	bc
   1419 DD 6E DC      [19]  949 	ld	l,-36 (ix)
   141C DD 66 DD      [19]  950 	ld	h,-35 (ix)
   141F 09            [11]  951 	add	hl,bc
   1420 7E            [ 7]  952 	ld	a,(hl)
   1421 DD 77 E4      [19]  953 	ld	-28 (ix),a
                            954 ;src/Renderer.c:417: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   1424 DD 7E DC      [19]  955 	ld	a,-36 (ix)
   1427 DD 86 D5      [19]  956 	add	a, -43 (ix)
   142A 6F            [ 4]  957 	ld	l,a
   142B DD 7E DD      [19]  958 	ld	a,-35 (ix)
   142E CE 00         [ 7]  959 	adc	a, #0x00
   1430 67            [ 4]  960 	ld	h,a
   1431 4E            [ 7]  961 	ld	c,(hl)
                            962 ;src/Renderer.c:418: if(lastCellWasWall&CELL_WALL_MASK){
   1432 CB 79         [ 8]  963 	bit	7, c
   1434 28 09         [12]  964 	jr	Z,00102$
                            965 ;src/Renderer.c:419: lastWallId=lastCellWasWall;
   1436 DD 71 D7      [19]  966 	ld	-41 (ix),c
                            967 ;src/Renderer.c:420: lastCellWasWall=1;
   1439 DD 36 DB 01   [19]  968 	ld	-37 (ix),#0x01
   143D 18 08         [12]  969 	jr	00296$
   143F                     970 00102$:
                            971 ;src/Renderer.c:423: lastCellWasWall=0;
   143F DD 36 DB 00   [19]  972 	ld	-37 (ix),#0x00
                            973 ;src/Renderer.c:424: lastWallId=CELLTYPE_FLOOR;
   1443 DD 36 D7 00   [19]  974 	ld	-41 (ix),#0x00
                            975 ;src/Renderer.c:427: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1447                     976 00296$:
   1447 DD 36 D4 00   [19]  977 	ld	-44 (ix),#0x00
   144B DD 36 CD 00   [19]  978 	ld	-51 (ix),#0x00
   144F                     979 00252$:
                            980 ;src/Renderer.c:429: if (xCellCount == zHeight)
   144F DD 7E C7      [19]  981 	ld	a,-57 (ix)
   1452 DD 96 F3      [19]  982 	sub	a, -13 (ix)
   1455 20 4B         [12]  983 	jr	NZ,00105$
                            984 ;src/Renderer.c:431: ++xCell;
   1457 DD 34 D4      [23]  985 	inc	-44 (ix)
                            986 ;src/Renderer.c:432: xCellCount = 0;
   145A DD 36 F3 00   [19]  987 	ld	-13 (ix),#0x00
                            988 ;src/Renderer.c:433: newCell=1;
   145E DD 36 E5 01   [19]  989 	ld	-27 (ix),#0x01
                            990 ;src/Renderer.c:434: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   1462 DD 7E D4      [19]  991 	ld	a,-44 (ix)
   1465 DD 77 E2      [19]  992 	ld	-30 (ix),a
   1468 DD 36 E3 00   [19]  993 	ld	-29 (ix),#0x00
   146C DD 7E E9      [19]  994 	ld	a,-23 (ix)
   146F DD 86 E2      [19]  995 	add	a, -30 (ix)
   1472 DD 77 E2      [19]  996 	ld	-30 (ix),a
   1475 DD 7E EA      [19]  997 	ld	a,-22 (ix)
   1478 DD 8E E3      [19]  998 	adc	a, -29 (ix)
   147B DD 77 E3      [19]  999 	ld	-29 (ix),a
   147E DD 34 E2      [23] 1000 	inc	-30 (ix)
   1481 20 03         [12] 1001 	jr	NZ,00608$
   1483 DD 34 E3      [23] 1002 	inc	-29 (ix)
   1486                    1003 00608$:
   1486 DD 7E DC      [19] 1004 	ld	a,-36 (ix)
   1489 DD 86 E2      [19] 1005 	add	a, -30 (ix)
   148C DD 77 E2      [19] 1006 	ld	-30 (ix),a
   148F DD 7E DD      [19] 1007 	ld	a,-35 (ix)
   1492 DD 8E E3      [19] 1008 	adc	a, -29 (ix)
   1495 DD 77 E3      [19] 1009 	ld	-29 (ix),a
   1498 DD 6E E2      [19] 1010 	ld	l,-30 (ix)
   149B DD 66 E3      [19] 1011 	ld	h,-29 (ix)
   149E 7E            [ 7] 1012 	ld	a,(hl)
   149F DD 77 E4      [19] 1013 	ld	-28 (ix),a
   14A2                    1014 00105$:
                           1015 ;src/Renderer.c:436: if(!(x%2)){
   14A2 DD 7E CD      [19] 1016 	ld	a,-51 (ix)
   14A5 E6 01         [ 7] 1017 	and	a, #0x01
   14A7 DD 77 E2      [19] 1018 	ld	-30 (ix),a
                           1019 ;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
   14AA DD 7E E4      [19] 1020 	ld	a,-28 (ix)
   14AD E6 80         [ 7] 1021 	and	a, #0x80
   14AF DD 77 EB      [19] 1022 	ld	-21 (ix),a
                           1023 ;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   14B2 DD 7E F3      [19] 1024 	ld	a,-13 (ix)
   14B5 DD 77 E0      [19] 1025 	ld	-32 (ix),a
   14B8 DD 36 E1 00   [19] 1026 	ld	-31 (ix),#0x00
   14BC DD 7E C7      [19] 1027 	ld	a,-57 (ix)
   14BF DD 77 E6      [19] 1028 	ld	-26 (ix),a
                           1029 ;src/Renderer.c:436: if(!(x%2)){
   14C2 DD 7E E2      [19] 1030 	ld	a,-30 (ix)
   14C5 B7            [ 4] 1031 	or	a, a
   14C6 C2 79 15      [10] 1032 	jp	NZ,00118$
                           1033 ;src/Renderer.c:437: if ((lateralWallCounter == 0)||newCell)
   14C9 DD 7E DA      [19] 1034 	ld	a,-38 (ix)
   14CC B7            [ 4] 1035 	or	a, a
   14CD 28 07         [12] 1036 	jr	Z,00114$
   14CF DD 7E E5      [19] 1037 	ld	a,-27 (ix)
   14D2 B7            [ 4] 1038 	or	a, a
   14D3 CA 79 15      [10] 1039 	jp	Z,00118$
   14D6                    1040 00114$:
                           1041 ;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
   14D6 DD 7E EB      [19] 1042 	ld	a,-21 (ix)
   14D9 B7            [ 4] 1043 	or	a, a
   14DA 28 22         [12] 1044 	jr	Z,00112$
                           1045 ;src/Renderer.c:441: lateralWallCounter = 0;//(zHeight - xCellCount);
   14DC DD 36 DA 00   [19] 1046 	ld	-38 (ix),#0x00
                           1047 ;src/Renderer.c:442: lateralWallSlope = 0;
   14E0 DD 36 F6 00   [19] 1048 	ld	-10 (ix),#0x00
                           1049 ;src/Renderer.c:443: xHeight = zHeight;
   14E4 DD 7E C7      [19] 1050 	ld	a,-57 (ix)
   14E7 DD 77 FD      [19] 1051 	ld	-3 (ix),a
                           1052 ;src/Renderer.c:444: color = currentCellID&0b01111111;
   14EA DD 7E E4      [19] 1053 	ld	a,-28 (ix)
   14ED E6 7F         [ 7] 1054 	and	a, #0x7F
   14EF DD 77 F7      [19] 1055 	ld	-9 (ix),a
                           1056 ;src/Renderer.c:445: lastCellWasWall = 1;
   14F2 DD 36 DB 01   [19] 1057 	ld	-37 (ix),#0x01
                           1058 ;src/Renderer.c:446: lastWallId=currentCellID;
   14F6 DD 7E E4      [19] 1059 	ld	a,-28 (ix)
   14F9 DD 77 D7      [19] 1060 	ld	-41 (ix),a
   14FC 18 77         [12] 1061 	jr	00113$
   14FE                    1062 00112$:
                           1063 ;src/Renderer.c:449: if(lateralWallCounter==0){//Lateral wall not finished
   14FE DD 7E DA      [19] 1064 	ld	a,-38 (ix)
   1501 B7            [ 4] 1065 	or	a, a
   1502 20 71         [12] 1066 	jr	NZ,00113$
                           1067 ;src/Renderer.c:450: if (lastCellWasWall)
   1504 DD 7E DB      [19] 1068 	ld	a,-37 (ix)
   1507 B7            [ 4] 1069 	or	a, a
   1508 28 5B         [12] 1070 	jr	Z,00107$
                           1071 ;src/Renderer.c:453: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   150A DD 7E CE      [19] 1072 	ld	a,-50 (ix)
   150D DD 96 D4      [19] 1073 	sub	a, -44 (ix)
   1510 87            [ 4] 1074 	add	a, a
   1511 3C            [ 4] 1075 	inc	a
                           1076 ;src/Renderer.c:454: lateralWallSlopeCounter = lateralWallSlope / 2;
   1512 DD 77 F6      [19] 1077 	ld	-10 (ix), a
   1515 CB 3F         [ 8] 1078 	srl	a
   1517 DD 77 F8      [19] 1079 	ld	-8 (ix),a
                           1080 ;src/Renderer.c:455: lateralWallCounter = lateralWallSlope * zHeight;
   151A DD 5E C7      [19] 1081 	ld	e,-57 (ix)
   151D DD 66 F6      [19] 1082 	ld	h,-10 (ix)
   1520 2E 00         [ 7] 1083 	ld	l, #0x00
   1522 55            [ 4] 1084 	ld	d, l
   1523 06 08         [ 7] 1085 	ld	b, #0x08
   1525                    1086 00609$:
   1525 29            [11] 1087 	add	hl,hl
   1526 30 01         [12] 1088 	jr	NC,00610$
   1528 19            [11] 1089 	add	hl,de
   1529                    1090 00610$:
   1529 10 FA         [13] 1091 	djnz	00609$
                           1092 ;src/Renderer.c:456: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   152B 7D            [ 4] 1093 	ld	a,l
   152C E6 FC         [ 7] 1094 	and	a, #0xFC
   152E CB C7         [ 8] 1095 	set	0, a
   1530 CB 3F         [ 8] 1096 	srl	a
   1532 CB 3F         [ 8] 1097 	srl	a
   1534 DD 96 F3      [19] 1098 	sub	a, -13 (ix)
                           1099 ;src/Renderer.c:457: lateralWallWidth=lateralWallCounter;
   1537 DD 77 DA      [19] 1100 	ld	-38 (ix), a
   153A DD 77 D3      [19] 1101 	ld	-45 (ix),a
                           1102 ;src/Renderer.c:458: lastCellWasWall = 0;
   153D DD 36 DB 00   [19] 1103 	ld	-37 (ix),#0x00
                           1104 ;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1541 DD 6E E0      [19] 1105 	ld	l,-32 (ix)
   1544 DD 66 E1      [19] 1106 	ld	h,-31 (ix)
   1547 29            [11] 1107 	add	hl, hl
   1548 DD 4E F6      [19] 1108 	ld	c,-10 (ix)
   154B 06 00         [ 7] 1109 	ld	b,#0x00
   154D C5            [11] 1110 	push	bc
   154E E5            [11] 1111 	push	hl
   154F CD 1B 5A      [17] 1112 	call	__divsint
   1552 F1            [10] 1113 	pop	af
   1553 F1            [10] 1114 	pop	af
   1554 DD 7E E6      [19] 1115 	ld	a,-26 (ix)
   1557 95            [ 4] 1116 	sub	a, l
   1558 DD 77 FD      [19] 1117 	ld	-3 (ix),a
                           1118 ;src/Renderer.c:460: color = lastWallId&0b01111111;
   155B DD 7E D7      [19] 1119 	ld	a,-41 (ix)
   155E E6 7F         [ 7] 1120 	and	a, #0x7F
   1560 DD 77 F7      [19] 1121 	ld	-9 (ix),a
   1563 18 10         [12] 1122 	jr	00113$
   1565                    1123 00107$:
                           1124 ;src/Renderer.c:464: xHeight = 0;
   1565 DD 36 FD 00   [19] 1125 	ld	-3 (ix),#0x00
                           1126 ;src/Renderer.c:465: lastCellWasWall = 0;
   1569 DD 36 DB 00   [19] 1127 	ld	-37 (ix),#0x00
                           1128 ;src/Renderer.c:466: lateralWallSlope=0;
   156D DD 36 F6 00   [19] 1129 	ld	-10 (ix),#0x00
                           1130 ;src/Renderer.c:467: lastWallId=0;
   1571 DD 36 D7 00   [19] 1131 	ld	-41 (ix),#0x00
   1575                    1132 00113$:
                           1133 ;src/Renderer.c:471: newCell=0;
   1575 DD 36 E5 00   [19] 1134 	ld	-27 (ix),#0x00
   1579                    1135 00118$:
                           1136 ;src/Renderer.c:474: if (lateralWallCounter > 0)
   1579 DD 7E DA      [19] 1137 	ld	a,-38 (ix)
   157C B7            [ 4] 1138 	or	a, a
   157D 28 1E         [12] 1139 	jr	Z,00124$
                           1140 ;src/Renderer.c:477: if (lateralWallSlope != 0)
   157F DD 7E F6      [19] 1141 	ld	a,-10 (ix)
   1582 B7            [ 4] 1142 	or	a, a
   1583 28 15         [12] 1143 	jr	Z,00122$
                           1144 ;src/Renderer.c:479: if (lateralWallSlopeCounter == lateralWallSlope)
   1585 DD 7E F8      [19] 1145 	ld	a,-8 (ix)
   1588 DD 96 F6      [19] 1146 	sub	a, -10 (ix)
   158B 20 0A         [12] 1147 	jr	NZ,00120$
                           1148 ;src/Renderer.c:481: lateralWallSlopeCounter = 0;
   158D DD 36 F8 00   [19] 1149 	ld	-8 (ix),#0x00
                           1150 ;src/Renderer.c:482: xHeight -= 2;
   1591 DD 35 FD      [23] 1151 	dec	-3 (ix)
   1594 DD 35 FD      [23] 1152 	dec	-3 (ix)
   1597                    1153 00120$:
                           1154 ;src/Renderer.c:484: ++lateralWallSlopeCounter;
   1597 DD 34 F8      [23] 1155 	inc	-8 (ix)
   159A                    1156 00122$:
                           1157 ;src/Renderer.c:487: --lateralWallCounter;
   159A DD 35 DA      [23] 1158 	dec	-38 (ix)
   159D                    1159 00124$:
                           1160 ;src/Renderer.c:498: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   159D DD 7E C7      [19] 1161 	ld	a,-57 (ix)
   15A0 DD 77 FB      [19] 1162 	ld	-5 (ix),a
   15A3 DD 36 FC 00   [19] 1163 	ld	-4 (ix),#0x00
                           1164 ;src/Renderer.c:490: if (!(x%2))
   15A7 DD 7E E2      [19] 1165 	ld	a,-30 (ix)
   15AA B7            [ 4] 1166 	or	a, a
   15AB C2 2C 16      [10] 1167 	jp	NZ,00136$
                           1168 ;src/Renderer.c:500: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   15AE DD 46 CD      [19] 1169 	ld	b,-51 (ix)
   15B1 CB 38         [ 8] 1170 	srl	b
                           1171 ;src/Renderer.c:498: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   15B3 DD 6E E0      [19] 1172 	ld	l,-32 (ix)
   15B6 DD 66 E1      [19] 1173 	ld	h,-31 (ix)
   15B9 29            [11] 1174 	add	hl, hl
   15BA 29            [11] 1175 	add	hl, hl
   15BB 29            [11] 1176 	add	hl, hl
   15BC 29            [11] 1177 	add	hl, hl
   15BD 29            [11] 1178 	add	hl, hl
   15BE C5            [11] 1179 	push	bc
   15BF DD 5E FB      [19] 1180 	ld	e,-5 (ix)
   15C2 DD 56 FC      [19] 1181 	ld	d,-4 (ix)
   15C5 D5            [11] 1182 	push	de
   15C6 E5            [11] 1183 	push	hl
   15C7 CD 1B 5A      [17] 1184 	call	__divsint
   15CA F1            [10] 1185 	pop	af
   15CB F1            [10] 1186 	pop	af
   15CC C1            [10] 1187 	pop	bc
   15CD 4D            [ 4] 1188 	ld	c,l
                           1189 ;src/Renderer.c:492: if(xHeight > 0){
   15CE DD 7E FD      [19] 1190 	ld	a,-3 (ix)
   15D1 B7            [ 4] 1191 	or	a, a
   15D2 28 3A         [12] 1192 	jr	Z,00129$
                           1193 ;src/Renderer.c:493: if (lateralWallCounter > 0)
   15D4 DD 7E DA      [19] 1194 	ld	a,-38 (ix)
   15D7 B7            [ 4] 1195 	or	a, a
   15D8 28 21         [12] 1196 	jr	Z,00126$
                           1197 ;src/Renderer.c:495: tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   15DA DD 5E D3      [19] 1198 	ld	e,-45 (ix)
   15DD 16 00         [ 7] 1199 	ld	d,#0x00
   15DF DD 6E DA      [19] 1200 	ld	l,-38 (ix)
   15E2 26 00         [ 7] 1201 	ld	h,#0x00
   15E4 7B            [ 4] 1202 	ld	a,e
   15E5 95            [ 4] 1203 	sub	a, l
   15E6 6F            [ 4] 1204 	ld	l,a
   15E7 7A            [ 4] 1205 	ld	a,d
   15E8 9C            [ 4] 1206 	sbc	a, h
   15E9 67            [ 4] 1207 	ld	h,a
   15EA 29            [11] 1208 	add	hl, hl
   15EB 29            [11] 1209 	add	hl, hl
   15EC 29            [11] 1210 	add	hl, hl
   15ED 29            [11] 1211 	add	hl, hl
   15EE 29            [11] 1212 	add	hl, hl
   15EF C5            [11] 1213 	push	bc
   15F0 D5            [11] 1214 	push	de
   15F1 E5            [11] 1215 	push	hl
   15F2 CD 1B 5A      [17] 1216 	call	__divsint
   15F5 F1            [10] 1217 	pop	af
   15F6 F1            [10] 1218 	pop	af
   15F7 C1            [10] 1219 	pop	bc
   15F8 55            [ 4] 1220 	ld	d,l
   15F9 18 01         [12] 1221 	jr	00127$
   15FB                    1222 00126$:
                           1223 ;src/Renderer.c:498: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   15FB 51            [ 4] 1224 	ld	d,c
   15FC                    1225 00127$:
                           1226 ;src/Renderer.c:500: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   15FC C5            [11] 1227 	push	bc
   15FD D5            [11] 1228 	push	de
   15FE 33            [ 6] 1229 	inc	sp
   15FF DD 66 F7      [19] 1230 	ld	h,-9 (ix)
   1602 DD 6E FD      [19] 1231 	ld	l,-3 (ix)
   1605 E5            [11] 1232 	push	hl
   1606 C5            [11] 1233 	push	bc
   1607 33            [ 6] 1234 	inc	sp
   1608 CD 3A 12      [17] 1235 	call	_draw_column_to_buffer
   160B F1            [10] 1236 	pop	af
   160C F1            [10] 1237 	pop	af
   160D C1            [10] 1238 	pop	bc
   160E                    1239 00129$:
                           1240 ;src/Renderer.c:502: if(!(currentCellID&CELL_WALL_MASK)){
   160E DD 7E EB      [19] 1241 	ld	a,-21 (ix)
   1611 B7            [ 4] 1242 	or	a, a
   1612 20 18         [12] 1243 	jr	NZ,00136$
                           1244 ;src/Renderer.c:503: if(currentCellID&CELL_ENEMY_MASK){
   1614 DD 7E E4      [19] 1245 	ld	a,-28 (ix)
   1617 E6 0F         [ 7] 1246 	and	a, #0x0F
   1619 28 11         [12] 1247 	jr	Z,00136$
                           1248 ;src/Renderer.c:504: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   161B 79            [ 4] 1249 	ld	a,c
   161C F5            [11] 1250 	push	af
   161D 33            [ 6] 1251 	inc	sp
   161E DD 66 E4      [19] 1252 	ld	h,-28 (ix)
   1621 DD 6E C7      [19] 1253 	ld	l,-57 (ix)
   1624 E5            [11] 1254 	push	hl
   1625 C5            [11] 1255 	push	bc
   1626 33            [ 6] 1256 	inc	sp
   1627 CD F7 10      [17] 1257 	call	_draw_column_to_buffer_enemy
   162A F1            [10] 1258 	pop	af
   162B F1            [10] 1259 	pop	af
                           1260 ;src/Renderer.c:506: else if(currentCellID&CELL_ITEM_MASK){
   162C                    1261 00136$:
                           1262 ;src/Renderer.c:512: ++xCellCount;
   162C DD 34 F3      [23] 1263 	inc	-13 (ix)
                           1264 ;src/Renderer.c:427: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   162F DD 34 CD      [23] 1265 	inc	-51 (ix)
                           1266 ;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
   1632 2A 79 10      [16] 1267 	ld	hl,(_cells_in_view_array)
   1635 DD 75 DC      [19] 1268 	ld	-36 (ix),l
   1638 DD 74 DD      [19] 1269 	ld	-35 (ix),h
                           1270 ;src/Renderer.c:427: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   163B DD 7E CD      [19] 1271 	ld	a,-51 (ix)
   163E D6 50         [ 7] 1272 	sub	a, #0x50
   1640 DA 4F 14      [10] 1273 	jp	C,00252$
                           1274 ;src/Renderer.c:519: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   1643 DD 7E CB      [19] 1275 	ld	a,-53 (ix)
   1646 B7            [ 4] 1276 	or	a, a
   1647 28 05         [12] 1277 	jr	Z,00264$
   1649 DD 4E EE      [19] 1278 	ld	c,-18 (ix)
   164C 18 02         [12] 1279 	jr	00265$
   164E                    1280 00264$:
   164E 0E 00         [ 7] 1281 	ld	c,#0x00
   1650                    1282 00265$:
   1650 DD 71 E0      [19] 1283 	ld	-32 (ix),c
                           1284 ;src/Renderer.c:520: lateralWallSlope=0;
   1653 DD 36 EB 00   [19] 1285 	ld	-21 (ix),#0x00
                           1286 ;src/Renderer.c:521: lateralWallSlopeCounter=0;
   1657 DD 36 E2 00   [19] 1287 	ld	-30 (ix),#0x00
                           1288 ;src/Renderer.c:522: xHeight=0;
   165B DD 36 DB 00   [19] 1289 	ld	-37 (ix),#0x00
                           1290 ;src/Renderer.c:524: lateralWallCounter = 0;
   165F DD 36 D7 00   [19] 1291 	ld	-41 (ix),#0x00
                           1292 ;src/Renderer.c:525: lineEnd = lineStart + offsetDiff * 2 + 2;
   1663 DD 7E CE      [19] 1293 	ld	a,-50 (ix)
   1666 87            [ 4] 1294 	add	a, a
   1667 4F            [ 4] 1295 	ld	c,a
   1668 DD 7E D5      [19] 1296 	ld	a,-43 (ix)
   166B 81            [ 4] 1297 	add	a, c
   166C DD 77 E4      [19] 1298 	ld	-28 (ix), a
   166F 4F            [ 4] 1299 	ld	c, a
   1670 0C            [ 4] 1300 	inc	c
   1671 0C            [ 4] 1301 	inc	c
                           1302 ;src/Renderer.c:527: newCell=1;
   1672 DD 36 E9 01   [19] 1303 	ld	-23 (ix),#0x01
                           1304 ;src/Renderer.c:528: currentCellID = cells_in_view_array[lineEnd - 1];
   1676 DD 71 FE      [19] 1305 	ld	-2 (ix),c
   1679 DD 36 FF 00   [19] 1306 	ld	-1 (ix),#0x00
   167D DD 5E FE      [19] 1307 	ld	e,-2 (ix)
   1680 DD 56 FF      [19] 1308 	ld	d,-1 (ix)
   1683 1B            [ 6] 1309 	dec	de
   1684 DD 6E DC      [19] 1310 	ld	l,-36 (ix)
   1687 DD 66 DD      [19] 1311 	ld	h,-35 (ix)
   168A 19            [11] 1312 	add	hl,de
   168B 7E            [ 7] 1313 	ld	a,(hl)
   168C DD 77 E5      [19] 1314 	ld	-27 (ix),a
                           1315 ;src/Renderer.c:530: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   168F DD 6E DC      [19] 1316 	ld	l,-36 (ix)
   1692 DD 66 DD      [19] 1317 	ld	h,-35 (ix)
   1695 06 00         [ 7] 1318 	ld	b,#0x00
   1697 09            [11] 1319 	add	hl, bc
   1698 4E            [ 7] 1320 	ld	c,(hl)
                           1321 ;src/Renderer.c:531: if(lastCellWasWall&CELL_WALL_MASK){
   1699 CB 79         [ 8] 1322 	bit	7, c
   169B 28 09         [12] 1323 	jr	Z,00139$
                           1324 ;src/Renderer.c:532: lastWallId=lastCellWasWall;
   169D DD 71 DA      [19] 1325 	ld	-38 (ix),c
                           1326 ;src/Renderer.c:533: lastCellWasWall=1;
   16A0 DD 36 FD 01   [19] 1327 	ld	-3 (ix),#0x01
   16A4 18 08         [12] 1328 	jr	00315$
   16A6                    1329 00139$:
                           1330 ;src/Renderer.c:536: lastCellWasWall=0;
   16A6 DD 36 FD 00   [19] 1331 	ld	-3 (ix),#0x00
                           1332 ;src/Renderer.c:537: lastWallId=CELLTYPE_FLOOR;
   16AA DD 36 DA 00   [19] 1333 	ld	-38 (ix),#0x00
                           1334 ;src/Renderer.c:540: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   16AE                    1335 00315$:
   16AE DD 36 D4 00   [19] 1336 	ld	-44 (ix),#0x00
   16B2 DD 36 CD 9F   [19] 1337 	ld	-51 (ix),#0x9F
   16B6                    1338 00254$:
                           1339 ;src/Renderer.c:543: if (xCellCount == zHeight)
   16B6 DD 7E C7      [19] 1340 	ld	a,-57 (ix)
   16B9 DD 96 E0      [19] 1341 	sub	a, -32 (ix)
   16BC 20 50         [12] 1342 	jr	NZ,00142$
                           1343 ;src/Renderer.c:545: ++xCell;
   16BE DD 34 D4      [23] 1344 	inc	-44 (ix)
                           1345 ;src/Renderer.c:546: xCellCount = 0;
   16C1 DD 36 E0 00   [19] 1346 	ld	-32 (ix),#0x00
                           1347 ;src/Renderer.c:547: newCell=1;
   16C5 DD 36 E9 01   [19] 1348 	ld	-23 (ix),#0x01
                           1349 ;src/Renderer.c:548: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   16C9 DD 7E D4      [19] 1350 	ld	a,-44 (ix)
   16CC DD 77 D8      [19] 1351 	ld	-40 (ix),a
   16CF DD 36 D9 00   [19] 1352 	ld	-39 (ix),#0x00
   16D3 DD 7E FE      [19] 1353 	ld	a,-2 (ix)
   16D6 DD 96 D8      [19] 1354 	sub	a, -40 (ix)
   16D9 DD 77 D8      [19] 1355 	ld	-40 (ix),a
   16DC DD 7E FF      [19] 1356 	ld	a,-1 (ix)
   16DF DD 9E D9      [19] 1357 	sbc	a, -39 (ix)
   16E2 DD 77 D9      [19] 1358 	ld	-39 (ix),a
   16E5 DD 6E D8      [19] 1359 	ld	l,-40 (ix)
   16E8 DD 66 D9      [19] 1360 	ld	h,-39 (ix)
   16EB 2B            [ 6] 1361 	dec	hl
   16EC DD 75 D8      [19] 1362 	ld	-40 (ix),l
   16EF DD 74 D9      [19] 1363 	ld	-39 (ix),h
   16F2 DD 7E DC      [19] 1364 	ld	a,-36 (ix)
   16F5 DD 86 D8      [19] 1365 	add	a, -40 (ix)
   16F8 DD 77 D8      [19] 1366 	ld	-40 (ix),a
   16FB DD 7E DD      [19] 1367 	ld	a,-35 (ix)
   16FE DD 8E D9      [19] 1368 	adc	a, -39 (ix)
   1701 DD 77 D9      [19] 1369 	ld	-39 (ix),a
   1704 DD 6E D8      [19] 1370 	ld	l,-40 (ix)
   1707 DD 66 D9      [19] 1371 	ld	h,-39 (ix)
   170A 7E            [ 7] 1372 	ld	a,(hl)
   170B DD 77 E5      [19] 1373 	ld	-27 (ix),a
   170E                    1374 00142$:
                           1375 ;src/Renderer.c:550: if(!(x%2)){
   170E DD 7E CD      [19] 1376 	ld	a,-51 (ix)
   1711 E6 01         [ 7] 1377 	and	a, #0x01
   1713 DD 77 D8      [19] 1378 	ld	-40 (ix),a
                           1379 ;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
   1716 DD 7E E5      [19] 1380 	ld	a,-27 (ix)
   1719 E6 80         [ 7] 1381 	and	a, #0x80
   171B DD 77 F8      [19] 1382 	ld	-8 (ix),a
                           1383 ;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   171E DD 7E E0      [19] 1384 	ld	a,-32 (ix)
   1721 DD 77 DE      [19] 1385 	ld	-34 (ix),a
   1724 DD 36 DF 00   [19] 1386 	ld	-33 (ix),#0x00
                           1387 ;src/Renderer.c:550: if(!(x%2)){
   1728 DD 7E D8      [19] 1388 	ld	a,-40 (ix)
   172B B7            [ 4] 1389 	or	a, a
   172C C2 FE 17      [10] 1390 	jp	NZ,00155$
                           1391 ;src/Renderer.c:551: if (lateralWallCounter == 0 || newCell)
   172F DD 7E D7      [19] 1392 	ld	a,-41 (ix)
   1732 B7            [ 4] 1393 	or	a, a
   1733 28 07         [12] 1394 	jr	Z,00151$
   1735 DD 7E E9      [19] 1395 	ld	a,-23 (ix)
   1738 B7            [ 4] 1396 	or	a, a
   1739 CA FE 17      [10] 1397 	jp	Z,00155$
   173C                    1398 00151$:
                           1399 ;src/Renderer.c:553: if ( currentCellID & CELL_WALL_MASK)//Wall
   173C DD 7E F8      [19] 1400 	ld	a,-8 (ix)
   173F B7            [ 4] 1401 	or	a, a
   1740 28 23         [12] 1402 	jr	Z,00149$
                           1403 ;src/Renderer.c:555: lateralWallCounter = 0;
   1742 DD 36 D7 00   [19] 1404 	ld	-41 (ix),#0x00
                           1405 ;src/Renderer.c:556: lateralWallSlope = 0;
   1746 DD 36 EB 00   [19] 1406 	ld	-21 (ix),#0x00
                           1407 ;src/Renderer.c:557: xHeight = zHeight;
   174A DD 7E C7      [19] 1408 	ld	a,-57 (ix)
   174D DD 77 DB      [19] 1409 	ld	-37 (ix),a
                           1410 ;src/Renderer.c:558: color = currentCellID&0b01111111;
   1750 DD 7E E5      [19] 1411 	ld	a,-27 (ix)
   1753 E6 7F         [ 7] 1412 	and	a, #0x7F
   1755 DD 77 F7      [19] 1413 	ld	-9 (ix),a
                           1414 ;src/Renderer.c:559: lastCellWasWall = 1;
   1758 DD 36 FD 01   [19] 1415 	ld	-3 (ix),#0x01
                           1416 ;src/Renderer.c:560: lastWallId=currentCellID;
   175C DD 7E E5      [19] 1417 	ld	a,-27 (ix)
   175F DD 77 DA      [19] 1418 	ld	-38 (ix),a
   1762 C3 FA 17      [10] 1419 	jp	00150$
   1765                    1420 00149$:
                           1421 ;src/Renderer.c:562: else if(lateralWallCounter==0){
   1765 DD 7E D7      [19] 1422 	ld	a,-41 (ix)
   1768 B7            [ 4] 1423 	or	a, a
   1769 C2 FA 17      [10] 1424 	jp	NZ,00150$
                           1425 ;src/Renderer.c:563: if (lastCellWasWall)
   176C DD 7E FD      [19] 1426 	ld	a,-3 (ix)
   176F B7            [ 4] 1427 	or	a, a
   1770 28 78         [12] 1428 	jr	Z,00144$
                           1429 ;src/Renderer.c:566: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   1772 DD 7E CE      [19] 1430 	ld	a,-50 (ix)
   1775 DD 96 D4      [19] 1431 	sub	a, -44 (ix)
   1778 87            [ 4] 1432 	add	a, a
   1779 3C            [ 4] 1433 	inc	a
                           1434 ;src/Renderer.c:567: lateralWallSlopeCounter = lateralWallSlope / 2;
   177A DD 77 EB      [19] 1435 	ld	-21 (ix), a
   177D CB 3F         [ 8] 1436 	srl	a
   177F DD 77 E2      [19] 1437 	ld	-30 (ix),a
                           1438 ;src/Renderer.c:568: lateralWallCounter = lateralWallSlope * zHeight;
   1782 DD 5E C7      [19] 1439 	ld	e,-57 (ix)
   1785 DD 66 EB      [19] 1440 	ld	h,-21 (ix)
   1788 2E 00         [ 7] 1441 	ld	l, #0x00
   178A 55            [ 4] 1442 	ld	d, l
   178B 06 08         [ 7] 1443 	ld	b, #0x08
   178D                    1444 00617$:
   178D 29            [11] 1445 	add	hl,hl
   178E 30 01         [12] 1446 	jr	NC,00618$
   1790 19            [11] 1447 	add	hl,de
   1791                    1448 00618$:
   1791 10 FA         [13] 1449 	djnz	00617$
                           1450 ;src/Renderer.c:569: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   1793 4D            [ 4] 1451 	ld	c,l
   1794 06 00         [ 7] 1452 	ld	b,#0x00
   1796 7D            [ 4] 1453 	ld	a,l
   1797 E6 03         [ 7] 1454 	and	a, #0x03
   1799 5F            [ 4] 1455 	ld	e,a
   179A 16 00         [ 7] 1456 	ld	d,#0x00
   179C 79            [ 4] 1457 	ld	a,c
   179D 93            [ 4] 1458 	sub	a, e
   179E 4F            [ 4] 1459 	ld	c,a
   179F 78            [ 4] 1460 	ld	a,b
   17A0 9A            [ 4] 1461 	sbc	a, d
   17A1 47            [ 4] 1462 	ld	b,a
   17A2 59            [ 4] 1463 	ld	e, c
   17A3 50            [ 4] 1464 	ld	d, b
   17A4 13            [ 6] 1465 	inc	de
   17A5 6B            [ 4] 1466 	ld	l, e
   17A6 62            [ 4] 1467 	ld	h, d
   17A7 CB 7A         [ 8] 1468 	bit	7, d
   17A9 28 04         [12] 1469 	jr	Z,00266$
   17AB 21 04 00      [10] 1470 	ld	hl,#0x0004
   17AE 09            [11] 1471 	add	hl,bc
   17AF                    1472 00266$:
   17AF CB 2C         [ 8] 1473 	sra	h
   17B1 CB 1D         [ 8] 1474 	rr	l
   17B3 CB 2C         [ 8] 1475 	sra	h
   17B5 CB 1D         [ 8] 1476 	rr	l
   17B7 DD 4E E0      [19] 1477 	ld	c,-32 (ix)
   17BA 7D            [ 4] 1478 	ld	a,l
   17BB 91            [ 4] 1479 	sub	a, c
                           1480 ;src/Renderer.c:570: lateralWallWidth=lateralWallCounter;
   17BC DD 77 D7      [19] 1481 	ld	-41 (ix), a
   17BF DD 77 D3      [19] 1482 	ld	-45 (ix),a
                           1483 ;src/Renderer.c:571: lastCellWasWall = 0;
   17C2 DD 36 FD 00   [19] 1484 	ld	-3 (ix),#0x00
                           1485 ;src/Renderer.c:572: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   17C6 DD 6E DE      [19] 1486 	ld	l,-34 (ix)
   17C9 DD 66 DF      [19] 1487 	ld	h,-33 (ix)
   17CC 29            [11] 1488 	add	hl, hl
   17CD DD 4E EB      [19] 1489 	ld	c,-21 (ix)
   17D0 06 00         [ 7] 1490 	ld	b,#0x00
   17D2 C5            [11] 1491 	push	bc
   17D3 E5            [11] 1492 	push	hl
   17D4 CD 1B 5A      [17] 1493 	call	__divsint
   17D7 F1            [10] 1494 	pop	af
   17D8 F1            [10] 1495 	pop	af
   17D9 DD 7E E6      [19] 1496 	ld	a,-26 (ix)
   17DC 95            [ 4] 1497 	sub	a, l
   17DD DD 77 DB      [19] 1498 	ld	-37 (ix),a
                           1499 ;src/Renderer.c:573: color = lastWallId&0b01111111;
   17E0 DD 7E DA      [19] 1500 	ld	a,-38 (ix)
   17E3 E6 7F         [ 7] 1501 	and	a, #0x7F
   17E5 DD 77 F7      [19] 1502 	ld	-9 (ix),a
   17E8 18 10         [12] 1503 	jr	00150$
   17EA                    1504 00144$:
                           1505 ;src/Renderer.c:577: xHeight = 0;
   17EA DD 36 DB 00   [19] 1506 	ld	-37 (ix),#0x00
                           1507 ;src/Renderer.c:578: lastCellWasWall = 0;
   17EE DD 36 FD 00   [19] 1508 	ld	-3 (ix),#0x00
                           1509 ;src/Renderer.c:579: lateralWallSlope=0;
   17F2 DD 36 EB 00   [19] 1510 	ld	-21 (ix),#0x00
                           1511 ;src/Renderer.c:580: lastWallId=0;
   17F6 DD 36 DA 00   [19] 1512 	ld	-38 (ix),#0x00
   17FA                    1513 00150$:
                           1514 ;src/Renderer.c:583: newCell=0;
   17FA DD 36 E9 00   [19] 1515 	ld	-23 (ix),#0x00
   17FE                    1516 00155$:
                           1517 ;src/Renderer.c:588: if (lateralWallCounter > 0)
   17FE DD 7E D7      [19] 1518 	ld	a,-41 (ix)
   1801 B7            [ 4] 1519 	or	a, a
   1802 28 1E         [12] 1520 	jr	Z,00161$
                           1521 ;src/Renderer.c:591: if (lateralWallSlope != 0)
   1804 DD 7E EB      [19] 1522 	ld	a,-21 (ix)
   1807 B7            [ 4] 1523 	or	a, a
   1808 28 15         [12] 1524 	jr	Z,00159$
                           1525 ;src/Renderer.c:593: if (lateralWallSlopeCounter == lateralWallSlope)
   180A DD 7E EB      [19] 1526 	ld	a,-21 (ix)
   180D DD 96 E2      [19] 1527 	sub	a, -30 (ix)
   1810 20 0A         [12] 1528 	jr	NZ,00157$
                           1529 ;src/Renderer.c:595: lateralWallSlopeCounter = 0;
   1812 DD 36 E2 00   [19] 1530 	ld	-30 (ix),#0x00
                           1531 ;src/Renderer.c:596: xHeight -= 2;
   1816 DD 35 DB      [23] 1532 	dec	-37 (ix)
   1819 DD 35 DB      [23] 1533 	dec	-37 (ix)
   181C                    1534 00157$:
                           1535 ;src/Renderer.c:598: ++lateralWallSlopeCounter;
   181C DD 34 E2      [23] 1536 	inc	-30 (ix)
   181F                    1537 00159$:
                           1538 ;src/Renderer.c:600: --lateralWallCounter;
   181F DD 35 D7      [23] 1539 	dec	-41 (ix)
   1822                    1540 00161$:
                           1541 ;src/Renderer.c:604: if (!(x%2))
   1822 DD 7E D8      [19] 1542 	ld	a,-40 (ix)
   1825 B7            [ 4] 1543 	or	a, a
   1826 C2 E9 18      [10] 1544 	jp	NZ,00173$
                           1545 ;src/Renderer.c:617: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   1829 DD 7E CD      [19] 1546 	ld	a,-51 (ix)
   182C CB 3F         [ 8] 1547 	srl	a
   182E DD 77 D8      [19] 1548 	ld	-40 (ix),a
                           1549 ;src/Renderer.c:614: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   1831 DD 7E FB      [19] 1550 	ld	a,-5 (ix)
   1834 DD 96 DE      [19] 1551 	sub	a, -34 (ix)
   1837 DD 77 DE      [19] 1552 	ld	-34 (ix),a
   183A DD 7E FC      [19] 1553 	ld	a,-4 (ix)
   183D DD 9E DF      [19] 1554 	sbc	a, -33 (ix)
   1840 DD 77 DF      [19] 1555 	ld	-33 (ix),a
   1843 3E 06         [ 7] 1556 	ld	a,#0x05+1
   1845 18 08         [12] 1557 	jr	00622$
   1847                    1558 00621$:
   1847 DD CB DE 26   [23] 1559 	sla	-34 (ix)
   184B DD CB DF 16   [23] 1560 	rl	-33 (ix)
   184F                    1561 00622$:
   184F 3D            [ 4] 1562 	dec	a
   1850 20 F5         [12] 1563 	jr	NZ,00621$
   1852 DD 6E FB      [19] 1564 	ld	l,-5 (ix)
   1855 DD 66 FC      [19] 1565 	ld	h,-4 (ix)
   1858 E5            [11] 1566 	push	hl
   1859 DD 6E DE      [19] 1567 	ld	l,-34 (ix)
   185C DD 66 DF      [19] 1568 	ld	h,-33 (ix)
   185F E5            [11] 1569 	push	hl
   1860 CD 1B 5A      [17] 1570 	call	__divsint
   1863 F1            [10] 1571 	pop	af
   1864 F1            [10] 1572 	pop	af
   1865 DD 74 DF      [19] 1573 	ld	-33 (ix),h
   1868 DD 75 DE      [19] 1574 	ld	-34 (ix), l
   186B DD 75 DE      [19] 1575 	ld	-34 (ix), l
                           1576 ;src/Renderer.c:607: if(xHeight > 0){
   186E DD 7E DB      [19] 1577 	ld	a,-37 (ix)
   1871 B7            [ 4] 1578 	or	a, a
   1872 28 55         [12] 1579 	jr	Z,00166$
                           1580 ;src/Renderer.c:609: if (lateralWallCounter > 0)
   1874 DD 7E D7      [19] 1581 	ld	a,-41 (ix)
   1877 B7            [ 4] 1582 	or	a, a
   1878 28 39         [12] 1583 	jr	Z,00163$
                           1584 ;src/Renderer.c:611: tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
   187A DD 7E D7      [19] 1585 	ld	a,-41 (ix)
   187D DD 77 EC      [19] 1586 	ld	-20 (ix),a
   1880 DD 36 ED 00   [19] 1587 	ld	-19 (ix),#0x00
   1884 3E 06         [ 7] 1588 	ld	a,#0x05+1
   1886 18 08         [12] 1589 	jr	00624$
   1888                    1590 00623$:
   1888 DD CB EC 26   [23] 1591 	sla	-20 (ix)
   188C DD CB ED 16   [23] 1592 	rl	-19 (ix)
   1890                    1593 00624$:
   1890 3D            [ 4] 1594 	dec	a
   1891 20 F5         [12] 1595 	jr	NZ,00623$
   1893 DD 7E D3      [19] 1596 	ld	a,-45 (ix)
   1896 DD 77 E7      [19] 1597 	ld	-25 (ix),a
   1899 DD 36 E8 00   [19] 1598 	ld	-24 (ix),#0x00
   189D DD 6E E7      [19] 1599 	ld	l,-25 (ix)
   18A0 DD 66 E8      [19] 1600 	ld	h,-24 (ix)
   18A3 E5            [11] 1601 	push	hl
   18A4 DD 6E EC      [19] 1602 	ld	l,-20 (ix)
   18A7 DD 66 ED      [19] 1603 	ld	h,-19 (ix)
   18AA E5            [11] 1604 	push	hl
   18AB CD 1B 5A      [17] 1605 	call	__divsint
   18AE F1            [10] 1606 	pop	af
   18AF F1            [10] 1607 	pop	af
   18B0 45            [ 4] 1608 	ld	b,l
   18B1 18 03         [12] 1609 	jr	00164$
   18B3                    1610 00163$:
                           1611 ;src/Renderer.c:614: tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
   18B3 DD 46 DE      [19] 1612 	ld	b,-34 (ix)
   18B6                    1613 00164$:
                           1614 ;src/Renderer.c:617: draw_column_to_buffer(x/2, xHeight, color,tex_column);
   18B6 C5            [11] 1615 	push	bc
   18B7 33            [ 6] 1616 	inc	sp
   18B8 DD 66 F7      [19] 1617 	ld	h,-9 (ix)
   18BB DD 6E DB      [19] 1618 	ld	l,-37 (ix)
   18BE E5            [11] 1619 	push	hl
   18BF DD 7E D8      [19] 1620 	ld	a,-40 (ix)
   18C2 F5            [11] 1621 	push	af
   18C3 33            [ 6] 1622 	inc	sp
   18C4 CD 3A 12      [17] 1623 	call	_draw_column_to_buffer
   18C7 F1            [10] 1624 	pop	af
   18C8 F1            [10] 1625 	pop	af
   18C9                    1626 00166$:
                           1627 ;src/Renderer.c:620: if(!(currentCellID&CELL_WALL_MASK)){
   18C9 DD 7E F8      [19] 1628 	ld	a,-8 (ix)
   18CC B7            [ 4] 1629 	or	a, a
   18CD 20 1A         [12] 1630 	jr	NZ,00173$
                           1631 ;src/Renderer.c:621: if(currentCellID&CELL_ENEMY_MASK){
   18CF DD 7E E5      [19] 1632 	ld	a,-27 (ix)
   18D2 E6 0F         [ 7] 1633 	and	a, #0x0F
   18D4 28 13         [12] 1634 	jr	Z,00173$
                           1635 ;src/Renderer.c:622: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   18D6 DD 66 DE      [19] 1636 	ld	h,-34 (ix)
   18D9 DD 6E E5      [19] 1637 	ld	l,-27 (ix)
   18DC E5            [11] 1638 	push	hl
   18DD DD 66 C7      [19] 1639 	ld	h,-57 (ix)
   18E0 DD 6E D8      [19] 1640 	ld	l,-40 (ix)
   18E3 E5            [11] 1641 	push	hl
   18E4 CD F7 10      [17] 1642 	call	_draw_column_to_buffer_enemy
   18E7 F1            [10] 1643 	pop	af
   18E8 F1            [10] 1644 	pop	af
                           1645 ;src/Renderer.c:624: else if(currentCellID&CELL_ITEM_MASK){
   18E9                    1646 00173$:
                           1647 ;src/Renderer.c:629: ++xCellCount;
   18E9 DD 34 E0      [23] 1648 	inc	-32 (ix)
                           1649 ;src/Renderer.c:540: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   18EC DD 35 CD      [23] 1650 	dec	-51 (ix)
                           1651 ;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
   18EF 2A 79 10      [16] 1652 	ld	hl,(_cells_in_view_array)
   18F2 DD 75 DC      [19] 1653 	ld	-36 (ix),l
   18F5 DD 74 DD      [19] 1654 	ld	-35 (ix),h
                           1655 ;src/Renderer.c:540: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   18F8 DD 7E CD      [19] 1656 	ld	a,-51 (ix)
   18FB D6 50         [ 7] 1657 	sub	a, #0x50
   18FD D2 B6 16      [10] 1658 	jp	NC,00254$
                           1659 ;src/Renderer.c:660: lineStart = lineStart + (offsetDiff * 2) + 3;
   1900 DD 7E E4      [19] 1660 	ld	a,-28 (ix)
   1903 C6 03         [ 7] 1661 	add	a, #0x03
   1905 DD 77 D5      [19] 1662 	ld	-43 (ix),a
                           1663 ;src/Renderer.c:661: zHeight += zHeight;
   1908 DD CB C7 26   [23] 1664 	sla	-57 (ix)
                           1665 ;src/Renderer.c:662: offsetDiff = offsetDiff >> 1;
   190C DD CB CE 3E   [23] 1666 	srl	-50 (ix)
                           1667 ;src/Renderer.c:664: }while(z);
   1910 DD 7E CB      [19] 1668 	ld	a,-53 (ix)
   1913 B7            [ 4] 1669 	or	a, a
   1914 C2 D9 13      [10] 1670 	jp	NZ,00175$
   1917 C3 C7 1E      [10] 1671 	jp	00260$
                           1672 ;src/Renderer.c:669: do{
   191A                    1673 00358$:
   191A DD 36 CB 06   [19] 1674 	ld	-53 (ix),#0x06
   191E                    1675 00246$:
                           1676 ;src/Renderer.c:671: --z;
   191E DD 35 CB      [23] 1677 	dec	-53 (ix)
                           1678 ;src/Renderer.c:406: xCellCount = (z) ? (zHeight >> 1) : 0;
   1921 DD 7E C7      [19] 1679 	ld	a,-57 (ix)
   1924 CB 3F         [ 8] 1680 	srl	a
   1926 DD 77 E7      [19] 1681 	ld	-25 (ix),a
                           1682 ;src/Renderer.c:675: xCellCount = (z) ? (zHeight >> 1) : 0;
   1929 DD 7E CB      [19] 1683 	ld	a,-53 (ix)
   192C B7            [ 4] 1684 	or	a, a
   192D 28 05         [12] 1685 	jr	Z,00267$
   192F DD 4E E7      [19] 1686 	ld	c,-25 (ix)
   1932 18 02         [12] 1687 	jr	00268$
   1934                    1688 00267$:
   1934 0E 00         [ 7] 1689 	ld	c,#0x00
   1936                    1690 00268$:
   1936 DD 71 CA      [19] 1691 	ld	-54 (ix),c
                           1692 ;src/Renderer.c:676: lateralWallSlope=0;
   1939 DD 36 C6 00   [19] 1693 	ld	-58 (ix),#0x00
                           1694 ;src/Renderer.c:677: lateralWallSlopeCounter=0;
   193D DD 36 CF 00   [19] 1695 	ld	-49 (ix),#0x00
                           1696 ;src/Renderer.c:678: xHeight=0;
   1941 DD 36 C8 00   [19] 1697 	ld	-56 (ix),#0x00
                           1698 ;src/Renderer.c:680: lateralWallCounter = 0;
   1945 DD 36 EC 00   [19] 1699 	ld	-20 (ix),#0x00
                           1700 ;src/Renderer.c:682: newCell=1;
   1949 DD 36 D0 01   [19] 1701 	ld	-48 (ix),#0x01
                           1702 ;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
   194D DD 7E D5      [19] 1703 	ld	a,-43 (ix)
   1950 DD 77 DE      [19] 1704 	ld	-34 (ix),a
   1953 DD 36 DF 00   [19] 1705 	ld	-33 (ix),#0x00
                           1706 ;src/Renderer.c:683: currentCellID = cells_in_view_array[lineStart + 1];
   1957 DD 4E DE      [19] 1707 	ld	c,-34 (ix)
   195A DD 46 DF      [19] 1708 	ld	b,-33 (ix)
   195D 03            [ 6] 1709 	inc	bc
   195E DD 6E DC      [19] 1710 	ld	l,-36 (ix)
   1961 DD 66 DD      [19] 1711 	ld	h,-35 (ix)
   1964 09            [11] 1712 	add	hl,bc
   1965 7E            [ 7] 1713 	ld	a,(hl)
   1966 DD 77 CC      [19] 1714 	ld	-52 (ix),a
                           1715 ;src/Renderer.c:685: lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
   1969 DD 7E DC      [19] 1716 	ld	a,-36 (ix)
   196C DD 86 D5      [19] 1717 	add	a, -43 (ix)
   196F 6F            [ 4] 1718 	ld	l,a
   1970 DD 7E DD      [19] 1719 	ld	a,-35 (ix)
   1973 CE 00         [ 7] 1720 	adc	a, #0x00
   1975 67            [ 4] 1721 	ld	h,a
   1976 4E            [ 7] 1722 	ld	c,(hl)
                           1723 ;src/Renderer.c:686: if(lastCellWasWall&CELL_WALL_MASK){
   1977 CB 79         [ 8] 1724 	bit	7, c
   1979 28 09         [12] 1725 	jr	Z,00179$
                           1726 ;src/Renderer.c:687: lastWallId=lastCellWasWall;
   197B DD 71 D2      [19] 1727 	ld	-46 (ix),c
                           1728 ;src/Renderer.c:688: lastCellWasWall=1;
   197E DD 36 D8 01   [19] 1729 	ld	-40 (ix),#0x01
   1982 18 08         [12] 1730 	jr	00336$
   1984                    1731 00179$:
                           1732 ;src/Renderer.c:691: lastCellWasWall=0;
   1984 DD 36 D8 00   [19] 1733 	ld	-40 (ix),#0x00
                           1734 ;src/Renderer.c:692: lastWallId=CELLTYPE_FLOOR;
   1988 DD 36 D2 00   [19] 1735 	ld	-46 (ix),#0x00
                           1736 ;src/Renderer.c:695: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   198C                    1737 00336$:
   198C DD 36 D4 00   [19] 1738 	ld	-44 (ix),#0x00
   1990 DD 36 CD 00   [19] 1739 	ld	-51 (ix),#0x00
   1994                    1740 00256$:
                           1741 ;src/Renderer.c:697: if (xCellCount == zHeight)
   1994 DD 7E CA      [19] 1742 	ld	a,-54 (ix)
   1997 DD 96 C7      [19] 1743 	sub	a, -57 (ix)
   199A 20 4B         [12] 1744 	jr	NZ,00182$
                           1745 ;src/Renderer.c:699: ++xCell;
   199C DD 34 D4      [23] 1746 	inc	-44 (ix)
                           1747 ;src/Renderer.c:700: xCellCount = 0;
   199F DD 36 CA 00   [19] 1748 	ld	-54 (ix),#0x00
                           1749 ;src/Renderer.c:701: newCell=1;
   19A3 DD 36 D0 01   [19] 1750 	ld	-48 (ix),#0x01
                           1751 ;src/Renderer.c:702: currentCellID=cells_in_view_array[xCell + lineStart + 1];
   19A7 DD 7E D4      [19] 1752 	ld	a,-44 (ix)
   19AA DD 77 FE      [19] 1753 	ld	-2 (ix),a
   19AD DD 36 FF 00   [19] 1754 	ld	-1 (ix),#0x00
   19B1 DD 7E DE      [19] 1755 	ld	a,-34 (ix)
   19B4 DD 86 FE      [19] 1756 	add	a, -2 (ix)
   19B7 DD 77 FE      [19] 1757 	ld	-2 (ix),a
   19BA DD 7E DF      [19] 1758 	ld	a,-33 (ix)
   19BD DD 8E FF      [19] 1759 	adc	a, -1 (ix)
   19C0 DD 77 FF      [19] 1760 	ld	-1 (ix),a
   19C3 DD 34 FE      [23] 1761 	inc	-2 (ix)
   19C6 20 03         [12] 1762 	jr	NZ,00629$
   19C8 DD 34 FF      [23] 1763 	inc	-1 (ix)
   19CB                    1764 00629$:
   19CB DD 7E FE      [19] 1765 	ld	a,-2 (ix)
   19CE DD 86 DC      [19] 1766 	add	a, -36 (ix)
   19D1 DD 77 FE      [19] 1767 	ld	-2 (ix),a
   19D4 DD 7E FF      [19] 1768 	ld	a,-1 (ix)
   19D7 DD 8E DD      [19] 1769 	adc	a, -35 (ix)
   19DA DD 77 FF      [19] 1770 	ld	-1 (ix),a
   19DD DD 6E FE      [19] 1771 	ld	l,-2 (ix)
   19E0 DD 66 FF      [19] 1772 	ld	h,-1 (ix)
   19E3 7E            [ 7] 1773 	ld	a,(hl)
   19E4 DD 77 CC      [19] 1774 	ld	-52 (ix),a
   19E7                    1775 00182$:
                           1776 ;src/Renderer.c:704: if(!(x%2)){
   19E7 DD 7E CD      [19] 1777 	ld	a,-51 (ix)
   19EA E6 01         [ 7] 1778 	and	a, #0x01
   19EC DD 77 FE      [19] 1779 	ld	-2 (ix),a
                           1780 ;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
   19EF DD 7E CC      [19] 1781 	ld	a,-52 (ix)
   19F2 E6 80         [ 7] 1782 	and	a, #0x80
   19F4 DD 77 FB      [19] 1783 	ld	-5 (ix),a
                           1784 ;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   19F7 DD 7E CA      [19] 1785 	ld	a,-54 (ix)
   19FA DD 77 E0      [19] 1786 	ld	-32 (ix),a
   19FD DD 36 E1 00   [19] 1787 	ld	-31 (ix),#0x00
   1A01 DD 7E C7      [19] 1788 	ld	a,-57 (ix)
   1A04 DD 77 F7      [19] 1789 	ld	-9 (ix),a
                           1790 ;src/Renderer.c:704: if(!(x%2)){
   1A07 DD 7E FE      [19] 1791 	ld	a,-2 (ix)
   1A0A B7            [ 4] 1792 	or	a, a
   1A0B C2 03 1B      [10] 1793 	jp	NZ,00195$
                           1794 ;src/Renderer.c:705: if ((lateralWallCounter == 0)||newCell)
   1A0E DD 7E EC      [19] 1795 	ld	a,-20 (ix)
   1A11 B7            [ 4] 1796 	or	a, a
   1A12 28 07         [12] 1797 	jr	Z,00191$
   1A14 DD 7E D0      [19] 1798 	ld	a,-48 (ix)
   1A17 B7            [ 4] 1799 	or	a, a
   1A18 CA 03 1B      [10] 1800 	jp	Z,00195$
   1A1B                    1801 00191$:
                           1802 ;src/Renderer.c:707: if (currentCellID & CELL_WALL_MASK)//Wall
   1A1B DD 7E FB      [19] 1803 	ld	a,-5 (ix)
   1A1E B7            [ 4] 1804 	or	a, a
   1A1F 28 2B         [12] 1805 	jr	Z,00189$
                           1806 ;src/Renderer.c:709: lateralWallCounter = 0;//(zHeight - xCellCount);
   1A21 DD 36 EC 00   [19] 1807 	ld	-20 (ix),#0x00
                           1808 ;src/Renderer.c:710: lateralWallSlope = 0;
   1A25 DD 36 C6 00   [19] 1809 	ld	-58 (ix),#0x00
                           1810 ;src/Renderer.c:711: xHeight = zHeight;
   1A29 DD 7E C7      [19] 1811 	ld	a,-57 (ix)
   1A2C DD 77 C8      [19] 1812 	ld	-56 (ix),a
                           1813 ;src/Renderer.c:712: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   1A2F DD 7E CC      [19] 1814 	ld	a,-52 (ix)
   1A32 D6 80         [ 7] 1815 	sub	a, #0x80
   1A34 20 04         [12] 1816 	jr	NZ,00269$
   1A36 0E 09         [ 7] 1817 	ld	c,#0x09
   1A38 18 02         [12] 1818 	jr	00270$
   1A3A                    1819 00269$:
   1A3A 0E 0B         [ 7] 1820 	ld	c,#0x0B
   1A3C                    1821 00270$:
   1A3C DD 71 D1      [19] 1822 	ld	-47 (ix),c
                           1823 ;src/Renderer.c:713: lastCellWasWall = 1;
   1A3F DD 36 D8 01   [19] 1824 	ld	-40 (ix),#0x01
                           1825 ;src/Renderer.c:714: lastWallId=currentCellID;
   1A43 DD 7E CC      [19] 1826 	ld	a,-52 (ix)
   1A46 DD 77 D2      [19] 1827 	ld	-46 (ix),a
   1A49 C3 FF 1A      [10] 1828 	jp	00190$
   1A4C                    1829 00189$:
                           1830 ;src/Renderer.c:717: if(lateralWallCounter==0){//Lateral wall not finished
   1A4C DD 7E EC      [19] 1831 	ld	a,-20 (ix)
   1A4F B7            [ 4] 1832 	or	a, a
   1A50 C2 FF 1A      [10] 1833 	jp	NZ,00190$
                           1834 ;src/Renderer.c:718: if (lastCellWasWall)
   1A53 DD 7E D8      [19] 1835 	ld	a,-40 (ix)
   1A56 B7            [ 4] 1836 	or	a, a
   1A57 CA EF 1A      [10] 1837 	jp	Z,00184$
                           1838 ;src/Renderer.c:721: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   1A5A DD 7E CE      [19] 1839 	ld	a,-50 (ix)
   1A5D DD 96 D4      [19] 1840 	sub	a, -44 (ix)
   1A60 87            [ 4] 1841 	add	a, a
   1A61 3C            [ 4] 1842 	inc	a
                           1843 ;src/Renderer.c:722: lateralWallSlopeCounter = lateralWallSlope / 2;
   1A62 DD 77 C6      [19] 1844 	ld	-58 (ix), a
   1A65 CB 3F         [ 8] 1845 	srl	a
   1A67 DD 77 CF      [19] 1846 	ld	-49 (ix),a
                           1847 ;src/Renderer.c:723: lateralWallCounter = lateralWallSlope * zHeight;
   1A6A DD 5E C7      [19] 1848 	ld	e,-57 (ix)
   1A6D DD 66 C6      [19] 1849 	ld	h,-58 (ix)
   1A70 2E 00         [ 7] 1850 	ld	l, #0x00
   1A72 55            [ 4] 1851 	ld	d, l
   1A73 06 08         [ 7] 1852 	ld	b, #0x08
   1A75                    1853 00632$:
   1A75 29            [11] 1854 	add	hl,hl
   1A76 30 01         [12] 1855 	jr	NC,00633$
   1A78 19            [11] 1856 	add	hl,de
   1A79                    1857 00633$:
   1A79 10 FA         [13] 1858 	djnz	00632$
   1A7B DD 75 E6      [19] 1859 	ld	-26 (ix), l
   1A7E 7D            [ 4] 1860 	ld	a, l
                           1861 ;src/Renderer.c:724: lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
   1A7F DD 77 C9      [19] 1862 	ld	-55 (ix), a
   1A82 E6 FC         [ 7] 1863 	and	a, #0xFC
   1A84 DD 77 E6      [19] 1864 	ld	-26 (ix), a
   1A87 CB C7         [ 8] 1865 	set	0, a
   1A89 DD 77 E6      [19] 1866 	ld	-26 (ix), a
   1A8C CB 3F         [ 8] 1867 	srl	a
   1A8E CB 3F         [ 8] 1868 	srl	a
   1A90 DD 96 CA      [19] 1869 	sub	a, -54 (ix)
   1A93 DD 77 EC      [19] 1870 	ld	-20 (ix),a
                           1871 ;src/Renderer.c:726: lastCellWasWall = 0;
   1A96 DD 36 D8 00   [19] 1872 	ld	-40 (ix),#0x00
                           1873 ;src/Renderer.c:727: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1A9A DD 7E E0      [19] 1874 	ld	a,-32 (ix)
   1A9D DD 77 E2      [19] 1875 	ld	-30 (ix),a
   1AA0 DD 7E E1      [19] 1876 	ld	a,-31 (ix)
   1AA3 DD 77 E3      [19] 1877 	ld	-29 (ix),a
   1AA6 DD CB E2 26   [23] 1878 	sla	-30 (ix)
   1AAA DD CB E3 16   [23] 1879 	rl	-29 (ix)
   1AAE DD 7E C6      [19] 1880 	ld	a,-58 (ix)
   1AB1 DD 77 E9      [19] 1881 	ld	-23 (ix),a
   1AB4 DD 36 EA 00   [19] 1882 	ld	-22 (ix),#0x00
   1AB8 DD 6E E9      [19] 1883 	ld	l,-23 (ix)
   1ABB DD 66 EA      [19] 1884 	ld	h,-22 (ix)
   1ABE E5            [11] 1885 	push	hl
   1ABF DD 6E E2      [19] 1886 	ld	l,-30 (ix)
   1AC2 DD 66 E3      [19] 1887 	ld	h,-29 (ix)
   1AC5 E5            [11] 1888 	push	hl
   1AC6 CD 1B 5A      [17] 1889 	call	__divsint
   1AC9 F1            [10] 1890 	pop	af
   1ACA F1            [10] 1891 	pop	af
   1ACB DD 74 E3      [19] 1892 	ld	-29 (ix),h
   1ACE DD 75 E2      [19] 1893 	ld	-30 (ix), l
   1AD1 DD 75 E6      [19] 1894 	ld	-26 (ix), l
   1AD4 DD 7E F7      [19] 1895 	ld	a,-9 (ix)
   1AD7 DD 96 E6      [19] 1896 	sub	a, -26 (ix)
   1ADA DD 77 C8      [19] 1897 	ld	-56 (ix),a
                           1898 ;src/Renderer.c:728: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   1ADD DD 7E D2      [19] 1899 	ld	a,-46 (ix)
   1AE0 D6 80         [ 7] 1900 	sub	a, #0x80
   1AE2 20 04         [12] 1901 	jr	NZ,00271$
   1AE4 0E 0A         [ 7] 1902 	ld	c,#0x0A
   1AE6 18 02         [12] 1903 	jr	00272$
   1AE8                    1904 00271$:
   1AE8 0E 0C         [ 7] 1905 	ld	c,#0x0C
   1AEA                    1906 00272$:
   1AEA DD 71 D1      [19] 1907 	ld	-47 (ix),c
   1AED 18 10         [12] 1908 	jr	00190$
   1AEF                    1909 00184$:
                           1910 ;src/Renderer.c:732: xHeight = 0;
   1AEF DD 36 C8 00   [19] 1911 	ld	-56 (ix),#0x00
                           1912 ;src/Renderer.c:733: lastCellWasWall = 0;
   1AF3 DD 36 D8 00   [19] 1913 	ld	-40 (ix),#0x00
                           1914 ;src/Renderer.c:734: lateralWallSlope=0;
   1AF7 DD 36 C6 00   [19] 1915 	ld	-58 (ix),#0x00
                           1916 ;src/Renderer.c:735: lastWallId=0;
   1AFB DD 36 D2 00   [19] 1917 	ld	-46 (ix),#0x00
   1AFF                    1918 00190$:
                           1919 ;src/Renderer.c:739: newCell=0;
   1AFF DD 36 D0 00   [19] 1920 	ld	-48 (ix),#0x00
   1B03                    1921 00195$:
                           1922 ;src/Renderer.c:742: if (lateralWallCounter > 0)
   1B03 DD 7E EC      [19] 1923 	ld	a,-20 (ix)
   1B06 B7            [ 4] 1924 	or	a, a
   1B07 28 1E         [12] 1925 	jr	Z,00201$
                           1926 ;src/Renderer.c:745: if (lateralWallSlope != 0)
   1B09 DD 7E C6      [19] 1927 	ld	a,-58 (ix)
   1B0C B7            [ 4] 1928 	or	a, a
   1B0D 28 15         [12] 1929 	jr	Z,00199$
                           1930 ;src/Renderer.c:747: if (lateralWallSlopeCounter == lateralWallSlope)
   1B0F DD 7E C6      [19] 1931 	ld	a,-58 (ix)
   1B12 DD 96 CF      [19] 1932 	sub	a, -49 (ix)
   1B15 20 0A         [12] 1933 	jr	NZ,00197$
                           1934 ;src/Renderer.c:749: lateralWallSlopeCounter = 0;
   1B17 DD 36 CF 00   [19] 1935 	ld	-49 (ix),#0x00
                           1936 ;src/Renderer.c:750: xHeight -= 2;
   1B1B DD 35 C8      [23] 1937 	dec	-56 (ix)
   1B1E DD 35 C8      [23] 1938 	dec	-56 (ix)
   1B21                    1939 00197$:
                           1940 ;src/Renderer.c:752: ++lateralWallSlopeCounter;
   1B21 DD 34 CF      [23] 1941 	inc	-49 (ix)
   1B24                    1942 00199$:
                           1943 ;src/Renderer.c:755: --lateralWallCounter;
   1B24 DD 35 EC      [23] 1944 	dec	-20 (ix)
   1B27                    1945 00201$:
                           1946 ;src/Renderer.c:498: tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
   1B27 DD 7E C7      [19] 1947 	ld	a,-57 (ix)
   1B2A DD 77 E2      [19] 1948 	ld	-30 (ix),a
   1B2D DD 36 E3 00   [19] 1949 	ld	-29 (ix),#0x00
                           1950 ;src/Renderer.c:758: if (!(x%2))
   1B31 DD 7E FE      [19] 1951 	ld	a,-2 (ix)
   1B34 B7            [ 4] 1952 	or	a, a
   1B35 20 74         [12] 1953 	jr	NZ,00210$
                           1954 ;src/Renderer.c:761: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1B37 DD 7E CD      [19] 1955 	ld	a,-51 (ix)
   1B3A CB 3F         [ 8] 1956 	srl	a
   1B3C DD 77 FE      [19] 1957 	ld	-2 (ix),a
                           1958 ;src/Renderer.c:760: if(xHeight > 0){
   1B3F DD 7E C8      [19] 1959 	ld	a,-56 (ix)
   1B42 B7            [ 4] 1960 	or	a, a
   1B43 28 11         [12] 1961 	jr	Z,00203$
                           1962 ;src/Renderer.c:761: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1B45 DD 66 D1      [19] 1963 	ld	h,-47 (ix)
   1B48 DD 6E C8      [19] 1964 	ld	l,-56 (ix)
   1B4B E5            [11] 1965 	push	hl
   1B4C DD 7E FE      [19] 1966 	ld	a,-2 (ix)
   1B4F F5            [11] 1967 	push	af
   1B50 33            [ 6] 1968 	inc	sp
   1B51 CD 80 10      [17] 1969 	call	_draw_column_to_buffer_untextured
   1B54 F1            [10] 1970 	pop	af
   1B55 33            [ 6] 1971 	inc	sp
   1B56                    1972 00203$:
                           1973 ;src/Renderer.c:764: if(!(currentCellID&CELL_WALL_MASK)){
   1B56 DD 7E FB      [19] 1974 	ld	a,-5 (ix)
   1B59 B7            [ 4] 1975 	or	a, a
   1B5A 20 4F         [12] 1976 	jr	NZ,00210$
                           1977 ;src/Renderer.c:765: if(currentCellID&CELL_ENEMY_MASK){
   1B5C DD 7E CC      [19] 1978 	ld	a,-52 (ix)
   1B5F E6 0F         [ 7] 1979 	and	a, #0x0F
   1B61 28 48         [12] 1980 	jr	Z,00210$
                           1981 ;src/Renderer.c:766: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID , (xCellCount)*TEXTURE_WIDTH/zHeight);
   1B63 DD 7E E0      [19] 1982 	ld	a,-32 (ix)
   1B66 DD 77 FB      [19] 1983 	ld	-5 (ix),a
   1B69 DD 7E E1      [19] 1984 	ld	a,-31 (ix)
   1B6C DD 77 FC      [19] 1985 	ld	-4 (ix),a
   1B6F 3E 06         [ 7] 1986 	ld	a,#0x05+1
   1B71 18 08         [12] 1987 	jr	00642$
   1B73                    1988 00641$:
   1B73 DD CB FB 26   [23] 1989 	sla	-5 (ix)
   1B77 DD CB FC 16   [23] 1990 	rl	-4 (ix)
   1B7B                    1991 00642$:
   1B7B 3D            [ 4] 1992 	dec	a
   1B7C 20 F5         [12] 1993 	jr	NZ,00641$
   1B7E DD 6E E2      [19] 1994 	ld	l,-30 (ix)
   1B81 DD 66 E3      [19] 1995 	ld	h,-29 (ix)
   1B84 E5            [11] 1996 	push	hl
   1B85 DD 6E FB      [19] 1997 	ld	l,-5 (ix)
   1B88 DD 66 FC      [19] 1998 	ld	h,-4 (ix)
   1B8B E5            [11] 1999 	push	hl
   1B8C CD 1B 5A      [17] 2000 	call	__divsint
   1B8F F1            [10] 2001 	pop	af
   1B90 F1            [10] 2002 	pop	af
   1B91 DD 74 FC      [19] 2003 	ld	-4 (ix),h
   1B94 DD 75 FB      [19] 2004 	ld	-5 (ix), l
   1B97 45            [ 4] 2005 	ld	b, l
   1B98 C5            [11] 2006 	push	bc
   1B99 33            [ 6] 2007 	inc	sp
   1B9A DD 66 CC      [19] 2008 	ld	h,-52 (ix)
   1B9D DD 6E C7      [19] 2009 	ld	l,-57 (ix)
   1BA0 E5            [11] 2010 	push	hl
   1BA1 DD 7E FE      [19] 2011 	ld	a,-2 (ix)
   1BA4 F5            [11] 2012 	push	af
   1BA5 33            [ 6] 2013 	inc	sp
   1BA6 CD F7 10      [17] 2014 	call	_draw_column_to_buffer_enemy
   1BA9 F1            [10] 2015 	pop	af
   1BAA F1            [10] 2016 	pop	af
                           2017 ;src/Renderer.c:768: else if(currentCellID&CELL_ITEM_MASK){
   1BAB                    2018 00210$:
                           2019 ;src/Renderer.c:774: ++xCellCount;
   1BAB DD 34 CA      [23] 2020 	inc	-54 (ix)
                           2021 ;src/Renderer.c:695: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1BAE DD 34 CD      [23] 2022 	inc	-51 (ix)
                           2023 ;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
   1BB1 2A 79 10      [16] 2024 	ld	hl,(_cells_in_view_array)
   1BB4 DD 75 DC      [19] 2025 	ld	-36 (ix),l
   1BB7 DD 74 DD      [19] 2026 	ld	-35 (ix),h
                           2027 ;src/Renderer.c:695: for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
   1BBA DD 7E CD      [19] 2028 	ld	a,-51 (ix)
   1BBD D6 50         [ 7] 2029 	sub	a, #0x50
   1BBF DA 94 19      [10] 2030 	jp	C,00256$
                           2031 ;src/Renderer.c:781: xCellCount = (z) ? (zHeight >> 1) : 0 ;
   1BC2 DD 7E CB      [19] 2032 	ld	a,-53 (ix)
   1BC5 B7            [ 4] 2033 	or	a, a
   1BC6 28 08         [12] 2034 	jr	Z,00273$
   1BC8 DD 7E E7      [19] 2035 	ld	a,-25 (ix)
   1BCB DD 77 E7      [19] 2036 	ld	-25 (ix),a
   1BCE 18 04         [12] 2037 	jr	00274$
   1BD0                    2038 00273$:
   1BD0 DD 36 E7 00   [19] 2039 	ld	-25 (ix),#0x00
   1BD4                    2040 00274$:
   1BD4 DD 7E E7      [19] 2041 	ld	a,-25 (ix)
   1BD7 DD 77 E7      [19] 2042 	ld	-25 (ix),a
                           2043 ;src/Renderer.c:782: lateralWallSlope=0;
   1BDA DD 36 EC 00   [19] 2044 	ld	-20 (ix),#0x00
                           2045 ;src/Renderer.c:783: lateralWallSlopeCounter=0;
   1BDE DD 36 DE 00   [19] 2046 	ld	-34 (ix),#0x00
                           2047 ;src/Renderer.c:784: xHeight=0;
   1BE2 DD 36 D8 00   [19] 2048 	ld	-40 (ix),#0x00
                           2049 ;src/Renderer.c:786: lateralWallCounter = 0;
   1BE6 DD 36 FE 00   [19] 2050 	ld	-2 (ix),#0x00
                           2051 ;src/Renderer.c:525: lineEnd = lineStart + offsetDiff * 2 + 2;
   1BEA DD 7E CE      [19] 2052 	ld	a,-50 (ix)
   1BED 87            [ 4] 2053 	add	a, a
   1BEE DD 77 FB      [19] 2054 	ld	-5 (ix),a
   1BF1 DD 7E D5      [19] 2055 	ld	a,-43 (ix)
   1BF4 DD 86 FB      [19] 2056 	add	a, -5 (ix)
                           2057 ;src/Renderer.c:787: lineEnd = lineStart + offsetDiff * 2 + 2;
   1BF7 DD 77 FB      [19] 2058 	ld	-5 (ix), a
   1BFA C6 02         [ 7] 2059 	add	a, #0x02
   1BFC DD 77 D6      [19] 2060 	ld	-42 (ix),a
                           2061 ;src/Renderer.c:789: newCell=1;
   1BFF DD 36 E6 01   [19] 2062 	ld	-26 (ix),#0x01
                           2063 ;src/Renderer.c:528: currentCellID = cells_in_view_array[lineEnd - 1];
   1C03 DD 7E D6      [19] 2064 	ld	a,-42 (ix)
   1C06 DD 77 E0      [19] 2065 	ld	-32 (ix),a
   1C09 DD 36 E1 00   [19] 2066 	ld	-31 (ix),#0x00
                           2067 ;src/Renderer.c:790: currentCellID = cells_in_view_array[lineEnd - 1];
   1C0D DD 7E E0      [19] 2068 	ld	a,-32 (ix)
   1C10 C6 FF         [ 7] 2069 	add	a,#0xFF
   1C12 DD 77 E9      [19] 2070 	ld	-23 (ix),a
   1C15 DD 7E E1      [19] 2071 	ld	a,-31 (ix)
   1C18 CE FF         [ 7] 2072 	adc	a,#0xFF
   1C1A DD 77 EA      [19] 2073 	ld	-22 (ix),a
   1C1D DD 7E DC      [19] 2074 	ld	a,-36 (ix)
   1C20 DD 86 E9      [19] 2075 	add	a, -23 (ix)
   1C23 DD 77 E9      [19] 2076 	ld	-23 (ix),a
   1C26 DD 7E DD      [19] 2077 	ld	a,-35 (ix)
   1C29 DD 8E EA      [19] 2078 	adc	a, -22 (ix)
   1C2C DD 77 EA      [19] 2079 	ld	-22 (ix),a
   1C2F DD 6E E9      [19] 2080 	ld	l,-23 (ix)
   1C32 DD 66 EA      [19] 2081 	ld	h,-22 (ix)
   1C35 7E            [ 7] 2082 	ld	a,(hl)
   1C36 DD 77 EB      [19] 2083 	ld	-21 (ix),a
                           2084 ;src/Renderer.c:792: lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
   1C39 DD 7E DC      [19] 2085 	ld	a,-36 (ix)
   1C3C DD 86 D6      [19] 2086 	add	a, -42 (ix)
   1C3F DD 77 E9      [19] 2087 	ld	-23 (ix),a
   1C42 DD 7E DD      [19] 2088 	ld	a,-35 (ix)
   1C45 CE 00         [ 7] 2089 	adc	a, #0x00
   1C47 DD 77 EA      [19] 2090 	ld	-22 (ix),a
   1C4A DD 6E E9      [19] 2091 	ld	l,-23 (ix)
   1C4D DD 66 EA      [19] 2092 	ld	h,-22 (ix)
   1C50 7E            [ 7] 2093 	ld	a,(hl)
   1C51 DD 77 DB      [19] 2094 	ld	-37 (ix),a
                           2095 ;src/Renderer.c:793: if(lastCellWasWall&CELL_WALL_MASK){
   1C54 DD CB DB 7E   [20] 2096 	bit	7, -37 (ix)
   1C58 28 06         [12] 2097 	jr	Z,00213$
                           2098 ;src/Renderer.c:794: lastWallId=lastCellWasWall;
                           2099 ;src/Renderer.c:795: lastCellWasWall=1;
   1C5A DD 36 D7 01   [19] 2100 	ld	-41 (ix),#0x01
   1C5E 18 08         [12] 2101 	jr	00356$
   1C60                    2102 00213$:
                           2103 ;src/Renderer.c:798: lastCellWasWall=0;
   1C60 DD 36 D7 00   [19] 2104 	ld	-41 (ix),#0x00
                           2105 ;src/Renderer.c:799: lastWallId=CELLTYPE_FLOOR;
   1C64 DD 36 DB 00   [19] 2106 	ld	-37 (ix),#0x00
                           2107 ;src/Renderer.c:802: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   1C68                    2108 00356$:
   1C68 DD 36 D4 00   [19] 2109 	ld	-44 (ix),#0x00
   1C6C DD 36 CD 9F   [19] 2110 	ld	-51 (ix),#0x9F
   1C70                    2111 00258$:
                           2112 ;src/Renderer.c:805: if (xCellCount == zHeight)
   1C70 DD 7E C7      [19] 2113 	ld	a,-57 (ix)
   1C73 DD 96 E7      [19] 2114 	sub	a, -25 (ix)
   1C76 20 50         [12] 2115 	jr	NZ,00216$
                           2116 ;src/Renderer.c:807: ++xCell;
   1C78 DD 34 D4      [23] 2117 	inc	-44 (ix)
                           2118 ;src/Renderer.c:808: xCellCount = 0;
   1C7B DD 36 E7 00   [19] 2119 	ld	-25 (ix),#0x00
                           2120 ;src/Renderer.c:809: newCell=1;
   1C7F DD 36 E6 01   [19] 2121 	ld	-26 (ix),#0x01
                           2122 ;src/Renderer.c:810: currentCellID = cells_in_view_array[lineEnd - xCell - 1];
   1C83 DD 7E D4      [19] 2123 	ld	a,-44 (ix)
   1C86 DD 77 E9      [19] 2124 	ld	-23 (ix),a
   1C89 DD 36 EA 00   [19] 2125 	ld	-22 (ix),#0x00
   1C8D DD 7E E0      [19] 2126 	ld	a,-32 (ix)
   1C90 DD 96 E9      [19] 2127 	sub	a, -23 (ix)
   1C93 DD 77 E9      [19] 2128 	ld	-23 (ix),a
   1C96 DD 7E E1      [19] 2129 	ld	a,-31 (ix)
   1C99 DD 9E EA      [19] 2130 	sbc	a, -22 (ix)
   1C9C DD 77 EA      [19] 2131 	ld	-22 (ix),a
   1C9F DD 6E E9      [19] 2132 	ld	l,-23 (ix)
   1CA2 DD 66 EA      [19] 2133 	ld	h,-22 (ix)
   1CA5 2B            [ 6] 2134 	dec	hl
   1CA6 DD 75 E9      [19] 2135 	ld	-23 (ix),l
   1CA9 DD 74 EA      [19] 2136 	ld	-22 (ix),h
   1CAC DD 7E DC      [19] 2137 	ld	a,-36 (ix)
   1CAF DD 86 E9      [19] 2138 	add	a, -23 (ix)
   1CB2 DD 77 E9      [19] 2139 	ld	-23 (ix),a
   1CB5 DD 7E DD      [19] 2140 	ld	a,-35 (ix)
   1CB8 DD 8E EA      [19] 2141 	adc	a, -22 (ix)
   1CBB DD 77 EA      [19] 2142 	ld	-22 (ix),a
   1CBE DD 6E E9      [19] 2143 	ld	l,-23 (ix)
   1CC1 DD 66 EA      [19] 2144 	ld	h,-22 (ix)
   1CC4 7E            [ 7] 2145 	ld	a,(hl)
   1CC5 DD 77 EB      [19] 2146 	ld	-21 (ix),a
   1CC8                    2147 00216$:
                           2148 ;src/Renderer.c:812: if(!(x%2)){
   1CC8 DD 7E CD      [19] 2149 	ld	a,-51 (ix)
   1CCB E6 01         [ 7] 2150 	and	a, #0x01
   1CCD DD 77 E4      [19] 2151 	ld	-28 (ix),a
                           2152 ;src/Renderer.c:439: if (currentCellID & CELL_WALL_MASK)//Wall
   1CD0 DD 7E EB      [19] 2153 	ld	a,-21 (ix)
   1CD3 E6 80         [ 7] 2154 	and	a, #0x80
   1CD5 DD 77 E9      [19] 2155 	ld	-23 (ix),a
                           2156 ;src/Renderer.c:459: xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
   1CD8 DD 7E E7      [19] 2157 	ld	a,-25 (ix)
   1CDB DD 77 EF      [19] 2158 	ld	-17 (ix),a
   1CDE DD 36 F0 00   [19] 2159 	ld	-16 (ix),#0x00
                           2160 ;src/Renderer.c:812: if(!(x%2)){
   1CE2 DD 7E E4      [19] 2161 	ld	a,-28 (ix)
   1CE5 B7            [ 4] 2162 	or	a, a
   1CE6 C2 14 1E      [10] 2163 	jp	NZ,00229$
                           2164 ;src/Renderer.c:813: if (lateralWallCounter == 0 || newCell)
   1CE9 DD 7E FE      [19] 2165 	ld	a,-2 (ix)
   1CEC B7            [ 4] 2166 	or	a, a
   1CED 28 07         [12] 2167 	jr	Z,00225$
   1CEF DD 7E E6      [19] 2168 	ld	a,-26 (ix)
   1CF2 B7            [ 4] 2169 	or	a, a
   1CF3 CA 14 1E      [10] 2170 	jp	Z,00229$
   1CF6                    2171 00225$:
                           2172 ;src/Renderer.c:815: if ( currentCellID & CELL_WALL_MASK)//Wall
   1CF6 DD 7E E9      [19] 2173 	ld	a,-23 (ix)
   1CF9 B7            [ 4] 2174 	or	a, a
   1CFA 28 32         [12] 2175 	jr	Z,00223$
                           2176 ;src/Renderer.c:817: lateralWallCounter = 0;
   1CFC DD 36 FE 00   [19] 2177 	ld	-2 (ix),#0x00
                           2178 ;src/Renderer.c:818: lateralWallSlope = 0;
   1D00 DD 36 EC 00   [19] 2179 	ld	-20 (ix),#0x00
                           2180 ;src/Renderer.c:819: xHeight = zHeight;
   1D04 DD 7E C7      [19] 2181 	ld	a,-57 (ix)
   1D07 DD 77 D8      [19] 2182 	ld	-40 (ix),a
                           2183 ;src/Renderer.c:820: color = currentCellID==CELLTYPE_DOOR?DOOR1_COLOR:WALL1_COLOR;
   1D0A DD 7E EB      [19] 2184 	ld	a,-21 (ix)
   1D0D D6 80         [ 7] 2185 	sub	a, #0x80
   1D0F 20 06         [12] 2186 	jr	NZ,00275$
   1D11 DD 36 E5 09   [19] 2187 	ld	-27 (ix),#0x09
   1D15 18 04         [12] 2188 	jr	00276$
   1D17                    2189 00275$:
   1D17 DD 36 E5 0B   [19] 2190 	ld	-27 (ix),#0x0B
   1D1B                    2191 00276$:
   1D1B DD 7E E5      [19] 2192 	ld	a,-27 (ix)
   1D1E DD 77 D1      [19] 2193 	ld	-47 (ix),a
                           2194 ;src/Renderer.c:821: lastCellWasWall = 1;
   1D21 DD 36 D7 01   [19] 2195 	ld	-41 (ix),#0x01
                           2196 ;src/Renderer.c:822: lastWallId=currentCellID;
   1D25 DD 7E EB      [19] 2197 	ld	a,-21 (ix)
   1D28 DD 77 DB      [19] 2198 	ld	-37 (ix),a
   1D2B C3 10 1E      [10] 2199 	jp	00224$
   1D2E                    2200 00223$:
                           2201 ;src/Renderer.c:824: else if(lateralWallCounter==0){
   1D2E DD 7E FE      [19] 2202 	ld	a,-2 (ix)
   1D31 B7            [ 4] 2203 	or	a, a
   1D32 C2 10 1E      [10] 2204 	jp	NZ,00224$
                           2205 ;src/Renderer.c:825: if (lastCellWasWall)
   1D35 DD 7E D7      [19] 2206 	ld	a,-41 (ix)
   1D38 B7            [ 4] 2207 	or	a, a
   1D39 CA 00 1E      [10] 2208 	jp	Z,00218$
                           2209 ;src/Renderer.c:828: lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
   1D3C DD 7E CE      [19] 2210 	ld	a,-50 (ix)
   1D3F DD 96 D4      [19] 2211 	sub	a, -44 (ix)
   1D42 87            [ 4] 2212 	add	a, a
   1D43 3C            [ 4] 2213 	inc	a
                           2214 ;src/Renderer.c:829: lateralWallSlopeCounter = lateralWallSlope / 2;
   1D44 DD 77 EC      [19] 2215 	ld	-20 (ix), a
   1D47 CB 3F         [ 8] 2216 	srl	a
   1D49 DD 77 DE      [19] 2217 	ld	-34 (ix),a
                           2218 ;src/Renderer.c:830: lateralWallCounter = lateralWallSlope * zHeight;
   1D4C DD 5E C7      [19] 2219 	ld	e,-57 (ix)
   1D4F DD 66 EC      [19] 2220 	ld	h,-20 (ix)
   1D52 2E 00         [ 7] 2221 	ld	l, #0x00
   1D54 55            [ 4] 2222 	ld	d, l
   1D55 06 08         [ 7] 2223 	ld	b, #0x08
   1D57                    2224 00648$:
   1D57 29            [11] 2225 	add	hl,hl
   1D58 30 01         [12] 2226 	jr	NC,00649$
   1D5A 19            [11] 2227 	add	hl,de
   1D5B                    2228 00649$:
   1D5B 10 FA         [13] 2229 	djnz	00648$
                           2230 ;src/Renderer.c:831: lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
   1D5D DD 75 E5      [19] 2231 	ld	-27 (ix), l
   1D60 DD 75 F1      [19] 2232 	ld	-15 (ix), l
   1D63 DD 36 F2 00   [19] 2233 	ld	-14 (ix),#0x00
   1D67 DD 7E E5      [19] 2234 	ld	a,-27 (ix)
   1D6A E6 03         [ 7] 2235 	and	a, #0x03
   1D6C DD 77 E5      [19] 2236 	ld	-27 (ix), a
   1D6F DD 77 F4      [19] 2237 	ld	-12 (ix),a
   1D72 DD 36 F5 00   [19] 2238 	ld	-11 (ix),#0x00
   1D76 DD 7E F1      [19] 2239 	ld	a,-15 (ix)
   1D79 DD 96 F4      [19] 2240 	sub	a, -12 (ix)
   1D7C DD 77 F4      [19] 2241 	ld	-12 (ix),a
   1D7F DD 7E F2      [19] 2242 	ld	a,-14 (ix)
   1D82 DD 9E F5      [19] 2243 	sbc	a, -11 (ix)
   1D85 DD 77 F5      [19] 2244 	ld	-11 (ix),a
   1D88 DD 7E F4      [19] 2245 	ld	a,-12 (ix)
   1D8B C6 01         [ 7] 2246 	add	a, #0x01
   1D8D DD 77 F1      [19] 2247 	ld	-15 (ix),a
   1D90 DD 7E F5      [19] 2248 	ld	a,-11 (ix)
   1D93 CE 00         [ 7] 2249 	adc	a, #0x00
   1D95 DD 77 F2      [19] 2250 	ld	-14 (ix),a
   1D98 DD 7E F1      [19] 2251 	ld	a,-15 (ix)
   1D9B DD 77 F9      [19] 2252 	ld	-7 (ix),a
   1D9E DD 7E F2      [19] 2253 	ld	a,-14 (ix)
   1DA1 DD 77 FA      [19] 2254 	ld	-6 (ix),a
   1DA4 DD CB F2 7E   [20] 2255 	bit	7, -14 (ix)
   1DA8 28 10         [12] 2256 	jr	Z,00277$
   1DAA DD 7E F4      [19] 2257 	ld	a,-12 (ix)
   1DAD C6 04         [ 7] 2258 	add	a, #0x04
   1DAF DD 77 F9      [19] 2259 	ld	-7 (ix),a
   1DB2 DD 7E F5      [19] 2260 	ld	a,-11 (ix)
   1DB5 CE 00         [ 7] 2261 	adc	a, #0x00
   1DB7 DD 77 FA      [19] 2262 	ld	-6 (ix),a
   1DBA                    2263 00277$:
   1DBA DD 4E F9      [19] 2264 	ld	c,-7 (ix)
   1DBD DD 46 FA      [19] 2265 	ld	b,-6 (ix)
   1DC0 CB 28         [ 8] 2266 	sra	b
   1DC2 CB 19         [ 8] 2267 	rr	c
   1DC4 CB 28         [ 8] 2268 	sra	b
   1DC6 CB 19         [ 8] 2269 	rr	c
   1DC8 DD 46 E7      [19] 2270 	ld	b,-25 (ix)
   1DCB 79            [ 4] 2271 	ld	a,c
   1DCC 90            [ 4] 2272 	sub	a, b
   1DCD DD 77 FE      [19] 2273 	ld	-2 (ix),a
                           2274 ;src/Renderer.c:833: lastCellWasWall = 0;
   1DD0 DD 36 D7 00   [19] 2275 	ld	-41 (ix),#0x00
                           2276 ;src/Renderer.c:834: xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
   1DD4 DD 6E EF      [19] 2277 	ld	l,-17 (ix)
   1DD7 DD 66 F0      [19] 2278 	ld	h,-16 (ix)
   1DDA 29            [11] 2279 	add	hl, hl
   1DDB DD 4E EC      [19] 2280 	ld	c,-20 (ix)
   1DDE 06 00         [ 7] 2281 	ld	b,#0x00
   1DE0 C5            [11] 2282 	push	bc
   1DE1 E5            [11] 2283 	push	hl
   1DE2 CD 1B 5A      [17] 2284 	call	__divsint
   1DE5 F1            [10] 2285 	pop	af
   1DE6 F1            [10] 2286 	pop	af
   1DE7 DD 7E F7      [19] 2287 	ld	a,-9 (ix)
   1DEA 95            [ 4] 2288 	sub	a, l
   1DEB DD 77 D8      [19] 2289 	ld	-40 (ix),a
                           2290 ;src/Renderer.c:835: color = lastWallId==CELLTYPE_DOOR?DOOR2_COLOR:WALL2_COLOR;
   1DEE DD 7E DB      [19] 2291 	ld	a,-37 (ix)
   1DF1 D6 80         [ 7] 2292 	sub	a, #0x80
   1DF3 20 04         [12] 2293 	jr	NZ,00278$
   1DF5 0E 0A         [ 7] 2294 	ld	c,#0x0A
   1DF7 18 02         [12] 2295 	jr	00279$
   1DF9                    2296 00278$:
   1DF9 0E 0C         [ 7] 2297 	ld	c,#0x0C
   1DFB                    2298 00279$:
   1DFB DD 71 D1      [19] 2299 	ld	-47 (ix),c
   1DFE 18 10         [12] 2300 	jr	00224$
   1E00                    2301 00218$:
                           2302 ;src/Renderer.c:839: xHeight = 0;
   1E00 DD 36 D8 00   [19] 2303 	ld	-40 (ix),#0x00
                           2304 ;src/Renderer.c:840: lastCellWasWall = 0;
   1E04 DD 36 D7 00   [19] 2305 	ld	-41 (ix),#0x00
                           2306 ;src/Renderer.c:841: lateralWallSlope=0;
   1E08 DD 36 EC 00   [19] 2307 	ld	-20 (ix),#0x00
                           2308 ;src/Renderer.c:842: lastWallId=0;
   1E0C DD 36 DB 00   [19] 2309 	ld	-37 (ix),#0x00
   1E10                    2310 00224$:
                           2311 ;src/Renderer.c:845: newCell=0;
   1E10 DD 36 E6 00   [19] 2312 	ld	-26 (ix),#0x00
   1E14                    2313 00229$:
                           2314 ;src/Renderer.c:850: if (lateralWallCounter > 0)
   1E14 DD 7E FE      [19] 2315 	ld	a,-2 (ix)
   1E17 B7            [ 4] 2316 	or	a, a
   1E18 28 1E         [12] 2317 	jr	Z,00235$
                           2318 ;src/Renderer.c:853: if (lateralWallSlope != 0)
   1E1A DD 7E EC      [19] 2319 	ld	a,-20 (ix)
   1E1D B7            [ 4] 2320 	or	a, a
   1E1E 28 15         [12] 2321 	jr	Z,00233$
                           2322 ;src/Renderer.c:855: if (lateralWallSlopeCounter == lateralWallSlope)
   1E20 DD 7E EC      [19] 2323 	ld	a,-20 (ix)
   1E23 DD 96 DE      [19] 2324 	sub	a, -34 (ix)
   1E26 20 0A         [12] 2325 	jr	NZ,00231$
                           2326 ;src/Renderer.c:857: lateralWallSlopeCounter = 0;
   1E28 DD 36 DE 00   [19] 2327 	ld	-34 (ix),#0x00
                           2328 ;src/Renderer.c:858: xHeight -= 2;
   1E2C DD 35 D8      [23] 2329 	dec	-40 (ix)
   1E2F DD 35 D8      [23] 2330 	dec	-40 (ix)
   1E32                    2331 00231$:
                           2332 ;src/Renderer.c:860: ++lateralWallSlopeCounter;
   1E32 DD 34 DE      [23] 2333 	inc	-34 (ix)
   1E35                    2334 00233$:
                           2335 ;src/Renderer.c:862: --lateralWallCounter;
   1E35 DD 35 FE      [23] 2336 	dec	-2 (ix)
   1E38                    2337 00235$:
                           2338 ;src/Renderer.c:866: if (!(x%2))
   1E38 DD 7E E4      [19] 2339 	ld	a,-28 (ix)
   1E3B B7            [ 4] 2340 	or	a, a
   1E3C 20 5B         [12] 2341 	jr	NZ,00244$
                           2342 ;src/Renderer.c:871: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1E3E DD 46 CD      [19] 2343 	ld	b,-51 (ix)
   1E41 CB 38         [ 8] 2344 	srl	b
                           2345 ;src/Renderer.c:869: if(xHeight > 0){
   1E43 DD 7E D8      [19] 2346 	ld	a,-40 (ix)
   1E46 B7            [ 4] 2347 	or	a, a
   1E47 28 10         [12] 2348 	jr	Z,00237$
                           2349 ;src/Renderer.c:871: draw_column_to_buffer_untextured(x/2, xHeight, color);
   1E49 C5            [11] 2350 	push	bc
   1E4A DD 66 D1      [19] 2351 	ld	h,-47 (ix)
   1E4D DD 6E D8      [19] 2352 	ld	l,-40 (ix)
   1E50 E5            [11] 2353 	push	hl
   1E51 C5            [11] 2354 	push	bc
   1E52 33            [ 6] 2355 	inc	sp
   1E53 CD 80 10      [17] 2356 	call	_draw_column_to_buffer_untextured
   1E56 F1            [10] 2357 	pop	af
   1E57 33            [ 6] 2358 	inc	sp
   1E58 C1            [10] 2359 	pop	bc
   1E59                    2360 00237$:
                           2361 ;src/Renderer.c:874: if(!(currentCellID&CELL_WALL_MASK)){
   1E59 DD 7E E9      [19] 2362 	ld	a,-23 (ix)
   1E5C B7            [ 4] 2363 	or	a, a
   1E5D 20 3A         [12] 2364 	jr	NZ,00244$
                           2365 ;src/Renderer.c:875: if(currentCellID&CELL_ENEMY_MASK){
   1E5F DD 7E EB      [19] 2366 	ld	a,-21 (ix)
   1E62 E6 0F         [ 7] 2367 	and	a, #0x0F
   1E64 28 33         [12] 2368 	jr	Z,00244$
                           2369 ;src/Renderer.c:876: draw_column_to_buffer_enemy(x/2, zHeight, currentCellID ,(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight);
   1E66 DD 7E E2      [19] 2370 	ld	a,-30 (ix)
   1E69 DD 96 EF      [19] 2371 	sub	a, -17 (ix)
   1E6C 6F            [ 4] 2372 	ld	l,a
   1E6D DD 7E E3      [19] 2373 	ld	a,-29 (ix)
   1E70 DD 9E F0      [19] 2374 	sbc	a, -16 (ix)
   1E73 67            [ 4] 2375 	ld	h,a
   1E74 29            [11] 2376 	add	hl, hl
   1E75 29            [11] 2377 	add	hl, hl
   1E76 29            [11] 2378 	add	hl, hl
   1E77 29            [11] 2379 	add	hl, hl
   1E78 29            [11] 2380 	add	hl, hl
   1E79 C5            [11] 2381 	push	bc
   1E7A DD 5E E2      [19] 2382 	ld	e,-30 (ix)
   1E7D DD 56 E3      [19] 2383 	ld	d,-29 (ix)
   1E80 D5            [11] 2384 	push	de
   1E81 E5            [11] 2385 	push	hl
   1E82 CD 1B 5A      [17] 2386 	call	__divsint
   1E85 F1            [10] 2387 	pop	af
   1E86 F1            [10] 2388 	pop	af
   1E87 55            [ 4] 2389 	ld	d,l
   1E88 C1            [10] 2390 	pop	bc
   1E89 D5            [11] 2391 	push	de
   1E8A 33            [ 6] 2392 	inc	sp
   1E8B DD 66 EB      [19] 2393 	ld	h,-21 (ix)
   1E8E DD 6E C7      [19] 2394 	ld	l,-57 (ix)
   1E91 E5            [11] 2395 	push	hl
   1E92 C5            [11] 2396 	push	bc
   1E93 33            [ 6] 2397 	inc	sp
   1E94 CD F7 10      [17] 2398 	call	_draw_column_to_buffer_enemy
   1E97 F1            [10] 2399 	pop	af
   1E98 F1            [10] 2400 	pop	af
                           2401 ;src/Renderer.c:878: else if(currentCellID&CELL_ITEM_MASK){
   1E99                    2402 00244$:
                           2403 ;src/Renderer.c:883: ++xCellCount;
   1E99 DD 34 E7      [23] 2404 	inc	-25 (ix)
                           2405 ;src/Renderer.c:802: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   1E9C DD 35 CD      [23] 2406 	dec	-51 (ix)
                           2407 ;src/Renderer.c:415: currentCellID = cells_in_view_array[lineStart + 1];
   1E9F 2A 79 10      [16] 2408 	ld	hl,(_cells_in_view_array)
   1EA2 DD 75 DC      [19] 2409 	ld	-36 (ix),l
   1EA5 DD 74 DD      [19] 2410 	ld	-35 (ix),h
                           2411 ;src/Renderer.c:802: for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
   1EA8 DD 7E CD      [19] 2412 	ld	a,-51 (ix)
   1EAB D6 50         [ 7] 2413 	sub	a, #0x50
   1EAD D2 70 1C      [10] 2414 	jp	NC,00258$
                           2415 ;src/Renderer.c:912: lineStart = lineStart + (offsetDiff * 2) + 3;
   1EB0 DD 7E FB      [19] 2416 	ld	a,-5 (ix)
   1EB3 C6 03         [ 7] 2417 	add	a, #0x03
   1EB5 DD 77 D5      [19] 2418 	ld	-43 (ix),a
                           2419 ;src/Renderer.c:913: zHeight += zHeight;
   1EB8 DD CB C7 26   [23] 2420 	sla	-57 (ix)
                           2421 ;src/Renderer.c:914: offsetDiff = offsetDiff >> 1;
   1EBC DD CB CE 3E   [23] 2422 	srl	-50 (ix)
                           2423 ;src/Renderer.c:916: }while(z);
   1EC0 DD 7E CB      [19] 2424 	ld	a,-53 (ix)
   1EC3 B7            [ 4] 2425 	or	a, a
   1EC4 C2 1E 19      [10] 2426 	jp	NZ,00246$
   1EC7                    2427 00260$:
   1EC7 DD F9         [10] 2428 	ld	sp, ix
   1EC9 DD E1         [14] 2429 	pop	ix
   1ECB C9            [10] 2430 	ret
                           2431 ;src/Renderer.c:922: void draw_minimap_to_buffer(){
                           2432 ;	---------------------------------
                           2433 ; Function draw_minimap_to_buffer
                           2434 ; ---------------------------------
   1ECC                    2435 _draw_minimap_to_buffer::
   1ECC DD E5         [15] 2436 	push	ix
   1ECE DD 21 00 00   [14] 2437 	ld	ix,#0
   1ED2 DD 39         [15] 2438 	add	ix,sp
   1ED4 21 F5 FF      [10] 2439 	ld	hl,#-11
   1ED7 39            [11] 2440 	add	hl,sp
   1ED8 F9            [ 6] 2441 	ld	sp,hl
                           2442 ;src/Renderer.c:925: u8* ptr = MINIMAP_BUFFER;
   1ED9 01 A0 AA      [10] 2443 	ld	bc,#0xAAA0
                           2444 ;src/Renderer.c:930: y=(player_position.y-MINIMAP_HEIGHT_HALF);
   1EDC 3A 5B 0E      [13] 2445 	ld	a, (#(_player_position + 0x0001) + 0)
   1EDF C6 F8         [ 7] 2446 	add	a,#0xF8
   1EE1 5F            [ 4] 2447 	ld	e,a
                           2448 ;src/Renderer.c:932: for(j=0;j<MINIMAP_HEIGHT;++j){
   1EE2 16 00         [ 7] 2449 	ld	d,#0x00
                           2450 ;src/Renderer.c:933: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   1EE4                    2451 00137$:
   1EE4 7B            [ 4] 2452 	ld	a,e
   1EE5 07            [ 4] 2453 	rlca
   1EE6 E6 01         [ 7] 2454 	and	a,#0x01
   1EE8 DD 77 FB      [19] 2455 	ld	-5 (ix),a
   1EEB 7B            [ 4] 2456 	ld	a,e
   1EEC EE 80         [ 7] 2457 	xor	a, #0x80
   1EEE D6 A0         [ 7] 2458 	sub	a, #0xA0
   1EF0 3E 00         [ 7] 2459 	ld	a,#0x00
   1EF2 17            [ 4] 2460 	rla
   1EF3 DD 77 FF      [19] 2461 	ld	-1 (ix),a
   1EF6 DD 36 F5 00   [19] 2462 	ld	-11 (ix),#0x00
   1EFA                    2463 00122$:
                           2464 ;src/Renderer.c:934: x=(player_position.x-MINIMAP_WIDTH_HALF);
   1EFA 3A 5A 0E      [13] 2465 	ld	a, (#_player_position + 0)
   1EFD C6 F8         [ 7] 2466 	add	a,#0xF8
   1EFF DD 77 FC      [19] 2467 	ld	-4 (ix),a
                           2468 ;src/Renderer.c:935: for(i=0;i<MINIMAP_WIDTH;++i){
   1F02 DD 36 F6 00   [19] 2469 	ld	-10 (ix),#0x00
   1F06                    2470 00120$:
                           2471 ;src/Renderer.c:938: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1F06 FD 21 10 00   [14] 2472 	ld	iy,#0x0010
   1F0A FD 09         [15] 2473 	add	iy, bc
                           2474 ;src/Renderer.c:936: if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
   1F0C DD CB FC 7E   [20] 2475 	bit	7, -4 (ix)
   1F10 20 15         [12] 2476 	jr	NZ,00111$
   1F12 DD 7E FC      [19] 2477 	ld	a,-4 (ix)
   1F15 EE 80         [ 7] 2478 	xor	a, #0x80
   1F17 D6 A0         [ 7] 2479 	sub	a, #0xA0
   1F19 30 0C         [12] 2480 	jr	NC,00111$
   1F1B DD 7E FB      [19] 2481 	ld	a,-5 (ix)
   1F1E B7            [ 4] 2482 	or	a, a
   1F1F 20 06         [12] 2483 	jr	NZ,00111$
   1F21 DD CB FF 46   [20] 2484 	bit	0,-1 (ix)
   1F25 20 0D         [12] 2485 	jr	NZ,00112$
   1F27                    2486 00111$:
                           2487 ;src/Renderer.c:937: *ptr=g_colors[MINIMAP_WALL_COLOR];
   1F27 3A 67 10      [13] 2488 	ld	a, (#(_g_colors + 0x0001) + 0)
   1F2A 02            [ 7] 2489 	ld	(bc),a
                           2490 ;src/Renderer.c:938: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1F2B 3A 67 10      [13] 2491 	ld	a, (#(_g_colors + 0x0001) + 0)
   1F2E FD 77 00      [19] 2492 	ld	0 (iy), a
   1F31 C3 DB 1F      [10] 2493 	jp	00113$
   1F34                    2494 00112$:
                           2495 ;src/Renderer.c:940: else if((x==player_position.x)&&(y==player_position.y)){
   1F34 DD 7E FC      [19] 2496 	ld	a,-4 (ix)
   1F37 DD 77 FD      [19] 2497 	ld	-3 (ix),a
   1F3A DD 7E FC      [19] 2498 	ld	a,-4 (ix)
   1F3D 17            [ 4] 2499 	rla
   1F3E 9F            [ 4] 2500 	sbc	a, a
   1F3F DD 77 FE      [19] 2501 	ld	-2 (ix),a
   1F42 3A 5A 0E      [13] 2502 	ld	a, (#_player_position + 0)
   1F45 DD 77 F7      [19] 2503 	ld	-9 (ix),a
   1F48 DD 36 F8 00   [19] 2504 	ld	-8 (ix),#0x00
   1F4C DD 73 F9      [19] 2505 	ld	-7 (ix),e
   1F4F 7B            [ 4] 2506 	ld	a,e
   1F50 17            [ 4] 2507 	rla
   1F51 9F            [ 4] 2508 	sbc	a, a
   1F52 DD 77 FA      [19] 2509 	ld	-6 (ix),a
   1F55 DD 7E FD      [19] 2510 	ld	a,-3 (ix)
   1F58 DD 96 F7      [19] 2511 	sub	a, -9 (ix)
   1F5B 20 2E         [12] 2512 	jr	NZ,00108$
   1F5D DD 7E FE      [19] 2513 	ld	a,-2 (ix)
   1F60 DD 96 F8      [19] 2514 	sub	a, -8 (ix)
   1F63 20 26         [12] 2515 	jr	NZ,00108$
   1F65 3A 5B 0E      [13] 2516 	ld	a, (#(_player_position + 0x0001) + 0)
   1F68 DD 77 F7      [19] 2517 	ld	-9 (ix),a
   1F6B DD 36 F8 00   [19] 2518 	ld	-8 (ix),#0x00
   1F6F DD 7E F9      [19] 2519 	ld	a,-7 (ix)
   1F72 DD 96 F7      [19] 2520 	sub	a, -9 (ix)
   1F75 20 14         [12] 2521 	jr	NZ,00108$
   1F77 DD 7E FA      [19] 2522 	ld	a,-6 (ix)
   1F7A DD 96 F8      [19] 2523 	sub	a, -8 (ix)
   1F7D 20 0C         [12] 2524 	jr	NZ,00108$
                           2525 ;src/Renderer.c:941: *ptr=g_colors[MINIMAP_PLAYER_COLOR];
   1F7F 3A 6A 10      [13] 2526 	ld	a, (#(_g_colors + 0x0004) + 0)
   1F82 02            [ 7] 2527 	ld	(bc),a
                           2528 ;src/Renderer.c:942: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
   1F83 3A 6A 10      [13] 2529 	ld	a, (#(_g_colors + 0x0004) + 0)
   1F86 FD 77 00      [19] 2530 	ld	0 (iy), a
   1F89 18 50         [12] 2531 	jr	00113$
   1F8B                    2532 00108$:
                           2533 ;src/Renderer.c:945: val = (*(u8*)(MAP_MEM+x+y*MAP_WIDTH));
   1F8B DD 7E FD      [19] 2534 	ld	a,-3 (ix)
   1F8E C6 00         [ 7] 2535 	add	a, #0x00
   1F90 DD 77 F7      [19] 2536 	ld	-9 (ix),a
   1F93 DD 7E FE      [19] 2537 	ld	a,-2 (ix)
   1F96 CE 70         [ 7] 2538 	adc	a, #0x70
   1F98 DD 77 F8      [19] 2539 	ld	-8 (ix),a
   1F9B DD 6E F9      [19] 2540 	ld	l,-7 (ix)
   1F9E DD 66 FA      [19] 2541 	ld	h,-6 (ix)
   1FA1 29            [11] 2542 	add	hl, hl
   1FA2 29            [11] 2543 	add	hl, hl
   1FA3 29            [11] 2544 	add	hl, hl
   1FA4 29            [11] 2545 	add	hl, hl
   1FA5 29            [11] 2546 	add	hl, hl
   1FA6 DD 7E F7      [19] 2547 	ld	a,-9 (ix)
   1FA9 85            [ 4] 2548 	add	a, l
   1FAA 6F            [ 4] 2549 	ld	l,a
   1FAB DD 7E F8      [19] 2550 	ld	a,-8 (ix)
   1FAE 8C            [ 4] 2551 	adc	a, h
   1FAF 67            [ 4] 2552 	ld	h,a
   1FB0 66            [ 7] 2553 	ld	h,(hl)
                           2554 ;src/Renderer.c:947: if(val==CELLTYPE_DOOR){
   1FB1 7C            [ 4] 2555 	ld	a,h
   1FB2 D6 80         [ 7] 2556 	sub	a, #0x80
   1FB4 20 0C         [12] 2557 	jr	NZ,00105$
                           2558 ;src/Renderer.c:948: *ptr=g_colors[MINIMAP_EXIT_COLOR];
   1FB6 3A 6B 10      [13] 2559 	ld	a, (#(_g_colors + 0x0005) + 0)
   1FB9 02            [ 7] 2560 	ld	(bc),a
                           2561 ;src/Renderer.c:949: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
   1FBA 3A 6B 10      [13] 2562 	ld	a, (#(_g_colors + 0x0005) + 0)
   1FBD FD 77 00      [19] 2563 	ld	0 (iy), a
   1FC0 18 19         [12] 2564 	jr	00113$
   1FC2                    2565 00105$:
                           2566 ;src/Renderer.c:951: else if(val&CELL_WALL_MASK){
   1FC2 29            [11] 2567 	add	hl, hl
   1FC3 30 0C         [12] 2568 	jr	NC,00102$
                           2569 ;src/Renderer.c:952: *ptr=g_colors[MINIMAP_WALL_COLOR];
   1FC5 3A 67 10      [13] 2570 	ld	a, (#(_g_colors + 0x0001) + 0)
   1FC8 02            [ 7] 2571 	ld	(bc),a
                           2572 ;src/Renderer.c:953: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
   1FC9 3A 67 10      [13] 2573 	ld	a, (#(_g_colors + 0x0001) + 0)
   1FCC FD 77 00      [19] 2574 	ld	0 (iy), a
   1FCF 18 0A         [12] 2575 	jr	00113$
   1FD1                    2576 00102$:
                           2577 ;src/Renderer.c:956: *ptr=g_colors[MINIMAP_FLOOR_COLOR];
   1FD1 3A 69 10      [13] 2578 	ld	a, (#(_g_colors + 0x0003) + 0)
   1FD4 02            [ 7] 2579 	ld	(bc),a
                           2580 ;src/Renderer.c:957: *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
   1FD5 3A 69 10      [13] 2581 	ld	a, (#(_g_colors + 0x0003) + 0)
   1FD8 FD 77 00      [19] 2582 	ld	0 (iy), a
   1FDB                    2583 00113$:
                           2584 ;src/Renderer.c:960: ++x;
   1FDB DD 34 FC      [23] 2585 	inc	-4 (ix)
                           2586 ;src/Renderer.c:961: ++ptr;
   1FDE 03            [ 6] 2587 	inc	bc
                           2588 ;src/Renderer.c:935: for(i=0;i<MINIMAP_WIDTH;++i){
   1FDF DD 34 F6      [23] 2589 	inc	-10 (ix)
   1FE2 DD 7E F6      [19] 2590 	ld	a,-10 (ix)
   1FE5 D6 10         [ 7] 2591 	sub	a, #0x10
   1FE7 DA 06 1F      [10] 2592 	jp	C,00120$
                           2593 ;src/Renderer.c:933: for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
   1FEA DD 34 F5      [23] 2594 	inc	-11 (ix)
   1FED DD 7E F5      [19] 2595 	ld	a,-11 (ix)
   1FF0 D6 04         [ 7] 2596 	sub	a, #0x04
   1FF2 DA FA 1E      [10] 2597 	jp	C,00122$
                           2598 ;src/Renderer.c:964: ++y;
   1FF5 1C            [ 4] 2599 	inc	e
                           2600 ;src/Renderer.c:932: for(j=0;j<MINIMAP_HEIGHT;++j){
   1FF6 14            [ 4] 2601 	inc	d
   1FF7 7A            [ 4] 2602 	ld	a,d
   1FF8 D6 10         [ 7] 2603 	sub	a, #0x10
   1FFA DA E4 1E      [10] 2604 	jp	C,00137$
   1FFD DD F9         [10] 2605 	ld	sp, ix
   1FFF DD E1         [14] 2606 	pop	ix
   2001 C9            [10] 2607 	ret
                           2608 	.area _CODE
                           2609 	.area _INITIALIZER
                           2610 	.area _CABS (ABS)
