module zext 
(
	input[15:0] in,
	output[19:0] out
);

assign out = {4'b0000,in};

endmodule : zext