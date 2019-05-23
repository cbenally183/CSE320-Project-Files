//timer used to measure out a period of 2 seconds, system will run at 100mhz, so 200 000 000 clock cycles

//done + verified
module timer(
input logic enable,
input reset,
input logic clock,
output logic done_signal //output of timer when 2 seconds have passed, passed to controller to cut off enable
);

logic [27:0]counter = 28'b0;


always_ff@(posedge clock)
begin 
if((counter == 28'd199_999_999)||(reset))
    begin
     counter <= 28'd000_000_000;

    end
else if(enable)
    begin
           counter <= counter + 28'd1;
      //     done_signal <= 0;
    end
end

always_ff@(posedge clock)
begin
if(reset)
    done_signal <= 0;
else if(counter == 28'd199_999_999)
    done_signal <=1;
    
end

endmodule