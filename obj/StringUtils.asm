;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9498 (Linux)
;--------------------------------------------------------
	.module StringUtils
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _i_to_s_buffer
	.globl _charArray
	.globl _integer_to_string
	.globl _print_text
	.globl _print_transparent_text
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/StringUtils.c:25: void* integer_to_string(u8 n, u8 format){
;	---------------------------------
; Function integer_to_string
; ---------------------------------
_integer_to_string::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/StringUtils.c:26: u8* charPosition=(u8*)&i_to_s_buffer;
	ld	bc,#_i_to_s_buffer+0
;src/StringUtils.c:28: switch(format){
	ld	a,5 (ix)
	sub	a, #0x62
	jr	Z,00102$
	ld	a,5 (ix)
	sub	a, #0x68
	jr	NZ,00106$
;src/StringUtils.c:30: charPosition+=2;
	ld	de,#_i_to_s_buffer + 2
;src/StringUtils.c:32: *charPosition = 0;
	xor	a, a
	ld	(de),a
;src/StringUtils.c:34: --charPosition;
	dec	de
;src/StringUtils.c:36: t=n%16;
	ld	a,4 (ix)
	and	a, #0x0F
	ld	l,a
;src/StringUtils.c:37: t=t>9?t+64:t+48;
	ld	a,#0x09
	sub	a, l
	jr	NC,00110$
	ld	a,l
	add	a, #0x40
	jr	00111$
00110$:
	ld	a,l
	add	a, #0x30
00111$:
;src/StringUtils.c:38: *charPosition=t;
	ld	(de),a
;src/StringUtils.c:39: n/=16;
	ld	a,4 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	ld	4 (ix),a
;src/StringUtils.c:40: --charPosition;
	dec	de
;src/StringUtils.c:42: t=n%16;
	ld	a,4 (ix)
	and	a, #0x0F
	ld	l,a
;src/StringUtils.c:43: t=t>9?t+64:t+48;
	ld	a,#0x09
	sub	a, l
	jr	NC,00112$
	ld	a,l
	add	a, #0x40
	jr	00113$
00112$:
	ld	a,l
	add	a, #0x30
00113$:
;src/StringUtils.c:44: *charPosition=t;
	ld	(de),a
;src/StringUtils.c:45: break;
	jp	00107$
;src/StringUtils.c:47: case 'b':{
00102$:
;src/StringUtils.c:49: charPosition+=8;
	ld	hl,#_i_to_s_buffer + 8
;src/StringUtils.c:51: while(t){
	ld	e,#0x08
00103$:
	ld	a,e
	or	a, a
	jr	Z,00107$
;src/StringUtils.c:52: --t;
	dec	e
;src/StringUtils.c:53: --charPosition;
	dec	hl
;src/StringUtils.c:54: *charPosition=(n&1)+48;
	ld	a,4 (ix)
	and	a, #0x01
	add	a, #0x30
	ld	(hl),a
;src/StringUtils.c:55: n>>=1;
	srl	4 (ix)
	jr	00103$
;src/StringUtils.c:59: default:{
00106$:
;src/StringUtils.c:60: charPosition+=3;
	ld	de,#_i_to_s_buffer + 3
;src/StringUtils.c:62: *charPosition = 0;
	xor	a, a
	ld	(de),a
;src/StringUtils.c:64: --charPosition;
	dec	de
;src/StringUtils.c:66: *charPosition=48+(n%10);
	push	bc
	push	de
	ld	a,#0x0A
	push	af
	inc	sp
	ld	a,4 (ix)
	push	af
	inc	sp
	call	__moduchar
	pop	af
	pop	de
	pop	bc
	ld	a,l
	add	a, #0x30
	ld	(de),a
;src/StringUtils.c:67: --charPosition;
;src/StringUtils.c:68: n/=10;
	push	bc
	ld	a,#0x0A
	push	af
	inc	sp
	ld	a,4 (ix)
	push	af
	inc	sp
	call	__divuchar
	pop	af
	pop	bc
	ld	4 (ix),l
;src/StringUtils.c:69: *charPosition=48+(n%10);
	push	bc
	ld	a,#0x0A
	push	af
	inc	sp
	ld	a,4 (ix)
	push	af
	inc	sp
	call	__moduchar
	pop	af
	pop	bc
	ld	a,l
	add	a, #0x30
	ld	(#(_i_to_s_buffer + 0x0001)),a
;src/StringUtils.c:70: --charPosition;
;src/StringUtils.c:71: n/=10;
	push	bc
	ld	a,#0x0A
	push	af
	inc	sp
	ld	a,4 (ix)
	push	af
	inc	sp
	call	__divuchar
	pop	af
	pop	bc
	ld	4 (ix),l
;src/StringUtils.c:72: *charPosition=48+(n%10);
	push	bc
	ld	a,#0x0A
	push	af
	inc	sp
	ld	a,4 (ix)
	push	af
	inc	sp
	call	__moduchar
	pop	af
	pop	bc
	ld	a,l
	add	a, #0x30
	ld	(#_i_to_s_buffer),a
;src/StringUtils.c:75: }
00107$:
;src/StringUtils.c:77: return i_to_s_buffer;
	ld	l, c
	ld	h, b
	pop	ix
	ret
_charArray:
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x29	; 41
	.db #0x24	; 36
	.db #0xFF	; 255
	.db #0x2D	; 45
	.db #0x2F	; 47
	.db #0xFF	; 255
	.db #0x2E	; 46
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x31	; 49	'1'
	.db #0x2C	; 44
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x26	; 38
	.db #0xFF	; 255
	.db #0x1A	; 26
	.db #0x1B	; 27
	.db #0x1C	; 28
	.db #0x1D	; 29
	.db #0x1E	; 30
	.db #0x1F	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x27	; 39
	.db #0xFF	; 255
	.db #0x2A	; 42
	.db #0xFF	; 255
	.db #0x2B	; 43
	.db #0x25	; 37
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0A	; 10
	.db #0x0B	; 11
	.db #0x0C	; 12
	.db #0x0D	; 13
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0A	; 10
	.db #0x0B	; 11
	.db #0x0C	; 12
	.db #0x0D	; 13
	.db #0x0E	; 14
	.db #0x0F	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0xFF	; 255
	.db #0x30	; 48	'0'
	.db #0xFF	; 255
_i_to_s_buffer:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
;src/StringUtils.c:81: void print_text(void * const text, u8* position, u8 bg, u8 fg){
;	---------------------------------
; Function print_text
; ---------------------------------
_print_text::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-15
	add	hl,sp
	ld	sp,hl
;src/StringUtils.c:82: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
	ld	a,9 (ix)
	add	a, #<(_g_colors)
	ld	-2 (ix),a
	ld	a,#0x00
	adc	a, #>(_g_colors)
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-12 (ix),a
	ld	a,#<(_g_colors)
	add	a, 8 (ix)
	ld	-2 (ix),a
	ld	a,#>(_g_colors)
	adc	a, #0x00
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	ld	-14 (ix),a
;src/StringUtils.c:88: position+=10240;
	ld	a,6 (ix)
	add	a, #0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a, #0x28
	ld	7 (ix),a
;src/StringUtils.c:90: while(height){
	ld	-15 (ix),#0x06
	ld	a,6 (ix)
	ld	-2 (ix),a
	ld	a,7 (ix)
	ld	-1 (ix),a
	ld	-5 (ix),#0x96
00106$:
	ld	a,-15 (ix)
	or	a, a
	jp	Z,00109$
;src/StringUtils.c:91: --height;
	ld	a,-5 (ix)
	add	a,#0xE7
	ld	-5 (ix),a
	dec	-15 (ix)
;src/StringUtils.c:92: currentChar=text;
	ld	a,4 (ix)
	ld	-7 (ix),a
	ld	a,5 (ix)
	ld	-6 (ix),a
;src/StringUtils.c:93: currentPos=position;
	ld	a,-2 (ix)
	ld	-4 (ix),a
	ld	a,-1 (ix)
	ld	-3 (ix),a
;src/StringUtils.c:95: while(*currentChar){
00103$:
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	-10 (ix), a
	or	a, a
	jp	Z,00105$
;src/StringUtils.c:97: spritePos = charArray[(*currentChar)];
	ld	a,#<(_charArray)
	add	a, -10 (ix)
	ld	-9 (ix),a
	ld	a,#>(_charArray)
	adc	a, #0x00
	ld	-8 (ix),a
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
;src/StringUtils.c:99: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
	ld	-13 (ix), a
	srl	a
	ld	-9 (ix), a
	add	a, -5 (ix)
	ld	-9 (ix),a
	add	a,#<(_typography_4x6_monospaced)
	ld	-9 (ix),a
	ld	a,#>(_typography_4x6_monospaced)
	adc	a, #0x00
	ld	-8 (ix),a
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	ld	-9 (ix),a
;src/StringUtils.c:101: if(spritePos%2) charBitArray<<=4;
	bit	0, -13 (ix)
	jr	Z,00102$
	ld	a,-9 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	-9 (ix),a
00102$:
;src/StringUtils.c:105: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
	bit	7, -9 (ix)
	jr	Z,00111$
	ld	a,-12 (ix)
	jr	00112$
00111$:
	ld	a,-14 (ix)
00112$:
	and	a, #0xAA
	ld	c,a
;src/StringUtils.c:107: charBitArray<<=1;
	ld	a,-9 (ix)
	add	a, a
	ld	b,a
;src/StringUtils.c:109: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
	bit	7, b
	jr	Z,00113$
	ld	a,-12 (ix)
	jr	00114$
00113$:
	ld	a,-14 (ix)
00114$:
	and	a, #0x55
	or	a, c
	ld	e,a
;src/StringUtils.c:111: charBitArray<<=1;
	ld	a,b
	add	a, a
	ld	c,a
;src/StringUtils.c:113: *currentPos=val;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),e
;src/StringUtils.c:114: ++currentPos;
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	inc	de
;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
	bit	7, c
	jr	Z,00115$
	ld	a,-12 (ix)
	jr	00116$
00115$:
	ld	a,-14 (ix)
00116$:
	and	a, #0xAA
	ld	-11 (ix),a
;src/StringUtils.c:120: charBitArray<<=1;
	ld	a,c
	add	a, a
;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
	rlca
	jr	NC,00117$
	ld	a,-12 (ix)
	jr	00118$
00117$:
	ld	a,-14 (ix)
00118$:
	and	a, #0x55
	or	a, -11 (ix)
;src/StringUtils.c:126: *currentPos=val;
	ld	(de),a
;src/StringUtils.c:127: ++currentPos;
	inc	de
	ld	-4 (ix),e
	ld	-3 (ix),d
;src/StringUtils.c:129: ++currentChar;
	inc	-7 (ix)
	jp	NZ,00103$
	inc	-6 (ix)
	jp	00103$
00105$:
;src/StringUtils.c:131: position-=(2048);
	ld	a,-2 (ix)
	add	a,#0x00
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a,#0xF8
	ld	-1 (ix),a
	jp	00106$
00109$:
	ld	sp, ix
	pop	ix
	ret
;src/StringUtils.c:136: void print_transparent_text(void* const text, u8* position, u8 fg){
;	---------------------------------
; Function print_transparent_text
; ---------------------------------
_print_transparent_text::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-11
	add	hl,sp
	ld	sp,hl
;src/StringUtils.c:143: position+=10240;
	ld	a,6 (ix)
	add	a, #0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a, #0x28
	ld	7 (ix),a
;src/StringUtils.c:145: while(height){
	ld	a,8 (ix)
	add	a, #<(_g_colors)
	ld	-9 (ix),a
	ld	a,#0x00
	adc	a, #>(_g_colors)
	ld	-8 (ix),a
	ld	-11 (ix),#0x06
	ld	a,6 (ix)
	ld	-4 (ix),a
	ld	a,7 (ix)
	ld	-3 (ix),a
	ld	-5 (ix),#0x96
00114$:
	ld	a,-11 (ix)
	or	a, a
	jp	Z,00117$
;src/StringUtils.c:146: currentChar=text;
	ld	a,4 (ix)
	ld	-7 (ix),a
	ld	a,5 (ix)
	ld	-6 (ix),a
;src/StringUtils.c:147: currentPos=position;
	ld	a,-4 (ix)
	ld	-2 (ix),a
	ld	a,-3 (ix)
	ld	-1 (ix),a
;src/StringUtils.c:148: --height;
	ld	a,-5 (ix)
	add	a,#0xE7
	ld	-5 (ix),a
	dec	-11 (ix)
;src/StringUtils.c:149: while(*currentChar){
00111$:
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	c,(hl)
	ld	a,c
	or	a, a
	jp	Z,00113$
;src/StringUtils.c:151: spritePos = charArray[(*currentChar)];
	ld	hl,#_charArray
	ld	b,#0x00
	add	hl, bc
	ld	b,(hl)
;src/StringUtils.c:153: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
	ld	a, b
	srl	a
	add	a, -5 (ix)
	ld	e,a
	ld	hl,#_typography_4x6_monospaced
	ld	d,#0x00
	add	hl, de
	ld	c,(hl)
;src/StringUtils.c:155: if(spritePos%2) charBitArray<<=4;
	bit	0, b
	jr	Z,00102$
	ld	a,c
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	c,a
00102$:
;src/StringUtils.c:157: val=*currentPos;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	b,(hl)
;src/StringUtils.c:159: if(charBitArray&0b10000000) val = (g_colors[fg]&0b10101010)|(val&0b01010101);
	bit	7, c
	jr	Z,00104$
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	and	a, #0xAA
	ld	e,a
	ld	a,b
	and	a, #0x55
	or	a, e
	ld	b,a
00104$:
;src/StringUtils.c:161: charBitArray<<=1;
	sla	c
;src/StringUtils.c:163: if(charBitArray&0b10000000) val = (g_colors[fg]&0b01010101)|(val&0b10101010);
	bit	7, c
	jr	Z,00106$
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	and	a, #0x55
	ld	e,a
	ld	a,b
	and	a, #0xAA
	or	a, e
	ld	b,a
00106$:
;src/StringUtils.c:165: charBitArray<<=1;
	sla	c
;src/StringUtils.c:167: *currentPos=val;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),b
;src/StringUtils.c:168: ++currentPos;
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	inc	de
;src/StringUtils.c:170: val=*currentPos;
	ld	a,(de)
	ld	-10 (ix),a
;src/StringUtils.c:172: if(charBitArray&0b10000000) val = (g_colors[fg]&0b10101010)|(val&0b01010101);
	bit	7, c
	jr	Z,00108$
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	and	a, #0xAA
	ld	b,a
	ld	a,-10 (ix)
	and	a, #0x55
	or	a, b
	ld	-10 (ix),a
00108$:
;src/StringUtils.c:174: charBitArray<<=1;
	ld	a,c
	add	a, a
;src/StringUtils.c:176: if(charBitArray&0b10000000) val = (g_colors[fg]&0b01010101)|(val&0b10101010);
	rlca
	jr	NC,00110$
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	and	a, #0x55
	ld	c,a
	ld	a,-10 (ix)
	and	a, #0xAA
	or	a, c
	ld	-10 (ix),a
00110$:
;src/StringUtils.c:180: *currentPos=val;
	ld	a,-10 (ix)
	ld	(de),a
;src/StringUtils.c:181: ++currentPos;
	inc	de
	ld	-2 (ix),e
	ld	-1 (ix),d
;src/StringUtils.c:183: ++currentChar;
	inc	-7 (ix)
	jp	NZ,00111$
	inc	-6 (ix)
	jp	00111$
00113$:
;src/StringUtils.c:185: position-=(2048);
	ld	a,-4 (ix)
	add	a,#0x00
	ld	-4 (ix),a
	ld	a,-3 (ix)
	adc	a,#0xF8
	ld	-3 (ix),a
	jp	00114$
00117$:
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
