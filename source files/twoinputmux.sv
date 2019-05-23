`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 04:46:18 PM
// Design Name: 
// Module Name: scaledclock
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


module twoinputmux(
input logic [15:0]mem1,
input logic [15:0]mem2,
input logic memselect,
output logic [15:0]dataout
);

always_comb
begin
    if(~memselect) //mem1
        dataout = mem1;   
    else
        dataout = mem2; //mem2
end
endmodule
