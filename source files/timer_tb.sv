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
module timer_tb();

logic clock = 1'b0;
logic enable;
logic [15:0]data_in;
logic done;
logic audio_data;
logic audio_enable;




Serializer ser(
.clock(clock),
.enable(enable),
.data_in(data_in),
.done(done),
.audio_data(audio_data),
.audio_enable(audio_enable)
);


always #10 clock = ~clock;


initial 
begin
enable = 0;
data_in = 16'b1000_0000_0000_0001;

#25 
enable = 1;

#25
enable = 0;

#25 enable = 1;

#1000000000
enable = 0;
#100 $finish;
end
endmodule
