module testbench();

timeunit 10ns;
timeprecision 1ns;

logic [15:0] S;
logic	Clk, Reset, Run, Continue;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic CE, UB, LB, OE, WE;
logic [19:0] ADDR;
wire [15:0] Data;

slc3 slc3(.*);


always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

initial begin: TEST_VECTORS
Reset = 0;
Run = 1;
Continue = 1;
S = 16'h0000;

#2 Reset = 1;

#2 Run = 0;
#2 Run = 1;
#6 Continue = 0;
#6 Continue = 1;

#6 Continue = 0;
#6 Continue = 1;

#80 Continue = 0;
#80 Continue = 1;

#80 Continue = 0;
#80 Continue = 1;



end
endmodule