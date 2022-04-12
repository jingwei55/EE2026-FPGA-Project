`timescale 1ns / 1ps 
////////////////////////////////////////////////////////////////////////////////// 
// Company:  
// Engineer:  
//  
// Create Date: 24.03.2022 00:23:46 
// Design Name:  
// Module Name: sg_map 
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


module map(input CLOCK, clk50, input pbu, pbu_ndb, pbd, pbd_ndb, pbl, pbl_ndb, pbr, pbr_ndb, pbc, SW0, SW1, SW14, input [2:0] layer, input [31:0] x, y, output reg [15:0] oled_data, output reg [7:0] seg_map, output reg [3:0] an_map); 
    parameter [6:0] b = 6;
    parameter [31:0] a = 4; 
    reg [6:0] x_ini = 45; // starting x coords
    reg [6:0] y_ini = 30; // starting y coords
    reg [6:0] x_ini2 = 45; // starting x coords
    reg [6:0] y_ini2 = 30; // starting y coords
    reg [6:0] set_x1 = 0;
    reg [6:0] set_y1 = 0;
    reg [6:0] set_x2 = 0;
    reg [6:0] set_y2 = 0;
    reg [2:0] cursor_state = 0;
    reg [31:0] COUNT = 0;
    
    wire sg_flag, map1, map2, cursor1, cursor2, pos1, pos2, distance_get, vert, vert2, done_sqrt, up, down, left, right, up2, down2, left2, right2;
    wire [6:0] borderx, bordery;
    wire [15:0] map [3:0];
    wire [13:0] distance;
    wire [6:0] x1, x2, y1, y2;
    wire [7:0] seg;
    wire [3:0] an;
    assign x1 = set_x1;
    assign x2 = set_x2;
    assign y1 = set_y1;
    assign y2 = set_y2;
    
    //change_cursor(.CLOCK(CLOCK), .pbu(pbu), .pbd(pbd), .pbl(pbl), .pbr(pbr), .cur_x(x_ini), .cur_y(y_ini), .new_x(x_ini), .new_y(y_ini));
    //cal_dist fa05 (.CLOCK(CLOCK), .set_x1(x1), .set_y1(y1), .set_x2(x2), .set_y2(y2), .distance(distance));     
    sqrt fa06 ( .Clock(CLOCK), .set_x1(x1), .set_y1(y1), .set_x2(x2), .set_y2(y2), .done(done_sqrt), .sq_root(distance));
    boundary_r fa07 (.clk50(clk50), .x(x_ini+1), .y(y_ini), .map(right));
    boundary_l fa08 (.clk50(clk50), .x(x_ini-1), .y(y_ini), .map(left));
    boundary_u fa09 (.clk50(clk50), .x(x_ini), .y(y_ini-1), .map(up));
    boundary_d fa10 (.clk50(clk50), .x(x_ini), .y(y_ini+1), .map(down));
    boundary_r2 fa11 (.clk50(clk50), .x(x_ini2+1), .y(y_ini2), .map(right2));
    boundary_l2 fa12 (.clk50(clk50), .x(x_ini2-1), .y(y_ini2), .map(left2));
    boundary_u2 fa13 (.clk50(clk50), .x(x_ini2), .y(y_ini2-1), .map(up2));
    boundary_d2 fa14 (.clk50(clk50), .x(x_ini2), .y(y_ini2+1), .map(down2));
    disp_dist fa15 ( .clk50(clk50), .distance(distance/2), .seg_map(seg), .an_map(an));

    assign map1 = (y==a && (x>= 45 && x<=53)) || (y==a+1 && (x>= 44 && x<=54)) || (y==a+2 && (x>= 41 && x<=55)) || (y==a+3 && (x>= 41 && x<=55)) || (y==a+4 && ((x>= 28 && x<=31)||(x>=39 && x<=57)))
                || (y==a+5 && ((x>= 28 && x<=31)||(x>= 39 && x<=57))) || (y==a+6 && ((x>= 25 && x<=32)||(x>= 39 && x<=58))) || (y==a+7 && ((x>= 24 && x<=32)||(x>= 37 && x<=58))) || (y==a+8 && (x>= 23 && x<=57))
                || (y==a+9 && ((x>= 21 && x<=57)||(x>=60 && x<=63))) 
                || (y==a+10 && ((x>= 19 && x<=55)||(x>= 59 && x<=63)||(x>= 72 && x<=76))) 
                || (y==a+11 && ((x>= 19 && x<=55)||(x>= 59 && x<=63)||(x==65)||(x>= 72 && x<=76))) 
                || (y==a+12 && ((x>= 19 && x<=53)||(x>= 57 && x<=65)||(x>=67 && x<=68)||(x>= 73 && x<=81)))                
                || (y==a+13 && ((x>= 19 && x<=51)||(x>= 56 && x<=65)||(x>=67 && x<=68)||(x>= 77 && x<=83))) 
                || (y==a+14 && ((x>= 18 && x<=51)||(x>= 53 && x<=69)||(x>= 78 && x<=81)))
                || (y==a+15 && ((x>= 18 && x<=49)||(x>= 53 && x<=69)||(x>= 78 && x<=81))) || (y==a+16 && (x>= 17 && x<=72)) || (y==a+17 && ((x>= 17 && x<=73)||(x>=83 && x<=85))) || (y==a+18 && ((x>= 17 && x<=73)||(x>=83 && x<=85))) 
                || (y==a+19 && ((x>= 17 && x<=75)||(x>=82 && x<=89))) || (y==a+20 && ((x>= 16 && x<=77)||(x>=80 && x<=88))) || (y==a+21 && (x>= 16 && x<=89)) || (y==a+22 && (x>= 16 && x<=89)) || (y==a+23 && (x>= 13 && x<=88)) 
                || (y==a+24 && (x>= 13 && x<=88)) || (y==a+25 && (x>= 12 && x<=89)) || (y==a+26 && (x>= 12 && x<=89)) || (y==a+27 && (x>= 11 && x<=89));

     assign map2 = (y==a+28 && (x>= 11 && x<=89)) || (y==a+29 && (x>= 11 && x<=89)) || (y==a+30 && (x>= 11 && x<=88)) || (y==a+31 && (x>= 10 && x<=88)) || (y==a+32 && (x>= 10 && x<=88)) || (y==a+33 && (x>= 10 && x<=87)) || (y==a+34 && (x>= 10 && x<=87)) || (y==a+35 && (x>= 10 && x<=90)) 
                || (y==a+36 && (x>= 9 && x<=91)) || (y==a+37 && ((x>= 9 && x<=10)||(x>=13 && x<=77))) || (y==a+38 && ((x>= 9 && x<=10)||(x>=16 && x<=24)||(x>=30 && x<=71))) || (y==a+39 && ((x>= 8 && x<=11)||(x>=16 && x<=18)||(x>=34 && x<=67))) || (y==a+40 && ((x>= 8 && x<=11)||(x>=16 && x<=18)||(x>=34 && x<=67))) || (y==a+41 && ((x>= 8 && x<=12)||(x>=16 && x<=18)||(x>=27 && x<=29)||(x>=37 && x<=65))) || (y==a+42 && ((x>= 8 && x<=12)||(x>=24 && x<=29)||(x>=39 && x<=63))) 
                || (y==a+43 && ((x>= 9 && x<=12)||(x>=24 && x<=30)||(x>=35 && x<=38)||(x>=40 && x<=60))) || (y==a+44 && ((x>= 9 && x<=12)||(x>=24 && x<=30)||(x>=35 && x<=38)||(x>=40 && x<=60))) || (y==a+45 && ((x>= 19 && x<=20)||(x>=23 && x<=33)||(x>=36 && x<=39)||(x>=42 && x<=59))) || (y==a+46 && ((x>= 18 && x<=21)||(x>=23 && x<=29)||(x==32)||(x>=37 && x<=39)||(x>=45 && x<=58))) || (y==a+47 && ((x>= 18 && x<=21)||(x>=23 && x<=29)||(x==32)||(x>=37 && x<=39)||(x>=45 && x<=58))) 
                || (y==a+48 && ((x>= 17 && x<=26)||(x>=28 && x<=30)||(x>=46 && x<=54))) || (y==a+49 && ((x>= 16 && x<=24)||(x>=49 && x<=50))) || (y==a+50 && ((x>= 17 && x<=22)||(x>=24 && x<=26)||(x>=47 && x<=50)||(x>=52 && x<=54))) || (y==a+51 && ((x>= 17 && x<=21)||(x>=48 && x<=55))) || (y==a+52 && ((x>= 18 && x<=20)||(x>=51 && x<=54)))
                || (y==a+53 && ((x>= 18 && x<=20)||(x>=51 && x<=54))) || (y==a+54 && ((x>= 18 && x<=20)||(x==52))) || (y==a+55 && ((x>= 18 && x<=20)||(x==52)));
                
    assign sg_flag = (x == 27 && ( y >= 19 && y <= 22)) || (x == 28 && ( y >= 18 && y <= 23)) || (x == 29 && ( y == 17 || y == 18 || y == 23 || y == 24)) || (x == 30 && ( y == 17 || y == 24)) || (x == 31 && ( y == 17 || y == 24))
                     || (x == 32 && y == 20) || (x == 33 && y == 22) || (x == 34 && y == 18) || (x == 35 && y == 22) || (x == 36 && y == 20);

      
      assign vert = y >= 14 && y <= 20;
      assign vert2 = y >= 32 && y <= 38;
      assign distance_get = (x == b && vert) || (x == b+1 && ( y == 14 || y == 20)) || (x == b+2 && ( y == 14 || y == 20)) || (x == b+3 && ( y == 14 || y == 20)) || (x == b+4 && ( y >= 15 && y <= 19)) 
                            || (x == b+6 && vert) 
                            || (x == b+8 && ( y == 15 || y == 16 || y == 19)) || (x == b+9 && ( y == 14 || y == 20 || y == 17)) || (x == b+10 && ( y == 14 || y == 20 || y == 17)) || (x == b+11 && ( y == 14 || y == 20 || y == 17)) || (x == b+12 && ( y == 15 || y == 19 || y == 18)) 
                            || (x == b+14 && y == 14) || (x == b+15 && y == 14)|| (x == b+16 && vert)  || (x == b+17 && y == 14) || (x == b+18 && y == 14) 
                            || (x == b+20 && ( y >= 16 && y <= 20)) || (x == b+21 && ( y == 15 || y == 18)) || (x == b+22 && ( y == 14 || y == 18)) || (x == b+23 && ( y == 15 || y == 18)) || (x == b+24 && ( y >= 16 && y <= 20)) 
                            || (x == b+26 && vert) || (x == b+27 && y == 16) || (x == b+28 && y == 17) || (x == b+29 && y == 18) || (x == b+30 && vert)
                            || (x == b+32 && ( y >= 15 && y <= 19)) || (x == b+33 && ( y == 14 || y == 20)) || (x == b+34 && ( y == 14 || y == 20)) || (x == b+35 && ( y == 14 || y == 20)) || (x == b+36 && ( y == 15 || y == 19)) 
                            || (x == b+38 && vert) || (x == b+39 && ( y == 14 || y == 20 || y == 17)) || (x == b+40 && ( y == 14 || y == 20 || y == 17)) || (x == b+41 && ( y == 14 || y == 20)) || (x == b+42 && ( y == 14 || y == 20)) 
                            || (x == b+49 && ( y >= 16 && y <= 20)) || (x == b+50 && ( y == 15 || y == 18)) || (x == b+51 && ( y == 14 || y == 18)) || (x == b+52 && ( y == 15 || y == 18)) || (x == b+53 && ( y >= 16 && y <= 20)) 
                            || (x == b+55 && ( y >= 15 && y <= 19)) || (x == b+56 && ( y == 14 || y == 20)) || (x == b+57 && ( y == 14 || y == 20 || y == 18)) || (x == b+58 && ( y == 14 || y == 20 || y == 19)) || (x == b+59 && ( y >= 15 && y <= 19))
                            || (x == b+61 && ( y >= 14 && y <= 19)) || (x == b+62 && y == 20) || (x == b+63 && y == 20) || (x == b+64 && y == 20) || (x == b+65 && ( y >= 14 && y <= 19))
                            || (x == b+67 && vert) || (x == b+69 && vert) || (x == b+70 && ( y == 14 || y == 17)) || (x == b+71 && ( y == 14 || y == 18 || y == 17)) || (x == b+72 && ( y == 14 || y == 19 || y == 17)) || (x == b+73 && ( y == 15 || y == 20 || y == 16))
                            || (x == b+75 && vert) || (x == b+76 && ( y == 14 || y == 20 || y == 17)) || (x == b+77 && ( y == 14 || y == 20 || y == 17)) || (x == b+78 && ( y == 14 || y == 20)) || (x == b+79 && ( y == 14 || y == 20)) 
                            || (x == b+81 && vert) || (x == b+82 && ( y == 14 || y == 20)) || (x == b+83 && ( y == 14 || y == 20)) || (x == b+84 && ( y == 14 || y == 20)) || (x == b+85 && ( y >= 15 && y <= 19)) 
                            || ((x >= 6 && x <= 91) && y ==22)
                            
                            || (x == a && y == 35) || (x == a+1 && (y >= 34 && y <= 36)) || (x == a+2 && (y >= 33 && y <= 37)) || (x == a+3 && (y >= 32 && y <= 38)) || (x == a+4 && (y >= 31 && y <= 39)) || (x == a+5 && (y >= 30 && y <= 40)) || ((x >= a+6 && x <= a+18) && (y >= 34 && y <= 36))
                            
                            || (x == a+21 && vert2) || (x == a+22 && ( y == 32 || y == 38)) || (x == a+23 && ( y == 32 || y == 38)) || (x == a+24 && ( y == 32 || y == 38)) || (x == a+25 && ( y >= 33 && y <= 37)) 
                            || (x == a+27 && vert2) 
                            || (x== a+29 && (y ==33 || y == 34 || y ==37)) || (x==a+30 && (y ==32 || y == 35 || y ==38)) || (x==a+31 && (y ==32 || y == 35 || y ==38)) || (x==a+32 && (y ==32 || y == 35 || y ==38)) || (x==a+33 && (y ==33 || y == 36 || y ==37)) 
                            || (x==a+35 && y ==32) || (x==36 && y ==32) || (x==a+37 && vert2) || (x==38 && y ==32) || (x==a+39 && y ==32)
                            || (x == a+41 && (y >= 34 && y <= 38)) || (x== a+42 && (y ==33 || y == 36)) || (x== a+43 && (y ==32 || y == 36)) || (x== a+44 && (y ==33 || y == 36)) || (x == a+45 && (y >= 34 && y <= 38))
                            || (x == a+47 && vert2) || (x== a+48 && y ==34) || (x== a+49 && y ==35) || (x== a+50 && y ==36) || (x == a+51 && vert2)
                            || (x == a+53 && (y >= 33 && y <= 37)) || (x== a+54 && (y ==32 || y == 38)) || (x== a+55 && (y ==32 || y == 38)) || (x== a+56 && (y ==32 || y == 38)) || (x== a+57 && (y ==33 || y == 37))
                            || (x == a+59 && vert2) || (x== a+60 && (y ==32 || y == 35 || y ==38)) || (x== a+61 && (y ==32 || y == 35 || y ==38)) || (x== a+62 && (y ==32 || y ==38)) || (x== a+63 && (y ==32 || y ==38))
                            || (x == a+68 && vert2) 
                            || (x == a+70 && vert2) || (x== a+71 && y ==34) || (x== a+72 && y ==35) || (x== a+73 && y ==36) || (x == a+74 && vert2)
                            || (x == a+79 && vert2) || (x== a+80 && y ==35) || (x== a+81 && y ==35) || (x== a+82 && (y ==34 || y==36))|| (x== a+83 && (y ==32 || y==33 || y ==37 || y==38))
                            || (x == a+85 && vert2) || (x== a+86 && y ==33) || (x== a+87 && y ==34) || (x== a+88 && y ==33) || (x == a+89 && vert2);
           
      assign cursor1 = (x == x_ini && (y >= y_ini - 1 && y<= y_ini + 1)) || (y == y_ini && (x== x_ini - 1 || x== x_ini + 1));
      assign cursor2 = (x == x_ini2 && (y >= y_ini2 - 1 && y<= y_ini2 + 1)) || (y == y_ini2 && (x== x_ini2 - 1 || x== x_ini2 + 1));
      
      //assign map_wo = map && ~cursor;
      //assign borderx = 45;
      //assign bordery = 31 || 29;
      always @ (posedge clk50) begin
        if (SW14) begin
          set_x1 = 0;
          set_y1 = 0;
          set_x2 = 0;
          set_y2 = 0;
          x_ini = 45; 
          y_ini = 30; 
          x_ini2 = 45; 
          y_ini2 = 30;
          cursor_state = 0;
        end
        if (SW0 && layer == 1) begin
            case (cursor_state)
                0: begin
                  an_map <= 4'b1111;
                  seg_map <= 8'b11111111;
                  if ( pbd_ndb && layer == 1 && down) begin //down
                    COUNT <= COUNT + 1;
                    if (COUNT > 20) begin
                     y_ini = y_ini + 1;
                     x_ini = x_ini;
                     COUNT <= 0;
                  end
                  end 
                  else if (pbl_ndb && layer == 1 && left) begin //left
                  COUNT <= COUNT + 1;
                  if (COUNT > 20) begin
                     x_ini = x_ini - 1;
                     y_ini = y_ini;
                     COUNT <= 0;
                   end
                  end else if (pbr_ndb && layer == 1 && right) begin //right
                  COUNT <= COUNT + 1;
                  if (COUNT > 20) begin
                     x_ini = x_ini + 1;
                     y_ini = y_ini;
                     COUNT <= 0;
                  end
                  end else if (pbu_ndb && layer == 1 && up) begin // up
                      COUNT <= COUNT + 1;
                      if (COUNT > 20) begin
                         y_ini = y_ini - 1;
                         x_ini = x_ini;
                         COUNT <= 0;
                      end
                  end
                  else if (pbc && layer == 1) begin     
                        set_y1 = y_ini;
                        set_x1 = x_ini;
                        cursor_state = 1;
                   end
                  else begin
                      y_ini = y_ini;
                      x_ini = x_ini;
                 end
             end
             1: begin 
                 if (pbd_ndb && layer == 1 && down2) begin //down
                 COUNT <= COUNT + 1;
                 if (COUNT > 20) begin
                      y_ini2 = y_ini2 + 1;
                      x_ini2 = x_ini2;
                      COUNT <= 0;
                 end
                   end 
                   else if (pbl_ndb && layer == 1 && left2) begin //left
                   COUNT <= COUNT + 1;
                   if (COUNT > 20) begin
                      x_ini2 = x_ini2 - 1;
                      y_ini2 = y_ini2;
                      COUNT <= 0;
                   end
                   end else if (pbr_ndb && layer == 1 && right2) begin //right
                   COUNT <= COUNT + 1;
                   if (COUNT > 20) begin
                      x_ini2 = x_ini2 + 1;
                      y_ini2 = y_ini2;
                      COUNT <= 0;  
                   end
                   end else if (pbu_ndb && layer == 1 && up2) begin // up
                   COUNT <= COUNT + 1;
                   if (COUNT > 20) begin
                      y_ini2 = y_ini2 - 1;
                      x_ini2 = x_ini2;
                      COUNT <= 0;
                   end
                   end
                   else if (pbc && layer == 1) begin
                       set_y2 = y_ini2;
                       set_x2 = x_ini2;
                       cursor_state = 2;
                   end
                   else begin
                       y_ini2 = y_ini2;
                       x_ini2 = x_ini2;
                  end
             end
             2: begin
                 if (layer == 1 && pbc) begin
                     cursor_state = 3;
                 end
             end
             3: begin
                 if (layer == 1 && pbc) begin
                   cursor_state = 0;
                   set_x1 = 0;
                   set_y1 = 0;
                   set_x2 = 0;
                   set_y2 = 0;
                   x_ini = 45; 
                   y_ini = 30; 
                   x_ini2 = 45; 
                   y_ini2 = 30;
                 end
                 else if (done_sqrt && layer == 1) begin
//                  if (distance >= 1 && distance < 5) seg_map <= 8'b11111001; 
//                  else if (distance >= 5 && distance < 10) seg_map <= 8'b10100100; 
//                  else if (distance >= 10 && distance < 15) seg_map <= 8'b10110000; 
//                  else if (distance >= 15 && distance < 20) seg_map <= 8'b10011001; 
//                  else if (distance >= 20 && distance < 25) seg_map <= 8'b10010010; 
//                  else seg_map <= 8'b10111111;
                    an_map <= an;
                    seg_map <= seg;
                  end
             end
            endcase
        end
        
        else begin 
        case (cursor_state)
            0: begin
              an_map <= 4'b1111;
              seg_map <= 8'b11111111;
              if (pbd && layer == 1 && down) begin //down
                 y_ini = y_ini + 1;
                 x_ini = x_ini;
              end 
              else if (pbl && layer == 1 && left) begin //left
                 x_ini = x_ini - 1;
                 y_ini = y_ini;
              end else if (pbr && layer == 1 && right) begin //right
                 x_ini = x_ini + 1;
                 y_ini = y_ini;
              end else if (pbu && layer == 1 && up) begin // up
                 y_ini = y_ini - 1;
                 x_ini = x_ini;
              end
              else if (pbc && layer == 1) begin
                    set_y1 = y_ini;
                    set_x1 = x_ini;
                    cursor_state = 1;
               end
              else begin
                  y_ini = y_ini;
                  x_ini = x_ini;
             end
         end
         1: begin 
             if (pbd && layer == 1 && down2) begin //down
                  y_ini2 = y_ini2 + 1;
                  x_ini2 = x_ini2;
               end 
               else if (pbl && layer == 1 && left2) begin //left
                  x_ini2 = x_ini2 - 1;
                  y_ini2 = y_ini2;
               end else if (pbr && layer == 1 && right2) begin //right
                  x_ini2 = x_ini2 + 1;
                  y_ini2 = y_ini2;
               end else if (pbu && layer == 1 && up2) begin // up
                  y_ini2 = y_ini2 - 1;
                  x_ini2 = x_ini2;
               end
               else if (pbc && layer == 1) begin
                   set_y2 = y_ini2;
                   set_x2 = x_ini2;
                   cursor_state = 2;
               end
               else begin
                   y_ini2 = y_ini2;
                   x_ini2 = x_ini2;
              end
         end
         2: begin
             if (layer == 1 && pbc) begin
                 cursor_state = 3;
             end
         end
         3: begin
             if (layer == 1 && pbc) begin
                cursor_state = 0;
                set_x1 = 0;
                set_y1 = 0;
                set_x2 = 0;
                set_y2 = 0;
                x_ini = 45; 
                y_ini = 30; 
                x_ini2 = 45; 
                y_ini2 = 30;
             end
             else if (done_sqrt && layer == 1) begin
//             if (distance >= 1 && distance < 5) seg_map <= 8'b11111001; 
//             else if (distance >= 5 && distance < 10) seg_map <= 8'b10100100; 
//             else if (distance >= 10 && distance < 15) seg_map <= 8'b10110000; 
//             else if (distance >= 15 && distance < 20) seg_map <= 8'b10011001; 
//             else if (distance >= 20 && distance < 25) seg_map <= 8'b10010010; 
//             else seg_map <= 8'b10111111;
                    an_map <= an;
                    seg_map <= seg;
             end
         end
        endcase
        end
    end
      
     assign pos1 = (x == set_x1 && (y >= set_y1 - 1 && y <= set_y1 + 1)) || (y == set_y1 && (x== set_x1 - 1 || x== set_x1 + 1));
     assign pos2 = (x == set_x2 && (y >= set_y2 - 1 && y<= set_y2 + 1)) || (y == set_y2 && (x== set_x2 - 1 || x== set_x2 + 1));
     //assign map = (map1 || map2) && ~cursor1;
     assign map[0] = (map1 || map2) && ~cursor1;
     assign map[1] = (map1 || map2) && ~cursor2 && ~pos1;
     assign map[2] = (map1 || map2) && ~pos2 && ~pos1;
     // assign map[4] for instructions
     assign map[3] = distance_get; //change to '<--- DISTANCE IN KM; DISTANCE CALCULATED' display on OLED 
     
    always @ (posedge CLOCK) begin
        if(SW1 && layer == 1) begin
           oled_data = (map1 && ~sg_flag) ? 16'b1111100000000000 : (map2 || sg_flag) ? 16'b1111111111111111 : 0;
        end
        else if (SW14 && layer == 1) begin
            oled_data = map[0] ? 16'b11111_000000_00000 : cursor1 ? 16'b11111_111111_00000 : 0; //reset
        end
        else begin
            oled_data = map[cursor_state] ? 16'b11111_000000_00000 : (cursor_state == 0 && cursor1) ? 16'b11111_111111_00000  //only have 1 yellow cursor moving
            : (cursor_state == 1 && cursor2) ? 16'b11111_111111_00000 : (cursor_state == 1 && pos1) ? 16'b00000_111111_00000 //set green position, 1 yellow cursor moving
            : (cursor_state == 2 && (pos1 || pos2)) ? 16'b00000_111111_00000 : 0; //set 2 green positions
        end
    end
                         
endmodule