`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2022 11:36:47
// Design Name: 
// Module Name: trace_tgt
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


module trace_tgt(input CLOCK, input clk1k, input [11:0]mic_in, input pbu, pbd, pbl, pbr, pbc, pbun,pbdn,pbln,pbrn, input[2:0] layer, input SW0, input sw14, input [31:0] x, y, output reg [15:0] oled_data, input [12:0] pixel_index

    );
    parameter [6:0] b = 6;
    parameter [31:0] a = 4; 
    wire map, cursor;
    reg [6:0] x_ini = 45; // starting x coords
    reg [6:0] y_ini = 30;
    reg [6:0] x_set;
    reg [6:0] y_set;
    reg [6:0] low_radius = 5;
    reg [6:0] med_radius = 10;
    reg [6:0] high_radius = 15;
    reg [11:0] current_peak = 0;
    wire [6:0] radius;
    reg [31:0] count = 1;
    reg [31:0] count1 = 1;
    reg [31:0] count2 = 1;
    reg [31:0] count3 = 1;
    reg[31:0] count4 = 1;
    reg[31:0] count5 = 1;
    reg[31:0] red_areas = 0;
    wire right_within;
    wire left_within;
    wire down_within;
    wire up_within;
    reg [6:0] x_upper_bound=0;
    reg [6:0] x_lower_bound=0;
    reg [6:0] y_upper_bound=0;
    reg [6:0] y_lower_bound=0;
    reg [6:0] xub=0, xub1=0, xub2=0, xub3=0, xub4 = 0;
    reg [6:0] xlb=0,xlb1=0,xlb2=0,xlb3=0,xlb4=0;
    reg [6:0] yub=0,yub1=0,yub2=0,yub3=0,yub4=0;
    reg [6:0] ylb=0,ylb1=0,ylb2=0,ylb3=0,ylb4=0;
    wire hotspot;
    wire hotspot1;
    wire hotspot2;
    wire hotspot3;
    wire hotspot4;
    reg set = 0;
    reg [6:0] state = 0;
    reg rst = 0;
    wire [15:0] oled_lockdown;
    
    lockdown_animation fa24(CLOCK, rst, pixel_index, oled_lockdown);
    

        
    
    boundary_r fa20(clk1k, x_ini+1,y_ini, right_within);
    boundary_r fa21(clk1k, x_ini-1,y_ini, left_within);
    boundary_r fa22(clk1k, x_ini,y_ini+1, down_within);
    boundary_r fa23(clk1k, x_ini+1,y_ini-1, up_within);
    assign map = (y==a && (x>= 45 && x<=53)) || (y==a+1 && (x>= 44 && x<=54)) || (y==a+2 && (x>= 41 && x<=55)) || (y==a+3 && (x>= 41 && x<=55)) || (y==a+4 && ((x>= 28 && x<=31)||(x>=39 && x<=57)))
                || (y==a+5 && ((x>= 28 && x<=31)||(x>= 39 && x<=57))) || (y==a+6 && ((x>= 25 && x<=32)||(x>= 39 && x<=58))) || (y==a+7 && ((x>= 24 && x<=32)||(x>= 37 && x<=58))) || (y==a+8 && (x>= 23 && x<=57))
                || (y==a+9 && ((x>= 21 && x<=57)||(x>=60 && x<=63))) 
                || (y==a+10 && ((x>= 19 && x<=55)||(x>= 59 && x<=63)||(x>= 72 && x<=76))) 
                || (y==a+11 && ((x>= 19 && x<=55)||(x>= 59 && x<=63)||(x==65)||(x>= 72 && x<=76))) 
                || (y==a+12 && ((x>= 19 && x<=53)||(x>= 57 && x<=65)||(x>=67 && x<=68)||(x>= 73 && x<=81)))                
                || (y==a+13 && ((x>= 19 && x<=51)||(x>= 56 && x<=65)||(x>=67 && x<=68)||(x>= 77 && x<=83))) 
                || (y==a+14 && ((x>= 18 && x<=51)||(x>= 53 && x<=69)||(x>= 78 && x<=81)))
                || (y==a+15 && ((x>= 18 && x<=49)||(x>= 53 && x<=69)||(x>= 78 && x<=81))) || (y==a+16 && (x>= 17 && x<=72)) || (y==a+17 && ((x>= 17 && x<=73)||(x>=83 && x<=85))) || (y==a+18 && ((x>= 17 && x<=73)||(x>=83 && x<=85))) 
                || (y==a+19 && ((x>= 17 && x<=75)||(x>=82 && x<=89))) || (y==a+20 && ((x>= 16 && x<=77)||(x>=80 && x<=88))) || (y==a+21 && (x>= 16 && x<=89)) || (y==a+22 && (x>= 16 && x<=89)) || (y==a+23 && (x>= 13 && x<=88)) 
                || (y==a+24 && (x>= 13 && x<=88)) || (y==a+25 && (x>= 12 && x<=89)) || (y==a+26 && (x>= 12 && x<=89)) || (y==a+27 && (x>= 11 && x<=89))
                || (y==a+28 && (x>= 11 && x<=89)) || (y==a+29 && (x>= 11 && x<=89)) || (y==a+30 && (x>= 11 && x<=88)) || (y==a+31 && (x>= 10 && x<=88)) || (y==a+32 && (x>= 10 && x<=88)) || (y==a+33 && (x>= 10 && x<=87)) || (y==a+34 && (x>= 10 && x<=87)) || (y==a+35 && (x>= 10 && x<=90)) 
                || (y==a+36 && (x>= 9 && x<=91)) || (y==a+37 && ((x>= 9 && x<=10)||(x>=13 && x<=77))) || (y==a+38 && ((x>= 9 && x<=10)||(x>=16 && x<=24)||(x>=30 && x<=71))) || (y==a+39 && ((x>= 8 && x<=11)||(x>=16 && x<=18)||(x>=34 && x<=67))) || (y==a+40 && ((x>= 8 && x<=11)||(x>=16 && x<=18)||(x>=34 && x<=67))) || (y==a+41 && ((x>= 8 && x<=12)||(x>=16 && x<=18)||(x>=27 && x<=29)||(x>=37 && x<=65))) || (y==a+42 && ((x>= 8 && x<=12)||(x>=24 && x<=29)||(x>=39 && x<=63))) 
                || (y==a+43 && ((x>= 9 && x<=12)||(x>=24 && x<=30)||(x>=35 && x<=38)||(x>=40 && x<=60))) || (y==a+44 && ((x>= 9 && x<=12)||(x>=24 && x<=30)||(x>=35 && x<=38)||(x>=40 && x<=60))) || (y==a+45 && ((x>= 19 && x<=20)||(x>=23 && x<=33)||(x>=36 && x<=39)||(x>=42 && x<=59))) || (y==a+46 && ((x>= 18 && x<=21)||(x>=23 && x<=29)||(x==32)||(x>=37 && x<=39)||(x>=45 && x<=58))) || (y==a+47 && ((x>= 18 && x<=21)||(x>=23 && x<=29)||(x==32)||(x>=37 && x<=39)||(x>=45 && x<=58))) 
                || (y==a+48 && ((x>= 17 && x<=26)||(x>=28 && x<=30)||(x>=46 && x<=54))) || (y==a+49 && ((x>= 16 && x<=24)||(x>=49 && x<=50))) || (y==a+50 && ((x>= 17 && x<=22)||(x>=24 && x<=26)||(x>=47 && x<=50)||(x>=52 && x<=54))) || (y==a+51 && ((x>= 17 && x<=21)||(x>=48 && x<=55))) || (y==a+52 && ((x>= 18 && x<=20)||(x>=51 && x<=54)))
                || (y==a+53 && ((x>= 18 && x<=20)||(x>=51 && x<=54))) || (y==a+54 && ((x>= 18 && x<=20)||(x==52))) || (y==a+55 && ((x>= 18 && x<=20)||(x==52)));
    assign cursor = (x == x_ini && (y >= y_ini - 1 && y<= y_ini + 1)) || (y == y_ini && (x== x_ini - 1 || x== x_ini + 1));
    
    
    always @ (posedge clk1k) begin
    if(sw14||rst)begin
        x_ini = 45;
        y_ini = 30;
        count = 1;
        count1 = 1;
        count2 = 1;
        count3 = 1;
        x_upper_bound=0;
        x_lower_bound=0;
        y_upper_bound=0;
        y_lower_bound=0;
        xub=0; xub1=0; xub2=0; xub3=0; xub4 = 0;
        xub=0; xub1=0; xub2=0; xub3=0; xub4 = 0;
        yub=0;yub1=0;yub2=0;yub3=0;yub4=0;
        ylb=0;ylb1=0;ylb2=0;ylb3=0;ylb4=0;
        set = 0; state = 0;
        //rst <= (count4==10)?0:count4+1;
    end
    else begin
        count4 <= 1;
        if(SW0 && layer == 2)begin
            if(!pbun && !pbdn && !pbln && !pbrn)begin
                count <=1;
            end
            if(!pbc)begin
                count1 <=1;
            end
            if(pbun&&up_within) begin
                count <= (count == 40)? 0:count+1;
                y_ini <= (count == 0)?y_ini-1:y_ini;
            end
            else if(pbdn&&down_within)begin
                count <= (count == 40)? 0:count+1;
                y_ini <= (count == 0)?y_ini+1:y_ini;
            end
            else if(pbln&&left_within)begin
                count <= (count == 40)? 0:count+1;
                x_ini <= (count == 0)?x_ini-1:x_ini;
            end
            else if(pbrn&&right_within)begin
                count <= (count == 40)? 0:count+1;
                x_ini <= (count == 0)?x_ini+1:x_ini;
            end
            else if(pbc||set)begin
                set <=1;
                count1 <= (count1 == 50 || count1 == 0)?0:count1+1;
                if(count1 == 0)begin
                    count2 <= count2 + 1;
                    if(mic_in>current_peak)begin
                        current_peak <= mic_in;
                    end
                    if(count2 == 2000)begin
                        x_set = x_ini;
                        y_set = y_ini;
                        if(current_peak >= 0 && current_peak <= 2535)begin
                            if(state == 0)begin
                                x_lower_bound = x_set-2; x_upper_bound = x_set+2; y_lower_bound = y_set-2; y_upper_bound = y_set+2;
                            end
                            else if(state == 1)begin
                                xlb = x_set - 2; xub = x_set+2; ylb = y_set-2; yub = y_set+2;
                            end
                            else if (state == 2)begin
                                xlb1 = x_set - 2; xub1 = x_set+2; ylb1 = y_set-2; yub1 = y_set+2;
                            end
                            else if(state == 3)begin
                                xlb2 = x_set - 2; xub2 = x_set+2; ylb2 = y_set-2; yub2 = y_set+2;
                            end
                            else if(state == 4)begin
                                xlb3 = x_set - 2; xub3 = x_set+2; ylb3 = y_set-2; yub3 = y_set+2;
                            end
                            else if(state == 5)begin
                                xlb4 = x_set - 2; xub4 = x_set+2; ylb4 = y_set-2; yub4 = y_set+2;
                            end   
                        end
                        else if(current_peak >= 2535 && current_peak <= 3315)begin
                            if(state == 0)begin
                                x_lower_bound = x_set-4; x_upper_bound = x_set+4; y_lower_bound = y_set-4; y_upper_bound = y_set+4;
                            end
                            else if(state == 1)begin
                                xlb = x_set - 4; xub = x_set+4; ylb = y_set-4; yub = y_set+4;
                            end
                            else if (state == 2)begin
                                xlb1 = x_set - 4; xub1 = x_set+4; ylb1 = y_set-4; yub1 = y_set+4;
                            end
                            else if(state == 3)begin
                                xlb2 = x_set - 4; xub2 = x_set+4; ylb2 = y_set-4; yub2 = y_set+4;
                            end
                            else if(state == 4)begin
                                xlb3 = x_set - 4; xub3 = x_set+4; ylb3 = y_set-4; yub3 = y_set+4;
                            end
                            else if(state == 5)begin
                                xlb4 = x_set - 4; xub4 = x_set+4; ylb4 = y_set-4; yub4 = y_set+4;
                            end   
                        end
                        else if(current_peak >= 3315 && current_peak <= 4095)begin
                            if(state == 0)begin
                                x_lower_bound = x_set-8; x_upper_bound = x_set+8; y_lower_bound = y_set-8; y_upper_bound = y_set+8;
                            end
                            else if(state == 1)begin
                                xlb = x_set - 8; xub = x_set+8; ylb = y_set-8; yub = y_set+8;
                            end
                            else if (state == 2)begin
                                xlb1 = x_set - 8; xub1 = x_set+8; ylb1 = y_set-8; yub1 = y_set+8;
                            end
                            else if(state == 3)begin
                                xlb2 = x_set - 8; xub2 = x_set+8; ylb2 = y_set-8; yub2 = y_set+8;
                            end
                            else if(state == 4)begin
                                xlb3 = x_set - 8; xub3 = x_set+8; ylb3 = y_set-8; yub3 = y_set+8;
                            end
                            else if(state == 5)begin
                                xlb4 = x_set - 8; xub4 = x_set+8; ylb4 = y_set-8; yub4 = y_set+8;
                            end   
                        end
                        count2 <= 1;
                        count1 <= 1;
                        set <= 0;
                        state <= state+1;
                        current_peak <= 0;
                    end
                end
            end
        end
        else if(!SW0 && layer == 2)begin
            if(!pbc)begin
                count1 <=1;
            end
            if(pbu&&up_within) begin
            y_ini <= y_ini-1;
            end
            else if(pbd&&down_within)begin
                y_ini <= y_ini+1;
            end
            else if(pbl&&left_within)begin
                x_ini <= x_ini-1;
            end
            else if(pbr&&right_within)begin
                x_ini <= x_ini+1;
            end
        end
    end
end
    
    assign hotspot = ((x>=x_lower_bound)&&(x<=x_upper_bound)&&(y>=y_lower_bound)&&(y<=y_upper_bound));
    assign hotspot1 = ((x>=xlb)&&(x<=xub)&&(y>=ylb)&&(y<=yub));
    assign hotspot2 = ((x>=xlb1)&&(x<=xub1)&&(y>=ylb1)&&(y<=yub1));
    assign hotspot3 = ((x>=xlb2)&&(x<=xub2)&&(y>=ylb2)&&(y<=yub2));
    assign hotspot4 = ((x>=xlb3)&&(x<=xub3)&&(y>=ylb3)&&(y<=yub3));
            
    always @ (posedge CLOCK) begin
/*    if(x==94 && y == 62)begin
        if(red_areas >= 200)begin
            rst <= 1;
            red_areas <= 0;
        end
        else begin
            red_areas <= 0;
        end
    end  */ 
    if(sw14)begin
        red_areas = 0;
        rst <= 0;
    end
    else if(rst)begin
       /* count5 <= count5+1;
        red_areas <= (count5==100000000)?0:red_areas;*/
        //rst <= (count5==100000000)?0:red_areas;
        if(rst)begin
            oled_data <= oled_lockdown;
            red_areas = 0;
        end
    end
    else begin
    count5 = 1;
    if(map && ~cursor&& ~hotspot &&~hotspot1 &&~hotspot2 &&~hotspot3 &&~hotspot4)begin
        oled_data <= 16'b00000_111111_00000;
    end
    else if(cursor)begin
        oled_data <= 16'b00000_000000_11111;
    end
    else if((hotspot||hotspot1||hotspot2||hotspot3||hotspot4)&& map)begin
        oled_data <= 16'b11111_000000_00000;
        red_areas <= red_areas + 1;
        if(red_areas >= 750)begin//240000
            rst = 1;
        end
    end
    else if(y>=62)begin
        red_areas <= 0;
        oled_data <= 16'b00000_000000_00000;
    end
    else if(x<=2)begin
        red_areas <= 0;
        oled_data <= 16'b00000_000000_00000;
    end
    else begin
        oled_data <= 16'b00000_000000_00000;
    end
    end
    

end
        
endmodule
