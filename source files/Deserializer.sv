`timescale 1ns / 1ps
//reads input from microphone, stores it into memory
//needs to read a line of 0/1 and creates a 16 bit word
//outputs done signal every 16 clock cycles
//needs to convert a 100mhz clock signal to 1mhz signal internally
module Deserializer(
input logic clock,
input logic enable,
input logic data_in,

output logic done,
output logic [15:0] data,
output logic pdm_clk_o, //microphone clock, needs to be 1 mhz, just feed it thru lol
output logic pdm_irsel_o //channel select

    );
    //done + verified
    
    logic [4:0]counter = 4'b0;
    
    logic [15:0]tempdata = 16'b0;
    
    always_comb pdm_clk_o = clock; //pass through of clock
    
    
   
     always_ff@(posedge clock)
     begin
     pdm_irsel_o <= 1'b0; //forced channel 0
     
     if(enable)
        begin
         tempdata <= tempdata<<1'b1;
         tempdata[0]<=data_in;
     
     
     

 
        end

     end
     
    
    
    
    always_ff@(posedge clock)
    begin
    
    if(~enable) 
    begin
        done <= 1'b0;
        counter<=5'd0;
    end
    
    else if(counter == 5'd15)
    begin
        counter <= 5'd0;
        data <= tempdata;
        done <= 1'b1;


    end
    else
        begin 
        counter <= counter +1;
        done<=1'b0;
        end
    end


endmodule
