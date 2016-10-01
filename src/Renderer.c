
#include "Renderer.h"
#include "Map.h"
#include "Structures.h"
#include "Player.h"
#include "Textures.h"

//#define _USE_OLD_RENDERER


#define CELLS_IN_VIEW_DEPTH 6

const u8 g_palette[16]={
    8,//Transparent color, common for all scenes
    0,13,26, //UI black, gray, white
    6,//Common for all scenes, minimap
    1,//Sky color
    9,//Ground color
    3,24,18,5,14,15,16,17,19,//Scene colors
};

const u8 g_colors[16]={
  0b00000000,//0
  0b11000000,//1
  0b00001100,//2
  0b11001100,//3
  0b00110000,//4
  0b11110000,//5
  0b00111100,//6
  0b11111100,//7
  0b00000011,//8
  0b11000011,//9
  0b00001111,//10
  0b11001111,//11
  0b00110011,//12
  0b11110011,//13
  0b00111111,//14
  0b11111111 //15
};

const u8 pixelMask[2]={
    0b10101010, 0b01010101
};

// #ifdef _USE_OLD_RENDERER

// // Raycasting methods and variables

// #define camPlaneMag 0.7f


// void abs(f32* n){
    // *(((u8*)n)+3) &= 0x7F;
// }

// void draw_column_to_buffer(const u8 column, u8 lineHeight, const u8 wall_texture, const u8 wall_texture_column) {
    // u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
    
    // u16 d;
    
    // u8 s_color, g_color, w_color, wall_texture_line ;
    // u8 pixMask = pixelMask[column&1];
    
    // u8 val = wall_texture;
    
    // u8 j;
    
    // u8 ceiling_height;
    // u8 ground_height;
   
    
    // ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
    // ground_height = ceiling_height + lineHeight;
    
    // s_color = (g_colors[SKY_COLOR]&pixMask);
    // g_color = (g_colors[GROUND_COLOR]&pixMask);
    
    // for(j=0;j<SCREEN_TEXTURE_HEIGHT;++j){
        // val =  ((*pvmem)&(~pixMask));
        // if(j<ceiling_height) *pvmem = val|s_color;
        // else if(j>ground_height) *pvmem = val|g_color;
        // else{
            // d = (u16)(j * 256) - (u16)(SCREEN_TEXTURE_HEIGHT * 128) + (u16)(lineHeight * 128);  //256 and 128 factors to avoid floats
            // wall_texture_line = ((d * TEXTURE_HEIGHT_BYTES) / lineHeight) / 256;
            
            // w_color = (g_tile_tileWall[wall_texture_column+(TEXTURE_WIDTH_BYTES*wall_texture_line)]&pixelMask[(wall_texture_column&1)]);
            // w_color = w_color | ((wall_texture_column&1)?w_color<<1:w_color>>1);
            // w_color = (w_color&pixMask);
            // *pvmem = val|w_color;
        // } 
        // pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
    // }
// }


