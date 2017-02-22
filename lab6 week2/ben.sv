module ben 
(
	input logic[2:0] nzp, NZP,
	output logic BEN
);

always_comb
begin
	if (nzp&NZP)
		BEN = 1'b1;
	else
		BEN = 1'b0;
end

endmodule : ben
