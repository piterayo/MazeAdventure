                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Enemy
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _abs
                             12 	.globl _enemyArray
                             13 	.globl _activeEnemies
                             14 	.globl _Enemy_spawn_new
                             15 	.globl _Enemy_update_logic
                             16 ;--------------------------------------------------------
                             17 ; special function registers
                             18 ;--------------------------------------------------------
                             19 ;--------------------------------------------------------
                             20 ; ram data
                             21 ;--------------------------------------------------------
                             22 	.area _DATA
   40C4                      23 _enemyArray::
   40C4                      24 	.ds 180
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _INITIALIZED
                             29 ;--------------------------------------------------------
                             30 ; absolute external ram data
                             31 ;--------------------------------------------------------
                             32 	.area _DABS (ABS)
                             33 ;--------------------------------------------------------
                             34 ; global & static initialisations
                             35 ;--------------------------------------------------------
                             36 	.area _HOME
                             37 	.area _GSINIT
                             38 	.area _GSFINAL
                             39 	.area _GSINIT
                             40 ;--------------------------------------------------------
                             41 ; Home
                             42 ;--------------------------------------------------------
                             43 	.area _HOME
                             44 	.area _HOME
                             45 ;--------------------------------------------------------
                             46 ; code
                             47 ;--------------------------------------------------------
                             48 	.area _CODE
                             49 ;src/Enemy.c:8: u8 abs(u8 n){
                             50 ;	---------------------------------
                             51 ; Function abs
                             52 ; ---------------------------------
   0040                      53 _abs::
                             54 ;src/Enemy.c:9: return ~n+1;
   0040 21 02 00      [10]   55 	ld	hl, #2+0
   0043 39            [11]   56 	add	hl, sp
   0044 7E            [ 7]   57 	ld	a, (hl)
   0045 2F            [ 4]   58 	cpl
   0046 4F            [ 4]   59 	ld	c,a
   0047 0C            [ 4]   60 	inc	c
   0048 69            [ 4]   61 	ld	l,c
   0049 C9            [10]   62 	ret
   004A                      63 _activeEnemies:
   004A 00                   64 	.db #0x00	; 0
                             65 ;src/Enemy.c:12: void Enemy_spawn_new(){
                             66 ;	---------------------------------
                             67 ; Function Enemy_spawn_new
                             68 ; ---------------------------------
   004B                      69 _Enemy_spawn_new::
                             70 ;src/Enemy.c:15: if(activeEnemies<15){
   004B 3A 4A 00      [13]   71 	ld	a,(#_activeEnemies + 0)
   004E D6 0F         [ 7]   72 	sub	a, #0x0F
   0050 D0            [11]   73 	ret	NC
                             74 ;src/Enemy.c:16: while(i){
   0051 0E 0F         [ 7]   75 	ld	c,#0x0F
   0053 11 B4 00      [10]   76 	ld	de,#0x00B4
   0056                      77 00103$:
   0056 79            [ 4]   78 	ld	a,c
   0057 B7            [ 4]   79 	or	a, a
   0058 C8            [11]   80 	ret	Z
                             81 ;src/Enemy.c:17: --i;
   0059 7B            [ 4]   82 	ld	a,e
   005A C6 F4         [ 7]   83 	add	a,#0xF4
   005C 5F            [ 4]   84 	ld	e,a
   005D 7A            [ 4]   85 	ld	a,d
   005E CE FF         [ 7]   86 	adc	a,#0xFF
   0060 57            [ 4]   87 	ld	d,a
   0061 0D            [ 4]   88 	dec	c
                             89 ;src/Enemy.c:18: if(enemyArray[i].hitPoints==0){
   0062 FD 21 C4 40   [14]   90 	ld	iy,#_enemyArray+0
   0066 FD 19         [15]   91 	add	iy,de
   0068 FD E5         [15]   92 	push	iy
   006A E1            [10]   93 	pop	hl
   006B 23            [ 6]   94 	inc	hl
   006C 23            [ 6]   95 	inc	hl
   006D 23            [ 6]   96 	inc	hl
   006E 7E            [ 7]   97 	ld	a, (hl)
   006F 23            [ 6]   98 	inc	hl
   0070 66            [ 7]   99 	ld	h,(hl)
   0071 B4            [ 4]  100 	or	a,h
   0072 20 E2         [12]  101 	jr	NZ,00103$
                            102 ;src/Enemy.c:19: e = &enemyArray[i];
   0074 FD E5         [15]  103 	push	iy
   0076 C1            [10]  104 	pop	bc
                            105 ;src/Enemy.c:21: e->textureId = 0;
   0077 AF            [ 4]  106 	xor	a, a
   0078 02            [ 7]  107 	ld	(bc),a
                            108 ;src/Enemy.c:23: e->hitPoints = 10;
   0079 03            [ 6]  109 	inc	bc
   007A 03            [ 6]  110 	inc	bc
   007B 03            [ 6]  111 	inc	bc
   007C 60            [ 4]  112 	ld	h,b
   007D 69            [ 4]  113 	ld	l, c
   007E 36 0A         [10]  114 	ld	(hl),#0x0A
   0080 23            [ 6]  115 	inc	hl
   0081 36 00         [10]  116 	ld	(hl),#0x00
                            117 ;src/Enemy.c:25: break;
   0083 C9            [10]  118 	ret
                            119 ;src/Enemy.c:31: void Enemy_update_logic(){
                            120 ;	---------------------------------
                            121 ; Function Enemy_update_logic
                            122 ; ---------------------------------
   0084                     123 _Enemy_update_logic::
                            124 ;src/Enemy.c:33: }
   0084 C9            [10]  125 	ret
                            126 	.area _CODE
                            127 	.area _INITIALIZER
                            128 	.area _CABS (ABS)
