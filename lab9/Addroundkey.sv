module Addroundkey(input [127:0] in,
						 input [127:0] rkey,
						 output [127:0] out);

assign out = in ^ rkey;

endmodule