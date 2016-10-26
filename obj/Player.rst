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
   7D8B                      33 _player_defense_value::
   7D8B                      34 	.ds 1
   7D8C                      35 _player_attack_value::
   7D8C                      36 	.ds 1
   7D8D                      37 _player_health_points::
   7D8D                      38 	.ds 1
   7D8E                      39 _player_is_dead::
   7D8E                      40 	.ds 1
   7D8F                      41 _player_has_key::
   7D8F                      42 	.ds 1
   7D90                      43 _player_potion_count::
   7D90                      44 	.ds 1
   7D91                      45 _player_scroll_count::
   7D91                      46 	.ds 1
   7D92                      47 _player_directionIndex::
   7D92                      48 	.ds 1
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
   1851                      77 _player_init::
                             78 ;src/Player.c:31: player_attack_value = 52;
   1851 21 8C 7D      [10]   79 	ld	hl,#_player_attack_value + 0
   1854 36 34         [10]   80 	ld	(hl), #0x34
                             81 ;src/Player.c:32: player_defense_value = 8;
   1856 21 8B 7D      [10]   82 	ld	hl,#_player_defense_value + 0
   1859 36 08         [10]   83 	ld	(hl), #0x08
                             84 ;src/Player.c:33: player_is_dead=0;
   185B 21 8E 7D      [10]   85 	ld	hl,#_player_is_dead + 0
   185E 36 00         [10]   86 	ld	(hl), #0x00
                             87 ;src/Player.c:35: player_health_points = PLAYER_MAX_HP;
   1860 21 8D 7D      [10]   88 	ld	hl,#_player_health_points + 0
   1863 36 FF         [10]   89 	ld	(hl), #0xFF
                             90 ;src/Player.c:36: player_has_key=0;
   1865 21 8F 7D      [10]   91 	ld	hl,#_player_has_key + 0
   1868 36 00         [10]   92 	ld	(hl), #0x00
                             93 ;src/Player.c:37: player_potion_count=0;
   186A 21 90 7D      [10]   94 	ld	hl,#_player_potion_count + 0
   186D 36 00         [10]   95 	ld	(hl), #0x00
                             96 ;src/Player.c:38: player_scroll_count=0;
   186F 21 91 7D      [10]   97 	ld	hl,#_player_scroll_count + 0
   1872 36 00         [10]   98 	ld	(hl), #0x00
   1874 C9            [10]   99 	ret
   1875                     100 _player_position:
   1875 01                  101 	.db #0x01	; 1
   1876 01                  102 	.db #0x01	; 1
   1877                     103 _player_direction:
   1877 01                  104 	.db #0x01	;  1
   1878 00                  105 	.db #0x00	;  0
                            106 ;src/Player.c:42: void player_turn_left(){
                            107 ;	---------------------------------
                            108 ; Function player_turn_left
                            109 ; ---------------------------------
   1879                     110 _player_turn_left::
                            111 ;src/Player.c:43: (player_directionIndex)=(player_directionIndex+2)&7;
   1879 3A 92 7D      [13]  112 	ld	a,(#_player_directionIndex + 0)
   187C C6 02         [ 7]  113 	add	a, #0x02
   187E E6 07         [ 7]  114 	and	a, #0x07
   1880 32 92 7D      [13]  115 	ld	(#_player_directionIndex + 0),a
                            116 ;src/Player.c:44: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
   1883 11 F8 0B      [10]  117 	ld	de,#_movement_directionArray+0
   1886 2A 92 7D      [16]  118 	ld	hl,(_player_directionIndex)
   1889 26 00         [ 7]  119 	ld	h,#0x00
   188B 19            [11]  120 	add	hl,de
   188C 4E            [ 7]  121 	ld	c,(hl)
   188D 21 77 18      [10]  122 	ld	hl,#_player_direction
   1890 71            [ 7]  123 	ld	(hl),c
                            124 ;src/Player.c:45: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
   1891 01 78 18      [10]  125 	ld	bc,#_player_direction+1
   1894 FD 21 92 7D   [14]  126 	ld	iy,#_player_directionIndex
   1898 FD 6E 00      [19]  127 	ld	l,0 (iy)
   189B 2C            [ 4]  128 	inc	l
   189C 26 00         [ 7]  129 	ld	h,#0x00
   189E 19            [11]  130 	add	hl,de
   189F 7E            [ 7]  131 	ld	a,(hl)
   18A0 02            [ 7]  132 	ld	(bc),a
   18A1 C9            [10]  133 	ret
                            134 ;src/Player.c:48: void player_turn_right(){
                            135 ;	---------------------------------
                            136 ; Function player_turn_right
                            137 ; ---------------------------------
   18A2                     138 _player_turn_right::
                            139 ;src/Player.c:50: (player_directionIndex)=(player_directionIndex-2)&7;
   18A2 3A 92 7D      [13]  140 	ld	a,(#_player_directionIndex + 0)
   18A5 C6 FE         [ 7]  141 	add	a,#0xFE
   18A7 E6 07         [ 7]  142 	and	a, #0x07
   18A9 32 92 7D      [13]  143 	ld	(#_player_directionIndex + 0),a
                            144 ;src/Player.c:51: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
   18AC 11 F8 0B      [10]  145 	ld	de,#_movement_directionArray+0
   18AF 2A 92 7D      [16]  146 	ld	hl,(_player_directionIndex)
   18B2 26 00         [ 7]  147 	ld	h,#0x00
   18B4 19            [11]  148 	add	hl,de
   18B5 4E            [ 7]  149 	ld	c,(hl)
   18B6 21 77 18      [10]  150 	ld	hl,#_player_direction
   18B9 71            [ 7]  151 	ld	(hl),c
                            152 ;src/Player.c:52: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
   18BA 01 78 18      [10]  153 	ld	bc,#_player_direction+1
   18BD FD 21 92 7D   [14]  154 	ld	iy,#_player_directionIndex
   18C1 FD 6E 00      [19]  155 	ld	l,0 (iy)
   18C4 2C            [ 4]  156 	inc	l
   18C5 26 00         [ 7]  157 	ld	h,#0x00
   18C7 19            [11]  158 	add	hl,de
   18C8 7E            [ 7]  159 	ld	a,(hl)
   18C9 02            [ 7]  160 	ld	(bc),a
   18CA C9            [10]  161 	ret
                            162 ;src/Player.c:55: void player_move_forward(){
                            163 ;	---------------------------------
                            164 ; Function player_move_forward
                            165 ; ---------------------------------
   18CB                     166 _player_move_forward::
                            167 ;src/Player.c:56: *(i8*)&(player_position.x) = player_position.x + player_direction.x;
   18CB 21 75 18      [10]  168 	ld	hl,#_player_position+0
   18CE 4D            [ 4]  169 	ld	c, l
   18CF 44            [ 4]  170 	ld	b, h
   18D0 56            [ 7]  171 	ld	d,(hl)
   18D1 21 77 18      [10]  172 	ld	hl,#_player_direction+0
   18D4 5E            [ 7]  173 	ld	e,(hl)
   18D5 7A            [ 4]  174 	ld	a,d
   18D6 83            [ 4]  175 	add	a, e
   18D7 02            [ 7]  176 	ld	(bc),a
                            177 ;src/Player.c:57: *(i8*)&(player_position.y) = player_position.y + player_direction.y;
   18D8 21 76 18      [10]  178 	ld	hl,#_player_position+1
   18DB 4D            [ 4]  179 	ld	c, l
   18DC 44            [ 4]  180 	ld	b, h
   18DD 56            [ 7]  181 	ld	d,(hl)
   18DE 21 78 18      [10]  182 	ld	hl,#_player_direction+1
   18E1 5E            [ 7]  183 	ld	e,(hl)
   18E2 7A            [ 4]  184 	ld	a,d
   18E3 83            [ 4]  185 	add	a, e
   18E4 02            [ 7]  186 	ld	(bc),a
   18E5 C9            [10]  187 	ret
                            188 ;src/Player.c:60: u8 player_get_direction_index(){
                            189 ;	---------------------------------
                            190 ; Function player_get_direction_index
                            191 ; ---------------------------------
   18E6                     192 _player_get_direction_index::
                            193 ;src/Player.c:61: return player_directionIndex;
   18E6 FD 21 92 7D   [14]  194 	ld	iy,#_player_directionIndex
   18EA FD 6E 00      [19]  195 	ld	l,0 (iy)
   18ED C9            [10]  196 	ret
                            197 	.area _CODE
                            198 	.area _INITIALIZER
                            199 	.area _CABS (ABS)