// void render_draw_to_buffer(){
    // Vec2f rayDir, magBetweenEdges, magToEdge;
    // Vec2i worldIndex, dirStep;
    // u8 sideHit, lineHeight,texture;
    // u8 x,texX;
    // f32 wallDist, currCamScale, wallX;
    // u8 (*map)[MAP_HEIGHT] = MAP_MEM;
    
    // for(x = 0;x<SCREEN_TEXTURE_WIDTH;++x)
    // {
        
        // currCamScale = ((2.0f * x) / (float) SCREEN_TEXTURE_WIDTH) - 1.0f;
        
        // rayDir.x = PLAYER_direction.x - ((PLAYER_direction.y * camPlaneMag) * currCamScale);
        // rayDir.y = PLAYER_direction.y + ((PLAYER_direction.x * camPlaneMag) * currCamScale);
        
        // worldIndex.x = PLAYER_position.x;
        // worldIndex.y = PLAYER_position.y;
        
        // magBetweenEdges.x = (rayDir.x + rayDir.y);
        // magBetweenEdges.y = (rayDir.x + ((rayDir.x*rayDir.x)/rayDir.y));
        
        // abs(&(magBetweenEdges.x));
        // abs(&(magBetweenEdges.y));
        
        // if(rayDir.x > 0){
            // magToEdge.x = ((worldIndex.x + 1) - (PLAYER_position.x+0.5f)) * magBetweenEdges.x;
            // dirStep.x = 1;
        // }
        // else{
            // magToEdge.x = ((PLAYER_position.x+0.5f )- worldIndex.x) * magBetweenEdges.x;
            // dirStep.x = -1;
        // }
        
        // if(rayDir.y > 0){
            // magToEdge.y = ((worldIndex.y + 1) - (PLAYER_position.y+0.5f)) * magBetweenEdges.y;
            // dirStep.y = 1;
        // }
        // else{
            // magToEdge.y = ((PLAYER_position.y+0.5f )- worldIndex.y) * magBetweenEdges.y;
            // dirStep.y = -1;
        // }
        
        // do{
            // if(magToEdge.x < magToEdge.y){
                // magToEdge.x += magBetweenEdges.x;
                // worldIndex.x += dirStep.x;
                // sideHit=0;
            // }
            // else{
                // magToEdge.y += magBetweenEdges.y;
                // worldIndex.y += dirStep.y;
                // sideHit=1;
            // }
        // }while(map[worldIndex.x][worldIndex.y] == 0);
        
        // if(!sideHit){
            // wallDist = ((worldIndex.x - (PLAYER_position.x+0.5f)) + ((1 - dirStep.x)/2.0f))/rayDir.x;
        // }
        // else{
            // wallDist = ((worldIndex.y - (PLAYER_position.y+0.5f)) + ((1 - dirStep.y)/2.0f))/rayDir.y;
        // }
        
        
        // lineHeight = (wallDist<1)?SCREEN_TEXTURE_HEIGHT:(SCREEN_TEXTURE_HEIGHT/wallDist);
        
        
        // switch(map[worldIndex.x][worldIndex.y]){
            // case 1:{
                // texture = sideHit?WALL1_COLOR:WALL2_COLOR;
                // break;
                // }
            // case 2:{
                // texture = sideHit?DOOR1_COLOR:DOOR2_COLOR;
                // break;
            // }
        // }
        
        // // where exactly the wall was hit
        // if (sideHit == 0){
          // wallX = worldIndex.y + wallDist * rayDir.y;
        // }
        // else{
          // wallX = worldIndex.x + wallDist * rayDir.x;
        // }           
        // wallX -= ((u8)(wallX));

        // // x coordinate on the texture
        // texX = (u8)(wallX * TILE_WIDTH)%TEXTURE_WIDTH_BYTES;
        // if(sideHit == 0 && rayDir.x > 0) texX = TEXTURE_WIDTH_BYTES - texX - 1;
        // if(sideHit == 1 && rayDir.y < 0) texX = TEXTURE_WIDTH_BYTES - texX - 1;

        
        // draw_column_to_buffer((x), lineHeight, texture, texX);
    // }
// }

// #endif /* OLD RENDERER */

#ifndef _USE_OLD_RENDERER
    
//New renderer implementation

u8* const cells_in_view_array = (u8*)CELLS_IN_VIEW_ARRAY;

const u8 offsets_cells_in_view[5]={
    8,12,14,15,16
};

