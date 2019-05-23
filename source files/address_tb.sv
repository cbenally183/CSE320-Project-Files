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
module addresstb();
logic clock = 1'b0;
logic done;
logic reset;
logic enable;
logic [15:0]address;

Address_creator addre(
.clock(clock),
.done(done),
.enable(enable),
.reset(reset),
.address(address)
);


always
    #300 done = ~done;
always 
    #5 clock = ~clock;
    
initial 
begin
done = 0;
reset = 1;
enable = 0;

#50
reset = 0;
#500 enable = 1;
#500 enable = 0;
#10000000000
done = 0; 
#100
$finish;
end
endmodule
