`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2022 17:47:37
// Design Name: 
// Module Name: lab_task
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


module lab_task(input clk1k, clk20k, clk25MHz, SW15, SW0, SW1, SW2, SW3, SW4, pbl, pbr, input [2:0] layer, input [31:0] x, y, input [11:0]mic_in, output reg [3:0] an, output reg [7:0] seg, output reg [15:0] led, output reg [15:0] oled_data);
    reg [31:0] COUNT = 0;
    reg [31:0] COUNT2 = 0;
    reg [31:0] COUNT3 = 0;
    reg [11:0] current_peak = 0;
    reg right = 0;
    reg left = 0;
    wire red, yellow, green;
    reg [31:0] min = 2048;
    reg [31:0] max = 2049;
    reg [31:0] range = 0;

    always @ (posedge clk25MHz) begin
        if (SW15 && layer == 4) begin
        if (led[4]) begin //red 
           if (((y >= 7 && y <= 9)||(y >= 54 && y <= 56)) && (x >= 7 && x <= 88)) begin 
               oled_data[15:0] <= 16'b1111100000000000; 
           end 
           else if (((x >= 7 && x <= 9)||(x >= 86 && x <= 88)) && (y >= 7 && y <= 56)) begin 
               oled_data[15:0] <= 16'b1111100000000000; 
           end 
           else if ((y == 5 || y == 58) && (x >= 5 && x <= 90)) begin 
               oled_data[15:0] <= 16'b1111111000000000; 
           end 
           else if ((x == 5 || x == 90) && (y >= 5 && y <= 58)) begin 
               oled_data[15:0] <= 16'b1111111000000000; 
           end 
           else if ((y == 3 || y ==  60) && (x >= 3 && x <= 92)) begin 
               oled_data[15:0] <= 16'b0000011111100000; 
           end 
           else if ((x == 3 || x == 92) && (y >= 3 && y <= 60)) begin 
                oled_data[15:0] <= 16'b0000011111100000; 
           end 
           else if(x>=18 && x<=77 && y>=27 && y<=36)begin 
               oled_data[15:11] <= 5'b11111; 
               oled_data[10:0] <= 0; 
           end 
           else if(x>=18 && x<=77 && y>=20 && y<=43)begin  // && (!SW0)
               oled_data[15:11] <= 5'b11111; 
               oled_data[10:5] <= 6'b110000; 
               oled_data[4:0] <= 0; 
           end 
           else if(x>=18 && x<=77 && y>=13 && y<=50)begin 
               oled_data[10:5] <= 6'b111111; 
               oled_data[4:0] <= 0; 
               oled_data[15:11] <= 0; 
           end 
           else begin 
               oled_data[15:0] <= 16'b0; 
           end 
       end 
       else if (led[2]||led[3]) begin //orange 
           if ((y == 5  || y == 58) && (x >= 5 && x <= 90)) begin 
               oled_data[15:0] <= 16'b1111111000000000; 
           end 
           else if ((x == 5 || x == 90) && (y >= 5 && y <= 58)) begin 
               oled_data[15:0] <= 16'b1111111000000000; 
           end 
           else if ((y == 3 || y ==  60) && (x >= 3 && x <= 92)) begin 
               oled_data[15:0] <= 16'b0000011111100000; 
           end 
           else if ((x == 3 || x == 92) && (y >= 3 && y <= 60)) begin 
               oled_data[15:0] <= 16'b0000011111100000; 
           end 
           else if(x>=18 && x<=77 && y>=20 && y<=43)begin // && (!SW0)
                oled_data[15:11] <= 5'b11111; 
                oled_data[10:5] <= 6'b110000; 
                oled_data[4:0] <= 0; 
           end 
           else if(x>=18 && x<=77 && y>=13 && y<=50)begin 
                oled_data[10:5] <= 6'b111111; 
                oled_data[4:0] <= 0; 
                oled_data[15:11] <= 0; 
           end 
           else begin 
                oled_data[15:0] <= 16'b0; 
           end 
       end 
       else if (led[0] || led[1]) begin //green 
           if ((y == 3 || y ==  60) && (x >= 3 && x <= 92)) begin 
              oled_data[15:0] <= 16'b0000011111100000; 
           end 
           else if ((x == 3 || x == 92) && (y >= 3 && y <= 60)) begin 
              oled_data[15:0] <= 16'b0000011111100000; 
           end 
           else if(x>=18 && x<=77 && y>=13 && y<=50)begin 
               oled_data[10:5] <= 6'b111111; 
               oled_data[4:0] <= 0; 
               oled_data[15:11] <= 0; 
           end 
           else begin 
              oled_data[15:0] <= 16'b0; 
           end   
       end       
       end

        else begin //if SW15 is off
            if (SW0 && layer == 4) begin
                if (((y >= 7 && y <= 9)||(y >= 54 && y <= 56)) && (x >= 7 && x <= 88)) begin 
                   oled_data[15:0] <= 16'b1111100000000000; 
               end 
               else if (((x >= 7 && x <= 9)||(x >= 86 && x <= 88)) && (y >= 7 && y <= 56)) begin 
                   oled_data[15:0] <= 16'b1111100000000000; 
               end 
               else if ((y == 5 || y == 58) && (x >= 5 && x <= 90)) begin 
                   oled_data[15:0] <= 16'b1111111000000000; 
               end 
               else if ((x == 5 || x == 90) && (y >= 5 && y <= 58)) begin 
                   oled_data[15:0] <= 16'b1111111000000000; 
               end 
               else if ((y == 3 || y ==  60) && (x >= 3 && x <= 92)) begin 
                   oled_data[15:0] <= 16'b0000011111100000; 
               end 
               else if ((x == 3 || x == 92) && (y >= 3 && y <= 60)) begin 
                    oled_data[15:0] <= 16'b0000011111100000; 
               end
               else oled_data[15:0] <= 0;
            end
            
            else if (SW1 && layer == 4) begin
                if(x>=18 && x<=77 && y>=27 && y<=36)begin 
                   oled_data[15:11] <= 5'b11111; 
                   oled_data[10:0] <= 0; 
               end 
               else if(x>=18 && x<=77 && y>=20 && y<=43 && (!SW2))begin  // && (!SW0)
                   oled_data[15:11] <= 5'b11111; 
                   oled_data[10:5] <= 6'b110000; 
                   oled_data[4:0] <= 0; 
               end 
               else if(x>=18 && x<=77 && y>=13 && y<=50)begin 
                   oled_data[10:5] <= 6'b111111; 
                   oled_data[4:0] <= 0; 
                   oled_data[15:11] <= 0; 
               end 
               else begin 
                   oled_data[15:0] <= 16'b0; 
               end 
           end
            
           else begin
               oled_data[15:0] <= 0; 
           end
            
        end
    end
        
    always @ (posedge clk20k) begin  
                if (SW3 && layer == 4) begin 
                    COUNT <= COUNT + 1;  
                    if (COUNT <= 40000) begin 
                        seg <= 8'b10111111;  
                    end 
                    else if (COUNT > 40000 && COUNT <= 80000) begin 
                        if (mic_in > min) begin  
                            min <= mic_in; 
                            max <= min+1; 
                        end 
                    end 
                    else if (COUNT > 80000 && COUNT <= 120000) begin 
                        seg <= 8'b10111110;  
                    end  
                    else if (COUNT > 120000 && COUNT <= 140000)begin 
                        if (mic_in > max) begin 
                            max <= mic_in; 
                        end 
                    end 
                    else begin 
                    range = (max - min)/6; 
                    COUNT <= 150000; 
                    end 
                end 
                 
                else if (SW4 && layer == 4) begin 
                    min <= 2048; 
                    max <=2049; 
                    COUNT <= 0; 
                    seg <= 8'b11111111; 
                    range <= 0; 
                end 
                 
                else if (SW15 && layer == 4) begin 
                  
                COUNT3 <= COUNT3 + 1;  
                if (mic_in > current_peak) begin  
                    current_peak <= mic_in;  
                end  
                  
                if (COUNT3 == 2000) begin  
                    if (current_peak >= min && current_peak <= min+range) begin //0, 1365/2048, 2389 
                        led[4:0] <= 5'b0;  
                        seg <= 8'b11000000; 
                    end  
                    else if (current_peak > min+range && current_peak <= min+range*2) begin //1365, 2535/2389, 2730 
                        led[4:0] <= 5'b00001;  
                        seg <= 8'b11111001;  
                    end  
                    else if (current_peak > min+range*2 && current_peak <= min+range*3) begin //2535, 2925/2730, 3072 
                        led[4:0] <= 5'b00011;  
                        seg <= 8'b10100100;  
                          
                    end  
                    else if (current_peak > min+range*3 && current_peak <= min+range*4) begin //2925, 3315/3072, 3413 
                        led[4:0] <= 5'b00111;  
                        seg <= 8'b10110000;  
                    end  
                    else if (current_peak > min+range*4 && current_peak <= min+range*5) begin //3315, 3705/3413,3754 
                        led[4:0] <= 5'b01111;  
                        seg <= 8'b10011001;  
                    end  
                    else if (current_peak > min+range*5 && current_peak <= min+range*6) begin //3705, 4095/3754, 4095 
                        led[4:0] <= 5'b11111;  
                        seg <= 8'b10010010;  
                    end  
                    COUNT3 <= 0;  
                    current_peak <= 0;  
                end  
            end 
    else begin
        led[4:0] <= 5'b0;
        seg <= 8'b11111111;
    end
    end
endmodule