void calculate_cells_in_view(){
    
    u8 offset=0, n=0, j, i;
    i8 x0, y0, dx, dy, x=0, y=0, vert=0;
    
    if(PLAYER_direction.y!=0){
        vert=1;
        dy=PLAYER_direction.y;
        dx=-PLAYER_direction.y;
        
        x0 = PLAYER_position.x-(17*dx);
        y0 = PLAYER_position.y+(6*dy);
    }
    else{
        vert=0;
        dy=PLAYER_direction.x;
        dx=PLAYER_direction.x;
        
        y0 = PLAYER_position.y-(17*dy);
        x0 = PLAYER_position.x+(6*dx);
        
    }
    
    x=x0;
    y=y0;
    
    for(j=0;j<6;++j){
        
        for(i=offset;i<35-offset;++i){
            
            if((x>=0 && x<MAP_WIDTH) && (y>=0 && y<MAP_HEIGHT)){
                cells_in_view_array[n]=*(u8*)(MAP_MEM+x+y*MAP_WIDTH);
            }
            else{
                cells_in_view_array[n]=1;
            }
            
            
            if(vert){
                x+=dx;
            }
            else{
                y+=dy;
            }
            ++n;
        }
        offset=offsets_cells_in_view[j];
        
        if(vert){
            y-=dy;
            if(dx<0) x=x0-offset;
            else x=x0+offset;
            
        }
        else{
            x-=dx;
            if(dy<0) y=y0-offset;
            else y=y0+offset;
        }
    }
    
    
}
void draw_column_to_buffer(const u8 column, u8 lineHeight, u8 wall_texture, const u8 wall_texture_column) {
    u8* pvmem = (u8*)(SCREEN_TEXTURE_BUFFER) + (column>>1) ;
    
    u8 w_color, start=0,end=SCREEN_TEXTURE_HEIGHT;
    u8 pixMask = pixelMask[column&1];
    
    u8 val;
    
    //u8 color;
    
    //                       START POSITION          TEXTURE INDEX OFFSET           X POSITION OFFSET
    u8* texture = (u8*)(UNCOMPRESSED_SHARED_TEXTURES + (1024*wall_texture) + ((wall_texture_column)*TEXTURE_WIDTH));
    
    u8 j;
    
    u8 ceiling_height;
    u8 ground_height;
    
        
    u16 wall_texture_line_add = (256*TEXTURE_HEIGHT)/lineHeight;
    u16 wall_texture_line=0;
    
    // wall_texture = g_colors[wall_texture]&pixMask;
    // w_color = wall_texture;
    
    ceiling_height  = (SCREEN_TEXTURE_HEIGHT>>1) - (lineHeight>>1);
    ground_height = ceiling_height + lineHeight;
    
    
    if(lineHeight>SCREEN_TEXTURE_HEIGHT){
        start=(lineHeight-SCREEN_TEXTURE_HEIGHT)/2;
        end+=start;
        ceiling_height=0;
        wall_texture_line = start * wall_texture_line_add;
    }
        

    
    for(j=start;j<end;++j){
        val =  ((*pvmem)&(~pixMask));
        
        if((j>=ceiling_height) && (j<ground_height)){
            
            w_color = (*(texture+(wall_texture_line/256))&pixMask);
                        
            *pvmem = val|w_color;
            
            wall_texture_line += wall_texture_line_add;
        }
        pvmem+=SCREEN_TEXTURE_WIDTH_BYTES;
    }
}

