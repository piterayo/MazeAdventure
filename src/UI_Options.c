
#include "UI_Options.h"

#include "GameDefinitions.h"
#include "GameFunctions.h"

#include "StringUtils.h"
#include "Renderer.h"

#define UI_OPTIONS_BUTTON_TEXTURES_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 43, 72))

#define UI_OPTIONS_BUTTON_MUSIC_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 43, 72+20))

#define UI_OPTIONS_BUTTON_EXIT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 34, 72+40))


#define UI_OPTIONS_BUTTON_TEXT_LABEL_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 26, 72+5))

#define UI_OPTIONS_BUTTON_MUSIC_LABEL_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 26, 72+25))


#define UI_OPTIONS_BUTTON_TEXTURES_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 46, 72+5))

#define UI_OPTIONS_BUTTON_MUSIC_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 46, 72+25))

#define UI_OPTIONS_BUTTON_EXIT_TEXT_POSITION (cpctm_screenPtr((u16)CPCT_VMEM_START, 36, 72+45))

#define UI_OPTIONS_ENTRIES 3

#define UI_OPTIONS_BUTTON_HEIGHT 16

#define UI_OPTIONS_BUTTON_WIDTH 12

u8 ui_options_lastEntry;
u8 ui_options_entryIndex;
u8 ui_options_entrySelected;

const void* const ui_options_entriesPosition[UI_OPTIONS_ENTRIES]={
    UI_OPTIONS_BUTTON_TEXTURES_POSITION,
    UI_OPTIONS_BUTTON_MUSIC_POSITION,
    UI_OPTIONS_BUTTON_EXIT_POSITION
};

const void* const ui_options_entriesTextPosition[UI_OPTIONS_ENTRIES]={
    UI_OPTIONS_BUTTON_TEXTURES_TEXT_POSITION,
    UI_OPTIONS_BUTTON_MUSIC_TEXT_POSITION,
    UI_OPTIONS_BUTTON_EXIT_TEXT_POSITION
};

const char* const ui_options_on_off[2]={
    "OFF", "ON"
};

const char* const ui_options_buttonText[UI_OPTIONS_ENTRIES]={
    "","","EXIT"
};

void ui_options_set_strings(){
    *(char**)(ui_options_buttonText)=ui_options_on_off[textures_on];
    *(char**)(ui_options_buttonText+1)=ui_options_on_off[music_on];
    // ui_options_render_all();
}

void ui_options_init(){
    ui_options_lastEntry=0;
    ui_options_entryIndex=0;
    ui_options_entrySelected=0;
    ui_options_set_strings();
}


u8 ui_options_get_entry(){
    return ui_options_entryIndex;
}

u8 ui_options_is_selected(){
    return ui_options_entrySelected;
}

void ui_options_next_entry(){
    if(ui_options_entryIndex<(UI_OPTIONS_ENTRIES-1)){
        ui_options_lastEntry=ui_options_entryIndex;
        ++ui_options_entryIndex;
    }
}

void ui_options_previous_entry(){
    if(ui_options_entryIndex>0){
        ui_options_lastEntry=ui_options_entryIndex;
        --ui_options_entryIndex;
    }
}


void ui_options_select_entry(){
    ui_options_entrySelected=1;
}

void ui_options_unselect_entry(){
    ui_options_entrySelected=0;
}

void ui_options_render_button(u8 n){
    u8 color;
    color = (n==ui_options_entryIndex)?((ui_options_entrySelected)? g_colors[BUTTON_COLOR_SELECTED]: g_colors[BUTTON_COLOR_HIGHLIGHT]): g_colors[BUTTON_COLOR_BACKGROUND];
    cpct_drawSolidBox(ui_options_entriesPosition[n],color, UI_OPTIONS_BUTTON_WIDTH, UI_OPTIONS_BUTTON_HEIGHT);
    print_transparent_text(ui_options_buttonText[n], ui_options_entriesTextPosition[n], 3);
}


void ui_options_render_refresh(){
    
    ui_options_render_button(ui_options_entryIndex);
    ui_options_render_button(ui_options_lastEntry);
    
    ui_options_lastEntry=ui_options_entryIndex;
}

void ui_options_render_all(){
    u8 n=UI_OPTIONS_ENTRIES;
    
    print_transparent_text("TEXTURES", UI_OPTIONS_BUTTON_TEXT_LABEL_POSITION, 3);
    print_transparent_text("MUSIC", UI_OPTIONS_BUTTON_MUSIC_LABEL_POSITION, 3);
    
    while(n){
        --n;
        ui_options_render_button(n);
    }
    
     ui_options_lastEntry=ui_options_entryIndex;
}
