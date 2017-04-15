module testbench();

timeunit 10ns;
timeprecision 1ns;

logic clk, reset_n,run;
logic[127:0]  msg_en, key;
logic [127:0]  msg_de;
logic io_ready, aes_ready;

aes_controller aes_controller(.*);

always begin : CLOCK_GENERATION
#1 clk = ~clk;
end

initial begin: CLOCK_INITIALIZATION
    clk = 0;
end 

initial begin: TEST_VECTORS
	reset_n =0;
	io_ready = 0;
	msg_en = 128'hdaec3055df058e1c39e814ea76f6747e;
	key = 128'h000102030405060708090a0b0c0d0e0f;
	
	#3 reset_n = 0;
	#3 reset_n = 1;
	#20 io_ready = 1;
	#10 io_ready = 0;
end
endmodule