module regfile
(
	input logic clk,
	input logic LD_REG,
	input logic[2:0] drmuxout, sr1muxout, sr2,
	input logic[15:0] busout,
	output logic[15:0] sr1out, sr2out
);

logic[15:0] data [7:0];

initial
begin
	for(int i=0; i< $size(data); i++)
	begin
		data[i] = 16'b0;
	end
end

always_ff @(posedge clk)
begin
	if(LD_REG)
	begin
		data[drmuxout] <= busout;
	end
end

always_comb
begin
	sr1out = data[sr1muxout];
	sr2out = data[sr2];
end

endmodule : regfile

