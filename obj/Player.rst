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
   086A                      54 _player_turn_left::
                             55 ;src/Player.c:20: *(u8*)&(player_directionIndex)=(player_directionIndex+2)&7;
   086A 01 9C 08      [10]   56 	ld	bc,#_player_directionIndex+0
   086D 3A 9C 08      [13]   57 	ld	a,(#_player_directionIndex + 0)
   0870 C6 02         [ 7]   58 	add	a, #0x02
   0872 E6 07         [ 7]   59 	and	a, #0x07
   0874 02            [ 7]   60 	ld	(bc),a
                             61 ;src/Player.c:21: *(i8*)&(player_direction.x) = player_directionArray[(player_directionIndex)];
   0875 01 9A 08      [10]   62 	ld	bc,#_player_direction+0
   0878 11 9D 08      [10]   63 	ld	de,#_player_directionArray+0
   087B FD 21 9C 08   [14]   64 	ld	iy,#_player_directionIndex
   087F FD 6E 00      [19]   65 	ld	l,0 (iy)
   0882 26 00         [ 7]   66 	ld	h,#0x00
   0884 19            [11]   67 	add	hl,de
   0885 7E            [ 7]   68 	ld	a,(hl)
   0886 02            [ 7]   69 	ld	(bc),a
                             70 ;src/Player.c:22: *(i8*)&(player_direction.y) = player_directionArray[((player_directionIndex)+1)];
   0887 01 9B 08      [10]   71 	ld	bc,#_player_direction+1
   088A FD 21 9C 08   [14]   72 	ld	iy,#_player_directionIndex
   088E FD 6E 00      [19]   73 	ld	l,0 (iy)
   0891 2C            [ 4]   74 	inc	l
   0892 26 00         [ 7]   75 	ld	h,#0x00
   0894 19            [11]   76 	add	hl,de
   0895 7E            [ 7]   77 	ld	a,(hl)
   0896 02            [ 7]   78 	ld	(bc),a
   0897 C9            [10]   79 	ret
   0898                      80 _player_position:
   0898 01                   81 	.db #0x01	; 1
   0899 01                   82 	.db #0x01	; 1
   089A                      83 _player_direction:
   089A 01                   84 	.db #0x01	;  1
   089B 00                   85 	.db #0x00	;  0
   089C                      86 _player_directionIndex:
   089C 00                   87 	.db #0x00	; 0
   089D                      88 _player_directionArray:
   089D 01                   89 	.db #0x01	;  1
   089E 00                   90 	.db #0x00	;  0
   089F 00                   91 	.db #0x00	;  0
   08A0 FF                   92 	.db #0xFF	; -1
   08A1 FF                   93 	.db #0xFF	; -1
   08A2 00                   94 	.db #0x00	;  0
   08A3 00                   95 	.db #0x00	;  0
   08A4 01                   96 	.db #0x01	;  1
                             97 ;src/Player.c:25: void player_turn_right(){
                             98 ;	---------------------------------
                             99 ; Function player_turn_right
                            100 ; ---------------------------------
   08A5                     101 _player_turn_right::
                            102 ;src/Player.c:27: *(u8*)&(player_directionIndex)=(player_directionIndex-2)&7;
   08A5 01 9C 08      [10]  103 	ld	bc,#_player_directionIndex+0
   08A8 3A 9C 08      [13]  104 	ld	a,(#_player_directionIndex + 0)
   08AB C6 FE         [ 7]  105 	add	a,#0xFE
   08AD E6 07         [ 7]  106 	and	a, #0x07
   08AF 02            [ 7]  107 	ld	(bc),a
                            108 ;src/Player.c:28: *(i8*)&(player_direction.x) = player_directionArray[(player_directionIndex)];
   08B0 01 9A 08      [10]  109 	ld	bc,#_player_direction+0
   08B3 11 9D 08      [10]  110 	ld	de,#_player_directionArray+0
   08B6 FD 21 9C 08   [14]  111 	ld	iy,#_player_directionIndex
   08BA FD 6E 00      [19]  112 	ld	l,0 (iy)
   08BD 26 00         [ 7]  113 	ld	h,#0x00
   08BF 19            [11]  114 	add	hl,de
   08C0 7E            [ 7]  115 	ld	a,(hl)
   08C1 02            [ 7]  116 	ld	(bc),a
                            117 ;src/Player.c:29: *(i8*)&(player_direction.y) = player_directionArray[((player_directionIndex)+1)];
   08C2 01 9B 08      [10]  118 	ld	bc,#_player_direction+1
   08C5 FD 21 9C 08   [14]  119 	ld	iy,#_player_directionIndex
   08C9 FD 6E 00      [19]  120 	ld	l,0 (iy)
   08CC 2C            [ 4]  121 	inc	l
   08CD 26 00         [ 7]  122 	ld	h,#0x00
   08CF 19            [11]  123 	add	hl,de
   08D0 7E            [ 7]  124 	ld	a,(hl)
   08D1 02            [ 7]  125 	ld	(bc),a
   08D2 C9            [10]  126 	ret
                            127 ;src/Player.c:32: void player_move_forward(){
                            128 ;	---------------------------------
                            129 ; Function player_move_forward
                            130 ; ---------------------------------
   08D3                     131 _player_move_forward::
                            132 ;src/Player.c:33: *(i8*)&(player_position.x) = player_position.x + player_direction.x;
   08D3 21 98 08      [10]  133 	ld	hl,#_player_position+0
   08D6 4D            [ 4]  134 	ld	c, l
   08D7 44            [ 4]  135 	ld	b, h
   08D8 56            [ 7]  136 	ld	d,(hl)
   08D9 21 9A 08      [10]  137 	ld	hl,#_player_direction+0
   08DC 5E            [ 7]  138 	ld	e,(hl)
   08DD 7A            [ 4]  139 	ld	a,d
   08DE 83            [ 4]  140 	add	a, e
   08DF 02            [ 7]  141 	ld	(bc),a
                            142 ;src/Player.c:34: *(i8*)&(player_position.y) = player_position.y + player_direction.y;
   08E0 21 99 08      [10]  143 	ld	hl,#_player_position+1
   08E3 4D            [ 4]  144 	ld	c, l
   08E4 44            [ 4]  145 	ld	b, h
   08E5 56            [ 7]  146 	ld	d,(hl)
   08E6 21 9B 08      [10]  147 	ld	hl,#_player_direction+1
   08E9 5E            [ 7]  148 	ld	e,(hl)
   08EA 7A            [ 4]  149 	ld	a,d
   08EB 83            [ 4]  150 	add	a, e
   08EC 02            [ 7]  151 	ld	(bc),a
   08ED C9            [10]  152 	ret
                            153 ;src/Player.c:37: u8 player_get_direction_index(){
                            154 ;	---------------------------------
                            155 ; Function player_get_direction_index
                            156 ; ---------------------------------
   08EE                     157 _player_get_direction_index::
                            158 ;src/Player.c:38: return player_directionIndex;
   08EE FD 21 9C 08   [14]  159 	ld	iy,#_player_directionIndex
   08F2 FD 6E 00      [19]  160 	ld	l,0 (iy)
   08F5 C9            [10]  161 	ret
                            162 	.area _CODE
                            163 	.area _INITIALIZER
                            164 	.area _CABS (ABS)
