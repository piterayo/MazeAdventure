
#include "StringInput.h"

#define MAX_INPUT_STRING 18

char inputString[MAX_INPUT_STRING+1];

u8 currentPos;

void ui_stringinput_init(){
    currentPos=0;
    cpct_memset(inputString, 0, MAX_INPUT_STRING+1);
}

void ui_stringinput_add_char(u8 c){
    if(currentPos<MAX_INPUT_STRING){
        inputString[currentPos] = c;
        ++currentPos;
    }
}

char* const ui_stringinput_get_string(){
    return inputString;
}

void ui_stringinput_remove_char(){
    if(currentPos>0){
        --currentPos;
        inputString[currentPos] = 0;
    }
}
