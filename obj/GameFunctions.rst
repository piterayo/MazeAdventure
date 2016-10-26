                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.5 #9498 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module GameFunctions
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _game_interrupt_handler
                             12 	.globl _level_init_palettes
                             13 	.globl _cpct_akp_stop
                             14 	.globl _cpct_akp_musicPlay
                             15 	.globl _cpct_akp_musicInit
                             16 	.globl _cpct_setPALColour
                             17 	.globl _cpct_setPalette
                             18 	.globl _cpct_fw2hw
                             19 	.globl _cpct_setVideoMode
                             20 	.globl _cpct_setInterruptHandler
                             21 	.globl _cpct_disableFirmware
                             22 	.globl _camelot_warriors_mode
                             23 	.globl _currentMusic
                             24 	.globl _syncmusic_counter
                             25 	.globl _textures_on
                             26 	.globl _music_on
                             27 	.globl _r_counter
                             28 	.globl _movement_directionArray
                             29 	.globl _set_music
                             30 	.globl _remove_music
                             31 	.globl _stop_music
                             32 	.globl _game_init
                             33 ;--------------------------------------------------------
                             34 ; special function registers
                             35 ;--------------------------------------------------------
                             36 ;--------------------------------------------------------
                             37 ; ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DATA
   86D5                      40 _r_counter::
   86D5                      41 	.ds 2
   86D7                      42 _music_on::
   86D7                      43 	.ds 1
   86D8                      44 _textures_on::
   86D8                      45 	.ds 1
   86D9                      46 _syncmusic_counter::
   86D9                      47 	.ds 1
   86DA                      48 _currentMusic::
   86DA                      49 	.ds 2
   86DC                      50 _camelot_warriors_mode::
   86DC                      51 	.ds 1
                             52 ;--------------------------------------------------------
                             53 ; ram data
                             54 ;--------------------------------------------------------
                             55 	.area _INITIALIZED
                             56 ;--------------------------------------------------------
                             57 ; absolute external ram data
                             58 ;--------------------------------------------------------
                             59 	.area _DABS (ABS)
                             60 ;--------------------------------------------------------
                             61 ; global & static initialisations
                             62 ;--------------------------------------------------------
                             63 	.area _HOME
                             64 	.area _GSINIT
                             65 	.area _GSFINAL
                             66 	.area _GSINIT
                             67 ;--------------------------------------------------------
                             68 ; Home
                             69 ;--------------------------------------------------------
                             70 	.area _HOME
                             71 	.area _HOME
                             72 ;--------------------------------------------------------
                             73 ; code
                             74 ;--------------------------------------------------------
                             75 	.area _CODE
                             76 ;src/GameFunctions.c:19: void game_interrupt_handler(){
                             77 ;	---------------------------------
                             78 ; Function game_interrupt_handler
                             79 ; ---------------------------------
   0CB5                      80 _game_interrupt_handler::
                             81 ;src/GameFunctions.c:20: ++r_counter;
   0CB5 21 D5 86      [10]   82 	ld	hl, #_r_counter+0
   0CB8 34            [11]   83 	inc	(hl)
   0CB9 20 04         [12]   84 	jr	NZ,00126$
   0CBB 21 D6 86      [10]   85 	ld	hl, #_r_counter+1
   0CBE 34            [11]   86 	inc	(hl)
   0CBF                      87 00126$:
                             88 ;src/GameFunctions.c:21: ++syncmusic_counter;
   0CBF 21 D9 86      [10]   89 	ld	hl, #_syncmusic_counter+0
   0CC2 34            [11]   90 	inc	(hl)
                             91 ;src/GameFunctions.c:22: if(syncmusic_counter==6){
   0CC3 3A D9 86      [13]   92 	ld	a,(#_syncmusic_counter + 0)
   0CC6 D6 06         [ 7]   93 	sub	a, #0x06
   0CC8 C0            [11]   94 	ret	NZ
                             95 ;src/GameFunctions.c:23: syncmusic_counter=0;
   0CC9 21 D9 86      [10]   96 	ld	hl,#_syncmusic_counter + 0
   0CCC 36 00         [10]   97 	ld	(hl), #0x00
                             98 ;src/GameFunctions.c:24: if(currentMusic && music_on){
   0CCE 3A DB 86      [13]   99 	ld	a,(#_currentMusic + 1)
   0CD1 21 DA 86      [10]  100 	ld	hl,#_currentMusic + 0
   0CD4 B6            [ 7]  101 	or	a,(hl)
   0CD5 C8            [11]  102 	ret	Z
   0CD6 3A D7 86      [13]  103 	ld	a,(#_music_on + 0)
   0CD9 B7            [ 4]  104 	or	a, a
   0CDA C8            [11]  105 	ret	Z
                            106 ;src/GameFunctions.c:25: cpct_akp_musicPlay();
   0CDB CD E4 7A      [17]  107 	call	_cpct_akp_musicPlay
                            108 ;src/GameFunctions.c:26: if (cpct_akp_songLoopTimes > 0){
   0CDE 3A E3 7A      [13]  109 	ld	a,(#_cpct_akp_songLoopTimes + 0)
   0CE1 B7            [ 4]  110 	or	a, a
   0CE2 C8            [11]  111 	ret	Z
                            112 ;src/GameFunctions.c:27: cpct_akp_musicInit(currentMusic);
   0CE3 2A DA 86      [16]  113 	ld	hl,(_currentMusic)
   0CE6 E5            [11]  114 	push	hl
   0CE7 CD E7 81      [17]  115 	call	_cpct_akp_musicInit
   0CEA F1            [10]  116 	pop	af
   0CEB C9            [10]  117 	ret
                            118 ;src/GameFunctions.c:38: void set_music(void* m){
                            119 ;	---------------------------------
                            120 ; Function set_music
                            121 ; ---------------------------------
   0CEC                     122 _set_music::
                            123 ;src/GameFunctions.c:39: currentMusic=m;
   0CEC 21 02 00      [10]  124 	ld	hl, #2+0
   0CEF 39            [11]  125 	add	hl, sp
   0CF0 7E            [ 7]  126 	ld	a, (hl)
   0CF1 32 DA 86      [13]  127 	ld	(#_currentMusic + 0),a
   0CF4 21 03 00      [10]  128 	ld	hl, #2+1
   0CF7 39            [11]  129 	add	hl, sp
   0CF8 7E            [ 7]  130 	ld	a, (hl)
   0CF9 32 DB 86      [13]  131 	ld	(#_currentMusic + 1),a
                            132 ;src/GameFunctions.c:40: cpct_akp_musicInit(currentMusic);
   0CFC 2A DA 86      [16]  133 	ld	hl,(_currentMusic)
   0CFF E5            [11]  134 	push	hl
   0D00 CD E7 81      [17]  135 	call	_cpct_akp_musicInit
   0D03 F1            [10]  136 	pop	af
   0D04 C9            [10]  137 	ret
   0D05                     138 _movement_directionArray:
   0D05 01                  139 	.db #0x01	;  1
   0D06 00                  140 	.db #0x00	;  0
   0D07 00                  141 	.db #0x00	;  0
   0D08 FF                  142 	.db #0xFF	; -1
   0D09 FF                  143 	.db #0xFF	; -1
   0D0A 00                  144 	.db #0x00	;  0
   0D0B 00                  145 	.db #0x00	;  0
   0D0C 01                  146 	.db #0x01	;  1
                            147 ;src/GameFunctions.c:43: void remove_music(){
                            148 ;	---------------------------------
                            149 ; Function remove_music
                            150 ; ---------------------------------
   0D0D                     151 _remove_music::
                            152 ;src/GameFunctions.c:44: cpct_akp_stop();
   0D0D CD 47 82      [17]  153 	call	_cpct_akp_stop
                            154 ;src/GameFunctions.c:45: currentMusic=0;
   0D10 21 00 00      [10]  155 	ld	hl,#0x0000
   0D13 22 DA 86      [16]  156 	ld	(_currentMusic),hl
   0D16 C9            [10]  157 	ret
                            158 ;src/GameFunctions.c:48: void stop_music(){
                            159 ;	---------------------------------
                            160 ; Function stop_music
                            161 ; ---------------------------------
   0D17                     162 _stop_music::
                            163 ;src/GameFunctions.c:49: cpct_akp_stop();
   0D17 C3 47 82      [10]  164 	jp  _cpct_akp_stop
                            165 ;src/GameFunctions.c:52: void game_init(){
                            166 ;	---------------------------------
                            167 ; Function game_init
                            168 ; ---------------------------------
   0D1A                     169 _game_init::
                            170 ;src/GameFunctions.c:53: cpct_disableFirmware();
   0D1A CD 1F 85      [17]  171 	call	_cpct_disableFirmware
                            172 ;src/GameFunctions.c:54: cpct_setVideoMode(0);
   0D1D 2E 00         [ 7]  173 	ld	l,#0x00
   0D1F CD FB 84      [17]  174 	call	_cpct_setVideoMode
                            175 ;src/GameFunctions.c:56: cpct_fw2hw(g_palette,16);
   0D22 21 10 00      [10]  176 	ld	hl,#0x0010
   0D25 E5            [11]  177 	push	hl
   0D26 21 18 1C      [10]  178 	ld	hl,#_g_palette
   0D29 E5            [11]  179 	push	hl
   0D2A CD C7 83      [17]  180 	call	_cpct_fw2hw
                            181 ;src/GameFunctions.c:58: cpct_setInterruptHandler(game_interrupt_handler);
   0D2D 21 B5 0C      [10]  182 	ld	hl,#_game_interrupt_handler
   0D30 CD 30 86      [17]  183 	call	_cpct_setInterruptHandler
                            184 ;src/GameFunctions.c:59: level_init_palettes();
   0D33 CD 97 11      [17]  185 	call	_level_init_palettes
                            186 ;src/GameFunctions.c:60: cpct_setPalette(g_palette,16);
   0D36 21 10 00      [10]  187 	ld	hl,#0x0010
   0D39 E5            [11]  188 	push	hl
   0D3A 21 18 1C      [10]  189 	ld	hl,#_g_palette
   0D3D E5            [11]  190 	push	hl
   0D3E CD BF 7A      [17]  191 	call	_cpct_setPalette
                            192 ;src/GameFunctions.c:61: cpct_setBorder(g_palette[1]);
   0D41 21 19 1C      [10]  193 	ld	hl, #_g_palette + 1
   0D44 46            [ 7]  194 	ld	b,(hl)
   0D45 C5            [11]  195 	push	bc
   0D46 33            [ 6]  196 	inc	sp
   0D47 3E 10         [ 7]  197 	ld	a,#0x10
   0D49 F5            [11]  198 	push	af
   0D4A 33            [ 6]  199 	inc	sp
   0D4B CD D6 7A      [17]  200 	call	_cpct_setPALColour
                            201 ;src/GameFunctions.c:63: music_on = 1;
   0D4E 21 D7 86      [10]  202 	ld	hl,#_music_on + 0
   0D51 36 01         [10]  203 	ld	(hl), #0x01
                            204 ;src/GameFunctions.c:64: textures_on = 1;
   0D53 21 D8 86      [10]  205 	ld	hl,#_textures_on + 0
   0D56 36 01         [10]  206 	ld	(hl), #0x01
                            207 ;src/GameFunctions.c:66: syncmusic_counter=0;
   0D58 21 D9 86      [10]  208 	ld	hl,#_syncmusic_counter + 0
   0D5B 36 00         [10]  209 	ld	(hl), #0x00
                            210 ;src/GameFunctions.c:67: currentMusic = 0;
   0D5D 21 00 00      [10]  211 	ld	hl,#0x0000
   0D60 22 DA 86      [16]  212 	ld	(_currentMusic),hl
                            213 ;src/GameFunctions.c:71: camelot_warriors_mode=0;
   0D63 21 DC 86      [10]  214 	ld	hl,#_camelot_warriors_mode + 0
   0D66 36 00         [10]  215 	ld	(hl), #0x00
   0D68 C9            [10]  216 	ret
                            217 	.area _CODE
                            218 	.area _INITIALIZER
                            219 	.area _CABS (ABS)
