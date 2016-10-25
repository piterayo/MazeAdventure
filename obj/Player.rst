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
   7D65                      33 _player_defense_value::
   7D65                      34 	.ds 1
   7D66                      35 _player_attack_value::
   7D66                      36 	.ds 1
   7D67                      37 _player_health_points::
   7D67                      38 	.ds 1
   7D68                      39 _player_is_dead::
   7D68                      40 	.ds 1
   7D69                      41 _player_has_key::
   7D69                      42 	.ds 1
   7D6A                      43 _player_potion_count::
   7D6A                      44 	.ds 1
   7D6B                      45 _player_scroll_count::
   7D6B                      46 	.ds 1
   7D6C                      47 _player_directionIndex::
   7D6C                      48 	.ds 1
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
   1808                      77 _player_init::
                             78 ;src/Player.c:31: player_attack_value = 52;
   1808 21 66 7D      [10]   79 	ld	hl,#_player_attack_value + 0
   180B 36 34         [10]   80 	ld	(hl), #0x34
                             81 ;src/Player.c:32: player_defense_value = 8;
   180D 21 65 7D      [10]   82 	ld	hl,#_player_defense_value + 0
   1810 36 08         [10]   83 	ld	(hl), #0x08
                             84 ;src/Player.c:33: player_is_dead=0;
   1812 21 68 7D      [10]   85 	ld	hl,#_player_is_dead + 0
   1815 36 00         [10]   86 	ld	(hl), #0x00
                             87 ;src/Player.c:35: player_health_points = PLAYER_MAX_HP;
   1817 21 67 7D      [10]   88 	ld	hl,#_player_health_points + 0
   181A 36 FF         [10]   89 	ld	(hl), #0xFF
                             90 ;src/Player.c:36: player_has_key=0;
   181C 21 69 7D      [10]   91 	ld	hl,#_player_has_key + 0
   181F 36 00         [10]   92 	ld	(hl), #0x00
                             93 ;src/Player.c:37: player_potion_count=0;
   1821 21 6A 7D      [10]   94 	ld	hl,#_player_potion_count + 0
   1824 36 00         [10]   95 	ld	(hl), #0x00
                             96 ;src/Player.c:38: player_scroll_count=0;
   1826 21 6B 7D      [10]   97 	ld	hl,#_player_scroll_count + 0
   1829 36 00         [10]   98 	ld	(hl), #0x00
   182B C9            [10]   99 	ret
   182C                     100 _player_position:
   182C 01                  101 	.db #0x01	; 1
   182D 01                  102 	.db #0x01	; 1
   182E                     103 _player_direction:
   182E 01                  104 	.db #0x01	;  1
   182F 00                  105 	.db #0x00	;  0
                            106 ;src/Player.c:42: void player_turn_left(){
                            107 ;	---------------------------------
                            108 ; Function player_turn_left
                            109 ; ---------------------------------
   1830                     110 _player_turn_left::
                            111 ;src/Player.c:43: (player_directionIndex)=(player_directionIndex+2)&7;
   1830 3A 6C 7D      [13]  112 	ld	a,(#_player_directionIndex + 0)
   1833 C6 02         [ 7]  113 	add	a, #0x02
   1835 E6 07         [ 7]  114 	and	a, #0x07
   1837 32 6C 7D      [13]  115 	ld	(#_player_directionIndex + 0),a
                            116 ;src/Player.c:44: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
   183A 11 F8 0B      [10]  117 	ld	de,#_movement_directionArray+0
   183D 2A 6C 7D      [16]  118 	ld	hl,(_player_directionIndex)
   1840 26 00         [ 7]  119 	ld	h,#0x00
   1842 19            [11]  120 	add	hl,de
   1843 4E            [ 7]  121 	ld	c,(hl)
   1844 21 2E 18      [10]  122 	ld	hl,#_player_direction
   1847 71            [ 7]  123 	ld	(hl),c
                            124 ;src/Player.c:45: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
   1848 01 2F 18      [10]  125 	ld	bc,#_player_direction+1
   184B FD 21 6C 7D   [14]  126 	ld	iy,#_player_directionIndex
   184F FD 6E 00      [19]  127 	ld	l,0 (iy)
   1852 2C            [ 4]  128 	inc	l
   1853 26 00         [ 7]  129 	ld	h,#0x00
   1855 19            [11]  130 	add	hl,de
   1856 7E            [ 7]  131 	ld	a,(hl)
   1857 02            [ 7]  132 	ld	(bc),a
   1858 C9            [10]  133 	ret
                            134 ;src/Player.c:48: void player_turn_right(){
                            135 ;	---------------------------------
                            136 ; Function player_turn_right
                            137 ; ---------------------------------
   1859                     138 _player_turn_right::
                            139 ;src/Player.c:50: (player_directionIndex)=(player_directionIndex-2)&7;
   1859 3A 6C 7D      [13]  140 	ld	a,(#_player_directionIndex + 0)
   185C C6 FE         [ 7]  141 	add	a,#0xFE
   185E E6 07         [ 7]  142 	and	a, #0x07
   1860 32 6C 7D      [13]  143 	ld	(#_player_directionIndex + 0),a
                            144 ;src/Player.c:51: *(i8*)&(player_direction.x) = movement_directionArray[(player_directionIndex)];
   1863 11 F8 0B      [10]  145 	ld	de,#_movement_directionArray+0
   1866 2A 6C 7D      [16]  146 	ld	hl,(_player_directionIndex)
   1869 26 00         [ 7]  147 	ld	h,#0x00
   186B 19            [11]  148 	add	hl,de
   186C 4E            [ 7]  149 	ld	c,(hl)
   186D 21 2E 18      [10]  150 	ld	hl,#_player_direction
   1870 71            [ 7]  151 	ld	(hl),c
                            152 ;src/Player.c:52: *(i8*)&(player_direction.y) = movement_directionArray[((player_directionIndex)+1)];
   1871 01 2F 18      [10]  153 	ld	bc,#_player_direction+1
   1874 FD 21 6C 7D   [14]  154 	ld	iy,#_player_directionIndex
   1878 FD 6E 00      [19]  155 	ld	l,0 (iy)
   187B 2C            [ 4]  156 	inc	l
   187C 26 00         [ 7]  157 	ld	h,#0x00
   187E 19            [11]  158 	add	hl,de
   187F 7E            [ 7]  159 	ld	a,(hl)
   1880 02            [ 7]  160 	ld	(bc),a
   1881 C9            [10]  161 	ret
                            162 ;src/Player.c:55: void player_move_forward(){
                            163 ;	---------------------------------
                            164 ; Function player_move_forward
                            165 ; ---------------------------------
   1882                     166 _player_move_forward::
                            167 ;src/Player.c:56: *(i8*)&(player_position.x) = player_position.x + player_direction.x;
   1882 21 2C 18      [10]  168 	ld	hl,#_player_position+0
   1885 4D            [ 4]  169 	ld	c, l
   1886 44            [ 4]  170 	ld	b, h
   1887 56            [ 7]  171 	ld	d,(hl)
   1888 21 2E 18      [10]  172 	ld	hl,#_player_direction+0
   188B 5E            [ 7]  173 	ld	e,(hl)
   188C 7A            [ 4]  174 	ld	a,d
   188D 83            [ 4]  175 	add	a, e
   188E 02            [ 7]  176 	ld	(bc),a
                            177 ;src/Player.c:57: *(i8*)&(player_position.y) = player_position.y + player_direction.y;
   188F 21 2D 18      [10]  178 	ld	hl,#_player_position+1
   1892 4D            [ 4]  179 	ld	c, l
   1893 44            [ 4]  180 	ld	b, h
   1894 56            [ 7]  181 	ld	d,(hl)
   1895 21 2F 18      [10]  182 	ld	hl,#_player_direction+1
   1898 5E            [ 7]  183 	ld	e,(hl)
   1899 7A            [ 4]  184 	ld	a,d
   189A 83            [ 4]  185 	add	a, e
   189B 02            [ 7]  186 	ld	(bc),a
   189C C9            [10]  187 	ret
                            188 ;src/Player.c:60: u8 player_get_direction_index(){
                            189 ;	---------------------------------
                            190 ; Function player_get_direction_index
                            191 ; ---------------------------------
   189D                     192 _player_get_direction_index::
                            193 ;src/Player.c:61: return player_directionIndex;
   189D FD 21 6C 7D   [14]  194 	ld	iy,#_player_directionIndex
   18A1 FD 6E 00      [19]  195 	ld	l,0 (iy)
   18A4 C9            [10]  196 	ret
                            197 	.area _CODE
                            198 	.area _INITIALIZER
                            199 	.area _CABS (ABS)
