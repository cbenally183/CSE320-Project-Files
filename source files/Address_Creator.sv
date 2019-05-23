//intended for use in both deserializer/serializer to create address locations to read/write to memory

//maybe it might be easier to implement this inside both serializer/deserializer, since this would run at 100 mhz, while both serializers run at 1mhz

module Address_creator(
input logic clock,
input logic done,
input logic reset,
input logic enable,
input logic regclock,
output logic [15:0]address


);

always_ff@(posedge clock, posedge reset)
begin 
if(reset || address == 16'd62499)
    address <= 16'd0;

else if(done&&enable) 
    address <= address +1'b1;
  
end

//always_ff@(posedge regclock)
//begin
//    if(reset)
//        address <= 16'd0;
//    else 
//        address<=address;
//end
endmodule