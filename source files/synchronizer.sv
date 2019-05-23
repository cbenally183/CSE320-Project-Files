`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 02:23:57 PM
// Design Name: 
// Module Name: synchronizer
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


module synchronizer(
input clock,
//buttons
input logic reset,
input logic record,
input logic play,
//switches
input logic clipselectionwr,
input logic clipselectionr,
//output logic
output logic [4:0]q
);

logic [4:0] b;

always_ff@(posedge clock)
begin
if(reset)
    b  <= 5'b10000;
else 
    b <= {reset,record,play,clipselectionwr,clipselectionr};
end

always_ff@(posedge clock)
begin
    if(reset)
        q <= 5'b10000;
    else
        q<=b;
end


endmodule
