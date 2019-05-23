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


module scaledclock(
input logic clock,
input logic reset,
input logic enable,
output logic scaledclk 
);

logic [6:0]counter = 7'd0;

always_ff@(posedge clock)
begin 
if((counter == 7'd99)|| reset)
    counter <= 7'd0;
else if(enable == 1)
           counter <= counter + 1'b1;
end

always_ff@(posedge clock)
    if(reset)
        begin
        //toggle clock and reset counter
          scaledclk <= 1'b0;
        end
    else if(counter == 7'd99)
        scaledclk <=!scaledclk;
    
endmodule
