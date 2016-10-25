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
;src/StringUtils.c:35: void* integer_to_string(u8 n, u8 format){
;	---------------------------------
; Function integer_to_string
; ---------------------------------
_integer_to_string::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/StringUtils.c:36: u8* charPosition=(u8*)&i_to_s_buffer;
	ld	bc,#_i_to_s_buffer+0
;src/StringUtils.c:38: switch(format){
	ld	a,5 (ix)
	sub	a, #0x62
	jr	Z,00102$
	ld	a,5 (ix)
	sub	a, #0x68
	jr	NZ,00106$
;src/StringUtils.c:40: charPosition+=2;
	ld	de,#_i_to_s_buffer + 2
;src/StringUtils.c:42: *charPosition = 0;
	xor	a, a
	ld	(de),a
;src/StringUtils.c:44: --charPosition;
	dec	de
;src/StringUtils.c:46: t=n&0x0F;
	ld	a,4 (ix)
	and	a, #0x0F
	ld	l,a
;src/StringUtils.c:47: t=t>9?t+55:t+48;
	ld	a,#0x09
	sub	a, l
	jr	NC,00110$
	ld	a,l
	add	a, #0x37
	jr	00111$
00110$:
	ld	a,l
	add	a, #0x30
00111$:
;src/StringUtils.c:48: *charPosition=t;
	ld	(de),a
;src/StringUtils.c:49: n>>=4;
	ld	a,4 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0F
	ld	4 (ix),a
;src/StringUtils.c:50: --charPosition;
	dec	de
;src/StringUtils.c:52: t=n>9?n+55:n+48;
	ld	a,#0x09
	sub	a, 4 (ix)
	jr	NC,00112$
	ld	a,4 (ix)
	add	a, #0x37
	jr	00113$
00112$:
	ld	a,4 (ix)
	add	a, #0x30
00113$:
;src/StringUtils.c:53: *charPosition=t;
	ld	(de),a
;src/StringUtils.c:54: break;
	jp	00107$
;src/StringUtils.c:56: case 'b':{
00102$:
;src/StringUtils.c:58: charPosition+=8;
	ld	hl,#_i_to_s_buffer + 8
;src/StringUtils.c:60: while(t){
	ld	e,#0x08
00103$:
	ld	a,e
	or	a, a
	jr	Z,00107$
;src/StringUtils.c:61: --t;
	dec	e
;src/StringUtils.c:62: --charPosition;
	dec	hl
;src/StringUtils.c:63: *charPosition=(n&1)+48;
	ld	a,4 (ix)
	and	a, #0x01
	add	a, #0x30
	ld	(hl),a
;src/StringUtils.c:64: n>>=1;
	srl	4 (ix)
	jr	00103$
;src/StringUtils.c:68: default:{
00106$:
;src/StringUtils.c:69: charPosition+=3;
	ld	de,#_i_to_s_buffer + 3
;src/StringUtils.c:71: *charPosition = 0;
	xor	a, a
	ld	(de),a
;src/StringUtils.c:73: --charPosition;
	dec	de
;src/StringUtils.c:75: *charPosition=48+(n%10);
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
;src/StringUtils.c:76: --charPosition;
;src/StringUtils.c:77: n/=10;
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
;src/StringUtils.c:78: *charPosition=48+(n%10);
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
;src/StringUtils.c:79: --charPosition;
;src/StringUtils.c:80: n/=10;
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
;src/StringUtils.c:81: *charPosition=48+(n%10);
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
;src/StringUtils.c:84: }
00107$:
;src/StringUtils.c:86: return i_to_s_buffer;
	ld	l, c
	ld	h, b
	pop	ix
	ret
_charArray:
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x24	; 36
	.db #0x29	; 41
	.db #0x2D	; 45
	.db #0x2F	; 47
	.db #0x29	; 41
	.db #0x2E	; 46
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x31	; 49	'1'
	.db #0x2C	; 44
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x26	; 38
	.db #0x29	; 41
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
	.db #0x29	; 41
	.db #0x2A	; 42
	.db #0x29	; 41
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
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
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
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x30	; 48	'0'
	.db #0x29	; 41
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
;src/StringUtils.c:90: void print_text(void * const text, u8* position, u8 bg, u8 fg){
;	---------------------------------
; Function print_text
; ---------------------------------
_print_text::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-17
	add	hl,sp
	ld	sp,hl
;src/StringUtils.c:91: u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
	ld	a,9 (ix)
	add	a, #<(_g_colors)
	ld	-7 (ix),a
	ld	a,#0x00
	adc	a, #>(_g_colors)
	ld	-6 (ix),a
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	-13 (ix),a
	ld	a,#<(_g_colors)
	add	a, 8 (ix)
	ld	-7 (ix),a
	ld	a,#>(_g_colors)
	adc	a, #0x00
	ld	-6 (ix),a
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	a,(hl)
	ld	-14 (ix),a
;src/StringUtils.c:97: (position)+=0x2800;
	ld	a,6 (ix)
	add	a, #0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a, #0x28
	ld	7 (ix),a
;src/StringUtils.c:98: if(position<0x2800){
	ld	c,6 (ix)
	ld	b,7 (ix)
	ld	a,b
	sub	a, #0x28
	jr	NC,00132$
;src/StringUtils.c:99: position-=0x4000;
	ld	a,6 (ix)
	add	a,#0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a,#0xC0
	ld	7 (ix),a
;src/StringUtils.c:100: position+=80;
	ld	a,6 (ix)
	add	a, #0x50
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	7 (ix),a
;src/StringUtils.c:103: while(height){
00132$:
	ld	-17 (ix),#0x06
	ld	-7 (ix),#0x96
00110$:
	ld	a,-17 (ix)
	or	a, a
	jp	Z,00113$
;src/StringUtils.c:104: --height;
	ld	a,-7 (ix)
	add	a,#0xE7
	ld	-7 (ix),a
	dec	-17 (ix)
;src/StringUtils.c:105: currentChar=text;
	ld	a,4 (ix)
	ld	-9 (ix),a
	ld	a,5 (ix)
	ld	-8 (ix),a
;src/StringUtils.c:106: currentPos=position;
	ld	a,6 (ix)
	ld	-2 (ix),a
	ld	a,7 (ix)
	ld	-1 (ix),a
;src/StringUtils.c:108: while(*currentChar){
00105$:
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,(hl)
	ld	-3 (ix), a
	or	a, a
	jp	Z,00107$
;src/StringUtils.c:110: spritePos = charArray[(*currentChar)];
	ld	a,#<(_charArray)
	add	a, -3 (ix)
	ld	-5 (ix),a
	ld	a,#>(_charArray)
	adc	a, #0x00
	ld	-4 (ix),a
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	a,(hl)
;src/StringUtils.c:112: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
	ld	-12 (ix), a
	srl	a
	ld	-5 (ix), a
	add	a, -7 (ix)
	ld	-5 (ix),a
	add	a,#<(_typography_4x6_monospaced)
	ld	-5 (ix),a
	ld	a,#>(_typography_4x6_monospaced)
	adc	a, #0x00
	ld	-4 (ix),a
	ld	l,-5 (ix)
	ld	h,-4 (ix)
	ld	a,(hl)
	ld	-5 (ix),a
;src/StringUtils.c:114: if(spritePos%2) charBitArray<<=4;
	bit	0, -12 (ix)
	jr	Z,00104$
	ld	a,-5 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	-5 (ix),a
00104$:
;src/StringUtils.c:118: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
	bit	7, -5 (ix)
	jr	Z,00115$
	ld	a,-13 (ix)
	jr	00116$
00115$:
	ld	a,-14 (ix)
00116$:
	and	a, #0xAA
	ld	c,a
;src/StringUtils.c:120: charBitArray<<=1;
	ld	a,-5 (ix)
	add	a, a
	ld	b,a
;src/StringUtils.c:122: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
	bit	7, b
	jr	Z,00117$
	ld	a,-13 (ix)
	jr	00118$
00117$:
	ld	a,-14 (ix)
00118$:
	and	a, #0x55
	or	a, c
	ld	c,a
;src/StringUtils.c:124: charBitArray<<=1;
	ld	a,b
	add	a, a
	ld	-11 (ix),a
;src/StringUtils.c:126: *currentPos=val;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),c
;src/StringUtils.c:127: ++currentPos;
	ld	a,-2 (ix)
	add	a, #0x01
	ld	-16 (ix),a
	ld	a,-1 (ix)
	adc	a, #0x00
	ld	-15 (ix),a
;src/StringUtils.c:131: val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
	bit	7, -11 (ix)
	jr	Z,00119$
	ld	a,-13 (ix)
	jr	00120$
00119$:
	ld	a,-14 (ix)
00120$:
	and	a, #0xAA
	ld	-10 (ix),a
;src/StringUtils.c:133: charBitArray<<=1;
	ld	a,-11 (ix)
	add	a, a
;src/StringUtils.c:135: val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
	rlca
	jr	NC,00121$
	ld	a,-13 (ix)
	jr	00122$
00121$:
	ld	a,-14 (ix)
00122$:
	and	a, #0x55
	ld	-5 (ix),a
	ld	a,-10 (ix)
	or	a, -5 (ix)
	ld	-5 (ix),a
;src/StringUtils.c:139: *currentPos=val;
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	ld	a,-5 (ix)
	ld	(hl),a
;src/StringUtils.c:140: ++currentPos;
	ld	a,-16 (ix)
	add	a, #0x01
	ld	-2 (ix),a
	ld	a,-15 (ix)
	adc	a, #0x00
	ld	-1 (ix),a
;src/StringUtils.c:142: ++currentChar;
	inc	-9 (ix)
	jp	NZ,00105$
	inc	-8 (ix)
	jp	00105$
00107$:
;src/StringUtils.c:144: position-=0x0800;
	ld	a,6 (ix)
	add	a,#0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a,#0xF8
;src/StringUtils.c:146: if(position<0xC000){
	ld	7 (ix), a
	sub	a, #0xC0
	jp	NC,00110$
;src/StringUtils.c:147: position+=0x4000;
	ld	a,6 (ix)
	add	a, #0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a, #0x40
	ld	7 (ix),a
;src/StringUtils.c:148: position-=80;
	ld	a,6 (ix)
	add	a,#0xB0
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a,#0xFF
	ld	7 (ix),a
	jp	00110$
00113$:
	ld	sp, ix
	pop	ix
	ret
;src/StringUtils.c:154: void print_transparent_text(void* const text, u8* position, u8 fg){
;	---------------------------------
; Function print_transparent_text
; ---------------------------------
_print_transparent_text::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;src/StringUtils.c:155: u8 val, charBitArray, spritePos, color = g_colors[fg];
	ld	bc,#_g_colors+0
	ld	l,8 (ix)
	ld	h,#0x00
	add	hl,bc
	ld	c,(hl)
;src/StringUtils.c:161: (position)+=0x2800;
	ld	a,6 (ix)
	add	a, #0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a, #0x28
	ld	7 (ix),a
;src/StringUtils.c:162: if(position<0x2800){
	ld	b,6 (ix)
	ld	e,7 (ix)
	ld	a,e
	sub	a, #0x28
	jr	NC,00132$
;src/StringUtils.c:163: position-=0x4000;
	ld	a,6 (ix)
	add	a,#0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a,#0xC0
	ld	7 (ix),a
;src/StringUtils.c:164: position+=80;
	ld	a,6 (ix)
	add	a, #0x50
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	7 (ix),a
;src/StringUtils.c:167: while(height){
00132$:
	ld	a,c
	and	a, #0xAA
	ld	-6 (ix),a
	ld	a,c
	and	a, #0x55
	ld	-5 (ix),a
	ld	-8 (ix),#0x06
	ld	-7 (ix),#0x96
00118$:
	ld	a,-8 (ix)
	or	a, a
	jp	Z,00121$
;src/StringUtils.c:168: currentChar=text;
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
;src/StringUtils.c:169: currentPos=position;
	ld	a,6 (ix)
	ld	-4 (ix),a
	ld	a,7 (ix)
	ld	-3 (ix),a
;src/StringUtils.c:170: --height;
	ld	a,-7 (ix)
	add	a,#0xE7
	ld	-7 (ix),a
	dec	-8 (ix)
;src/StringUtils.c:171: while(*currentChar){
00113$:
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	c,(hl)
	ld	a,c
	or	a, a
	jp	Z,00115$
;src/StringUtils.c:173: spritePos = charArray[(*currentChar)];
	ld	hl,#_charArray
	ld	b,#0x00
	add	hl, bc
	ld	b,(hl)
;src/StringUtils.c:175: charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
	ld	a, b
	srl	a
	add	a, -7 (ix)
	ld	e,a
	ld	hl,#_typography_4x6_monospaced
	ld	d,#0x00
	add	hl, de
	ld	c,(hl)
;src/StringUtils.c:177: if(spritePos%2) charBitArray<<=4;
	bit	0, b
	jr	Z,00104$
	ld	a,c
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	c,a
00104$:
;src/StringUtils.c:179: val=*currentPos;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	e,(hl)
;src/StringUtils.c:181: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
	bit	7, c
	jr	Z,00106$
	ld	a,e
	and	a, #0x55
	or	a, -6 (ix)
	ld	e,a
00106$:
;src/StringUtils.c:183: charBitArray<<=1;
	sla	c
;src/StringUtils.c:185: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
	bit	7, c
	jr	Z,00108$
	ld	a,e
	and	a, #0xAA
	or	a, -5 (ix)
	ld	e,a
00108$:
;src/StringUtils.c:187: charBitArray<<=1;
	sla	c
;src/StringUtils.c:189: *currentPos=val;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),e
;src/StringUtils.c:190: ++currentPos;
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	inc	de
;src/StringUtils.c:192: val=*currentPos;
	ld	a,(de)
	ld	b,a
;src/StringUtils.c:194: if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
	bit	7, c
	jr	Z,00110$
	ld	a,b
	and	a, #0x55
	or	a, -6 (ix)
	ld	b,a
00110$:
;src/StringUtils.c:196: charBitArray<<=1;
	ld	a,c
	add	a, a
;src/StringUtils.c:198: if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
	rlca
	jr	NC,00112$
	ld	a,b
	and	a, #0xAA
	or	a, -5 (ix)
	ld	b,a
00112$:
;src/StringUtils.c:202: *currentPos=val;
	ld	a,b
	ld	(de),a
;src/StringUtils.c:203: ++currentPos;
	inc	de
	ld	-4 (ix),e
	ld	-3 (ix),d
;src/StringUtils.c:205: ++currentChar;
	inc	-2 (ix)
	jp	NZ,00113$
	inc	-1 (ix)
	jp	00113$
00115$:
;src/StringUtils.c:207: position-=0x0800;
	ld	a,6 (ix)
	add	a,#0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a,#0xF8
;src/StringUtils.c:209: if(position<0xC000){
	ld	7 (ix), a
	sub	a, #0xC0
	jp	NC,00118$
;src/StringUtils.c:210: position+=0x4000;
	ld	a,6 (ix)
	add	a, #0x00
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a, #0x40
	ld	7 (ix),a
;src/StringUtils.c:211: position-=80;
	ld	a,6 (ix)
	add	a,#0xB0
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a,#0xFF
	ld	7 (ix),a
	jp	00118$
00121$:
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
