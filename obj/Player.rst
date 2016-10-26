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
                             12 	.globl _player_scroll_count
                             13 	.globl _player_potion_count
                             14 	.globl _player_has_key
                             15 	.globl _player_is_dead
                             16 	.globl _player_health_points
                             17 	.globl _player_attack_value
                             18 	.globl _player_defense_value
                             19 	.globl _player_direction
                             20 	.globl _player_position
                             21 	.globl _player_init
                             22 	.globl _player_turn_left
                             23 	.globl _player_turn_right
                             24 	.globl _player_move_forward
                             25 	.globl _player_get_direction_index
                             26 ;--------------------------------------------------------
                             27 ; special function registers
                             28 ;--------------------------------------------------------
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _DATA
   8705                      33 _player_defense_value::
   8705                      34 	.ds 1
   8706                      35 _player_attack_value::
   8706                      36 	.ds 1
   8707                      37 _player_health_points::
   8707                      38 	.ds 1
   8708                      39 _player_is_dead::
   8708                      40 	.ds 1
   8709                      41 _player_has_key::
   8709                      42 	.ds 1
   870A                      43 _player_potion_count::
   870A                      44 	.ds 1
   870B                      45 _player_scroll_count::
   870B                      46 	.ds 1
   870C                      47 _player_directionIndex::
   870C                      48 	.ds 1
                             49 ;--------------------------------------------------------
                             50 ; ram data
                             51 ;--------------------------------------------------------
                             52 	.area _INITIALIZED
                             53 ;--------------------------------------------------------
                             54 ; absolute external ram data
                             55 ;--------------------------------------------------------
                             56 	.area _DABS (ABS)
                             57 ;--------------------------------------------------------
                             58 ; global & static initialisations
                             59 ;--------------------------------------------------------
                             60 	.area _HOME
                             61 	.area _GSINIT
                             62 	.area _GSFINAL
                             63 	.area _GSINIT
                             64 ;--------------------------------------------------------
                             65 ; Home
                             66 ;--------------------------------------------------------
                             67 	.area _HOME
                             68 	.area _HOME
                             69 ;--------------------------------------------------------
                             70 ; code
                             71 ;--------------------------------------------------------
                             72 	.area _CODE
                             73 ;src/Player.c:30: void player_init(){
                             74 ;	---------------------------------
                             75 ; Function player_init
                             76 ; ---------------------------------
   19CA                      77 _player_init::
                             78 ;src/Player.c:31: player_attack_value = 52;
   19CA 21 06 87      [10]   79 	ld	hl,#_player_attack_value + 0
   19CD 36 34         [10]   80 	ld	(hl), #0x34
                             81 ;src/Player.c:32: player_defense_value = 8;
   19CF 21 05 87      [10]   82 	ld	hl,#_player_defense_value + 0
   19D2 36 08         [10]   83 	ld	(hl), #0x08
                             84 ;src/Player.c:33: player_is_dead=0;
   19D4 21 08 87      [10]   85 	ld	hl,#_player_is_dead + 0
   19D7 36 00         [10]   86 	ld	(hl), #0x00
                             87 ;src/Player.c:35: player_health_points = PLAYER_MAX_HP;
   19D9 21 07 87      [10]   88 	ld	hl,#_player_health_points + 0
   19DC 36 FF         [10]   89 	ld	(hl), #0xFF
                             90 ;src/Player.c:36: player_has_key=0;
   19DE 21 09 87      [10]   91 	ld	hl,#_player_has_key + 0
   19E1 36 00         [10]   92 	ld	(hl), #0x00
                             93 ;src/Player.c:37: player_potion_count=0;
   19E3 21 0A 87      [10]   94 	ld	hl,#_player_potion_count + 0
   19E6 36 00         [10]   95 	ld	(hl), #0x00
                             96 ;src/Player.c:38: player_scroll_count=0;
   19E8 21 0B 87      [10]   97 	ld	hl,#_player_scroll_count + 0
   19EB 36 00         [10]   98 	ld	(hl), #0x00
   19ED C9            [10]   99 	ret
   19EE                     100 _player_position:
   19EE 01                  101 	.db #0x01	; 1
   19EF 01                  102 	.db #0x01	; 1
   19F0                     103 _player_direction:
   19F0 01                  104 	.db #0x01	;  1
   19F1 00                  105 	.db #0x00	;  0
                            106 ;src/Player.c:42: void player_turn_left(){
                            107 ;	---------------------------------
                            108 ; Function player_turn_left
                            109 ; ---------------------------------
   19F2                     110 _player_turn_left::
                            111 ;src/Player.c:43: (player_directionIndex)=(player_directionIndex+2)&7;
   19F2 3A 0C 87      [13]  112 	ld	a,(#_player_directionIndex + 0)
   19F5 C6 02         [ 7]  113 	add	a, #0x02
   19F7 E6 07         [ 7]  114 	and	a, #0x07
   19F9 32 0C 87      [13]  115 	ld	(#_player_directionIndex + 0),a
                            116 ;src/Player.c:44: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
   19FC 11 05 0D      [10]  117 	ld	de,#_movement_directionArray+0
   19FF 2A 0C 87      [16]  118 	ld	hl,(_player_directionIndex)
   1A02 26 00         [ 7]  119 	ld	h,#0x00
   1A04 19            [11]  120 	add	hl,de
   1A05 4E            [ 7]  121 	ld	c,(hl)
   1A06 21 F0 19      [10]  122 	ld	hl,#_player_direction
   1A09 71            [ 7]  123 	ld	(hl),c
                            124 ;src/Player.c:45: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
   1A0A 01 F1 19      [10]  125 	ld	bc,#_player_direction+1
   1A0D FD 21 0C 87   [14]  126 	ld	iy,#_player_directionIndex
   1A11 FD 6E 00      [19]  127 	ld	l,0 (iy)
   1A14 2C            [ 4]  128 	inc	l
   1A15 26 00         [ 7]  129 	ld	h,#0x00
   1A17 19            [11]  130 	add	hl,de
   1A18 7E            [ 7]  131 	ld	a,(hl)
   1A19 02            [ 7]  132 	ld	(bc),a
   1A1A C9            [10]  133 	ret
                            134 ;src/Player.c:48: void player_turn_right(){
                            135 ;	---------------------------------
                            136 ; Function player_turn_right
                            137 ; ---------------------------------
   1A1B                     138 _player_turn_right::
                            139 ;src/Player.c:50: (player_directionIndex)=(player_directionIndex-2)&7;
   1A1B 3A 0C 87      [13]  140 	ld	a,(#_player_directionIndex + 0)
   1A1E C6 FE         [ 7]  141 	add	a,#0xFE
   1A20 E6 07         [ 7]  142 	and	a, #0x07
   1A22 32 0C 87      [13]  143 	ld	(#_player_directionIndex + 0),a
                            144 ;src/Player.c:51: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
   1A25 11 05 0D      [10]  145 	ld	de,#_movement_directionArray+0
   1A28 2A 0C 87      [16]  146 	ld	hl,(_player_directionIndex)
   1A2B 26 00         [ 7]  147 	ld	h,#0x00
   1A2D 19            [11]  148 	add	hl,de
   1A2E 4E            [ 7]  149 	ld	c,(hl)
   1A2F 21 F0 19      [10]  150 	ld	hl,#_player_direction
   1A32 71            [ 7]  151 	ld	(hl),c
                            152 ;src/Player.c:52: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
   1A33 01 F1 19      [10]  153 	ld	bc,#_player_direction+1
   1A36 FD 21 0C 87   [14]  154 	ld	iy,#_player_directionIndex
   1A3A FD 6E 00      [19]  155 	ld	l,0 (iy)
   1A3D 2C            [ 4]  156 	inc	l
   1A3E 26 00         [ 7]  157 	ld	h,#0x00
   1A40 19            [11]  158 	add	hl,de
   1A41 7E            [ 7]  159 	ld	a,(hl)
   1A42 02            [ 7]  160 	ld	(bc),a
   1A43 C9            [10]  161 	ret
                            162 ;src/Player.c:55: void player_move_forward(){
                            163 ;	---------------------------------
                            164 ; Function player_move_forward
                            165 ; ---------------------------------
   1A44                     166 _player_move_forward::
                            167 ;src/Player.c:56: *(i8*)&(player_position.x) = player_position.x + player_direction.x;
   1A44 21 EE 19      [10]  168 	ld	hl,#_player_position+0
   1A47 4D            [ 4]  169 	ld	c, l
   1A48 44            [ 4]  170 	ld	b, h
   1A49 56            [ 7]  171 	ld	d,(hl)
   1A4A 21 F0 19      [10]  172 	ld	hl,#_player_direction+0
   1A4D 5E            [ 7]  173 	ld	e,(hl)
   1A4E 7A            [ 4]  174 	ld	a,d
   1A4F 83            [ 4]  175 	add	a, e
   1A50 02            [ 7]  176 	ld	(bc),a
                            177 ;src/Player.c:57: *(i8*)&(player_position.y) = player_position.y + player_direction.y;
   1A51 21 EF 19      [10]  178 	ld	hl,#_player_position+1
   1A54 4D            [ 4]  179 	ld	c, l
   1A55 44            [ 4]  180 	ld	b, h
   1A56 56            [ 7]  181 	ld	d,(hl)
   1A57 21 F1 19      [10]  182 	ld	hl,#_player_direction+1
   1A5A 5E            [ 7]  183 	ld	e,(hl)
   1A5B 7A            [ 4]  184 	ld	a,d
   1A5C 83            [ 4]  185 	add	a, e
   1A5D 02            [ 7]  186 	ld	(bc),a
   1A5E C9            [10]  187 	ret
                            188 ;src/Player.c:60: u8 player_get_direction_index(){
                            189 ;	---------------------------------
                            190 ; Function player_get_direction_index
                            191 ; ---------------------------------
   1A5F                     192 _player_get_direction_index::
                            193 ;src/Player.c:61: return player_directionIndex;
   1A5F FD 21 0C 87   [14]  194 	ld	iy,#_player_directionIndex
   1A63 FD 6E 00      [19]  195 	ld	l,0 (iy)
   1A66 C9            [10]  196 	ret
                            197 	.area _CODE
                            198 	.area _INITIALIZER
                            199 	.area _CABS (ABS)
