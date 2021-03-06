`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2022 22:14:30
// Design Name: 
// Module Name: boundary
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


module boundary_u2( input clk50, input [6:0] x, y, output reg map);
    parameter [31:0] a = 4; 
    always @ (posedge clk50) begin
        map <= (y==a && (x>= 45 && x<=53)) || (y==a+1 && (x>= 44 && x<=54)) || (y==a+2 && (x>= 41 && x<=55)) || (y==a+3 && (x>= 41 && x<=55)) || (y==a+4 && ((x>= 28 && x<=31)||(x>=39 && x<=57)))
            || (y==a+5 && ((x>= 28 && x<=31)||(x>= 39 && x<=57))) || (y==a+6 && ((x>= 25 && x<=32)||(x>= 39 && x<=58))) || (y==a+7 && ((x>= 24 && x<=32)||(x>= 37 && x<=58))) || (y==a+8 && (x>= 23 && x<=57))
            || (y==a+9 && ((x>= 21 && x<=57)||(x>=60 && x<=63))) 
            || (y==a+10 && ((x>= 19 && x<=55)||(x>= 59 && x<=63)||(x>= 72 && x<=76))) 
            || (y==a+11 && ((x>= 19 && x<=55)||(x>= 59 && x<=63)||(x==65)||(x>= 72 && x<=76))) 
            || (y==a+12 && ((x>= 19 && x<=53)||(x>= 57 && x<=65)||(x>=67 && x<=68)||(x>= 73 && x<=81)))                
            || (y==a+13 && ((x>= 19 && x<=51)||(x>= 56 && x<=65)||(x>=67 && x<=68)||(x>= 77 && x<=83))) 
            || (y==a+14 && ((x>= 18 && x<=51)||(x>= 53 && x<=69)||(x>= 78 && x<=81)))
            || (y==a+15 && ((x>= 18 && x<=49)||(x>= 53 && x<=69)||(x>= 78 && x<=81))) || (y==a+16 && (x>= 17 && x<=72)) || (y==a+17 && ((x>= 17 && x<=73)||(x>=83 && x<=85))) || (y==a+18 && ((x>= 17 && x<=73)||(x>=83 && x<=85))) 
            || (y==a+19 && ((x>= 17 && x<=75)||(x>=82 && x<=89))) || (y==a+20 && ((x>= 16 && x<=77)||(x>=80 && x<=88))) || (y==a+21 && (x>= 16 && x<=89)) || (y==a+22 && (x>= 16 && x<=89)) || (y==a+23 && (x>= 13 && x<=88)) 
            || (y==a+24 && (x>= 13 && x<=88)) || (y==a+25 && (x>= 12 && x<=89)) || (y==a+26 && (x>= 12 && x<=89)) || (y==a+27 && (x>= 11 && x<=89)) || (y==a+28 && (x>= 11 && x<=89)) || (y==a+29 && (x>= 11 && x<=89)) || (y==a+30 && (x>= 11 && x<=88)) || (y==a+31 && (x>= 10 && x<=88)) || (y==a+32 && (x>= 10 && x<=88)) || (y==a+33 && (x>= 10 && x<=87)) || (y==a+34 && (x>= 10 && x<=87)) || (y==a+35 && (x>= 10 && x<=90)) 
            || (y==a+36 && (x>= 9 && x<=91)) || (y==a+37 && ((x>= 9 && x<=10)||(x>=13 && x<=77))) || (y==a+38 && ((x>= 9 && x<=10)||(x>=16 && x<=24)||(x>=30 && x<=71))) || (y==a+39 && ((x>= 8 && x<=11)||(x>=16 && x<=18)||(x>=34 && x<=67))) || (y==a+40 && ((x>= 8 && x<=11)||(x>=16 && x<=18)||(x>=34 && x<=67))) || (y==a+41 && ((x>= 8 && x<=12)||(x>=16 && x<=18)||(x>=27 && x<=29)||(x>=37 && x<=65))) || (y==a+42 && ((x>= 8 && x<=12)||(x>=24 && x<=29)||(x>=39 && x<=63))) 
            || (y==a+43 && ((x>= 9 && x<=12)||(x>=24 && x<=30)||(x>=35 && x<=38)||(x>=40 && x<=60))) || (y==a+44 && ((x>= 9 && x<=12)||(x>=24 && x<=30)||(x>=35 && x<=38)||(x>=40 && x<=60))) || (y==a+45 && ((x>= 19 && x<=20)||(x>=23 && x<=33)||(x>=36 && x<=39)||(x>=42 && x<=59))) || (y==a+46 && ((x>= 18 && x<=21)||(x>=23 && x<=29)||(x==32)||(x>=37 && x<=39)||(x>=45 && x<=58))) || (y==a+47 && ((x>= 18 && x<=21)||(x>=23 && x<=29)||(x==32)||(x>=37 && x<=39)||(x>=45 && x<=58))) 
            || (y==a+48 && ((x>= 17 && x<=26)||(x>=28 && x<=30)||(x>=46 && x<=54))) || (y==a+49 && ((x>= 16 && x<=24)||(x>=49 && x<=50))) || (y==a+50 && ((x>= 17 && x<=22)||(x>=24 && x<=26)||(x>=47 && x<=50)||(x>=52 && x<=54))) || (y==a+51 && ((x>= 17 && x<=21)||(x>=48 && x<=55))) || (y==a+52 && ((x>= 18 && x<=20)||(x>=51 && x<=54)))
            || (y==a+53 && ((x>= 18 && x<=20)||(x>=51 && x<=54))) || (y==a+54 && ((x>= 18 && x<=20)||(x==52))) || (y==a+55 && ((x>= 18 && x<=20)||(x==52)));
    end
endmodule
