module register #(parameter width=16)
(
    input clk,
	 input load,
	 input reset,
	 input [width-1:0] in,
	 output logic [width-1:0] out
);

logic [width-1:0] data;

initial
begin
	data = 1'b0;
end

always_ff @ (posedge clk)
begin
	if(load)
	begin
		if(reset) 
		begin
			data <= 0;
		end
		else
		begin
			data <= in;
		end
	end
end

always_comb
begin
	out = data;
end

endmodule : register