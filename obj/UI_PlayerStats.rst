                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module UI_PlayerStats
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _integer_to_string
                             12 	.globl _print_text
                             13 	.globl _cpct_drawSolidBox
                             14 	.globl _strings
                             15 	.globl _ui_playerstats_render_all
                             16 	.globl _ui_playerstats_render_hp
                             17 	.globl _ui_playerstats_render_attack
                             18 	.globl _ui_playerstats_render_defense
                             19 	.globl _ui_playerstats_render_potions
                             20 	.globl _ui_playerstats_render_scrolls
                             21 	.globl _ui_playerstats_render_key
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DATA
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _INITIALIZED
                             33 ;--------------------------------------------------------
                             34 ; absolute external ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DABS (ABS)
                             37 ;--------------------------------------------------------
                             38 ; global & static initialisations
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _GSINIT
                             42 	.area _GSFINAL
                             43 	.area _GSINIT
                             44 ;--------------------------------------------------------
                             45 ; Home
                             46 ;--------------------------------------------------------
                             47 	.area _HOME
                             48 	.area _HOME
                             49 ;--------------------------------------------------------
                             50 ; code
                             51 ;--------------------------------------------------------
                             52 	.area _CODE
                             53 ;src/UI_PlayerStats.c:24: void ui_playerstats_render_all(){
                             54 ;	---------------------------------
                             55 ; Function ui_playerstats_render_all
                             56 ; ---------------------------------
   4BBF                      57 _ui_playerstats_render_all::
                             58 ;src/UI_PlayerStats.c:25: print_text("STATS", UI_PLAYERSTATS_POSITION+1,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4BBF 21 01 03      [10]   59 	ld	hl,#0x0301
   4BC2 E5            [11]   60 	push	hl
   4BC3 21 A1 C0      [10]   61 	ld	hl,#0xC0A1
   4BC6 E5            [11]   62 	push	hl
   4BC7 21 EF 4B      [10]   63 	ld	hl,#___str_0
   4BCA E5            [11]   64 	push	hl
   4BCB CD C5 3D      [17]   65 	call	_print_text
   4BCE 21 06 00      [10]   66 	ld	hl,#6
   4BD1 39            [11]   67 	add	hl,sp
   4BD2 F9            [ 6]   68 	ld	sp,hl
                             69 ;src/UI_PlayerStats.c:26: ui_playerstats_render_hp();
   4BD3 CD FF 4B      [17]   70 	call	_ui_playerstats_render_hp
                             71 ;src/UI_PlayerStats.c:27: ui_playerstats_render_attack();
   4BD6 CD 60 4C      [17]   72 	call	_ui_playerstats_render_attack
                             73 ;src/UI_PlayerStats.c:28: ui_playerstats_render_defense();
   4BD9 CD 96 4C      [17]   74 	call	_ui_playerstats_render_defense
                             75 ;src/UI_PlayerStats.c:29: ui_playerstats_render_potions();
   4BDC CD CC 4C      [17]   76 	call	_ui_playerstats_render_potions
                             77 ;src/UI_PlayerStats.c:30: ui_playerstats_render_scrolls();
   4BDF CD 02 4D      [17]   78 	call	_ui_playerstats_render_scrolls
                             79 ;src/UI_PlayerStats.c:31: ui_playerstats_render_key();
   4BE2 C3 38 4D      [10]   80 	jp  _ui_playerstats_render_key
   4BE5                      81 _strings:
   4BE5 F5 4B                82 	.dw __str_1
   4BE7 F7 4B                83 	.dw __str_2
   4BE9 F9 4B                84 	.dw __str_3
   4BEB FB 4B                85 	.dw __str_4
   4BED FD 4B                86 	.dw __str_5
   4BEF                      87 ___str_0:
   4BEF 53 54 41 54 53       88 	.ascii "STATS"
   4BF4 00                   89 	.db 0x00
   4BF5                      90 __str_1:
   4BF5 2B                   91 	.ascii "+"
   4BF6 00                   92 	.db 0x00
   4BF7                      93 __str_2:
   4BF7 23                   94 	.ascii "#"
   4BF8 00                   95 	.db 0x00
   4BF9                      96 __str_3:
   4BF9 26                   97 	.ascii "&"
   4BFA 00                   98 	.db 0x00
   4BFB                      99 __str_4:
   4BFB 7E                  100 	.ascii "~"
   4BFC 00                  101 	.db 0x00
   4BFD                     102 __str_5:
   4BFD 24                  103 	.ascii "$"
   4BFE 00                  104 	.db 0x00
                            105 ;src/UI_PlayerStats.c:35: void ui_playerstats_render_hp(){
                            106 ;	---------------------------------
                            107 ; Function ui_playerstats_render_hp
                            108 ; ---------------------------------
   4BFF                     109 _ui_playerstats_render_hp::
                            110 ;src/UI_PlayerStats.c:36: u8 h = 1+((u16)player_health_points*9)/255;
   4BFF 21 67 7D      [10]  111 	ld	hl,#_player_health_points + 0
   4C02 4E            [ 7]  112 	ld	c, (hl)
   4C03 06 00         [ 7]  113 	ld	b,#0x00
   4C05 69            [ 4]  114 	ld	l, c
   4C06 60            [ 4]  115 	ld	h, b
   4C07 29            [11]  116 	add	hl, hl
   4C08 29            [11]  117 	add	hl, hl
   4C09 29            [11]  118 	add	hl, hl
   4C0A 09            [11]  119 	add	hl, bc
   4C0B 01 FF 00      [10]  120 	ld	bc,#0x00FF
   4C0E C5            [11]  121 	push	bc
   4C0F E5            [11]  122 	push	hl
   4C10 CD 94 78      [17]  123 	call	__divuint
   4C13 F1            [10]  124 	pop	af
   4C14 F1            [10]  125 	pop	af
   4C15 45            [ 4]  126 	ld	b,l
   4C16 04            [ 4]  127 	inc	b
                            128 ;src/UI_PlayerStats.c:37: print_text("HP", UI_PLAYERSTATS_POSITION+160,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4C17 C5            [11]  129 	push	bc
   4C18 21 01 03      [10]  130 	ld	hl,#0x0301
   4C1B E5            [11]  131 	push	hl
   4C1C 21 40 C1      [10]  132 	ld	hl,#0xC140
   4C1F E5            [11]  133 	push	hl
   4C20 21 5D 4C      [10]  134 	ld	hl,#___str_6
   4C23 E5            [11]  135 	push	hl
   4C24 CD C5 3D      [17]  136 	call	_print_text
   4C27 21 06 00      [10]  137 	ld	hl,#6
   4C2A 39            [11]  138 	add	hl,sp
   4C2B F9            [ 6]  139 	ld	sp,hl
   4C2C C1            [10]  140 	pop	bc
                            141 ;src/UI_PlayerStats.c:40: cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_BG_COLOR], 10,4);
   4C2D 21 6A 1A      [10]  142 	ld	hl, #_g_colors + 4
   4C30 56            [ 7]  143 	ld	d,(hl)
   4C31 C5            [11]  144 	push	bc
   4C32 21 0A 04      [10]  145 	ld	hl,#0x040A
   4C35 E5            [11]  146 	push	hl
   4C36 D5            [11]  147 	push	de
   4C37 33            [ 6]  148 	inc	sp
   4C38 21 44 C9      [10]  149 	ld	hl,#0xC944
   4C3B E5            [11]  150 	push	hl
   4C3C CD 92 7B      [17]  151 	call	_cpct_drawSolidBox
   4C3F F1            [10]  152 	pop	af
   4C40 F1            [10]  153 	pop	af
   4C41 33            [ 6]  154 	inc	sp
   4C42 C1            [10]  155 	pop	bc
                            156 ;src/UI_PlayerStats.c:41: if(!player_is_dead) cpct_drawSolidBox(UI_PLAYERSTATS_POSITION+164+2048, g_colors[UI_PLAYERSTATS_HEALTHBAR_FG_COLOR], h,4);
   4C43 3A 68 7D      [13]  157 	ld	a,(#_player_is_dead + 0)
   4C46 B7            [ 4]  158 	or	a, a
   4C47 C0            [11]  159 	ret	NZ
   4C48 21 6B 1A      [10]  160 	ld	hl, #_g_colors + 5
   4C4B 56            [ 7]  161 	ld	d,(hl)
   4C4C 3E 04         [ 7]  162 	ld	a,#0x04
   4C4E F5            [11]  163 	push	af
   4C4F 33            [ 6]  164 	inc	sp
   4C50 4A            [ 4]  165 	ld	c, d
   4C51 C5            [11]  166 	push	bc
   4C52 21 44 C9      [10]  167 	ld	hl,#0xC944
   4C55 E5            [11]  168 	push	hl
   4C56 CD 92 7B      [17]  169 	call	_cpct_drawSolidBox
   4C59 F1            [10]  170 	pop	af
   4C5A F1            [10]  171 	pop	af
   4C5B 33            [ 6]  172 	inc	sp
   4C5C C9            [10]  173 	ret
   4C5D                     174 ___str_6:
   4C5D 48 50               175 	.ascii "HP"
   4C5F 00                  176 	.db 0x00
                            177 ;src/UI_PlayerStats.c:45: void ui_playerstats_render_attack(){
                            178 ;	---------------------------------
                            179 ; Function ui_playerstats_render_attack
                            180 ; ---------------------------------
   4C60                     181 _ui_playerstats_render_attack::
                            182 ;src/UI_PlayerStats.c:46: print_text(strings[0], UI_PLAYERSTATS_POSITION+320,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4C60 ED 4B E5 4B   [20]  183 	ld	bc, (#_strings + 0)
   4C64 21 01 03      [10]  184 	ld	hl,#0x0301
   4C67 E5            [11]  185 	push	hl
   4C68 21 E0 C1      [10]  186 	ld	hl,#0xC1E0
   4C6B E5            [11]  187 	push	hl
   4C6C C5            [11]  188 	push	bc
   4C6D CD C5 3D      [17]  189 	call	_print_text
   4C70 21 06 00      [10]  190 	ld	hl,#6
   4C73 39            [11]  191 	add	hl,sp
   4C74 F9            [ 6]  192 	ld	sp,hl
                            193 ;src/UI_PlayerStats.c:47: print_text(integer_to_string(player_attack_value,'d'), UI_PLAYERSTATS_POSITION+324,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4C75 3E 64         [ 7]  194 	ld	a,#0x64
   4C77 F5            [11]  195 	push	af
   4C78 33            [ 6]  196 	inc	sp
   4C79 3A 66 7D      [13]  197 	ld	a,(_player_attack_value)
   4C7C F5            [11]  198 	push	af
   4C7D 33            [ 6]  199 	inc	sp
   4C7E CD 5E 3C      [17]  200 	call	_integer_to_string
   4C81 F1            [10]  201 	pop	af
   4C82 4D            [ 4]  202 	ld	c,l
   4C83 44            [ 4]  203 	ld	b,h
   4C84 21 01 03      [10]  204 	ld	hl,#0x0301
   4C87 E5            [11]  205 	push	hl
   4C88 21 E4 C1      [10]  206 	ld	hl,#0xC1E4
   4C8B E5            [11]  207 	push	hl
   4C8C C5            [11]  208 	push	bc
   4C8D CD C5 3D      [17]  209 	call	_print_text
   4C90 21 06 00      [10]  210 	ld	hl,#6
   4C93 39            [11]  211 	add	hl,sp
   4C94 F9            [ 6]  212 	ld	sp,hl
   4C95 C9            [10]  213 	ret
                            214 ;src/UI_PlayerStats.c:50: void ui_playerstats_render_defense(){
                            215 ;	---------------------------------
                            216 ; Function ui_playerstats_render_defense
                            217 ; ---------------------------------
   4C96                     218 _ui_playerstats_render_defense::
                            219 ;src/UI_PlayerStats.c:51: print_text(strings[1], UI_PLAYERSTATS_POSITION+400,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4C96 ED 4B E7 4B   [20]  220 	ld	bc, (#(_strings + 0x0002) + 0)
   4C9A 21 01 03      [10]  221 	ld	hl,#0x0301
   4C9D E5            [11]  222 	push	hl
   4C9E 21 30 C2      [10]  223 	ld	hl,#0xC230
   4CA1 E5            [11]  224 	push	hl
   4CA2 C5            [11]  225 	push	bc
   4CA3 CD C5 3D      [17]  226 	call	_print_text
   4CA6 21 06 00      [10]  227 	ld	hl,#6
   4CA9 39            [11]  228 	add	hl,sp
   4CAA F9            [ 6]  229 	ld	sp,hl
                            230 ;src/UI_PlayerStats.c:52: print_text(integer_to_string(player_defense_value,'d'), UI_PLAYERSTATS_POSITION+404,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4CAB 3E 64         [ 7]  231 	ld	a,#0x64
   4CAD F5            [11]  232 	push	af
   4CAE 33            [ 6]  233 	inc	sp
   4CAF 3A 65 7D      [13]  234 	ld	a,(_player_defense_value)
   4CB2 F5            [11]  235 	push	af
   4CB3 33            [ 6]  236 	inc	sp
   4CB4 CD 5E 3C      [17]  237 	call	_integer_to_string
   4CB7 F1            [10]  238 	pop	af
   4CB8 4D            [ 4]  239 	ld	c,l
   4CB9 44            [ 4]  240 	ld	b,h
   4CBA 21 01 03      [10]  241 	ld	hl,#0x0301
   4CBD E5            [11]  242 	push	hl
   4CBE 21 34 C2      [10]  243 	ld	hl,#0xC234
   4CC1 E5            [11]  244 	push	hl
   4CC2 C5            [11]  245 	push	bc
   4CC3 CD C5 3D      [17]  246 	call	_print_text
   4CC6 21 06 00      [10]  247 	ld	hl,#6
   4CC9 39            [11]  248 	add	hl,sp
   4CCA F9            [ 6]  249 	ld	sp,hl
   4CCB C9            [10]  250 	ret
                            251 ;src/UI_PlayerStats.c:55: void ui_playerstats_render_potions(){
                            252 ;	---------------------------------
                            253 ; Function ui_playerstats_render_potions
                            254 ; ---------------------------------
   4CCC                     255 _ui_playerstats_render_potions::
                            256 ;src/UI_PlayerStats.c:56: print_text(strings[2], UI_PLAYERSTATS_POSITION+480,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4CCC ED 4B E9 4B   [20]  257 	ld	bc, (#(_strings + 0x0004) + 0)
   4CD0 21 01 03      [10]  258 	ld	hl,#0x0301
   4CD3 E5            [11]  259 	push	hl
   4CD4 21 80 C2      [10]  260 	ld	hl,#0xC280
   4CD7 E5            [11]  261 	push	hl
   4CD8 C5            [11]  262 	push	bc
   4CD9 CD C5 3D      [17]  263 	call	_print_text
   4CDC 21 06 00      [10]  264 	ld	hl,#6
   4CDF 39            [11]  265 	add	hl,sp
   4CE0 F9            [ 6]  266 	ld	sp,hl
                            267 ;src/UI_PlayerStats.c:57: print_text(integer_to_string(player_potion_count,'d'), UI_PLAYERSTATS_POSITION+484,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4CE1 3E 64         [ 7]  268 	ld	a,#0x64
   4CE3 F5            [11]  269 	push	af
   4CE4 33            [ 6]  270 	inc	sp
   4CE5 3A 6A 7D      [13]  271 	ld	a,(_player_potion_count)
   4CE8 F5            [11]  272 	push	af
   4CE9 33            [ 6]  273 	inc	sp
   4CEA CD 5E 3C      [17]  274 	call	_integer_to_string
   4CED F1            [10]  275 	pop	af
   4CEE 4D            [ 4]  276 	ld	c,l
   4CEF 44            [ 4]  277 	ld	b,h
   4CF0 21 01 03      [10]  278 	ld	hl,#0x0301
   4CF3 E5            [11]  279 	push	hl
   4CF4 21 84 C2      [10]  280 	ld	hl,#0xC284
   4CF7 E5            [11]  281 	push	hl
   4CF8 C5            [11]  282 	push	bc
   4CF9 CD C5 3D      [17]  283 	call	_print_text
   4CFC 21 06 00      [10]  284 	ld	hl,#6
   4CFF 39            [11]  285 	add	hl,sp
   4D00 F9            [ 6]  286 	ld	sp,hl
   4D01 C9            [10]  287 	ret
                            288 ;src/UI_PlayerStats.c:60: void ui_playerstats_render_scrolls(){
                            289 ;	---------------------------------
                            290 ; Function ui_playerstats_render_scrolls
                            291 ; ---------------------------------
   4D02                     292 _ui_playerstats_render_scrolls::
                            293 ;src/UI_PlayerStats.c:61: print_text(strings[3], UI_PLAYERSTATS_POSITION+560,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D02 ED 4B EB 4B   [20]  294 	ld	bc, (#(_strings + 0x0006) + 0)
   4D06 21 01 03      [10]  295 	ld	hl,#0x0301
   4D09 E5            [11]  296 	push	hl
   4D0A 21 D0 C2      [10]  297 	ld	hl,#0xC2D0
   4D0D E5            [11]  298 	push	hl
   4D0E C5            [11]  299 	push	bc
   4D0F CD C5 3D      [17]  300 	call	_print_text
   4D12 21 06 00      [10]  301 	ld	hl,#6
   4D15 39            [11]  302 	add	hl,sp
   4D16 F9            [ 6]  303 	ld	sp,hl
                            304 ;src/UI_PlayerStats.c:62: print_text(integer_to_string(player_scroll_count,'d'), UI_PLAYERSTATS_POSITION+564, UI_PLAYERSTATS_BG_TEXT_COLOR,UI_PLAYERSTATS_TEXT_COLOR);
   4D17 3E 64         [ 7]  305 	ld	a,#0x64
   4D19 F5            [11]  306 	push	af
   4D1A 33            [ 6]  307 	inc	sp
   4D1B 3A 6B 7D      [13]  308 	ld	a,(_player_scroll_count)
   4D1E F5            [11]  309 	push	af
   4D1F 33            [ 6]  310 	inc	sp
   4D20 CD 5E 3C      [17]  311 	call	_integer_to_string
   4D23 F1            [10]  312 	pop	af
   4D24 4D            [ 4]  313 	ld	c,l
   4D25 44            [ 4]  314 	ld	b,h
   4D26 21 01 03      [10]  315 	ld	hl,#0x0301
   4D29 E5            [11]  316 	push	hl
   4D2A 21 D4 C2      [10]  317 	ld	hl,#0xC2D4
   4D2D E5            [11]  318 	push	hl
   4D2E C5            [11]  319 	push	bc
   4D2F CD C5 3D      [17]  320 	call	_print_text
   4D32 21 06 00      [10]  321 	ld	hl,#6
   4D35 39            [11]  322 	add	hl,sp
   4D36 F9            [ 6]  323 	ld	sp,hl
   4D37 C9            [10]  324 	ret
                            325 ;src/UI_PlayerStats.c:65: void ui_playerstats_render_key(){
                            326 ;	---------------------------------
                            327 ; Function ui_playerstats_render_key
                            328 ; ---------------------------------
   4D38                     329 _ui_playerstats_render_key::
                            330 ;src/UI_PlayerStats.c:66: print_text(strings[4], UI_PLAYERSTATS_POSITION+640,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D38 ED 4B ED 4B   [20]  331 	ld	bc, (#(_strings + 0x0008) + 0)
   4D3C 21 01 03      [10]  332 	ld	hl,#0x0301
   4D3F E5            [11]  333 	push	hl
   4D40 21 20 C3      [10]  334 	ld	hl,#0xC320
   4D43 E5            [11]  335 	push	hl
   4D44 C5            [11]  336 	push	bc
   4D45 CD C5 3D      [17]  337 	call	_print_text
   4D48 21 06 00      [10]  338 	ld	hl,#6
   4D4B 39            [11]  339 	add	hl,sp
   4D4C F9            [ 6]  340 	ld	sp,hl
                            341 ;src/UI_PlayerStats.c:67: if(player_has_key){
   4D4D 3A 69 7D      [13]  342 	ld	a,(#_player_has_key + 0)
   4D50 B7            [ 4]  343 	or	a, a
   4D51 28 15         [12]  344 	jr	Z,00102$
                            345 ;src/UI_PlayerStats.c:68: print_text("YES", UI_PLAYERSTATS_POSITION+644,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D53 21 01 03      [10]  346 	ld	hl,#0x0301
   4D56 E5            [11]  347 	push	hl
   4D57 21 24 C3      [10]  348 	ld	hl,#0xC324
   4D5A E5            [11]  349 	push	hl
   4D5B 21 7D 4D      [10]  350 	ld	hl,#___str_7
   4D5E E5            [11]  351 	push	hl
   4D5F CD C5 3D      [17]  352 	call	_print_text
   4D62 21 06 00      [10]  353 	ld	hl,#6
   4D65 39            [11]  354 	add	hl,sp
   4D66 F9            [ 6]  355 	ld	sp,hl
   4D67 C9            [10]  356 	ret
   4D68                     357 00102$:
                            358 ;src/UI_PlayerStats.c:71: print_text("NO", UI_PLAYERSTATS_POSITION+646,UI_PLAYERSTATS_BG_TEXT_COLOR, UI_PLAYERSTATS_TEXT_COLOR);
   4D68 21 01 03      [10]  359 	ld	hl,#0x0301
   4D6B E5            [11]  360 	push	hl
   4D6C 21 26 C3      [10]  361 	ld	hl,#0xC326
   4D6F E5            [11]  362 	push	hl
   4D70 21 81 4D      [10]  363 	ld	hl,#___str_8
   4D73 E5            [11]  364 	push	hl
   4D74 CD C5 3D      [17]  365 	call	_print_text
   4D77 21 06 00      [10]  366 	ld	hl,#6
   4D7A 39            [11]  367 	add	hl,sp
   4D7B F9            [ 6]  368 	ld	sp,hl
   4D7C C9            [10]  369 	ret
   4D7D                     370 ___str_7:
   4D7D 59 45 53            371 	.ascii "YES"
   4D80 00                  372 	.db 0x00
   4D81                     373 ___str_8:
   4D81 4E 4F               374 	.ascii "NO"
   4D83 00                  375 	.db 0x00
                            376 	.area _CODE
                            377 	.area _INITIALIZER
                            378 	.area _CABS (ABS)
