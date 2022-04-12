`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2020 08:28:16 PM
// Design Name: 
// Module Name: changestate
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


module aftermenu( //change state
    input clk, pbc, pbl, pbr, sw14,
    input [3:0] layer, menu_flag, // menu flag
    output reg [3:0] state
    );
    reg [31:0] COUNT = 0;
    always @ (posedge clk) begin
        if (sw14) begin
            COUNT <= COUNT + 1; 
            if (COUNT > 2000) begin
                state <= 0;
                COUNT <= 0;
            end
        end
        else begin
          if (pbc && layer == 0) 
            state <= menu_flag;
//          else if (pbr && menu_flag == 0 && layer == 0) //enter lab task
//            state <= 4;
          else 
            state <= state;
        end
    end
endmodule