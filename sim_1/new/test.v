`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2022 14:59:57
// Design Name: 
// Module Name: test_LED
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


module test();
    reg J_MIC3_Pin3;
    reg CLOCK; 
    reg[31:0]m;
    reg SW0;
    wire CLOCK2k;
    wire J_MIC3_Pin1;
    wire J_MIC3_Pin4;
    wire [11:0] led;
    Top_Student fa0 (J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, CLOCK, led, SW0);
    initial begin
            CLOCK = 0;
            m = 249;
            SW0 = 1;
    end
    always begin
        #5 CLOCK = ~CLOCK;
    end
endmodule
