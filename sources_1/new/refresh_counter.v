`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2022 01:12:03
// Design Name: 
// Module Name: refresh_counter
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


module refresh_counter(input CLOCK, output reg [1:0] counter = 0);
    always @ (posedge CLOCK) begin
        if (counter == 2) counter <= 0;
        else counter <= counter + 1;
    end
endmodule
