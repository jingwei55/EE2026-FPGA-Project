`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2022 01:18:06
// Design Name: 
// Module Name: seg_disp
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


module seg_disp( input [3:0] one, ten, hun, input [1:0] counter, output reg [3:0] digit);
    always @ (counter) begin
        case (counter) 
            0: 
                digit = one;
            1: 
                digit = ten;
            2: 
                digit = hun;
//            3: 
//                digit = thou;
        endcase
    end
endmodule
