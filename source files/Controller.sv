//main driver, controlls everything
//use created memory, datainA will be writing in, datainB will be reading out

//done plz error check
module Controller(
input logic [4:0]q, //{reset,record,play,clipselectionwrite,clipselectionread}
input clock,

input logic seconds2, //input from timer to let controller know 2 seconds have passed

output logic [1:0]memoryselect_clip_1, //2nd bit = which block, 0 = block 1, 1 = block 2, 1st bit = read or write, write = 1, read = 0

output logic timer,
output logic seriena,
output logic creset,
output logic deseriena
);
parameter s0 = 5'b00001; //idle state
parameter s1 = 5'b00010; //writing to mem 1 
parameter s2 = 5'b00100; //writing to mem 2
parameter s3 = 5'b01000; //playing mem 1 
parameter s4 = 5'b10000; //playing mem 2 

logic [4:0]state, nextstate;

always_ff @(posedge clock) //state transisiton
begin
    if(q[4]) 
        state <= s0;
    else 
        state <= nextstate;
end

always_comb

begin //next state logic
case(state)//{reset,record,play,clipselectionwrite,clipselectionread}
s0:
    begin
    if(q[3] ==1 && q[1] == 0) nextstate = s1; //write block 1 
    else if(q[3]==1 && q[1] ==1) nextstate = s2; //write block 2
    else if(q[2] ==1 && q[0] ==0) nextstate = s3; //read block 1
    else if(q[2] ==1 && q[0] ==1) nextstate = s4; //read block 2
    else nextstate=state;
    end
    
s1:
    begin
    if(seconds2) nextstate = s0;
    else nextstate = state;
    end
    
s2:
    begin
    if(seconds2) nextstate = s0;
    else nextstate = state;
    end
    s3:
    begin
    if(seconds2) nextstate = s0;
    else nextstate = state;
    end
s4:
    begin
    if(seconds2) nextstate = s0;
    else nextstate = state;
    end


default: nextstate = state;

endcase
end







always_comb //output logic 
begin
case(state)
s0:
begin
    timer = 1'b0;
    memoryselect_clip_1[1:0] = 2'b00;
    seriena=1'b0;
    deseriena=1'b0;
    creset = 1'b1;
end

s1:
begin
    timer = 1'b1;
    memoryselect_clip_1[1:0] = 2'b01;
    seriena=1'b0;
    deseriena=1'b1;
    creset = 1'b0;
end
s2:
begin
    timer = 1'b1;
    memoryselect_clip_1[1:0] = 2'b11;
    seriena=1'b0;
    deseriena=1'b1;
    creset = 1'b0;
end
s3: 
begin
    timer = 1'b1;
    memoryselect_clip_1[1:0] = 2'b00;
    seriena=1'b1;
    deseriena=1'b0;
    creset = 1'b0;
end
s4: 
begin
    timer = 1'b1;
    memoryselect_clip_1[1:0] = 2'b10;
    seriena = 1'b1;
    deseriena=1'b0;
    creset = 1'b0;
end
default:
begin
    timer = 1'b0;
    memoryselect_clip_1[1:0] = 2'b00;
    seriena=1'b0;
    deseriena=1'b0;
    creset = 1'b1;
end
endcase
end
endmodule