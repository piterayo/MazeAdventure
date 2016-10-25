
#include "State_Inventory.h"
#include "StateManager.h"

#include "GameFunctions.h"

#include "Renderer.h"

#include "Item.h"

#include "UI_Inventory.h"

#include <cpctelera.h>

u8 object_used;

void state_inventory_enter(){
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[4], 34, 80);
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 24, 68), g_colors[1], 32, 72);
    ui_inventory_init();
    ui_inventory_render_all();
    object_used=0;
}

void state_inventory_return(){
    
}

u8 state_inventory_object_used(){
    return object_used;
}

void state_inventory_input(){
    if(cpct_isKeyPressed(Key_CursorUp)){
        ui_inventory_previous_entry();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_CursorDown)){
        ui_inventory_next_entry();
        statemanager_input_accepted();
    }
    else if(cpct_isKeyPressed(Key_Return)){
        ui_inventory_select_entry();
        statemanager_input_accepted();
    }
}

void state_inventory_update(){
    if(ui_inventory_is_selected()){
        ui_inventory_render_refresh();
        switch(ui_inventory_get_entry()){
            case 0:{//Potion
                object_used=item_use_potion();
                break;
            }
            case 1:{//Scroll
                object_used=item_use_scroll();
                break;
            }
        }
        statemanager_close_state();
    }
    ui_inventory_unselect_entry();
}

void state_inventory_render(){
    ui_inventory_render_refresh();
}

void state_inventory_exit(){
    cpct_drawSolidBox (cpctm_screenPtr(CPCT_VMEM_START, 23, 64), g_colors[1], 34, 80);
}