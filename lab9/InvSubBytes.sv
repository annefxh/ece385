module Invsubytes(input clk,
						input [127:0] in,
						output [127:0] out);

InvSubBytes inv0(.clk, .in(in[7:0]), .out(out[7:0]) );
InvSubBytes inv1(.clk, .in(in[15:8]), .out(out[15:8]) );
InvSubBytes inv2(.clk, .in(in[23:16]), .out(out[23:16]) );
InvSubBytes inv3(.clk, .in(in[31:24]), .out(out[31:24]) );
InvSubBytes inv4(.clk, .in(in[39:32]), .out(out[39:32]) );
InvSubBytes inv5(.clk, .in(in[47:40]), .out(out[47:40]) );
InvSubBytes inv6(.clk, .in(in[55:48]), .out(out[55:48]) );
InvSubBytes inv7(.clk, .in(in[63:56]), .out(out[63:56]) );
InvSubBytes inv8(.clk, .in(in[71:64]), .out(out[71:64]) );
InvSubBytes inv9(.clk, .in(in[79:72]), .out(out[79:72]) );
InvSubBytes inv10(.clk, .in(in[87:80]), .out(out[87:80]) );
InvSubBytes inv11(.clk, .in(in[95:88]), .out(out[95:88]) );
InvSubBytes inv12(.clk, .in(in[103:96]), .out(out[103:96]) );
InvSubBytes inv13(.clk, .in(in[111:104]), .out(out[111:104]) );
InvSubBytes inv14(.clk, .in(in[119:112]), .out(out[119:112]) );
InvSubBytes inv15(.clk, .in(in[127:120]), .out(out[127:120]) );

endmodule
