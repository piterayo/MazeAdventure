
#include "UI_Log.h"

#include "StringUtils.h"

#include "Renderer.h"

#define UI_LOG_TITLE_POSITION cpctm_screenPtr((u16)CPCT_VMEM_START, 70, 16)
#define UI_LOG_POSITION cpctm_screenPtr((u16)CPCT_VMEM_START, 64, 32)

#define UI_LOG_BG_COLOR 1
// #define UI_LOG_FG_COLOR 3

u8 ui_log_currentString;

char ui_log_textStrings[8][10];

void ui_log_init(){
    u8 n=8;
    ui_log_currentString=0;
    print_text("LOG", UI_LOG_TITLE_POSITION, UI_LOG_BG_COLOR, 3);
    while(n){
        --n;
        ui_log_textStrings[n][0]=0;
        ui_log_textStrings[n][8]=0;
    }
}

void ui_log_add_log(const char* const newLog, u8 color){
    
    ui_log_currentString = (ui_log_currentString+1) & 7;
    
    cpct_memcpy(ui_log_textStrings[ui_log_currentString], newLog, 8);
    ui_log_textStrings[ui_log_currentString][9] = color;
    
}

void ui_log_render(){
    u8 i = 8;
    u8* pos = UI_LOG_POSITION;
    cpct_drawSolidBox(UI_LOG_POSITION, g_colors[1], 16, 64);
    while(i){
        ui_log_currentString=((ui_log_currentString+1)&7);
        print_text(ui_log_textStrings[ui_log_currentString], pos, UI_LOG_BG_COLOR, ui_log_textStrings[ui_log_currentString][9]);
        pos+=80;
        --i;
    }
    
    
}