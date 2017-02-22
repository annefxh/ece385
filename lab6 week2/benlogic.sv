module ben_logic(input logic [15:0] bus_out,
				 output logic [2:0] nzp);

always_comb
	begin
		if(bus_out[16])
			begin
				nzp = 3'b100;
			end
		else	
			begin
				if(bus_out = 16'h0000)
					begin
						nzp = 3'b010;
					end
				else
					begin
						nzp = 3'b001;
					end
			end
	end
endmodule