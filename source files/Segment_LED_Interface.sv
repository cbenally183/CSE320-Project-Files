`timescale 1ns / 1ps
//read from buttons/switch and display to led output, no need to connect to controller

// should be done plz error check
module Segment_LED_Interface(
input logic switch0, //which memory block to write to, 1 or 2 J15 package pins
input logic switch1, //which block to read from, 1 or 2  L16
input logic clock,
input logic reset,
output logic a0,//right led
output logic a1,//left led
output logic [6:0]cathode //7 - 0  = a-g
    );
logic [3:0]count;

always_comb
begin
if(a0 && switch0)
    cathode[6:0] = 7'b001_001_0; //2 //if switch0 = 1, display 2
else if(a0 && ~switch0)
    cathode[6:0] = 7'b100_111_1; //1 //if switch0 = 0, display 1
    
else if(a1 && switch1)
    cathode[6:0] = 7'b001_001_0; //2 //if switch1 = 1, display 2 
else if(a1 && ~switch1)
    cathode[6:0] = 7'b100_111_1; //1 //if switch1 = 0, display 1 
else cathode[6:0] = cathode[6:0];
end




always_ff@(posedge clock)
begin
if(reset || count == 4'd8) 
    count <= 4'd0;
else
    count<= count + 1'b1;
end


always_ff@(posedge clock) 
begin
    if(reset)
    begin
    a0<=0;
    a1<=1;
    end
    else if( count == 4'd8) 
    begin
    a0 <= ~a0;
    a1 <= ~a1;
    end
end


//always_ff@(posedge clock) //alernating
//begin
//    if(reset)//set values
//    begin
//        count <= 4'd0;
//        a0 <= 1;
//        a1 <= 0;
//        cathode <= 7'd0; 
//    end
    
//    else
//    begin
//        if(count == 4'd8)
//        begin
//            //swap lights reset counter
//            count <= 4'd0;
//            a0 <= ~a0;
//            a1 <= ~a1;
//        end
//        else
//            count <= count + 4'd1;
//    end
//end


endmodule
