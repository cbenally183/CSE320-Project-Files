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
module synchtb ();
logic clock = 1'b0;
logic reset;
logic record;
logic play;
logic switch0;
logic switch1;
logic [4:0] qout; //{reset,record,play,clipselectionwrite,clipselectionread}

synchronizer synchronizer( //not verified working but cmon its 2 buffer ff
.clock(clock),
.reset(reset), //button
.record(record), //button
.play(play), //button
.clipselectionwr(switch0), //switch0, rightmost switch
.clipselectionr(switch1), //switch1, second to rightmost switch
.q(qout) //5 bit output, concatination of above inputs after 2 ff
);

always 
#5 clock = ~clock;
initial 
begin
 //{reset,record,play,clipselectionwrite,clipselectionread}
reset = 1;
record = 0;
play = 0;
switch0 = 0;
switch1 = 0;

#50
reset = 0;

#50 
reset = 1;

#50
reset = 0;

#50 
record = 1;
switch0 = 0;
switch1 = 0;
#20
record = 0;


#100
record = 1;
switch0 = 1;
switch1 = 0;
#20
record = 0;
#100
record = 1;
switch0 = 0;
switch1 = 1;
#20
record = 0;
#100
record = 1;
switch0 = 1;
switch1 = 1;
#20
record = 0;
#50
record = 0; 
#100
play = 1;
switch0 = 0;
switch1 = 0;
#50
play = 0;

#100 
play = 1;
switch0 = 1;
switch1 = 0;
#50
play = 0;
#100 
play = 1;
switch0 = 0;
switch1 = 1;
#50
play = 0;
#100 
play = 1;
switch0 = 1;
switch1 = 1;
#50
play = 0;
#1000
$finish;
end
endmodule
