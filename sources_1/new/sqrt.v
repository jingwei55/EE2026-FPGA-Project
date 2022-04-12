`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2022 22:30:51
// Design Name: 
// Module Name: sqrt
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


module sqrt
    #(parameter N = 14)
    (   input Clock,  //Clock
        input [6:0] set_x1, set_y1, set_x2, set_y2,
        //input reset,  //Asynchronous active high reset.      
        //input [N-1:0] num_in,   //this is the number for which we want to find square root.
        output reg done,     //This signal goes high when output is ready
        output reg [N/2-1:0] sq_root  //square root of 'num_in'
    );
    reg [6:0] x, y;
    reg [N-1:0] num_in;
    reg [N-1:0] a;   //original input.
    reg [N/2+1:0] left,right;     //input to adder/sub.r-remainder.
    reg signed [N/2+1:0] r;
    reg [N/2-1:0] q;    //result.
    integer i;   //index of the loop. 

    always @(posedge Clock) 
    begin
        if (!(set_x1 && set_y1 && set_x2 && set_y2)) begin   //reset the variables.
            done <= 0;
            sq_root <= 0;
            i = 0;
            a = 0;
            left = 0;
            right = 0;
            r = 0;
            q = 0;
        end    
        else begin
            //Before we start the first clock cycle get the 'input' to the variable 'a'.
            x = (set_x1 > set_x2) ? set_x1 - set_x2 : set_x2 - set_x1;
            y = (set_y1 > set_y2) ? set_y1 - set_y2 : set_y2 - set_y1;
            num_in = x*x + y*y;
            
            if(i == 0) begin  
                a = num_in;
                done <= 0;    //reset 'done' signal.
                i = i+1;   //increment the loop index.
            end
            else if(i < N/2) begin //keep incrementing the loop index.
                i = i+1;  
            end
            //These statements below are derived from the block diagram.
            right = {q,r[N/2+1],1'b1};
            left = {r[N/2-1:0], a[N-1:N-2]};
            a = {a[N-3:0], 2'b0};  //shifting left by 2 bit.
            if ( r[N/2+1] == 1)    //add or subtract as per this bit.
                r = left + right;
            else
                r = left - right;
            q = {q[N/2-2:0], ~r[N/2+1]};
            if(i == N/2) begin    //This means the max value of loop index has reached. 
                done <= 1;    //make 'done' high because output is ready.
                i = 0; //reset loop index for beginning the next cycle.
                sq_root <= q;   //assign 'q' to the output port.
                //reset other signals for using in the next cycle.
                left = 0;
                right = 0;
                r = 0;
                q = 0;
            end
        end    
    end

endmodule