`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2022 23:38:30
// Design Name: 
// Module Name: disp_dist
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


module disp_dist( input clk50, input [13:0] distance, output reg [7:0] seg_map, output wire [3:0] an_map);
    wire [1:0] counter;
    wire [3:0] one, ten, hun, digit;
    refresh_counter fa01 (clk50, counter);
    anode_control fa02 (counter, an_map);
    seg_disp fa03 (one, ten, hun, counter, digit);
    
    assign one = distance % 10;
    assign ten = (distance/10) % 10;
    assign hun = (distance/100) % 10;
    //assign thou = (distance/1000) % 10;

    always @ (digit) begin
        case (digit)
            0: begin
                seg_map <= 8'b11000000;
            end
            1: begin
                seg_map <= 8'b11111001;
            end
            2: begin
                seg_map <= 8'b10100100;
            end
            3: begin
                seg_map <= 8'b10110000;
            end
            4: begin
                seg_map <= 8'b10011001;
            end
            5: begin
                seg_map <= 8'b10010010;
            end
            6: begin

                seg_map <= 8'b10000010;
            end
            7: begin
                seg_map <= 8'b11111000;
            end
            8: begin;
                seg_map <= 8'b10000000;
            end
            9: begin
                seg_map <= 8'b10010000;
            end
            default: begin
                seg_map <= 8'b11000000;
            end
        endcase
    end

endmodule
