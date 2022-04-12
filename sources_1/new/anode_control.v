`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2022 01:15:02
// Design Name: 
// Module Name: anode_control
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


module anode_control(input [1:0] counter, output reg [3:0] anode);
    always @ (counter) begin
        case (counter) 
            0: 
                anode = 4'b1110;
            1: 
                anode = 4'b1101;
            2: 
                anode = 4'b1011;
//            3: 
//                anode = 4'b0111;
        endcase
    end
endmodule