void render_draw_to_buffer(){//TODO Optimize
    
    u8 xHeight = 2;
    
    u8 x;
    i8 z=6;
    
    u8 xCell = 0;
    u8 xCellCount = 0;
    
    u8 zHeight = 5;
    
    u8 lateralWallCounter = 0;
    u8 lateralWallSlope = 0;
    u8 lateralWallSlopeCounter = 0;
    
    u8 offsetDiff = 16;
    
    u8 lastCellWasWall = 0;
    
    u8 lineEnd = 0;
    u8 lineStart = 0;
    
    u8 lateralWallWidth=0;
    
    u8 tex_column;
    u8 lastWallId;
    
    u8 newCell;
    u8 currentCellID;
    
    u8 color;
    
    //u16 temp;
    
    cpct_memset(SCREEN_TEXTURE_BUFFER, g_colors[SKY_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
    cpct_memset(SCREEN_TEXTURE_HORIZON_WALL_START, g_colors[HORIZON_COLOR], SCREEN_TEXTURE_HORIZON_WALL_SIZE);
    cpct_memset(SCREEN_TEXTURE_GROUND_START, g_colors[GROUND_COLOR], SCREEN_TEXTURE_GROUND_SKY_SIZE);
    
    calculate_cells_in_view();
    
    
    do{
        
        --z;
        
        //Start to center
        
        xCellCount = (z) ? (zHeight >> 1) : 0;
        lateralWallSlope=0;
        lateralWallSlopeCounter=0;
        xHeight=0;
        xCell = 0;
        lateralWallCounter = 0;
        
        newCell=1;
        currentCellID = cells_in_view_array[lineStart + 1];
        
        lastCellWasWall = cells_in_view_array[lineStart];//Calculate offscreen
        if(lastCellWasWall<5){
            lastWallId=lastCellWasWall;
            lastCellWasWall=1;
        }
        else{
            lastCellWasWall=0;
            lastWallId=CELLTYPE_FLOOR;
        }
        
        for (x = 0; x < SCREEN_TEXTURE_WIDTH; ++x)
        {
            if (xCellCount == zHeight)
            {
                ++xCell;
                xCellCount = 0;
                newCell=1;
                currentCellID=cells_in_view_array[xCell + lineStart + 1];
            }
            if(!(x%2)){
                if ((lateralWallCounter == 0)||newCell)
                {
                    if (currentCellID < 5)//Wall
                    {
                        lateralWallCounter = 0;//(zHeight - xCellCount);
                        lateralWallSlope = 0;
                        xHeight = zHeight;
                        color = currentCellID;
                        lastCellWasWall = 1;
                        lastWallId=currentCellID;
                    }
                    else if(lateralWallCounter==0){//Lateral wall not finished
                        if (lastCellWasWall)
                        {
                            
                            lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
                            lateralWallSlopeCounter = lateralWallSlope / 2;
                            lateralWallCounter = lateralWallSlope * zHeight;
                            lateralWallCounter = (((lateralWallCounter & 0xFC) | 0x01) >> 2) - xCellCount;
                            lateralWallWidth=lateralWallCounter;
                            lastCellWasWall = 0;
                            xHeight = zHeight - ((2 * xCellCount) / lateralWallSlope);
                            color = lastWallId;
                        }
                        else //Dont draw
                        {
                            xHeight = 0;
                            lastCellWasWall = 0;
                            lateralWallSlope=0;
                            lastWallId=0;
                        }
                    }
                    // if()
                    newCell=0;
                }
            }
            if (lateralWallCounter > 0)
            {
            
                if (lateralWallSlope != 0)
                {
                    if (lateralWallSlopeCounter == lateralWallSlope)
                    {
                        lateralWallSlopeCounter = 0;
                        xHeight -= 2;
                    }
                    ++lateralWallSlopeCounter;
                }
                
                --lateralWallCounter;
            }
            
            if (!(x%2))
            {
                if(xHeight > 0){
                    if (lateralWallCounter > 0)
                    {
                        tex_column=(lateralWallWidth-lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
                    }
                    else{
                        tex_column=(xCellCount)*TEXTURE_WIDTH/zHeight;
                    }
                    draw_column_to_buffer(x/2, xHeight, color,tex_column);
                }
            }
            
            ++xCellCount;
            
        }
        
        
        ////End to center
        
        xCellCount = (z) ? (zHeight >> 1) : 0 ;
        lateralWallSlope=0;
        lateralWallSlopeCounter=0;
        xHeight=0;
        xCell = 0;
        lateralWallCounter = 0;
        lineEnd = lineStart + offsetDiff * 2 + 2;
        
        newCell=1;
        currentCellID = cells_in_view_array[lineEnd - 1];
        
        lastCellWasWall = cells_in_view_array[lineEnd];//Calculate offscreen
        if(lastCellWasWall<5){
            lastWallId=lastCellWasWall;
            lastCellWasWall=1;
        }
        else{
            lastCellWasWall=0;
            lastWallId=CELLTYPE_FLOOR;
        }
        
        for (x = (SCREEN_TEXTURE_WIDTH*2) - 1; x >= SCREEN_TEXTURE_WIDTH; --x)
            
        {
            if (xCellCount == zHeight)
            {
                ++xCell;
                xCellCount = 0;
                newCell=1;
                currentCellID = cells_in_view_array[lineEnd - xCell - 1];
            }
            if(!(x%2)){
                if (lateralWallCounter == 0 || newCell)
                {
                    if ( currentCellID < 5)//Wall
                    {
                        lateralWallCounter = 0;
                        lateralWallSlope = 0;
                        xHeight = zHeight;
                        color = currentCellID;
                        lastCellWasWall = 1;
                        lastWallId=currentCellID;
                    }
                    else if(lateralWallCounter==0){
                        if (lastCellWasWall)
                        {
                            
                            lateralWallSlope = (((offsetDiff - xCell) * 2) + 1);//TODO Optimize
                            lateralWallSlopeCounter = lateralWallSlope / 2;
                            lateralWallCounter = lateralWallSlope * zHeight;
                            lateralWallCounter = (((lateralWallCounter - (lateralWallCounter % 4)) + 1) / 4) - xCellCount;
                            lateralWallWidth=lateralWallCounter;
                            lastCellWasWall = 0;
                            xHeight = zHeight - 2 * xCellCount / lateralWallSlope;
                            color = lastWallId;
                        }
                        else //Dont draw
                        {
                            xHeight = 0;
                            lastCellWasWall = 0;
                            lateralWallSlope=0;
                            lastWallId=0;
                        }
                    }
                    newCell=0;
                }
            }
            
            
            if (lateralWallCounter > 0)
            {
                
                if (lateralWallSlope != 0)
                {
                    if (lateralWallSlopeCounter == lateralWallSlope)
                    {
                        lateralWallSlopeCounter = 0;
                        xHeight -= 2;
                    }
                    ++lateralWallSlopeCounter;
                }
                --lateralWallCounter;
            }
            
            
            if (!(x%2))
            {
                
                if(xHeight > 0){
            
                    if (lateralWallCounter > 0)
                    {
                        tex_column=(lateralWallCounter)*TEXTURE_WIDTH/lateralWallWidth;
                    }
                    else{
                        tex_column=(zHeight-xCellCount)*TEXTURE_WIDTH/zHeight;
                    }
                    
                    draw_column_to_buffer(x/2, xHeight, color,tex_column);
                }
            }
            ++xCellCount;
            
        }
        
        
        
        
        lineStart = lineStart + (offsetDiff * 2) + 3;
        zHeight += zHeight;
        offsetDiff = offsetDiff >> 1;
        
    }while(z);
    
    
}

#endif /*NEW RENDERER*/


void draw_minimap_to_buffer(){
    u8 i, j, n;
    i8 x,y;
    u8* ptr = MINIMAP_BUFFER;
    
    u8 (*map)[MAP_HEIGHT] = MAP_MEM;
    //u8 pixMask; 
    x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
    y=(PLAYER_position.y-MINIMAP_HEIGHT_HALF);
    
    for(j=0;j<MINIMAP_HEIGHT;++j){
        for(n=0;n<MINIMAP_HEIGHT_WIDTH_RATIO;++n){
            x=(PLAYER_position.x-MINIMAP_WIDTH_HALF);
            for(i=0;i<MINIMAP_WIDTH;++i){
                if((x<0)||(x>=MAP_WIDTH)||(y<0)||(y>=MAP_HEIGHT)){
                    *ptr=g_colors[MINIMAP_WALL_COLOR];
                    *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
                }
                else if((x==PLAYER_position.x)&&(y==PLAYER_position.y)){
                    *ptr=g_colors[MINIMAP_PLAYER_COLOR];
                    *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_PLAYER_COLOR];
                }
                else{
                    switch(*(u8*)(MAP_MEM+x+y*MAP_WIDTH)){
                        case CELLTYPE_FLOOR:{
                            *ptr=g_colors[MINIMAP_FLOOR_COLOR];
                            *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_FLOOR_COLOR];
                            break;
                        }
                        case CELLTYPE_DOOR:{
                            *ptr=g_colors[MINIMAP_EXIT_COLOR];
                            *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_EXIT_COLOR];
                            break;
                        }
                        default:{
                            *ptr=g_colors[MINIMAP_WALL_COLOR];
                            *(ptr+MINIMAP_WIDTH_BYTES)=g_colors[MINIMAP_WALL_COLOR];
                            break;
                        }
                    }
                }
                ++x;
                ++ptr;
            }
        }
        ++y;
    }
}