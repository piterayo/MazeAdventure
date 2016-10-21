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
                             11 	.globl _player_directionIndex
                             12 	.globl _player_direction
                             13 	.globl _player_position
                             14 	.globl _player_turn_left
                             15 	.globl _player_turn_right
                             16 	.globl _player_move_forward
                             17 	.globl _player_get_direction_index
                             18 ;--------------------------------------------------------
                             19 ; special function registers
                             20 ;--------------------------------------------------------
                             21 ;--------------------------------------------------------
                             22 ; ram data
                             23 ;--------------------------------------------------------
                             24 	.area _DATA
   5B2A                      25 _player_directionIndex::
   5B2A                      26 	.ds 1
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
                             51 ;src/Player.c:17: void player_turn_left(){
                             52 ;	---------------------------------
                             53 ; Function player_turn_left
                             54 ; ---------------------------------
   0E31                      55 _player_turn_left::
                             56 ;src/Player.c:18: (player_directionIndex)=(player_directionIndex+2)&7;
   0E31 3A 2A 5B      [13]   57 	ld	a,(#_player_directionIndex + 0)
   0E34 C6 02         [ 7]   58 	add	a, #0x02
   0E36 E6 07         [ 7]   59 	and	a, #0x07
   0E38 32 2A 5B      [13]   60 	ld	(#_player_directionIndex + 0),a
                             61 ;src/Player.c:19: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
   0E3B 11 B6 06      [10]   62 	ld	de,#_movement_directionArray+0
   0E3E 2A 2A 5B      [16]   63 	ld	hl,(_player_directionIndex)
   0E41 26 00         [ 7]   64 	ld	h,#0x00
   0E43 19            [11]   65 	add	hl,de
   0E44 4E            [ 7]   66 	ld	c,(hl)
   0E45 21 5C 0E      [10]   67 	ld	hl,#_player_direction
   0E48 71            [ 7]   68 	ld	(hl),c
                             69 ;src/Player.c:20: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
   0E49 01 5D 0E      [10]   70 	ld	bc,#_player_direction+1
   0E4C FD 21 2A 5B   [14]   71 	ld	iy,#_player_directionIndex
   0E50 FD 6E 00      [19]   72 	ld	l,0 (iy)
   0E53 2C            [ 4]   73 	inc	l
   0E54 26 00         [ 7]   74 	ld	h,#0x00
   0E56 19            [11]   75 	add	hl,de
   0E57 7E            [ 7]   76 	ld	a,(hl)
   0E58 02            [ 7]   77 	ld	(bc),a
   0E59 C9            [10]   78 	ret
   0E5A                      79 _player_position:
   0E5A 01                   80 	.db #0x01	; 1
   0E5B 01                   81 	.db #0x01	; 1
   0E5C                      82 _player_direction:
   0E5C 01                   83 	.db #0x01	;  1
   0E5D 00                   84 	.db #0x00	;  0
                             85 ;src/Player.c:23: void player_turn_right(){
                             86 ;	---------------------------------
                             87 ; Function player_turn_right
                             88 ; ---------------------------------
   0E5E                      89 _player_turn_right::
                             90 ;src/Player.c:25: (player_directionIndex)=(player_directionIndex-2)&7;
   0E5E 3A 2A 5B      [13]   91 	ld	a,(#_player_directionIndex + 0)
   0E61 C6 FE         [ 7]   92 	add	a,#0xFE
   0E63 E6 07         [ 7]   93 	and	a, #0x07
   0E65 32 2A 5B      [13]   94 	ld	(#_player_directionIndex + 0),a
                             95 ;src/Player.c:26: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
   0E68 11 B6 06      [10]   96 	ld	de,#_movement_directionArray+0
   0E6B 2A 2A 5B      [16]   97 	ld	hl,(_player_directionIndex)
   0E6E 26 00         [ 7]   98 	ld	h,#0x00
   0E70 19            [11]   99 	add	hl,de
   0E71 4E            [ 7]  100 	ld	c,(hl)
   0E72 21 5C 0E      [10]  101 	ld	hl,#_player_direction
   0E75 71            [ 7]  102 	ld	(hl),c
                            103 ;src/Player.c:27: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
   0E76 01 5D 0E      [10]  104 	ld	bc,#_player_direction+1
   0E79 FD 21 2A 5B   [14]  105 	ld	iy,#_player_directionIndex
   0E7D FD 6E 00      [19]  106 	ld	l,0 (iy)
   0E80 2C            [ 4]  107 	inc	l
   0E81 26 00         [ 7]  108 	ld	h,#0x00
   0E83 19            [11]  109 	add	hl,de
   0E84 7E            [ 7]  110 	ld	a,(hl)
   0E85 02            [ 7]  111 	ld	(bc),a
   0E86 C9            [10]  112 	ret
                            113 ;src/Player.c:30: void player_move_forward(){
                            114 ;	---------------------------------
                            115 ; Function player_move_forward
                            116 ; ---------------------------------
   0E87                     117 _player_move_forward::
                            118 ;src/Player.c:31: *(i8*)&(player_position.x) = player_position.x + player_direction.x;
   0E87 21 5A 0E      [10]  119 	ld	hl,#_player_position+0
   0E8A 4D            [ 4]  120 	ld	c, l
   0E8B 44            [ 4]  121 	ld	b, h
   0E8C 56            [ 7]  122 	ld	d,(hl)
   0E8D 21 5C 0E      [10]  123 	ld	hl,#_player_direction+0
   0E90 5E            [ 7]  124 	ld	e,(hl)
   0E91 7A            [ 4]  125 	ld	a,d
   0E92 83            [ 4]  126 	add	a, e
   0E93 02            [ 7]  127 	ld	(bc),a
                            128 ;src/Player.c:32: *(i8*)&(player_position.y) = player_position.y + player_direction.y;
   0E94 21 5B 0E      [10]  129 	ld	hl,#_player_position+1
   0E97 4D            [ 4]  130 	ld	c, l
   0E98 44            [ 4]  131 	ld	b, h
   0E99 56            [ 7]  132 	ld	d,(hl)
   0E9A 21 5D 0E      [10]  133 	ld	hl,#_player_direction+1
   0E9D 5E            [ 7]  134 	ld	e,(hl)
   0E9E 7A            [ 4]  135 	ld	a,d
   0E9F 83            [ 4]  136 	add	a, e
   0EA0 02            [ 7]  137 	ld	(bc),a
   0EA1 C9            [10]  138 	ret
                            139 ;src/Player.c:35: u8 player_get_direction_index(){
                            140 ;	---------------------------------
                            141 ; Function player_get_direction_index
                            142 ; ---------------------------------
   0EA2                     143 _player_get_direction_index::
                            144 ;src/Player.c:36: return player_directionIndex;
   0EA2 FD 21 2A 5B   [14]  145 	ld	iy,#_player_directionIndex
   0EA6 FD 6E 00      [19]  146 	ld	l,0 (iy)
   0EA9 C9            [10]  147 	ret
                            148 	.area _CODE
                            149 	.area _INITIALIZER
                            150 	.area _CABS (ABS)
