`timescale 1ns / 1ps
//reads input from memory address via the address creator
//reads 16 bit words and transforms it into 16 1-bit cycles
//outputs done signal for 1 cycle every 16 cycles

module Serializer( //shifts new bits right to left

    input logic clock,
    input logic enable,
    input logic [15:0] data_in,
    output logic done,
    output logic audio_enable, //needed to enable audio, D12
    output logic audio_data
    
);

    logic [3:0]counter = 4'b0; //counter for counting 16 cycles
    logic [15:0]tempdata;
    logic boolean;
    
always_comb 
    audio_enable = enable;

always_ff@(posedge clock)
begin
 if(enable)
    begin
        boolean <= 1;
        if(counter == 0)
            tempdata = data_in;

    end
 else
    begin
    boolean <= 0;
    tempdata <= 16'd0;
    audio_data <= 1'b0;
    end
    if(enable&&boolean)
        begin
           audio_data <= tempdata[15];
           tempdata = tempdata << 1;
           counter <= counter + 4'b1;
           done <= 1'b0;
           
           if(counter == 4'd15)
           begin
                counter <= 4'b0;
                done <= 1'b1;
           end
        end
    else
        begin 
            done <= 4'b0;
            audio_data <= 4'b0;
            counter <= 4'd0;
        end
    end
endmodule