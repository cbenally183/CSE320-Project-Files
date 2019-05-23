`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 03:37:08 PM
// Design Name: 
// Module Name: timer_tb
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
module controller_tb();
logic clock = 1'b0;
logic [4:0]q; //{reset,record,play,clipselectionwrite,clipselectionread}
logic [1:0]memoryselect_clip_1; //2nd bit = which block, 1st bit = read or write, write = 1, read = 0
logic seconds2; //input from timer to let controller know 2 seconds have passed
logic timer;


Controller control(
.q(q), //{reset,record,play,clipselectionwrite,clipselectionread}
.clock(clock),
.seconds2(seconds2), //input from timer to let controller know 2 seconds have passed
.memoryselect_clip_1(memoryselect_clip_1), //2nd bit = which block, 1st bit = read or write, write = 1, read = 0
.timer(timer)
);


always #5 
clock = ~clock;
//{reset,record,play,clipselectionwrite,clipselectionread}
initial 
begin
//reset
q = 5'b10000;
seconds2 = 0;

//write to memory 1
#20
q = 5'b01000;

#50
seconds2 = 1;

#20 
seconds2 = 0;
//write to memory 2
#20
q = 5'b01010;

#50
seconds2 = 1;

#20 
seconds2 = 0;
// read from block 1
#20
q = 5'b00100;

#50
seconds2 = 1;

#20 
seconds2 = 0;

//read from block 2
#20
q = 5'b00101;

#50
seconds2 = 1;

#20 
seconds2 = 0;



#1000000000
#100 $finish;
end
endmodule
