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
module meminttb();
logic [1:0] memoryena;
logic block1ena;
logic block2ena;
logic block1wea;
logic block2wea;
logic seriena;
logic deseriena;

MemInterpreter memint(
.memoryena(memoryena),
.block1ena(block1ena),
.block1wea(block1wea),
.block2ena(block2ena),
.block2wea(block2wea),
.seriena(seriena),
.deseriena(deseriena)
);


initial 
begin
//reset
memoryena = 2'b00;

#100 
memoryena = 2'b01;

#100 
memoryena = 2'b10;

#100 
memoryena = 2'b11;

#100 
$finish;
end
endmodule
