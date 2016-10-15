                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module Player
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _player_directionArray
                             12 	.globl _player_directionIndex
                             13 	.globl _player_direction
                             14 	.globl _player_position
                             15 	.globl _player_turn_left
                             16 	.globl _player_turn_right
                             17 	.globl _player_move_forward
                             18 	.globl _player_get_direction_index
                             19 ;--------------------------------------------------------
                             20 ; special function registers
                             21 ;--------------------------------------------------------
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _DATA
                             26 ;--------------------------------------------------------
                             27 ; ram data
                             28 ;--------------------------------------------------------
                             29 	.area _INITIALIZED
                             30 ;--------------------------------------------------------
                             31 ; absolute external ram data
                             32 ;--------------------------------------------------------
                             33 	.area _DABS (ABS)
                             34 ;--------------------------------------------------------
                             35 ; global & static initialisations
                             36 ;--------------------------------------------------------
                             37 	.area _HOME
                             38 	.area _GSINIT
                             39 	.area _GSFINAL
                             40 	.area _GSINIT
                             41 ;--------------------------------------------------------
                             42 ; Home
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _HOME
                             46 ;--------------------------------------------------------
                             47 ; code
                             48 ;--------------------------------------------------------
                             49 	.area _CODE
                             50 ;src/Player.c:19: void player_turn_left(){
                             51 ;	---------------------------------
                             52 ; Function player_turn_left
                             53 ; ---------------------------------
   085B                      54 _player_turn_left::
                             55 ;src/Player.c:20: *(u8*)&(player_directionIndex)=(player_directionIndex+2)&7;
   085B 01 8D 08      [10]   56 	ld	bc,#_player_directionIndex+0
   085E 3A 8D 08      [13]   57 	ld	a,(#_player_directionIndex + 0)
   0861 C6 02         [ 7]   58 	add	a, #0x02
   0863 E6 07         [ 7]   59 	and	a, #0x07
   0865 02            [ 7]   60 	ld	(bc),a
                             61 ;src/Player.c:21: *(i8*)&(player_direction.x) = player_directionArray[(player_directionIndex)];
   0866 01 8B 08      [10]   62 	ld	bc,#_player_direction+0
   0869 11 8E 08      [10]   63 	ld	de,#_player_directionArray+0
   086C FD 21 8D 08   [14]   64 	ld	iy,#_player_directionIndex
   0870 FD 6E 00      [19]   65 	ld	l,0 (iy)
   0873 26 00         [ 7]   66 	ld	h,#0x00
   0875 19            [11]   67 	add	hl,de
   0876 7E            [ 7]   68 	ld	a,(hl)
   0877 02            [ 7]   69 	ld	(bc),a
                             70 ;src/Player.c:22: *(i8*)&(player_direction.y) = player_directionArray[((player_directionIndex)+1)];
   0878 01 8C 08      [10]   71 	ld	bc,#_player_direction+1
   087B FD 21 8D 08   [14]   72 	ld	iy,#_player_directionIndex
   087F FD 6E 00      [19]   73 	ld	l,0 (iy)
   0882 2C            [ 4]   74 	inc	l
   0883 26 00         [ 7]   75 	ld	h,#0x00
   0885 19            [11]   76 	add	hl,de
   0886 7E            [ 7]   77 	ld	a,(hl)
   0887 02            [ 7]   78 	ld	(bc),a
   0888 C9            [10]   79 	ret
   0889                      80 _player_position:
   0889 01                   81 	.db #0x01	; 1
   088A 01                   82 	.db #0x01	; 1
   088B                      83 _player_direction:
   088B 01                   84 	.db #0x01	;  1
   088C 00                   85 	.db #0x00	;  0
   088D                      86 _player_directionIndex:
   088D 00                   87 	.db #0x00	; 0
   088E                      88 _player_directionArray:
   088E 01                   89 	.db #0x01	;  1
   088F 00                   90 	.db #0x00	;  0
   0890 00                   91 	.db #0x00	;  0
   0891 FF                   92 	.db #0xFF	; -1
   0892 FF                   93 	.db #0xFF	; -1
   0893 00                   94 	.db #0x00	;  0
   0894 00                   95 	.db #0x00	;  0
   0895 01                   96 	.db #0x01	;  1
                             97 ;src/Player.c:25: void player_turn_right(){
                             98 ;	---------------------------------
                             99 ; Function player_turn_right
                            100 ; ---------------------------------
   0896                     101 _player_turn_right::
                            102 ;src/Player.c:27: *(u8*)&(player_directionIndex)=(player_directionIndex-2)&7;
   0896 01 8D 08      [10]  103 	ld	bc,#_player_directionIndex+0
   0899 3A 8D 08      [13]  104 	ld	a,(#_player_directionIndex + 0)
   089C C6 FE         [ 7]  105 	add	a,#0xFE
   089E E6 07         [ 7]  106 	and	a, #0x07
   08A0 02            [ 7]  107 	ld	(bc),a
                            108 ;src/Player.c:28: *(i8*)&(player_direction.x) = player_directionArray[(player_directionIndex)];
   08A1 01 8B 08      [10]  109 	ld	bc,#_player_direction+0
   08A4 11 8E 08      [10]  110 	ld	de,#_player_directionArray+0
   08A7 FD 21 8D 08   [14]  111 	ld	iy,#_player_directionIndex
   08AB FD 6E 00      [19]  112 	ld	l,0 (iy)
   08AE 26 00         [ 7]  113 	ld	h,#0x00
   08B0 19            [11]  114 	add	hl,de
   08B1 7E            [ 7]  115 	ld	a,(hl)
   08B2 02            [ 7]  116 	ld	(bc),a
                            117 ;src/Player.c:29: *(i8*)&(player_direction.y) = player_directionArray[((player_directionIndex)+1)];
   08B3 01 8C 08      [10]  118 	ld	bc,#_player_direction+1
   08B6 FD 21 8D 08   [14]  119 	ld	iy,#_player_directionIndex
   08BA FD 6E 00      [19]  120 	ld	l,0 (iy)
   08BD 2C            [ 4]  121 	inc	l
   08BE 26 00         [ 7]  122 	ld	h,#0x00
   08C0 19            [11]  123 	add	hl,de
   08C1 7E            [ 7]  124 	ld	a,(hl)
   08C2 02            [ 7]  125 	ld	(bc),a
   08C3 C9            [10]  126 	ret
                            127 ;src/Player.c:32: void player_move_forward(){
                            128 ;	---------------------------------
                            129 ; Function player_move_forward
                            130 ; ---------------------------------
   08C4                     131 _player_move_forward::
                            132 ;src/Player.c:33: *(i8*)&(player_position.x) = player_position.x + player_direction.x;
   08C4 21 89 08      [10]  133 	ld	hl,#_player_position+0
   08C7 4D            [ 4]  134 	ld	c, l
   08C8 44            [ 4]  135 	ld	b, h
   08C9 56            [ 7]  136 	ld	d,(hl)
   08CA 21 8B 08      [10]  137 	ld	hl,#_player_direction+0
   08CD 5E            [ 7]  138 	ld	e,(hl)
   08CE 7A            [ 4]  139 	ld	a,d
   08CF 83            [ 4]  140 	add	a, e
   08D0 02            [ 7]  141 	ld	(bc),a
                            142 ;src/Player.c:34: *(i8*)&(player_position.y) = player_position.y + player_direction.y;
   08D1 21 8A 08      [10]  143 	ld	hl,#_player_position+1
   08D4 4D            [ 4]  144 	ld	c, l
   08D5 44            [ 4]  145 	ld	b, h
   08D6 56            [ 7]  146 	ld	d,(hl)
   08D7 21 8C 08      [10]  147 	ld	hl,#_player_direction+1
   08DA 5E            [ 7]  148 	ld	e,(hl)
   08DB 7A            [ 4]  149 	ld	a,d
   08DC 83            [ 4]  150 	add	a, e
   08DD 02            [ 7]  151 	ld	(bc),a
   08DE C9            [10]  152 	ret
                            153 ;src/Player.c:37: u8 player_get_direction_index(){
                            154 ;	---------------------------------
                            155 ; Function player_get_direction_index
                            156 ; ---------------------------------
   08DF                     157 _player_get_direction_index::
                            158 ;src/Player.c:38: return player_directionIndex;
   08DF FD 21 8D 08   [14]  159 	ld	iy,#_player_directionIndex
   08E3 FD 6E 00      [19]  160 	ld	l,0 (iy)
   08E6 C9            [10]  161 	ret
                            162 	.area _CODE
                            163 	.area _INITIALIZER
                            164 	.area _CABS (ABS)
