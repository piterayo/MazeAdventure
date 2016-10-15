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
                             11 	.globl _enemyArray
                             12 	.globl _activeEnemies
                             13 	.globl _Enemy_spawn_new
                             14 	.globl _Enemy_update_logic
                             15 ;--------------------------------------------------------
                             16 ; special function registers
                             17 ;--------------------------------------------------------
                             18 ;--------------------------------------------------------
                             19 ; ram data
                             20 ;--------------------------------------------------------
                             21 	.area _DATA
   49F4                      22 _enemyArray::
   49F4                      23 	.ds 180
                             24 ;--------------------------------------------------------
                             25 ; ram data
                             26 ;--------------------------------------------------------
                             27 	.area _INITIALIZED
                             28 ;--------------------------------------------------------
                             29 ; absolute external ram data
                             30 ;--------------------------------------------------------
                             31 	.area _DABS (ABS)
                             32 ;--------------------------------------------------------
                             33 ; global & static initialisations
                             34 ;--------------------------------------------------------
                             35 	.area _HOME
                             36 	.area _GSINIT
                             37 	.area _GSFINAL
                             38 	.area _GSINIT
                             39 ;--------------------------------------------------------
                             40 ; Home
                             41 ;--------------------------------------------------------
                             42 	.area _HOME
                             43 	.area _HOME
                             44 ;--------------------------------------------------------
                             45 ; code
                             46 ;--------------------------------------------------------
                             47 	.area _CODE
                             48 ;src/Enemy.c:12: void Enemy_spawn_new(){
                             49 ;	---------------------------------
                             50 ; Function Enemy_spawn_new
                             51 ; ---------------------------------
   0040                      52 _Enemy_spawn_new::
                             53 ;src/Enemy.c:15: if(activeEnemies<15){
   0040 3A 79 00      [13]   54 	ld	a,(#_activeEnemies + 0)
   0043 D6 0F         [ 7]   55 	sub	a, #0x0F
   0045 D0            [11]   56 	ret	NC
                             57 ;src/Enemy.c:16: while(i){
   0046 0E 0F         [ 7]   58 	ld	c,#0x0F
   0048 11 B4 00      [10]   59 	ld	de,#0x00B4
   004B                      60 00103$:
   004B 79            [ 4]   61 	ld	a,c
   004C B7            [ 4]   62 	or	a, a
   004D C8            [11]   63 	ret	Z
                             64 ;src/Enemy.c:17: --i;
   004E 7B            [ 4]   65 	ld	a,e
   004F C6 F4         [ 7]   66 	add	a,#0xF4
   0051 5F            [ 4]   67 	ld	e,a
   0052 7A            [ 4]   68 	ld	a,d
   0053 CE FF         [ 7]   69 	adc	a,#0xFF
   0055 57            [ 4]   70 	ld	d,a
   0056 0D            [ 4]   71 	dec	c
                             72 ;src/Enemy.c:18: if(enemyArray[i].hitPoints==0){
   0057 FD 21 F4 49   [14]   73 	ld	iy,#_enemyArray+0
   005B FD 19         [15]   74 	add	iy,de
   005D FD E5         [15]   75 	push	iy
   005F E1            [10]   76 	pop	hl
   0060 23            [ 6]   77 	inc	hl
   0061 23            [ 6]   78 	inc	hl
   0062 23            [ 6]   79 	inc	hl
   0063 7E            [ 7]   80 	ld	a, (hl)
   0064 23            [ 6]   81 	inc	hl
   0065 66            [ 7]   82 	ld	h,(hl)
   0066 B4            [ 4]   83 	or	a,h
   0067 20 E2         [12]   84 	jr	NZ,00103$
                             85 ;src/Enemy.c:19: e = &enemyArray[i];
   0069 FD E5         [15]   86 	push	iy
   006B C1            [10]   87 	pop	bc
                             88 ;src/Enemy.c:21: e->textureId = 0;
   006C AF            [ 4]   89 	xor	a, a
   006D 02            [ 7]   90 	ld	(bc),a
                             91 ;src/Enemy.c:23: e->hitPoints = 10;
   006E 03            [ 6]   92 	inc	bc
   006F 03            [ 6]   93 	inc	bc
   0070 03            [ 6]   94 	inc	bc
   0071 60            [ 4]   95 	ld	h,b
   0072 69            [ 4]   96 	ld	l, c
   0073 36 0A         [10]   97 	ld	(hl),#0x0A
   0075 23            [ 6]   98 	inc	hl
   0076 36 00         [10]   99 	ld	(hl),#0x00
                            100 ;src/Enemy.c:25: break;
   0078 C9            [10]  101 	ret
   0079                     102 _activeEnemies:
   0079 00                  103 	.db #0x00	; 0
                            104 ;src/Enemy.c:31: void Enemy_update_logic(){
                            105 ;	---------------------------------
                            106 ; Function Enemy_update_logic
                            107 ; ---------------------------------
   007A                     108 _Enemy_update_logic::
                            109 ;src/Enemy.c:33: }
   007A C9            [10]  110 	ret
                            111 	.area _CODE
                            112 	.area _INITIALIZER
                            113 	.area _CABS (ABS)
