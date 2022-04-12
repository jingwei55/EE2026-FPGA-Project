`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2022 14:30:15
// Design Name:
// Module Name: stopwatch
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


module stopwatch(input CLOCK, clk50, input SW1, SW0, SW2, SW3, SW4, input [3:0] layer, input [31:0] x, y, output reg [15:0] oled_data); 
    parameter [6:0] a = 62;  
    parameter [6:0] b = 24;
    parameter [6:0] c = 48;
    parameter [6:0] d = 30;
    wire stopwatch, one, two, three, four, five, six, seven, eight, nine, zero, 
        zero1, one1, two1, three1, four1, five1, six1, 
        zero2, one2, two2, three2, four2, five2, 
        vert, vert2, colon1;
    reg [300:0] state;
    reg [31:0] COUNT = 0;
    wire [15:0] timer [300:0];
    
    assign vert2 = (y >=7 && y <=13);
    assign stopwatch = (x == b && (y==8 || y==9||y==12)) || (x == b+1 && (y==7 || y==10||y==13)) || (x == b+2 && (y==7 || y==10||y==13)) || (x == b+3 && (y==7 || y==10||y==13)) || (x == b+4 && (y==8 || y==11||y==12))
                    || (x==b+6 && y==7) || (x==b+7 && y==7) || (x==b+8 && vert2) || (x==b+9 && y==7) || (x==b+10 && y==7)
                    || (x==b+12 && (y>= 8 && y<= 12)) || (x == b+13 && (y==7||y==13)) || (x == b+14 && (y==7||y==13)) || (x == b+15 && (y==7||y==13)) || (x==b+16 && (y>= 8 && y<= 12))
                    || (x==b+18 && vert2) || (x == b+19 && (y==7||y==10)) || (x == b+20 && (y==7||y==10)) || (x == b+21 && (y==7||y==10)) || (x == b+22 && (y==8||y==9))
                    || (x==b+24 && (y >=7 && y <=12)) || (x==b+25 && y==13) || (x == b+26 && (y==11||y==12)) || (x==b+27 && y==13)  || (x==b+28 && (y >=7 && y <=12))
                    || (x==b+30 && (y >=9 && y <=12)) || (x == b+31 && (y==8||y==11)) || (x == b+32 && (y==7||y==11)) || (x == b+33 && (y==8||y==11)) || (x==b+34 && (y >=9 && y <=12))
                    || (x==b+36 && y==7) || (x==b+37 && y==7) || (x==b+38 && vert2) || (x==b+39 && y==7) || (x==b+40 && y==7)
                    || (x==b+42 && (y >=8 && y <=12)) || (x == b+43 && (y==7||y==13)) || (x == b+44 && (y==7||y==13)) || (x == b+45 && (y==7||y==13)) || (x == b+46 && (y==8||y==12))
                    || (x==b+48 && vert2) || (x==b+49 && y==10) || (x==b+50 && y==10) || (x==b+51 && y==10) || (x==b+52 && vert2)
                    || ((x >=23 && x<=77) && y ==15);

                    
                    
    assign vert = (y >= 24 && y <= 37);
    assign colon1 = ((x==43 || x == 44) && (y==27 || y==28 || y==33 || y==34));
    
    assign zero = ((x == a || x == a+1) && (y >= 26 && y <= 35)) || ((x >= a+2 && x <= a+7) && (y == 24 || y == 25 || y == 36 || y == 37)) || ((x == a+8 || x == a+9) && (y >= 26 && y <= 35));
    assign one = ((x >= a && x <= a+3) && (y == 27 || y == 26 || y == 37 || y == 36)) || ((x == a+4 || x == a+5) && vert) || ((x >= a+6 && x <= a+9) && (y == 36 || y==37));
    assign two = ((x == a || x==a+1) && (y == 27 || y == 26 || (y >= 34 && y <= 37))) || ((x == a+2 || x==a+3) && (y == 24 || y == 25 || y == 32 || y == 33 || y == 36 || y == 37)) || ((x == a+4 || x==a+5) && (y == 24 || y == 25 || y == 30 || y == 31 || y == 36 || y == 37)) || ((x == a+6 || x==a+7) && (y == 24 || y == 25 || y == 28 || y == 29 || y == 36 || y == 37)) || ((x == a+8 || x==a+9) && (y == 26 || y == 27 || y == 36 || y == 37));
    assign three = ((x == a || x == a+1) && (y == 26 || y == 27 || y == 34 || y == 35)) || ((x == a+2 || x == a+3) && (y == 24 || y == 25 || y == 36 || y == 37)) || ((x == a+4 || x == a+5) && (y == 24 || y == 25 || y == 36 || y == 37 || y == 30 || y == 31)) || ((x == a+6 || x == a+7) && (y == 24 || y == 25 || y == 36 || y == 37 || y == 30 || y == 31)) || ((x == a+8 || x == a+9) && (y == 26 || y == 27 || y == 28 || y == 29 || y == 35 || y == 32 || y == 33 || y == 34));
    assign four = ((x==a || x ==a+1) && (y>=24 && y<=33)) || ((x>=a+2 && x <= a+5) && (y==32 || y==33)) || ((x==a+6 || x ==a+7) && (y>=26 && y<=37)) || ((x==a+8 || x ==a+9) && (y==33 || y==32));
    assign five = ((x==a || x ==a+1) && ((y>=24 && y<=31) || y == 36 || y ==37)) || ((x>=a+2 && x <=a+7) && (y==24 || y==25 || y==30 || y==31 || y==36 ||y==37)) || ((x==a+8 || x ==a+9) && (y==24 || y==25 || y==32 || y==33 || y==34 ||y==35));
    assign six = ((x==a || x ==a+1) && (y>=26 && y<=35)) || ((x>=a+2 && x <=a+7) && (y==24 || y==25 || y==30 || y==31 || y==36 ||y==37)) || ((x==a+8 || x ==a+9) && (y==24 || y==25 || y==32 || y==33 || y==34 ||y==35));
    assign seven = ((x>=a && x <=a+3) && (y==24 || y==25)) || ((x==a+4 || x ==a+5) && ((y>= 30 && y<=37) || y==24 || y==25)) || ((x==a+6 || x ==a+7) && (y== 28 || y==29 || y==24 || y==25)) || ((x==a+8 || x ==a+9) && (y== 26 || y==27 || y==24 || y==25));
    assign eight = ((x==a || x ==a+1) && ((y>=26 && y<=29) || (y>=32 && y<=35))) || ((x==a+8 || x ==a+9) && ((y>=26 && y<=29) || (y>=32 && y<=35))) || ((x>=a+2 && x <=a+7) && (y==24 || y==25 || y==30 || y==31 || y==36 || y==37));
    assign nine = ((x==a || x ==a+1) && (y>=26 && y<=29)) || ((x==a+8 || x ==a+9) && ((y>=26 && y<=29) || (y>=32 && y<=35))) || ((x>=a+2 && x <=a+7) && (y==24 || y==25 || y==30 || y==31 || y==36 || y==37));

    assign zero1 = ((x == c || x == c+1) && (y >= 26 && y <= 35)) || ((x >= c+2 && x <= c+7) && (y == 24 || y == 25 || y == 36 || y == 37)) || ((x == c+8 || x == c+9) && (y >= 26 && y <= 35));
    assign one1 = ((x >= c && x <= c+3) && (y == 27 || y == 26 || y == 37 || y == 36)) || ((x == c+4 || x == c+5) && vert) || ((x >= c+6 && x <= c+9) && (y == 36 || y==37));
    assign two1 = ((x == c || x==c+1) && (y == 27 || y == 26 || (y >= 34 && y <= 37))) || ((x == c+2 || x==c+3) && (y == 24 || y == 25 || y == 32 || y == 33 || y == 36 || y == 37)) || ((x == c+4 || x==c+5) && (y == 24 || y == 25 || y == 30 || y == 31 || y == 36 || y == 37)) || ((x == c+6 || x==c+7) && (y == 24 || y == 25 || y == 28 || y == 29 || y == 36 || y == 37)) || ((x == c+8 || x==c+9) && (y == 26 || y == 27 || y == 36 || y == 37));
    assign three1 = ((x == c || x == c+1) && (y == 26 || y == 27 || y == 34 || y == 35)) || ((x == c+2 || x == c+3) && (y == 24 || y == 25 || y == 36 || y == 37)) || ((x == c+4 || x == c+5) && (y == 24 || y == 25 || y == 36 || y == 37 || y == 30 || y == 31)) || ((x == c+6 || x == c+7) && (y == 24 || y == 25 || y == 36 || y == 37 || y == 30 || y == 31)) || ((x == c+8 || x == c+9) && (y == 26 || y == 27 || y == 28 || y == 29 || y == 35 || y == 32 || y == 33 || y == 34));
    assign four1 = ((x==c || x ==c+1) && (y>=24 && y<=33)) || ((x>=c+2 && x <= c+5) && (y==32 || y==33)) || ((x==c+6 || x ==c+7) && (y>=26 && y<=37)) || ((x==c+8 || x ==c+9) && (y==33 || y==32));
    assign five1 = ((x==c || x ==c+1) && ((y>=24 && y<=31) || y == 36 || y ==37)) || ((x>=c+2 && x <=c+7) && (y==24 || y==25 || y==30 || y==31 || y==36 ||y==37)) || ((x==c+8 || x ==c+9) && (y==24 || y==25 || y==32 || y==33 || y==34 ||y==35));
    assign six1 = ((x==c || x ==c+1) && (y>=26 && y<=35)) || ((x>=c+2 && x <=c+7) && (y==24 || y==25 || y==30 || y==31 || y==36 ||y==37)) || ((x==c+8 || x ==c+9) && (y==24 || y==25 || y==32 || y==33 || y==34 ||y==35));
    
    assign zero2 = ((x == d || x == d+1) && (y >= 26 && y <= 35)) || ((x >= d+2 && x <= d+7) && (y == 24 || y == 25 || y == 36 || y == 37)) || ((x == d+8 || x == d+9) && (y >= 26 && y <= 35));
    assign one2 = ((x >= d && x <= d+3) && (y == 27 || y == 26 || y == 37 || y == 36)) || ((x == d+4 || x == d+5) && vert) || ((x >= d+6 && x <= d+9) && (y == 36 || y==37));
    assign two2 = ((x == d || x==d+1) && (y == 27 || y == 26 || (y >= 34 && y <= 37))) || ((x == d+2 || x==d+3) && (y == 24 || y == 25 || y == 32 || y == 33 || y == 36 || y == 37)) || ((x == d+4 || x==d+5) && (y == 24 || y == 25 || y == 30 || y == 31 || y == 36 || y == 37)) || ((x == d+6 || x==d+7) && (y == 24 || y == 25 || y == 28 || y == 29 || y == 36 || y == 37)) || ((x == d+8 || x==d+9) && (y == 26 || y == 27 || y == 36 || y == 37));
    assign three2 = ((x == d || x == d+1) && (y == 26 || y == 27 || y == 34 || y == 35)) || ((x == d+2 || x == d+3) && (y == 24 || y == 25 || y == 36 || y == 37)) || ((x == d+4 || x == d+5) && (y == 24 || y == 25 || y == 36 || y == 37 || y == 30 || y == 31)) || ((x == d+6 || x == d+7) && (y == 24 || y == 25 || y == 36 || y == 37 || y == 30 || y == 31)) || ((x == d+8 || x == d+9) && (y == 26 || y == 27 || y == 28 || y == 29 || y == 35 || y == 32 || y == 33 || y == 34));
    assign four2 = ((x==d || x ==d+1) && (y>=24 && y<=33)) || ((x>=d+2 && x <= d+5) && (y==32 || y==33)) || ((x==d+6 || x ==d+7) && (y>=26 && y<=37)) || ((x==d+8 || x ==d+9) && (y==33 || y==32));
    assign five2 = ((x==d || x ==d+1) && ((y>=24 && y<=31) || y == 36 || y ==37)) || ((x>=d+2 && x <=d+7) && (y==24 || y==25 || y==30 || y==31 || y==36 ||y==37)) || ((x==d+8 || x ==d+9) && (y==24 || y==25 || y==32 || y==33 || y==34 ||y==35));
        
                 
    assign timer[0] = zero || colon1 || zero1 || zero2 || stopwatch;
    assign timer[1] = one || colon1 || zero1 || zero2 || stopwatch;
    assign timer[2] = two || colon1 || zero1 || zero2 || stopwatch;
    assign timer[3] = three || colon1 || zero1 || zero2 || stopwatch;
    assign timer[4] = four || colon1 || zero1 || zero2 || stopwatch;
    assign timer[5] = five || colon1 || zero1 || zero2 || stopwatch;
    assign timer[6] = six || colon1 || zero1 || zero2 || stopwatch;
    assign timer[7] = seven || colon1 || zero1 || zero2 || stopwatch;
    assign timer[8] = eight || colon1 || zero1 || zero2 || stopwatch;
    assign timer[9] = nine || colon1 || zero1 || zero2 || stopwatch;
    
    assign timer[10] = zero || colon1 || one1 || zero2 || stopwatch;
    assign timer[11] = one || colon1 || one1 || zero2 || stopwatch;
    assign timer[12] = two || colon1 || one1 || zero2 || stopwatch;
    assign timer[13] = three || colon1 || one1 || zero2 || stopwatch;
    assign timer[14] = four || colon1 || one1 || zero2 || stopwatch;
    assign timer[15] = five || colon1 || one1 || zero2 || stopwatch;
    assign timer[16] = six || colon1 || one1 || zero2 || stopwatch;
    assign timer[17] = seven || colon1 || one1 || zero2 || stopwatch;
    assign timer[18] = eight || colon1 || one1 || zero2 || stopwatch;
    assign timer[19] = nine || colon1 || one1 || zero2 || stopwatch;
     
    assign timer[20] = zero || colon1 || two1 || zero2 || stopwatch;
    assign timer[21] = one || colon1 || two1 || zero2 || stopwatch;
    assign timer[22] = two || colon1 || two1 || zero2 || stopwatch;
    assign timer[23] = three || colon1 || two1 || zero2 || stopwatch;
    assign timer[24] = four || colon1 || two1 || zero2 || stopwatch;
    assign timer[25] = five || colon1 || two1 || zero2 || stopwatch;
    assign timer[26] = six || colon1 || two1 || zero2 || stopwatch;
    assign timer[27] = seven || colon1 || two1 || zero2 || stopwatch;
    assign timer[28] = eight || colon1 || two1 || zero2 || stopwatch;
    assign timer[29] = nine || colon1 || two1 || zero2 || stopwatch;
    
    assign timer[30] = zero || colon1 || three1 || zero2 || stopwatch;
    assign timer[31] = one || colon1 || three1 || zero2 || stopwatch;
    assign timer[32] = two || colon1 || three1 || zero2 || stopwatch;
    assign timer[33] = three || colon1 || three1 || zero2 || stopwatch;
    assign timer[34] = four || colon1 || three1 || zero2 || stopwatch;
    assign timer[35] = five || colon1 || three1 || zero2 || stopwatch;
    assign timer[36] = six || colon1 || three1 || zero2 || stopwatch;
    assign timer[37] = seven || colon1 || three1 || zero2 || stopwatch;
    assign timer[38] = eight || colon1 || three1 || zero2 || stopwatch;
    assign timer[39] = nine || colon1 || three1 || zero2 || stopwatch;
    
    assign timer[40] = zero || colon1 || four1 || zero2 || stopwatch;
    assign timer[41] = one || colon1 || four1 || zero2 || stopwatch;
    assign timer[42] = two || colon1 || four1 || zero2 || stopwatch;
    assign timer[43] = three || colon1 || four1 || zero2 || stopwatch;
    assign timer[44] = four || colon1 || four1 || zero2 || stopwatch;
    assign timer[45] = five || colon1 || four1 || zero2 || stopwatch;
    assign timer[46] = six || colon1 || four1 || zero2 || stopwatch;
    assign timer[47] = seven || colon1 || four1 || zero2 || stopwatch;
    assign timer[48] = eight || colon1 || four1 || zero2 || stopwatch;
    assign timer[49] = nine || colon1 || four1 || zero2 || stopwatch;
    
    assign timer[50] = zero || colon1 || five1 || zero2 || stopwatch;
    assign timer[51] = one || colon1 || five1 || zero2 || stopwatch;
    assign timer[52] = two || colon1 || five1 || zero2 || stopwatch;
    assign timer[53] = three || colon1 || five1 || zero2 || stopwatch;
    assign timer[54] = four || colon1 || five1 || zero2 || stopwatch; 
    assign timer[55] = five || colon1 || five1 || zero2 || stopwatch;
    assign timer[56] = six || colon1 || five1 || zero2 || stopwatch;
    assign timer[57] = seven || colon1 || five1 || zero2 || stopwatch;
    assign timer[58] = eight || colon1 || five1 || zero2 || stopwatch;
    assign timer[59] = nine || colon1 || five1 || zero2 || stopwatch;
    
    assign timer[60] = zero || colon1 || zero1 || one2 || stopwatch;
    assign timer[61] = one || colon1 || zero1 || one2 || stopwatch;
    assign timer[62] = two || colon1 || zero1 || one2 || stopwatch;
    assign timer[63] = three || colon1 || zero1 || one2 || stopwatch;
    assign timer[64] = four || colon1 || zero1 || one2 || stopwatch;
    assign timer[65] = five || colon1 || zero1 || one2 || stopwatch;
    assign timer[66] = six || colon1 || zero1 || one2 || stopwatch;
    assign timer[67] = seven || colon1 || zero1 || one2 || stopwatch;
    assign timer[68] = eight || colon1 || zero1 || one2 || stopwatch;
    assign timer[69] = nine || colon1 || zero1 || one2 || stopwatch;
    
    assign timer[70] = zero || colon1 || one1 || one2 || stopwatch;
    assign timer[71] = one || colon1 || one1 || one2 || stopwatch;
    assign timer[72] = two || colon1 || one1 || one2 || stopwatch;
    assign timer[73] = three || colon1 || one1 || one2 || stopwatch;
    assign timer[74] = four || colon1 || one1 || one2 || stopwatch;
    assign timer[75] = five || colon1 || one1 || one2 || stopwatch;
    assign timer[76] = six || colon1 || one1 || one2 || stopwatch;
    assign timer[77] = seven || colon1 || one1 || one2 || stopwatch;
    assign timer[78] = eight || colon1 || one1 || one2 || stopwatch;
    assign timer[79] = nine || colon1 || one1 || one2 || stopwatch;
     
    assign timer[80] = zero || colon1 || two1 || one2 || stopwatch;
    assign timer[81] = one || colon1 || two1 || one2 || stopwatch;
    assign timer[82] = two || colon1 || two1 || one2 || stopwatch;
    assign timer[83] = three || colon1 || two1 || one2 || stopwatch;
    assign timer[84] = four || colon1 || two1 || one2 || stopwatch;
    assign timer[85] = five || colon1 || two1 || one2 || stopwatch;
    assign timer[86] = six || colon1 || two1 || one2 || stopwatch;
    assign timer[87] = seven || colon1 || two1 || one2 || stopwatch;
    assign timer[88] = eight || colon1 || two1 || one2 || stopwatch;
    assign timer[89] = nine || colon1 || two1 || one2 || stopwatch;
    
    assign timer[90] = zero || colon1 || three1 || one2 || stopwatch;
    assign timer[91] = one || colon1 || three1 || one2 || stopwatch;
    assign timer[92] = two || colon1 || three1 || one2 || stopwatch;
    assign timer[93] = three || colon1 || three1 || one2 || stopwatch;
    assign timer[94] = four || colon1 || three1 || one2 || stopwatch;
    assign timer[95] = five || colon1 || three1 || one2 || stopwatch;
    assign timer[96] = six || colon1 || three1 || one2 || stopwatch;
    assign timer[97] = seven || colon1 || three1 || one2 || stopwatch;
    assign timer[98] = eight || colon1 || three1 || one2 || stopwatch;
    assign timer[99] = nine || colon1 || three1 || one2|| stopwatch;
    
    assign timer[100] = zero || colon1 || four1 || one2|| stopwatch;
    assign timer[101] = one || colon1 || four1 || one2|| stopwatch;
    assign timer[102] = two || colon1 || four1 || one2|| stopwatch;
    assign timer[103] = three || colon1 || four1 || one2|| stopwatch;
    assign timer[104] = four || colon1 || four1 || one2|| stopwatch;
    assign timer[105] = five || colon1 || four1 || one2|| stopwatch;
    assign timer[106] = six || colon1 || four1 || one2|| stopwatch;
    assign timer[107] = seven || colon1 || four1 || one2|| stopwatch;
    assign timer[108] = eight || colon1 || four1 || one2|| stopwatch;
    assign timer[109] = nine || colon1 || four1 || one2|| stopwatch;
    
    assign timer[110] = zero || colon1 || five1 || one2|| stopwatch;
    assign timer[111] = one || colon1 || five1 || one2|| stopwatch;
    assign timer[112] = two || colon1 || five1 || one2|| stopwatch;
    assign timer[113] = three || colon1 || five1 || one2|| stopwatch;
    assign timer[114] = four || colon1 || five1 || one2|| stopwatch;
    assign timer[115] = five || colon1 || five1 || one2|| stopwatch;
    assign timer[116] = six || colon1 || five1 || one2|| stopwatch;
    assign timer[117] = seven || colon1 || five1 || one2|| stopwatch;
    assign timer[118] = eight || colon1 || five1 || one2|| stopwatch;
    assign timer[119] = nine || colon1 || five1 || one2|| stopwatch;
    
    assign timer[120] = zero || colon1 || zero1 || two2 || stopwatch;
    assign timer[121] = one || colon1 || zero1 || two2|| stopwatch;
    assign timer[122] = two || colon1 || zero1 || two2|| stopwatch;
    assign timer[123] = three || colon1 || zero1 || two2|| stopwatch;
    assign timer[124] = four || colon1 || zero1 || two2|| stopwatch;
    assign timer[125] = five || colon1 || zero1 || two2|| stopwatch;
    assign timer[126] = six || colon1 || zero1 || two2|| stopwatch;
    assign timer[127] = seven || colon1 || zero1 || two2|| stopwatch;
    assign timer[128] = eight || colon1 || zero1 || two2|| stopwatch;
    assign timer[129] = nine || colon1 || zero1 || two2|| stopwatch;
    
    assign timer[130] = zero || colon1 || one1 || two2|| stopwatch;
    assign timer[131] = one || colon1 || one1 || two2|| stopwatch;
    assign timer[132] = two || colon1 || one1 || two2|| stopwatch;
    assign timer[133] = three || colon1 || one1 || two2|| stopwatch;
    assign timer[134] = four || colon1 || one1 || two2|| stopwatch;
    assign timer[135] = five || colon1 || one1 || two2|| stopwatch;
    assign timer[136] = six || colon1 || one1 || two2|| stopwatch;
    assign timer[137] = seven || colon1 || one1 || two2|| stopwatch;
    assign timer[138] = eight || colon1 || one1 || two2|| stopwatch;
    assign timer[139] = nine || colon1 || one1 || two2|| stopwatch;
    
    assign timer[140] = zero || colon1 || two1 || two2|| stopwatch;
    assign timer[141] = one || colon1 || two1 || two2|| stopwatch;
    assign timer[142] = two || colon1 || two1 || two2|| stopwatch;
    assign timer[143] = three || colon1 || two1 || two2|| stopwatch;
    assign timer[144] = four || colon1 || two1 || two2|| stopwatch;
    assign timer[145] = five || colon1 || two1 || two2|| stopwatch;
    assign timer[146] = six || colon1 || two1 || two2|| stopwatch;
    assign timer[147] = seven || colon1 || two1 || two2|| stopwatch;
    assign timer[148] = eight || colon1 || two1 || two2|| stopwatch;
    assign timer[149] = nine || colon1 || two1 || two2|| stopwatch;
    
    assign timer[150] = zero || colon1 || three1 || two2|| stopwatch;
    assign timer[151] = one || colon1 || three1 || two2|| stopwatch;
    assign timer[152] = two || colon1 || three1 || two2|| stopwatch;
    assign timer[153] = three || colon1 || three1 || two2|| stopwatch;
    assign timer[154] = four || colon1 || three1 || two2|| stopwatch;
    assign timer[155] = five || colon1 || three1 || two2|| stopwatch;
    assign timer[156] = six || colon1 || three1 || two2|| stopwatch;
    assign timer[157] = seven || colon1 || three1 || two2|| stopwatch;
    assign timer[158] = eight || colon1 || three1 || two2|| stopwatch;
    assign timer[159] = nine || colon1 || three1 || two2|| stopwatch;
    
    assign timer[160] = zero || colon1 || four1 || two2|| stopwatch;
    assign timer[161] = one || colon1 || four1 || two2|| stopwatch;
    assign timer[162] = two || colon1 || four1 || two2|| stopwatch;
    assign timer[163] = three || colon1 || four1 || two2|| stopwatch;
    assign timer[164] = four || colon1 || four1 || two2|| stopwatch;
    assign timer[165] = five || colon1 || four1 || two2|| stopwatch;
    assign timer[166] = six || colon1 || four1 || two2|| stopwatch;
    assign timer[167] = seven || colon1 || four1 || two2|| stopwatch;
    assign timer[168] = eight || colon1 || four1 || two2|| stopwatch;
    assign timer[169] = nine || colon1 || four1 || two2|| stopwatch;
    
    assign timer[170] = zero || colon1 || five1 || two2|| stopwatch;
    assign timer[171] = one || colon1 || five1 || two2|| stopwatch;
    assign timer[172] = two || colon1 || five1 || two2|| stopwatch;
    assign timer[173] = three || colon1 || five1 || two2|| stopwatch;
    assign timer[174] = four || colon1 || five1 || two2|| stopwatch;
    assign timer[175] = five || colon1 || five1 || two2|| stopwatch;
    assign timer[176] = six || colon1 || five1 || two2|| stopwatch;
    assign timer[177] = seven || colon1 || five1 || two2|| stopwatch;
    assign timer[178] = eight || colon1 || five1 || two2|| stopwatch;
    assign timer[179] = nine || colon1 || five1 || two2|| stopwatch;
    
    assign timer[180] = zero || colon1 || zero1 || three2|| stopwatch;
    assign timer[181] = one || colon1 || zero1 || three2|| stopwatch;
    assign timer[182] = two || colon1 || zero1 || three2|| stopwatch;
    assign timer[183] = three || colon1 || zero1 || three2|| stopwatch;
    assign timer[184] = four || colon1 || zero1 || three2|| stopwatch;
    assign timer[185] = five || colon1 ||zero1 || three2|| stopwatch;
    assign timer[186] = six || colon1 ||zero1 || three2|| stopwatch;
    assign timer[187] = seven || colon1 || zero1 || three2|| stopwatch;
    assign timer[188] = eight || colon1 || zero1 || three2|| stopwatch;
    assign timer[189] = nine || colon1 || zero1 || three2|| stopwatch;
    
    assign timer[190] = zero || colon1 || one1 || three2|| stopwatch;
    assign timer[191] = one || colon1 || one1 || three2|| stopwatch;
    assign timer[192] = two || colon1 || one1 || three2|| stopwatch;
    assign timer[193] = three || colon1 || one1 || three2|| stopwatch;
    assign timer[194] = four || colon1 || one1 || three2|| stopwatch;
    assign timer[195] = five || colon1 ||one1 || three2|| stopwatch;
    assign timer[196] = six || colon1 ||one1 || three2|| stopwatch;
    assign timer[197] = seven || colon1 || one1 || three2|| stopwatch;
    assign timer[198] = eight || colon1 || one1 || three2|| stopwatch;
    assign timer[199] = nine || colon1 || one1 || three2|| stopwatch;    
    
    assign timer[200] = zero || colon1 || two1 || three2|| stopwatch;
    assign timer[201] = one || colon1 || two1 || three2|| stopwatch;
    assign timer[202] = two || colon1 || two1 || three2|| stopwatch;
    assign timer[203] = three || colon1 || two1 || three2|| stopwatch;
    assign timer[204] = four || colon1 || two1 || three2|| stopwatch;
    assign timer[205] = five || colon1 ||two1 || three2|| stopwatch;
    assign timer[206] = six || colon1 ||two1 || three2|| stopwatch;
    assign timer[207] = seven || colon1 || two1 || three2|| stopwatch;
    assign timer[208] = eight || colon1 || two1 || three2|| stopwatch;
    assign timer[209] = nine || colon1 || two1 || three2|| stopwatch;    
    
    assign timer[210] = zero || colon1 || three1 || three2|| stopwatch;
    assign timer[211] = one || colon1 || three1 || three2|| stopwatch;
    assign timer[212] = two || colon1 || three1 || three2|| stopwatch;
    assign timer[213] = three || colon1 || three1 || three2|| stopwatch;
    assign timer[214] = four || colon1 || three1 || three2|| stopwatch;
    assign timer[215] = five || colon1 || three1 || three2|| stopwatch;
    assign timer[216] = six || colon1 ||three1 || three2|| stopwatch;
    assign timer[217] = seven || colon1 || three1 || three2|| stopwatch;
    assign timer[218] = eight || colon1 || three1 || three2|| stopwatch;
    assign timer[219] = nine || colon1 || three1 || three2|| stopwatch;    
    
    assign timer[220] = zero || colon1 || four1 || three2|| stopwatch;
    assign timer[221] = one || colon1 || four1 || three2|| stopwatch;
    assign timer[222] = two || colon1 || four1 || three2|| stopwatch;
    assign timer[223] = three || colon1 || four1 || three2|| stopwatch;
    assign timer[224] = four || colon1 || four1 || three2|| stopwatch;
    assign timer[225] = five || colon1 || four1 || three2|| stopwatch;
    assign timer[226] = six || colon1 || four1 || three2|| stopwatch;
    assign timer[227] = seven || colon1 || four1 || three2|| stopwatch;
    assign timer[228] = eight || colon1 || four1 || three2|| stopwatch;
    assign timer[229] = nine || colon1 || four1 || three2|| stopwatch;
    
    assign timer[230] = zero || colon1 || five1 || three2|| stopwatch;
    assign timer[231] = one || colon1 || five1 || three2|| stopwatch;
    assign timer[232] = two || colon1 || five1 || three2|| stopwatch;
    assign timer[233] = three || colon1 || five1 || three2|| stopwatch;
    assign timer[234] = four || colon1 || five1 || three2|| stopwatch;
    assign timer[235] = five || colon1 || five1 || three2|| stopwatch;
    assign timer[236] = six || colon1 || five1 || three2|| stopwatch;
    assign timer[237] = seven || colon1 || five1 || three2|| stopwatch;
    assign timer[238] = eight || colon1 || five1 || three2|| stopwatch;
    assign timer[239] = nine || colon1 || five1 || three2|| stopwatch;
    
    assign timer[240] = zero || colon1 || zero1 || four2|| stopwatch;
    assign timer[241] = one || colon1 || zero1 || four2|| stopwatch;
    assign timer[242] = two || colon1 || zero1 || four2|| stopwatch;
    assign timer[243] = three || colon1 || zero1 || four2|| stopwatch;
    assign timer[244] = four || colon1 || zero1 || four2|| stopwatch;
    assign timer[245] = five || colon1 ||zero1 || four2|| stopwatch;
    assign timer[246] = six || colon1 ||zero1 || four2|| stopwatch;
    assign timer[247] = seven || colon1 || zero1 || four2|| stopwatch;
    assign timer[248] = eight || colon1 || zero1 || four2|| stopwatch;
    assign timer[249] = nine || colon1 || zero1 ||four2|| stopwatch;
    
    assign timer[250] = zero || colon1 || one1 || four2|| stopwatch;
    assign timer[251] = one || colon1 || one1 || four2|| stopwatch;
    assign timer[252] = two || colon1 || one1 || four2|| stopwatch;
    assign timer[253] = three || colon1 || one1 || four2|| stopwatch;
    assign timer[254] = four || colon1 || one1 || four2|| stopwatch;
    assign timer[255] = five || colon1 ||one1 || four2|| stopwatch;
    assign timer[256] = six || colon1 ||one1 || four2|| stopwatch;
    assign timer[257] = seven || colon1 || one1 || four2|| stopwatch;
    assign timer[258] = eight || colon1 || one1 ||four2|| stopwatch;
    assign timer[259] = nine || colon1 || one1 || four2|| stopwatch;    
    
    assign timer[260] = zero || colon1 || two1 || four2|| stopwatch;
    assign timer[261] = one || colon1 || two1 || four2|| stopwatch;
    assign timer[262] = two || colon1 || two1 || four2|| stopwatch;
    assign timer[263] = three || colon1 || two1 || four2|| stopwatch;
    assign timer[264] = four || colon1 || two1 || four2|| stopwatch;
    assign timer[265] = five || colon1 ||two1 || four2|| stopwatch;
    assign timer[266] = six || colon1 ||two1 || four2|| stopwatch;
    assign timer[267] = seven || colon1 || two1 || four2|| stopwatch;
    assign timer[268] = eight || colon1 || two1 || four2|| stopwatch;
    assign timer[269] = nine || colon1 || two1 || four2 || stopwatch;    
    
    assign timer[270] = zero || colon1 || three1 || four2|| stopwatch;
    assign timer[271] = one || colon1 || three1 || four2|| stopwatch;
    assign timer[272] = two || colon1 || three1 || four2|| stopwatch;
    assign timer[273] = three || colon1 || three1 || four2|| stopwatch;
    assign timer[274] = four || colon1 || three1 || four2|| stopwatch;
    assign timer[275] = five || colon1 || three1 || four2|| stopwatch;
    assign timer[276] = six || colon1 ||three1 || four2|| stopwatch;
    assign timer[277] = seven || colon1 || three1 || four2|| stopwatch;
    assign timer[278] = eight || colon1 || three1 || four2|| stopwatch;
    assign timer[279] = nine || colon1 || three1 || four2|| stopwatch;    
    
    assign timer[280] = zero || colon1 || four1 || four2|| stopwatch;
    assign timer[281] = one || colon1 || four1 || four2|| stopwatch;
    assign timer[282] = two || colon1 || four1 || four2|| stopwatch;
    assign timer[283] = three || colon1 || four1 || four2|| stopwatch;
    assign timer[284] = four || colon1 || four1 || four2|| stopwatch;
    assign timer[285] = five || colon1 || four1 || four2|| stopwatch;
    assign timer[286] = six || colon1 || four1 || four2|| stopwatch;
    assign timer[287] = seven || colon1 || four1 || four2|| stopwatch;
    assign timer[288] = eight || colon1 || four1 || four2|| stopwatch;
    assign timer[289] = nine || colon1 || four1 || four2|| stopwatch;
    
    assign timer[290] = zero || colon1 || five1 || four2|| stopwatch;
    assign timer[291] = one || colon1 || five1 || four2|| stopwatch;
    assign timer[292] = two || colon1 || five1 || four2|| stopwatch;
    assign timer[293] = three || colon1 || five1 || four2|| stopwatch;
    assign timer[294] = four || colon1 || five1 || four2|| stopwatch;
    assign timer[295] = five || colon1 || five1 || four2|| stopwatch;
    assign timer[296] = six || colon1 || five1 || four2|| stopwatch;
    assign timer[297] = seven || colon1 || five1 || four2|| stopwatch;
    assign timer[298] = eight || colon1 || five1 || four2|| stopwatch;
    assign timer[299] = nine || colon1 || five1 || four2|| stopwatch;
    
    assign timer[300] = zero || colon1 || zero1 || five2|| stopwatch;
    
    always @ (posedge clk50) begin
        if (SW1 && layer == 5) begin
            state <= 0;
            COUNT <= 0;
        end
        else if (SW0 && layer == 5) begin
            COUNT <= COUNT + 1;
            if (COUNT == 50 && state < 240) begin
                state <= state + 1;
                COUNT <= 0;
            end
            else state <= state;
        end
        else COUNT <= COUNT;
    end
    
    always @ (posedge CLOCK) begin  
        if (SW2 && layer == 5) oled_data <= timer[state] ? 16'b1111100000000000 : 16'b1111111111100000;
        else if (SW3 && layer ==5) oled_data <= timer[state] ? 16'b0000000000011111 : 16'b0000011111100000;
        else if (SW4 && layer ==5) oled_data <= timer[state] ? 16'b0 : 16'b1111100000011111;
        else oled_data <= timer[state] ? 16'b1111111111111111 : 0;
    end
    
endmodule
