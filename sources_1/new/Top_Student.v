`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): THURSDAY A.M.
//
//  STUDENT A NAME: Chien Jing Wei
//  STUDENT A MATRICULATION NUMBER: A0233540R
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////

//`include "definitions.vh"

module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    input CLOCK,
    output [15:0] led,
    input [15:0]sw, input pbl, pbr, pbu, pbd, pbc,
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden,
    output [3:0] an,
    output [7:0] seg
);

    wire clk20k, clk10, clk50, clk6p25m, clk1k, clk25MHz;
    wire reset, debU, debD, debR, debC, debL, debL_fast;
    wire [11:0]mic_in;
    my_clock_module clk_twentyk (CLOCK, clk20k, 2499);
    ten_Hz clk10Hz (CLOCK, clk10, 4999999);
    fifty_Hz clk50Hz (CLOCK, clk50, 999999);
    clk625m clk625Hz (CLOCK, clk6p25m, 7);
    clk1000Hz clk1000 (CLOCK, clk1k, 49999);
    twentyfive_MHz clk25M (CLOCK, clk25MHz, 3);
    
    debounce_single dsp0 (pbc, clk6p25m, reset); // To change to be menu button
    debounce_single dsp1 (pbu, clk1k, debU);
    debounce_single dsp2 (pbd, clk1k, debD);
    debounce_single dsp3 (pbr, clk1k, debR);
    debounce_single dsp4 (pbc, clk1k, debC);
    debounce_single dsp5 (pbl, clk1k, debL);
    //debounce_single dsp6 (pbl, clk10k, debL_fast);
    
    Audio_Capture audio (CLOCK, clk20k, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_in);
    wire [12:0] pixel_index;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [15:0] oled_data, oled_menu, oled_map, oled_lab, oled_lm, oled_trace, oled_stopwatch;
    wire [3:0] an_lab, an_map;
    wire [7:0] seg_lab, seg_map;
    wire [15:0] led_lab;
    wire [31:0] x, y;
    wire [3:0] state, menu_flag, curr_layer;
    wire [13:0] distance;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    menu fa0 (.pbu(debU), .pbd(debD), .SW0(sw[0]), .x(x), .y(y), .clk(clk1k), .oled_data(oled_menu), .state(menu_flag), .layer(curr_layer));
    
    stopwatch fa6(.CLOCK(CLOCK), .clk50(clk50), .SW0(sw[0]), .SW1(sw[1]), .SW2(sw[2]), .SW3(sw[3]), .SW4(sw[4]),.layer(curr_layer), .x(x), .y(y), .oled_data(oled_stopwatch)); 

    lab_task fa1 (.clk1k(clk1k), .clk20k(clk20k), .clk25MHz(clk25MHz), .SW15(sw[15]), .SW0(sw[0]), .SW2(sw[2]), .SW1(sw[1]), .SW3(sw[3]), .SW4(sw[4]), .pbl(pbl), .pbr(pbr), .x(x), .y(y), 
    .mic_in(mic_in), .an(an_lab), .seg(seg_lab), .led(led_lab), .oled_data(oled_lab), .layer(curr_layer));
    
    map fa2 (.layer(curr_layer), .SW0(sw[0]), .CLOCK(CLOCK), .pbu_ndb(pbu), .pbd_ndb(pbd), .pbl_ndb(pbl), .pbr_ndb(pbr), .clk50(clk1k), .pbc(debC), 
    .pbu(debU), .pbd(debD), .pbl(debL), .pbr(debR), .SW1(sw[1]), .SW14(sw[14]), .x(x), .y(y), .oled_data(oled_map), .seg_map(seg_map), .an_map(an_map)); 
    
    Landmarks fa5 (.CLOCK(CLOCK), .clk1k(clk1k), .pbu(debU), .pbd(debD), .pbl(debL), .pbr(debR), .pbc(debC), .SW14(sw[14]), .layer(curr_layer), .x(x), .y(y), .oled_data(oled_lm), .pixel_index(pixel_index));

    aftermenu fa3 (.clk(clk1k), .sw14(sw[14]), .pbc(debC), .pbl(debL), .pbr(debR), .menu_flag(menu_flag), .state(state), .layer(curr_layer));
    
    final_mux fa4(.clk(CLOCK), .an_map(an_map), .state(state), .an_lab(an_lab), .led_lab(led_lab), .seg_lab(seg_lab), .seg_map(seg_map), .oled_lab(oled_lab), 
    .oled_menu(oled_menu), .oled_distance(oled_map), .oled_trace(oled_trace), .oled_lm(oled_lm), .oled_stopwatch(oled_stopwatch), 
    .an(an), .seg(seg), .oled_data(oled_data), .led(led), .curr_layer(curr_layer));
    
    trace_tgt fa7(clk6p25m, clk1k,mic_in, debU, debD, debL, debR, debC, pbu,pbd,pbl,pbr,curr_layer, sw[0],sw[14], x, y, oled_trace, pixel_index);

    Oled_Display OLED (clk6p25m, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen, pmoden);
              
endmodule