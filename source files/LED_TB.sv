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
module LED_tb();
logic clock = 1'b0;
logic reset;
logic switch0;
logic switch1; 
logic a0; 
logic a1; 
logic [6:0]cathode;
logic [3:0]count;

Segment_LED_Interface LEDS(
.reset(reset),
.clock(clock),
.switch0(switch0), //slect record clip, 1 or 2 J15 package pins
.switch1(switch1), //select play clip, 1 or 2  L16
.a0(a0),
.a1(a1),
.count(count),
.cathode(cathode) //7 - 0  = a-g
//.counter(counter)
);


always #5 
clock = ~clock;


initial 
begin
switch0 = 0;
switch1 = 0;
reset = 0;

#25 
reset = 1;

#25 
reset = 0;

#25 
reset = 1;

#25 
reset = 0;

#200
switch0 = 1;
switch1 = 0;

#200
switch0 = 0;
switch1 = 1;

#200
switch0 = 1;
switch1 = 1;

#100 $finish;
end
endmodule
