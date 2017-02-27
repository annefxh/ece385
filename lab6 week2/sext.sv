module sext #(parameter width = 16)
(
	input[width-1:0] a,
	output[15:0] y
);

assign y = {{16-width{a[width-1]}}, a};

endmodule : sext