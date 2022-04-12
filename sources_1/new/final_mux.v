`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 10:49:52 PM
// Design Name: 
// Module Name: final_mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module final_mux(
    input clk,
    input [3:0] state,
    input [3:0] an_lab, an_map,
    input [15:0] led_lab, 
    input [7:0] seg_lab, seg_map,
    input [15:0] oled_lab, oled_menu, oled_distance, oled_trace, oled_lm, oled_stopwatch,
    output reg [3:0] an,
    output reg [7:0] seg,
    output reg [15:0] oled_data, led,
    output reg [3:0] curr_layer
    );
    
    always @ (posedge clk) begin
        case (state)
        // Menu
        0: begin
            led <= 0;
            an <= 4'b1111;
            seg <= 8'b11111111;
            oled_data <= oled_menu;
            curr_layer <= 0;
        end
        // Distance Finder
        1: begin
            led <= 0;
            an <= an_map;
            seg <= seg_map;
            oled_data <= oled_distance;
            curr_layer <= 1;
        end
        // Trace together
        2: begin
            led <= 0;
            an <= 4'b1111;
            seg <= 8'b11111111;
            oled_data <= oled_trace;
            curr_layer <= 2;
        end
        // Landmarks
        3: begin
            led <= 0;
            an <= 4'b1111;
            seg <= 8'b11111111;
            oled_data <= oled_lm;
            curr_layer <= 3;
        end
        // Lab Task
        4: begin
            led <= led_lab;
            an <= an_lab;
            seg <= seg_lab;
            oled_data <= oled_lab;
            curr_layer <= 4;
        end
        //stopwatch
        5: begin
            led <= 0;
            an <= 4'b1111;
            seg <= 8'b11111111;
            oled_data <= oled_stopwatch;
            curr_layer <= 5;
        end
        endcase
    end
            
endmodule