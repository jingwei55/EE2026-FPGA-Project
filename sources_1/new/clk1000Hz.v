`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2022 09:22:14
// Design Name: 
// Module Name: my_clock_module
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


module clk1000Hz(input CLOCK, output reg COUNT2k = 0, input[31:0] m);
    reg [31:0]COUNT = 0;
    always @ (posedge CLOCK) begin 
            COUNT <= (COUNT == m)? 0 : COUNT + 1;  //2499
            COUNT2k <= (COUNT == 0) ? ~COUNT2k : COUNT2k;
    end
endmodule
