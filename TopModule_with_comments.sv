`timescale 1ns / 1ps

//just holds container, 
module TopModule(
input logic switch0,
input logic switch1, 
input logic reset,
input logic play,
input logic record,
input logic clock,

input logic microphone,

output logic audio_out,
output logic a0,
output logic a1,
output logic [6:0]cathode,
output logic audio_enable,
output logic pdm_clk_o,
output logic channelselect


////debugging
//output logic [15:0]memoryin,
//output logic [15:0]data,
//output logic [15:0]memaddr,
//output logic block1ena,
//output logic block1wea,
//output logic block2ena,
//output logic block2wea,

//output logic timerdone,
//output logic timer,
//output logic donedes,
//output logic doneser,
//output logic done,
//output logic scaledclk
);

//wires and such
logic [4:0]qout; //wire between syncronizer and control, used for 5 bit memory selection, read, write enables
logic [1:0]memoryselect_clip_1; //wire between controller and memory interpreter, used to send instructions to memory block enables for read/write
logic [15:0]memin; //wire between 2 16 bit mux input to serializer, passes wanted memory to serializer to convert into a bit stream
logic [15:0]data; //wire between deserializer and memory blocks, used to pass 16 bit words to store into the block memories
logic scaledclk; //wire between scaled clock to both serializers and address creator, used to convert 100 mhz clock to 1 mhz
logic timerdone; //wire between timer and controller, used to signal when 2 seconds have passed
logic timer; //wire between timer and controller, used to signal the timer to start counting, and cound while timer is on 
logic donedes; //wire that feeds into an or gate to output a done signal when either the deserializer or serializer are done with their workload 
logic doneser; //^
logic done;// wire between the serializers and address creator and block memory, used as a clock for memories to store the newly created word/fetch word

//logic[15:0] memoryin;//debugging

logic [15:0]memaddr;//wire between address creators and memory blocks, sends new address to address in ports of memories 
logic [15:0]mem1out; //data output of mem1, goes to mux 
logic [15:0]mem2out; //data output of mem2, goes to mux

logic block1ena; //wire between meminterpreter, enables reading of block 1
logic block1wea; //enables writing to block 1 
logic block2ena; //enables reading from block 2
logic block2wea; //enables writing to block 2 
logic deseriena; //enables deserializer
logic seriena; //enables serializer
logic aen; //wire or gate for address creator enable. takes either block1ena or block2ena as inputs, so whenever we need to do anything to either memory, address creator is enabled

//debugging
//always_comb
//begin
//    memoryin = memin;
//end

//or for done signal to address
always_comb
begin
    done = doneser||donedes;
    aen = block1ena || block2ena;    
end


synchronizer synchronizer( //should be verified just verify outputs are correct
.clock(clock),
.reset(reset), //button
.record(record), //button
.play(play), //button
.clipselectionwr(switch0), //switch0, rightmost switch
.clipselectionr(switch1), //switch1, second to rightmost switch
.q(qout) //5 bit output, concatination of above inputs after 2 ff
);

Controller controller( //verified working
.q(qout), //{reset,record,play,clipselectionwrite,clipselectionread}
.clock(clock),
.seconds2(timerdone), //input from timer to let controller know 2 seconds have passed
.memoryselect_clip_1(memoryselect_clip_1), //2nd bit = which block, 1st bit = read or write, write = 1, read = 0
.timer(timer), //output to run 2 second timer while on
.deseriena(deseriena),
.seriena(seriena)
);
    
Segment_LED_Interface LEDS( //led interface, 
.switch0(switch0), //slect record clip, 1 or 2 J15 package pins
.switch1(switch1), //select play clip, 1 or 2  L16
.a0(a0), //rightmost led segment
.a1(a1), //second to rightmost led 
.reset(reset),
.clock(clock),
.cathode(cathode) //7 - 0  = a-g
);

timer time2( //outputs 1 when 2 seconds have passed, verified working
.enable(timer), 
.clock(clock),
.done_signal(timerdone) //output of timer when 2 seconds have passed, passed to controller to cut off enable
);

scaledclock sclk( //converts 100 mhz clock to 1 mhz, feeds serializer, deserializer, and mic in , verified working
.clock(clock), //100 mhz clock
.enable(timer), //while timing
.scaledclk(scaledclk) //1 mhz clock output
);

Deserializer Dserial( //verified working
.clock(scaledclk), //scaled clock input
.enable(deseriena), //only deserialize when timing
.data_in(microphone), //mic in
.done(donedes), //into or gate output done to prevent contention, feeds into address creator
.data(data), //15:0 word that gets outputted
.pdm_clk_o(pdm_clk_o), //clock that is passed through from the input to feed microphone
.pdm_irsel_o(channelselect) //forced channel, mono audio lol
);

Serializer serial( //verified working
.clock(scaledclk), //scaled clk input
.enable(seriena), //only serialise when timing
.data_in(memin), //15:0 word in 
.done(doneser), //into or gate output done to prevent contention, feeds into address creator
.audio_enable(audio_enable), //pass thru of enable
.audio_data(audio_out) //bit stream out 
);    

Address_creator DS( //address creator feeds both address ins of both memories, verified working
.clock(scaledclk), //scaled clock input to prevent multiple increases when increasing address
.done(done), //input, address only increases if this is recieved
.reset(reset),
.address(memaddr), //output 15:0 address
.regclock(clock),
.enable(aen)
);


MemInterpreter MemInterpreter( //interprets the 2 bit memory input into usable enables for the memory blocks, verified working
.memoryena(memoryselect_clip_1), //2 bit input to decode
.block1ena(block1ena), //read/write enables decoded from instructions
.block1wea(block1wea),
.block2ena(block2ena),
.block2wea(block2wea)

);

blk_mem_gen_0 MEM1(
  .clka(done),    // clock input, toggles when done signal recieved
  .ena(block1ena),      // input wire ena, needs to be on when reading OR writing
  .wea(block1wea),      // input wire [0 : 0] wea, needs to be on when writing
  .addra(memaddr),  // input wire [15 : 0] addra
  .dina(data),    // input wire [15 : 0] dina, Data in
  .douta(mem1out)  // output wire [15 : 0] douta, Data out
);

blk_mem_gen_0 MEME2(
  .clka(done),    // clock input, toggles when done signal recieved
  .ena(block2ena),      // input wire ena
  .wea(block2wea),      // input wire [0 : 0] wea
  .addra(memaddr),  // input wire [15 : 0] addra
  .dina(data),    // input wire [15 : 0] dina
  .douta(mem2out)  // output wire [15 : 0] douta
);

twoinputmux MUX( // verified working 
.mem1(mem1out), //mem 1 read feed
.mem2(mem2out), //mem 2 read feed
.memselect(block2ena), //if ~ena, then read from mem 1, else read from mem 2
.dataout(memin)
);

endmodule