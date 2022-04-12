`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2022 09:41:20
// Design Name: 
// Module Name: twentyfive_MHz
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


module twentyfive_MHz(input CLOCK, output reg COUNT2k = 0, input[31:0] m);
    reg [31:0]COUNT = 0;
    always @ (posedge CLOCK) begin 
            COUNT <= (COUNT == m)? 0 : COUNT + 1;  //2499
            COUNT2k <= (COUNT == 0) ? ~COUNT2k : COUNT2k;
    end
endmodule
