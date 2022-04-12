`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2022 17:02:23
// Design Name: 
// Module Name: cal_dist
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


module cal_dist(input CLOCK, input [6:0] set_x1, set_y1, set_x2, set_y2, output reg [13:0] distance);
    wire [6:0] x, y;
    wire [13:0] dist;
    reg [13:0] root, square;
    reg [13:0]approx = 1;
    reg [31:0] COUNT = 0;

        assign x = (set_x1 > set_x2) ? set_x1 - set_x2 : set_x2 - set_x1;
        assign y = (set_y1 > set_y2) ? set_y1 - set_y2 : set_y2 - set_y1;
        assign dist = x*x + y*y;
    
    always @(posedge CLOCK) begin
        if (!(set_x1 && set_y1 && set_x2 && set_y2)) begin 
        square <= approx * approx;
        if (square < dist) approx <= approx + 1;
        else distance <= approx;
        end
    end
//        if (COUNT == 0) begin
////            x <= (set_x1 > set_x2) ? set_x1 - set_x2 : set_x2 - set_x1;
////            y <= (set_y1 > set_y2) ? set_y1 - set_y2 : set_y2 - set_y1;
////            dist <= x*x + y*y;
////            a <= dist;
////            abs <= 1; 
////            COUNT <= COUNT + 1;
////        end
////        else if (COUNT > 0 && abs > 0)  begin
////              root = ( a + (dist/a) ) / 2;
////              abs = (root > a) ? root - a : a - root; 
////              a = root;
////              COUNT <= COUNT + 1;
////        end
////        else begin
////            distance <= root;
////            COUNT <= 0;
////        end
//    end
endmodule
