
#include "StringUtils.h"

#include "Renderer.h"


#include "textures/typography/typography_4x6_monospaced.h"

#define CHARSET_LENGHT 50


//ICONS
// # = Shield
// $ = Key
// + = Sword
// & = Potion
// < = Left arrow
// > = Right arrow
// * = Face
// ~ = Venom

const u8 charArray[128]={
     41, 41, 41, 41, 41, 41, 41, 41,     41, 41, 41, 41, 41, 41, 41, 41, //15
     41, 41, 41, 41, 41, 41, 41, 41,     41, 41, 41, 41, 41, 41, 41, 41, //31
     41, 36, 41, 45, 47, 41, 46, 41,     41, 41, 49, 44, 41, 41, 38, 41, //47
     26, 27, 28, 29, 30, 31, 32, 33,     34, 35, 39, 41, 42, 41, 43, 37, //63
     40,  0,  1,  2,  3,  4,  5,  6,      7,  8,  9, 10, 11, 12, 13, 14, //79
     15, 16, 17, 18, 19, 20, 21, 22,     23, 24, 25, 41, 41, 41, 41, 41, //95
     41,  0,  1,  2,  3,  4,  5,  6,      7,  8,  9, 10, 11, 12, 13, 14, //111
     15, 16, 17, 18, 19, 20, 21, 22,     23, 24, 25, 41, 41, 41, 48, 41, //127
};

char const i_to_s_buffer[9]={0,0,0,0,0,0,0,0,0};

void* integer_to_string(u8 n, u8 format){
    u8* charPosition=(u8*)&i_to_s_buffer;
    u8 t;
    switch(format){
        case 'h':{
            charPosition+=2;
            
            *charPosition = 0;
            
            --charPosition;
            
            t=n&0x0F;
            t=t>9?t+55:t+48;
            *charPosition=t;
            n>>=4;
            --charPosition;
            
            t=n>9?n+55:n+48;
            *charPosition=t;
            break;
        }
        case 'b':{
            t=8;
            charPosition+=8;
            
            while(t){
                --t;
                --charPosition;
                *charPosition=(n&1)+48;
                n>>=1;
            }
            break;
        }
        default:{
            charPosition+=3;
            
            *charPosition = 0;
            
            --charPosition;
            
            *charPosition=48+(n%10);
            --charPosition;
            n/=10;
            *charPosition=48+(n%10);
            --charPosition;
            n/=10;
            *charPosition=48+(n%10);
            break;
        }
    }
    
    return i_to_s_buffer;
    
}

void print_text(void * const text, u8* position, u8 bg, u8 fg){
    u8 val, charBitArray, spritePos, fgColor=g_colors[fg], bgColor=g_colors[bg];
    u8* currentChar;
    u8* currentPos;
    u8 height = (2*typography_4x6_monospaced_LENGTH/CHARSET_LENGHT);
    u8 width = (CHARSET_LENGHT/2);
    
    (position)+=0x2800;
    if(position<0x2800){
        position-=0x4000;
        position+=80;
    }
    
    while(height){
        --height;
        currentChar=text;
        currentPos=position;
        val=0;
        while(*currentChar){
            
            spritePos = charArray[(*currentChar)];
            
            charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
            
            if(spritePos%2) charBitArray<<=4;
            
            val=0;
            
            val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
            
            charBitArray<<=1;
            
            val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
            
            charBitArray<<=1;
            
            *currentPos=val;
            ++currentPos;
            
            val=0;
            
            val = ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b10101010;
            
            charBitArray<<=1;
            
            val = val | ((charBitArray&0b10000000)?(fgColor):(bgColor))&0b01010101;
            
            charBitArray<<=1;
            
            *currentPos=val;
            ++currentPos;
            
            ++currentChar;
        }
        position-=0x0800;
        
        if(position<0xC000){
            position+=0x4000;
            position-=80;
        } 
    }
    
}

void print_transparent_text(void* const text, u8* position, u8 fg){
    u8 val, charBitArray, spritePos, color = g_colors[fg];
    u8* currentChar;
    u8* currentPos;
    u8 height = (2*typography_4x6_monospaced_LENGTH/CHARSET_LENGHT);
    u8 width = (CHARSET_LENGHT/2);
    
    (position)+=0x2800;
    if(position<0x2800){
        position-=0x4000;
        position+=80;
    }
    
    while(height){
        currentChar=text;
        currentPos=position;
        --height;
        while(*currentChar){
            
            spritePos = charArray[(*currentChar)];
            
            charBitArray = typography_4x6_monospaced[spritePos/2 + height*width];
            
            if(spritePos%2) charBitArray<<=4;
            
            val=*currentPos;
            
            if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
            
            charBitArray<<=1;
            
            if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
            
            charBitArray<<=1;
            
            *currentPos=val;
            ++currentPos;
            
            val=*currentPos;
            
            if(charBitArray&0b10000000) val = (color&0b10101010)|(val&0b01010101);
            
            charBitArray<<=1;
            
            if(charBitArray&0b10000000) val = (color&0b01010101)|(val&0b10101010);
            
            charBitArray<<=1;
            
            *currentPos=val;
            ++currentPos;
            
            ++currentChar;
        }
        position-=0x0800;
        
        if(position<0xC000){
            position+=0x4000;
            position-=80;
        } 
        
    }
}