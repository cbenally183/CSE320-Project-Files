`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2017 07:09:07 PM
// Design Name: 
// Module Name: topmod_tb
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


module topmod_tb();
logic clock = 1'b0;
logic switch0;
logic switch1;
logic reset;
logic play;
logic record;
logic microphone;
logic audio_out;
logic a0;
logic a1;
logic [6:0]cathode;

logic [15:0]memoryin;
logic [15:0]data;
logic [15:0]memaddr;
logic block1ena;
logic block1wea;
logic block2ena;
logic block2wea;
logic timerdone;
logic timer;
logic donedes;
logic doneser;
logic done;
logic scaledclk;

TopModule TopMod(
.switch0(switch0),
.switch1(switch1),
.reset(reset),
.play(play),
.record(record),
.clock(clock),
//debugging
.memoryin(memoryin),
.data(data),
.memaddr(memaddr),
.block1ena(block1ena),
.block1wea(block1wea),
.block2ena(block2ena),
.block2wea(block2wea),
.timerdone(timerdone),
.timer(timer),
.donedes(donedes),
.doneser(doneser),
.done(done),
.scaledclk(scaledclk),

.microphone(microphone),
.audio_out(audio_out),
.a0(a0),
.a1(a1),
.cathode(cathode)
);

always
begin 
#5 clock = ~clock;
end

always
begin
# 1microphone = 0;
#3 microphone = 1;
#2 microphone = 0;
#6 microphone = 1;
#6 microphone = 0;
end

initial 
begin
switch0 = 0;
switch1 = 0;
reset = 0;
play = 0;
record = 0;

#5
reset =1;
#30 
reset = 0;
switch0 = 0;




#25
record = 1;

#1000
record = 0;

#2000500000
play = 1;

#5000
play  = 0;

#100000000000000
switch0 = 0;

#100000000000000
reset = 0;
#100 $finish;
end

endmodule
